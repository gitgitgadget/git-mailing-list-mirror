Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8832C4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 01:31:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229852AbiLQBbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Dec 2022 20:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLQBbR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Dec 2022 20:31:17 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0EA67D9A
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 17:31:16 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2BH1VF1B012286
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
        for <git@vger.kernel.org>; Fri, 16 Dec 2022 20:31:15 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     <git@vger.kernel.org>
Subject: [Possible Bug] config --system fails when ./etc does not exist
Date:   Fri, 16 Dec 2022 20:31:09 -0500
Organization: Nexbridge Inc.
Message-ID: <007a01d911b7$4125bd60$c3713820$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        boundary="----=_NextPart_000_0074_01D9118B.96936A30";
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE4CFRwLZxOlqSDP71bamdH/PZGgw==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On an initial install, the ./etc directory does not exist where git is
installed. This causes git config --system to fail because the ./etc/config
file cannot be created because of ENOENT. Is this deliberately intended for
a specific security concern or would a patch to automatically create ./etc
if it the directory does not exist be desired? It would need a
stat("./etc".) call prior to attempting to create the ./etc/config file,
with appropriate knobs, of course. If the build assumes the use of /etc
instead of ./etc inside /usr/local, we probably do not want to do this.

Curiously,
Randall

