From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [PATCH (resend)] Let core.excludesfile default to ~/.gitexcludes.
Date: Thu, 26 Nov 2009 14:01:15 +0100
Message-ID: <36ca99e90911260501q571929e5l114cb0af9f374a98@mail.gmail.com>
References: <1258840832-22130-1-git-send-email-Matthieu.Moy@imag.fr>
	 <1259231726-5218-1-git-send-email-Matthieu.Moy@imag.fr>
	 <4B0E6DC9.3070105@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	gitster@pobox.com
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Nov 26 14:02:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NDdyN-0002KE-5M
	for gcvg-git-2@lo.gmane.org; Thu, 26 Nov 2009 14:01:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760439AbZKZNBM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Nov 2009 08:01:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760434AbZKZNBL
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Nov 2009 08:01:11 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:49073 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758329AbZKZNBL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Nov 2009 08:01:11 -0500
Received: by fxm5 with SMTP id 5so706520fxm.28
        for <git@vger.kernel.org>; Thu, 26 Nov 2009 05:01:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=SPlyzyf/1KJkLesQIBzxlr0h2XRQ3yGXo+yY8jNCqJY=;
        b=rZkLLBeSU/eY0TERPAYtstI4bxZSX67f77FkSMpH9wVQrn2gzUbZC8icC6KHPlysZ0
         lqTO/GGm5tuE4Haj4mx+kCKS2Rxu1HTQnbtUyNGvV+geJU0wK8fMEOEO/HkgGH1H8bef
         0qTh5x3M8gJBno1RZGUVSyoCC2Y4Xlwi8IZV0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=fPIFIe2nC6KvJ1ie9xUADjQJzlmv2QwYnfZYDRPr9wmnxtYoWN2ZT0EQt0sM0XGcjz
         uA6NZx2HYlCq5nZnE3iO8aHHnrSETA/86TcprBa5bDiM7BDJEtCqQDbAhxxmT7aqV2o2
         XdsPKAtHpzdkzCHVcnvuVgiZDVwxIsvIcqtho=
Received: by 10.223.4.214 with SMTP id 22mr1392348fas.34.1259240475836; Thu, 
	26 Nov 2009 05:01:15 -0800 (PST)
In-Reply-To: <4B0E6DC9.3070105@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133792>

On Thu, Nov 26, 2009 at 13:00, Michael J Gruber
<git@drmicha.warpmail.net> wrote:
> Matthieu Moy venit, vidit, dixit 26.11.2009 11:35:
>> Most users will set it to ~/.gitsomething. ~/.gitignore would conflict
>> with per-directory ignore file if ~/ is managed by Git, so ~/.gitexcludes
>> is a sane default.
>
> I'm sorry to jump in so late, and this may sound like bike-shedding, but
> right now we have
>
> .git/info/exclude
> .gitignore
>
> and this would add
>
> ~/.gitexcludes
>
> That is, three terms, or two, where one comes in two variations
> (exclude/exludes). I always wondered why we have two.
>
> The reason for .gitignore is most probably the similarity to
> .${othervcs}ignore, and that is a valid reason.
>
> I know we have ~/.gitconfig for the global version of .git/config, and
> maybe that was just no good idea either. But I don't even dare
> suggesting to rename it ~/.gitglobalconfig.
>
> So, in line at least with our term "global" (per user) config, I would
> suggest to use "~/.gitglobalignore" for the global ignore file. Maybe,
> eventually, we'll manage to rename .git/info/excludes to .git/info/ignore.
>
> On a somewhat larger scale, a good alternative strategy would be to have
> a directory "~/.gitglobal/" in which Git would look for
> ~/.gitglobal/config and
> ~/.gitglobal/info/ignore or
> ~/.gitglobal/ignore
>
> i.e. mirroring the repo structure or at least bundling everything in a
> single dir, which would also be a good place for a global svnauthors
> file and such, and for other global configuration files we don't think
> of right now.
I would vote for that too. Its more future-proof than a single new
file. Also I would suggest to name this dir ~/.gitrc/. On the other
hand the --global option to git config specifies the .gitconfig in
your HOME.

Bert
>
> Michael
