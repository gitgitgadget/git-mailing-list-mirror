Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ADCA01F453
	for <e@80x24.org>; Tue, 16 Oct 2018 07:57:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbeJPPq4 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 11:46:56 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:46828 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbeJPPq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 11:46:56 -0400
Received: by mail-wr1-f67.google.com with SMTP id n11-v6so24184832wru.13
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 00:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=IRZJ/LO0rQm+ygcftKB6fymugEdBvM1uFmyPZQ/Bpe4=;
        b=V2o9fjyyOX3fl78BqUzg2YYYZnpIhZhAUBvG5eUZ3Nf7XsQh+jOJy+BBL8fqfq+QZf
         vmBIVS53tq+o69/tb//U6hZrZIz1RIfSmnYoDAT5ZnmUneAwPv2oR7RHkHwa+E6eU/ux
         ag/atEwYOK5U0jjrwyK/s7UtE208NUbLowji9RalLpeWUieZ3/MBi4l2jdjSam6rm5IY
         HSE3F3TUN54ctnkT5EsrDXHvtfJJ1vrFpZcRcGSvzZXJGqexdwEZHBSKllQbDZQY3IjY
         3Us+AdrXM4PJFc+w/x0tQyDv6TpFq3dQ6Qm6K0iZNaZhaPbwT93r2hWWcyuvuUSs3Ems
         Glaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=IRZJ/LO0rQm+ygcftKB6fymugEdBvM1uFmyPZQ/Bpe4=;
        b=mLyvBnTYQbgUmY0MwWPEGF95MAwJqA9InyxWH+Fgu7elEkDWdR7JMEsg4yT8mvt/iy
         +uyS63gukvn5RXzzPqN8MoHmYO0xypWRWW5mGxYvWoPVspQP0M7fNglGftje0rhu1e9F
         6+nb8xqf3y7j4X29pUiX98mZIf+5mrVnFsZ3KqsZ2WFLRatC7uLRyMBVi8FG15ngTmzJ
         WUcoFT8mLJXGEyjnt6bE3I4xHQCkkOop7n9tv2qBhjwF0FG3+gejaf6ZQsHhxtNr7Ji8
         g2JmrqIuCt8KD5BXGE58M4xjShNR49Ej5MTmGUUKXONi6i5XGjERuYL2zXxOC7XTnvx0
         M/FA==
X-Gm-Message-State: ABuFfojsZyJ2fRugkm5Hbntx54Darq1vmgCOzzrtE9dQ4repajuUjcSV
        IrRPC8NxT4C9tqP1tHWAgEuHOswm3uk=
X-Google-Smtp-Source: ACcGV61hI5Zk/ohbI2IPLxfR86GJcssjJGOyIvkcXDZ9PvvsQhb5VDLUTtaYJKABRdxQgGJ163vHKQ==
X-Received: by 2002:adf:f3c7:: with SMTP id g7-v6mr16683863wrp.229.1539676663353;
        Tue, 16 Oct 2018 00:57:43 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id i6-v6sm11010814wrq.4.2018.10.16.00.57.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 00:57:42 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rasmus Villemoes <rv@rasmusvillemoes.dk>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/3] send-email: Also pick up cc addresses from -by trailers
References: <20181010111351.5045-1-rv@rasmusvillemoes.dk>
        <20181016073923.28134-1-rv@rasmusvillemoes.dk>
Date:   Tue, 16 Oct 2018 16:57:41 +0900
In-Reply-To: <20181016073923.28134-1-rv@rasmusvillemoes.dk> (Rasmus
        Villemoes's message of "Tue, 16 Oct 2018 09:39:20 +0200")
Message-ID: <xmqq36t6z5l6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rasmus Villemoes <rv@rasmusvillemoes.dk> writes:

> This series extends the logic in git-send-email so that addresses
> appearing in various *-by: trailers (e.g. Reviewed-by, Acked-by,
> Tested-by) are picked up and added to the Cc list, in addition to the
> current logic that picks up Cc: and Signed-off-by: lines.

Thanks.  Will replace.  I think this is ready for 'next' so let's
see if somebody else have more comments for a few days and then
start merging it down.

