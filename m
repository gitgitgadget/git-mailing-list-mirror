Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC5EC46467
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 18:32:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230323AbjASScb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 13:32:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjASSc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 13:32:26 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAC4E38B
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 10:32:18 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d3so3089897plr.10
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 10:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kKSzg9a6tmGGlH0LfxppcKBC45XBDEbttVEv6320UPo=;
        b=iVDyHpQL9/eG5EhejwlyKA8Dkz4EgEzZ8OHOmvmin/aBlnjLeUu7Feey3NDCt6PFXM
         itXDBgw3eBp7MFcKfAj3ZJZSaoUcIlzWJ1L1mGlw/Q1m0jGWAQmsS+yk8RfKsQaiPfHh
         hQHo/h1kh4Zgln3/gyQNxdM7uCWf+YMpVJdbseK48plvQQmPT8rsvtgdBhd78PPEVIYL
         EN4jjgZpfoSKG3rW/kHFqbC6MMxrGtkUQxjfMcxmeFTlm5CHgnqWAysUr+Z2m+eMc+Eo
         pZSdAOapFzkoNTDyY2x1mwCocZSCU2WvQVhr7yAH9+anvU8NEJ0TtL4O6Cyl6/YcM7pU
         5+JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kKSzg9a6tmGGlH0LfxppcKBC45XBDEbttVEv6320UPo=;
        b=bjCYWiQMzyKRysrw+pbItp22shfYsfh7nX1tHcTBHMMzcgvgAmZKsxOKaRrO+GSZJ4
         txe1+KOYoM0SXDePNH1a43IttxqIWPOPGhET5VtZyHn2rLKteFfiVS5i4bnX+4UlKQ4j
         OCTGXNTYvbDqWBi4UiXvXaiX9sUas35gplk2H3CFfWpxsB8azxr0q+So2y+OShw/9VTJ
         l9VX/8opw38zIhVpqC7hhR+mBRtGHrzibacXh82DNt86ExamlK6cxID7vdYgHk6wqmCB
         i/kfOB1VGwyJCZYYp41fOoCfZxYwsHNE4slFr6Tb8aOpv9FivpC++586UpnUPy1h7Z2c
         k5Jg==
X-Gm-Message-State: AFqh2kqWSDV5IfxjeX5itx8oqCX7t4qRKQGKcgdY0bRjUNsqL4NG+Z4u
        use59FtRHQaKPRdofV85GsLITGR7vx6t+CQ=
X-Google-Smtp-Source: AMrXdXvnFIAb4b92b99dbw0Hxjwb2X1BPBL8BegXut0sxXsOVfjo/dHSIJ170L8sUfh0OvMKWwrhjw==
X-Received: by 2002:a17:902:9343:b0:194:4a2b:d7e4 with SMTP id g3-20020a170902934300b001944a2bd7e4mr12967452plp.17.1674153138042;
        Thu, 19 Jan 2023 10:32:18 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id d6-20020a170902654600b00186b69157ecsm25267798pln.202.2023.01.19.10.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 10:32:17 -0800 (PST)
