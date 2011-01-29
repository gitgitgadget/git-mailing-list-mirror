From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Updating a submodule with a compatible version from
	another submodule version using the parent meta-repository
Date: Sat, 29 Jan 2011 12:08:08 +0100
Message-ID: <20110129110807.GA21864@book.hvoigt.net>
References: <AANLkTinN1XVsAZXGLqkuhysrJ8-TCtGm4pOu2RfCEVVp@mail.gmail.com> <AANLkTimvNaiieEw8-Y52xxDW6DQ6b16v9azCk+BDPxhe@mail.gmail.com> <4D407099.4010805@web.de> <AANLkTinMhvBNrBMJ8vQpJdYxP_NgJU2L7JEW0KhXGjhf@mail.gmail.com> <4D407875.7080607@web.de> <AANLkTik-XdgGM20kFu8KZ5k9ynfNAo8fvL9t7kL_JhQg@mail.gmail.com> <7v7hdrl7nw.fsf@alter.siamese.dyndns.org> <AANLkTik8VrhbBSLwRq9gd39hofnmifk15zSqXVTsSzAp@mail.gmail.com> <7v1v3zjp6w.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Ibarz <julian.ibarz@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 29 12:15:12 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pj8lr-00035d-RC
	for gcvg-git-2@lo.gmane.org; Sat, 29 Jan 2011 12:15:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540Ab1A2LOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jan 2011 06:14:51 -0500
Received: from darksea.de ([83.133.111.250]:36142 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750784Ab1A2LOu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jan 2011 06:14:50 -0500
X-Greylist: delayed 400 seconds by postgrey-1.27 at vger.kernel.org; Sat, 29 Jan 2011 06:14:50 EST
Received: (qmail 14589 invoked from network); 29 Jan 2011 12:08:08 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 29 Jan 2011 12:08:08 +0100
Content-Disposition: inline
In-Reply-To: <7v1v3zjp6w.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165656>

Hi,

On Wed, Jan 26, 2011 at 02:05:43PM -0800, Junio C Hamano wrote:
> If that version of submodule B is explicitly bound to a commit in the
> superproject A, you know which version of A and C were recorded, and the
> problem is solved.
> 
[...]
> 
> If you are confident that you didn't introduce different kind of
> dependency to other submodules while developing your "old_feature" branch
> in submodule B, one strategy may be to find an ancestor, preferrably the
> fork point, of your "old_feature" branch that is bound to the superproject
> A.  Then at that point at least you know whoever made that commit in A
> tested the combination of what was recorded in that commit, together with
> the version of B and C, and you can go forward from there, replaying the
> changes you made to the "old_feature" branch in submodule B.

Lets extend your explanation a little further and maybe demonstrate the problem
Julian is having a little more. I think what Julian searches for is a tool in
git that does the lookup for you which is AFAIK not that easy currently. It
seems to be a quite useful feature. Here what I understand Julian wants:

1. Find the most recent superproject commit X'' in A that records a submodule
   commit X' in B which contains the commit X in B you are searching for.

   For this we would need use something similar to git describe --contains
   but instead of using the list of existing tags in B it should use the list
   of commits in B which are recorded in A.

   Here a drawing to explain (linear history for simplicity):

   superproject A:

      O---O---X''---O
               \
   submodule B: \
                 \
      O---X---O---X'---O---O

2. Look up the commit of C which is recorded in X'' of A and check it
   out.

Step 2 is easy but for Step 1 the lookup of X' is missing for the commandline.
Is there already anything that implements git describe --contains for a defined
list of commits instead of refs?

Cheers Heiko
