Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 963CFC433F5
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 15:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbhLGPVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 10:21:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234832AbhLGPVB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 10:21:01 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A20FC061574
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 07:17:31 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id n17-20020a9d64d1000000b00579cf677301so18440651otl.8
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 07:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=n1Od+9+GmlGCaUTI98qMoouywqEU0nWUButRfd3xbb4=;
        b=QYpPfmz84R1RrJKeiWfgRI+l9SQ7LlOPoLxwaSzzb/fwMvSN+jh9izmsQPokGhJgjw
         77gvCJ6dGmDVACWRrX7jq90PRpb810OCKUT2r02GkNKPsuqCGEQtIzhzT7IyhioCONhs
         djrM10BGdwDvvtWdkFNWksvxSThiVTZaq8oYYtL2YKW1Zttt8XE6wv8mLSClm/H9ma1V
         X5E2yO8ypZYkYy9ifIkKQr/iC/EvvJP5+Bg7Lxome8r2EWmRNJNcXtDtEbdGJ45DJEm8
         FP2EHzq3RIKYTqSaYYPmI56xINejsvwl7C3/CHb5egpss575e2M7yKz47KcnipbTOtkf
         NvNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=n1Od+9+GmlGCaUTI98qMoouywqEU0nWUButRfd3xbb4=;
        b=uVH2KbdoB6obknOjc0GiH3gMDeJTnHGZHtxTh8acjeo8YdtyyNSrS+AaHt2z2mBSVo
         VTs+Ez8yyXCKMVeSHers1+yIwkpMXfvMvvx8FK+JDPfjIJBnGgaXbKFY6iKcUPKmZIGf
         D2CdoDEG+Qit+/1zvxg2hvYFJiC5wsak39vlDNCjLmPaJuCMhqDjguOdOoRZvd8/mOlI
         E+AZ0/G1C1l1fEV1C2Yo2qWnu+Geu5T4ja6Ikdre1LUs7Fe6jD9G8uFH2uFmzYVhk86T
         XcvqjIIuHNkn5y/INiww5TWpNcOGpVPiqjZQZ14o1YFzs3262tXlBCY2WfuE0Jgnhjdr
         AcaA==
X-Gm-Message-State: AOAM530F9egKPKLGjJBkBrup7XqBpfCVUg9BYlJqjZohyY/v68SRiYRn
        uDTQ3NB5UC4aaZLtzGsY1UU=
X-Google-Smtp-Source: ABdhPJzqXtCEAqCtO0XITjOtkkWcPNt36NYnf/31eDpAp5+TSBoiiKPyUMXuuHprpzFfvIQ3Y/h5bQ==
X-Received: by 2002:a9d:64ca:: with SMTP id n10mr35487886otl.26.1638890250724;
        Tue, 07 Dec 2021 07:17:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1d54:16a5:5c65:4b5? ([2600:1700:e72:80a0:1d54:16a5:5c65:4b5])
        by smtp.gmail.com with ESMTPSA id c3sm3625964oiw.8.2021.12.07.07.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 07:17:30 -0800 (PST)
Message-ID: <38198f38-ca06-1ab3-344b-29e7b6857ed0@gmail.com>
Date:   Tue, 7 Dec 2021 10:17:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 08/17] builtin/pack-objects.c: --cruft without expiration
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, larsxschneider@gmail.com, peff@peff.net,
        tytso@mit.edu
