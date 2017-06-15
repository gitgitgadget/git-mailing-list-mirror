Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49B7F20401
	for <e@80x24.org>; Thu, 15 Jun 2017 18:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752681AbdFOSeu (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 14:34:50 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35990 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751803AbdFOSes (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 14:34:48 -0400
Received: by mail-pg0-f67.google.com with SMTP id v18so2514916pgb.3
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 11:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=INw6f/6AfKwz38zIxawZDyGsVRjBgytFKUjIcu09/xk=;
        b=ZUgoe2oPQTT1HXYsK4dZnfUnX9Pk75ISvr8wA2/Y4KMuUrJ+pNGs63BSwIcarJmJrg
         wqL04XoUmVxQs0BLI2gJnkkBKc5szJm1yhq/bG2q3glY53HD0x2Hrm3k6+3kerpDFoid
         +m2xu9C2F2uHEF8O1EL/DPAkWdqpFY5ZB6gpu4aEhdwNQjl3A9890j0CSjHbyv9qEpB4
         yjlJCxZ6EOZkrrTxrdo/MYns+HTVW3um85Jv5azVzlgO9m9fzXN2yulxh01YaIpmj4gu
         p2AQh7vbRgC4rHQa/YaVn48KkUi/uSLjMUl2ddPVDu0gCmr1BgraZj8NSzp27BPTqiE5
         1i7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=INw6f/6AfKwz38zIxawZDyGsVRjBgytFKUjIcu09/xk=;
        b=sotxq4Y43oENWBu+ukwBGZA5g8aTKZ/29Hs01H+zg75bm3FnmiObgQCBDp88z+x4rG
         tIAe3bxc4SLhihoTgm/mN6Ke/AQfLj7V4yooJYkMwNaBeUIkAMADiR+vDv2edBepblvv
         UytSmM/fVQTFIsLYOLK9yk8okeEvfBIahydfKrt40ICeqbLWmkMKdrfMpdUv/RtQRi8e
         IIAnYLcH5Rgk23IkFhsOcorqS3GD+MPX/wrdh/thlw3I49bfCLFdhp6GHVKymoQV/KHp
         JZIZkE5hgsqlne/5fA4+ZW3WQxDmaYbnxThPaK3pZvlmrmhfFeC+r9Ew01RuYcxNke/v
         QjQA==
X-Gm-Message-State: AKS2vOyx1GFZRE4pBlr14apeR7A4RO5elbmyA/467hvqJolFe5uMTght
        DiL3geldVZp0HA==
X-Received: by 10.99.113.74 with SMTP id b10mr6660703pgn.139.1497551687154;
        Thu, 15 Jun 2017 11:34:47 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id r85sm1559436pfd.100.2017.06.15.11.34.46
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 11:34:46 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v2 4/4] sha1_file, fsck: add missing blob support
References: <cover.1497387713.git.jonathantanmy@google.com>
        <cover.1497035376.git.jonathantanmy@google.com>
        <cover.1497387713.git.jonathantanmy@google.com>
        <aa3904dbe16050188a6b70a209bfcbfa86ea3213.1497387714.git.jonathantanmy@google.com>
Date:   Thu, 15 Jun 2017 11:34:45 -0700
In-Reply-To: <aa3904dbe16050188a6b70a209bfcbfa86ea3213.1497387714.git.jonathantanmy@google.com>
        (Jonathan Tan's message of "Tue, 13 Jun 2017 14:06:00 -0700")
Message-ID: <xmqqy3st14my.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> diff --git a/sha1_file.c b/sha1_file.c
> index 98086e21e..75fe2174d 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -27,6 +27,9 @@
>  #include "list.h"
>  #include "mergesort.h"
>  #include "quote.h"
> +#include "iterator.h"
> +#include "dir-iterator.h"
> +#include "sha1-lookup.h"
>  
>  #define SZ_FMT PRIuMAX
>  static inline uintmax_t sz_fmt(size_t s) { return s; }
> @@ -1624,6 +1627,72 @@ static const struct packed_git *has_packed_and_bad(const unsigned char *sha1)
>  	return NULL;
>  }
>  
> +struct missing_blob_manifest {
> +	struct missing_blob_manifest *next;
> +	const char *data;
> +};
> +struct missing_blob_manifest *missing_blobs;
> +int missing_blobs_initialized;

I do not think you meant to make these non-static.  The type of the
former is not even visible to the outside world, and the latter is
something that could be made into static to prepare_missing_blobs()
function (unless and until you start allowing the missing-blobs
manifest to be re-initialized).  Your ensure_configured() below
seems to do the "static" right, on the other hand ;-).

