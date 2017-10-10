Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 301AF2036B
	for <e@80x24.org>; Tue, 10 Oct 2017 18:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756480AbdJJS2V (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Oct 2017 14:28:21 -0400
Received: from mail-pf0-f180.google.com ([209.85.192.180]:46382 "EHLO
        mail-pf0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756353AbdJJS2U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Oct 2017 14:28:20 -0400
Received: by mail-pf0-f180.google.com with SMTP id p87so9054536pfj.3
        for <git@vger.kernel.org>; Tue, 10 Oct 2017 11:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=69Vggy2h3eTgUVFtmaPC/pB5XY5Y2uDgDbFyE2DmF2M=;
        b=D/gkqInRDfYXjcK6+DiWSYtCbua7Ha0VMf6HNJ43Upn2bDEH508XunPWdfF0gmHFJ9
         ruzy9gM+PxJ2SGcV4LY0kaV7zXGJPShHbuzp+EvbBrPb5nc0ma8VMeTQujXWt+B2qmCb
         nmhsh9yZ9WBRxF5ndp/sgbxq4xof9XmnqQGQswo5gBkeNDCjE6+i5OQZ20YX91BFTCAj
         iwC2L9Ow3rBJ+KQtlF7Smv2beYRlWMOH5RVB2oAPDvl6iBeTexsI7zKUQJ4GWpkcYmIB
         hOR35M/CoWnRX+v14hHCDUm+I/VPjuog8MHXxdzBk2dN/7n25E9/JNsFt13TEd2DrvCZ
         moWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=69Vggy2h3eTgUVFtmaPC/pB5XY5Y2uDgDbFyE2DmF2M=;
        b=DgEvsKutWGvaK4qjNPXbK7wiCFb6rVUjAo3a0YvNnIYxCqOGPGOdaltcfNddGgaUNh
         e75wXZgHd1D2dcR24TILuQKKBOaRmdQd/lTLcJhRrlGpvLxSKeAnbpG3BH0WaZ5u/l5Y
         UL3pIm5NtJLrEykf+q009mwtvEhNMFpvmqZZJovzf/fnIr8woE3QZPNzeAOdAUhJXC8L
         DtMcV2MhSl1JHcofOXb/vzkzOEwIfnHDFwYQHj0WjvB0LGWDiOe/cRSIw+LvKyJvGUWT
         4NSxoKcodq9tza7NTCv++ULx7LOk6WhbzZ0tNHKh1oPT1w1/iPqoFtJc9X4nMU6Y/EH5
         AINQ==
X-Gm-Message-State: AMCzsaVkSq9W0nvgZMALbg7trEcKAwpCLISQ3P+cTfJ7MYeWj/V8y3Qb
        A995qgIWqiCjKHiDFJDIFIv6HA==
X-Google-Smtp-Source: AOwi7QA3Jt7b5FD7wHJHo+00EoOx0CMq1HE0QUKYPI/Jm74CN65ConXUrSKjSEPNXB8vry2T1lHQ7g==
X-Received: by 10.84.128.1 with SMTP id 1mr12800328pla.238.1507660099906;
        Tue, 10 Oct 2017 11:28:19 -0700 (PDT)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:961:a8fe:b03f:d840])
        by smtp.gmail.com with ESMTPSA id d74sm4098421pfe.167.2017.10.10.11.28.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Oct 2017 11:28:19 -0700 (PDT)
Date:   Tue, 10 Oct 2017 11:28:18 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v3 05/10] upload-pack, receive-pack: introduce protocol
 version 1
Message-Id: <20171010112818.bd75e8dbe4ae39c90e6512da@google.com>
In-Reply-To: <20171003201507.3589-6-bmwill@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
        <20171003201507.3589-1-bmwill@google.com>
        <20171003201507.3589-6-bmwill@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue,  3 Oct 2017 13:15:02 -0700
Brandon Williams <bmwill@google.com> wrote:

> +	switch (determine_protocol_version_server()) {
> +	case protocol_v1:
> +		if (advertise_refs || !stateless_rpc)
> +			packet_write_fmt(1, "version 1\n");
> +		/*
> +		 * v1 is just the original protocol with a version string,
> +		 * so just fall through after writing the version string.
> +		 */

Peff sent out at least one patch [1] that reformats fallthrough comments
to be understood by GCC. It's probably worth doing here too.

In this case, I would do the 2-comment system that Peff suggested:

	/*
	 * v1 is just the original protocol with a version string,
	 * so just fall through after writing the version string.
	 */
	if (advertise_refs || !stateless_rpc)
		packet_write_fmt(1, "version 1\n");
	/* fallthrough */

(I put the first comment before the code, so it doesn't look so weird.)

[1] https://public-inbox.org/git/20170921062541.ew67gyvrmb2ot4sf@sigill.intra.peff.net/

> +	case protocol_v0:
> +		break;
> +	default:
> +		BUG("unknown protocol version");
> +	}
