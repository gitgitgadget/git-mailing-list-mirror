From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT PATCH 2/4] Abstract a PatchSet object out of Series.
Date: Wed, 13 Jun 2007 22:38:21 +0200
Message-ID: <20070613203821.GQ6992@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070611003117.4736.33551.stgit@gandelf.nowhere.earth> <20070611003330.4736.69293.stgit@gandelf.nowhere.earth> <b0943d9e0706121509j5088e164iadedb561501d6a55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 22:38:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyZbg-0006XB-Lf
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 22:38:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754779AbXFMUiR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 16:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754665AbXFMUiR
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 16:38:17 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:44946 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754186AbXFMUiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 16:38:16 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id A58D45A15C;
	Wed, 13 Jun 2007 22:38:14 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 0F15B1F157; Wed, 13 Jun 2007 22:38:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <b0943d9e0706121509j5088e164iadedb561501d6a55@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50128>

On Tue, Jun 12, 2007 at 11:09:50PM +0100, Catalin Marinas wrote:
> On 11/06/07, Yann Dirson <ydirson@altern.org> wrote:
> >The goal is to move into PatchSet all functionnality that is not
> >dependant of Series being a real stack, paving the way for handling
> >parallel (hydra) stacks, or any other way to organize patches.
> 
> Thanks for the patches. I applied this one as well and I like the
> idea. What is your long-term plan with this split?

I have started to work on a Hydra class (available at [1], but be
aware it doesn't do much more than creating an octopus, and breaking
many current StGIT assumptions), with a testcase to demonstrate its
use), which binds together a set of stacks with an octopus, to allow
keeping related patches together, and allow people to pull from one
topic stack without getting unrelated work.

I'm however facing a problem, with the pervasive assumption that we
only have stacks :).  Basically, we probably need a factory of
PatchSet objects, which would return a Series or an Hydra according to
the specified name - I'm currently thinking about this, but don't
expect any working code too rapidly.


> The HEAD in my repository fails the test suite. Do you have any
> additional patches pending (some patches were not applied in order as
> I had to manually fix the conflicts). Anyway, please check my
> repository for any missing patches.

Oh, I had not noticed you had applied
bd69feaf7c3c94b6e7e216ea8091064af9cdfa97.  Sorry, I was not explicit
enough when posing this, only the cover mail included "RFC" in the
subject.  As described in that mail, there are problems both with the
original approach (Karl's test failing), and with that new one (that
exisiting test failing).

Do you have any idea on how we could overcome the problem ?  In the
meantime, we could possibly just comment that testcase out (or add
support for continuing the testsuite even with a failure) - the
problem it exhibits is probably less common than the one that was
fixed.

BTW, a02ba4077f12578fe31c99d903488804a656e1c4 has a slight problem: it
is a patch by Karl, which I re-sent in the same group since it was
exhibiting the problem (and with the intent of adding a signed-off-by
line, but my way of adding them trough a buggy template showed its
limits and the commit now have 2 signed-off-by lines with Karl's
name).  However, it was applied with myself as author, which is quite
wrong: could that be a but in "stg import" ignoring the Author field ?

Best regards,
-- 
Yann.

[1] http://repo.or.cz/w/stgit/ydirson.git
