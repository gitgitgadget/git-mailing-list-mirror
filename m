Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6FEB6207D6
	for <e@80x24.org>; Tue, 25 Apr 2017 04:30:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S973433AbdDYEaU (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Apr 2017 00:30:20 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:33809 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753722AbdDYEaT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Apr 2017 00:30:19 -0400
Received: by mail-io0-f171.google.com with SMTP id a103so207335418ioj.1
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 21:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lkqTobVf0WUcH1mxytEsSOQqo12YO0ZtPXlcXGBE76g=;
        b=eXCdpBjlfGS7nKNq69204yC9SmncqdpY0lrv1tI6GZKwecB4epegVpoPeQyxa0a4OQ
         rSLrSXlFBDMSeBosteiNpXkrkHVaBUhL5oDrxvOQpLibrrqvL6UUIrZvB7S9vq5CpWXt
         5bT5tPJa2AyF1Wgkrf5fAYgjYDPjK27S5rUEJ17sZYm816vd7+MPsoc49nOVJt57DBFd
         MBozR+3KHj5uh+BVg4UDTeeQ4lc0ml/R4pzBjigu0gk5XWRuYPt+88UstbqAnyx89TwY
         ZcoV1wuS81lyONbQ4XQulFHYhnynGXJA8I3b8wBA/azPY7Ets4leJ3z6ipvEUAdJrDtr
         3gVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lkqTobVf0WUcH1mxytEsSOQqo12YO0ZtPXlcXGBE76g=;
        b=oa/E0UDwkOsyElXaWTkptsZRcPttpEh69fwobxKF2hkiU7w+lVCIXVSuDVn8kPLfHx
         SZxo3/iuo6+uYPPY7ve8Tkusk37AAQxuOP1e7GVTzJ4tACUHh79Vr3+Iqma0DbAgyjTk
         UTLl8hymvl7TiHaCTEDg28EQD2WDFoarPlZDErEc2aBunp+LCI21DE6v+5y87D5LvPH3
         tlTsLHIlf6Fwv5RgS0g3W2N2JqdX3Bs+wj1BlLJW0HgHTTVFyQk2qFodsb1Vz+fJzJ6M
         tqA/q6UbnoZtSo0vHV8nbnyW/CMv7/+s24RZyLp/tkCp/SGEqyfcwWQfGh35WlnzthsQ
         KXdA==
X-Gm-Message-State: AN3rC/7W37BoY6C1tsiVa6wBm4OSG2p8i0HJaCDcJUxrKbnsmGi02OWP
        18vrm5SlG7YSZg==
X-Received: by 10.107.11.159 with SMTP id 31mr11656099iol.41.1493094617998;
        Mon, 24 Apr 2017 21:30:17 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:894:a17f:b6e3:25e8])
        by smtp.gmail.com with ESMTPSA id y22sm6903928ioi.26.2017.04.24.21.30.17
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 24 Apr 2017 21:30:17 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v5 0/6] Kill manual ref parsing code in worktree.c
References: <20170404102123.25315-1-pclouds@gmail.com>
        <20170424100124.24637-1-pclouds@gmail.com>
Date:   Mon, 24 Apr 2017 21:30:16 -0700
In-Reply-To: <20170424100124.24637-1-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Mon, 24 Apr 2017 17:01:18 +0700")
Message-ID: <xmqqbmrlw1lz.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> v5 chanes are mostly cosmetic:

Good changes.  Will re-queue.

Thanks.

>
> diff --git a/refs.c b/refs.c
> index 5d31fb6bcf..7972720256 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1530,11 +1530,7 @@ struct ref_store *get_main_ref_store(void)
>  	if (main_ref_store)
>  		return main_ref_store;
>  
> -	main_ref_store = ref_store_init(get_git_dir(),
> -					(REF_STORE_READ |
> -					 REF_STORE_WRITE |
> -					 REF_STORE_ODB |
> -					 REF_STORE_MAIN));
> +	main_ref_store = ref_store_init(get_git_dir(), REF_STORE_ALL_CAPS);
>  	return main_ref_store;
>  }
>  
> @@ -1597,9 +1593,6 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
>  struct ref_store *get_worktree_ref_store(const struct worktree *wt)
>  {
>  	struct ref_store *refs;
> -	unsigned int refs_all_capabilities =
> -		REF_STORE_READ | REF_STORE_WRITE |
> -		REF_STORE_ODB | REF_STORE_MAIN;
>  	const char *id;
>  
>  	if (wt->is_current)
> @@ -1612,10 +1605,10 @@ struct ref_store *get_worktree_ref_store(const struct worktree *wt)
>  
>  	if (wt->id)
>  		refs = ref_store_init(git_common_path("worktrees/%s", wt->id),
> -				      refs_all_capabilities);
> +				      REF_STORE_ALL_CAPS);
>  	else
>  		refs = ref_store_init(get_git_common_dir(),
> -				      refs_all_capabilities);
> +				      REF_STORE_ALL_CAPS);
>  
>  	if (refs)
>  		register_ref_store_map(&worktree_ref_stores, "worktree",
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 690498698e..b26f7e41ce 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -467,6 +467,10 @@ struct ref_store;
>  #define REF_STORE_WRITE		(1 << 1) /* can perform update operations */
>  #define REF_STORE_ODB		(1 << 2) /* has access to object database */
>  #define REF_STORE_MAIN		(1 << 3)
> +#define REF_STORE_ALL_CAPS	(REF_STORE_READ | \
> +				 REF_STORE_WRITE | \
> +				 REF_STORE_ODB | \
> +				 REF_STORE_MAIN)
>  
>  /*
>   * Initialize the ref_store for the specified gitdir. These functions
>
> Nguyễn Thái Ngọc Duy (6):
>   environment.c: fix potential segfault by get_git_common_dir()
>   refs.c: make submodule ref store hashmap generic
>   refs: add REFS_STORE_ALL_CAPS
>   refs: introduce get_worktree_ref_store()
>   worktree.c: kill parse_ref() in favor of refs_resolve_ref_unsafe()
>   refs: kill set_worktree_head_symref()
>
>  branch.c                               |  15 ++---
>  environment.c                          |   2 +
>  refs.c                                 | 100 ++++++++++++++++++++------------
>  refs.h                                 |  12 +---
>  refs/files-backend.c                   |  44 --------------
>  refs/refs-internal.h                   |   4 ++
>  t/helper/test-ref-store.c              |  18 ++++++
>  t/t1407-worktree-ref-store.sh (new +x) |  52 +++++++++++++++++
>  worktree.c                             | 102 +++++++++------------------------
>  worktree.h                             |   2 +-
>  10 files changed, 177 insertions(+), 174 deletions(-)
>  create mode 100755 t/t1407-worktree-ref-store.sh
