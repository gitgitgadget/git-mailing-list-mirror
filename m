Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DAD2202AF
	for <e@80x24.org>; Wed, 15 Nov 2017 01:45:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754054AbdKOBpC (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Nov 2017 20:45:02 -0500
Received: from mail-it0-f41.google.com ([209.85.214.41]:51963 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753415AbdKOBpB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Nov 2017 20:45:01 -0500
Received: by mail-it0-f41.google.com with SMTP id x28so10310561ita.0
        for <git@vger.kernel.org>; Tue, 14 Nov 2017 17:45:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=boHAXdfHkHuVUNFHA6pZxcBF6VdY9r/UtHqYgJcAdxw=;
        b=Pv0u+DhwW1WYLhi5VZJR8rS+WPVgQf7lvCzx69+Gxhy+vGRmlPzVVgknCD4Q/DKqGI
         kyAHc0nSpa0gMw6viEaoa+DJhzHs4q+otpa/TIX6HH/wggmkyL1cjyxwkiUwNQRsMJ5Z
         +WYFlXJpV3IKF3v2iIVjjWktmU+kFpBbD4migYze2HPrn4JxKfrde2+55PXYmxlzKjbF
         RhCHz2BKyoSX5PUMMMLp5e08dnmy37cJpKNv6g4urFr642yz6K0m2LOSwWUODXskVGaL
         35INItCBRJtc6LVRpLdI0EaCHGzNwol4j1cKs07cyVjcNytoXkTRyg+bgCSoc9JyuP9E
         Cv7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=boHAXdfHkHuVUNFHA6pZxcBF6VdY9r/UtHqYgJcAdxw=;
        b=oALJaz8gIzkXzHNbTT8U9TJ7akk0gQH07pU2q77zUb2t0EvrKDObujIbRCqAELTXbS
         S3bL/cD/dHKI1Uw2IKXS2AGUEXJIdfQ96tgzit0qhFn0MFV2Qx/xhgL8yIU0deaRq1iB
         00dut9xVM2lrf2MHqpxLBSdTe49swV2VjjADw+2pg6ObyFl1fJ50Rl49OFtl4pzAIwbL
         LkZeMUa+jbXTDjr2Q2GQQrh2A586Kv4XH4hrwCBaW5jiZRiwLFIlzvBzpz3cSaFxLQZ6
         VfH++MrxG3wfFilexS/07vBNNF36UPvwB+y5Zxbgon9KmFaIQ+qwr6oXZ/lqn9bVCpJ2
         aWCQ==
X-Gm-Message-State: AJaThX7+LZmA0GnqLY1s8TzPkCuQyzH5kCxXvEeAw2PGgnoIH2EFQA4/
        rTpVnvLxZzRBmxjWFldqGMJDCw==
X-Google-Smtp-Source: AGs4zMbpSLJHWpYHpnt8R6Jimi8RNc1B1tW9tVq8VIlNhC6YVv+va6PBS5WzuWiDiOeRQ0GuJgOwqg==
X-Received: by 10.36.29.208 with SMTP id 199mr17720045itj.40.1510710300446;
        Tue, 14 Nov 2017 17:45:00 -0800 (PST)
Received: from twelve3.mtv.corp.google.com ([2620:0:100e:422:68e8:a345:46:2771])
        by smtp.gmail.com with ESMTPSA id o1sm5043575ite.2.2017.11.14.17.44.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 Nov 2017 17:44:59 -0800 (PST)
Date:   Tue, 14 Nov 2017 17:44:58 -0800
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCHv4 6/7] builtin/describe.c: factor out describe_commit
Message-Id: <20171114174458.48e345602d6cb3b2614941ef@google.com>
In-Reply-To: <20171115003043.24080-7-sbeller@google.com>
References: <20171115003043.24080-1-sbeller@google.com>
        <20171115003043.24080-7-sbeller@google.com>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 14 Nov 2017 16:30:42 -0800
Stefan Beller <sbeller@google.com> wrote:

> In the next patch we'll learn how to describe more than just commits,
> so factor out describing commits into its own function.  That will make
> the next patches easy as we still need to describe a commit as part of
> describing blobs.
> 
> While factoring out the functionality to describe_commit, make sure
> that any output to stdout is put into a strbuf, which we can print
> afterwards, using puts which also adds the line ending.

I think the sentences here are a bit jumbled. The aim is to make the
next patch easier (your 2nd sentence), and how we accomplish that is by
factoring out the description of commits (1st sentence) *and* by
outputting to a strbuf because we need to postprocess the output further
when describing a commit as part of describing a blob (3rd sentence).
