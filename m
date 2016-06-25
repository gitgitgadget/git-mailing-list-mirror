Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7706C1FEAA
	for <e@80x24.org>; Sat, 25 Jun 2016 14:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbcFYOCs (ORCPT <rfc822;e@80x24.org>);
	Sat, 25 Jun 2016 10:02:48 -0400
Received: from mail-io0-f180.google.com ([209.85.223.180]:36496 "EHLO
	mail-io0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751308AbcFYOCr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2016 10:02:47 -0400
Received: by mail-io0-f180.google.com with SMTP id s63so116800490ioi.3
        for <git@vger.kernel.org>; Sat, 25 Jun 2016 07:02:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ogmm/GWGke/bW82XODQ2SIP3zrNV1nvpr5WBB5BDUK8=;
        b=ijD+uUH2+/6xTjf+7/XRm8q5EIrFQ05kwB79/ANHdOrh8KdOuyIRxeaw9youwqhLUb
         v1KoXKdKZJT/okjvQ5AC5+DBesGBiDKurfiAw0jpYNifAkZ3fVbiTXG5SQvBnesKp0mU
         mKmKJN6cigsLp6CkLm9k7aWHLWeCbxB++oZSYyPhQGP4lgn/G21iY+OO3frF3aY6El2P
         dbgyrh467+y4PF/PpBJRBt6ibSW7jCcU5G4uSD+kNuKy5BrF2XUGEBb5ygaCS93EByj9
         xqmTHI11iKM2qrdngq7QP9jCSBLhmTn+n7HeqI9S9qw5qaKojEdIBBXmXPA3vIA4L9qR
         BsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ogmm/GWGke/bW82XODQ2SIP3zrNV1nvpr5WBB5BDUK8=;
        b=dk1nZUzXJECkTzEPtOu1fPvZgohOEHKSWSDfYi19hTJnoRtaVlQF2YSgCgWqIKE27P
         InuzY2ZJ6m+eRojps/gBOkPsokpqtuv6HOGRCC6vHBt3983MwDwGORNPEj8/MLde/yVe
         jiFgvVGGntxs5QUvRdxobCvpTSfNltRYf4K7bJt3H7HAAjI1eRqi9S1+vD9QHL3tKFKm
         yavzTBylMCiVHHC3zSqQZE0CBdk/qHLgylCmFzMmhSMKFQ/O8w87Hkm8wRwSaRvoGrr2
         yDpG5iow5ZcZES2MUco16MXOFduELxfSlIT/9Vlb85YaEMxuz+L5Rj2hc5a++npLy6By
         jYXw==
X-Gm-Message-State: ALyK8tL8WC06NdvVyAxTS3wTFvCRrHD8anH2aYeYgjW7dnAFVzKDyLViMh0ZzUPPTOWhCUQjKj17xKk1OYQPtg==
X-Received: by 10.107.8.220 with SMTP id h89mr10034674ioi.95.1466863340294;
 Sat, 25 Jun 2016 07:02:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.225.235 with HTTP; Sat, 25 Jun 2016 07:01:50 -0700 (PDT)
In-Reply-To: <1463694357-6503-4-git-send-email-dturner@twopensource.com>
References: <1463694357-6503-1-git-send-email-dturner@twopensource.com> <1463694357-6503-4-git-send-email-dturner@twopensource.com>
From:	Duy Nguyen <pclouds@gmail.com>
Date:	Sat, 25 Jun 2016 16:01:50 +0200
Message-ID: <CACsJy8C82KMjPUdYA-QHz7zCx_pXtSUCL8O4nWJY2Jyit9Q3hw@mail.gmail.com>
Subject: Re: [PATCH v12 03/20] pkt-line: add gentle version of packet_write
To:	David Turner <novalis@novalis.org>
Cc:	Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, May 19, 2016 at 11:45 PM, David Turner <dturner@twopensource.com> wrote:
> +int packet_flush_gently(int fd)
> +{
> +       packet_trace("0000", 4, 1);
> +       return write_in_full(fd, "0000", 4) != 4;
> +}

The return value convention here is a bit weird, isn't it? Usually we
have "zero good, minus one  (or negative) bad" or "zero bad, positive
good". This one goes "zero good, one bad". Same goes for the other
_gently() function.
-- 
Duy
