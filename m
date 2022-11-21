Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B892C4332F
	for <git@archiver.kernel.org>; Mon, 21 Nov 2022 11:42:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231233AbiKULmu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Nov 2022 06:42:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbiKULmL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Nov 2022 06:42:11 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFD210040
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 03:41:57 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id n17so10901693pgh.9
        for <git@vger.kernel.org>; Mon, 21 Nov 2022 03:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NibhDelDFXodKp9KgQUvfvEzNWCU6C18nhXzXa6Y70o=;
        b=SyRQZyOhoihHtPhPBPPbyt84BHoM2PChMfMSLdNpQlbFmZoyvb1osYHC0I5mdmqWkk
         E0axjJ+kjxC7G7NegegsHWmckpsVS7oQE6MDtwFmyt9yU386jZjz5hjZWP1kNljq8p+B
         WaNKVg+xzYTO8iOfRDd7NExaLxJPnc/ssksGStmiyFB/nnOnSgPZaw5SnfaiBUQ+ca61
         6Q/pt0tsRyyeDvhuJqNb+qOzZE+871nfMBqIiJC2o4l6DQlOLTHl0JYwUFL7yxvl7nTI
         1qUoNY203ghSXwwjSF54DgJ0PiR4Z2BU/0N9/PRKAv5fKPzJqq647IoKriHf2xFEUNwa
         jXQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NibhDelDFXodKp9KgQUvfvEzNWCU6C18nhXzXa6Y70o=;
        b=Xy/bcrvoMh7O2tGsnNSNR76MD/qYn+OtKlrpiCPKwmNtDcIqjtAfh/KlbJ6uyLIo/G
         iOEDO/AY0LSAVziOKIO/hTEvu3PR5lQejrQbUpgj0BqAxJr5RfROqa/i7R6AfPVSOQgM
         K1lccXM1dwwfXb9r6jwRGjuE9TmQY6J8S0Pf0Dw7XCJKsr0dAmcyqR5v0Ro5Sg7clyE0
         r0XgakwH1MAQeuF3+E+6/dN77s88Umaa79F5n1kOGG4pevfN/K71qcqZfPLxKpPsCQOg
         wHzX3CKat3KkzrWCO5X1aL9IGEIdXShce1lFBRNj9R56YK0jaJ/qAK+UFiHsN+LPRwCU
         JBTQ==
X-Gm-Message-State: ANoB5pl895qzlnKOnrCiECsbPiGuOday61GYFZ8MD1Tl3nWhJ0MqR/bx
        RN7Fy1rJ0WwgZG6H5UNCWwQ=
X-Google-Smtp-Source: AA0mqf6JGDJmSyQAtadM5nQSgWBo79Fq6qjBYxJie9i0C+BneaXM4ylFmZo6FWdQ4DlziAN4Rztj+Q==
X-Received: by 2002:aa7:8608:0:b0:52f:db84:81cf with SMTP id p8-20020aa78608000000b0052fdb8481cfmr2446474pfn.26.1669030916917;
        Mon, 21 Nov 2022 03:41:56 -0800 (PST)
Received: from localhost.localdomain ([47.246.101.53])
        by smtp.gmail.com with ESMTPSA id v4-20020a1709029a0400b001782398648dsm9569866plp.8.2022.11.21.03.41.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Nov 2022 03:41:56 -0800 (PST)
From:   Teng Long <dyroneteng@gmail.com>
X-Google-Original-From: Teng Long <tenglong.tl@alibaba-inc.com>
To:     me@ttaylorr.com
Cc:     avarab@gmail.com, dyroneteng@gmail.com, git@vger.kernel.org,
        tenglong.tl@alibaba-inc.com
Subject: Re: [RFC PATCH 0/6] ls-tree: introduce '--pattern' option
Date:   Mon, 21 Nov 2022 19:41:50 +0800
Message-Id: <20221121114150.3473-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.38.1.383.g9d5a491887b
In-Reply-To: <Y3ave2+kEwLTvtE6@nand.local>
References: <Y3ave2+kEwLTvtE6@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> I think this falls into the same trap as the series on 'git show-ref
> --count' that I worked on earlier this year [1].
>
> At the time, it seemed useful to me (since I was working in an
> environment where counting the number of lines from 'show-ref' was more
> cumbersome than teaching 'show-ref' how to perform the same task
> itself).
>
> And I stand by that value judgement, but sharing the patches with the
> Git mailing list under the intent to merge it in was wrong. Those
> patches were too niche to be more generally useful, and would only serve
> to clutter up the UI of show-ref for everybody else.
>
> So I was glad to drop that topic. Now, I'd be curious to hear from Teng
> whether or not there *is* something that we're missing, since if so, I
> definitely want to know what it is.
>
> But absent of that, I tend to agree with Ævar that I'm not compelled by
> replacing 'ls-tree | grep <pattern>' with 'ls-tree --pattern=<pattern>',
> especially if the latter is slower than the former.
>
> Thanks,
> Taylor
>
> [1]: https://lore.kernel.org/git/cover.1654552560.git.me@ttaylorr.com/

honestly, I just think it's useful to me, but omit the performance recession of
the option. I originally thought about it looks like the "git tag -l <pattern>"
or "git branch -l <pattern>" usage, but it seems not as a regex matching on
them and it indeed executes faster than the pipe grep, because it seems like the
former has the more restrictive matching conditions (because if I move the
last aster， there is no output):


✗ git branch -r --list "avar*" | wc -l
    1498

✗ hyperfine 'git branch -r --list "avar*"'
Benchmark 1: git branch -r --list "avar*"
  Time (mean ± σ):      69.8 ms ±   3.1 ms    [User: 25.8 ms, System: 42.7 ms]
  Range (min … max):    66.6 ms …  81.8 ms    35 runs

✗ hyperfine 'git branch -r --list | grep "avar"'
Benchmark 1: git branch -r --list | grep "avar"
  Time (mean ± σ):      76.4 ms ±   3.7 ms    [User: 32.7 ms, System: 45.2 ms]
  Range (min … max):    72.9 ms …  85.5 ms    34 runs

➜  Documentation git:(tl/extra_bitmap_relative_path) ✗ git branch -r --list "avar" | wc -l
       0

So unless someone finds other benefits, such as the implementation of "git tag
-l <pattern>" to solve the performance problem, this method can bring benefits
in the corresponding scenario. It's ok for me to continue or stop this patch.

Thanks.
