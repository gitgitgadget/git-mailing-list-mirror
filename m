Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F9071F453
	for <e@80x24.org>; Mon, 24 Sep 2018 17:59:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730059AbeIYACw (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Sep 2018 20:02:52 -0400
Received: from mail-pg1-f169.google.com ([209.85.215.169]:36761 "EHLO
        mail-pg1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728468AbeIYACw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Sep 2018 20:02:52 -0400
Received: by mail-pg1-f169.google.com with SMTP id d1-v6so9500386pgo.3
        for <git@vger.kernel.org>; Mon, 24 Sep 2018 10:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:mime-version:subject:message-id:date
         :to;
        bh=4DJQ/8g5cQl9LVZfeVlxNOS5KPehwzpYQksSjnb3TN0=;
        b=Xq55bi7QJw/uTHYJzi+vQsyzGnLNLY4NsyWn40yWsDfZRLxtQrfhIjoqK5WLv68gG6
         fBHE15zYvqM5gIL3qeBP593W+yYtV+h7fcAy9roajXK5VXJCUQA0diFoXtEqZbjln06J
         aDamzW4oZTcitcC+NUsaQ6VLwkw6hbPXyFoaY5wY7s0Hj2MuPmZgXOavnaEveLvjuv3y
         /n+nrcO8gRUKNgnr7cOfXHrnTvWTJO0SLO45WPb1riEviWOY0e9DnArDZcVs2W0bjc/y
         GdjfOSM3KhBPNhcCT9be06jRddfZoTaoEILv8VuGWc3O7/3yLYXkgHEol00WasYWcUi6
         dxuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:to;
        bh=4DJQ/8g5cQl9LVZfeVlxNOS5KPehwzpYQksSjnb3TN0=;
        b=p9PCL3soue6uCeyduIDPkZP8k4R8thg974d+veqGW2a9AKd5p7nAJnp9iIYld00fb+
         cECdwH+Y1DgFbHpXAgGuGdamauz22ZcxMXvU2QPcuTX8bPuFjmzQe0+masKEwGUE8QD1
         A5/uemr4dpLgGKca+j131mc/YOI2g0nRJWBSUphOtP+zeOnC1kSzNbgQ6fDOtoFrrkkB
         6MXmwesgQa45AkXwd28SxySbPINn4XcXidEir+WiRkR98749jiuT8tO5Gr0f9B/pXfwh
         jKy73thG3lbAot9M2qbgZM2s5geE6/JeydaLVAlI27I4G0gHHamAK1H3gR0Zjaz8Icfs
         VUmA==
X-Gm-Message-State: ABuFfoid8CNIgPDUq/j7n7feY69HThuBsX+F+vmlV1KHSeoJsKvvyLWp
        Ni0R2fK080wUiar7SvCdSJHzNo/r
X-Google-Smtp-Source: ANB0VdYOeZis12wSdV5U3XmPOlQARvxV2aYs3JcfnGAAiN/bosZoHzZD3zbKAi9b0r14qf+88HGEFg==
X-Received: by 2002:a62:f610:: with SMTP id x16-v6mr11228592pfh.169.1537811971382;
        Mon, 24 Sep 2018 10:59:31 -0700 (PDT)
Received: from smckelvie-mbp2tb.corp.xevo.com (hq.xevo.com. [4.14.243.50])
        by smtp.gmail.com with ESMTPSA id r205-v6sm49264784pgr.11.2018.09.24.10.59.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Sep 2018 10:59:30 -0700 (PDT)
From:   Sam McKelvie <sammck@gmail.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Mac OS X Mail 11.5 \(3445.9.1\))
Subject: "git rev-parse --show-superproject-working-tree" fails with "fatal:
 BUG: returned path string doesn't match cwd?" if supermodule has unmerged
 changes of the submodule reference
Message-Id: <EE3D88E4-EF86-44E2-811D-535C8F19C51A@gmail.com>
Date:   Mon, 24 Sep 2018 10:59:28 -0700
To:     git@vger.kernel.org
X-Mailer: Apple Mail (2.3445.9.1)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I experienced this problem using git 2.17.1; however, from inspection of =
the next branch, function get_superproject_working_tree() in submodule.c =
has not changed in 2 years.

I believe the problem is related to the fact that when a merge of the =
submodule reference is in progress, "git --stage =E2=80=94full-name =
<submodule-relative-path>=E2=80=9D returns three seperate entries for =
the submodule (one for each stage) rather than a single entry; e.g.,

$ git ls-files --stage --full-name submodule-child-test
160000 dbbd2766fa330fa741ea59bb38689fcc2d283ac5 1	=
submodule-child-test
160000 f174d1dbfe863a59692c3bdae730a36f2a788c51 2	=
submodule-child-test
160000 e6178f3a58b958543952e12824aa2106d560f21d 3	=
submodule-child-test

The code in get_superproject_working_tree() uses the =E2=80=9C-z=E2=80=9D =
option on ls-files, so it expects null-byte termination between entries. =
However, the computation of super_sub_len:

    		super_sub_len =3D sb.buf + sb.len - super_sub - 1;

will only work when there is exactly one entry returned. If this line is =
changed to:

		super_sub_len =3D strlen(super_sub);

then only the first returned entry is used, and the bug is resolved.

strlen() should be safe to use here because strbuf_read ensures the =
result buffer is null-terminated.

Thanks,
Sam McKelvie


