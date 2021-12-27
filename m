Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA6B1C433EF
	for <git@archiver.kernel.org>; Mon, 27 Dec 2021 01:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhL0BLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 20:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234895AbhL0BLw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 20:11:52 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5763AC06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 17:11:52 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id j18so29491376wrd.2
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 17:11:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=E50/WmwgBtvxhIvPsu2RR8t3VLcoSmY5Go1Jt/ht89Y=;
        b=R/K1MlCtVHwDO6V0t/uFVYcSDTM9OpXQ+geZhKS71HALb9CXeuO1Da2Th5owCUU0F7
         M6zimewk5L937WnFyjwmZSwhSsM00SOLkBEH8FGN45YqyA5lYrNVj6yqi5HB6Y9HsPvV
         qu7wfH4qv5v6BO9RA/pXrUqsx/spJh1Ha0knYQdtUBLZXv2YMNVHp0MPmTAusz6MieGQ
         cC0IGMy1/CitVWWjIp2iubVeSDcLSwUfr6oFh3kI80sgHMZ+5254n3WxK3wwAzGSiRHU
         oIz44LpX8VR3ActdToYSSCtCAMmJ/g/ZUSsqmJZ84zEJU+pZyeGaDHoOuOcVvcZeoZYE
         H06g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E50/WmwgBtvxhIvPsu2RR8t3VLcoSmY5Go1Jt/ht89Y=;
        b=hExFq50DrkFzequI/OXBe1IsW6vXsWCxud7d5iniAf6IOaYSiuDAmROwCpOoFjU4Gb
         QlepI391fxFzJPeii0wQ/9K6pkLOnQtxVQ+yNsdtx4mUyoUsnfIQDR0tUpCEvl6bnc+M
         bjSYqId2uBsaM5o6i2IHK4YwcsavL8fPyE6S8WzTBQqq9wC6rUWbvWMp9X+km8sn2w5B
         qLQqYikjaUOEAqKDuop6bPsNdrzPvKIdfAwicT1FZpMBCtwdycaQN2wDZ7YQ/mmqu8qo
         lPFkN/8hONZ2q+4GrSWV3W0km1mX3PWonv3qR9+aepXKx5Mdz39JygUo/E6bUPUHevmn
         lBBA==
X-Gm-Message-State: AOAM531o826oV9q7V/y8krQugTAwUWi5tk9+d/Y5fix4o9kfVL1QglM4
        Y/1xlzzYERRzlQWLpcYfIo8=
X-Google-Smtp-Source: ABdhPJwFMAWALYhIYf1fKXSvgzNr6I+927taRm3U52w+WhLiMRByGAfGl1SGHNII+C7IWk3x7mqyfA==
X-Received: by 2002:adf:d843:: with SMTP id k3mr11547286wrl.303.1640567510941;
        Sun, 26 Dec 2021 17:11:50 -0800 (PST)
Received: from gmail.com (62-47-14-33.adsl.highway.telekom.at. [62.47.14.33])
        by smtp.gmail.com with ESMTPSA id s207sm14108354wme.2.2021.12.26.17.11.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 17:11:50 -0800 (PST)
Date:   Mon, 27 Dec 2021 02:11:48 +0100
From:   Johannes Altmanninger <aclopte@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v7 6/7] pack-bitmap-write.c: don't return without
 stop_progress()
Message-ID: <20211227011148.rz57cgk3fovklz6i@gmail.com>
References: <cover-v7-0.7-00000000000-20211217T041945Z-avarab@gmail.com>
 <patch-v7-6.7-776362de897-20211217T041945Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v7-6.7-776362de897-20211217T041945Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 17, 2021 at 05:25:01AM +0100, Ævar Arnfjörð Bjarmason wrote:
> Fix a bug that's been here since 7cc8f971085 (pack-objects: implement
> bitmap writing, 2013-12-21), we did not call stop_progress() if we
> reached the early exit in this function.
> 
> We could call stop_progress() before we return, but better yet is to
> defer calling start_progress() until we need it.

Looks great.

> 
> This will matter in a subsequent commit where we BUG(...) out if this happens,

"this" = "call start without stop"? Let's maybe be explicit here

(I guess the BUG() commit was postponed, but it doesn't hurt to mention it.)

> and matters now e.g. because we don't have a corresponding
> "region_end" for the progress trace2 event.

s/region_end/region_leave/

> 
> Suggested-by: SZEDER Gábor <szeder.dev@gmail.com>
> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  pack-bitmap-write.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/pack-bitmap-write.c b/pack-bitmap-write.c
> index 9c55c1531e1..cab3eaa2acd 100644
> --- a/pack-bitmap-write.c
> +++ b/pack-bitmap-write.c
> @@ -575,15 +575,15 @@ void bitmap_writer_select_commits(struct commit **indexed_commits,
>  
>  	QSORT(indexed_commits, indexed_commits_nr, date_compare);
>  
> -	if (writer.show_progress)
> -		writer.progress = start_progress("Selecting bitmap commits", 0);
> -
>  	if (indexed_commits_nr < 100) {
>  		for (i = 0; i < indexed_commits_nr; ++i)
>  			push_bitmapped_commit(indexed_commits[i]);
>  		return;
>  	}
>  
> +	if (writer.show_progress)
> +		writer.progress = start_progress("Selecting bitmap commits", 0);
> +
>  	for (;;) {
>  		struct commit *chosen = NULL;
>  
> -- 
> 2.34.1.1119.g7a3fc8778ee
> 
