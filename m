Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E77ECC4321E
	for <git@archiver.kernel.org>; Mon,  5 Dec 2022 15:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231602AbiLEPMF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Dec 2022 10:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231230AbiLEPME (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Dec 2022 10:12:04 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569071B8
        for <git@vger.kernel.org>; Mon,  5 Dec 2022 07:12:03 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id h15so5194461ilh.12
        for <git@vger.kernel.org>; Mon, 05 Dec 2022 07:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h6U8kQlLE7Um9SCMx2tLb25lnaOmgJRDhFP1AP8iqvw=;
        b=LJY7OedT7ASI5/0FILcv9qEF3glORJgd7rJqKHpNusppi0YvWdF87fE6OetHSFjLbW
         G/BlcYhWnWmLubzXVGIartVMIsHTH8kjkFCoLKVI63JZ8+icH0wH09lDee2UfHkBGCJS
         fbWwyeUjhFTzTfcnqpOKyMzuo5oRksp3jTmf4ST9AuP3awGRLVthCXM4DidENYAoBvL3
         LBXB0b5JmIIsl4wCeuT3da81DaZZkWaxL4mjd+Uj1iCLgVhgKtDlvIS15aHsCRjVtgsv
         JRnfGxPSUxrEY94IJCC3jOzv9n333uJbKdXpcuExnn/M3jp6ZE6lClmTe4XhWc3Opp5B
         6Dqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6U8kQlLE7Um9SCMx2tLb25lnaOmgJRDhFP1AP8iqvw=;
        b=KNH7GY/yiEVDtZOAYTsLoNL1tpD9gx80KGvwaZUHTT0jTLxqariG2h7JutyUJyRdr4
         5FdRnM66La6u16yZs8YVaaNZC84URY0ntHt2gcY91izVQfZganSXpMKDTdipb39re6K/
         uswAxERQaA4OCX9Cv4w4xINtx9sCLDd2sVQpKE/WNduwePnbyj7P4cZEUvThfsz1mEmr
         Rq4e8v/paZnIeyVv1GP8ZbBdLqDVE+pxkyY55mly3rmQkvNtep4cOTAJMF/7k9Udqz1l
         M/4A1yD5FjAtLCtYyzImUiAgJDBDAi1yrHiDpNfLI7mwa/oLgXZgbkvFfPYEuK3faVPC
         Sjiw==
X-Gm-Message-State: ANoB5pkduY2+Wjyx+enSnrBiJt7EZeeJLg5vbi9ivaZaOEOW9rBITAcj
        w046KYzoLaQWZdbdJozFl+Pf
X-Google-Smtp-Source: AA0mqf7YiHs6405g86Hk2vdl2Vf84aOfaueawusEE4Q+mGpdadUkVNkNv9SsPTrMthXUlCUoK8d1pg==
X-Received: by 2002:a92:dcce:0:b0:303:2a0e:c83 with SMTP id b14-20020a92dcce000000b003032a0e0c83mr11849707ilr.136.1670253122621;
        Mon, 05 Dec 2022 07:12:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:be:c88b:ab42:5165? ([2600:1700:e72:80a0:be:c88b:ab42:5165])
        by smtp.gmail.com with ESMTPSA id d10-20020a92ddca000000b00302a52ca9d9sm5265547ilr.74.2022.12.05.07.12.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 07:12:02 -0800 (PST)
Message-ID: <0980dcd4-30eb-4ef4-9369-279abe5ca5a2@github.com>
Date:   Mon, 5 Dec 2022 10:11:59 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v2 6/9] strbuf: introduce strbuf_strip_file_from_path()
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, mjcheetham@outlook.com, steadmon@google.com,
        chooglen@google.com, jonathantanmy@google.com, dyroneteng@gmail.com
References: <pull.1400.git.1667264854.gitgitgadget@gmail.com>
 <pull.1400.v2.git.1668628302.gitgitgadget@gmail.com>
 <7d86852c01513ee131bf993302416f4c881a0bc6.1668628303.git.gitgitgadget@gmail.com>
 <221202.86bkolfwzv.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <221202.86bkolfwzv.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/2/2022 1:32 PM, Ævar Arnfjörð Bjarmason wrote:

>> +size_t strbuf_strip_file_from_path(struct strbuf *buf)
> 
> Nit: Almost every function in this API calls its argument "sb", let's do
> that for new functions.

Sure.

>> +{
>> +	size_t len = buf->len;
>> +	size_t offset = offset_1st_component(buf->buf);
> 
> Mm, isn't the return value of offset_1st_component() a boolean? it's
> just an "is_dir_sep(buf->buf[0])".
> 
> So this works to....
> 
>> +	char *path_sep = find_last_dir_sep(buf->buf + offset);
> 
> ...find the last dir separator starting at either 0 or 1.
> 
> But anyway, what sort of string is this expecting to handle where the
> last dir separator isn't >=1 offset into the string anyway? Shouldn't we
> just exclude the string "/" here? Maybe I'm missing something....

The difference is all about whether or not we start with a slash _and_ no
other slash appears in the path.

 1. "/root-file": offset becomes 1 and path_sep becomes NULL, so the
    length is reduced to offset (1), resulting in "/"
 2. "local-file": offset becomes 0 and path_sep becomes NULL, so the
    length is reduced to offset (0), resulting in ""

Of course, the first case would be the same if we did not set offset to 1
and then path_sep points to that base slash, so the length calculation
results in "/" anyway. That will simplify things.

void strbuf_strip_file_from_path(struct strbuf *sb)
{
	char *path_sep = find_last_dir_sep(sb->buf);
	strbuf_setlen(sb, path_sep ? path_sep - sb->buf + 1 : 0);
}

>> +	strbuf_setlen(buf, path_sep ? path_sep - buf->buf + 1 : offset);
>> +	return len - buf->len;
>> +}
> 
> Urm, so isn't this literally one-byte away from being equivalent to a
> function that's already in the API?:
> strbuf_trim_trailing_dir_sep. I.e. this seems to me to do the same as
> this new function.
> 
> Context manually adjusted so we can see the only difference is the
> "is_dir_sep" v.s. "!is_dir_sep".
> 
> There's a few strbuf functions like that, and we should probably
> generalize the ctype-like test they share into some callback mechanism,
> but in the meantime keeping with the pattern & naming of existing
> functions seems better.

Using callbacks or extra options seems like overkill here.

> I removed the comment because if it's the same then the new function is
> self-documenting. It doesn't matter if the URI ends in a "/" or not, all
> we need to get across is that we're stripping non-dirsep characters from
> the URL, whether it ends in one or not.
> 
> In terms of correctness: The use of is_dir_sep() seems incorrect to me
> here. On Windows won't that end up using is_xplatform_dir_sep(), so
> bundle-uri's behavior will differ there, and we'll support \\-paths as
> well as /-paths, but elsewhere only /-paths.
> 
> Shouldn't this just test "/", not "is_dir_sep()"?

This method is used for file paths, too, so is_dir_sep() is important to
work properly on Windows platforms.

Thanks,
-Stolee

