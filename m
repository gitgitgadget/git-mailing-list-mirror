Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 066D51F404
	for <e@80x24.org>; Tue, 14 Aug 2018 20:09:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728137AbeHNW61 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 18:58:27 -0400
Received: from mail-it0-f41.google.com ([209.85.214.41]:38865 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbeHNW61 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 18:58:27 -0400
Received: by mail-it0-f41.google.com with SMTP id v71-v6so21782873itb.3
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 13:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=bXGVLIpap+MmAdq2ajhxMHhB+9hvdCFrt4qXd7iL83s=;
        b=Jb+lD6UGhwUgP5p0RnbqQZzswwJJbtPlVRQ6EBI2R+j9ktNxTeU55ZzrpjTWPsaYe0
         2ct42Ru7uCczRNC/QbXAn9O5q1nUfmOQVp/1MX16yHmcqkMvoI9AoZC6o37XZ5FEuq0h
         oSTVHOC5nKRtajcbRfAwh/HzwgRqwhXdpKLWEkNZwuL4HLbIfBNkRbvTeksXxmd7HB5H
         TZxP0OXFP5lFRM4UldyPEgAOGIEzPJ+ORGPD65cNmep2m0WNNRQj6GI3HlQnVeWQpvT0
         o1FODtSxpmm/XSjz6LXLu5G34xaauh4yIo+7DY5qINEDRLLHdPeK02IRsP1kMQaT7kZc
         cUng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=bXGVLIpap+MmAdq2ajhxMHhB+9hvdCFrt4qXd7iL83s=;
        b=oQeUIaW58kYYKjUfhJI3le5RH0tTy9r/o/wI6dof++TGcPs5csVfbb7v+eZoELjYMQ
         0WYqiIESukXNGD+rGCNqOWAbmYsDKBfXaop+RRkUd2y3vK+Z8AiRIbcE49OSsNNQRIef
         dCFwbn1xbKqGdMVGi8R+Y+JliixLUrEE7YR7tsq/N5R8OifCDf4xILRFOzNPcOx1+650
         KyhG0yzs+rEHXwy2nOvTLWC3RI+WMxh/W4dbq05m2862qI8CwhvHLIRc9hsGRq495yQh
         iBMY+5T0ACv/ZCeM/EF7L2oFYsHE1vfNCYxqaP2ZTK8jtD17CbYM/HTD5J8hb4RwIEC9
         TlZg==
X-Gm-Message-State: AOUpUlF3w8EQM6hpeYhdArbsOQdrfQ9eccFlUkE0w/nQ9rHDp+eGxaT8
        H1sGbU4ZzeYMcDgx/Ki7rgJ+t3EgIq9RbMh6/FYSCj07
X-Google-Smtp-Source: AA+uWPzPTD6ZbQJVIGShP8p56shY5Xu8fWeZNfV+NIEHjEUDZgt/zA5Q6VOW1zDqjfRbgBfMkd3DfhDbewKEpuPGD8w=
X-Received: by 2002:a24:dd88:: with SMTP id t130-v6mr14929191itf.129.1534277378137;
 Tue, 14 Aug 2018 13:09:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4f:228d:0:0:0:0:0 with HTTP; Tue, 14 Aug 2018 13:09:37
 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 14 Aug 2018 22:09:37 +0200
Message-ID: <CAP8UFD0_jpKdcDvNx5CYnmyDMagE_O-E7cef5VthaT_w-=4xsA@mail.gmail.com>
Subject: Syncing HEAD
To:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

When cloning with --mirror, the clone gets its HEAD initialized with
the value HEAD has in its origin remote. After that if HEAD changes in
origin there is no simple way to sync HEAD at the same time as the
refs are synced.

It looks like the simplest way to sync HEAD is:

1) git remote show origin
2) parse "HEAD branch: XXX" from the output of the above command
3) git symbolic-ref HEAD refs/heads/XXX

It looks like it would be quite easy to add an option to `fetch` to
sync HEAD at the same time as regular refs are synced because every
fetch from an origin that uses a recent Git contains something like:

19:55:39.304976 pkt-line.c:80           packet:          git< YYYYYYYY
HEAD\0multi_ack thin-pack side-band side-band-64k ofs-delta shallow
deepen-since deepen-not deepen-relative no-progress include-tag
multi_ack_detailed no-done symref=HEAD:refs/heads/test-1
agent=git/2.18.0

which in this example shows that HEAD is a symref to refs/heads/test-1
in origin.

Is there a reason why no such option already exists? Would it makes
sense to add one? Is there any reason why it's not a good idea? Or am
I missing something?

I am asking because GitLab uses HEAD in the bare repos it manages to
store the default branch against which the Merge Requests (same thing
as Pull Requests on GitHub) are created.

So when people want to keep 2 GitLab hosted repos in sync, GitLab
needs to sync HEADs too, not just the refs.

I think this could be useful to other setups than GitLab though.

Thanks,
Christian.
