From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] wildmatch: properly fold case everywhere
Date: Thu, 30 May 2013 06:09:42 -0400
Message-ID: <CAPig+cQZd4Y5gwJkf4NT73xv5hYmNQeZ_kccrzF9_12WbzONJw@mail.gmail.com>
References: <CACsJy8CuaowyZJGKh7X+43qRwYAdUCDbVo8P5CpEtukBzRiReg@mail.gmail.com>
	<1369903506-72731-1-git-send-email-n.oxyde@gmail.com>
	<CAPig+cTfaj3e_sRZhHLQUDWYinFVsNieFFA027zJSfdSty1x1g@mail.gmail.com>
	<E670228E-B029-422C-B048-5F28E3AEB731@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Anthony Ramine <n.oxyde@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 30 12:09:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uhznp-0003Xw-Lx
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 12:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030371Ab3E3KJq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 06:09:46 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:41927 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967701Ab3E3KJo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 06:09:44 -0400
Received: by mail-la0-f47.google.com with SMTP id fq12so47690lab.20
        for <git@vger.kernel.org>; Thu, 30 May 2013 03:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=BRCI42/p9ONUoGrYWycDY8u5R7eF/cY8a7Dc34+AuW4=;
        b=PusFG1OAmB1IMiZ2sN8wyU1lS4CwoGxI6rIX1jo3S6zxlnz99T+PkT6P2cKVhSdZS1
         wbjZtWt1fpnobAkDcrWl0p7qGywnJHcqDNtG2u6DkMbKvdd4ff8TUoMSJwLFvLSxJqSe
         VJtvFlSnEygVHQ2Jzqeio+KsbrAh24VpQiv3sG0/gm2xizFx94Qk3ZOHnizkbeDloTFZ
         kZKyYd9cRPxirvj2mCWuM3dctZIYfgfu9pFtMLg14FtT7deV9K1bDtOh9pvHDFmmX6IA
         iiBZGpSPhNx1NdWpdJoUy7iBYJXaBIqTF/WEXwQcft/P9QVQEEobH0OHjVhtN92dfFOD
         o0Kw==
X-Received: by 10.112.188.161 with SMTP id gb1mr3381142lbc.107.1369908582750;
 Thu, 30 May 2013 03:09:42 -0700 (PDT)
Received: by 10.114.161.4 with HTTP; Thu, 30 May 2013 03:09:42 -0700 (PDT)
In-Reply-To: <E670228E-B029-422C-B048-5F28E3AEB731@gmail.com>
X-Google-Sender-Auth: hzoFRlFZB0JxuZM_tiU1RLbM47c
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225952>

On Thu, May 30, 2013 at 5:29 AM, Anthony Ramine <n.oxyde@gmail.com> wro=
te:
> Yes indeed. Will amend. Should I add your name in Reviewed-by as well=
?

No. I merely spotted a minor typographical error.

> --
> Anthony Ramine
>
> Le 30 mai 2013 =E0 11:07, Eric Sunshine a =E9crit :
>
>> On Thu, May 30, 2013 at 4:45 AM, Anthony Ramine <n.oxyde@gmail.com> =
wrote:
>>> Case folding is not done correctly when matching against the [:uppe=
r:]
>>> character class and uppercased character ranges (e.g. A-Z).
>>> Specifically, an uppercase letter fails to match against any of the=
m
>>> when case folding is requested because plain characters in the patt=
ern
>>> and the whole string and preemptively lowercased to handle the base=
 case
>>
>> Did you mean s/and preemptively/are preemptively/ ?
>>
>>> fast.
>>>
>>> That optimization is kept and ISLOWER() is used in the [:upper:] ca=
se
>>> when case folding is requested, while matching against a character =
range
>>> is retried with toupper() if the character was lowercase, as the bo=
unds
>>> of the range itself cannot be modified (in a case-insensitive conte=
xt,
>>> [A-_] is not equivalent to [a-_]).
>>>
>>> Signed-off-by: Anthony Ramine <n.oxyde@gmail.com>
>
