Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 47A9A1F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 00:19:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfJFATK (ORCPT <rfc822;e@80x24.org>);
        Sat, 5 Oct 2019 20:19:10 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:56922 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726903AbfJFATK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Oct 2019 20:19:10 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 32E4879123;
        Sat,  5 Oct 2019 20:19:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=zrrZe1jgdtvsiIT3jIWK7cpQ1yw=; b=QoRF2w
        Lbbs3mbWXZFzBR+8weV3LjS2sM2hokdsD0lR2gi1eslv3xB8wM3cl3JNZMEWZVvF
        hG3BQk+k7DAjm8md1Z4DjI019zeMP8RwrIDP6YX7rR9hnsqyGSr+yB1tsKM4ysaz
        wTqXu+3W3A1aXwPCLDNXVV7t2NEbgdJNbuCuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=khCasyZdgd7xidT7POvzMsDfw0w1NUH5
        Ju4PjkF18CKuXLcG1/gEc45tfbQo0DM2c81Q9+FkhdVdyW1A6tYRNet9gLX2KIfQ
        Si5yu/CMbSXzD5cY20FyIf2k56yPcEqgBTrQgKYMFZqinWosrkPFtahbxj9qsqkQ
        gmz+VDUCmEs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2B71979122;
        Sat,  5 Oct 2019 20:19:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5381B79121;
        Sat,  5 Oct 2019 20:19:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v3 00/13] ci: include a Visual Studio build & test in our Azure Pipeline
References: <pull.288.v2.git.gitgitgadget@gmail.com>
        <pull.288.v3.git.gitgitgadget@gmail.com>
Date:   Sun, 06 Oct 2019 09:19:03 +0900
In-Reply-To: <pull.288.v3.git.gitgitgadget@gmail.com> (Johannes Schindelin via
        GitGitGadget's message of "Fri, 04 Oct 2019 08:09:23 -0700 (PDT)")
Message-ID: <xmqqimp26808.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E806EB60-E7CE-11E9-93EE-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> Changes since v2:
>
>  * The overflow check introduced in v1 was consolidated into a single
>    helper.

Looks good to me.

> Range-diff vs v2:
>
>   1:  4d0b38125a =  1:  4d0b38125a push: do not pretend to return `int` from `die_push_simple()`
>   2:  8800320590 <  -:  ---------- msvc: avoid using minus operator on unsigned types
>   -:  ---------- >  2:  7fe2a85506 msvc: avoid using minus operator on unsigned types
>   3:  8512a3e96d =  3:  e632a4eef4 winansi: use FLEX_ARRAY to avoid compiler warning

This is less useful than it could be.  

With a larger creation-factor (and we can afford using a larger one,
simply because the user of GGG _knows_ that the two series being
compared are closely related), what is output is entirely readable
(attached at the end).

Oh, while I am suggesting possible improvements on GGG, can we
please tweak the sender date like git-send-email does so that two
messages in the same series do not share the same timestamp?  When
multi-patch series are displayed in MUA or public-inbox News feed
out of order, it almost always is from GGG that gave the same
timestamp to adjacent messages in a series, and it prevents me from
applying them in one go (or saving in one action to a mbox).

What send-email does is, at the beginning for N patch series, to
take the current wallclock time and subtract N seconds from it, and
then give that timestamp to the first message it sends out, and
after that, it increments the timestamp by 1 seconds.

Note that there is no need for any "sleep"---the timestamps are
given by explicitly generating the "Date: " header.  The last time
we looked into this issue, I think the code was trying to do almost
the right thing but it was giving a malformatted timezone and forcing
the sending MTA to override it with the wallclock time or something.

Thanks.

1:  9629f3c751 ! 1:  c097b95a26 msvc: avoid using minus operator on unsigned types
    @@ Commit message
         Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    + ## cache.h ##
    +@@ cache.h: struct cache_entry *index_file_exists(struct index_state *istate, const char *na
    +  */
    + int index_name_pos(const struct index_state *, const char *name, int namelen);
    + 
    ++/*
    ++ * Some functions return the negative complement of an insert position when a
    ++ * precise match was not found but a position was found where the entry would
    ++ * need to be inserted. This helper protects that logic from any integer
    ++ * underflow.
    ++ */
    ++static inline int index_pos_to_insert_pos(uintmax_t pos)
    ++{
    ++	if (pos > INT_MAX)
    ++		die("overflow: -1 - %"PRIuMAX, pos);
    ++	return -1 - (int)pos;
    ++}
    ++
    + #define ADD_CACHE_OK_TO_ADD 1		/* Ok to add */
    + #define ADD_CACHE_OK_TO_REPLACE 2	/* Ok to replace file/directory */
    + #define ADD_CACHE_SKIP_DFCHECK 4	/* Ok to skip DF conflict checks */
    +
      ## read-cache.c ##
     @@ read-cache.c: static int add_index_entry_with_check(struct index_state *istate, struct cache_e
    - 	 * we can avoid searching for it.
      	 */
      	if (istate->cache_nr > 0 &&
    --		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
    + 		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0)
     -		pos = -istate->cache_nr - 1;
    -+		strcmp(ce->name, istate->cache[istate->cache_nr - 1]->name) > 0) {
    -+		if (istate->cache_nr > INT_MAX)
    -+			die("overflow: -1 - %u", istate->cache_nr);
    -+		pos = -1 - (int)istate->cache_nr;
    -+	}
    ++		pos = index_pos_to_insert_pos(istate->cache_nr);
      	else
      		pos = index_name_stage_pos(istate, ce->name, ce_namelen(ce), ce_stage(ce));
      
    @@ read-cache.c: static size_t estimate_cache_size(size_t ondisk_size, unsigned int
     
      ## sha1-lookup.c ##
     @@ sha1-lookup.c: int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
    - 			miv = take2(sha1 + ofs);
      			if (miv < lov)
      				return -1;
    --			if (hiv < miv)
    + 			if (hiv < miv)
     -				return -1 - nr;
    -+			if (hiv < miv) {
    -+				if (nr > INT_MAX)
    -+					die("overflow: -1 - %"PRIuMAX,
    -+					    (uintmax_t)nr);
    -+				return -1 - (int)nr;
    -+			}
    ++				return index_pos_to_insert_pos(nr);
      			if (lov != hiv) {
      				/*
      				 * At this point miv could be equal
    @@ sha1-lookup.c: int sha1_pos(const unsigned char *sha1, void *table, size_t nr,
      		mi = lo + (hi - lo) / 2;
      	} while (lo < hi);
     -	return -lo-1;
    -+	if (nr > INT_MAX)
    -+		die("overflow: -1 - %"PRIuMAX, (uintmax_t)lo);
    -+	return -1 - (int)lo;
    ++	return index_pos_to_insert_pos(lo);
      }
      
      int bsearch_hash(const unsigned char *sha1, const uint32_t *fanout_nbo,

