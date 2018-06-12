Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9957E1F403
	for <e@80x24.org>; Tue, 12 Jun 2018 17:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933660AbeFLRrJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Jun 2018 13:47:09 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36745 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933550AbeFLRrI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jun 2018 13:47:08 -0400
Received: by mail-wr0-f194.google.com with SMTP id f16-v6so25032597wrm.3
        for <git@vger.kernel.org>; Tue, 12 Jun 2018 10:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IKvVEg2a/HLNw1DteRLFKGkI3QdYqSWDr5uODcYBXy4=;
        b=tEp9Q8dAngRrjtGd7t1bC108vXymM2lvxlZAwAVxH7WzmDpLBCouKGCXGZ2ULOYtHa
         Mwgo3P4cc+8ShlSWoVN6Lz0JVfP5d4XlDgkY0RMfX9Wg0jsH26a5WF56AWqOoVnnHBhA
         qoavQPsOtsyJV33mSB0/JTTzhcebeb4m7fwdynZzAmL+uITZI9RYhMdcv91z5jJ3otxI
         lSOHP3dw0HKGz2V4BQxhS7Onv5d5ncB22IA9tH1aKZgLiByfNqiM3PkKKJ+6Cz4hmOvd
         ujKvI8tNBFYqcbMuiDWj2n8iIYPhfW6lPnDs4r/zTIb4GVmu6CMNkllUzwuVaLhWvSmr
         ib4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IKvVEg2a/HLNw1DteRLFKGkI3QdYqSWDr5uODcYBXy4=;
        b=qJP5PWeFlb3JDbXJyrh99GuA+XRX6d1MTnccIws155QKYSpj4ehyGZf15TkBqxtF64
         tIUeVoV2iM0UaW8RMLb8zqRtIsqjsy05RJK/D8nbky5AEE+F1zQtjRH62S4hNkqmUt5B
         LMK5CpAq5aBYT4YjdELiFK0/mx4y2P82wQHfssSNGutGq1j1DdxXFEJD3ODQa31oPuXQ
         X4opaGC62nyqHuClRSU1W0pDKG5GKqGxiB1eUVfdLl8llHpzdfNITPxS7pUn+4WBeeDu
         pIw970FrlBRnrohRL/bHo5eMIDErtXeVGjEe60amxyLwQRu1BjK6wS20cTJXA/41RYQl
         MG+w==
X-Gm-Message-State: APt69E0TdX5WxzETWUFRhkazPSPWdNroWfvay2/x+vaZJYR5uTPJQE/2
        1B3svpNA3xG2f8Z/xJkPeBQ=
X-Google-Smtp-Source: ADUXVKL7gDE0CT+h5Dd3gb9NaTfMNzQE4c1y7DB8B4WdLWuyiTwil1eJMF7zbdIQfp+h41EQ0Nzkhw==
X-Received: by 2002:adf:8f23:: with SMTP id p32-v6mr1113001wrb.193.1528825626440;
        Tue, 12 Jun 2018 10:47:06 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id r2-v6sm1389414wmb.39.2018.06.12.10.47.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 12 Jun 2018 10:47:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] list-objects: check if filter is NULL before using
References: <20180611215126.205944-1-jonathantanmy@google.com>
Date:   Tue, 12 Jun 2018 10:47:05 -0700
In-Reply-To: <20180611215126.205944-1-jonathantanmy@google.com> (Jonathan
        Tan's message of "Mon, 11 Jun 2018 14:51:26 -0700")
Message-ID: <xmqqfu1raodi.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Tan <jonathantanmy@google.com> writes:

> In partial_clone_get_default_filter_spec(), the
> core_partial_clone_filter_default variable may be NULL; ensure that it
> is not NULL before using it.
>
> Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
> ---
> This was noticed by someone else at $DAY_JOB when trying to use a
> partial clone with no core.partialclonefilter set.

Thanks, will queue.

> ---
>  list-objects-filter-options.c | 2 ++
>  t/t0410-partial-clone.sh      | 8 ++++++++
>  2 files changed, 10 insertions(+)
>
> diff --git a/list-objects-filter-options.c b/list-objects-filter-options.c
> index 6a3cc985c4..c0e2bd6a06 100644
> --- a/list-objects-filter-options.c
> +++ b/list-objects-filter-options.c
> @@ -146,6 +146,8 @@ void partial_clone_get_default_filter_spec(
>  	/*
>  	 * Parse default value, but silently ignore it if it is invalid.
>  	 */
> +	if (!core_partial_clone_filter_default)
> +		return;
>  	gently_parse_list_objects_filter(filter_options,
>  					 core_partial_clone_filter_default,
>  					 NULL);
> diff --git a/t/t0410-partial-clone.sh b/t/t0410-partial-clone.sh
> index cc18b75c03..4984ca583d 100755
> --- a/t/t0410-partial-clone.sh
> +++ b/t/t0410-partial-clone.sh
> @@ -23,7 +23,15 @@ promise_and_delete () {
>  	delete_object repo "$HASH"
>  }
>  
> +test_expect_success 'extensions.partialclone without filter' '
> +	test_create_repo server &&
> +	git clone --filter="blob:none" "file://$(pwd)/server" client &&
> +	git -C client config --unset core.partialclonefilter &&
> +	git -C client fetch origin
> +'
> +
>  test_expect_success 'missing reflog object, but promised by a commit, passes fsck' '
> +	rm -rf repo &&
>  	test_create_repo repo &&
>  	test_commit -C repo my_commit &&
