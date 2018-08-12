Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIMWL_WL_MED shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3668D1F404
	for <e@80x24.org>; Sun, 12 Aug 2018 10:05:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbeHLMnW (ORCPT <rfc822;e@80x24.org>);
        Sun, 12 Aug 2018 08:43:22 -0400
Received: from mail-yw1-f46.google.com ([209.85.161.46]:45623 "EHLO
        mail-yw1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727549AbeHLMnW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Aug 2018 08:43:22 -0400
Received: by mail-yw1-f46.google.com with SMTP id 139-v6so11630106ywg.12
        for <git@vger.kernel.org>; Sun, 12 Aug 2018 03:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xteddy-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=le9DiQ0YDMLedrGNEKe+JjJ445VZUTmXJzpiGtU8pIg=;
        b=AuTTZlu9Sr+oMr7+vb8AeRP6y3zjDP4okjlsXaBzA0xVUu4Cu3hnn0ncYEeJ0ZMg+s
         OIAhrl2FKJRzh2MpB5WAk5R3sTsD/whml6eXqdYGQrDW5mSkgCqv9f/FmkUEmLj8CINc
         rE1UyKG21JHcW5mAasKBByeO1CDj9dtjOnE+7YOBP2UIDNzirOfXyyYdTdqnqzScYSX0
         nZDsdSjwt0qQCCMiEloS+RcttC24Yl5oQZ1P7na1rUoY9HRNyTyoMuI7aNLvvFG8bdGS
         tIXqw9zcxzkTouqclzbfoFAeqHVjQ3ukMkH8BD2OJB0reE3PNFb83ToiTxNYg8JLmDib
         8aoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=le9DiQ0YDMLedrGNEKe+JjJ445VZUTmXJzpiGtU8pIg=;
        b=VdrRlgi9r3LzeyPSeJXf3B46I2KmrCvqMBl4MuNV20dKynNYpAVErVaaBSPhw+LgvL
         blO7FWKlI+w3wfUabYNYwgrY1gEGkzGRwp9mAgSMfuY5hlsnMGWpbwwpzfkCZV0bJcdQ
         Bpa+4Cn60qQ7Maz0fInkHXWb6I27z1Yw+PQDONlYmwLvYsQqVLrjDswhm3u8PuXKgZ4C
         8qJCQQLo2oLEMiIDK522uTCdbBgfE4xnZ7p6903x27M44HQDPB+Fa2wm0HlvWk5jIljU
         YB/UdVLykUHxCTBdEc8s0d6hRnzr3bu/ljk1AZiQgZenWr+phJhf7Le2czwiYIL35aKM
         iFcQ==
X-Gm-Message-State: AOUpUlHe8lT3PsSjSAmrxQpCXTFT6NktXl3f6yzkgokH9G0omQf3DoGB
        i+hzbYtD8WsEul3JhudQB8oNQc99U9tWG02w8eVDzQ==
X-Google-Smtp-Source: AA+uWPx/vTmQWqBcuR6YNBNj/DZrEwTjZo5pEIhtCxGSdr9uRVuK+Bu7bgsWliTtTb+8RUU435mvfy+FD04eDS87n4Q=
X-Received: by 2002:a81:15d6:: with SMTP id 205-v6mr6811997ywv.356.1534068351498;
 Sun, 12 Aug 2018 03:05:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180804053723.4695-1-pclouds@gmail.com> <20180812081551.27927-1-pclouds@gmail.com>
 <20180812081551.27927-3-pclouds@gmail.com>
In-Reply-To: <20180812081551.27927-3-pclouds@gmail.com>
From:   Thomas Adam <thomas@xteddy.org>
Date:   Sun, 12 Aug 2018 11:05:37 +0100
Message-ID: <CAOhcEPZphaKASyMAmZ5erdn-fygdVrvtPScTL_zZmAAgCYYKqQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] unpack-trees: add performance tracing
To:     pclouds@gmail.com
Cc:     Ben.Peart@microsoft.com, Git Users <git@vger.kernel.org>,
        gitster@pobox.com, peartben@gmail.com, peff@peff.net,
        newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, 12 Aug 2018 at 09:19, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pc=
louds@gmail.com> wrote:

Hi,

> +       trace_performance_leave("cache_tree_update");

I would suggest trace_performance_leave() calls use __func__ instead.
That way, there's no ambiguity if the function name ever changes.

Kindly,
Thomas
