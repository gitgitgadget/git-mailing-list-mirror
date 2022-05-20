Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B31AEC433EF
	for <git@archiver.kernel.org>; Fri, 20 May 2022 17:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237156AbiETR10 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 May 2022 13:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236051AbiETR1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 May 2022 13:27:24 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9979517CE6F
        for <git@vger.kernel.org>; Fri, 20 May 2022 10:27:23 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id t11-20020a17090a6a0b00b001df6f318a8bso12037374pjj.4
        for <git@vger.kernel.org>; Fri, 20 May 2022 10:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=izndWJjslfUwBwQZfE5O/x2PLY40b6HWJyYng7YxIxs=;
        b=awrma6d6bcPIHxngqjEPNcRlT/BYvkc0r6kXgNqwldmBf5O0SHtBsRNOhXy5382nzs
         wbC6eRDJ9offjBpfwUGRy5meAhZ/bgE0sIa+7dpI+fL7BvcjIABLrt0rfLZvjiofh2/5
         TV7o6/o2R+2WnH/QNEkxuVYuVHWg86IQHnXWqrhhAFDujkoTdyYtCwwTsy4BzVVNyPwR
         Iz9GrUrOggmig7F935bowfUwMSjm3IrelQVigHGa+SKBvVq8yRCFcPgxRCsivRXoZF8L
         KqZuEzal4vLthXjqXl6LnKKWRv5xla2uUPwKVWCW2R3VI0YEfHrdrIGdE6SpxRZ/EeWm
         qs1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=izndWJjslfUwBwQZfE5O/x2PLY40b6HWJyYng7YxIxs=;
        b=ybyiDk1mcGW8oXhQMqwPRP6OFDGK5lKTQK6ZcnXnRzSCTlcuCyyYR6QippYe7JcA/G
         xD52+WlVc372Ozqmg4s9opmEcEYPsEd+J7SZ+PRu9lxwWLbDcwRqDjohYp6GNkPLhwO+
         kwV3nEVM1UHSbgJyuSkCfPqjW1r/R67K3dg2MGpEbk8285gWz7a9O2aaQNXVJRFdgHou
         vDFwqEZYz0QqWJ5qo9sYFXoglVjHJn/webBFhtvshC+bzA+W/ShAqLrGCj2bybmr/qi4
         MF86mvAHqmytHT3nWX4FA7eNcp4ecMy179pCQXyuzomNepCsv+awX79UX+MHI3Bye1Qf
         bA4g==
X-Gm-Message-State: AOAM530m76Jd9PjJauBSiyw/jNXIdUoXLE26klFlF0xufQpROWnZcUrL
        fznxnSD9KbCEwfzPmZgDCT8v
X-Google-Smtp-Source: ABdhPJzwUpJzJl2WfJhQZ0gTUpq4MfjmBM81yRc+Ymv0d3onET/68ObkVlnkvZZOTToDMWoAo/u7+g==
X-Received: by 2002:a17:902:7597:b0:15e:b5d3:267d with SMTP id j23-20020a170902759700b0015eb5d3267dmr10856462pll.55.1653067643009;
        Fri, 20 May 2022 10:27:23 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id k16-20020a170902761000b001615de533a9sm32616pll.30.2022.05.20.10.27.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 May 2022 10:27:22 -0700 (PDT)
Message-ID: <bb19159b-6d0c-a683-a58e-95ebdc128627@github.com>
Date:   Fri, 20 May 2022 10:27:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH] repack: respect --keep-pack with geometric repack
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1235.git.1653064572170.gitgitgadget@gmail.com>
 <YofJLv8+x5J7yPmf@nand.local>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <YofJLv8+x5J7yPmf@nand.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau wrote:
