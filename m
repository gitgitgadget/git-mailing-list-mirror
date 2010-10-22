From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: Buglet in i18n?
Date: Fri, 22 Oct 2010 10:20:52 +0200
Message-ID: <AANLkTimqzmPLCj=JeSGWFcY829gxct9ANGt+CCjB2jy=@mail.gmail.com>
References: <4CC13AC1.7080402@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Fri Oct 22 10:21:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9Cs1-0001Sq-13
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 10:21:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755565Ab0JVIUz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 04:20:55 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:50068 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753987Ab0JVIUy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 04:20:54 -0400
Received: by bwz11 with SMTP id 11so299136bwz.19
        for <git@vger.kernel.org>; Fri, 22 Oct 2010 01:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=mKFG34EGUlTSIMTtaj0+N7CGjWSIRmhEEXI5g8KiW+4=;
        b=LG87R9epMjAdWRwgku4p+imKHU2sDpusg9Lq2xOu7WCopOU5of742Lrvw/H72eEnL9
         nTYCIkbQDAxycBUFBVY4ZgNnmYkjkNrBj0AAHmzv+Jwd5RH/j6CNRYSB+AqHLzpvTOq0
         FocTYGCJy/S9/uzE/EoXQ2028nxJGtpEivXoc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=C4NNLknsJW3kcnmTUGyJ3PB6pmaIk3Bl4Cj6kbhEzl/AL4zkknynJ0WY5opIPRaz+u
         K3MZ389BimWMzYhkAFr+TcIMqSZH8ZTsiylAcsxqUol04yXo+H5IqGkdEjRDw5DgfWun
         jru6xvXMM+B8mEWF3k7tm3DmMcONxYQh7gwsk=
Received: by 10.204.180.75 with SMTP id bt11mr1696785bkb.115.1287735652933;
 Fri, 22 Oct 2010 01:20:52 -0700 (PDT)
Received: by 10.223.115.5 with HTTP; Fri, 22 Oct 2010 01:20:52 -0700 (PDT)
In-Reply-To: <4CC13AC1.7080402@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159663>

On Fri, Oct 22, 2010 at 09:18, Johannes Sixt <j.sixt@viscovery.net> wrote:
> I just noticed these message after a 'git am' invocation:
>
> When you have resolved this problem run gitam--resolved.
> If you would prefer to skip this patch, instead run gitam--skip.
> To restore the original branch and stop patching run gitam--abort.
>
> Notice the missing blanks in the suggested commands.
>
> This is on Windows. I have ab/i18n (a102b434c) merged, but compiled with
> NO_GETTEXT.

This is the message in the code:

    eval_gettext "When you have resolved this problem run \"\$cmdline
--resolved\".
If you would prefer to skip this patch, instead run \"\$cmdline
--skip\".
To restore the original branch and stop patching run \"\$cmdline
--abort\"."; echo

And presumably you're using these functions from git-sh-i18n.sh:

        gettext () {
            printf "%s" "$1"
        }

        eval_gettext () {
            gettext_eval="printf '%s' \"$1\""
            printf "%s" "`eval \"$gettext_eval\"`"
        }

So maybe the shell on Windows doesn't behave the same way wih regards
to eval_gettext()?
