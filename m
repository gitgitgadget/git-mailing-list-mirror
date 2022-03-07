Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 295CDC433EF
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 14:48:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240363AbiCGOtb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 09:49:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236508AbiCGOta (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 09:49:30 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0793134E
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 06:48:35 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id i5so15412875oih.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 06:48:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ngA2P47JlKncDX8RW0Z4R8pTJuUu4xsMf8S84PYpXfc=;
        b=W5kezCFTwbNim3744g86l5KEkcfp/Ajlhvz5EUHnwcGfD2YmaQhr2zVI8/By0OcH8R
         rN6ZvtFNqjpQ6rh9Uyp0KwQvWcpUmtedftalTK9+41kb4xnlY82300htcTC2BMR8AAH2
         DL9Hus83DaiSwhpGQVadcoDuoNYLU3TNp/qfkDQbcvMW2+O22wwtH/z5hDJZyGo8WU9w
         ur4PwfQO1zsG8tDxs7YRsiYTd5CcMuJEZX+Z8cj6sAHJkdIUBPr75vgD8lda5ai7BPhS
         Pv2KKSDPFz4A0qvHdkyQaV6FME++f6VGoQc14+zXWY6Vrb2umYj9Xqj8M1qaTWBrTWpU
         ToDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ngA2P47JlKncDX8RW0Z4R8pTJuUu4xsMf8S84PYpXfc=;
        b=XIyTYUHsL6YDZ52zrpMy7rbxDN5dmqCKqxufpBFMMNEXBpMafNS1s6FTBdFPx6jjuN
         NBTopFqT1t0OPz4Q9DErVuWAs1Vtk7cE3BHQm1iwVEGtEVS274f9bwlzb1kg8I2kB8ps
         Y4IDf3LvebNTkiesqViAuDxslnrcqxKJXB3j0jNMromkPs7cDZYUlenTLF2xYUzyw3G+
         Ru4fbW7VV+quok98C9s4CuIr6sHaV6tTk9i5AJTZ+OZmPPzy99eylzZyZSNLb5rF79ZX
         6Vo/Vw8JRH/DeNvcu4p6bTBmhEJlrTfqzQlBdyNtfGr/59MgiIoy2K3IaRiGA9cvTIcP
         UCAw==
X-Gm-Message-State: AOAM531J+RqD8RwYiUg4goxhFqPNxYZoHkewiCE+9PDPWdVIjQMpRx32
        QUbrO+j/gE4fFCwY0nTen2ga
X-Google-Smtp-Source: ABdhPJx8KIDMKZqaUTqI2yQqv0MYo0GsUPNL8xplJ8h//zuRAMK3/nu9x5KM0bfNgf4t35+vDh1NNA==
X-Received: by 2002:aca:de8b:0:b0:2cf:5b:be98 with SMTP id v133-20020acade8b000000b002cf005bbe98mr18045106oig.170.1646664514606;
        Mon, 07 Mar 2022 06:48:34 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id g18-20020a9d6c52000000b005af7c7cb702sm6046654otq.34.2022.03.07.06.48.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 06:48:34 -0800 (PST)
Message-ID: <ee6c7a5b-63e8-af1c-fdb7-75dca9cd798d@github.com>
Date:   Mon, 7 Mar 2022 09:48:33 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 11/11] bundle: unbundle promisor packs
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <ec51d0a50e6e64ae37795d77f7d33204b9b71ecd.1645638911.git.gitgitgadget@gmail.com>
 <xmqqzgm5wafu.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqzgm5wafu.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/4/2022 6:43 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>>
>> In order to have a valid pack-file after unbundling a bundle that has
>> the 'filter' capability, we need to generate a .promisor file. The
>> bundle does not promise _where_ the objects can be found, but we can
>> expect that these bundles will be unbundled in repositories with
>> appropriate promisor remotes that can find those missing objects.
> 
> That sounds like a lot of wishful thinking, but I do not think of a
> better way to phrase the idea.  Taking a bundle out of a repository
> and unbundling it elsewhere is "git fetch" that could be done to
> send objects from the former to the latter repository, so I am OK
> with the assumption that the original repository will stay available
> for such users who took its contents over sneaker-net instead of
> over the wire.

As an aside, I'm also concerned about the existing model of promisor
remotes where it depends on each remote, and isn't a repository-wide
state. In particular, if I do a blobless partial clone of git/git and
then add git-for-windows/git as a remote and fetch it, it will break
because git-for-windows/git isn't set up as a promisor remote and we
expect to have every blob reachable from its pack-file (even though
it was not sent because we advertised a commit that can reach it).

I've been thinking about adjusting the config parsing around promisors
to say "I see one promisor remote, so I will assume all remotes are
promisors." It seems to me that this will fix cases like the above
without further breaking any cases (that are not already broken).