Do we expect that we will have only a handful of these missing blob
manifests?  Each manifest seems to be efficiently looked-up with a
binary search, but it makes me wonder if it is a good idea to
consolidate these manifests into a single list of object names to
eliminate the outer loop in has_missing_blob().  Unlike pack .idx
files that must stay one-to-one with .pack files, it appears to me
that there is no reason why we need to keep multiple ones separate
for extended period of time (e.g. whenever we learn that we receieved
an incomplete pack from the other side with a list of newly missing
blobs, we could incorporate that into existing missing blob list).

> +int has_missing_blob(const unsigned char *sha1, unsigned long *size)
> +{

This function that answers "is it expected to be missing?" is
confusingly named.  Is it missing, or does it exist?

> @@ -2981,11 +3050,55 @@ static int sha1_loose_object_info(const unsigned char *sha1,
>  	return (status < 0) ? status : 0;
>  }
>  
> +static char *missing_blob_command;
> +static int sha1_file_config(const char *conf_key, const char *value, void *cb)
> +{
> +	if (!strcmp(conf_key, "core.missingblobcommand")) {
> +		missing_blob_command = xstrdup(value);
> +	}
> +	return 0;
> +}
> +
> +static int configured;
> +static void ensure_configured(void)
> +{
> +	if (configured)
> +		return;

Do not be selfish and pretend that this is the _only_ kind of
configuration that needs to be done inside sha1_file.c.  Call the
function ensure_<something>_is_configured() and rename the run-once
guard to match.

The run-once guard can be made static to the "ensure" function, and
if you do so, then its name can stay to be "configured", as at that
point it is clear what it is guarding.

> diff --git a/t/t3907-missing-blob.sh b/t/t3907-missing-blob.sh
> new file mode 100755
> index 000000000..e0ce0942d
> --- /dev/null
> +++ b/t/t3907-missing-blob.sh
> @@ -0,0 +1,69 @@
> +#!/bin/sh
> +
> +test_description='core.missingblobcommand option'
> +
> +. ./test-lib.sh
> +
> +pack() {

Style: "pack () {"

> +	perl -e '$/ = undef; $input = <>; print pack("H*", $input)'

high-nybble first to match ntohll() done in has_missing_blob()?  OK.

> +}
> +
> +test_expect_success 'sha1_object_info_extended and read_sha1_file (through git cat-file -p)' '
> +	rm -rf server client &&
> +
> +	git init server &&
> +	test_commit -C server 1 &&
> +	test_config -C server uploadpack.allowanysha1inwant 1 &&
> +	HASH=$(git hash-object server/1.t) &&
> +
> +	git init client &&
> +	test_config -C client core.missingblobcommand \
> +		"git -C \"$(pwd)/server\" pack-objects --stdout | git unpack-objects" &&
> +
> +	# does not work if missing blob is not registered
> +	test_must_fail git -C client cat-file -p "$HASH" &&
> +
> +	mkdir -p client/.git/objects/missing &&
> +	printf "%016x%s%016x" 1 "$HASH" "$(wc -c <server/1.t)" |
> +		pack >client/.git/objects/missing/x &&
> +
> +	# works when missing blob is registered
> +	git -C client cat-file -p "$HASH"
> +'

OK, by passing printf '%016x', implementations of "$(wc -c)" that
gives extra whitespace around its output can still work correctly.
Good.
