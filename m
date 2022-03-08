Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8763DC433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 22:06:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344490AbiCHWHn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 17:07:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234181AbiCHWHm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 17:07:42 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6180C57168
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 14:06:45 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qt6so859391ejb.11
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 14:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HUXvqCuwfztjpKFz3RgfBwLkFcZotPjURBpuEy8QoBg=;
        b=GT12Jht1mUfJaN6VjZ3Xbtj848Q7Pl3U+5X9ze9OvtXXH5ys1Rb+W+PBn8ZHUfKnue
         eMoYwEVGxNCTVkDuAS1uBer1c6Ik5OhrO+j9OrPKwwn1yfW3B2t3n76PgfW7hNEZUIVC
         /Y5n+F4qlwMM8k4Jhif7SZoqzTfj6rs4xPJXNitnvvPmS4Xmb4cKnvx8g0UIM6c0mZT9
         msi4X7dJHLUtjRU7kRnH+y+JtiL3M8ySxfTbEwoNHLw/NR/vHQbwKSjPb7rY4PqUKcDh
         NCSIPYRFwxFrjX9wX8Io+VIq+BM81I4cCJ+HVtfDEo1yVTS+TON8xbi+Y1N3+k5weYw6
         kh9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HUXvqCuwfztjpKFz3RgfBwLkFcZotPjURBpuEy8QoBg=;
        b=pQJCjPkXUCAejvSr8ird+o/gZH3yuKvxLlOiPLLAT4tSrnTYhojRkbw71xrBQ8XAn5
         NX8FUNipAkfPyhQUhjb4T6lTeSOY5rhRZj9mkP0YeAHyDZBgVu4rqCZPTIztPSzD0BWN
         7I0znpwg6yjTtiXBvESCeAtopv0mTxCWCuDWQgElk1QEnmbuyOsP3FFMA5nUEveRtgXD
         gTuqW6dNKVLL+FI4DLdC5Pqr00RblaYEbADLk5L6XvzRkk9M6tvpWJoJ4cXCGWavKVVd
         3XABJAbJWdnyyLMExZ/JgyOACh/fS455q78Pezhw+GkKDU7eZDEI3T1NtyDoxw6ZMziW
         pc1w==
X-Gm-Message-State: AOAM5303mAmLJaHpIClQhLLUXyq+K/nutatbICFvZmzz7Ha/6eeT9dAz
        9mJ3hlqs6FmcNgWnZlT3K8Q=
X-Google-Smtp-Source: ABdhPJyswEznmBxyBCFeOBduZDSAWEZLyc1RU2YiWrf61DGrCy/CTkEx4moWFe1WBF0lYm/gUD88DQ==
X-Received: by 2002:a17:907:392:b0:6da:8608:e09e with SMTP id ss18-20020a170907039200b006da8608e09emr15131796ejb.89.1646777203725;
        Tue, 08 Mar 2022 14:06:43 -0800 (PST)
Received: from [10.37.129.2] (guest-pat-13-128.njit.edu. [128.235.13.128])
        by smtp.gmail.com with ESMTPSA id m10-20020a056402510a00b00415eee901c0sm24628edd.61.2022.03.08.14.06.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Mar 2022 14:06:43 -0800 (PST)
From:   John Cai <johncai86@gmail.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?utf-8?b?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2] cat-file: skip expanding default format
Date:   Tue, 08 Mar 2022 17:06:41 -0500
X-Mailer: MailMate (1.14r5852)
Message-ID: <52AB116A-E1A6-4609-AF13-A6C81581A511@gmail.com>
In-Reply-To: <YifSFQ8zEZimCkHl@nand.local>
References: <pull.1221.git.git.1646429845306.gitgitgadget@gmail.com>
 <pull.1221.v2.git.git.1646708063480.gitgitgadget@gmail.com>
 <YifSFQ8zEZimCkHl@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Taylor