But that's a tangent for another time. :)
 
>> Use the 'git index-pack --promisor=<message>' option to create this
>> .promisor file. Add "from-bundle" as the message to help anyone diagnose
>> issues with these promisor packs.
>>
>> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
>> ---
>>  bundle.c               | 4 ++++
>>  t/t6020-bundle-misc.sh | 8 +++++++-
>>  2 files changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/bundle.c b/bundle.c
>> index e284ef63062..3d97de40ef0 100644
>> --- a/bundle.c
>> +++ b/bundle.c
>> @@ -631,6 +631,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
>>  	struct child_process ip = CHILD_PROCESS_INIT;
>>  	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
>>  
>> +	/* If there is a filter, then we need to create the promisor pack. */
>> +	if (header->filter)
>> +		strvec_push(&ip.args, "--promisor=from-bundle");
>> +
>>  	if (extra_index_pack_args) {
>>  		strvec_pushv(&ip.args, extra_index_pack_args->v);
>>  		strvec_clear(extra_index_pack_args);
>> diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
>> index 39cfefafb65..344af34db1e 100755
>> --- a/t/t6020-bundle-misc.sh
>> +++ b/t/t6020-bundle-misc.sh
>> @@ -513,7 +513,13 @@ do
>>  		The bundle uses this filter: $filter
>>  		The bundle records a complete history.
>>  		EOF
>> -		test_cmp expect actual
>> +		test_cmp expect actual &&
>> +
>> +		# This creates the first pack-file in the
>> +		# .git/objects/pack directory. Look for a .promisor.
>> +		git bundle unbundle partial.bdl &&
>> +		ls .git/objects/pack/pack-*.promisor >promisor &&
>> +		test_line_count = 1 promisor
> 
> OK.  Do we also want to inspect the contents of the resulting
> repository to make sure that the bundle had the right contents?
> 
> One idea to do so would probably be
> 
>  - prepare a test repository (you already have it)
>  - prepare a partial.bdl (you already do this)
> 
>  - clone the test repository into a new repository, with the same
>    filter
>  - create an empty repository, unbundle the partial.bdl
> 
>  - take "for-each-ref" and list of objects available in these two
>    "partial copies" from the test repository, and compare

Good idea. Thanks!

Of course, looking closer at it... "git bundle unbundle" doesn't
actually store the refs directly in the refspace, but instead only
outputs the refs that it used.

Here is an attempt to verify the refs that are reported match
those in a mirror clone.

--- >8 ---

diff --git a/t/t6020-bundle-misc.sh b/t/t6020-bundle-misc.sh
index 344af34db1e..a228cbfc4e3 100755
--- a/t/t6020-bundle-misc.sh
+++ b/t/t6020-bundle-misc.sh
@@ -490,7 +490,7 @@ test_expect_success 'unfiltered bundle with --objects' '
 for filter in "blob:none" "tree:0" "tree:1" "blob:limit=100"
 do
 	test_expect_success 'filtered bundle: $filter' '
-		test_when_finished rm -rf .git/objects/pack &&
+		test_when_finished rm -rf .git/objects/pack cloned unbundled &&
 		git bundle create partial.bdl \
 			--all \
 			--filter=$filter &&
@@ -515,11 +515,22 @@ do
 		EOF
 		test_cmp expect actual &&
 
-		# This creates the first pack-file in the
-		# .git/objects/pack directory. Look for a .promisor.
-		git bundle unbundle partial.bdl &&
-		ls .git/objects/pack/pack-*.promisor >promisor &&
-		test_line_count = 1 promisor
+		git init unbundled &&
+		(
+			cd unbundled &&
+			# This creates the first pack-file in the
+			# .git/objects/pack directory. Look for a .promisor.
+			git bundle unbundle ../partial.bdl >ref-list.txt &&
+			ls .git/objects/pack/pack-*.promisor >promisor &&
+			test_line_count = 1 promisor
+		) &&
+
+		git clone --filter=blob:none --mirror "file://$(pwd)" cloned &&
+		git -C cloned for-each-ref \
+			--format="%(objectname) %(refname)" >cloned-refs.txt &&
+		echo "$(git -C cloned rev-parse HEAD) HEAD" >>cloned-refs.txt &&
+		test_cmp cloned-refs.txt unbundled/ref-list.txt
 	'
 done
 
--- >8 ---

I also attempted doing a "git clone --bare partial.bdl unbundled.git" to
get the 'git clone' command to actually place the refs. However, 'git clone'
does not set up the repository filter based on the bundle, so it reports
missing blobs (even though there is no checkout). Making this work would
require that "repository global promisor config" idea that I mentioned in
another reply. I'll make note of this as a potential application of that
idea.

Thanks,
-Stolee
