Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9404FC38A02
	for <git@archiver.kernel.org>; Mon, 31 Oct 2022 13:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231462AbiJaNOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 09:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbiJaNOD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 09:14:03 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9375DCCC
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 06:14:02 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id f5-20020a17090a4a8500b002131bb59d61so12541778pjh.1
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 06:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pfResopG19/5s6Gc0cXS2BqW4L/nRwuaSk/xLmmoms4=;
        b=lKe665MF72S8fuIjpvd+DVW0jXR/uVh0CtmW3xPue/4u5PgU2d4TguWhVe41wkK880
         iYagI4gPamMIYGRVV1B3+HAusCpHXqkb/IxaApa+ahpwb/fAwdNmemgWp2PNkdpFCD/C
         nWXRTGQr+SmC739XvINe6dzNpNWz4WpAkQDTHfpaONyd3iO5zboNOmoCD6Tkzc9GgAeh
         f+1TFMNzzkl2D+CQckspg0t+1j/r7oDlSqSPXSiZJNlYIsZVR0Cwy9MsNgEln0Q0m+dw
         YhhLGxj8fF2D8nuyiTTDMcMY7hVu9enmQc5hfG91JHwS8Ql+kPb/qGnOMPH3dVgDaXHa
         YOQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pfResopG19/5s6Gc0cXS2BqW4L/nRwuaSk/xLmmoms4=;
        b=ktpG4asIMTvYkrIeX5IeoYcBXjPxaP1gExrbh28oGVS4mA/kY/Fzh3SiCOj3lb9edG
         Ids4+ddy9edymtsPcIhcsJJbYOR88UVvN+x6xOZtkK1mJfSBPZoWQbD9zM3xLn00BWgP
         Sy0Bm+WtQ0yXAtsIEl0Wc7HeyLYksWXddEcYaMB/SZFLCeNhpDFGLa2eNpdaARd7X6tm
         nE7c8XVb1px5Cagn1m04DEMwCYniX0OF0TbzOe1OCLCF05XE//MOHykP1zyVKi0HsHxL
         sw/kNBjy2OQGeRwUzrKvOOtdRwruEwGRt4QRzN+xHt6rDXUqwtuY2PIXdYKH+nYwLdzg
         h01Q==
X-Gm-Message-State: ACrzQf2BgMgcPsegCq0GMsrSReRFWb+MbotlTKFWbr16YEpwbIYtmVA2
        clUZkf0D2D6hKsdh8BwRw/k=
X-Google-Smtp-Source: AMsMyM6cXRts5bW3aL8Zk0abqOtciv7o1x+Hu9BnT1Gyqhfoalau+JQM5XlDHUmeHBz1qEZ3dzxZfw==
X-Received: by 2002:a17:90b:3901:b0:213:dfd5:a75f with SMTP id ob1-20020a17090b390100b00213dfd5a75fmr5836002pjb.233.1667222041997;
        Mon, 31 Oct 2022 06:14:01 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.45])
        by smtp.gmail.com with ESMTPSA id p7-20020a170902780700b001830ed575c3sm4391005pll.117.2022.10.31.06.13.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2022 06:14:01 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     me@ttaylorr.com
Cc:     avarab@gmail.com, derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, tenglong.tl@alibaba-inc.com
Subject: Re: [PATCH 0/1] pack-bitmap.c: avoid exposing absolute paths
Date:   Mon, 31 Oct 2022 21:13:56 +0800
Message-Id: <20221031131356.67007-1-dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.581.g7a5d018042
In-Reply-To: <Y1mp23NHB0qzKsPR@nand.local>
References: <Y1mp23NHB0qzKsPR@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> --- >8 ---

What does ">8" means? 

It's like a Github internal patch between the ">8"
and "<8" marks, right?

> ...and as the patch message notes, this is done mostly to prevent
> confusion when racily fetching from GitHub, or due to some
> misconfiguration.

> And in that instance, I think the patch from Peff is right. If there is
> a legitimate bug, we'd see it elsewhere and have sufficiently powerful
> tools to investigate it. But the warning is useless and confusing to
> users who don't have access to such tools.

Yes, currently there will be only one bitmap to be process and other
ones will be skipped, so we should remove it I think because it's no
actual meanings for client uses, they do not care about what the server
skipped and hope to avoid the disturbing information.

> For the general case of what ships in git.git, I *do* find this warning
> ...

"ships in git.git" means as the git developers, right?

> useful. It's helpful when hacking on pack-bitmap.c to know if you've
> messed up, and it's useful to see the filename of the affected
> bitmap(s).

I agree, let things expose entirely, but it's a trade-off.

> You could also imagine adding a configuration knob here to control
> whether or not the warning is shown, but I find that to be kind of
> gross.
> 
> So I think that the warning is--in general--too useful to consider
> removing it entirely, and that at most we should consider just emitting
> the basename of the pack, but nothing else. 

I think it's no need for a new config knob here, I agree with you on this
point.

And keep the pack basename seems like definitly a better solution than
the current one and I have a other solution which is to replace "warn()"
to a trace2 api, so the developer of git or ships in git.git if I
understand it right ;-) could get the warning in trace2 output by:


➜  pack git:(master) GIT_TRACE2_PERF=1 git rev-list --test-bitmap HEAD                                                                                                                                                                                                    <<<
21:04:08.702523 common-main.c:49             | d0 | main                     | version      |     |           |           |              | 2.38.0
21:04:08.702791 common-main.c:50             | d0 | main                     | start        |     |  0.001922 |           |              | /usr/local/bin/git rev-list --test-bitmap HEAD
21:04:08.703553 git.c:461                    | d0 | main                     | cmd_name     |     |           |           |              | rev-list (rev-list)
21:04:08.704889 usage.c:86                   | d0 | main                     | error        |     |           |           |              | ignoring extra bitmap file: '/Users/tenglong.tl/Downloads/trace-test/.git/objects/pack/pack-3cea516b416961285fd8f519e12102b19bcf257e.pack'
warning: ignoring extra bitmap file: '/Users/tenglong.tl/Downloads/trace-test/.git/objects/pack/pack-3cea516b416961285fd8f519e12102b19bcf257e.pack'
Bitmap v1 test (2 entries loaded)
Found bitmap for '2c5959955b5e6167181d08eeb30ee4099b4a4c5b'. 64 bits / ca44d5df checksum
21:04:08.705305 progress.c:268               | d0 | main                     | region_enter | r0  |  0.004448 |           | progress     | label:Verifying bitmap entries
Verifying bitmap entries: 100% (6/6), done.
21:04:08.705814 progress.c:340               | d0 | main                     | data         | r0  |  0.004955 |  0.000507 | progress     | ..total_objects:6
21:04:08.705829 progress.c:346               | d0 | main                     | region_leave | r0  |  0.004972 |  0.000524 | progress     | label:Verifying bitmap entries
OK!
21:04:08.705883 git.c:721                    | d0 | main                     | exit         |     |  0.005026 |           |              | code:0
21:04:08.705899 trace2/tr2_tgt_perf.c:215    | d0 | main                     | atexit       |     |  0.005043 |           |              | code:0



I don't know which is better and I will go on reading the left replies.

Thanks for the hard working on this patchset, Taylor, really appreciate for that.
