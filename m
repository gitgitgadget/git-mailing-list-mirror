Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AE4CC76196
	for <git@archiver.kernel.org>; Mon,  3 Apr 2023 19:23:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230414AbjDCTXk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Apr 2023 15:23:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjDCTXj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Apr 2023 15:23:39 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11FA6E7C
        for <git@vger.kernel.org>; Mon,  3 Apr 2023 12:23:38 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C98E53200495;
        Mon,  3 Apr 2023 15:23:34 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 03 Apr 2023 15:23:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1680549814; x=1680636214; bh=4eytkVrSnw6hpkIRQwFd+0bDG
        vH2/bGpCSkDtX6khwM=; b=baiPNzOVddmyzByQiHkd1rUy+yg2xEOdAOom7m7yv
        Ru0gjiYOQewxirUoLQPOCpyYm5RcPXSpxfWxGZNdWtvbfSRHUXmrFD/qgB3YsrB5
        iZLCZ0KmtyNpKqyyyOYVIbn3E88AaZ+ckm3AH0uBX41i4+s09x/+R20IVA4Dt1Rg
        799Xxz7XVA7XXmVQSzgskh1qmjeDrV/fOWJIcXIlMBGQjg8T24s1imU3xL4gpVxz
        tU50d2AAv4devp9gZ1HGRP5ODdVKeXIJ89Q3IMICddcaLAdgonwodRVdiJy8dqTJ
        fFLcAmSt5Eb8vSUa+UwbRDxuv4bFrkCr3h+g10oclOUGg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1680549814; x=1680636214; bh=4eytkVrSnw6hpkIRQwFd+0bDGvH2/bGpCSk
        DtX6khwM=; b=u3WmnoD439K8pC7ZhBe2fCr4KW92NF1wRYqmsdByx8s+fu9U1DU
        /yVHtbimIzzbRIUiK/3lr1TkS9tw/vhs+hEJUWF/EZ0CCS5MEbUM14THQcigtRv3
        +wjamb5DcBapAEfF32f/NArHoZnpsz76JKmLYjx+hnRSxeTRgqc76N3kozL+fHdI
        p39r3Fc9ugA/QN1tBAKzVpSIOEU/JFbqZZynZb82KAG1eNoM5nTUoWLZ+AwRRZPd
        wdBe65q+qh3AKjjhoXfWkJdwWchcLmpcyIG+epULxrZuub6Fw4rVf0aWtbwQQMCc
        iZ2fuUxxySRNHqlcVt2YQPiwEFhKM3FmETQ==
X-ME-Sender: <xms:ticrZBgM805DY3EJlOeE6cvPOg077ho_XSfQTcce0ukfsrncCTmAbJY>
    <xme:ticrZGDSbzhIj4XCwfAsefp73KDiLX-f3irw3TrvKGG0CLV9THPQAqYiEd1yvQyMq
    XM6snFiFwN2VjRJLA>
X-ME-Received: <xmr:ticrZBErf6YTIk-FUeCj2QgCs6jgxDLQgTicQyZJbGPUDYZQifdKFQwB_UOh7mwUsA_BSd31DVQpb_BgtLpYiG2xILfMTPH33IdnmqGN5Qxkb-r4iVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeijedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhephffvvefufffkofgjfhggtgfgse
    htkeertdertdejnecuhfhrohhmpefmrhhishhtohhffhgvrhcujfgruhhgshgsrghkkhcu
    oegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgeqnecuggftrfgrthhtvghrnhepve
    fgleevieekgeejieekueevhfelieduvdelgeefkeejtdekvedttefgffevtedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhh
    gruhhgshgsrghkkhdrnhgrmhgv
X-ME-Proxy: <xmx:ticrZGQIZtsB8JPBRW3wTdB_zwZ7h5FbrSpepvpsPx8y48skClCVsw>
    <xmx:ticrZOwub8bdZx9qRNPy7YHwkVpGTX0enpR-7yJZsMVrPkymUn1FRw>
    <xmx:ticrZM6e9cuPmxqJNVPEBkgX6yIs3mn2UIB8ilTp--HGXUn4Dd7-hw>
    <xmx:ticrZDo8KBXLBWosacPQh0JPrjB-fy4nQL_KCQV9HwVmey2K_s9e2A>
Feedback-ID: i2671468f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Apr 2023 15:23:33 -0400 (EDT)
From:   Kristoffer Haugsbakk <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     Kristoffer Haugsbakk <code@khaugsbakk.name>, rybak.a.v@gmail.com
Subject: [PATCH v2 0/3] doc: interpret-trailers: don't use deprecated config
Date:   Mon,  3 Apr 2023 21:21:58 +0200
Message-Id: <cover.1680548208.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230331181229.15255-1-code@khaugsbakk.name>
References: <xmqqsfdkep2b.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Replace deprecated `command` with `cmd` (patch 2). While visiting this
file also rewrite heredoc examples to use files which are shown with
cat(1) (patch 1) and fix two examples that didn’t work properly (patch
3).

§ Changes in v2

First of all I had to send a second version since I messed up sending my
v1 cover letter (unencoded Unicode in the subject). But I ended up doing
quite a few changes:

1. Patch 1: Junio had some alternative suggestions. Remove trailing
   spaces by using files which are shown with cat(1) and thereby make it
   easier to copy-paste from the docs.
2. Patch 2: Fix discrepancy (see/sign) in commit message (thanks to
   Andrei Rybak)
3. Patch 2: minor commit message correction
4. Patch 3: Fix another example and build on top of it by using the
   typical “subject/message” format instead of an empty file and an
   s-o-b file (a file with just an s-o-b trailer)

Kristoffer Haugsbakk (3):
  doc: interpret-trailers: don’t use heredoc in examples
  doc: interpret-trailers: don’t use deprecated config
  doc: interpret-trailers: fix examples

 Documentation/git-interpret-trailers.txt | 93 +++++++++++++-----------
 1 file changed, 52 insertions(+), 41 deletions(-)

Range-diff against v1:
1:  b57fac21e4 < -:  ---------- doc: interpret-trailers: remove trailing spaces
2:  d85e955ff2 < -:  ---------- doc: interpret-trailers: don’t use deprecated config
3:  bd6b78a707 < -:  ---------- doc: interpret-trailers: fix example
-:  ---------- > 1:  38f9a4bdf8 doc: interpret-trailers: don’t use heredoc in examples
-:  ---------- > 2:  ea06be8f5a doc: interpret-trailers: don’t use deprecated config
-:  ---------- > 3:  14555cf87f doc: interpret-trailers: fix examples
--
2.40.0
