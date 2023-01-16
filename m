Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22CBC54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 19:08:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232527AbjAPTID (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 14:08:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231628AbjAPTIC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 14:08:02 -0500
Received: from mx-out1.startmail.com (mx-out1.startmail.com [145.131.90.139])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9790B274BF
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 11:08:00 -0800 (PST)
From:   Toon Claes <toon@iotcl.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=startmail.com;
        s=2020-07; t=1673896079;
        bh=Hj4p9U5l5oIKSWgg4hxOSJZ89nU1oI7OE0NSvQGn80o=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         Mime-Version:Content-Transfer-Encoding:From:Subject:To:Date:Sender:
         Content-Type:Content-Transfer-Encoding:Content-Disposition:
         Mime-Version:Reply-To:In-Reply-To:References:Message-Id:Autocrypt;
        b=ZUZDsKOllPXmm6Hv8dyn7WRnlNc4lVGMVA9rslmacgB+Xtb+XgldHibmJUSzLaziq
         UbPfOXfFI/6aVo1k/X4rNWn/pPR7FfIfS6scl31xe+ZI2Y/PXzaUzWKV4L12LZvZX+
         JNwCCeBZttcK3rtpPi4Pv2LHELX/si0SNaWFcZU8HbTLCfViol7tqK80mQ4jjSEnlX
         0YZaVfvSmAvdicc1rGGoGSnOnvYYHfpnouDbtyMygPFzy9Hm3kTQlEoDCIN9JP3KCN
         FM1Dz2jSQXYQmEwoDQIYWJF0HuyW5R0LGG9iiNHjbC3Y5LkmFfX99rUMWXCleMiUOA
         14+bmV+nooMeQ==
To:     git@vger.kernel.org
Cc:     Toon Claes <toon@iotcl.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 0/1] cat-file: quote-format name in error when using -z
Date:   Mon, 16 Jan 2023 20:07:48 +0100
Message-Id: <20230116190749.4141516-1-toon@iotcl.com>
In-Reply-To: <20230105062447.2943709-1-toon@iotcl.com>
References: <20230105062447.2943709-1-toon@iotcl.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi there,

This third revision of this patch fixes broken test case that was added in
t1006.

Toon Claes (1):
  cat-file: quote-format name in error when using -z

 builtin/cat-file.c  | 19 +++++++++++++++++++
 t/t1006-cat-file.sh |  8 ++++++++
 2 files changed, 27 insertions(+)

Range-diff against v2:
1:  4f39eb0719 ! 1:  a56932572c cat-file: quote-format name in error when using -z
    @@ t/t1006-cat-file.sh: test_expect_success FUNNYNAMES '--batch-check, -z with newl
      '

     +test_expect_success '--batch-check, -z with newline in non-existent named object' '
    -+	printf "HEAD:newline${LF}embedded" >in &&
    ++	printf "HEAD:newline${LF}missing" >in &&
     +	git cat-file --batch-check -z <in >actual &&
     +
    -+	printf "\"HEAD:newline\\\\nembedded\" missing\n" >expect &&
    ++	printf "\"HEAD:newline\\\\nmissing\" missing\n" >expect &&
     +	test_cmp expect actual
     +'
     +
--
2.39.0.rc0.57.g2e71cbbddd.dirty
