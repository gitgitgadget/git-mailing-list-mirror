Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.5 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C71E21F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 23:56:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbfJNX4c (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 19:56:32 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:51841 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726799AbfJNX4c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 19:56:32 -0400
Received: by mail-pf1-f202.google.com with SMTP id s137so14478803pfs.18
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 16:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=WA+D4RTk2FkGek10p3VJNike1zZVCWVduF1F6T680CY=;
        b=ceMVRviKrR5hdYenJT7nYp81yKERHkyRbLBuF4mWr2NPfA34GbAbjbZ6mnGPIFPHRS
         YPwndlPXsZyTkOnCVfbkeu+xboUEg2GSyxvYoN4y2N5LfCtcFOqrZafrF3C9k/TT0+vg
         5nAHk3WhMEbX3wOi6EPNPhJKmQnICHD5Sus1QxS2Qucqhi1KrSKlbExPU7lQyKqIH9V+
         pwYR/8NK3dqFuNW15KxjG0gXZJlRruYEbJKS8ppWI/cxm9iZB1zFxcAFUnH9B2BaZD0D
         Z8XbjM+F0GxU6HHqn2LH+XdRuPsDt2pQ+taY1VxYtbk0PuyayI82AZ86dgF1iYGPD7iM
         eW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=WA+D4RTk2FkGek10p3VJNike1zZVCWVduF1F6T680CY=;
        b=tiZky0y+p9u4X3xdpP8H5Orxr45v4xzejewJQLxWWtSngXmXy/41mnWu5pd4sbiGKJ
         ThC8C8guwk7VP1hA1Baok34M31cPcQHTBzjqbJWonL54S11k/Eq/1QagUAt5pxoI7uR/
         hwZnF1gnGB/f0QTUkNhUhSDFiRC7t5ERV7DssEk7ivH9ztbyI+ofXBAbAUz5DLiqhoqc
         NE0mghHQi3fb6iyoTdLy/q00zaC1EHELmFjmM6n1l3xVYSTMsKfQ+M50e6uRd/1/zwtT
         jlthHXQ/+OiLVwS/+E9JDJGeHJR9P2g0R0wVMcnM56zCO76RfnsAkE+BoAM9cUo4vRNk
         /m/Q==
X-Gm-Message-State: APjAAAWUpp8eoKQytRJM1bqI6u/nRcHMnBhAjB4O4j22M1X2D15SY8Bw
        bIglx6HN21O6uE/i6cOuDEkR4erB5n8IP9az069S
X-Google-Smtp-Source: APXvYqz8f7zsMh6AyfGCUlYPJN8SBxZxSikaLjSji2ymrbAjAQy9eIIdhJPQjoUFq7S3DiRsVJVm9gCBWJrctS+oACo4
X-Received: by 2002:a63:1053:: with SMTP id 19mr34498795pgq.229.1571097391586;
 Mon, 14 Oct 2019 16:56:31 -0700 (PDT)
Date:   Mon, 14 Oct 2019 16:56:28 -0700
In-Reply-To: <20191014222749.GB233821@google.com>
Message-Id: <20191014235628.153287-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20191014222749.GB233821@google.com>
X-Mailer: git-send-email 2.23.0.700.g56cf767bdb-goog
Subject: Re: [PATCH] fetch-pack: write fetched refs to .promisor
From:   Jonathan Tan <jonathantanmy@google.com>
To:     steadmon@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for your comments. Rearranging them:

> This makes me wonder why we don't also change index-pack to write a
> similar message to the .promisor. I guess there's potentially too much
> information to shove all the refs on the command-line?

index-pack already is capable of writing messages to .promisor using the
"--promisor" argument. You're right that I'm not using that because I
don't want to run into argument length limits.

> I am not sure why we want to tie creating the .promisor to creating the
> lockfile. I'll keep reading and see if it becomes clear later. Other
> than that, the logic here seems clear.

[snip]

> Apart from using the lockfile name as the base for the .promisor
> filename, I'm still not seeing why we need to tie this to the fact that
> we're creating a lockfile. Could we instead just unconditionally create
> the .promisor when args->from_promisor is set, and then remove the logic
> in the previous chunk that adds the "--promisor" flag to the index-pack
> call?

I'm tying the promisor to the lockfile to avoid overcomplicating things:
fetch-pack currently reads filename information from index-pack only
when there is a lockfile. (It could do so even when there is no
lockfile, but it currently does not.) We need this filename to know what
to call the ".promisor" file.

And the situation that I'm interested in - when the user fetches with
"git fetch" from http or ssh - always uses a lockfile (see
fetch_refs_via_pack() in transport.c). So I'm writing additional data in
this case, and falling back on the "--promisor" flag otherwise. I'll
elaborate in the commit message.
