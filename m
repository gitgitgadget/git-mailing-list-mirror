Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CBE1C43334
	for <git@archiver.kernel.org>; Mon, 25 Jul 2022 06:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiGYGIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jul 2022 02:08:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGYGII (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jul 2022 02:08:08 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD505DF4F
        for <git@vger.kernel.org>; Sun, 24 Jul 2022 23:08:05 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id p5so1568088edi.12
        for <git@vger.kernel.org>; Sun, 24 Jul 2022 23:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=kiOl8hIbgqYjPHotGlirT6UsRZYyYgaL4hoNNJzzpgk=;
        b=Q9NfbDlUBtIL94qMK6/uOB47VMCx3W23/AupSJKk0u1mX8ZBWiYw+p380l9+t0ooe2
         7LuEQx19ndC8QTYfKJKl7LY3Iwee7nZVNIfd4rhvyd8mgyV3QTaqN5L15o1j9otZpEp0
         eVRN275jNjQ8I4NLOVTxNjoO6RJCK4bl/iRxFuiRjxpMtmGTBmAhqLwHqMbWGULOzZHq
         SIuzgD+eG/hA8s4qgh8AvRtRmx6F2+QF9U/s5/LD4+2Q7CyU+35FhvAU3ftOkbqSGgbS
         DhHcAUJSoyUnknFVozSzXw8CbUqfQOd8a3GwaQ4coJ+Rz62b1DJw3UdkBi0OwaMuw8Pf
         xKIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=kiOl8hIbgqYjPHotGlirT6UsRZYyYgaL4hoNNJzzpgk=;
        b=avSrhr6LHrVyXjYnYXMwrFA7DcYtKhtFma3OLCyMrCSZHfVUu99IDfV1rgKOVLbnLv
         j8hdWGw/JHVGNuRa3vnPDeBn9rrNblKrDFVvQR4oZNr/BfIYoBDqy17ws8+PSyDazKX8
         uBxqxKH1tDYHO6gimgVtKd73F3Jx90610XgTVmvI/zw64us6BtJ9wz1DBwBbqI1BFU7f
         d1ly32sJiqMeQLIxUHdsSoOOtJsPEjxmXfEDrtaoyaEgTiQ8pFaixKfo9R2CIAC58yhx
         zhGfW+U0HaD1N14+g9kcvrY+Hl9jyEchsWLkh5X2kIZdU/IHJXXau1Ek+rMeRNK54lxY
         nSwQ==
X-Gm-Message-State: AJIora978M3b0EenltYX8tw7ZMCEFxdEWhhNT+T5SL2T44RW8XfuVWs7
        zdRxrX5QFyK0KOwMgSPZhNJeFWzefFY=
X-Google-Smtp-Source: AGRyM1vtlTk1IeDgvHCQjxGTX/HuhfHoqKFiFkwVNdaNveCx31zl66XZrHcgrLQofI4yDh3izfhB1w==
X-Received: by 2002:a05:6402:2687:b0:43a:6025:1658 with SMTP id w7-20020a056402268700b0043a60251658mr11225211edd.271.1658729283846;
        Sun, 24 Jul 2022 23:08:03 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d19-20020a170906305300b006fe8ac6bc69sm5011182ejd.140.2022.07.24.23.08.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Jul 2022 23:08:03 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1oFrG6-005aQe-H9;
        Mon, 25 Jul 2022 08:08:02 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, chooglen@google.com, gitster@pobox.com,
        newren@gmail.com, levraiphilippeblain@gmail.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v5] submodule merge: update conflict error message
Date:   Mon, 25 Jul 2022 08:05:42 +0200
References: <20220712231935.2979727-1-calvinwan@google.com>
 <20220718214349.3379328-1-calvinwan@google.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <20220718214349.3379328-1-calvinwan@google.com>
Message-ID: <220725.868rohragt.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jul 18 2022, Calvin Wan wrote:


One of the CI failures in "seen" is because of my topic to mark (among
other things) t1500*.sh as passing with SANITIZE=leak, and this change.

Because...

> ..
>  	object_array_clear(&merges);
>  cleanup:
> +	if (!ret) {
> +		if (!csub) {
> +			CALLOC_ARRAY(csub, 1);
> +		}
> +		csub_item.oid = xstrdup(repo_find_unique_abbrev(&subrepo, b, DEFAULT_ABBREV));
> +		csub_item.path = xstrdup(path);
> +		csub_item.resolution_exists = resolution_exists;
> +		ALLOC_GROW(csub->items, csub->nr + 1, csub->alloc);

... in "cleanup" we're ALLOC_GROW()-ing? I haven't looked into this yet,
but this seems susppect. This is line 1879 in the following stacktrace:
	
	+ git -C super merge branch1
	Failed to merge submodule dir/sub
	CONFLICT (submodule): Merge conflict in dir/sub
	Recursive merging with submodules currently only supports trivial cases.
	Please manually handle the merging of each conflicted submodule.
	This can be accomplished with the following steps:
	 - go to submodule (dir/sub), and either merge commit 7018b5f
	or update to an existing commit which has merged those changes
	 - come back to superproject, and `git add dir/sub` to record the above merge or update
	 - resolve any other conflicts in the superproject
	 - commit the resulting index in the superproject
	Automatic merge failed; fix conflicts and then commit the result.
	
	=================================================================
	==31261==ERROR: LeakSanitizer: detected memory leaks
	
	Direct leak of 576 byte(s) in 1 object(s) allocated from:
	    #0 0x4565ad in __interceptor_realloc (git+0x4565ad)
	    #1 0x76ecfd in xrealloc wrapper.c:136:8
	    #2 0x64fcd3 in merge_submodule merge-ort.c:1879:3
	    #3 0x64ee9b in handle_content_merge merge-ort.c:2118:11
	    #4 0x651c14 in process_entry merge-ort.c:4056:17
	    #5 0x648c05 in process_entries merge-ort.c:4267:4
	    #6 0x646c03 in merge_ort_nonrecursive_internal merge-ort.c:4893:2
	    #7 0x6470f3 in merge_ort_internal merge-ort.c:4982:2
	    #8 0x646de0 in merge_incore_recursive merge-ort.c:5033:2
	    #9 0x652d1a in merge_ort_recursive merge-ort-wrappers.c:57:2
	    #10 0x4ec0f6 in try_merge_strategy builtin/merge.c:764:12
	    #11 0x4e9bf2 in cmd_merge builtin/merge.c:1710:9
	    #12 0x45a3aa in run_builtin git.c:466:11
	    #13 0x458e41 in handle_builtin git.c:720:3
	    #14 0x459d85 in run_argv git.c:787:4
	    #15 0x458bfa in cmd_main git.c:920:19
	    #16 0x56a049 in main common-main.c:56:11
	    #17 0x7fe592bca81c in __libc_start_main csu/../csu/libc-start.c:332:16
	    #18 0x431139 in _start (git+0x431139)
