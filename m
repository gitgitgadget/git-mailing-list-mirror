Return-Path: <SRS0=m/NF=B2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E0DC433DF
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 15:34:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F06206C0
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 15:34:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t8DGOiPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728346AbgHPPeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Aug 2020 11:34:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726407AbgHPPeB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Aug 2020 11:34:01 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1F10C061786
        for <git@vger.kernel.org>; Sun, 16 Aug 2020 08:34:00 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id w25so14768508ljo.12
        for <git@vger.kernel.org>; Sun, 16 Aug 2020 08:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4YOE5lxlhvw1ehNaNLm3fkmZ+ybBqVRWtOR8TIt6Ulk=;
        b=t8DGOiPbSOcjQxHuVj8uw+To+hfdk9toiI8GgXNgUa4taC9gucYDfZ/xT5R632PCU2
         jz/yhO+GaTJqer6l+YlY8RuE7pstCEwV436d0hPP9zjq6ct9qD+YhOECHFIruSet6qcb
         TCjaijJg6w8AiVETsDdVREGkMm2k0A2rJaz896b9RxU/TIDITAcSXFoedxc0l8U5qgLb
         xqrM25SbAwCuYtCqTxuBWfxwywYBsLb0oRxEJ04B2I2bAKNAAe6Gmmeyq3ST8Gyne+HQ
         lJtRF5XYgi9jVzaQovNWAJiZmaWPzvtebq5tAahDImO7S6f8PHy5smQx0fPzw1RsSEub
         +vaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4YOE5lxlhvw1ehNaNLm3fkmZ+ybBqVRWtOR8TIt6Ulk=;
        b=MnebyOegs7EREBRzMVjbR/i7zmk8iN/Eb3NyTGastPrY8CFQSw+MwpSJgRu0rhEbDU
         I1QnbvdUbXFn51NidFmKJdVPthVucVSjPxiutmY5Vgxdh4thGrGIOJYEpBoJerhayLhI
         fDXJMPmIaYgfysf/TqA/yc93mWjCsLhAYrX2vn/QxWPPVlzJnOUR/LVHMsOs/ABt58j6
         VUUh5wU2Ks3gCsRoVDHSnQ2a1A5yIQmkQYqENpKYzOkxRZu+xz+8K37q8K+A1zwkIqzI
         mQga1c0up5JZqbuB7RR5oJfACYgmXDiIiUEf+ueCtcsqqBtcYt6AFJccPET18INiRLME
         bHhA==
X-Gm-Message-State: AOAM531kBkp73q7YOn6n39TSRDbp2GQ8agXDdmUpO1YBGha5PGC2cUSF
        /tSBCIsWm4lCAspEHgg+GhyDJIgZJKwoXA==
X-Google-Smtp-Source: ABdhPJyXSNIu7XslLrVP9e5l72UslpZqVZPuNH1PY1UKVbO0Lx+CIO2pPAOghkCJADAcHYXZC678mw==
X-Received: by 2002:a05:651c:238:: with SMTP id z24mr5682138ljn.172.1597592036666;
        Sun, 16 Aug 2020 08:33:56 -0700 (PDT)
Received: from localhost.localdomain (92-33-153-30.customers.ownit.se. [92.33.153.30])
        by smtp.gmail.com with ESMTPSA id y28sm4110026lfl.15.2020.08.16.08.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Aug 2020 08:33:56 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        Andreas Schwab <schwab@suse.de>,
        Birger Skogeng Pedersen <birger.sp@gmail.com>,
        Birger Skogeng Pedersen <birgersp@gmail.com>,
        Brandon Williams <bwilliams.eng@gmail.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Damien Robert <damien.olivier.robert+git@gmail.com>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Ed Maste <emaste@FreeBSD.org>, Ed Maste <emaste@freebsd.org>,
        Fangyi Zhou <me@fangyi.io>,
        Fangyi Zhou <fangyi.zhou@yuriko.moe>,
        Jiang Xin <worldhello.net@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Kevin Willford <Kevin.Willford@microsoft.com>,
        Kevin Willford <kewillf@microsoft.com>,
        Peter Kaestle <peter@piie.net>,
        Peter Kaestle <peter.kaestle@nokia.com>,
        Sun Chao <sunchao9@huawei.com>, Sun Chao <16657101987@163.com>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2] Update .mailmap
