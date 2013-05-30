From: Anthony Ramine <n.oxyde@gmail.com>
Subject: Re: [PATCH] wildmatch: properly fold case everywhere
Date: Thu, 30 May 2013 11:29:25 +0200
Message-ID: <E670228E-B029-422C-B048-5F28E3AEB731@gmail.com>
References: <CACsJy8CuaowyZJGKh7X+43qRwYAdUCDbVo8P5CpEtukBzRiReg@mail.gmail.com> <1369903506-72731-1-git-send-email-n.oxyde@gmail.com> <CAPig+cTfaj3e_sRZhHLQUDWYinFVsNieFFA027zJSfdSty1x1g@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1283)
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?utf-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
	<pclouds@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu May 30 11:29:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhzAs-0008BT-Us
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 11:29:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967986Ab3E3J3b convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 05:29:31 -0400
Received: from mail-we0-f177.google.com ([74.125.82.177]:60465 "EHLO
	mail-we0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967400Ab3E3J3a convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 05:29:30 -0400
Received: by mail-we0-f177.google.com with SMTP id n57so16109wev.22
        for <git@vger.kernel.org>; Thu, 30 May 2013 02:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:mime-version:content-type:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to:x-mailer;
        bh=QaUtSEz4tMZJGBMK/RBmm6lWSEGkjOb6lCkwC//P56o=;
        b=mUNZDSHJTm+4UunSjOpFM/x4CQ6rcLgca7bKxPl3Ni9qUr4OIHTAye2cMBL++i+bxi
         86YKgHMBUF2NC2p3MVXvkpCzlz9gLtvSKSc7J2MO6d3AXN2I80hQG0xJX3rwElyScjdF
         SnnQTtqCrvMIhbkgqzWp5Z5gcQHyIiRUEf0wsTByRLf/i+cqzLfYQ7ddP7v+3qImW+uz
         LiLpI7sCFzbapaVQ1K8BwlSIeECEZHgT9q6w4PMBQnxPbXavJ8AtLJM8+rj0FenIIjXj
         /o+dlhtpf+/znsxyRm1P0VrcEhKlPDD4piB8b6QpXVBsppf4W2LENb4XVICbLYiZb6gT
         MMSA==
X-Received: by 10.180.206.228 with SMTP id lr4mr3695944wic.48.1369906168967;
        Thu, 30 May 2013 02:29:28 -0700 (PDT)
Received: from [192.168.118.188] (33-43.83-90.static-ip.oleane.fr. [90.83.43.33])
        by mx.google.com with ESMTPSA id q13sm36631467wie.8.2013.05.30.02.29.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 30 May 2013 02:29:27 -0700 (PDT)
In-Reply-To: <CAPig+cTfaj3e_sRZhHLQUDWYinFVsNieFFA027zJSfdSty1x1g@mail.gmail.com>
X-Mailer: Apple Mail (2.1283)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225949>

Yes indeed. Will amend. Should I add your name in Reviewed-by as well?

--=20
Anthony Ramine

Le 30 mai 2013 =E0 11:07, Eric Sunshine a =E9crit :

> On Thu, May 30, 2013 at 4:45 AM, Anthony Ramine <n.oxyde@gmail.com> w=
rote:
>> Case folding is not done correctly when matching against the [:upper=
:]
>> character class and uppercased character ranges (e.g. A-Z).
>> Specifically, an uppercase letter fails to match against any of them
>> when case folding is requested because plain characters in the patte=
rn
>> and the whole string and preemptively lowercased to handle the base =
case
>=20
> Did you mean s/and preemptively/are preemptively/ ?
>=20
>> fast.
>>=20
>> That optimization is kept and ISLOWER() is used in the [:upper:] cas=
e
>> when case folding is requested, while matching against a character r=
ange
>> is retried with toupper() if the character was lowercase, as the bou=
nds
>> of the range itself cannot be modified (in a case-insensitive contex=
t,
>> [A-_] is not equivalent to [a-_]).
>>=20
>> Signed-off-by: Anthony Ramine <n.oxyde@gmail.com>
