Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0DAC21F404
	for <e@80x24.org>; Tue, 13 Mar 2018 16:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934521AbeCMQA1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 12:00:27 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:35666 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933831AbeCMQAY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 12:00:24 -0400
Received: by mail-pf0-f176.google.com with SMTP id y186so46054pfb.2
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 09:00:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qOv6uV9S/SoayDlhZogoH3TXb/ZKKcSN/Z+uaNV6WvA=;
        b=bKpyNrHCr4Yw4RWXTyl1vo3DT5MGOH9EVwPb0Ik3Cm/Ut999B9qVfxiYiwMhVPHAw1
         F3bLTEGjR98iH0oA8ky6VE2zmoUcEdcQrbCxe6ZP8es0FnYx2I3Zy86jVzalFvBk3ul4
         xqA2B+/pb51URA736itvpm7FpSOWH/STbEQV0wxliyIOmhpDqGwb3KWbrnbB74rtGiFR
         jlhzplwNmdI67Pd3lR9VD41kHyOoYSG9y76GtfqsvOhxuSL7GegPaNDWekol6Dvh2oh4
         +5fuR7jsbelc/5YB4UuAzvBCNxe9XlNaSmIOTKNBGgXfR+aK/cykBc351G19xef3/Za9
         EJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qOv6uV9S/SoayDlhZogoH3TXb/ZKKcSN/Z+uaNV6WvA=;
        b=mJkBhT9LDwH28P9q4FotHNb30bLJIl5d6TOu8yKGLJikgCjx/j8iAPQF/dMFSzK+VP
         0N2ehc/+EVYX5Igl+9eOHV34/bS8eiwUxQo09GzA/GYpXVnk0qmsB5+OgqiGEKeKyG9u
         HvO6KJVG2Hjpyfhx0srs9205989deheux+hpqyUWANIUI8KgTFg2X4eitKaFsylNR/aI
         Lddmaku1WHIDezDdkIujfj4L+oSeyp+URAgotcDg87b1vIZnZENf6/CVpIjjQ5a6biW3
         YVdv8icZzB90egW0ZHuZPEJqNIQ12mBUxmAN+yxC06OMNSfSrxkTZ9SrzP2o1YOemFPR
         X0iw==
X-Gm-Message-State: AElRT7G9DRWhuVTH4IOY+2BXrn6jtLZfgWWLj031GP9ENZy/3yRLvXDk
        gG7u5E5vw7MFhCQBx4hjn1uwvwQBZUo=
X-Google-Smtp-Source: AG47ELuOpi5CTY3kPt7Xvxgy47TCJOOx7cAKDyRI3XQ1l4H5ztV9M7MwxI6B+fX2hmOI31/wubZyrg==
X-Received: by 10.101.76.71 with SMTP id l7mr912084pgr.192.1520956823287;
        Tue, 13 Mar 2018 09:00:23 -0700 (PDT)
Received: from twelve3.svl.corp.google.com ([2620:0:100e:422:ffac:c1d4:4bf7:bb93])
        by smtp.gmail.com with ESMTPSA id z64sm1214829pfi.58.2018.03.13.09.00.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 13 Mar 2018 09:00:22 -0700 (PDT)
Date:   Tue, 13 Mar 2018 09:00:20 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, git@jeffhostetler.com, gitster@pobox.com,
        jrnieder@gmail.com, pclouds@gmail.com, peff@peff.net,
        sbeller@google.com, stolee@gmail.com
Subject: Re: [PATCH v4 16/35] transport: convert transport_get_remote_refs
 to take a list of ref patterns
Message-Id: <20180313090020.036f0314549cc23d9f71ce87@google.com>
In-Reply-To: <20180228232252.102167-17-bmwill@google.com>
References: <20180207011312.189834-1-bmwill@google.com>
        <20180228232252.102167-1-bmwill@google.com>
        <20180228232252.102167-17-bmwill@google.com>
X-Mailer: Sylpheed 3.6.0 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 28 Feb 2018 15:22:33 -0800
Brandon Williams <bmwill@google.com> wrote:

> Convert 'transport_get_remote_refs()' to optionally take a list of ref
> patterns.
> 
> Signed-off-by: Brandon Williams <bmwill@google.com>

[snip]

> -const struct ref *transport_get_remote_refs(struct transport *transport);
> +/*
> + * Retrieve refs from a remote.
> + *
> + * Optionally a list of ref patterns can be provided which can be sent to the
> + * server (when communicating using protocol v2) to enable it to limit the ref
> + * advertisement.  Since ref filtering is done on the server's end (and only
> + * when using protocol v2), this can return refs which don't match the provided
> + * ref_patterns.
> + */
> +const struct ref *transport_get_remote_refs(struct transport *transport,
> +					    const struct argv_array *ref_patterns);

Thanks for adding the documentation, but I think this should also go
into the commit message. For example:

    Teach transport_get_remote_refs() to accept a list of ref patterns,
    which will be sent to the server for use in filtering when using
    protocol v2. (This list will be ignored when not using protocol v2.)
