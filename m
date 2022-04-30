Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9230CC433F5
	for <git@archiver.kernel.org>; Sat, 30 Apr 2022 19:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244802AbiD3TiL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Apr 2022 15:38:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238997AbiD3TiJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 30 Apr 2022 15:38:09 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2EB4AE22
        for <git@vger.kernel.org>; Sat, 30 Apr 2022 12:34:46 -0700 (PDT)
Received: from host-84-13-159-41.opaltelecom.net ([84.13.159.41] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1nksrd-0006i1-AG;
        Sat, 30 Apr 2022 20:34:45 +0100
Message-ID: <6e8cd958-b749-0a55-d8ae-ff249f06bd2f@iee.email>
Date:   Sat, 30 Apr 2022 20:34:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 01/23] contrib/coccinnelle: add equals-null.cocci
Content-Language: en-GB
To:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
References: <20220430041406.164719-1-gitter.spiros@gmail.com>
 <20220430041406.164719-2-gitter.spiros@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20220430041406.164719-2-gitter.spiros@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 30/04/2022 05:13, Elia Pinto wrote:
> Add a coccinelle semantic patch necessary to reinforce the git coding style
> guideline:
>
> "Do not explicitly compute an integral value with constant 0 or '\ 0', or a

s/compute/compare/
> pointer value with constant NULL."

If this gets re-rolled, perhaps include a simple example for those who
don't immediately understand that quoted sentence. It will also help
decode the coccinelle script

so:     `if (ptr == NULL)` becomes `if (!ptr)`  etc.

--
Philip
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  contrib/coccinelle/equals-null.cocci | 30 ++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
>  create mode 100644 contrib/coccinelle/equals-null.cocci
>
> diff --git a/contrib/coccinelle/equals-null.cocci b/contrib/coccinelle/equals-null.cocci
> new file mode 100644
> index 0000000000..92c7054013
> --- /dev/null
> +++ b/contrib/coccinelle/equals-null.cocci
> @@ -0,0 +1,30 @@
> +/* SPDX-License-Identifier: LGPL-2.1-or-later */
> +@@
> +expression e;
> +statement s;
> +@@
> +if (
> +(
> +!e
> +|
> +- e == NULL
> ++ !e
> +)
> +   )
> +   {...}
> +else s
> +
> +@@
> +expression e;
> +statement s;
> +@@
> +if (
> +(
> +e
> +|
> +- e != NULL
> ++ e
> +)
> +   )
> +   {...}
> +else s

