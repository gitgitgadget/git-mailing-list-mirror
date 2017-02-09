Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1D8461FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 19:48:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753697AbdBITsa (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 14:48:30 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:33966 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752243AbdBITs3 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 14:48:29 -0500
Received: by mail-pf0-f194.google.com with SMTP id y143so821391pfb.1
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 11:48:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qVPPMhz6K01K/kMJ1RUDt5vSa6zFC2Uyb1P0WBqcuZA=;
        b=bnZ8wq5n2a0d9wQiwnKHs5VvlAefUfL0U59Kv9S0qDJk792iph9yYFVya09/osUXdh
         vf5EBEvotq8Yxh9csHSfaLfJVtb4MutYHhBPc114rKdVK2icJmc1ls4MdHC+MN4EEsMZ
         jHTQW7G/ZYkcgpXay3r4bpUDpPAm4cyBOBNaVEOqjsC5UnexX5bdVhLW4cCfdaR1hPWJ
         FHAodj6LY2DgadwrO7+3kE+6rRes0ZkYma7depC+WQlZSpQWpWzYPLQWB9AgHPvWTyJj
         WRHGZSEo1A3pIJCM4HSh7Lj/uuUCbne/ei+PqBYNgdK5oBnEeS3NmIhHNDv036zXfmQH
         ZGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qVPPMhz6K01K/kMJ1RUDt5vSa6zFC2Uyb1P0WBqcuZA=;
        b=oNkl7xHgdxvjkp87/4s8Zy5BYkO95itnNBYpEOjHwoxHbqEDjwiAuoisvZ1rCsmvUp
         /ADPcWuv7OcepYM2H0eZ6HZmDbWUdT4l3VBSl0E3k3lwksKBM5vwY+Os1bncUymwx9K+
         eC5L/4eX4CroxwxrepTH6ALWM8OBTPZGBbOhwsWwTADpqY0pj19YE7NUFUVr3CFJ1c/I
         Iv2bH1965lvkU0h9f9xTsCdA0+69Anus2Cm1xE7rLn+gZMUEFzk27ojsJnOPbXQ4Klai
         HPgwS6qCVIn13zndv0XnTodD73tHlcjtxQicKDFma5hSeT48OgoAOMAwQgsOzbzbbQUd
         UJiw==
X-Gm-Message-State: AMke39n7oa9jMSmklDFeNh1Uif5OZdEqIPnVrBIvoSVPqE1eHyjoQWnPn26dtDwkhwAIpA==
X-Received: by 10.98.71.199 with SMTP id p68mr5564220pfi.104.1486669708382;
        Thu, 09 Feb 2017 11:48:28 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:704f:61dd:c9f4:9782])
        by smtp.gmail.com with ESMTPSA id r16sm30920847pfg.76.2017.02.09.11.48.27
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 09 Feb 2017 11:48:27 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] Store submodules in a hash, not a linked list
References: <cover.1486629195.git.mhagger@alum.mit.edu>
Date:   Thu, 09 Feb 2017 11:48:27 -0800
In-Reply-To: <cover.1486629195.git.mhagger@alum.mit.edu> (Michael Haggerty's
        message of "Thu, 9 Feb 2017 14:26:57 +0100")
Message-ID: <xmqqlgtfp2lw.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Michael Haggerty <mhagger@alum.mit.edu> writes:

> I have mentioned this patch series on the mailing list a couple of
> time [1,2] but haven't submitted it before. I just rebased it to
> current master. It is available from my Git fork [3] as branch
> "submodule-hash".
>
> The first point of this patch series is to optimize submodule
> `ref_store` lookup by storing the `ref_store`s in a hashmap rather
> than a linked list. But a more interesting second point is to weaken
> the 1:1 relationship between submodules and `ref_stores` a little bit
> more.
>
> A `files_ref_store` would be perfectly happy to represent, say, the
> references *physically* stored in a linked worktree (e.g., `HEAD`,
> `refs/bisect/*`, etc) even though that is not the complete collection
> of refs that are *logically* visible from that worktree (which
> includes references from the main repository, too). But the old code
> was confusing the two things by storing "submodule" in every
> `ref_store` instance.
>
> So push the submodule attribute down to the `files_ref_store` class
> (but continue to let the `ref_store`s be looked up by submodule).
>
> The last commit is relatively orthogonal to the others; it simplifies
> read_loose_refs() by calling resolve_ref_recursively() directly using
> the `ref_store` instance that it already has in hand, rather than
> indirectly via the public wrappers.
>
> Michael
>
> [1] http://public-inbox.org/git/341999fc-4496-b974-c117-c18a2fca1358@alum.mit.edu/
> [2] http://public-inbox.org/git/37fe2024-0378-a974-a28d-18a89d3e2312@alum.mit.edu/
> [3] https://github.com/mhagger/git
>
> Michael Haggerty (5):
>   refs: store submodule ref stores in a hashmap
>   refs: push the submodule attribute down
>   register_ref_store(): new function
>   files_ref_store::submodule: use NULL for the main repository
>   read_loose_refs(): read refs using resolve_ref_recursively()

Thanks.  Will queue on mh/submodule-hash forked from 'maint'.
