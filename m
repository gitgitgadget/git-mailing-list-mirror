From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 7/8] ls-files: support --max-depth
Date: Fri, 28 Mar 2014 21:38:12 +0700
Message-ID: <CACsJy8BR8RoNAayS-rXgCz_=aHrxaoYBJH30jCSCC3ThL1ztjA@mail.gmail.com>
References: <1395310551-23201-1-git-send-email-pclouds@gmail.com>
 <1395310551-23201-8-git-send-email-pclouds@gmail.com> <1457323768.788823.1395737758945.JavaMail.zimbra@imag.fr>
 <CACsJy8Awu6oNOS-m5_DNh_HGeHKgcnowUY+iz4efo3s1HYycnQ@mail.gmail.com>
 <vpqtxaiqvl9.fsf@anie.imag.fr> <CACsJy8DtW_uUf+G4krc5=EPATNRST3aG9o-bhE34Yb7pw_dXSQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Mar 28 15:38:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTXvk-0006Pw-IQ
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 15:38:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751573AbaC1Oin (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 10:38:43 -0400
Received: from mail-qa0-f53.google.com ([209.85.216.53]:47207 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751427AbaC1Oim (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 10:38:42 -0400
Received: by mail-qa0-f53.google.com with SMTP id w8so5236491qac.26
        for <git@vger.kernel.org>; Fri, 28 Mar 2014 07:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=H+4xXCxKeH4w2h/h25V17LBue/tw5L1gneiiWjRsfgM=;
        b=mWnlB0jYeAKMiMD+9Ni+4iBFOXF1rDATzKAqZD66VuXNeMTHOJneCljRx+noQOdhAe
         byTD8DFVkeqJ+vJYClZMEnLzWpR3T1GQIETveywedfbTKWPuGRsJ51SfdLQrkiQ0sbj0
         ptUtJbGDg4XWZLSEZ3BLkGKNcOTr+B+u2y2YvYNnKBeolOVU9szuXMEGacrZ8zu6neFM
         87t8ijhOGPlzoRP5hb7P5vD36J1SYOLHHadKgDmYIsvF3JV9yfNv7B+srWJxcQOD1rz9
         1RZqbSdIZBcnc+O6kJA16KLSXL8sfRFdwyYhNGfZzGTsuTOkukcUjl2G5cLAaNByaHtI
         KYag==
X-Received: by 10.140.107.229 with SMTP id h92mr8934226qgf.30.1396017522172;
 Fri, 28 Mar 2014 07:38:42 -0700 (PDT)
Received: by 10.96.103.166 with HTTP; Fri, 28 Mar 2014 07:38:12 -0700 (PDT)
In-Reply-To: <CACsJy8DtW_uUf+G4krc5=EPATNRST3aG9o-bhE34Yb7pw_dXSQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245390>

On Fri, Mar 28, 2014 at 9:15 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Fri, Mar 28, 2014 at 8:52 PM, Matthieu Moy
> <Matthieu.Moy@grenoble-inp.fr> wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> I'd rather go with no trailing slash by default and add -F (which
>>> seems to be more than just '/')
>>
>> ... and then add a configuration variable to let users enable it by
>> default.
>>
>> For GNU ls, I have "alias ls='ls -F --color=auto'" in my shell's
>> configuration, but I cannot push the analogy by aliasing "git ls"
>> because Git doesn't allow aliasing existing commands.
>
> I can do that but I want to push for a general solution instead
> of ls-only. How about config key defaults.<cmd>, containing a list of
> arguments, that will be prepended to git-<cmd>? Only some commands are
> marked to support this by adding USE_DEFAULTS in the array commands[]
> in git.c. And "git --no-defaults <cmd>" will ignore defaults.<cmd> (or
> "git -c defaults.<cmd>= <cmd>" but it's less obvious). GIT_NO_DEFAULTS
> can also be set, which has the same effect for all commands.

Another option is to make git recognize program name g<something> and
auto map it to the alias <something>. For example, the symlink "gls"
will be executed as "git ls" (and the alias version is preferred over
the builtin one). Of course you can't have alias "it" because "git" is
already taken. It works for many cases, it's faster to type, and it
does not break current scripts.
-- 
Duy