References: <cover.1638224692.git.me@ttaylorr.com>
 <66165917a4660f63ce60b820d178d52a51304d20.1638224692.git.me@ttaylorr.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <66165917a4660f63ce60b820d178d52a51304d20.1638224692.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/29/2021 5:25 PM, Taylor Blau wrote:
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> +static int add_cruft_object_entry(const struct object_id *oid, enum object_type type,
> +				  struct packed_git *pack, off_t offset,
> +				  const char *name, uint32_t mtime)
> +{
> +	struct object_entry *entry;
> +
> +	display_progress(progress_state, ++nr_seen);

I don't love the global nr_seen here, but it is pervasive through the
file. OK.

> +	entry = packlist_find(&to_pack, oid);
> +	if (entry) {
> +		if (name) {
> +			entry->hash = pack_name_hash(name);
> +			entry->no_try_delta = name && no_try_delta(name);

This is already in an "if (name)" block, so "name &&" isn't needed.

> +		}
> +	} else {
> +		if (!want_object_in_pack(oid, 0, &pack, &offset))
> +			return 0;
> +		if (!pack && type == OBJ_BLOB && !has_loose_object(oid)) {
> +			/*
> +			 * If a traversed tree has a missing blob then we want
> +			 * to avoid adding that missing object to our pack.
> +			 *
> +			 * This only applies to missing blobs, not trees,
> +			 * because the traversal needs to parse sub-trees but
> +			 * not blobs.
> +			 *
> +			 * Note we only perform this check when we couldn't
> +			 * already find the object in a pack, so we're really
> +			 * limited to "ensure non-tip blobs which don't exist in
> +			 * packs do exist via loose objects". Confused?
> +			 */
> +			return 0;
> +		}
> +
> +		entry = create_object_entry(oid, type, pack_name_hash(name),
> +					    0, name && no_try_delta(name),
> +					    pack, offset);
> +	}
> +
> +	if (mtime > oe_cruft_mtime(&to_pack, entry))
> +		oe_set_cruft_mtime(&to_pack, entry, mtime);
> +	return 1;

I was confused at this "return 1" here, while other cases return 0.

It turns out that there are multiple methods in this file that have
different semantics: add_loose_object() and add_object_entry_from_pack()
are both called from iterators where "return 1" means "stop iterating"
so they return 0 always. add_object_entry_from_bitmap() is used to
iterate over a bitmap and "return 1" means "include this object".

However, the return code for add_cruft_object_entry() is never used,
so it should probably return void or swap the meanings to have nonzero
mean an error occurred.

> +static void mark_pack_kept_in_core(struct string_list *packs, unsigned keep)
> +{
> +	struct string_list_item *item = NULL;
> +	for_each_string_list_item(item, packs) {
> +		struct packed_git *p = item->util;
> +		if (!p)
> +			die(_("could not find pack '%s'"), item->string);

Interesting that this is a potential issue. We are expecting the pack
to be loaded before we get here. Is this more because some packs might
not actually load, but it's fine as long as we don't mark them as kept?

> +		p->pack_keep_in_core = keep;
> +	}
> +}
...
> +static void read_cruft_objects(void)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +	struct string_list discard_packs = STRING_LIST_INIT_DUP;
> +	struct string_list fresh_packs = STRING_LIST_INIT_DUP;
> +	struct packed_git *p;
> +
> +	ignore_packed_keep_in_core = 1;

Here is a global that we are suddenly changing. Should we not be
returning it to its initial state when this method is complete?

> +static int option_parse_cruft_expiration(const struct option *opt,
> +					 const char *arg, int unset)
> +{
> +	if (unset) {
> +		cruft = 0;

This unassignment of 'cruft' when cruft-expiration is unset with
--no-cruft-expiration seems odd. I would expect

	git pack-objects --cruft --no-cruft-expiration

to still make a cruft pack, but not expire anything. It seems that
your code here makes --no-cruft-expiration disable the --cruft option.

> +		cruft_expiration = 0;
> +	} else {
> +		cruft = 1;
> +		if (arg)
> +			cruft_expiration = approxidate(arg);
> +	}
> +	return 0;
> +}
..
> +		OPT_BOOL(0, "cruft", &cruft, N_("create a cruft pack")),
> +		OPT_CALLBACK_F(0, "cruft-expiration", NULL, N_("time"),
> +		  N_("expire cruft objects older than <time>"),
> +		  PARSE_OPT_OPTARG, option_parse_cruft_expiration),

> -static int has_loose_object(const struct object_id *oid)
> +int has_loose_object(const struct object_id *oid)
>  {
>  	return check_and_freshen(oid, 0);
>  }

I'm surprised this hasn't been modified to use a repository pointer.
Adding another caller here isn't too much debt, though.

> diff --git a/object-store.h b/object-store.h
> index d87481f101..a79c1c91ab 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -308,6 +308,8 @@ int repo_has_object_file_with_flags(struct repository *r,
>   */
>  int has_loose_object_nonlocal(const struct object_id *);

Of course, here is another example that is already more widely used.

> +int has_loose_object(const struct object_id *);
> +
>  void assert_oid_type(const struct object_id *oid, enum object_type expect);

...

> +	test_expect_success "unreachable packed objects are packed (expire $expire)" '
> +		git init repo &&
> +		test_when_finished "rm -fr repo" &&
> +		(
> +			cd repo &&
> +
> +			test_commit packed &&
> +			git repack -Ad &&
> +			test_commit other &&
> +
> +			git rev-list --objects --no-object-names packed.. >objects &&
> +			keep="$(basename "$(ls $packdir/pack-*.pack)")" &&
> +			other="$(git pack-objects --delta-base-offset \
> +				$packdir/pack <objects)" &&
> +			git prune-packed &&
> +
> +			test-tool chmtime --get -100 "$packdir/pack-$other.pack" >expect &&

I am missing how this test creates _unreachable_ objects. I would expect removal of
some refs or a 'git reset --hard' somewhere. What am I missing?

> +			cruft="$(git pack-objects --cruft --cruft-expiration="$expire" $packdir/pack <<-EOF
> +			$keep
> +			-pack-$other.pack
> +			EOF
> +			)" &&
> +			test-tool pack-mtimes "pack-$cruft.mtimes" >actual.raw &&
> +
> +			cut -d" " -f2 <actual.raw | sort -u >actual &&
> +
> +			test_cmp expect actual
> +		)
> +	'
> +
> +	test_expect_success "unreachable cruft objects are repacked (expire $expire)" '

I have the same question for all of the tests, really.

> +			# remove the unreachable tree, but leave the commit
> +			# which has it as its root tree in-tact

nit: "intact" is one word.

> +			rm -fr "$objdir/$(test_oid_to_path "$tree")" &&
> +
> +			git repack -Ad &&
> +			basename $(ls $packdir/pack-*.pack) >in &&
> +			git pack-objects --cruft --cruft-expiration="$expire" \
> +				$packdir/pack <in
> +		)
> +	'

...

> +basic_cruft_pack_tests never

I look forward to seeing how this changes with additional expiration values.

Thanks,
-Stolee

