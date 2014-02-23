From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: [PATCH] clone: allow initial sparse checkouts
Date: Sun, 23 Feb 2014 20:58:07 +0000
Message-ID: <robbat2-20140223T204934-225383635Z@orbis-terrarum.net>
References: <1393122713-4308-1-git-send-email-robbat2@gentoo.org>
 <CACsJy8BKJ4HzXLcajC8cXviD4hboRPOYhWSen7H5Ta=_JuXNjw@mail.gmail.com>
 <robbat2-20140223T072340-334493350Z@orbis-terrarum.net>
 <CACsJy8ApmVPAnhQmVAsFyXtV49S+9VULsEYZ7W3x7HMMoVtDzA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 23 21:58:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHg7r-0002Rh-LB
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 21:58:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751948AbaBWU6L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 15:58:11 -0500
Received: from smtp.gentoo.org ([140.211.166.183]:46634 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751796AbaBWU6K (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 15:58:10 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 7451933F91F
	for <git@vger.kernel.org>; Sun, 23 Feb 2014 20:58:09 +0000 (UTC)
Received: (qmail 17243 invoked by uid 10000); 23 Feb 2014 20:58:07 -0000
Content-Disposition: inline
In-Reply-To: <CACsJy8ApmVPAnhQmVAsFyXtV49S+9VULsEYZ7W3x7HMMoVtDzA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242551>

On Sun, Feb 23, 2014 at 03:43:47PM +0700,  Duy Nguyen wrote:
> On Sun, Feb 23, 2014 at 2:32 PM, Robin H. Johnson <robbat2@gentoo.org> wrote:
> >> > This patch implements easily accessible sparse checkouts during clone,
> >> > in the --sparse-checkout option.
> >> >
> >> > $ git clone REPO --sparse-checkout PATH
> >> Or take a file as input if there are lots of paths/rules.
> > How much demand for taking a file of rules,
> I don't know. I guess it depends on each repo's layout. If the layout
> is simple, usually you would need one or two rules so it's ok to type
> again and again. If it's more complicated and starts using '!' rules,
> it's probably best to save in a file.
> 
> > and opinions of syntax to do
> > that vs specify on the commandline?
> >
> > --sparse-checkout-from FILE
> 
> I think this one is better. But if you don't see a need for it, we can
> always delay implementing it until an actual use case comes up.
I think I'd prefer to delay that part then.
What I'm concerned about if we do have it, is what ordering semantics
there should be, eg for something like:
--sparse-checkout '!X' --sparse-checkout-from F --sparse-checkout Y

Should that be [!X, *F, Y], or [*F, !X, Y], or something else?
Would the option parser need to be modified to handle this?
Or do we just make them mutually exclusive?

The only other clean alternative would be implementing ONLY
--sparse-checkout-from, and letting uses use fds creatively:
--sparse-checkout-from <(echo X; echo Y)
But the msysgit crowd would probably mumble complaints under their
breath at me.

-- 
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
