From: Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH] Maintaince script for l10n files and commits
Date: Fri, 9 Mar 2012 08:57:22 +0800
Message-ID: <CANYiYbGxsTZ1sDVf8e47w9butmN_XUgucJByfCdYfFSpNhzVYA@mail.gmail.com>
References: <7vr4x4mdae.fsf@alter.siamese.dyndns.org>
	<1331222706-81728-1-git-send-email-worldhello.net@gmail.com>
	<7v399iddw3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, avarab@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 09 01:57:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S5o9X-00069U-Rl
	for gcvg-git-2@plane.gmane.org; Fri, 09 Mar 2012 01:57:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759100Ab2CIA5c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 Mar 2012 19:57:32 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:43169 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759389Ab2CIA5X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 8 Mar 2012 19:57:23 -0500
Received: by vbbff1 with SMTP id ff1so963144vbb.19
        for <git@vger.kernel.org>; Thu, 08 Mar 2012 16:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=egHRUnzJwf4Cg0rwJZWtYIdqtzFGaP/hWyIgjirJD3Y=;
        b=ho3vyiX6NhhnU1FVDN4nAQSyQsk3hB8ag55Mcc8zhoMCjcRW2tQ/GuL2NxoYpsBahb
         goIjiOO2qlv+TVkZggWm71Aw/QXbK91NyEscPI0dyt2+05C8sPx2iA74qfzD+G2HGI3U
         CmrDFDC7T2AD+5FNSLE3IwoaQdln6Q1kZgL5+YdLDgaN0SKvVJey7cDMmGqbyYtVOSBc
         /6nGfhVEDa1WfXFDX81kFwSPr2J8cJodOQsSQ3B/OlG4cdErqwYgNfilYXw+hXtaRv15
         d42jHbqV8avQlkS5cBH6nbnBcbZHIyszMy/h0loQo3iPeIVS26WbFi4wQDMm9qkW00g3
         jm8A==
Received: by 10.52.173.104 with SMTP id bj8mr377971vdc.83.1331254642294; Thu,
 08 Mar 2012 16:57:22 -0800 (PST)
Received: by 10.52.26.37 with HTTP; Thu, 8 Mar 2012 16:57:22 -0800 (PST)
In-Reply-To: <7v399iddw3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192667>

2012/3/9 Junio C Hamano <gitster@pobox.com>:
> That's quite a style deviation from out norm in the commit log
> messages, don't you think (see "git log --no-merges -100", for
> example)? =A0State the problem you are attempting to solve first, and
> explain the solution to the problem, in separate paragraphs for
> readability, perhaps like this:
>
> =A0 =A0 =A0 =A0There are routine tasks translators need to perform th=
at can
> =A0 =A0 =A0 =A0be automated.
>
> =A0 =A0 =A0 =A0Help them to
>
> =A0 =A0 =A0 =A0 (1) initialize or update the message files;
> =A0 =A0 =A0 =A0 (2) check errors in the message files they edited;
> =A0 =A0 =A0 =A0 (3) check errors in their commits; and
> =A0 =A0 =A0 =A0 (4) review recent updates to the message template fil=
e
> =A0 =A0 =A0 =A0 =A0 =A0 they base their translations on.
>
> =A0 =A0 =A0 =A0by adding a helper script.

Thank you for provide better commit log, and I learn
a lot from it. Writing in English still a big issue for me,
and also obstacles to many l10n contributors. So your
decision that l10n contributors can write commit logs
in native language is very helpful, yet it has potential
risk about wrong character encodings in commit log.
So I need to write a helper for l10n team leaders,
especially for myself, to detect bad commit log,
because nobody knows all languages and encodings.
Hacks outside of "po/" directory should be checked
regularly also.


>> @@ -0,0 +1,271 @@
>> +#!/bin/bash
>
> Is there any bash-ism in this script? =A0Otherwise please start this
> with "#!/bin/sh" to allow people who do not use bash to get involved
> in the project.

There are several regex match expressions written in bash style,
which is not dash compatible. I will try to use grep and sed instead.

> Will we later regret that we didn't give a command word for this
> one? =A0Two common sources of such risks are:
>
> =A0(1) it turns out XX.po matches the pattern we would want to use as
> =A0 =A0 a command; and
>
> =A0(2) it turns out "init/update" is not the most often used action.
>
> I do not think (1) is likely. I do not think anybody can decide
> about (2) at this point yet.

The style of arguments comes from previous Rakefile implementation.
I will change XX.po as a alias subcommand of init/update.

--=20
Jiang xin
