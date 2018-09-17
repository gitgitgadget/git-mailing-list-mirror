Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 52B251F404
	for <e@80x24.org>; Mon, 17 Sep 2018 19:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728007AbeIRAmC (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 20:42:02 -0400
Received: from mail-wm1-f41.google.com ([209.85.128.41]:35010 "EHLO
        mail-wm1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727052AbeIRAmC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 20:42:02 -0400
Received: by mail-wm1-f41.google.com with SMTP id o18-v6so10954035wmc.0
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 12:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=921zPcIf/wksDaGvqnzLB2YPHNVruPRri1FMCPFRwo0=;
        b=T5CddndjGZIGnwKSjlx4W+7QBkc/OAIxqtI7FE3RZcML7geYGW+XWXWBqJ9GUhtUEn
         qvl1DOoy7/inEus4YEc6wfZewc6vxaJfJG+CBbQYN7drA6y5of80zcUDnGhsiKvGqjkU
         d/g7XJZL0ftwz1dRvw0EJGoHe890mrC999mFrW9N5XnzGzdoW/mNsSR1hn57mcf+PtE9
         YY/B2UzyIxPOSakLq8yStHYaXOyRM8PUn8cT2fiWTKJLQo7KFzBOgtAwb/g9bk0umlRH
         7g9VmBlBBxnVb08oxXoVGmUWPQmCyoLo+cv61KUtkq3bmVanQPR85gLccTLszfSXDggC
         +Rbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=921zPcIf/wksDaGvqnzLB2YPHNVruPRri1FMCPFRwo0=;
        b=sGAy0BJbrPDozs++/LOEA5lnakkVVwxwZbDoWBHEwoHPHmAuqH2vwrkJFiQgrzu7xn
         yO5uZ1EXXwi+YIoRWHcg+P3l2kX2B4R4939NwlllnMLl5MoncIOt1OUwqoMOz7upliuI
         HmyIHIQf6g/+FE61xzkum03d+IydNiZgT/B0Qx709rjw9depBJFFfBSmorENwtnH4Feu
         KXHWtU8f/ccSdr3ByNottxLwL0++0ydnHkWAP49oK/9kEMeulCusWay0ZvCAZGuqW7S6
         CEoSsAjzYMnmhxn4pTc9mepLHeaI+zYM5IfhBIBCuw/8M7dqmRBCTqF82TDncOmk6r71
         245g==
X-Gm-Message-State: APzg51A+DpuFs8aR4KBu8OuvafYt4sjkzeUHpTAMUMosr4SkBShHNQ4W
        UTL86p/SFfl33pafGSvfg8I=
X-Google-Smtp-Source: ANB0VdYa2if95owwOhDu5LkibGCR1ng6TNLIoPp7kRMWUmw6OhrBoiHR7Qps86jcVyAShy0p+WS30A==
X-Received: by 2002:a1c:b286:: with SMTP id b128-v6mr12026157wmf.121.1537211599053;
        Mon, 17 Sep 2018 12:13:19 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id d1-v6sm32381849wrc.52.2018.09.17.12.13.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 12:13:18 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 02/23] read-cache.c: remove 'const' from index_has_changes()
References: <20180909085418.31531-1-pclouds@gmail.com>
        <20180915161759.8272-1-pclouds@gmail.com>
        <20180915161759.8272-3-pclouds@gmail.com>
        <xmqqo9cw851q.fsf@gitster-ct.c.googlers.com>
        <CACsJy8A6ox7gRp6pNJWy-Yb_+gQDPZJYfAmKd+of8MAdajic4A@mail.gmail.com>
Date:   Mon, 17 Sep 2018 12:13:17 -0700
In-Reply-To: <CACsJy8A6ox7gRp6pNJWy-Yb_+gQDPZJYfAmKd+of8MAdajic4A@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 17 Sep 2018 18:53:34 +0200")
Message-ID: <xmqqbm8w6ipe.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Mon, Sep 17, 2018 at 6:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:
>>
>> > This function calls do_diff_cache() which eventually needs to set this
>> > "istate" to unpack_options->src_index (*). This is an unfortunate fact
>> > that unpack_trees() _will_ destroy src_index so we can't really pass a
>>
>> Wasn't the whole point of introducing src_index and dst_index to
>> unpack-trees API so that we can keep the src_index read-only by
>> writing the result of merge to a separate in-core dst_index?
>>
>> What does the above exactly mean by "will destroy src_index"?  Is it
>> now fundamental that src_index needs to lack constness, or is it
>> something easy to fix?
>
> "destroy" is probably a strong word, but we do modify the src_index, e.g.
>
>  mark_all_ce_unused(o->src_index);
>  mark_new_skip_worktree(.., o->src_index...
>  move_index_extensions(&o->result, o->src_index);
>  invalidate_ce_path();
>
> all these update the source index. It is possible to fix, but I don't
> think it's exactly easy and may even incur some performance cost (e.g.
> if we stop modify ce_flags in the src_index, then we need to do one
> extra lookup to wherever we store these flags).

Ah, OK.  I thought that we'd be doing something, if write_tree() is
called on src_index before and after these operation, to cause us to
see two different trees, which made me worried.

But what you mean is that transient bits in the istate or cache
entries reachable from it are touched while we perform operations
that are read-only in spirit, and we need to pass non const pointer
around.

The phrasing in the log message does need to be updated to avoid
similar confusion by future readers, but I think I understand and
agree with the direction/approach.

Thanks.



