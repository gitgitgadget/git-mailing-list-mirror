Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3B29A1F42B
	for <e@80x24.org>; Tue,  2 Jan 2018 22:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751100AbeABWtr (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Jan 2018 17:49:47 -0500
Received: from mail-qt0-f181.google.com ([209.85.216.181]:44490 "EHLO
        mail-qt0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751021AbeABWtq (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Jan 2018 17:49:46 -0500
Received: by mail-qt0-f181.google.com with SMTP id m59so65012785qte.11
        for <git@vger.kernel.org>; Tue, 02 Jan 2018 14:49:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=QMPFiQAdWsI/2mmX/gOmSj5OT1bP9tkonxyEMT2JuBY=;
        b=V6jG9Ocw8F+bD1RwPmM/MO+FdUDOQXC92wseKmh3/wgvvevYjJ69DvtrXHvFdmvhwa
         bJ7doAufMCKechrF9yzAGAD9cR1KfNPMuCBZx84WLdS2ZhiLO14zbgH1kHWvirs9MBR4
         3REz4oC1XV1aeweFuFV4dHJQKQ94BOBn7gvtxqRwZ2BgNN9S1h+cQt9a5BpWlI865Nzb
         Ydq2YufUx34l9n+eW9tMPE1r9s7UQMCxxwa8H90Yzwwzv9nh8TbnOJhNBtp38nh/G0MK
         RGz2fVadifkwECv654CnYFLgqzeJboxGOoXMa1QeiKrhW3PQJ2/H5gqvqD9fHyYiTT4D
         aA/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=QMPFiQAdWsI/2mmX/gOmSj5OT1bP9tkonxyEMT2JuBY=;
        b=g/SsFBPnyp1a4HPMq+bCTE9L08/ELQUU8YP4rWNzBO2zntOetf3f3/M43lM6ckfc4l
         VrhSkJgg2BJ0SHkyx2ZsRkaBorZYjaZlewfTFU0CwGr5+Gi+xgdRg3CVRQhortNVVHYH
         9IkKRZJ/MyRn0w0U90lKrcIRr2aPXfhRdl+Oqs3X9344/2p1a8918ZmNF5AqMMhparZX
         iJf1dQyh39J/MpnF/wBiFBJIRrejAx8m5vBpkICXTgGWWhd4slXBLH36pzmhus8K3sMj
         qcloMyZEBvzlbwqCMToy1NboyoUtHl62nD9o5EdJJCzoEQFKAbqelHqbrwvaae66MMiu
         StgQ==
X-Gm-Message-State: AKGB3mLFSv37ljQsTugeEatF5HFrzyn3llfENUGCKJhm9DoIluIcpJ9F
        7+XpnPAs42AD0EI5DxhBaiA697O0QKhb9R8Rn+E=
X-Google-Smtp-Source: ACJfBot07Lprbei+C0GhDHPJqeuf67bb/g+Rq0oQr7HLMKsSM8/BRRi8aEufkLLGEZ/ZzturrfEQUh5OEcejMd+rzYk=
X-Received: by 10.55.126.7 with SMTP id z7mr58804485qkc.306.1514933386093;
 Tue, 02 Jan 2018 14:49:46 -0800 (PST)
MIME-Version: 1.0
Received: by 10.12.198.2 with HTTP; Tue, 2 Jan 2018 14:49:45 -0800 (PST)
In-Reply-To: <20180102211139.GD22556@sigill.intra.peff.net>
References: <20180102210753.GA10430@sigill.intra.peff.net> <20180102211139.GD22556@sigill.intra.peff.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Tue, 2 Jan 2018 17:49:45 -0500
X-Google-Sender-Auth: QH4BEro_XCSKIdG5Qqc-Gj7lkyc
Message-ID: <CAPig+cQOU7d21kDELtFAkM0qJh8pvj7F56oWVYw+kYiUftQEuA@mail.gmail.com>
Subject: Re: [PATCH 4/4] clone: do not clean up directories we didn't create
To:     Jeff King <peff@peff.net>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        Stephan Janssen <sjanssen@you-get.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 2, 2018 at 4:11 PM, Jeff King <peff@peff.net> wrote:
> [...]
> Because we know that the only directory we'll write into is
> an empty one, we can handle this case by just passing the
> KEEP_TOPLEVEL flag to our recursive delete (if we could
> write into populated directories, we'd have to keep track of
> what we wrote and what we did not, which would be much
> harder).
>
> Note that we need to handle the work-tree and git-dir
> separately, though, as only one might exist (and the new
> tests in t5600 cover all cases).
>
> Reported-by: Stephan Janssen <sjanssen@you-get.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> diff --git a/t/t5600-clone-fail-cleanup.sh b/t/t5600-clone-fail-cleanup.sh
> @@ -42,13 +53,48 @@ test_expect_success 'successful clone must leave the directory' '
> +test_expect_success 'failed clone into empty leaves directory (separate, git)' '
> +       mkdir -p empty-git &&
> +       corrupt_repo &&
> +       test_must_fail git clone --separate-git-dir empty-git foo no-wt &&
> +       test_dir_is_empty empty-git &&
> +       test_path_is_missing no-wt
> +'
> +
> +test_expect_success 'failed clone into empty leaves directory (separate, git)' '
> +       mkdir -p empty-wt &&
> +       corrupt_repo &&
> +       test_must_fail git clone --separate-git-dir no-git foo empty-wt &&
> +       test_path_is_missing no-git &&
> +       test_dir_is_empty empty-wt
> +'

The final two tests seem to have the same title...
