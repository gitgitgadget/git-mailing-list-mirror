Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5A5741F6AC
	for <e@80x24.org>; Tue,  3 Jul 2018 22:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933300AbeGCWFk (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Jul 2018 18:05:40 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:55838 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932516AbeGCWFj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Jul 2018 18:05:39 -0400
Received: by mail-wm0-f65.google.com with SMTP id v16-v6so3780631wmv.5
        for <git@vger.kernel.org>; Tue, 03 Jul 2018 15:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=ZKwZKkkrH7slVXrlWY03RmhLL1oRLp9DfRs6PBQyOr0=;
        b=lx76nutpD7NRwe5VWskj4zf+DHPE9xRjt3nHglpltO+iENQicgP/fzuB9SPdA66Shy
         wvc1bIPvoFtoITZOhgTfDpI9py52UskgVwUUFO09aCQDJZInIpjmIjxTz40Ffplws3gw
         TY7PbOafkyG6zFm5Ksg4BuKMa96n8KX3ZQ/rVEW9sNoViGIzo/8WYtrGetv9anjA3t8Y
         cdvFzIlKEB5dQR2glW1Pz6kr2Nnk9Tivfg8Zmq19R/M/gZU3kT7rd8/ZaEtxZUAw+1qz
         tV30uUm36uEk9mCzl8kUbrSFrzvzJTKYwrWkgdrUGTXoDtcFlvJxiFgcnlyCQzPesYaa
         hBqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=ZKwZKkkrH7slVXrlWY03RmhLL1oRLp9DfRs6PBQyOr0=;
        b=gQnTfpxu66BzwqYQrTBn1O3L9QLYmDPycOtNFM/xJBVQyw19xNcyxzgYAW7+twik6m
         KkRJrLKBv8Ynsh45NZQLWHaEqtfO+zMf8O6FmnLUhscCYINIpDCIsRlaNQQcxi7BC3Ub
         Reidd7VvLWkMS1c2d1tzuFw9I5Ahcp0hTtvzBIs0KoDeO/tYqSk2dcGETEKUd0ySN/Ue
         jbgaxURfoFx6u0qszTlFTEL9nCkilbsHCxad4i9PcscbbeZ6HorDxgazSMGS/ip/miNo
         9v3U+9pZ2Zvp50Lc6NVcNj5Few8n29JFO5xy2H33wtBfc7c+f5hD7ST4Xstq8h7FJvMT
         dG+Q==
X-Gm-Message-State: APt69E2LisUGZfk/ACdKLjkEKFO+MOCm3p+r6gOxt0BHU13F0RNN7RNt
        KNrbA2fHAf6yJAhPxTkhF2w=
X-Google-Smtp-Source: AAOMgpcRsPay8NWaupdiScunS88715qUVHcdSklZeGNxT+lpogo3/RB45+EzZZBiPCmFbIV2RAeYhw==
X-Received: by 2002:a1c:bd5:: with SMTP id 204-v6mr5406732wml.160.1530655537901;
        Tue, 03 Jul 2018 15:05:37 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id q8-v6sm4722467wmb.3.2018.07.03.15.05.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 03 Jul 2018 15:05:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Joshua Nelson <jyn514@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/3] ls-tree: make <tree-ish> optional
References: <20180703035802.24060-1-jyn514@gmail.com>
        <CABPp-BFu+m-7Fyf4kj8hUO33vhAxKuAu5JnyL5Tzc7c6Kq+Hjg@mail.gmail.com>
Date:   Tue, 03 Jul 2018 15:05:36 -0700
In-Reply-To: <CABPp-BFu+m-7Fyf4kj8hUO33vhAxKuAu5JnyL5Tzc7c6Kq+Hjg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 3 Jul 2018 00:12:43 -0700")
Message-ID: <xmqqbmbonff3.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Mon, Jul 2, 2018 at 8:58 PM, Joshua Nelson <jyn514@gmail.com> wrote:
>> use syntax similar to `git-checkout` to make <tree-ish> optional for
>> `ls-tree`. if <tree-ish> is omitted, default to HEAD. infer arguments as
>> follows:
>>
>> 1. if args start with --
>>         assume <tree-ish> to be HEAD
>> 2. if exactly one arg precedes --, treat the argument as <tree-ish>
>> 3. if more than one arg precedes --, exit with an error
>> 4. if -- is not in args
>>         a) if args[0] is a valid <tree-ish> object, treat is as such
>>         b) else, assume <tree-ish> to be HEAD
>>
>> in all cases, every argument besides <tree-ish> is treated as a <path>
>
> Cool, this is something I've wanted a few times.

Hmph, is it, and why?  

I'd prefer *not* to have such a DWIM in a command like ls-tree, aka
plumbing commands, where predictability is worth 1000 times more
than ease of typing.
