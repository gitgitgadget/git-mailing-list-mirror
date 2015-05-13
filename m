From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v2] mergetools: add winmerge as a builtin tool
Date: Wed, 13 May 2015 17:33:53 +0200
Message-ID: <CAHGBnuPDSdCyVNM+Gagang1Cf9yw0Tyios45i6pnZSSzaJJC2Q@mail.gmail.com>
References: <1431482407-63642-1-git-send-email-davvid@gmail.com>
	<55534F4E.60402@gmail.com>
	<3d7e3b09b89c46c39befca7564f5c1d6@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: David Aguilar <davvid@gmail.com>, Phil Susi <phillsusi@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Philip Oakley <philipoakley@iee.org>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 13 17:34:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsYfX-0002d2-E8
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 17:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934512AbbEMPdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2015 11:33:55 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:36714 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933546AbbEMPdy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2015 11:33:54 -0400
Received: by igbpi8 with SMTP id pi8so142312711igb.1
        for <git@vger.kernel.org>; Wed, 13 May 2015 08:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=ZK6SjidsyeJtMU5B+ifoOxVG1reca9ae25+m02aZVrE=;
        b=BgbfQ6hAHZSuIZVG4Sbmkjb9EylfbYmLP4iMIVjyR/r7s7tk6eJFb3Lg4naP4wbB+u
         elznUSs3hBYiVQG07xjry2H7YNQwsj0vBuE7TpI69I+TwhJq3DmhVKV/S1jIJZdg2gVa
         dd/HppLG7ynCtuDpTbHcF7SVMmDx1sppgS3AR1Qzh2HzZeWry2qwBKVTnl4iRA/JTqq9
         Dwgds/zB7A0C2tEl/QXbn+ZuCvRgQ0ocFxU5iL7nuunuhy/hfLUezyXtAS9bel24c8F+
         RH6Cmqy4HCivpBgwbsXwZHsvFlfPpmLOPhSdgeOZSbOktMN7oi8Y8vsdjEyGaF5+tIuL
         vMjw==
X-Received: by 10.42.126.10 with SMTP id c10mr9909351ics.66.1431531233690;
 Wed, 13 May 2015 08:33:53 -0700 (PDT)
Received: by 10.107.29.149 with HTTP; Wed, 13 May 2015 08:33:53 -0700 (PDT)
In-Reply-To: <3d7e3b09b89c46c39befca7564f5c1d6@www.dscho.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268989>

On Wed, May 13, 2015 at 5:22 PM, Johannes Schindelin
<johannes.schindelin@gmx.de> wrote:

> In my tests, "$PROGRAMFILES(X86)" did *not* work:
>
>     $ echo "$PROGRAMFILES(X86)"
>     bash: syntax error near unexpected token `('

Interesting. In both MSYS1/2 Git Bashes I get on Windows 7 64-bit:

$ echo "$PROGRAMFILES(X86)"
C:\Program Files (x86)(X86)

So it seems to resolve only the $PROGRAMFILES part and appending the
literal "(X86)". Not sure how to tell Bash that "(X86)" is part of the
variable name.

> Exactly. In my tests, "$ProgramW6432" worked, while "$PROGRAMW6432" did not.

Very odd indeed that for me it's the exact opposite.

> FWIW I think that the idea to test for a WinMerge executable of another bitness makes sense, because we can execute an executable of another bitness (unlike a .dll of another bitness).

I agree it makes sense to check for both 64-bit and 32-bit WinMerge
installations. But IMO it does not make sense to mix in the bitness of
the process requesting the environment as part of running the
mergetools/winmerge script, which is what we do by querying
"$ProgramW6432" / "$PROGRAMW6432" .

-- 
Sebastian Schuberth
