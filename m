Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE01B20286
	for <e@80x24.org>; Wed, 13 Sep 2017 19:11:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbdIMTLG (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Sep 2017 15:11:06 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:36508 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751444AbdIMTLF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Sep 2017 15:11:05 -0400
Received: by mail-pg0-f66.google.com with SMTP id d8so523528pgt.3
        for <git@vger.kernel.org>; Wed, 13 Sep 2017 12:11:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=isWQABP+gWiDfUbmtefGRluuVCPIuFB4IbP3WxGJiiY=;
        b=I5M8xIs0La5uhzaKGBc28W4BC9KKjkirvq65HrlR84/MwbcDwkdqVE5nO1Y5Z1NGf2
         zCDFdDCnT/Z3q3Xct7GZUwhubrO0F2ehrB+ygxjBhB93Zd8GvadvzzQmyrqKElf05nvh
         dsqJvbo4oiDHmiYaiq1gODl5/fGolFMYOSeYobntsCmqn+UNn+k6oPiHSBA+aNhKDrpJ
         798a4/kjtIgK2V8qN/gKydTHX5axX2tvtzVg/iPAF2LNFscrXicTN1mE22GW4qEgexhA
         L06UPcBIvLx8uuVWCUWvRHW84KC26upHiiaZbzG+on67a5HJrK7jgtDrw2L1rZbsT13+
         xF6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=isWQABP+gWiDfUbmtefGRluuVCPIuFB4IbP3WxGJiiY=;
        b=BlpoWH8301AZYrXPvFZCrADwumSGHojKumn32HIIp1BNnpAma0pPlWt+EDkQHAaHnd
         EEtzIfLQHUZQGBBH96qZmgH+cFw5IwCjtBjrgHP6N4qMgVr+kwEpucU+cbuHdwl/E0Bd
         fDVeWS7t2UTevUwrCiYB9mZ7g1miH4DuY/hnvy+Y/mbd4GfURgj2plnTDqFAmhUxZ1aX
         eea6eKXzscy87H6IjEARnvpcabpPJCR2BIQo/fEC6lnqAU+j0imwI7zPJTbOrXod/bon
         JPUH/aaJrLgAYRgHMZ3SfrCI0iaf0ywtj9u5kaEoL8XBkOTQz+l7+EN7xZsvec1K2OnO
         jzyg==
X-Gm-Message-State: AHPjjUiIwfWB7P6pTsu/peeWzVK+VLh8MTCi5iPkLqdmhnNqhzQ6+Yl8
        V/G+jWsnVwpNilQhF9Y=
X-Google-Smtp-Source: ADKCNb4lg3T5ES2W/BT8aqelvsuDwOEb34aMIoj0Pgi5CHFvUIEwHA30cT0Hcwe4ofQbGFVD8v9yHw==
X-Received: by 10.99.121.77 with SMTP id u74mr18373409pgc.180.1505329865001;
        Wed, 13 Sep 2017 12:11:05 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:422:d132:98b:3ff1:a635])
        by smtp.gmail.com with ESMTPSA id f13sm26055588pfj.127.2017.09.13.12.11.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 13 Sep 2017 12:11:04 -0700 (PDT)
Date:   Wed, 13 Sep 2017 12:11:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     demerphq <demerphq@gmail.com>, Git <git@vger.kernel.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 8/7] read_pack_header: handle signed/unsigned comparison
 in read result
Message-ID: <20170913191102.GF27425@aiede.mtv.corp.google.com>
References: <CANgJU+Wj_sN8Px6rweHMw_iAX8UA3mW9x4NVCctpUCs8_3ytLw@mail.gmail.com>
 <20170913170807.cyx7rrpoyhaauvol@sigill.intra.peff.net>
 <20170913184722.imcexldnufskugqz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170913184722.imcexldnufskugqz@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:

> Subject: [PATCH] read_pack_header: handle signed/unsigned comparison in read  result
>
> The result of read_in_full() may be -1 if we saw an error.
> But in comparing it to a sizeof() result, that "-1" will be
> promoted to size_t. In fact, the largest possible size_t
> which is much bigger than our struct size. This means that
> our "< sizeof(header)" error check won't trigger.
>
> In practice, we'd go on to read uninitialized memory and
> compare it to the PACK signature, which is likely to fail.
> But we shouldn't get there.
>
> We can fix this by making a direct "!=" comparison to the
> requested size, rather than "<". This means that errors get
> lumped in with short reads, but that's sufficient for our
> purposes here. There's no PH_ERROR tp represent our case.
> And anyway, this function reads from pipes and network
> sockets. A network error may racily appear as EOF to us
> anyway if there's data left in the socket buffers.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  sha1_file.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch 8 (but not patches 2-7) is
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.

An alternative would be to use something like

	< (int) sizeof(*header)

to force it to be signed, but I think this is clearer.

Using the following semantic patch, I find this and the example from
patch 1 and no others:

  @@
  expression fd;
  expression buf;
  expression len;
  size_t rhs;
  @@
  -read_in_full(fd, buf, len) < rhs
  +ERROR()

  @@
  expression fd;
  expression buf;
  expression len;
  size_t rhs;
  @@
  -write_in_full(fd, buf, len) < rhs
  +ERROR()

Thanks,
Jonathan

> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -1850,7 +1850,7 @@ int index_path(struct object_id *oid, const char *path, struct stat *st, unsigne
>  
>  int read_pack_header(int fd, struct pack_header *header)
>  {
> -	if (read_in_full(fd, header, sizeof(*header)) < sizeof(*header))
> +	if (read_in_full(fd, header, sizeof(*header)) != sizeof(*header))
>  		/* "eof before pack header was fully read" */
>  		return PH_ERROR_EOF;
>  
