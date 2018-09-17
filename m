Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 463B51F404
	for <e@80x24.org>; Mon, 17 Sep 2018 19:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728080AbeIRAhb (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 20:37:31 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:39150 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727672AbeIRAhb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 20:37:31 -0400
Received: by mail-wm1-f65.google.com with SMTP id q8-v6so10931587wmq.4
        for <git@vger.kernel.org>; Mon, 17 Sep 2018 12:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7qxBCRcufoE06+Y6he2T9UonUvLHM/VGc/jga8q4Rvw=;
        b=VbwkBN19kfbZu3UgdHkNoVUk2rW8VTFORjvqNHdpyghk2xYN1eqHjRAR9nNgfzdPTC
         kJIP5M2Jf74V7q3cXd5cBZbzaqk71aF3LOY7UKTiqLpysKkQHecycKZEZu4ncjsUwgJE
         pTtRojswtO6KIA68CmFDBlTkeQBbEGH2KRb6cinBdRculJi+YqOTc2swReAkLFlNe3Lp
         MXYQYBdo1ZFTyb4ZoJhoof2oh4h0TnSAVWoG3+sQdMh5U8S4DTGdmJ1j0x0B8Iwnn40o
         WdDRX836Ku9oH2dAGQKF7XR+qnW37Xsv2ylGbxAFQp/mv3UMblI+bO/cwa3pI0P74S4R
         jWcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7qxBCRcufoE06+Y6he2T9UonUvLHM/VGc/jga8q4Rvw=;
        b=IsdMTmkzG78MuSus885Pq4jIBQ2qLwp7ir70qQQ/3yR9AXsH2nO4abu9MJD2c1puaK
         bLpHtsK5fgOdgQIZVxby99CZMCfsnxP6PCKSoFQyvl/hYFxRFtLmAY2CgB+gG5Gpt7mu
         ZC3Ep9QE62yAc91XGaifh+DCyx7WLYJdZ3RVJ+E1up2H0gT4jg0NBljgRBb9pb6E+DXz
         SFwOSTX9n3t7Xa2g7PJVah9TuKLf6IvJBiGdLbg0GkwhaAFhTln/Qak1DkXnIdaspb0b
         PeYKVlTV1QbSXq7s+8ffqvYygKKc2GVciYqYdjolyGTCJnY45rujCriAJVZ9ny7owS5f
         7bsQ==
X-Gm-Message-State: APzg51DUJEcmcWG1Xx1ICmdjFHV0NkjiUgu1weke7bp3QPs4glYBCLSh
        /lC+IUQYMkgMDQBu0xi2dKU=
X-Google-Smtp-Source: ANB0VdZq/Q5Rv8sIidZTaGhvlr1UizniR372TpLlgrIJJRtaaQecr7CefW1c4fICpnXHGHHuZLf1Ww==
X-Received: by 2002:a1c:cb4d:: with SMTP id b74-v6mr13072242wmg.123.1537211329355;
        Mon, 17 Sep 2018 12:08:49 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w3-v6sm13879128wru.93.2018.09.17.12.08.48
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Sep 2018 12:08:48 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Ben Peart <peartben@gmail.com>, Ben Peart <benpeart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v5 1/5] eoie: add End of Index Entry (EOIE) extension
References: <20180823154053.20212-1-benpeart@microsoft.com>
        <20180912161832.55324-1-benpeart@microsoft.com>
        <20180912161832.55324-2-benpeart@microsoft.com>
        <CACsJy8B51s2j0aR69UdwtpSbRN6qdLy--am_tyP5Xqo=5Zm_7g@mail.gmail.com>
        <f7250999-71a3-0113-2858-e66bad283db3@gmail.com>
        <CACsJy8DEvLJYBm0P1VtvKFD-CAo6_4Z13dBHWkuuAavghbGBag@mail.gmail.com>
        <xmqqsh286nfs.fsf@gitster-ct.c.googlers.com>
        <CACsJy8CqaEGDaEAgp1EspR+BwyHB6YSPoppZ2t5M+qxg77hULg@mail.gmail.com>
Date:   Mon, 17 Sep 2018 12:08:48 -0700
In-Reply-To: <CACsJy8CqaEGDaEAgp1EspR+BwyHB6YSPoppZ2t5M+qxg77hULg@mail.gmail.com>
        (Duy Nguyen's message of "Mon, 17 Sep 2018 19:38:43 +0200")
Message-ID: <xmqqfty86iwv.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> I get annoyed by the "ignoring unknown extension xxx" messages while
> testing though (not just this extension) and I think it will be the
> same for other git implementations. But perhaps other implementations
> just silently drop the extension. Most of the extensions we have added
> so far (except the ancient 'TREE') are optional and are probably not

Most of the index extensions are optional, including TREE.  I think
"link" is the only one that the readers that do not understand it
are told to abort without causing damage.

> present 99% of time when a different git impl reads an index created
> by C Git. This 'EIOE' may be a good test then to see if they follow
> the "ignore optional extensions" rule since it will always appear in
> new C Git releases.

I think we probably should squelch "ignoring unknown" unless some
sort of GIT_TRACE/DEBUG switch is set.

Patches welcome ;-)

Thanks.

