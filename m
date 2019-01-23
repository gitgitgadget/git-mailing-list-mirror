Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 532151F453
	for <e@80x24.org>; Wed, 23 Jan 2019 22:14:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbfAWWN7 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Jan 2019 17:13:59 -0500
Received: from mail-pf1-f202.google.com ([209.85.210.202]:47193 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726152AbfAWWN6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jan 2019 17:13:58 -0500
Received: by mail-pf1-f202.google.com with SMTP id m3so2821640pfj.14
        for <git@vger.kernel.org>; Wed, 23 Jan 2019 14:13:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=CeOCQ+78amczbt2vHRf3bUPkT/Flu06wb6GdCNci6BQ=;
        b=Sl9owBdeHkugojbCCtV8QxKAshEpdMGHj7EnW5tYTttIQPSavauPIWL7n7pTeNOIK8
         7DV+2I8eigoldgvZ6lA/x+INrsrGJUJ3wkDoCe6FycuBpKqNFYOkhbo/Le6ZlvFAxFRk
         cv1F0jJBsZFCWodW5R1zmpe54YTlCiDbACAABX9gv9lYyAQogGkXzRQpODvt2UmdXH0w
         ShESllMQsYheDxFsXQZB1Q9qJq7S84tj9Fh9dHj2CFK54NySOimKMDi/CpfIwUJAiOjy
         kLlwGDUEbWx/Ioj/vEbn6qK5AYxu+6SQaebO1iURL8EltoQ0f9gKlcNFCXMXOupCjIgU
         AXsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=CeOCQ+78amczbt2vHRf3bUPkT/Flu06wb6GdCNci6BQ=;
        b=sV4KL9dNROBPaWiCNWaCKJWNELeHRqTHRKL4zXN8ayGsoGfQnGi8GfHaJ65CfS1HAB
         UrRN4O6H0/x+bGSV+r1Az0VG4fNtaEyXPsQfIafhdiXbKLv936tE26raE3yTyPnPYEhD
         tSc2ssWeIs1Xc6bKxPlkayLD2pYifba2I0AovuJdduUaxXsJc8QGK2AjPyMv/FHu5pa4
         DWrP8IKn590yVQ9kLVbb8Obx3cOzH/icGjC6Ftxfbk69OGzBiSztLIOsFcZfZiN/tAs/
         VzQvfNLrSumc5ngfaNsiPq5w7dybNOte/WzaVqF7MWyQ6VKF49Su1mFEjy405FmjL97S
         XoCA==
X-Gm-Message-State: AJcUukezgyzZtkNh3YIQ0ZDEZeOjAtcqnmOQLR4PprM9xSaweDNyYOcC
        QzM0obF5cLirclBQLuhYUgW6yOTirhB5kA+8unv+
X-Google-Smtp-Source: ALg8bN6V0FlDr5+BuM1RV2cNbbcBPoZs/WwE6hvwsascnHfU04oEl9nfdWc92WjuHRMllKYHNxFbi3uC8Uu1XzkK3kt+
X-Received: by 2002:a63:6988:: with SMTP id e130mr1776749pgc.9.1548281637486;
 Wed, 23 Jan 2019 14:13:57 -0800 (PST)
Date:   Wed, 23 Jan 2019 14:13:54 -0800
In-Reply-To: <4dbff40e7ad653d9c5c3b19dd63a345a21a73dbd.1547047269.git.gitgitgadget@gmail.com>
Message-Id: <20190123221354.136961-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <4dbff40e7ad653d9c5c3b19dd63a345a21a73dbd.1547047269.git.gitgitgadget@gmail.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [PATCH v3 6/9] multi-pack-index: implement 'expire' verb
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitgitgadget@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com, peff@peff.net,
        jrnieder@gmail.com, avarab@gmail.com, gitster@pobox.com,
        dstolee@microsoft.com, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> The 'git multi-pack-index expire' command looks at the existing
> mult-pack-index, counts the number of objects referenced in each
> pack-file, deletes the pack-fils with no referenced objects, and
> rewrites the multi-pack-index to no longer reference those packs.

Thanks - this was quite straightforwardly written.

> @@ -745,7 +761,10 @@ int write_midx_file(const char *object_dir)
>  			  midx_name);
>  	}
>  
> -	packs.m = load_multi_pack_index(object_dir, 1);
> +	if (m)
> +		packs.m = m;
> +	else
> +		packs.m = load_multi_pack_index(object_dir, 1);

If we already loaded the m, we can just pass it in - OK.

