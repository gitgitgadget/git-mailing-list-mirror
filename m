Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30433C433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 14:04:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbiGUOEO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 10:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbiGUOEM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 10:04:12 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783C4402FE
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 07:04:11 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id p26-20020a1c545a000000b003a2fb7c1274so3402176wmi.1
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 07:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ke8B8nt0IhSyl5td1v4aRd3G0H4fL5e7Atz+VoHk6lY=;
        b=bZGWDtKe7HhwAgATangxOoEDy27XjaJcm2qH9sLOSSxXtZ8YrQqt/oSV061Vn2Nufz
         5PYxJyd0CfULQddgvK+XXilsvLyUJCzmPx1ileGT/BFTPgCZw6hscesLZlDUQnCoc9hN
         7pE3CDkq9kf2rYbpYCHkHLT+xBe9kPrTVlt5LkG2d4426RFgswsZUvg1exJ9kOnrk32j
         JaqGEnD3Xhe7R+Y3ZpB1L0aAFqpLCZ/SulxOBt2s5V05+5EI0GlEw6T1NsnYwhfyPHJJ
         a6SP+wWvep/oC8eV1VHGKR0EjZ3pX107iT0g+PR8EPJRgd5I+Vfz4/o5tyZknbqRofjD
         xf8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ke8B8nt0IhSyl5td1v4aRd3G0H4fL5e7Atz+VoHk6lY=;
        b=ynDU7cqmuQd1r9QfJOk0E/fvrBBsbrQdZyUNi+YjfSHxuDtiLxzjVr0Mu4E9T/UfVD
         ZyzlVQLmxYKgyBH6VOmm00gK1vXIXqQo65gPlVyEhSODaU5meer6uY+GIKGVQ7kokXAP
         M529ghColXzIcEMMLStgFfbWo5lC2iDv5UtqurLIhA/pEAIOi24yLrOk+sspjSW0dEad
         mXUHSOvWc9EeL4UCUQbRSKIwNsFo2hODzvYn95s/C/dAnFhYR1LiVu7H94pkcdpiLePw
         O/eyCUtN079QR3RzYnd9Sdc4hYhuo6putJyobUH4LOOQ7N0plgAbEnE4vEUBiF0zKwsd
         xMVQ==
X-Gm-Message-State: AJIora+a9HLrB807usHIY2LBuIvtdxp6pdbA5gPj4VW662okPuPFUOQR
        iSJZ0TgIfmwDpjUf0pE0XzM=
X-Google-Smtp-Source: AGRyM1vdQLIv3hexkssvslyZjSaBDqH7AOEM5IxNbEgtegPK27vcwGDaoVKo+ZA8mR1hgz8DrBhE6g==
X-Received: by 2002:a05:600c:a03:b0:39e:4f0c:938c with SMTP id z3-20020a05600c0a0300b0039e4f0c938cmr8425901wmp.145.1658412249767;
        Thu, 21 Jul 2022 07:04:09 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id f7-20020a1c3807000000b003a3080eacb9sm2051963wma.24.2022.07.21.07.04.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Jul 2022 07:04:09 -0700 (PDT)
Message-ID: <bb96c7a0-8da3-1be7-f1a6-a46ad673002e@gmail.com>
Date:   Thu, 21 Jul 2022 15:04:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5 09/12] sequencer: rewrite update-refs as user edits
 todo list
Content-Language: en-GB-large
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, johannes.schindelin@gmx.de, me@ttaylorr.com,
        Jeff Hostetler <git@jeffhostetler.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1247.v4.git.1657631225.gitgitgadget@gmail.com>
 <pull.1247.v5.git.1658255624.gitgitgadget@gmail.com>
 <95e2bbcedb1740f240a0a470822549d63075cc46.1658255624.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <95e2bbcedb1740f240a0a470822549d63075cc46.1658255624.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee

On 19/07/2022 19:33, Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> +void todo_list_filter_update_refs(struct repository *r,
> +				  struct todo_list *todo_list)
> +{
> +	int i;
> +	int updated = 0;
> +	struct string_list update_refs = STRING_LIST_INIT_DUP;
> +
> +	sequencer_get_update_refs_state(r->gitdir, &update_refs);
> +
> +	/*
> +	 * For each item in the update_refs list, if it has no updated
> +	 * value and does not appear in the todo_list, then remove it
> +	 * from the update_refs list.
> +	 */
> +	for (i = 0; i < update_refs.nr; i++) {
> +		int j;
> +		int found = 0;
> +		const char *ref = update_refs.items[i].string;
> +		size_t reflen = strlen(ref);
> +		struct update_ref_record *rec = update_refs.items[i].util;
> +
> +		/* OID already stored as updated. */
> +		if (!is_null_oid(&rec->after))
> +			continue;
> +
> +		for (j = 0; !found && j < todo_list->total_nr; j++) {
> +			struct todo_item *item = &todo_list->items[j];
> +			const char *arg = todo_list->buf.buf + item->arg_offset;
> +
> +			if (item->command != TODO_UPDATE_REF)
> +				continue;
> +
> +			if (item->arg_len != reflen ||
> +			    strncmp(arg, ref, reflen))
> +				continue;
> +
> +			found = 1;
> +		}
> +
> +		if (!found) {
> +			free(update_refs.items[i].string);
> +			free(update_refs.items[i].util);
> +
> +			update_refs.nr--;
> +			MOVE_ARRAY(update_refs.items + i, update_refs.items + i + 1, update_refs.nr - i);
> +
> +			updated = 1;
> +			i--;
> +		}
> +	}
> +
> +	/*
> +	 * For each todo_item, check if its ref is in the update_refs list.
> +	 * If not, then add it as an un-updated ref.
> +	 */
> +	for (i = 0; i < todo_list->total_nr; i++) {
> +		struct todo_item *item = &todo_list->items[i];
> +		const char *arg = todo_list->buf.buf + item->arg_offset;
> +		int j, found = 0;
> +
> +		if (item->command != TODO_UPDATE_REF)
> +			continue;
> +
> +		for (j = 0; !found && j < update_refs.nr; j++) {
> +			const char *ref = update_refs.items[j].string;
> +
> +			found = strlen(ref) == item->arg_len &&
> +				!strncmp(ref, arg, item->arg_len);
> +		}
> +
> +		if (!found) {
> +			struct string_list_item *inserted;
> +			struct strbuf argref = STRBUF_INIT;
> +
> +			strbuf_add(&argref, arg, item->arg_len);
> +			inserted = string_list_insert(&update_refs, argref.buf);
> +			inserted->util = init_update_ref_record(argref.buf);
> +			strbuf_release(&argref);
> +			updated = 1;
> +		}
> +	}
> +
> +	if (updated)
> +		write_update_refs_state(&update_refs);

We should return an error if write_update_refs_state() fails

Best Wishes

Phillip
