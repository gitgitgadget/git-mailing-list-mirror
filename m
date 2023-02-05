Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B688C636CD
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 22:17:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbjBEWRf (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Feb 2023 17:17:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBEWRd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Feb 2023 17:17:33 -0500
Received: from ring.crustytoothpaste.net (ring.crustytoothpaste.net [IPv6:2600:3c04::f03c:92ff:fe9e:c6d8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000531A97F
        for <git@vger.kernel.org>; Sun,  5 Feb 2023 14:17:32 -0800 (PST)
Received: from tapette.crustytoothpaste.net (unknown [IPv6:2001:470:b056:101:e59a:3ed0:5f5c:31f3])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (3072 bits) server-digest SHA256)
        (No client certificate requested)
        by ring.crustytoothpaste.net (Postfix) with ESMTPSA id 9429C5A210;
        Sun,  5 Feb 2023 22:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1675635451;
        bh=qrpEIhBfjMsAPC2uVYNU8p4ulGyrqXx3uJrpJWgOp7U=;
        h=From:To:Cc:Subject:Date:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=FezuS3quj0xNXrYyfAMck8/CXVz0CVQLIefUafPPLQCPRIHtgPwsXSlXeEYe0ydVA
         vaC1APljMNzANUmg+HvJ8MO/6PlbrnUUpVMPTgQWeEIB9FBUd4845bISjLNnSQWs4N
         ptNVAStobarYBEStPw55lgbXPv5+F6hWafypu4pUCVFreduPDf1IjgZvXkhYTDnF/3
         KmHcWYJIbXN6UOfD1ZJxIGBV5BGXacZWgaHlVRS9a1yPMhRXTYKT/BHkc+AomY858N
         KhCoafJ8Y8dBPejg7dY47VLg0yodiDzKMT9uKnWaZJHdN9oEOxiss0i+AXeLGkgrI2
         VIG2x9ao+wxFXcQiWxFOUFHjGvGuhhZYbPrwI1nMfn1iMZlCz6ky3Jr20nQQSVufct
         q4GsFuQimtkzLlV0l6kk8JqBzsARc4zmjNPAo8ITn0KWNG9zsjLqnAP/80ClT+t4xK
         wnuKo6vRm62yNK81bqLbwJ5DV+E6E69KOSKN0fTNv6iWBEilQ5O
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     <git@vger.kernel.org>
Cc:     Eli Schwartz <eschwartz93@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 0/1] Canonical tar format for Git
Date:   Sun,  5 Feb 2023 22:17:27 +0000
Message-Id: <20230205221728.4179674-1-sandals@crustytoothpaste.net>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

With recent discussions about guaranteeing some stability for our
archives, here's a document which specifies a canonical tar format we
can use, based on the pax format.

It contains a sufficient amount of explanation about how the format
works to (hopefully) be easily understandable, and it explains the
benefits of the extremely rigid format it defines.

If we decide that we'd like to implement extensions to it in the future,
it can be easily extended.  My original approach allowed specifying
version extensions to specify that things like permissions or timestamps
were persisted, but I simplified for ease of use, since we don't
technically need those changes.

Feedback about this approach is welcome, and after some discussion, I
plan to send a future version with an actual implementation and tests.

brian m. carlson (1):
  Document a fixed tar format for interoperability

 Documentation/technical/tarball.txt | 234 ++++++++++++++++++++++++++++
 1 file changed, 234 insertions(+)
 create mode 100644 Documentation/technical/tarball.txt

