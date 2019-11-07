Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 610891F454
	for <e@80x24.org>; Thu,  7 Nov 2019 11:11:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387725AbfKGLLP (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Nov 2019 06:11:15 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55263 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727278AbfKGLLP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Nov 2019 06:11:15 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E27FC3222E;
        Thu,  7 Nov 2019 06:11:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dIYwgXSfkhGRr6O6uBAe2dkkHa4=; b=q7UFYw
        5+JnxKNqUjbrewfeLYf4CtkC9w0fETvX8N8R2TBgSwlel2y+tMoqUXS03VTNvtti
        fTviFlZMaknsQ8OLdX5DpBZNHb7oCQX6KMlFBeQf2hHlzrvldPjQTeAJDK8dCA/t
        kIsHwVYotuWSlUkVfmEDytrfNMTSjoRLjzLys=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ey+wuKN8hu00JHoJLQUCROEVu412b/i0
        MKwRRew2QoQ8/IDPaemHt2LF9smTz99osH63RBPLj2nJr8pOG+eWoeCdBzS4O+Tf
        8C6uiPKdIF5ukwJSa2k2C9p0R++J4YDols+zilxwpJQjePUjZcD2IZQyNjhWmD1H
        rF9GLMSPnZE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id DB0223222D;
        Thu,  7 Nov 2019 06:11:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4E1AB3222C;
        Thu,  7 Nov 2019 06:11:12 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elia Pinto <gitter.spiros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] kset.h, tar.h: add missing header guard to prevent multiple inclusion
References: <20191107101243.99744-1-gitter.spiros@gmail.com>
Date:   Thu, 07 Nov 2019 20:11:11 +0900
In-Reply-To: <20191107101243.99744-1-gitter.spiros@gmail.com> (Elia Pinto's
        message of "Thu, 7 Nov 2019 10:12:43 +0000")
Message-ID: <xmqqeeykosa8.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4EBE325C-014F-11EA-8F63-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elia Pinto <gitter.spiros@gmail.com> writes:

> Add missing headers to prevent ill-effects from multiple inclusion.
>
> Found by the LGTM source code analyzer.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> ---
>  kwset.h | 4 ++++
>  tar.h   | 5 +++++
>  2 files changed, 9 insertions(+)

Makes sense; thanks.

> diff --git a/kwset.h b/kwset.h
> index df99a92178..f50ecae573 100644
> --- a/kwset.h
> +++ b/kwset.h
> @@ -1,3 +1,6 @@
> +#ifndef KWSET_H
> +#define KWSET_H
> +
>  /* This file has been copied from commit e7ac713d^ in the GNU grep git
>   * repository. A few small changes have been made to adapt the code to
>   * Git.
> @@ -59,3 +62,4 @@ size_t kwsexec(kwset_t, char const *, size_t, struct kwsmatch *);
>  /* Deallocate the given keyword set and all its associated storage. */
>  void kwsfree(kwset_t);
>  
> +#endif /* KWSET_H */
> diff --git a/tar.h b/tar.h
> index 3467705e9b..6b258c4d4a 100644
> --- a/tar.h
> +++ b/tar.h
> @@ -1,3 +1,6 @@
> +#ifndef TAR_H
> +#define TAR_H
> +
>  #define TYPEFLAG_AUTO		'\0'
>  #define TYPEFLAG_REG		'0'
>  #define TYPEFLAG_LNK		'2'
> @@ -23,3 +26,5 @@ struct ustar_header {
>  	char devminor[8];	/* 337 */
>  	char prefix[155];	/* 345 */
>  };
> +
> +#endif /* TAR_H */
