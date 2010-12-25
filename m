From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 1/2] t1501: avoid bashisms
Date: Sat, 25 Dec 2010 21:44:25 +0700
Message-ID: <AANLkTi=fCa4a-POoMWqnraFjz28-Ko4Yp0fcar+d7AsE@mail.gmail.com>
References: <1293285457-11915-1-git-send-email-pclouds@gmail.com>
 <m2aajudjqt.fsf@whitebox.home> <AANLkTinhrBf14446rJBZSYWTSH6sxOchMcgBsrq8DoLO@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michel Briand <michelbriand@free.fr>
To: Andreas Schwab <schwab@linux-m68k.org>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Dec 25 15:45:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PWVMl-0008PO-Cg
	for gcvg-git-2@lo.gmane.org; Sat, 25 Dec 2010 15:45:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751550Ab0LYOo6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Dec 2010 09:44:58 -0500
Received: from mail-ww0-f42.google.com ([74.125.82.42]:34531 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138Ab0LYOo5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Dec 2010 09:44:57 -0500
Received: by wwi17 with SMTP id 17so7733048wwi.1
        for <git@vger.kernel.org>; Sat, 25 Dec 2010 06:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=rt2gmEKUkB9j3rYghZDbAmmmayV3MtfsdS9U6xqHqY0=;
        b=HEUWLaeFMpvcQl//HmkbXZ4T2wIyk2HGZo+I8nji1BhIKDEONO+LkQIjYu+4nmSUy1
         9CuyegDsy9JrN94pY9LLClYDz3iRbRcdtTlJqdimwuqAR7CqkWekAiGb5iJ//YCa0RmA
         dSlLHfnAKS6u8D3vCOOZBDZsrPKGJJ086PHGQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=mw8DvZbFmPYusfB9ZLFl5xFw/d1QvOIGrqUyVzK9nn3P9SWctt95DuOs8R9Ux91zu3
         eWKVoYwhxDZJByfx0Rx4/tC0+RJlwhMK7Q3fRxjl7pkXnLgRyN0uBq0UYFcfBu1/Vspg
         4L8bJKwLVIuJz+Yyfd1WeYmXWPzd8ofPyol0Q=
Received: by 10.216.142.101 with SMTP id h79mr11595580wej.49.1293288295496;
 Sat, 25 Dec 2010 06:44:55 -0800 (PST)
Received: by 10.216.158.83 with HTTP; Sat, 25 Dec 2010 06:44:25 -0800 (PST)
In-Reply-To: <AANLkTinhrBf14446rJBZSYWTSH6sxOchMcgBsrq8DoLO@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164181>

On Sat, Dec 25, 2010 at 9:29 PM, Nguyen Thai Ngoc Duy <pclouds@gmail.co=
m> wrote:
> 2010/12/25 Andreas Schwab <schwab@linux-m68k.org>:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes=
:
>>
>>> @@ -322,7 +322,10 @@ test_expect_success 'git grep' '
>>> =C2=A0test_expect_success 'git commit' '
>>> =C2=A0 =C2=A0 =C2=A0 (
>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cd repo.git &&
>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 GIT_DIR=3D. GIT_WORK_TR=
EE=3Dwork git commit -a -m done
>>
>> In which way is that not portable?
>
> I admit that I rarely leave bash, so I'll quote Johannes answer [1]
>
> -- 8< --
> Sure, it is (bashisms). This:
>
> =C2=A0 GIT_DIR=3D"$TRASH_DIRECTORY/2/.git" test_repo 2/sub
>
> does not work the same way in all shells when test_repo is a shell
> function. You have to export GIT_DIR explicitly before the function c=
all.

Hmm.. I misread it. That's only for shell _functions_. [1] says
variable assignments for simple commands are actually exported.

Junio, please don't pick up this patch.

[1] http://pubs.opengroup.org/onlinepubs/009695399/utilities/xcu_chap02=
=2Ehtml
--=20
Duy
