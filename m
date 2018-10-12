Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71AC11F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 13:52:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728646AbeJLVYm (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 17:24:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45158 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728354AbeJLVYm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 17:24:42 -0400
Received: by mail-wr1-f65.google.com with SMTP id q5-v6so13535971wrw.12
        for <git@vger.kernel.org>; Fri, 12 Oct 2018 06:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=NYja0fhTFHR55d0QgdX2EheFtjs0WeUtf1Ho6kzN0Gw=;
        b=WptuUvt5Q3+OdE19s+Tftu4YK0YAWiqfrLFdftBfFeaXYWNSWfDEBeU4u/HBLchwd9
         n0feLW8HxMjY4BRhFkw/KjfD4+uRYjbthv9c3r9Gyonp/QuiPnaM8Hpa4ffjIREx+Svb
         +YkYs/2H8stPlmkJ6TGs7vKXXzv6zTUjUmCxofkR0FpnRzDTS3X1SoPym1fNJbPrf2Ny
         OA2YTnMIDzpYtFR+MA6bhRe8orJSs2xhrW3Gf7mQuRsVaEj7s/0Z9QbT+6Biu1fu4QgU
         Dha8wm1S9DuPI9AtOxwrObptI6iN3mcv9uwMs0q+57nNYz6DEmAdHgS4CXL9vpp/8bGV
         bU8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=NYja0fhTFHR55d0QgdX2EheFtjs0WeUtf1Ho6kzN0Gw=;
        b=Sg2WBEtXuTvVO0NzogwB8Ggw/yH9Nuf6FLCJADboyFY0rBmxeUYnBHa3AdKvYRzBh/
         gz2CRxs29rt6zn60s82hmV8fM9oi5dxkHDJvjBhP+rX3AMbv9u/BMFvo8WII+NL90oYb
         NCXLd67y1jd8QVAJE/6zkSN8y1Rasaaz1Zeo9k27khzgVPMz5WGAa1YRCuyPnVcrmonh
         uGpMrYz1Y3GsyyhFs6JHAGG2F3y3siLjekKAVKTaQupHfThSTgk8jtf1fa2GPrHx0JFN
         dpX2CvMxIU0MWOv7rRGzCKRDfJH381OHULQDK+ad9itZO8i0iqVjHWsLgUV/nRGnlu+M
         Ouhw==
X-Gm-Message-State: ABuFfoi/lzdkRQ3/ma4UhYvxbNY9F+ca3p1CJPJmDTwL9dlbxfbUQt+y
        rPBSNTO+SQIqX9WL5weTyI0=
X-Google-Smtp-Source: ACcGV60Yt/ndDfF94TmtEEiET8tl5NBR9zxamvvxJ43UiWBOqMB7A9hDSjU6xsUXzqjLoIwn/gn4bw==
X-Received: by 2002:a05:6000:111:: with SMTP id o17mr5660294wrx.279.1539352327527;
        Fri, 12 Oct 2018 06:52:07 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id j46-v6sm1695571wre.91.2018.10.12.06.52.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Oct 2018 06:52:06 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Martin Koegler <martin.koegler@chello.at>
Subject: Re: [PATCH] zlib.c: use size_t for size
References: <xmqqsh1bbq36.fsf@gitster-ct.c.googlers.com>
        <nycvar.QRO.7.76.6.1810121150050.45@tvgsbejvaqbjf.bet>
Date:   Fri, 12 Oct 2018 22:52:05 +0900
In-Reply-To: <nycvar.QRO.7.76.6.1810121150050.45@tvgsbejvaqbjf.bet> (Johannes
        Schindelin's message of "Fri, 12 Oct 2018 11:54:31 +0200 (DST)")
Message-ID: <xmqqzhvj9ssa.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Fri, 12 Oct 2018, Junio C Hamano wrote:
>
>> From: Martin Koegler <martin.koegler@chello.at>
>> Date: Thu, 10 Aug 2017 20:13:08 +0200
>> 
>> Signed-off-by: Martin Koegler <martin.koegler@chello.at>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> ---
>> 
>>  * I made minimal adjustments to make the change apply to today's
>>    codebase.  I still find some choices and mixing of off_t and
>>    size_t done by the patch a bit iffy, and some arith may need to
>>    become st_addX().  Extra set of eyes are very much appreciated.
>> 
>>  builtin/pack-objects.c | 10 +++++-----
>>  cache.h                | 10 +++++-----
>>  pack-check.c           |  6 +++---
>>  pack.h                 |  2 +-
>>  packfile.h             |  2 +-
>>  wrapper.c              |  8 ++++----
>>  zlib.c                 |  8 ++++----
>>  7 files changed, 23 insertions(+), 23 deletions(-)
>> 
>> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
>> index e6316d294d..b9ca04eb8a 100644
>> --- a/builtin/pack-objects.c
>> +++ b/builtin/pack-objects.c
>> @@ -266,15 +266,15 @@ static void copy_pack_data(struct hashfile *f,
>>  		struct packed_git *p,
>>  		struct pack_window **w_curs,
>>  		off_t offset,
>> -		off_t len)
>> +		size_t len)
>>  {
>>  	unsigned char *in;
>> -	unsigned long avail;
>> +	size_t avail;
>>  
>>  	while (len) {
>>  		in = use_pack(p, w_curs, offset, &avail);
>>  		if (avail > len)
>
> Do we have to be careful to handle sizeof(off_t) != sizeof(size_t) here? I
> guess we would receive a compiler warning about different sizes in that
> case, but it makes me worry.

Yup, you just said exactly the same thing as I already said in the
part you quoted.  I still find the mixed use of off_t and size_t in
this patch iffy, and that was the secondary reason why the patch was
kept in the stalled state for so long.  The primary reason was that
nobody tried to dust it off and reignite the topic so far---which I
am trying to correct, but as I said, this is just minimally adjusted
to today's codebase, without any attempt to improve relative to the
original patch.

I think we are in agreement in that this is not making things worse,
as we are already in the mixed arith territory before this patch.

