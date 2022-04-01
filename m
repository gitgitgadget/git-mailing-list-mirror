Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5793BC433F5
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 17:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350132AbiDARdy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 13:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347779AbiDARdx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 13:33:53 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A13223BC0
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 10:32:03 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id pv16so7414294ejb.0
        for <git@vger.kernel.org>; Fri, 01 Apr 2022 10:32:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=I+8aDbkRh/S+QQDXHEOraf7bpqS2RohefG/XHmg27zI=;
        b=eEksMeJuHR10LCHMI1tSI5jY0zQjX231gT4QN5tPJtm4lXOAo0AAcNQO83diuY32ee
         VMvL0xcFAKEwGps5DUhYVOJUWegkQ35V2HkAztWq+Ecadp19vdTi8FZrdKQpSTtoH5h8
         D7Bnaux/Srjh4hPX3YajCd6grtTq54r3F6UiYlcY980Ba4n8EN1+UMxPBFCyXc5Z04jI
         WCVuV7flQZ0M6R4sxjIKcCd7Y4nKjVFedOCkXI3dPrNrdoK9HUByUhWkfRmAE4fbVoLc
         jcoNF98u4l2m84qnK6KqdZ5BqZ/J0T6OUT3hJk50EGA0OB+EvbC2e7Va80uszaTEJC9p
         JlKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=I+8aDbkRh/S+QQDXHEOraf7bpqS2RohefG/XHmg27zI=;
        b=0xKgMdz3g03b0ndJcZzQP8/7ASYcv2s0yQf4auq+dCQ6koDuX37R8lT/5xtLgXXAy9
         AedtfNGYZv0Oy4cSUPI1f7w3wEyjPeQbwbIjZC+uRxdc+N6s6zPqV+N2QXKDOv0IehTz
         +iGuKNX+l0GAqhgyLWttQyWViliyjVHnY3u1hlEguw9gj6a40WnZdDdnwr2YCRp+GPO9
         vloqrITkJS2PKSKZmBQdz7WezxNrHl++7SQByG3S8kvVUiYa56LAovMO3PFa+asPUmBT
         klm07s0n/z4M1ey92bulk67tLBAHGdHUEjHN3P6C2pHHx6iaWek40Os/p+4he2ULtZyB
         oUxQ==
X-Gm-Message-State: AOAM530KVfjR9pFcq2tEhzqkSoWwrCnP8YxhMIROInKkAmkO904SD/jT
        9n9R4h7/NVIZZG+Yz8+QuuuSWVKu24Y=
X-Google-Smtp-Source: ABdhPJwCWsWgJnJFejZHy9NwHIobZviOoLfRLVz+W31u5TIUVoVem7HCWgmI3DS15p4pxP/ReAWArA==
X-Received: by 2002:a17:907:16ac:b0:6e0:1646:9121 with SMTP id hc44-20020a17090716ac00b006e016469121mr828120ejc.194.1648834322015;
        Fri, 01 Apr 2022 10:32:02 -0700 (PDT)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id bd12-20020a056402206c00b00418c9bf71cbsm1363615edb.68.2022.04.01.10.32.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 10:32:01 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1naL7w-001Gjz-Uo;
        Fri, 01 Apr 2022 19:32:00 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Phillip Wood <phillip.wood123@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v4 10/27] stash: always have the owner of "stash_info"
 free it
Date:   Fri, 01 Apr 2022 19:29:05 +0200
References: <cover-v3-00.27-00000000000-20220325T171340Z-avarab@gmail.com>
 <cover-v4-00.27-00000000000-20220331T005325Z-avarab@gmail.com>
 <patch-v4-10.27-145a0f74b6a-20220331T005325Z-avarab@gmail.com>
 <9a487124-ef1e-0644-9585-174343555914@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <9a487124-ef1e-0644-9585-174343555914@gmail.com>
Message-ID: <220401.86zgl4n20f.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Apr 01 2022, Phillip Wood wrote:

> Hi =C3=86var
>
> On 31/03/2022 02:11, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Change the initialization of the "revision" member of "struct
>> stash_info" to be initialized vi a macro, and more importantly that
>> that initializing function be tasked to free it, usually via a "goto
>> cleanup" pattern.
>> Despite the "revision" name (and the topic of the series containing
>> this commit) the "stash info" has nothing to do with the "struct
>> rev_info". I'm making this change because in the subsequent commit
>> when we do want to free the "struct rev_info" via a "goto cleanup"
>> pattern we'd otherwise free() uninitialized memory in some cases, as
>> we only strbuf_init() the string in get_stash_info().
>> So while it's the smallest possible change, let's convert all users
>> of
>> this pattern in the file while we're at it.
>> A good follow-up to this change would be to change all the "ret =3D
>> -1;
>> goto done;" in this file to instead use a "goto cleanup", and
>> initialize "int ret =3D -1" at the start of the relevant functions. That
>> would allow us to drop a lot of needless brace verbosity on two-line
>> "if" statements, but let's leave that alone for now.
>
> You seem to have made this change here.
>
>>[...]
>> @@ -861,10 +863,8 @@ static int show_stash(int argc, const char **argv, =
const char *prefix)
>>   			strvec_push(&revision_args, argv[i]);
>>   	}
>>   -	ret =3D get_stash_info(&info, stash_args.nr, stash_args.v);
>> -	strvec_clear(&stash_args);
>> -	if (ret)
>> -		return -1;
>> +	if (get_stash_info(&info, stash_args.nr, stash_args.v))
>> +		goto cleanup;
>>     	/*
>>   	 * The config settings are applied only if there are not passed
>> @@ -878,8 +878,8 @@ static int show_stash(int argc, const char **argv, c=
onst char *prefix)
>>   			rev.diffopt.output_format |=3D DIFF_FORMAT_PATCH;
>>     		if (!show_stat && !show_patch) {
>> -			free_stash_info(&info);
>> -			return 0;
>> +			ret =3D 0;
>> +			goto cleanup;
>>   		}
>>   	}
>>   @@ -912,8 +912,11 @@ static int show_stash(int argc, const char
>> **argv, const char *prefix)
>>   	}
>>   	log_tree_diff_flush(&rev);
>>   +	ret =3D diff_result_code(&rev.diffopt, 0);;
>> +cleanup:
>> +	strvec_clear(&stash_args);
>
> This seems to be fixing a leak that's not mentioned in the commit message.

This is just moving the exsting strvec_clear() shown above to the
"cleanup" branch, as we change return to "goto cleanup".

>>   	free_stash_info(&info);
>> -	return diff_result_code(&rev.diffopt, 0);
>> +	return ret;
>>   }
>>[...]
>> @@ -1434,7 +1438,7 @@ static int do_push_stash(const struct pathspec *ps=
, const char *stash_msg, int q
>>   			 int keep_index, int patch_mode, int include_untracked, int only_st=
aged)
>>   {
>>   	int ret =3D 0;
>> -	struct stash_info info;
>> +	struct stash_info info =3D STASH_INFO_INIT;
>
> There doesn't seem to be a call to free_stash_info() in this function.

Hrm, I think you're right about that (but it was an existing leak). Will
fix.
