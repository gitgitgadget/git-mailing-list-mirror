Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83138C4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 17:49:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62D79613D2
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 17:49:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238457AbhHXRuR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 13:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241973AbhHXRt0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 13:49:26 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30C6C014AFB
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 10:09:05 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id x10-20020a056830408a00b004f26cead745so47963565ott.10
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 10:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ajTzH7El8R1fBEkpVfeJ7hjiJkuqZFLZf1wlvkm3gqU=;
        b=hhcYi6F4EwiL9Gc55HEVDc0bWyEVa2WpOGBEy3iODftRRyXsoL3582W0kTenXLpi8D
         zZbi5LajoivnfvuiW7C3D1ag8UyhM7Qwgvbaiy0V8Nn7uVKKtarySuMzPzxLWW5BhbSJ
         9H+jjQFhp9p30t9hqxd0vw8MnFglp2gmLn5p3d41dSmYXHOnJodeOKXhK9LpfWh8/C5r
         oRfJfGWSdOuTAkrKYRhsfTui34vEJm7FgEaS26gSEANopfrpHOzILOxINwBpHRm/JqxW
         ZwmvGm+9yS/flKLgNaIAGM1fjaCh7+oMJicupYfzRfEoAmiI6t2Lmp/M+XCdx5dYoNXO
         8zLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ajTzH7El8R1fBEkpVfeJ7hjiJkuqZFLZf1wlvkm3gqU=;
        b=CHi8MnBsPDTSbDPFTC4KLt01LxC0fYwPHrYS+Sr++seiUowDnRHG3TMQRad6FcSxRU
         NITFu66z3nlgFo6SLi1ftCWKliVEFomo2qlDwg9g03qny9kfXIE6ji0hwb4zKMXyzbO+
         ZkXxTpzjXkeomD4HnNFDB/8vmuHaTxLSkq3WeHK3KTsGLrz2t5Lpjuuhx26vPvxP5BJk
         /OlJL87y6DC7kGZoat4xFJHwtzwM3awHnLnNV3vQBMbEROq/2wpQOvL/hxFRrtWjnLPh
         K7ORcWBjuYXQmC8JXK1VJiguTuoxRP534uzM6vRkQSUcPyR53ifIi0v4cFPm0uv1fgi5
         YLuw==
X-Gm-Message-State: AOAM531yR1FKAEVurcHHR2w6u49z4SsccDnq8UjR1LBvQQeI3nyZ/X6X
        Nm2asZMQWh55vNLCTNPWhLI=
X-Google-Smtp-Source: ABdhPJx5p2WHvk2XZfT0OAN6byFTfL0vmH12CLff3aKAq4szYHL+8lkNQaDYz7ypAx79hauOGBdl/g==
X-Received: by 2002:aca:af0d:: with SMTP id y13mr3546223oie.161.1629824944845;
        Tue, 24 Aug 2021 10:09:04 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:3cc8:64de:6d4:4ca6? ([2600:1700:e72:80a0:3cc8:64de:6d4:4ca6])
        by smtp.gmail.com with ESMTPSA id 7sm4608438oth.69.2021.08.24.10.09.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Aug 2021 10:09:04 -0700 (PDT)
Subject: Re: [PATCH v2 2/4] bundle API: change "flags" to be
 "extra_index_pack_args"
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <cover-0.4-0000000000-20210727T004015Z-avarab@gmail.com>
 <cover-v2-0.4-00000000000-20210823T110136Z-avarab@gmail.com>
 <patch-v2-2.4-3d7bd9c33be-20210823T110136Z-avarab@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <30620e13-4509-1905-7644-9962b6adf9c5@gmail.com>
Date:   Tue, 24 Aug 2021 13:09:02 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <patch-v2-2.4-3d7bd9c33be-20210823T110136Z-avarab@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/23/2021 7:02 AM, Ævar Arnfjörð Bjarmason wrote:
...
> --- a/builtin/bundle.c
> +++ b/builtin/bundle.c
> @@ -165,7 +165,8 @@ static int cmd_bundle_unbundle(int argc, const char **argv, const char *prefix)
>  	struct option options[] = {
>  		OPT_END()
>  	};
> -	char *bundle_file;
> +	char* bundle_file;

nit: errant movement of "*" here.

> +	struct strvec extra_args = STRVEC_INIT;
...
> -	ret = !!unbundle(the_repository, &header, bundle_fd, 0) ||
> +	ret = !!unbundle(the_repository, &header, bundle_fd, &extra_args) ||

I'm assuming that you will be adding something that adds to extra_args
in a future commit. It might be better to just convert the "0" to "NULL"
here and add extra_args when you actually use it.

>  int unbundle(struct repository *r, struct bundle_header *header,
> -	     int bundle_fd, int flags)
> +	     int bundle_fd, struct strvec *extra_index_pack_args)
>  {
> -	const char *argv_index_pack[] = {"index-pack",
> -					 "--fix-thin", "--stdin", NULL, NULL};
>  	struct child_process ip = CHILD_PROCESS_INIT;
> +	int i;
>  
> -	if (flags & BUNDLE_VERBOSE)
> -		argv_index_pack[3] = "-v";
> +	strvec_push(&ip.args, "index-pack");
> +	strvec_push(&ip.args, "--fix-thin");
> +	strvec_push(&ip.args, "--stdin");
> +	if (extra_index_pack_args) {
> +		struct strvec *extra = extra_index_pack_args;

Creating a shorter variable name seems unnecessary.

> +		for (i = 0; i < extra->nr; i++)
> +			strvec_push(&ip.args, extra->v[i]);

This seems like a good opportunity to create and use a
strvec_concat() method.

> +		strvec_clear(extra_index_pack_args);

Why is it the responsibility of this method to clear these args?
I suppose it is convenient. It just seems a bit wrong to me.

>  /**
>   * Unbundle after reading the header with read_bundle_header().
>   *
>   * We'll invoke "git index-pack --stdin --fix-thin" for you on the
>   * provided `bundle_fd` from read_bundle_header().
> + *
> + * Provide extra_index_pack_args to pass any extra arguments
> + * (e.g. "-v" for verbose/progress), NULL otherwise. The provided
> + * extra_index_pack_args (if any) will be strvec_clear()'d for you
> + * (like the run-command.h API itself does).
>   */
>  int unbundle(struct repository *r, struct bundle_header *header,
> -	     int bundle_fd, int flags);
> +	     int bundle_fd, struct strvec *extra_index_pack_args);
>  int list_bundle_refs(struct bundle_header *header,
>  		int argc, const char **argv);
>  
> diff --git a/transport.c b/transport.c
> index 17e9629710a..8bc4b5fcd3c 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -162,12 +162,15 @@ static int fetch_refs_from_bundle(struct transport *transport,
>  			       int nr_heads, struct ref **to_fetch)
>  {
>  	struct bundle_transport_data *data = transport->data;
> +	struct strvec extra_index_pack_args = STRVEC_INIT;
>  	int ret;
>  
> +	strvec_push(&extra_index_pack_args, "-v");
> +
>  	if (!data->get_refs_from_bundle_called)
>  		get_refs_from_bundle(transport, 0, NULL);
>  	ret = unbundle(the_repository, &data->header, data->fd,
> -			   transport->progress ? BUNDLE_VERBOSE : 0);

Previously, this was conditioned on 'transport->progress', but above
you unconditionally add the "-v" option. Seems like a bug.

> +		       &extra_index_pack_args);

Thanks,
-Stolee
