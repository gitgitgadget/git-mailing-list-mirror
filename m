Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85A821F453
	for <e@80x24.org>; Wed,  3 Oct 2018 19:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbeJDBuR (ORCPT <rfc822;e@80x24.org>);
        Wed, 3 Oct 2018 21:50:17 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:45290 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbeJDBuR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 3 Oct 2018 21:50:17 -0400
Received: by mail-ot1-f65.google.com with SMTP id u22so6620503ota.12
        for <git@vger.kernel.org>; Wed, 03 Oct 2018 12:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w9n1QuUsmgagCXp5jPRcRGs44akDJEnAdkD4vLElobw=;
        b=ojMsVBfOY8GHg8N+vNVp6tE10L3X30qt4Cl3/0kfU5D+YaAwMpzFBfZgDu90odl0tM
         VcY3bLLLe396D6QYX7CxoxE1Q3ZXZuF1UToz3v7eK/dsDHTGwGOGoqxD+MmGEKtrme+I
         ptrb0QM8WOqs11cxbi4iSXyW7P5ZlMvIqFC64o6+xRsdhpB851yHyibTMZTlUdvpBZeJ
         6U3+OgjxOnkZjM7uaEIV675hX5TaiXZkO/QawSBI0P9uXONhppK/FalB0iFY7lnGsrAV
         iGAgSiqV6dvliXUQEEOmJ9shzQfIfjktSjKM6hjqnr2tWBaaWa9GFQZhAqEZPNU/Xw+C
         KCqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w9n1QuUsmgagCXp5jPRcRGs44akDJEnAdkD4vLElobw=;
        b=Mz3Nz02LtA8j2gWCKroy53REb0gHC4xxo+GYo3Ll7vT0nnHpbT1Ec2iWMN+vjszkG/
         gd2Hr8ekkOj1PKhvux8YUbKQBTMVXNi6/4zMHCE5Ua3adDCl8lcRcZNWzaaVS+jw6Pp1
         g0SHWWvEH9YEwsvQmRxBMlkSYIHUCw7LWQ+9L2QyeAdSZoD0PQEfBDSEeFfpT31i9VFY
         QnidfewP6pYlw/XbtZbLtUsSNzW7geoqHhopCeTO+klYQjU4Yci7GaGezM8KcqDx5i9t
         fIXC87wWl8q0CjDogLfXSX55onkby8tVAngKpTH5Vc8G6kRvedWPy3hYkdRa032Vjcsg
         2NRg==
X-Gm-Message-State: ABuFfogeKQssWZkW5NC0vO4Zbwg7F7RX66SYN41lNj2hvGhjN75YCMAz
        UxNtN0Umifc7/wQyA7UieIEiXGLYUU3QR/1aL9XslZEdZA==
X-Google-Smtp-Source: ACcGV63JivxqTXC4VTFzfDhrndp266MoG+DP8I2vYWBLsCVG/XA/VXpp3guugaFm+2ZysVqmLaVaV5CqA+1n9WA2yys=
X-Received: by 2002:a9d:32c3:: with SMTP id u61-v6mr1555454otb.173.1538593237793;
 Wed, 03 Oct 2018 12:00:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1533854545.git.matvore@google.com> <cover.1534183648.git.matvore@google.com>
 <92faf2e011474bcc87b1b0974e7e232f6469dc4a.1534183648.git.matvore@google.com> <d751d56b-84bb-a03d-5f2a-7dbaf8d947cc@jeffhostetler.com>
In-Reply-To: <d751d56b-84bb-a03d-5f2a-7dbaf8d947cc@jeffhostetler.com>
From:   Matthew DeVore <matvore@google.com>
Date:   Wed, 3 Oct 2018 12:00:25 -0700
Message-ID: <CAMfpvhLsrBPtH66bOLX8HKmdKHs6_BpxG4q6P6MUkH-JUafkCg@mail.gmail.com>
Subject: Re: [PATCH v3 5/5] list-objects-filter: implement filter tree:0
To:     git@jeffhostetler.com
Cc:     git@vger.kernel.org, jeffhost@microsoft.com,
        Jeff King <peff@peff.net>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 8:13 AM Jeff Hostetler <git@jeffhostetler.com> wrote:
>
> There are a couple of options here:
> [] If really want to omit all trees and blobs (and we DO NOT want
>     the oidset of everything omitted), then we might be able to
>     shortcut the traversal and speed things up.
>
>     {} add a LOFR_SKIP_TREE bit to list_objects_filter_result
>     {} test this bit process_tree() and avoid the init_tree_desc() and
>        the while loop and some adjacent setup/tear-down code.
>     {} make this filter something like:
>
>         case LOFS_BEGIN_TREE:
>                 if (filter_data->omits) {
>                         oidset_insert(filter_data->omits, &obj->oid);
>                         return LOFR_MARK_SEEN; /* ... (hard omit) */
>                 } else
>                         return LOFR_SKIP_TREE;
>         case LOFS_BLOB:
>                 if (filter_data->omits) {
>                         oidset_insert(filter_data->omits, &obj->oid);
>                         return LOFR_MARK_SEEN; /* ... (hard omit) */
>                 else
>                         assert(...should not happen...);
>
> [] Later, if we choose to actually support a depth>0, we'll probably
>     want a different filter function to conditionally include/exclude
>     blobs, include shallow tree[node]s, and do some of the provisional-
>     omit logic on deep tree[nodes] (in case a tree appears at multiple
>     places/depths in the history).  But that can wait.
>
> Jeff
>

Jeff, have you made any progress on depth>0 support for the tree
filter? I'd like to take a stab at it without duplicating work :)

- Matt
