From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: Why do git submodules require manual checkouts and commits?
Date: Fri, 16 May 2008 10:12:16 -0400
Message-ID: <32541b130805160712m24f24c6aw59b54a0f0ace6269@mail.gmail.com>
References: <2729632a0805152116o3c998324xb401674207dd2e1e@mail.gmail.com>
	 <32541b130805160643y3bfe609et22b2d00627f98c04@mail.gmail.com>
	 <alpine.DEB.1.00.0805161457250.30431@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "skillzero@gmail.com" <skillzero@gmail.com>, git@vger.kernel.org
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri May 16 16:13:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jx0gJ-0003MU-KA
	for gcvg-git-2@gmane.org; Fri, 16 May 2008 16:13:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752213AbYEPOMU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2008 10:12:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752092AbYEPOMU
	(ORCPT <rfc822;git-outgoing>); Fri, 16 May 2008 10:12:20 -0400
Received: from fg-out-1718.google.com ([72.14.220.156]:17355 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751263AbYEPOMS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 May 2008 10:12:18 -0400
Received: by fg-out-1718.google.com with SMTP id 19so717319fgg.17
        for <git@vger.kernel.org>; Fri, 16 May 2008 07:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=csDyfvwetjkDfgxjO4R99HdSMudczE374X8ow/Ux6F8=;
        b=qKfN9yhlwi76JWubjViN+nBQ7oYHmuw0U36GqybUD5y9t8XYCdvzowkSVGwbd6bVGQ6i7awEGElBdjf9FOt2KPpT4aZIH8NpMkT82NYFdCo17eyylrtWbdedXi8XLY9+bnvaA9nGCsPdEB6f8SiZXngVLZ1piLOED/xHCOVpPns=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qiTkk6G9XJhmFbDcP7Gqhru+QDkpP3wV/etxBDfjgnwDc24mhc/bYCb1qVjNUu69B5Owk2HBKz1iQzGiHS+F2WNapmuxt+01Bab90QOha+ruGpHIPv5tKLww95hzu/uS6D8ajLSjW+Uo4vU/QSd3mdYWAtCfh/0YrbucE/V5i78=
Received: by 10.82.126.5 with SMTP id y5mr490448buc.89.1210947136851;
        Fri, 16 May 2008 07:12:16 -0700 (PDT)
Received: by 10.82.100.5 with HTTP; Fri, 16 May 2008 07:12:16 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0805161457250.30431@racer>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82292>

On 5/16/08, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>  On Fri, 16 May 2008, Avery Pennarun wrote:
>  > So I think it would be very bad if the supermodule automatically
>  > updated to the latest version of the submodule whenever you commit in
>  > the submodule.  *However*, the other way around might be fine: if you
>  > commit in the supermodule, maybe it should commit in the submodule at
>  > the same time and link to that specific commit.  I'm pretty sure that
>  > idea doesn't have any *fundamental* flaws, it's just got a lot of
>  > really tricky details that need to be worked out.
>
> Just the fundamental flaw that you might _not_ want to commit that, just
>  as you can have a dirty Makefile _forever_.

I consider that one of the annoying details rather than a fundamental
flaw.  I agree that it's hard to solve though.

Think of it this way: I can commit, or not commit, my dirty Makefile
at the same time as everything else (in a single project) with a
single "git commit" line, depending on what I want to do.  Things like
"git commit -a" and "git add -u" speed up the common case where I just
want to commit everything.  But with submodules, that common case
looks more like this:

   cd sub
   git checkout -b manual_branchname_because_there_was_no_default
   git commit -a
   git push etc.
   cd ..
   git commit -a
   git push etc.

That's *really* tedious, and the number of commands multiplies when
you have more than one submodule going at once.

I think git's submodules are awesome because they *don't* have
fundamental flaws.  They just need an (optional) more automated
workflow for the common case.  And I'll be sure to propose one when I
figure out what my common case actually is :)

Have fun,

Avery