Message-ID: <ede340d1-bce4-0c1d-7afb-4874a67d1803@github.com>
Date:   Thu, 19 Jan 2023 10:32:13 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 4/8] bundle-uri: download in creationToken order
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <57c0174d3752fb61a05e0653de9d3057616ed16a.1673037405.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <57c0174d3752fb61a05e0653de9d3057616ed16a.1673037405.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> +static int fetch_bundles_by_token(struct repository *r,
> +				  struct bundle_list *list)
> +{
> +	int cur;
> +	int pop_or_push = 0;
> +	struct bundle_list_context ctx = {
> +		.r = r,
> +		.list = list,
> +		.mode = list->mode,
> +	};
> +	struct sorted_bundle_list sorted = {
> +		.alloc = hashmap_get_size(&list->bundles),
> +	};
> +
> +	ALLOC_ARRAY(sorted.items, sorted.alloc);
> +
> +	for_all_bundles_in_list(list, insert_bundle, &sorted);
> +
> +	QSORT(sorted.items, sorted.nr, compare_creation_token);

So, at this point, 'sorted' is ordered by *decreasing* creation token? With
the loop below being somewhat complex, it would be nice to have a comment
mention that explicitly so readers have a clear understanding of the
"initial state" before entering the loop.

> +
> +	/*
> +	 * Use a stack-based approach to download the bundles and attempt
> +	 * to unbundle them in decreasing order by creation token. If we
> +	 * fail to unbundle (after a successful download) then move to the
> +	 * next non-downloaded bundle (push to the stack) and attempt
> +	 * downloading. Once we succeed in applying a bundle, move to the
> +	 * previous unapplied bundle (pop the stack) and attempt to unbundle
> +	 * it again.
> +	 *
> +	 * In the case of a fresh clone, we will likely download all of the
> +	 * bundles before successfully unbundling the oldest one, then the
> +	 * rest of the bundles unbundle successfully in increasing order
> +	 * of creationToken.
> +	 *
> +	 * If there are existing objects, then this process may terminate
> +	 * early when all required commits from "new" bundles exist in the
> +	 * repo's object store.
> +	 */
> +	cur = 0;
> +	while (cur >= 0 && cur < sorted.nr) {
> +		struct remote_bundle_info *bundle = sorted.items[cur];
> +		if (!bundle->file) {
> +			/* Not downloaded yet. Try downloading. */
> +			if (download_bundle_to_file(bundle, &ctx)) {
> +				/* Failure. Push to the stack. */
> +				pop_or_push = 1;
> +				goto stack_operation;

Personally, I find the use of "stack" terminology more confusing than not.
'sorted' isn't really a stack, it's a list with fixed contents being
traversed stepwise with 'cur'. For example, 'pop_or_push' being renamed to
'move_direction' or 'step' something along those lines might more clearly
indicate what's actually happening with 'cur' & 'sorted'.

> +			}
> +
> +			/* We expect bundles when using creationTokens. */
> +			if (!is_bundle(bundle->file, 1)) {
> +				warning(_("file downloaded from '%s' is not a bundle"),
> +					bundle->uri);
> +				break;
> +			}
> +		}
> +
> +		if (bundle->file && !bundle->unbundled) {
> +			/*
> +			 * This was downloaded, but not successfully
> +			 * unbundled. Try unbundling again.
> +			 */
> +			if (unbundle_from_file(ctx.r, bundle->file)) {
> +				/* Failed to unbundle. Push to stack. */
> +				pop_or_push = 1;
> +			} else {
> +				/* Succeeded in unbundle. Pop stack. */
> +				pop_or_push = -1;
> +			}
> +		}
> +
> +		/*
> +		 * Else case: downloaded and unbundled successfully.
> +		 * Skip this by moving in the same direction as the
> +		 * previous step.
> +		 */
> +
> +stack_operation:
> +		/* Move in the specified direction and repeat. */
> +		cur += pop_or_push;
> +	}

After reading through this loop, I generally understood *what* its doing,
but didn't really follow *why* the download & unbundling is done like this.
I needed to refer back to the design doc
('Documentation/technical/bundle-uri.txt') to understand some basic
assumptions about bundles:

- A new bundle's creation token should always be strictly greater than the
  previous newest bundle's creation token. I don't see any special handling
  for equal creation tokens, so my assumption is that the sorting of the
  list arbitrarily assigns one to be "greater" and it's dealt with that way.
- The bundle with the lowest creation token should always be unbundleable,
  since it contains all objects in an initial clone.

I do still have some questions, though:

- Why would 'unbundle_from_file()' fail? From context clues, I'm guessing it
  fails if it has some unreachable objects (as in an incremental bundle), or
  if it's corrupted somehow.
- Why would 'download_bundle_to_file()' to fail? Unlike
  'unbundle_from_file()', it looks like that represents an unexpected error.

Also - it seems like one of the assumptions here is that, if a bundle can't
be downloaded & unbundled, no bundle with a higher creation token can be
successfully unbundled ('download_bundle_to_file()' sets 'pop_or_push' to
'1', which will cause the loop to ignore all higher-token bundles and return
a nonzero value from the function). 

I don't think that assumption is necessarily true, though. Suppose you have
a "base" bundle 100 and incremental bundles 101 and 102. 101 has all objects
from a new branch A, and 102 has all objects from a newer branch B (not
based on any objects in A). In this case, 102 could be unbundled even if 101
is corrupted/can't be downloaded, but we'd run into issues if we store 102
as the "latest unbundled creation token" (because it implies that 101 was
unbundled).

Is there any benefit to trying to unbundle those higher bundles *without*
advancing the "latest creation token"? E.g. in my example, unbundle 102 but
store '100' as the latest creation token?

> diff --git a/t/t5558-clone-bundle-uri.sh b/t/t5558-clone-bundle-uri.sh
> index 328caeeae9a..d7461ec907e 100755
> --- a/t/t5558-clone-bundle-uri.sh
> +++ b/t/t5558-clone-bundle-uri.sh
> @@ -368,6 +368,8 @@ test_expect_success 'clone bundle list (HTTP, any mode)' '
>  '
>  
>  test_expect_success 'clone bundle list (http, creationToken)' '
> +	test_when_finished rm -f trace*.txt &&
> +
>  	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
>  	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
>  	[bundle]
> @@ -392,10 +394,45 @@ test_expect_success 'clone bundle list (http, creationToken)' '
>  		creationToken = 4
>  	EOF
>  
> -	git clone --bundle-uri="$HTTPD_URL/bundle-list" . clone-list-http-2 &&
> +	GIT_TRACE2_EVENT=$(pwd)/trace-clone.txt \
> +	git clone --bundle-uri="$HTTPD_URL/bundle-list" \
> +		clone-from clone-list-http-2 &&
>  
>  	git -C clone-from for-each-ref --format="%(objectname)" >oids &&
> -	git -C clone-list-http-2 cat-file --batch-check <oids
> +	git -C clone-list-http-2 cat-file --batch-check <oids &&
> +
> +	for b in 1 2 3 4
> +	do
> +		test_bundle_downloaded bundle-$b.bundle trace-clone.txt ||
> +			return 1
> +	done

If I understand correctly, these added conditions would have passed even if
they were added when the test was initially created in patch 1, but they're
added here to tie them to the implementation of the creationToken heuristic?
Seems reasonable.

> +'
> +
> +test_expect_success 'clone bundle list (http, creationToken)' '

This new test has the same name as the one above it - how does it differ
from that one? Whatever the difference is, can that be noted somehow in the
title or a comment?

> +	test_when_finished rm -f trace*.txt &&
> +
> +	cp clone-from/bundle-*.bundle "$HTTPD_DOCUMENT_ROOT_PATH/" &&
> +	cat >"$HTTPD_DOCUMENT_ROOT_PATH/bundle-list" <<-EOF &&
> +	[bundle]
> +		version = 1
> +		mode = all
> +		heuristic = creationToken
> +
> +	[bundle "bundle-1"]
> +		uri = bundle-1.bundle
> +		creationToken = 1
> +
> +	[bundle "bundle-2"]
> +		uri = bundle-2.bundle
> +		creationToken = 2
> +	EOF
> +
> +	GIT_TRACE2_EVENT=$(pwd)/trace-clone.txt \
> +	git clone --bundle-uri="$HTTPD_URL/bundle-list" \
> +		clone-from clone-token-http &&
> +
> +	test_bundle_downloaded bundle-1.bundle trace-clone.txt &&
> +	test_bundle_downloaded bundle-2.bundle trace-clone.txt
>  '
>  
>  # Do not add tests here unless they use the HTTP server, as they will
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 1928ea1dd7c..57476b6e6d7 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -831,6 +831,56 @@ test_expect_success 'auto-discover multiple bundles from HTTP clone' '
>  	grep -f pattern trace.txt
>  '
>  
> +# Usage: test_bundle_downloaded <bundle-id> <trace-filename>
> +test_bundle_downloaded () {
> +	cat >pattern <<-EOF &&
> +	"event":"child_start".*"argv":\["git-remote-https","$HTTPD_URL/$1.bundle"\]
> +	EOF
> +	grep -f pattern "$2"
> +}

This function is the same as the one created in 't5558'. Should it be moved
to 'lib-bundle.sh' or 'test-lib.sh' to avoid duplicate code?

> +
> +test_expect_success 'auto-discover multiple bundles from HTTP clone: creationToken heuristic' '
> +	test_when_finished rm -rf "$HTTPD_DOCUMENT_ROOT_PATH/repo4.git" &&
> +	test_when_finished rm -rf clone-heuristic trace*.txt &&
> +
> +	test_commit -C src newest &&
> +	git -C src bundle create "$HTTPD_DOCUMENT_ROOT_PATH/newest.bundle" HEAD~1..HEAD &&
> +	git clone --bare --no-local src "$HTTPD_DOCUMENT_ROOT_PATH/repo4.git" &&
> +
> +	cat >>"$HTTPD_DOCUMENT_ROOT_PATH/repo4.git/config" <<-EOF &&
> +	[uploadPack]
> +		advertiseBundleURIs = true
> +
> +	[bundle]
> +		version = 1
> +		mode = all
> +		heuristic = creationToken
> +
> +	[bundle "everything"]
> +		uri = $HTTPD_URL/everything.bundle
> +		creationtoken = 1
> +
> +	[bundle "new"]
> +		uri = $HTTPD_URL/new.bundle
> +		creationtoken = 2
> +
> +	[bundle "newest"]
> +		uri = $HTTPD_URL/newest.bundle
> +		creationtoken = 3
> +	EOF
> +
> +	GIT_TRACE2_EVENT="$(pwd)/trace-clone.txt" \
> +		git -c protocol.version=2 \
> +		    -c transfer.bundleURI=true clone \
> +		"$HTTPD_URL/smart/repo4.git" clone-heuristic &&
> +
> +	# We should fetch all bundles
> +	for b in everything new newest
> +	do
> +		test_bundle_downloaded $b trace-clone.txt || return 1
> +	done
> +'
> +
>  # DO NOT add non-httpd-specific tests here, because the last part of this
>  # test script is only executed when httpd is available and enabled.
>  

