From: "Catalin Marinas" <catalin.marinas@gmail.com>
Subject: Re: stgit 0.13 + git 1.5.3.5 bogus "empty patch" status, and other problems
Date: Thu, 15 Nov 2007 16:37:36 +0000
Message-ID: <b0943d9e0711150837w2812dd8x8990eb6e17a5344d@mail.gmail.com>
References: <200711120039.lAC0dgex015049@freya.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Adam J. Richter" <adam@yggdrasil.com>
X-From: git-owner@vger.kernel.org Thu Nov 15 17:38:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ishj5-0001vE-1k
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 17:37:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758170AbXKOQhl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 11:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757953AbXKOQhk
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 11:37:40 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:58321 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757917AbXKOQhj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 11:37:39 -0500
Received: by nz-out-0506.google.com with SMTP id s18so559016nze
        for <git@vger.kernel.org>; Thu, 15 Nov 2007 08:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=vtROkOQNSon83/7Q+FRZnW1/W1gPOfCVIvw3nGtlGlU=;
        b=V4JlIqzBvJuBeznCFYUfa94qrtiPfTcblCxFhzgPc/bG1651csjs1CqdV3Teo1CNw2B9ibndq1Yy0hh35kH348uFTTLdTGgnNgpkfh/YeOCXLisMA/ZymgOph9ftIX2vCVYZOQOXeyHsP8fjNAZA82n+GRBilyR6HHnUlNQjuiU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hVCB0Mm4bbR91LXU40oeT5UTV62eixfd6lRom75mO5g1nqb1/DJbKxqxxYyIz2nmkJYJ9vrI8WGNDPMeT04LfKYoEaJlf5Rjouyf4oplsjJY/6FAl4IoN0uktFRAQMe/cm9zcnypP+mm5OdE7/tZLjvNKWoSRk1sgD3pbH3T238=
Received: by 10.142.187.2 with SMTP id k2mr171395wff.1195144656350;
        Thu, 15 Nov 2007 08:37:36 -0800 (PST)
Received: by 10.142.230.10 with HTTP; Thu, 15 Nov 2007 08:37:36 -0800 (PST)
In-Reply-To: <200711120039.lAC0dgex015049@freya.yggdrasil.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65135>

On 12/11/2007, Adam J. Richter <adam@yggdrasil.com> wrote:
>         So, did repeated "stg pop" commands to get to the point where
> the change to parser.y is applied, did an "stg new", deleted
> y.tab.{c,h}, did "stg rm y.tab.{c,h}" and "stg refresh".  So far, so
> good.  Then I tried to do an "stg push" to re-integrate the next
> patch, and I got a complaint from stgit about some git object not
> existing.  This patch did not touch y.tab.{c,h} or any files touched
> by any of the other patches I had pushed on.

I don't know the exact error but are you sure that changes to
y.tab.{c,h} are not involuntarily included in other patches?

> I don't know stgit well
> enough to recover from the situation gracefully, so I just wiped the
> stgit tree and tried to apply the patches again, which brings me to
> bug #2.

If the error is a conflict, 'stg push --undo' should revert the pushed
patch to its previous state. Otherwise, fix the conflict and run 'stg
refresh'.

>         I made a new stgit tree of the program (bash), pulling from a
> local git tree, and attempted to apply the first patch, with usuaul
> "stg new...make changes...stg refresh".  Then stg refresh informed
> printed this message ("invalid_multibyte_sequence" is the name of the
> new patch):
>
> Checking for changes in the working directory ... done
> Refreshing patch "invalid_multibyte_sequence" ... done (empty patch)
>
>         "stg diff" still shows the changes as if I had not done an
> "stg refresh".  Obviously, stg commits have worked for me in the past.
> I suspect that a recent upgrade of git or other system software
> triggered the break.

I haven't seen this type of error before. There might be some
inconsistency between the HEAD and the index. Can you try
'git-read-tree HEAD' and run 'stg refresh' afterwards?

You might also want to try the latest StGIT snapshot. It should be
pretty stable as we are preparing it for a 0.14 release.

-- 
Catalin