> Hi Victoria,
> 
> On Fri, May 20, 2022 at 04:36:12PM +0000, Victoria Dye via GitGitGadget wrote:
>> From: Victoria Dye <vdye@github.com>
>>
>> Update 'repack' to ignore packs named on the command line with the
>> '--keep-pack' option. Specifically, modify 'init_pack_geometry()' to treat
>> command line-kept packs the same way it treats packs with an on-disk '.keep'
>> file (that is, skip the pack and do not include it in the 'geometry'
>> structure).
>>
>> Without this handling, a '--keep-pack' pack would be included in the
>> 'geometry' structure. If the pack is *before* the geometry split line (with
>> at least one other pack and/or loose objects present), 'repack' assumes the
>> pack's contents are "rolled up" into another pack via 'pack-objects'.
>> However, because the internally-invoked 'pack-objects' properly excludes
>> '--keep-pack' objects, any new pack it creates will not contain the kept
>> objects. Finally, 'repack' deletes the '--keep-pack' as "redundant" (since
>> it assumes 'pack-objects' created a new pack with its contents), resulting
>> in possible object loss and repository corruption.
> 
> Nicely found and explained. Having discussed this fix with you already
> off-list, this approach (to treat kept packs as excluded from the list
> of packs in the `geometry` structure regardless of whether they are kept
> on disk or in-core) makes sense to me.
> 
> I left a couple of small notes on the patch below, but since I have some
> patches that deal with a separate issue in the `git repack --geometric`
> code coming, do you want to combine forces (and I can send a
> lightly-reworked version of this patch as a part of my series)?
> 

Works for me! I'm happy with all the suggested changes you noted below
(moving the 'string_list_sort' and cleaning up the test), so feel free to
include them in your series.

Thanks!

