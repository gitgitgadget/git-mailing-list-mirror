Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E97620193
	for <e@80x24.org>; Mon, 24 Oct 2016 19:53:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941081AbcJXTx3 (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 15:53:29 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:34630 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754740AbcJXTx2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 15:53:28 -0400
Received: by mail-wm0-f50.google.com with SMTP id d199so835188wmd.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2016 12:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kCi6CK3E6S0mZsab5daQD1hVijHnaxcBh6HDeBmsZdQ=;
        b=tZAlqdUKkhqEqyIxNnWQVsjJAYPxDyvpSCwYLIwK/N6aziWZ9d5AtvQiIo+XhsWRxM
         N2s8puFk32PrgRtNyaKmt4wCig/bX7xrl6D5n7RvlZGeestHx16azGTlOYjo65EUvHc+
         GzJhY+69HvH2JHqeSGh3R9PCBI0H+ex0hpcpxDN6Z0CDZAz9Q27tuWBd/pDwrfwvTlXs
         HX26tnfz1yPfdhfBdlR7aQXh/40hik2VQ9OxZGPDtsSSepmgeMd4JkU8Dvx6g6blLxYt
         7WCWzSZfr1Zw/y6kJHMG6vb8UD4Tp0R7XROXAW3vDv2d3BpTeNyJsewEN89X+yEI3Ab5
         mt4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=kCi6CK3E6S0mZsab5daQD1hVijHnaxcBh6HDeBmsZdQ=;
        b=lsNaRQsErUjb5Xd2BxorYU9T/GmO/UKJERF7c5IeNl7ohBVhUQSiW+55wasfnwDsXw
         d4Pd4iCwzopvp/Q9PDSGbRsjFGM2qwd1hU+zk/TlRvlGixDBtoB0UGq/AfJiIMXy8Dao
         w2Kqm4+SDXXddA5hLZg4i+FqBkLCxed/8MoccZPIniiaZCAaIhby9/e1Wpt8e7jbFx4g
         C59WEwUntNvplb54BUPiLaUI8E2cClLx6xVFDiFNqfP4VJbVlrIJBMPemkZjrEO9P630
         v8bjpWTGycLyz55GEv/pagZNsyUKE4bCnvXMkb9xPxmYEg6ugR4/5UdAxmm7j5iLFV3A
         SfgA==
X-Gm-Message-State: AA6/9RmJLdnc9N/aibcwuxq0RPvOlsL9eUwmpHtxVX72/uDz4PWhoiOOXq7NhoFJxW76hw==
X-Received: by 10.28.35.82 with SMTP id j79mr16126953wmj.32.1477338807046;
        Mon, 24 Oct 2016 12:53:27 -0700 (PDT)
Received: from slxbook4.fritz.box (p5DDB5B90.dip0.t-ipconnect.de. [93.219.91.144])
        by smtp.gmail.com with ESMTPSA id c7sm21008464wjk.19.2016.10.24.12.53.25
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 24 Oct 2016 12:53:26 -0700 (PDT)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v2 2/2] read-cache: make sure file handles are not inherited by child processes
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <10135d1c-d9a7-d4ec-438a-bb0a8f6762fe@kdbg.org>
Date:   Mon, 24 Oct 2016 21:53:24 +0200
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, e@80x24.org,
        jnareb@gmail.com, gitster@pobox.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <4C96209A-756F-45F1-B075-037FE32B3291@gmail.com>
References: <20161024180300.52359-1-larsxschneider@gmail.com> <20161024180300.52359-3-larsxschneider@gmail.com> <10135d1c-d9a7-d4ec-438a-bb0a8f6762fe@kdbg.org>
To:     Johannes Sixt <j6t@kdbg.org>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 24 Oct 2016, at 21:22, Johannes Sixt <j6t@kdbg.org> wrote:
>=20
> Am 24.10.2016 um 20:03 schrieb larsxschneider@gmail.com:
>> From: Lars Schneider <larsxschneider@gmail.com>
>>=20
>> This fixes "convert: add filter.<driver>.process option" (edcc8581) =
on
>> Windows.
>=20
> Today's next falls flat on its face on Windows in t0021.15 "required =
process filter should filter data"; might it be the failure meant here? =
(I haven't dug deeper, yet.)

Yes, this is the failure meant here :-)

Cheers,
Lars

