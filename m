Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9B80A201A0
	for <e@80x24.org>; Fri, 30 Jun 2017 18:40:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751887AbdF3SkZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Jun 2017 14:40:25 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:32946 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751072AbdF3SkY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2017 14:40:24 -0400
Received: by mail-pg0-f65.google.com with SMTP id u62so16178670pgb.0
        for <git@vger.kernel.org>; Fri, 30 Jun 2017 11:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Mipgt3i7oyq3ioia4QTxE1iR8uJB7weCPLlbwG+84l0=;
        b=BeKxCr2cEmVvaFLC71Nd5wVQX3A7hZXzqNEpzWieirxs/a7APU9yP9L5oIVw+D/Th2
         Gj4qlG8qReHsssLN4XZYHs6XmCaKbpILv3fmpVpK5I4sQqvplxDUIuG6/3hXH5kzYT13
         G3MCVduMvwWnxSRn4bMN+BLTRg+H5Ru3euqaNFeVd6PfpjDnF6lZRm7NhgxP0bSVMKtU
         GJAJAGsiIpIqw2GR6Wx64I1FS0uPUKkLrIq1DblVYrmuHhGOFbEHg8BFwrrPp2R+/11f
         KP0DNi9BhbdlVwOlOb4TzT5ACnR+lqJrOgbOtQtrB5LI6k6Wk7aW+Zkwo6fneFhabqUH
         fBAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Mipgt3i7oyq3ioia4QTxE1iR8uJB7weCPLlbwG+84l0=;
        b=jW9r/phAxCAGlVCq4PGIGzCwFVu8kiS2bss2Iiz+dKl3nMFhE5nNlqPfRM5DpCJlKp
         uZDbaHGdTZ5+jzTA5Rw+IcIlDNd9mDWY17yJMZ+5AXttYqLtZ01jOmIe5/qsIiN3F0mS
         PCEuRUUhsbjFKNuslY5HILe5L+ZIBcU0KdnssH2SdfW0Ho2qd+xHoTIeQmvULTuFTf9M
         NroA4d83AdHB3NVcVd+XU0ksGzFjYlSVG8RtskU4cQr5GU6YB2NCM5f+pE7j41mskIr+
         A1CvGs3JVt8pSoJYqa0hA4XdmyKP9L0U/ano+0kyss9P3dPcA15m4qek9z9mo4Ac8WxP
         8/1Q==
X-Gm-Message-State: AKS2vOyKNm7I9RNYsxzkf3V8jFYbHRtHvb4Gr9GELKWjHQOMGPMQH5uv
        2Mc7QCd8acjHKQ==
X-Received: by 10.98.216.193 with SMTP id e184mr23479845pfg.46.1498848024020;
        Fri, 30 Jun 2017 11:40:24 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:54f:b41d:dd9d:3de0])
        by smtp.gmail.com with ESMTPSA id r28sm22410413pfd.4.2017.06.30.11.40.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 30 Jun 2017 11:40:23 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jeff King <peff@peff.net>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: [PATCHv2 1/2] hashmap.h: compare function has access to a data field
References: <20170629011334.11173-1-sbeller@google.com>
        <20170629235336.28460-1-sbeller@google.com>
        <20170629235336.28460-2-sbeller@google.com>
        <xmqqh8yxs7by.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kbWXuC2y97+nOsgvNhCCqg=2+VgOOvTbUn1LGpH4f0=PQ@mail.gmail.com>
Date:   Fri, 30 Jun 2017 11:40:22 -0700
In-Reply-To: <CAGZ79kbWXuC2y97+nOsgvNhCCqg=2+VgOOvTbUn1LGpH4f0=PQ@mail.gmail.com>
        (Stefan Beller's message of "Fri, 30 Jun 2017 11:00:19 -0700")
Message-ID: <xmqqzicpqpyh.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> I am at a loss here after re-reading your answer over and over,
> but I think you are asking if patch_id_cmp can break, as
> we have a callchain like
>
>   patch_id_cmp
>     commit_patch_id
>       (diff_root_tree_oid)
>         diff_tree_oid
>           ll_diff_tree_oid
>
> passing diff_options down there, and patch_id_cmp may have
> gotten NULL.
>
> The answer is no, it was safe. (by accident?)
>
> That is because we never use hashmap_get_next
> on the hashmap that uses patch_id_cmp as the compare
> function.
>
> hashmap_get_next is the only function that does not pass
> on a keydata, any other has valid caller provided keydata.

Ah, thanks for clarifying.  I think I misread the earlier
discussion.  So unless somebody goes in to patch-ids.c and adds a
call to do get_next, we won't see a breakage, and it is not worth to
do a test-patch-ids.c that peeks into the hashmap patch-ids.c uses
and does get_next() only to demonstrate a potential future breakage.

OK.
