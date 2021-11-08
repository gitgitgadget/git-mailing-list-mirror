Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB167C433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:01:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE2DC619BB
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 23:01:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240715AbhKHXEA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 18:04:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238462AbhKHXD7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 18:03:59 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BE5C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 15:01:14 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id x25-20020aa79199000000b0044caf0d1ba8so11573559pfa.1
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 15:01:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=wCHXw72RXfFTeNf5K01iS20u5BdtdTkSl45qI68w3gk=;
        b=THHwDNeGtq/4U/YZva4jsyTHO9lPpQgFCZBvxfKuTgNfAIfuHsB5zwGoQUrCZU6HC7
         zEN31B7EMeWx2q5+mHlKDfyT4aWLlhtupcsbjO/UR4+a251QGivWWtmlpSCHU4R4e5o+
         F2LWBcRT0eZwbAIM0epZD31QcCnsbxrRlFPOfqL+rd8ESZ0uCci9VNCcdVxDCHfHQiFQ
         +GMhWJQje8+tHfNvwdrR4z04Y8fETvAL0s6X1rteNTXR2Imx1BNalV+u/L6FP0iUoww+
         XmCu4Y71ev/SWMrwb0DJC3dv3+AujuG4CpjQYhtvOK6WGE3Obq/sRTOFG+vMFibZd/eD
         8zTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=wCHXw72RXfFTeNf5K01iS20u5BdtdTkSl45qI68w3gk=;
        b=QMHyiiIpP+QyH3blwoW/gCXlLUFXvZo9xuFIYbpO5p7EC1yzOrMlfAVJjJ7Typ7ZcO
         bNeT4hKgZnwrSki9tn/wHDisIiZhUprml/S8S43s55QooIMQsHab5Bfu6jPtNhaNppc3
         Ud6dw4ulNcl1E1kaA9QWEuXyXVq3eUtOxUoNyG7Ujwty2m52FECYN5z4OrdT85ZhTz90
         F1Vl+/AkARw9ZHxkZJBXxd/N/jSKuS08enzLLbXqN2MGDeDTNyhw/UmRHgeuJ5XsL1Q7
         AB1QWSJG/niwDquaTPQ0Sv1jHf9BbW5FQBkcEdTHOZGBhAGbhDUgPkSXy2tzBdc2rgSs
         SjMQ==
X-Gm-Message-State: AOAM533Alc7wJDpe5e8kqczBJPvwjim/ZQNxIP/Rkb3CU1C26tJx9dH4
        t1AmRlHAv1N/NMaY5jIrCaRbnsXQMTRFCIdi3AYM
X-Google-Smtp-Source: ABdhPJwREdUEPvGKHKxNKKaVprFQC7AncvEuTwQcUMMSA6+H84OLm2+X0CPvumCAikCietVUBWS5dlxtRE9SGOJGqehZ
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:c412:b0:141:f710:2a94 with
 SMTP id k18-20020a170902c41200b00141f7102a94mr2439443plk.1.1636412473866;
 Mon, 08 Nov 2021 15:01:13 -0800 (PST)
Date:   Mon,  8 Nov 2021 15:01:11 -0800
In-Reply-To: <a6098f98946bd9cc1186ab9c83d917566c78b805.1635532975.git.gitgitgadget@gmail.com>
Message-Id: <20211108230111.1101434-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <a6098f98946bd9cc1186ab9c83d917566c78b805.1635532975.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.34.0.rc0.344.g81b53c2807-goog
Subject: Re: [PATCH v6 1/2] fetch-pack: redact packfile urls in traces
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, avarab@gmail.com, sunshine@sunshineco.com,
        ifrade@google.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> diff --git a/fetch-pack.c b/fetch-pack.c
> index a9604f35a3e..62ea90541c5 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -1653,8 +1653,12 @@ static struct ref *do_fetch_pack_v2(struct fetch_pack_args *args,
>  				receive_wanted_refs(&reader, sought, nr_sought);
>  
>  			/* get the pack(s) */
> +			if (git_env_bool("GIT_TRACE_REDACT", 1))
> +				reader.options |= PACKET_READ_REDACT_URI_PATH;
>  			if (process_section_header(&reader, "packfile-uris", 1))
>  				receive_packfile_uris(&reader, &packfile_uris);
> +			reader.options &= ~PACKET_READ_REDACT_URI_PATH;

Probably worth commenting why you're resetting the flag (avoid the
relatively expensive URI check when we don't need it).

> diff --git a/pkt-line.c b/pkt-line.c
> index 2dc8ac274bd..5a69ddc2e77 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -370,6 +370,31 @@ int packet_length(const char lenbuf_hex[4])
>  	return (val < 0) ? val : (val << 8) | hex2chr(lenbuf_hex + 2);
>  }
>  
> +static char *find_packfile_uri_path(const char *buffer)
> +{
> +	const char *URI_MARK = "://";
> +	char *path;
> +	int len;
> +
> +	/* First char is sideband mark */
> +	buffer += 1;
> +
> +	len = strspn(buffer, "0123456789abcdefABCDEF");
> +	if (len != (int)the_hash_algo->hexsz || buffer[len] != ' ')
> +		return NULL; /* required "<hash>SP" not seen */

Optional: As I said in my reply (just sent out), checking for both SHA-1
and SHA-256 lengths is reasonable too.

[1] https://lore.kernel.org/git/20211108224335.569596-1-jonathantanmy@google.com/

> diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
> index d527cf6c49f..f01af2f2ed3 100755
> --- a/t/t5702-protocol-v2.sh
> +++ b/t/t5702-protocol-v2.sh
> @@ -1107,6 +1107,57 @@ test_expect_success 'packfile-uri with transfer.fsckobjects fails when .gitmodul
>  	test_i18ngrep "disallowed submodule name" err
>  '
>  
> +test_expect_success 'packfile-uri path redacted in trace' '
> +	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> +	rm -rf "$P" http_child log &&
> +
> +	git init "$P" &&
> +	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
> +
> +	echo my-blob >"$P/my-blob" &&
> +	git -C "$P" add my-blob &&
> +	git -C "$P" commit -m x &&
> +
> +	git -C "$P" hash-object my-blob >objh &&
> +	git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
> +	git -C "$P" config --add \
> +		"uploadpack.blobpackfileuri" \
> +		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
> +
> +	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \

No need for GIT_TRACE=1 since you're not checking stdout. Also I don't
think GIT_TEST_SIDEBAND_ALL=1 is needed - we should check that it works
even without a test variable (and I've checked and it seems to work).

[snip]

> +test_expect_success 'packfile-uri path not redacted in trace when GIT_TRACE_REDACT=0' '
> +	P="$HTTPD_DOCUMENT_ROOT_PATH/http_parent" &&
> +	rm -rf "$P" http_child log &&
> +
> +	git init "$P" &&
> +	git -C "$P" config "uploadpack.allowsidebandall" "true" &&
> +
> +	echo my-blob >"$P/my-blob" &&
> +	git -C "$P" add my-blob &&
> +	git -C "$P" commit -m x &&
> +
> +	git -C "$P" hash-object my-blob >objh &&
> +	git -C "$P" pack-objects "$HTTPD_DOCUMENT_ROOT_PATH/mypack" <objh >packh &&
> +	git -C "$P" config --add \
> +		"uploadpack.blobpackfileuri" \
> +		"$(cat objh) $(cat packh) $HTTPD_URL/dumb/mypack-$(cat packh).pack" &&
> +
> +	GIT_TRACE=1 GIT_TRACE_PACKET="$(pwd)/log" GIT_TEST_SIDEBAND_ALL=1 \

Same comment here.
