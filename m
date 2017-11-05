Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49467202A0
	for <e@80x24.org>; Sun,  5 Nov 2017 02:56:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752579AbdKEC4u (ORCPT <rfc822;e@80x24.org>);
        Sat, 4 Nov 2017 22:56:50 -0400
Received: from ikke.info ([178.21.113.177]:45388 "EHLO vps892.directvps.nl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751613AbdKEC4t (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Nov 2017 22:56:49 -0400
Received: by vps892.directvps.nl (Postfix, from userid 1008)
        id 97FD0440804; Sun,  5 Nov 2017 03:56:47 +0100 (CET)
Date:   Sun, 5 Nov 2017 03:56:47 +0100
From:   Kevin Daudt <me@ikke.info>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 1/3] notes: move hex_to_bytes() to hex.c and export it
Message-ID: <20171105025647.GB23275@alpha.vpn.ikke.info>
References: <508b1b3f-6b55-eee8-110a-c17d572ec27a@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <508b1b3f-6b55-eee8-110a-c17d572ec27a@web.de>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 31, 2017 at 02:46:49PM +0100, René Scharfe wrote:
> Make the function for converting pairs of hexadecimal digits to binary
> available to other call sites.
> 
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  cache.h |  7 +++++++
>  hex.c   | 12 ++++++++++++
>  notes.c | 17 -----------------
>  3 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/cache.h b/cache.h
> index 6440e2bf21..f06bfbaf32 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1317,6 +1317,13 @@ extern int set_disambiguate_hint_config(const char *var, const char *value);
>  extern int get_sha1_hex(const char *hex, unsigned char *sha1);
>  extern int get_oid_hex(const char *hex, struct object_id *sha1);
>  
> +/*
> + * Read `len` pairs of hexadecimal digits from `hex` and write the
> + * values to `binary` as `len` bytes. Return 0 on success, or -1 if

Is it correct to call the result binary? I would say that it's the value
that gets stored. To me, this value does not really have a base.

Kevin
