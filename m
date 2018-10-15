Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6ADC21F453
	for <e@80x24.org>; Mon, 15 Oct 2018 02:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726347AbeJOKUZ (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 06:20:25 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:45176 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbeJOKUZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 06:20:25 -0400
Received: by mail-wr1-f68.google.com with SMTP id q5-v6so19407515wrw.12
        for <git@vger.kernel.org>; Sun, 14 Oct 2018 19:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=CK6osLb7f++XLyjrbVJcjzwIZwEeaycVlezJUC2XkyE=;
        b=kbOsz4Kn5Zn50Q3QHf0mYsQoaNJ4tHesB+MQwF3luqVWVO1ymzX+DqmKUWV0ISIbCd
         ifQcPPzv4n1wdLFdg8KdKlU4DZlElX8z5EvqkkSG0YLR8FgmFfPKTg5I8wsxPyov/Gcp
         RGpNE0H3R9Pl3NobF2HbjBdNBP++oUyZeA9vj/VCViq4aAdDie3Tn5enHkAvcVCDFr00
         A8Z92VVHT/+vNog8RPctx6/UF2BvuBL6CaCUOYypswRB6+eKAoZ/csyAQEWTt3PHu93a
         lwg2cxD39SrhfP7GboLp1WAAvLSFa7Jh9MzI2uL4v2kveEgqRC89yZ4y/OqjlerulVN7
         uW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=CK6osLb7f++XLyjrbVJcjzwIZwEeaycVlezJUC2XkyE=;
        b=k8GflCjMWWib1cx4k74/coz9j3rsHbt9O4RPTbwUtjkCn9mkQ2nBH40dYr4Nha+YVf
         tf81wmyKMa438v48aoYYykZzKjygnZv74oBlVteWPxBg1zDolwIDSyyrOv3iIT9B1NXE
         TQm/n7tSZu4KeuBhwHG/aHIjGj2kCMK0fv16h7xi1Utv3Q+WUbaVUSVkhG3dPRfzleYB
         O4OxvTwOC4uRK20Pj48QxY1c6OFZqFwTO1Bv1ePmn9bX2rFAUlqv+gaQ0Cy+OEXLetpd
         GskOzeoaUFYWUZeNSBK527HfieVFjB4lY6ev4OFbwQcwfnOAsl6nwc8J+Di3XTv3c/l7
         2i6A==
X-Gm-Message-State: ABuFfohrCUl8kolIW84EaEqhldexlhGKnnB1APOthmc0dxdYneJwrzOQ
        HClokZOKLNU9dFLusmPU+5A=
X-Google-Smtp-Source: ACcGV63eYND11LT6+fQQtNUnKN7Vp5vrIviuzQDlLWhMSsadpJV11l0QZJHi1DXr+/JsDsnMLWne0w==
X-Received: by 2002:adf:8382:: with SMTP id 2-v6mr12326717wre.13.1539571033125;
        Sun, 14 Oct 2018 19:37:13 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id c8-v6sm11824957wrb.6.2018.10.14.19.37.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Oct 2018 19:37:12 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Matthew DeVore <matvore@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, git@jeffhostetler.com,
        jeffhost@microsoft.com, peff@peff.net, stefanbeller@gmail.com,
        jonathantanmy@google.com, pclouds@gmail.com
Subject: Re: [PATCH v12 0/8] filter: support for excluding all trees and blobs
References: <cover.1533854545.git.matvore@google.com>
        <cover.1539373969.git.matvore@google.com>
Date:   Mon, 15 Oct 2018 11:37:11 +0900
In-Reply-To: <cover.1539373969.git.matvore@google.com> (Matthew DeVore's
        message of "Fri, 12 Oct 2018 13:01:41 -0700")
Message-ID: <xmqqd0sc6ilk.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Matthew DeVore <matvore@google.com> writes:

> Here is a re-roll-up since I haven't received any additional corrections for
> almost a week.

Sorry, but doesn't this topic already in 'next'?  If so, please make
these small clean-ups as incremental patches.

Thansk.