> +	if (packs_to_drop && packs_to_drop->nr) {
> +		int drop_index = 0;
> +		int missing_drops = 0;
> +
> +		for (i = 0; i < packs.nr && drop_index < packs_to_drop->nr; i++) {
> +			int cmp = strcmp(packs.info[i].pack_name,
> +					 packs_to_drop->items[drop_index].string);
> +
> +			if (!cmp) {
> +				drop_index++;
> +				packs.info[i].expired = 1;
> +			} else if (cmp > 0) {
> +				error(_("did not see pack-file %s to drop"),
> +				      packs_to_drop->items[drop_index].string);
> +				drop_index++;
> +				missing_drops++;
> +				i--;
> +			} else {
> +				packs.info[i].expired = 0;
> +			}
> +		}
> +
> +		if (missing_drops) {
> +			result = 1;
> +			goto cleanup;
> +		}
> +	}

This takes into account that packfiles can shift while we run this
command, I see. Other than that, this is a common pattern - how we
iterate through 2 sorted arrays, one a subsequence of each other.

And indeed packs_to_drop is a sorted list, because we use
string_list_insert() below.

>  	ALLOC_ARRAY(pack_perm, packs.nr);
>  	for (i = 0; i < packs.nr; i++) {
> -		pack_perm[packs.info[i].orig_pack_int_id] = i;
> +		if (packs.info[i].expired) {
> +			dropped_packs++;
> +			pack_perm[packs.info[i].orig_pack_int_id] = PACK_EXPIRED;
> +		} else {
> +			pack_perm[packs.info[i].orig_pack_int_id] = i - dropped_packs;
> +		}

Here...

>  	}
>  
> -	for (i = 0; i < packs.nr; i++)
> -		pack_name_concat_len += strlen(packs.info[i].pack_name) + 1;
> +	for (i = 0; i < packs.nr; i++) {
> +		if (!packs.info[i].expired)
> +			pack_name_concat_len += strlen(packs.info[i].pack_name) + 1;
> +	}

...and here and elsewhere, we have to contend with the fact that
packs.info has pack_info that we don't want to write. I think it would
be slightly better to filter out the expired ones from packs.info, and
then when generating pack_perm, first memset it to 0xff. This way, we
wouldn't have to check expiry everywhere. But I don't feel too strongly
about this.

>  int expire_midx_packs(const char *object_dir)
>  {
> -	return 0;
> +	uint32_t i, *count, result = 0;
> +	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
> +	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
> +
> +	if (!m)
> +		return 0;
> +
> +	count = xcalloc(m->num_packs, sizeof(uint32_t));
> +	for (i = 0; i < m->num_objects; i++) {
> +		int pack_int_id = nth_midxed_pack_int_id(m, i);
> +		count[pack_int_id]++;
> +	}
> +
> +	for (i = 0; i < m->num_packs; i++) {
> +		char *pack_name;
> +
> +		if (count[i])
> +			continue;
> +
> +		if (prepare_midx_pack(m, i))
> +			continue;
> +
> +		if (m->packs[i]->pack_keep)
> +			continue;
> +
> +		pack_name = xstrdup(m->packs[i]->pack_name);
> +		close_pack(m->packs[i]);
> +		FREE_AND_NULL(m->packs[i]);
> +
> +		string_list_insert(&packs_to_drop, m->pack_names[i]);
> +		unlink_pack_path(pack_name, 0);
> +		free(pack_name);
> +	}
> +
> +	free(count);
> +
> +	if (packs_to_drop.nr)
> +		result = write_midx_internal(object_dir, m, &packs_to_drop);
> +
> +	string_list_clear(&packs_to_drop, 0);
> +	return result;
>  }

This is as I expected - unlink all the files we don't want, and even
though much of the midx hasn't changed, we still need to write it
because it has a new list of packfiles.

> +test_expect_success 'expire removes unreferenced packs' '
> +	(
> +		cd dup &&
> +		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
> +		refs/heads/A
> +		^refs/heads/C
> +		EOF
> +		git multi-pack-index write &&
> +		ls .git/objects/pack | grep -v -e pack-[AB] >expect &&
> +		git multi-pack-index expire &&
> +		ls .git/objects/pack >actual &&
> +		test_cmp expect actual &&
> +		ls .git/objects/pack/ | grep idx >expect-idx &&
> +		test-tool read-midx .git/objects | grep idx >actual-midx &&
> +		test_cmp expect-idx actual-midx
> +	)
> +'

Maybe add a fsck at the end for sanity's sake. Also, I think that
preservation of .keep packfiles is an important feature, and maybe worth
a test.