>> @@ -332,17 +332,34 @@ static int geometry_cmp(const void *va, const void *vb)
>>  	return 0;
>>  }
>>
>> -static void init_pack_geometry(struct pack_geometry **geometry_p)
>> +static void init_pack_geometry(struct pack_geometry **geometry_p,
>> +			       struct string_list *existing_kept_packs)
>>  {
>>  	struct packed_git *p;
>>  	struct pack_geometry *geometry;
>> +	struct strbuf buf = STRBUF_INIT;
>>
>>  	*geometry_p = xcalloc(1, sizeof(struct pack_geometry));
>>  	geometry = *geometry_p;
>>
>> +	string_list_sort(existing_kept_packs);
> 
> Would it be worth sorting this as early as in collect_pack_filenames()?
> For our purposes in this patch, this works as-is, but it may be
> defensive to try and minimize the time that list has unsorted contents.
> 

I went back and forth on this, eventually settling on this to keep the
'string_list_sort' as close as possible to where the sorted list is needed.
I'm still pretty indifferent, though, so moving it to the end of
'collect_pack_filenames()' is fine with me.

>>  	for (p = get_all_packs(the_repository); p; p = p->next) {
>> -		if (!pack_kept_objects && p->pack_keep)
>> -			continue;
>> +		if (!pack_kept_objects) {
>> +			if (p->pack_keep)
>> +				continue;
> 
> (You mentioned this to me off-list, but I'll repeat it here since it
> wasn't obvious to me on first read): this check for `p->pack_keep` isn't
> strictly necessary, since any packs that have their `pack_keep` bit set
> will appear in the `existing_kept_packs` list.
> 
> But it does give us a fast path to avoid having to check that list, so
> it's worth checking that bit to avoid a slightly more expensive check
> where possible.
> 
>> +			/*
>> +			 * The pack may be kept via the --keep-pack option;
>> +			 * check 'existing_kept_packs' to determine whether to
>> +			 * ignore it.
>> +			 */
>> +			strbuf_reset(&buf);
>> +			strbuf_addstr(&buf, pack_basename(p));
>> +			strbuf_strip_suffix(&buf, ".pack");
>> +
>> +			if (string_list_has_string(existing_kept_packs, buf.buf))
>> +				continue;
> 
> It's too bad that we have to do this check at all, and can't rely on the
> `pack_keep_in_core` in the same way as we check `p->pack_keep`. But
> lifting that restriction is a more invasive change, so I'm happy to
> rely on the contents of existing_kept_packs here in the meantime.
> 
>> +		}
>>
>>  		ALLOC_GROW(geometry->pack,
>>  			   geometry->pack_nr + 1,
>> @@ -353,6 +370,7 @@ static void init_pack_geometry(struct pack_geometry **geometry_p)
>>  	}
>>
>>  	QSORT(geometry->pack, geometry->pack_nr, geometry_cmp);
>> +	strbuf_release(&buf);
>>  }
>>
>>  static void split_pack_geometry(struct pack_geometry *geometry, int factor)
>> @@ -714,17 +732,20 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>>  		strbuf_release(&path);
>>  	}
>>
>> +	packdir = mkpathdup("%s/pack", get_object_directory());
>> +	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
>> +	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
>> +
>> +	collect_pack_filenames(&existing_nonkept_packs, &existing_kept_packs,
>> +			       &keep_pack_list);
>> +
> 
> Makes sense; we have to initialize existing_kept_packs before arranging
> the list of packs for the `--geometric` split. And presumably
> `collect_pack_filenames()` relies on `packdir`, `packtmp_name`, and
> `packtmp` being setup ahead of time, too.
> 
>>  	if (geometric_factor) {
>>  		if (pack_everything)
>>  			die(_("options '%s' and '%s' cannot be used together"), "--geometric", "-A/-a");
>> -		init_pack_geometry(&geometry);
>> +		init_pack_geometry(&geometry, &existing_kept_packs);
>>  		split_pack_geometry(geometry, geometric_factor);
>>  	}
>>
>> -	packdir = mkpathdup("%s/pack", get_object_directory());
>> -	packtmp_name = xstrfmt(".tmp-%d-pack", (int)getpid());
>> -	packtmp = mkpathdup("%s/%s", packdir, packtmp_name);
>> -
>>  	sigchain_push_common(remove_pack_on_signal);
>>
>>  	prepare_pack_objects(&cmd, &po_args);
>> @@ -764,9 +785,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
>>  	if (use_delta_islands)
>>  		strvec_push(&cmd.args, "--delta-islands");
>>
>> -	collect_pack_filenames(&existing_nonkept_packs, &existing_kept_packs,
>> -			       &keep_pack_list);
>> -
>>  	if (pack_everything & ALL_INTO_ONE) {
>>  		repack_promisor_objects(&po_args, &names);
>>
>> diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
>> index bdbbcbf1eca..f5ac23413d5 100755
>> --- a/t/t7703-repack-geometric.sh
>> +++ b/t/t7703-repack-geometric.sh
>> @@ -180,6 +180,40 @@ test_expect_success '--geometric ignores kept packs' '
>>  	)
>>  '
>>
>> +test_expect_success '--geometric ignores --keep-pack packs' '
>> +	git init geometric &&
>> +	test_when_finished "rm -fr geometric" &&
>> +	(
>> +		cd geometric &&
>> +
>> +		# Create two equal-sized packs
>> +		test_commit kept && # 3 objects
>> +		test_commit pack && # 3 objects
>> +
>> +		KEPT=$(git pack-objects --revs $objdir/pack/pack <<-EOF
>> +		refs/tags/kept
>> +		EOF
>> +		) &&
>> +		PACK=$(git pack-objects --revs $objdir/pack/pack <<-EOF
>> +		refs/tags/pack
>> +		^refs/tags/kept
>> +		EOF
>> +		) &&
> 
> Nit; we don't care about the name of $PACK, so it would probably be fine
> to avoid storing the `PACK` variable. We could write these packs with
> just `git repack -d` after each `test_commit` (which would avoid us
> having to call `prune-packed`).
> 

Makes sense.

> Does it matter which one is kept? I don't think so, since AFAICT the
> critical bit is that we mark one of the packs being rolled up as a
> `--keep-pack`.
> 

Correct, the two packs in this test are just two same-sized (or, more
generally, non-geometrically progressing) packs with non-overlapping
content.

>> +		# Prune loose objects that are now packed into PACK and KEEP
>> +		git prune-packed &&
>> +
>> +		git repack --geometric 2 -dm --keep-pack=pack-$KEPT.pack >out &&
>> +
>> +		# Packs should not have changed (only one non-kept pack, no
>> +		# loose objects), but midx should now exist.
>> +		test_i18ngrep "Nothing new to pack" out &&
> 
> Nit; test_i18ngrep here should just be "grep".
> 

Thanks for pointing this out - I've been a bit unsure of the difference for
a while, but this pushed me to figure out the difference and I found the
note in 'test-lib-functions.sh' clarifying that 'test_i18ngrep' is
deprecated.

>> +		test_path_is_file $midx &&
>> +		test_path_is_file $objdir/pack/pack-$KEPT.pack &&
>> +		git fsck
>> +	)
> 
> 
> Thanks,
> Taylor