On 8 Mar 2022, at 17:00, Taylor Blau wrote:

> On Tue, Mar 08, 2022 at 02:54:23AM +0000, John Cai via GitGitGadget wro=
te:
>>  /*
>>   * If "pack" is non-NULL, then "offset" is the byte offset within the=
 pack from
>>   * which the object may be accessed (though note that we may also rel=
y on
>> @@ -363,6 +371,11 @@ static void batch_object_write(const char *obj_na=
me,
>>  			       struct packed_git *pack,
>>  			       off_t offset)
>>  {
>> +	struct strbuf type_name =3D STRBUF_INIT;
>> +
>> +	if (!opt->format)
>> +		data->info.type_name =3D &type_name;
>
> Hmmm, I'm not quite sure I understand why the extra string buffer is
> necessary here. When we do the first expansion with the DEFAULT_FORMAT,=

> we set data->info.typep to point at data->type.
>
> So by the time we do our actual query (either with
> `packed_object_info()` or just `oid_object_info_extended()`), we will
> get the type filled into data->type.
>
> And we should be able to use that in print_default_format(), which save=
s
> us in a couple of ways:
>
>   - We don't have to (stack) allocate a string buffer, which then needs=

>     to be cleaned up after printing each object.
>
>   - (More importantly) we can avoid the extra string copy through the
>     intermediate buffer by using type_name() directly.

Agree with your reasoning here.

>
> Here's a small patch on top that you could apply, if you're interested:=

>
> --- >8 ---
>
>
> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index ab9a49e13a..9f55afa75b 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -355,5 +355,5 @@ static int print_default_format(char *buf, int len,=
 struct expand_data *data)
>  {
>  	return xsnprintf(buf, len, "%s %s %"PRIuMAX"\n", oid_to_hex(&data->oi=
d),
> -		 data->info.type_name->buf,
> +			 type_name(data->type),
>  		 (uintmax_t)*data->info.sizep);
>
> @@ -372,9 +372,4 @@ static void batch_object_write(const char *obj_name=
,
>  			       off_t offset)
>  {
> -	struct strbuf type_name =3D STRBUF_INIT;
> -
> -	if (!opt->format)
> -		data->info.type_name =3D &type_name;
> -
>  	if (!data->skip_object_info) {
>  		int ret;
> @@ -391,5 +386,5 @@ static void batch_object_write(const char *obj_name=
,
>  			       obj_name ? obj_name : oid_to_hex(&data->oid));
>  			fflush(stdout);
> -			goto cleanup;
> +			return;
>  		}
>  	}
> @@ -410,7 +405,4 @@ static void batch_object_write(const char *obj_name=
,
>  		batch_write(opt, "\n", 1);
>  	}
> -
> -cleanup:
> -	strbuf_release(&type_name);
>  }
>
> --- 8< ---
>
> On my copy of git.git., it shaves off around ~7ms that we're spending
> just copying type names back and forth.
>
>     (without the above)
>     Benchmark 1: git.compile cat-file --batch-check --batch-all-objects=

>       Time (mean =C2=B1 =CF=83):     578.7 ms =C2=B1  12.7 ms    [User:=
 553.4 ms, System: 25.2 ms]
>       Range (min =E2=80=A6 max):   568.1 ms =E2=80=A6 600.1 ms    10 ru=
ns
>
>     (with the above)
>     Benchmark 1: git.compile cat-file --batch-check --batch-all-objects=

>       Time (mean =C2=B1 =CF=83):     571.5 ms =C2=B1   7.9 ms    [User:=
 544.0 ms, System: 27.3 ms]
>       Range (min =E2=80=A6 max):   558.8 ms =E2=80=A6 583.2 ms    10 ru=
ns

Thanks for this suggestion and the benchmark! This is similar to what Jun=
io suggested, and
I do think this is the right thing to do here.

>
> Thanks,
> Taylor

Thanks,
John
