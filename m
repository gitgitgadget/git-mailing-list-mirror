Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A92E8FDC3
	for <git@archiver.kernel.org>; Wed,  4 Oct 2023 01:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239603AbjJDBdi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 21:33:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230274AbjJDBdh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 21:33:37 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A571AB
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 18:33:35 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:56944)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qnqlZ-00EQoU-R5; Tue, 03 Oct 2023 19:33:34 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:60926 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qnqlZ-008lnf-0c; Tue, 03 Oct 2023 19:33:33 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
References: <20231003202504.GA7697@coredump.intra.peff.net>
Date:   Tue, 03 Oct 2023 20:33:26 -0500
In-Reply-To: <20231003202504.GA7697@coredump.intra.peff.net> (Jeff King's
        message of "Tue, 3 Oct 2023 16:25:04 -0400")
Message-ID: <878r8j2mu1.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qnqlZ-008lnf-0c;;;mid=<878r8j2mu1.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX193O3uM1JeVlHCbM3I0iW4eP3Jw7+/PIXY=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Is SANITIZE=leak make test unreliable for anyone else?
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Jeff,

Please accept my apologies for slightly hijacking your posting, but I
see you have been fixing some leaks, and so presumably you are familiar
with building git with "SANITIZE=leak".

I have fixed some leaks in my SHA1+SHA256 patchset recently and while
tracking them down I found that simply enabling SANITIZE=leak caused
"make test" on git v2.42 without patches to give different failures
from test run to test run.

Well actually I wound up with the following command line:
GIT_TEST_PASSING_SANITIZE_LEAK=true GIT_TEST_SANITIZE_LEAK_LOG=true SANITIZE=leak DEVELOPER=1 make test

I had removed "-j32" to make things more reproducible.

I observed this unreliability with SANITIZE=leak when building git on
an fully updated version of debian 12.

My big question is:

    Do other people see random test failures when SANITIZE=leak is enabled?

Is it just me?

Thanks,
Eric
