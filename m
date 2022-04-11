Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6C98C433F5
	for <git@archiver.kernel.org>; Mon, 11 Apr 2022 10:14:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345238AbiDKKRJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Apr 2022 06:17:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345264AbiDKKRC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Apr 2022 06:17:02 -0400
X-Greylist: delayed 574 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Apr 2022 03:14:46 PDT
Received: from mailproxy06.manitu.net (mailproxy06.manitu.net [IPv6:2a00:1828:1000:1111::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 554811838A
        for <git@vger.kernel.org>; Mon, 11 Apr 2022 03:14:46 -0700 (PDT)
Received: from localhost (p200300ef4f478b0002216bfffe535270.dip0.t-ipconnect.de [IPv6:2003:ef:4f47:8b00:221:6bff:fe53:5270])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: u16723@rkta.de)
        by mailproxy06.manitu.net (Postfix) with ESMTPSA id 6BC255800CC;
        Mon, 11 Apr 2022 12:05:07 +0200 (CEST)
Date:   Mon, 11 Apr 2022 12:05:07 +0200
From:   Rene Kita <mail@rkta.de>
To:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v5 3/8] Makefile: disable GNU make built-in wildcard rules
Message-ID: <YlP9U8GOgsfnZcKQ@x200>
References: <cover-v4-0.9-00000000000-20220302T124320Z-avarab@gmail.com>
 <cover-v5-0.8-00000000000-20220303T160155Z-avarab@gmail.com>
 <patch-v5-3.8-9f42f40b518-20220303T160155Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-v5-3.8-9f42f40b518-20220303T160155Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu,  Mar 03, 2022 at 05:04:14PM +0100, Ævar Arnfjörð Bjarmason wrote:

[...]

> Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
> ---
>  shared.mak | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/shared.mak b/shared.mak
> index 0170bb397ae..29f0e69ecb9 100644
> --- a/shared.mak
> +++ b/shared.mak
> @@ -1,3 +1,14 @@
> +### Remove GNU make implicit rules
> +
> +## This speeds things up since we don't need to look for and stat() a
> +## "foo.c,v" every time a rule referring to "foo.c" is in play. See
> +## "make -p -f/dev/null | grep ^%::'".
                                  ^
A bit late to the party, but are you missing an opening single quote
there?

> +%:: %,v
> +%:: RCS/%,v
> +%:: RCS/%
> +%:: s.%
> +%:: SCCS/s.%
> +
>  ### Flags affecting all rules
>  
>  # A GNU make extension since gmake 3.72 (released in late 1994) to
> -- 
> 2.35.1.1230.ga6e6579e98c
> 
