From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: Issue when changing staged files in a pre-commit hook
Date: Tue, 19 Jan 2016 19:20:36 +0700
Message-ID: <CACsJy8DhiYiie7+Cw3PkPJpSX7CGp-r2Mu98mLp4OMhhGdsXgQ@mail.gmail.com>
References: <CAPYEnzGfnRbajDQAwBTNE5XSaB0WbHKbf1heRV0bUgbq5w_A5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Niek van der Kooy <niekvanderkooy@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 13:21:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aLVHi-000117-PC
	for gcvg-git-2@plane.gmane.org; Tue, 19 Jan 2016 13:21:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753165AbcASMVK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2016 07:21:10 -0500
Received: from mail-lf0-f51.google.com ([209.85.215.51]:34366 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751496AbcASMVH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2016 07:21:07 -0500
Received: by mail-lf0-f51.google.com with SMTP id 17so135000994lfz.1
        for <git@vger.kernel.org>; Tue, 19 Jan 2016 04:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=KO75FAFa3X/Bjo0pnNqqVTeZbspnVXPcPWXWKYPwvyU=;
        b=wWzxIQHSOtLyaDnnFnBKammA3N+1fc18gCgAXFnX5nHgp7L+wdvIiiBZrDwqSSdNgd
         TFXQM+QZvRq/I2ROvk6ONCXuHkMAHUY/qqPiWaCLPxNQsAwqJfPosBDyZvzMGQitHh+t
         08A2hYWPMOffRo1FrIBNtymMSVxfODdyntywrhb6tZV1o591HuVUmMozANySae2sTCDg
         zlW6Vg+PmNDDEpzlBwXIM4o19tF+AuDxe9lmQ5Fn625kxKpsQOpVMzgZM02hD5pazXQZ
         xJOqnuKZIAGl1Xr628MXW16HtvnWvjxGtdiT/geoGM3zp1WEdDR8xAB/8SoP/qwcEpZ0
         zZ5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=KO75FAFa3X/Bjo0pnNqqVTeZbspnVXPcPWXWKYPwvyU=;
        b=cr+WSBbJyrbkAKhilGvAAAmiT4GDuF2Ff8Anf9Wk5Y7ctzt+rC0ZzNtYQ0Q/EAy02o
         gOPtCgA7IUzi76TrZusKSPWGnQWRHiKNavewHfVYLcDilekCOn6rJJ24TTXWzDT1UB/f
         WfyPa4Jb2+QlfpLKXPEuOPPMSosjlZ6IrGEUddD4SboRf9nC3X9HNe3FJ7TF+ovVqxUr
         jJJDUPZV58om3x/n66FTEUmRxwtnq4Hq/oZ1uJdOc1V00oroILvE0DrnaHYE+yMRvZaN
         D9vajeo9Np1IafK801vnMcNFHuGAo2gE2AOJzTN/vVgv4YeuoqjX088AQRlOXLta0zrL
         JwQw==
X-Gm-Message-State: ALoCoQnRGpdqXT8K+2YrIFS1Rz+TXHTZx2GxyXlXMtcJVKf+mKH0p3fPQpVf1ZPobDltR1uqGr7+5ICjNKyQKCpnd9Dzg5tU3A==
X-Received: by 10.25.144.17 with SMTP id s17mr10419071lfd.94.1453206065941;
 Tue, 19 Jan 2016 04:21:05 -0800 (PST)
Received: by 10.112.97.72 with HTTP; Tue, 19 Jan 2016 04:20:36 -0800 (PST)
In-Reply-To: <CAPYEnzGfnRbajDQAwBTNE5XSaB0WbHKbf1heRV0bUgbq5w_A5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284357>

On Mon, Dec 28, 2015 at 7:17 PM, Niek van der Kooy
<niekvanderkooy@gmail.com> wrote:
> I am having an issue where the default commit message is not changed
> when adding staged files in a pre-commit hook.
> Please see http://stackoverflow.com/questions/34492779/git-update-git-status-part-of-commit-message-after-pre-commit-hook
> for details.

you should probably copy the text here instead of putting a link.
Sometimes I don't bother clicking another link. Make it easy for
people to help you. Long story short, pre-commit hook adds a file,
which ends up in the commit, but is not shown in git-status.

> Is there a workaround / proper way to achieve what I am trying to do,
> or is this a bug?

When you commit something, git may prepare a temporary index that
contains what's to be in the commit, unless you do "git commit"
without -a/-A, or paths... The pre-commit is set up to see this index.
So if you make changes in this index, they will end up in the new
commit. But the index will then be discarded. The main index,
$GIT_DIR/index, may or may not be untouched the whole time. This is
the index that is used by "git status". If you do "git commit" without
-a/-A/paths they "git status" should be consistent because your hook
sees $GIT_DIR/index instead of a temporary one.

I think it's the intended behavior. I believe $GIT_DIR is exported to
your hook, so in theory you could do an extra
"GIT_INDEX_FILE=$GIT_DIR/index git add public" (i.e. you update _two_
index files, one for committing, one for future git commands). But be
careful. It may have unwanted effects. It's probably easier to make an
alias that adds that 'public' file first then commits without hooks.
-- 
Duy
