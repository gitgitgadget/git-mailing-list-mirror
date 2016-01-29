From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5 04/10] grep/icase: avoid kwsset on literal non-ascii strings
Date: Fri, 29 Jan 2016 01:41:39 -0500
Message-ID: <CAPig+cSgMM2zjdqbtw0HZ1gmLoiBA5h_cD_oMTDA_23unThEFA@mail.gmail.com>
References: <1453982183-24124-1-git-send-email-pclouds@gmail.com>
	<1453982183-24124-5-git-send-email-pclouds@gmail.com>
	<CAPig+cSrt3FE081a=7in_h2njCbhPfaSHm+S+e8-DLuvP7Ga0w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 29 07:41:48 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aP2ka-0001N8-NX
	for gcvg-git-2@plane.gmane.org; Fri, 29 Jan 2016 07:41:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751947AbcA2Gll convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Jan 2016 01:41:41 -0500
Received: from mail-vk0-f67.google.com ([209.85.213.67]:33066 "EHLO
	mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751717AbcA2Glk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jan 2016 01:41:40 -0500
Received: by mail-vk0-f67.google.com with SMTP id n1so2478105vkb.0
        for <git@vger.kernel.org>; Thu, 28 Jan 2016 22:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=WzpPI6KjVR7mQaDaJOnMxFSi9yT5wnzbMNfdOw5MVrs=;
        b=LU95TKwGA5tgTFySCImfIyHYb0mUdav50RTsOxHD/ApO9kCboNerUvyLxGP6kC387s
         z48DCYH/KwJRO3bSe2Vol7LwzdNV1xR7Ih4GTQVIRQks4+Q7X+IoPdD50zaoybLCuiPN
         rZ1AuqIiRiRRcYNbaZbrElXO2arcasc3qpO4dp3+OkHidgsSgxNrnIi0pUF79RjsG83w
         a/BespBwJQDbWQ2u8koEZp042CAK1dZD8nDJaNhVL82Hase0ctZp9xmJvbVnEfXzW/Sz
         PKAr5ce6YWnMqJwDjrXcZSUIxnbEBSTgcwu8KWKoIb08nj8M4pGZlFUkZZkr1L2EEYXL
         78mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=WzpPI6KjVR7mQaDaJOnMxFSi9yT5wnzbMNfdOw5MVrs=;
        b=itPlvcbVBOhE06SIQdTsoECQYSCiiPeIRDFAI0cziTlSQJm2+2Za2Zxh2KSCYLHouj
         OvfZnDtMJoAeIXeRsJyWHPB4I1TKRcPK7lpnw71Fjazy+g41izaFwa8132ZD3J93h4ei
         S3+xIOrLVdpy6sll29cqiySIKSfhB3OvSHfwlbW4EROeO1pRYf6l1dwRBdPqIlAyreBJ
         WykQBbpCm0TmLyqw82q5N+/LK4J3iWBs3Kb1zVLn4x6iBgkWqBR3jZQPZsGAbBFc0s3D
         vBubkqO1xwyIoAzI6WaKpFWKemiNGQuSCXd7yRg7d6/NCqU3lwdPRDW6xjuazrVI2Y+z
         4UDA==
X-Gm-Message-State: AG10YOSrsWWWYjIWkN/OqkOEAL+QHfmkOuTcyI3cWOFCAj66wb99KBCS8cfR1TH8+aZ/t5nKYfik9rieJ10bNg==
X-Received: by 10.31.150.76 with SMTP id y73mr4830184vkd.84.1454049699136;
 Thu, 28 Jan 2016 22:41:39 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Thu, 28 Jan 2016 22:41:39 -0800 (PST)
In-Reply-To: <CAPig+cSrt3FE081a=7in_h2njCbhPfaSHm+S+e8-DLuvP7Ga0w@mail.gmail.com>
X-Google-Sender-Auth: 8tGwdo28CVrun6f76e9DTEs-fuk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285067>

On Fri, Jan 29, 2016 at 1:18 AM, Eric Sunshine <sunshine@sunshineco.com=
> wrote:
> On Thu, Jan 28, 2016 at 6:56 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8D=
c Duy <pclouds@gmail.com> wrote:
>> When we detect the pattern is just a literal string, we avoid heavy
>> regex engine and use fast substring search implemented in kwsset.c.
>> But kws uses git-ctype which is locale-independent so it does not kn=
ow
>> how to fold case properly outside ascii range. Let regcomp or pcre
>> take care of this case instead. Slower, but accurate.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>> diff --git a/grep.c b/grep.c
>> @@ -398,12 +399,16 @@ static int is_fixed(const char *s, size_t len)
>>  static void compile_regexp(struct grep_pat *p, struct grep_opt *opt=
)
>>  {
>> +       int icase_non_ascii;
>>         int err;
>>
>>         p->word_regexp =3D opt->word_regexp;
>>         p->ignore_case =3D opt->ignore_case;
>> +       icase_non_ascii =3D
>> +               (opt->regflags & REG_ICASE || p->ignore_case) &&
>> +               has_non_ascii(p->pattern);
>>
>> -       if (is_fixed(p->pattern, p->patternlen))
>> +       if (!icase_non_ascii && is_fixed(p->pattern, p->patternlen))
>
> These double negatives (!non_ascii) here and in patch 5/10 are
> difficult to grok. I wonder if a different name, such as
> icase_ascii_only would help.

By the way, this is such a minor issue, and since there are only two
cases (in patches 4/10 and 5/10), it's not worth worrying about, and
certainly not worth a reroll.