Date:   Sun, 16 Aug 2020 17:30:37 +0200
Message-Id: <20200816153037.1143576-1-martin.agren@gmail.com>
X-Mailer: git-send-email 2.28.0.277.g9b3c35fffd
In-Reply-To: <20200805065408.1242617-1-martin.agren@gmail.com>
References: <20200805065408.1242617-1-martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Similar to a35b13fce0 ("Update .mailmap", 2018-11-09), make the output
of `git shortlog -nse v2.10.0..master` duplicate-free by taking/guessing
the current and preferred addresses for authors that appear with more
than one address.

By request, don't add an entry for Andreas Schwab. For Brandon Williams,
use the e-mail address they gave in a62527b0e5 ("mailmap: update brandon
williams's email address", 2018-12-07). Peter Kaestle has used different
addresses to separate work-time and spare-time contributions, but
similar to 3fa0e04667 ("mailmap: add an additional email address for
brian m. carlson", 2020-02-20), has asked that we attribute those
commits to the same person.

Use the by far most common e-mail address:
 * Jiang Xin

Use the most recent e-mail address:
 * Birger Skogeng Pedersen
 * Ed Maste
 * Fangyi Zhou
 * Kevin Willford
 * Peter Kaestle

Use the one they used for their "Signed-off-by":
 * Damien Robert
 * Sun Chao

Acked-by: Ed Maste <emaste@FreeBSD.org>
Acked-by: Damien Robert <damien.olivier.robert+git@gmail.com>
Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 .mailmap | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index bde7aba756..f3b335af20 100644
--- a/.mailmap
+++ b/.mailmap
@@ -27,8 +27,10 @@ Ben Peart <benpeart@microsoft.com> <peartben@gmail.com>
 Ben Walton <bdwalton@gmail.com> <bwalton@artsci.utoronto.ca>
 Benoit Sigoure <tsunanet@gmail.com> <tsuna@lrde.epita.fr>
 Bernt Hansen <bernt@norang.ca> <bernt@alumni.uwaterloo.ca>
+Birger Skogeng Pedersen <birger.sp@gmail.com> <birgersp@gmail.com>
 Brandon Casey <drafnel@gmail.com> <casey@nrlssc.navy.mil>
 Brandon Williams <bwilliams.eng@gmail.com> <bmwill@google.com>
+Brandon Williams <bwilliams.eng@gmail.com> <bwilliamseng@gmail.com>
 brian m. carlson <sandals@crustytoothpaste.net>
 brian m. carlson <sandals@crustytoothpaste.net> <sandals@crustytoothpaste.ath.cx>
 brian m. carlson <sandals@crustytoothpaste.net> <bk2204@github.com>
@@ -45,6 +47,7 @@ Christopher Díaz Riveros <chrisadr@gentoo.org> Christopher Diaz Riveros
 Clemens Buchacher <drizzd@gmx.net> <drizzd@aon.at>
 Clemens Buchacher <drizzd@gmx.net> <clemens.buchacher@intel.com>
 Csaba Henk <csaba@gluster.com> <csaba@lowlife.hu>
+Damien Robert <damien.olivier.robert+git@gmail.com> <damien.olivier.robert@gmail.com>
 Dan Johnson <computerdruid@gmail.com>
 Dana L. How <danahow@gmail.com> <how@deathvalley.cswitch.com>
 Dana L. How <danahow@gmail.com> Dana How
@@ -64,13 +67,15 @@ Derrick Stolee <dstolee@microsoft.com> Derrick Stolee via GitGitGadget <gitgitga
 Deskin Miller <deskinm@umich.edu>
 Đoàn Trần Công Danh <congdanhqx@gmail.com> Doan Tran Cong Danh
 Dirk Süsserott <newsletter@dirk.my1.cc>
+Ed Maste <emaste@FreeBSD.org> <emaste@freebsd.org>
 Eric Blake <eblake@redhat.com> <ebb9@byu.net>
 Eric Hanchrow <eric.hanchrow@gmail.com> <offby1@blarg.net>
 Eric S. Raymond <esr@thyrsus.com>
 Eric Wong <e@80x24.org> <normalperson@yhbt.net>
 Erik Faye-Lund <kusmabite@gmail.com> <kusmabite@googlemail.com>
 Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com> <eyvind-git@orakel.ntnu.no>
-Fangyi Zhou <fangyi.zhou@yuriko.moe> Zhou Fangyi
+Fangyi Zhou <me@fangyi.io> <fangyi.zhou@yuriko.moe>
+Fangyi Zhou <me@fangyi.io> Zhou Fangyi <fangyi.zhou@yuriko.moe>
 Florian Achleitner <florian.achleitner.2.6.31@gmail.com> <florian.achleitner2.6.31@gmail.com>
 Franck Bui-Huu <vagabon.xyz@gmail.com> <fbuihuu@gmail.com>
 Frank Lichtenheld <frank@lichtenheld.de> <djpig@debian.org>
@@ -107,6 +112,8 @@ Jeff Muizelaar <jmuizelaar@mozilla.com> <jeff@infidigm.net>
 Jens Axboe <axboe@kernel.dk> <axboe@suse.de>
 Jens Axboe <axboe@kernel.dk> <jens.axboe@oracle.com>
 Jens Lindström <jl@opera.com> Jens Lindstrom <jl@opera.com>
+Jiang Xin <worldhello.net@gmail.com> <xin.jiang@huawei.com>
+Jiang Xin <worldhello.net@gmail.com> <zhiyou.jx@alibaba-inc.com>
 Jim Meyering <jim@meyering.net> <meyering@redhat.com>
 Joachim Berdal Haga <cjhaga@fys.uio.no>
 Joachim Jablon <joachim.jablon@people-doc.com> <ewjoachim@gmail.com>
@@ -142,6 +149,7 @@ Kazuki Saitoh <ksaitoh560@gmail.com> kazuki saitoh <ksaitoh560@gmail.com>
 Keith Cascio <keith@CS.UCLA.EDU> <keith@cs.ucla.edu>
 Kent Engstrom <kent@lysator.liu.se>
 Kevin Leung <kevinlsk@gmail.com>
+Kevin Willford <Kevin.Willford@microsoft.com> <kewillf@microsoft.com>
 Kirill Smelkov <kirr@navytux.spb.ru> <kirr@landau.phys.spbu.ru>
 Kirill Smelkov <kirr@navytux.spb.ru> <kirr@mns.spb.ru>
 Knut Franke <Knut.Franke@gmx.de> <k.franke@science-computing.de>
@@ -209,6 +217,7 @@ Paul Mackerras <paulus@samba.org> <paulus@dorrigo.(none)>
 Paul Mackerras <paulus@samba.org> <paulus@pogo.(none)>
 Peter Baumann <waste.manager@gmx.de> <Peter.B.Baumann@stud.informatik.uni-erlangen.de>
 Peter Baumann <waste.manager@gmx.de> <siprbaum@stud.informatik.uni-erlangen.de>
+Peter Kaestle <peter@piie.net> <peter.kaestle@nokia.com>
 Peter Krefting <peter@softwolves.pp.se> <peter@softwolves.pp.se>
 Peter Krefting <peter@softwolves.pp.se> <peter@svarten.intern.softwolves.pp.se>
 Petr Baudis <pasky@ucw.cz> <pasky@suse.cz>
@@ -256,6 +265,7 @@ Steven Grimm <koreth@midwinter.com> <sgrimm@sgrimm-mbp.local>
 Steven Grimm <koreth@midwinter.com> koreth@midwinter.com
 Steven Walter <stevenrwalter@gmail.com> <swalter@lexmark.com>
 Steven Walter <stevenrwalter@gmail.com> <swalter@lpdev.prtdev.lexmark.com>
+Sun Chao <sunchao9@huawei.com> <16657101987@163.com>
 Sven Verdoolaege <skimo@kotnet.org> <Sven.Verdoolaege@cs.kuleuven.ac.be>
 Sven Verdoolaege <skimo@kotnet.org> <skimo@liacs.nl>
 SZEDER Gábor <szeder.dev@gmail.com> <szeder@ira.uka.de>
-- 
2.28.0.277.g9b3c35fffd

