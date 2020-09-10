Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE273C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4057C221EE
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 21:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="H3pel5Y4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728093AbgIJVXl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 17:23:41 -0400
Received: from mout.web.de ([212.227.17.11]:57863 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgIJOXi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 10:23:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1599747796;
        bh=V4sL9n4ClChzUkzp5o6in43kCY3HFnlmgNSGVLFrurg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=H3pel5Y4jgOZN4zIpukx4gGm9nViU62gq1if8t2/KGUIVBYUbZSFe/LEOSOOLVyPX
         6TNyIXJTuS8NoAJtWqap+bRV1nl+X54/QI3tVEMWr8Rlq6ubHjqkaEvaTtKRIIoTLm
         JSd6NGncQMSGgekLkxyzawx2JIL4nfaLFaVuEOOQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([91.47.149.245]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mav2X-1knFGB02pf-00c98Q; Thu, 10
 Sep 2020 16:23:16 +0200
Subject: Re: [Bug report] git status doesn't escape paths of untracked files
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Patrick Fong <patrickf3139@gmail.com>, git@vger.kernel.org
References: <CAMRL+qb0YC1EOTM-LDfMpJ=AJJ014LT5ufBcs0v77byN74A0vw@mail.gmail.com>
 <20200908011756.GG241078@camp.crustytoothpaste.net>
 <xmqq5z8p12ds.fsf@gitster.c.googlers.com>
 <xmqq4ko8yxp9.fsf@gitster.c.googlers.com>
 <3a72c5f2-35cc-a865-d5f2-02706c48d8ec@web.de>
 <xmqqa6xytwtn.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <b48b2be0-c417-9140-54f1-73d0c59c40d5@web.de>
Date:   Thu, 10 Sep 2020 16:23:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqa6xytwtn.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:4+84LYHSoTGTo4RkT6S3Dq67OrIuL96fbEaNYtGjWKUzq3F/l+3
 IihsG/5NhmP4oKYQTC+URI26VLXiISwTR2sMjZGCrPD4QGFxrr4KFZDwlc3DlqqJAF8CvCY
 iWDyF65LDf7UJbbJnzZPF0lGPy9iuf+jrZEtKKZXbC42fl0Fxb5JVnAC0Cs8lPKNvtWooWp
 +1aqhYZqapANIs3TXi2OA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:jzfkgk/ee/s=:x3oQegkTX84JB/9pPjBhg9
 Xearynagkdi+9vkTF85Q0wX/cAwys5nhCSU5UVDAA4rdbWkUrVyZvJFNnNvlin0r5nRG2H7Xa
 tTcxXugnw8d7Ua839PTclMx4DyR/NtVbxLji5xmSfwIjPj5f+raCGXb4hSLRZ5HmpMiSEgv1U
 bX/jpCaEa5cclN01mRFXzHIsRWHBpdhsSax1grMFuUio0z2dqweBtb4MLmrOzshQhDaIbGX7E
 3BLsxuLeuwcZ+bVLOAjSM9Ml8G6wZ12WYdpu2GvEF1bfuqHH2zed3aTtZ1I+IbawRptixtS2T
 ozIn+iThLBWJmT/kpYqPVZv7sKFKwzppSVzdT5GkEGIpVUDKnSzDgNK47FvbIUF/cV8a52nLZ
 LmXHBHB3pjSNWFc+SfnTcwSZMCOvUNtsWfT9g+mxA4JS1wmaZ20txCSPk2I0vRcFNgG36VCLt
 lIY/3ebeIYv51bPyfypdP1N787hM0/2i6AQzwtf3PH7yo62EkDZar9+Cji1V0DAN+vdSQyXsl
 usLArvytf9/7d0PANPzk/PBTEohB4+amJGFA/xvigGVgQjIIh0zv5m89LrHn0w6/hNirQd0wR
 t3528ReK+iBvOKOfaIARziuiBAN4eVXvFaJk4wKQCJkeavFxe8Q1UcjPI39XVJuJxW9Nskfrl
 VPHxvfnL9vlBYHmAEvcOf2+PV7kczTw+AExUB7+SGouHDivrIXaYXzWou9qqsW5Z9T6WSLuS6
 8yCy6Zp1+9r+qZpFSynMrCq1PPRgXvyW5UoOUhn33NKWkDJ2PSenAGxiZiaQr+vovAacNBbbP
 3+kop83uyIu0xjTlciZtf4HXarkH2Ke2bLWlPtenLyO59XeFV7BaC0UQOYi8FOpgKB3ZLNwXW
 aDMQsU1WEN2qPp6Gdr8ziNPn2ocaTV1UtaNWn2QqLZWi9hwUZpA3BV9PZpAfV9Z075SA4F7OD
 zKJKaXIkEdPxEFRfHpDDkWZQkuqU/LazNvmP06iqaqEb7nWFt13rE9E4FO8zev2wzAMIQyPvr
 0y6qtptJzU7X3QQlRVxVL30BYaXx1oUC22YHtayCuoSiD07bhPTRqe4KJo/68pmlniraZXCM6
 /KY9aeUySQ2HC3z6THT6lV5ekB/DdaVzONBJdvpGjwY58ALRn8D55EypJ2RZC2ViICxtnVeVX
 0PVQbpiqElwI1lE3XMiRT8PNqtirEUiFL1WIX/ZA9Q4wXwJur+ExSRmzd5qt+xIoAeqzjhDa3
 hqf95kuNLnDqnRsru
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 10.09.20 um 00:22 schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>> diff --git a/wt-status.c b/wt-status.c
>> index ff43932402..e0711aff04 100644
>> --- a/wt-status.c
>> +++ b/wt-status.c
>> @@ -1829,19 +1829,19 @@ static void wt_longstatus_print(struct wt_statu=
s *s)
>>  		wt_longstatus_print_stash_summary(s);
>>  }
>>
>> -static void print_cquoted(const char *fmt, const char *path, const cha=
r *prefix)
>> +static const char *cquote(const char *in, const char *prefix, struct s=
trbuf *out)
>>  {
>> -	struct strbuf onebuf =3D STRBUF_INIT;
>> -	const char *one;
>> -
>> -	one =3D quote_path(path, prefix, &onebuf);
>> -	if (*one !=3D '"' && strchr(one, ' ')) {
>> -		strbuf_insertstr(&onebuf, 0, "\"");
>> -		strbuf_addch(&onebuf, '"');
>> -		one =3D onebuf.buf;
>> -	}
>> -	printf(fmt, one);
>> -	strbuf_release(&onebuf);
>> +	struct strbuf sb =3D STRBUF_INIT;
>> +	const char *rel =3D relative_path(in, prefix, &sb);
>> +	int need_quotes =3D *rel !=3D '"' && strchr(rel, ' ');
>
> relative_path() does not quote, so "begins with a dq" is not a good
> test to see "if we were to pass this string to quote_c_style(), would
> we get it back quoted already so we won't have to surround the
> result with an extra pair of dq ourselves?".

Ha!, that's true.  Makes me wonder how it was still able to pass the
test suite, though..

>
>> +	strbuf_reset(out);
>> +	if (need_quotes)
>> +		strbuf_addch(out, '"');
>> +	quote_c_style(rel, out, NULL, 0);
>> +	if (need_quotes)
>> +		strbuf_addch(out, '"');
>> +	strbuf_release(&sb);
>> +	return out->buf;
>>  }
