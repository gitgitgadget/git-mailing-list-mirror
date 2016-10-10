Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2A7D0207EC
	for <e@80x24.org>; Mon, 10 Oct 2016 03:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbcJJDKZ (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Oct 2016 23:10:25 -0400
Received: from mail-out2.apple.com ([17.151.62.25]:42815 "EHLO
        mail-in2.apple.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751629AbcJJDKY (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Oct 2016 23:10:24 -0400
X-Greylist: delayed 950 seconds by postgrey-1.27 at vger.kernel.org; Sun, 09 Oct 2016 23:09:25 EDT
DKIM-Signature: v=1; a=rsa-sha256; d=apple.com; s=mailout2048s; c=relaxed/simple;
        q=dns/txt; i=@apple.com; t=1476068015;
        h=From:Sender:Reply-To:Subject:Date:Message-Id:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=E6NEmxXiKi17J5Zcb4j00SNzYX9ahbISZ2kRFzDt99Q=;
        b=siTclZUeSPfgNqrnLsUlYnt4ICnmoj3xra3YlJ/1vl8STTDrpq/QLprPK37Gu61k
        v+/LJo/msoNbGCZUU536Np14SNG6YDUA8JxovswGPFibTnyVF5Twaf2xaRcM280e
        sICwa8+DZApbG0jzWYGOTlV4UpCd5aBTt7fUIQTbHvabTQlcwP4OJYWshykU9bXC
        ml3qbr6SNk6MjzL5QsGq2URZVI9AiEEIYOox8Vuj8QzOXR0LaWSWBC6+//zPjtQP
        d6koEC/b8U/iDwRcTnOgs91/YaULwN0V5Wa89n2FLsXrERUxLCsGEWN+uCjDcuTL
        JX5kHeVsSZy0e2u4ugsDDQ==;
Received: from relay3.apple.com (relay3.apple.com [17.128.113.83])
        by mail-in2.apple.com (Apple Secure Mail Relay) with SMTP id EA.5B.06856.FA20BF75; Sun,  9 Oct 2016 19:53:35 -0700 (PDT)
X-AuditID: 11973e11-8d1ff70000001ac8-90-57fb02af7d38
Received: from tonberry.org (Unknown_Domain [17.153.27.88])
        by relay3.apple.com (Apple SCV relay) with SMTP id DC.1B.13773.EA20BF75; Sun,  9 Oct 2016 19:53:35 -0700 (PDT)
From:   Jeremy Huddleston Sequoia <jeremyhu@apple.com>
To:     git@vger.kernel.org
Cc:     Jeremy Huddleston Sequoia <jeremyhu@apple.com>,
        Josh Triplett <josh@joshtriplett.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] t4014-format-patch: Adjust git_version regex to better handle distro changes to DEF_VER
Date:   Sun,  9 Oct 2016 19:53:23 -0700
Message-Id: <20161010025323.9415-1-jeremyhu@apple.com>
X-Mailer: git-send-email 2.10.1 (Apple Git-99)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrJJMWRmVeSWpSXmKPExsUi2FAYrLue6Xe4wYP9IhZdV7qZLBp6rzBb
        /F+Q78Dsceu1rcfFS8oenzfJBTBHcdmkpOZklqUW6dslcGVsuSlZMIet4tu98ywNjCtYuxg5
        OSQETCQWfe9h7mLk4hAS2MsosX//AmaYxI+dk5kgEmsYJVbd+McEkmADStz6c5oFxBYREJd4
        e3wmO0gRs0Ajo0TblOdsIAlhgQyJX8v+MYLYLAKqEp/nrmQHsXkFzCTu3psF1MwBtEFPYu+L
        JJBeCYG9rBJn171hnMDIs4CRYRWjUG5iZo5uZp6RXmJBQU6qXnJ+7iZGkN+n2wnuYDy+yuoQ
        owAHoxIPb8KMX+FCrIllxZW5hxilOViUxHkv7QAKCaQnlqRmp6YWpBbFF5XmpBYfYmTi4JRq
        YDw7r9St5M5SsfbDx3v3bvFZLSR6MZX9p5JKarzp9Y9Ld340iam1OdJvonD4S5rFx/MNjKkN
        B+r9lssXW6+8cW76fAXPAqutL4Q22PeynFqXlXlST1ZGfPPzB1G7/1olvdmzpsu0Xbr2nVZ8
        lMmOfebRcvb8sow+RhHfw/df+Vu3sCCgbO7m50osxRmJhlrMRcWJAEGk4MzcAQAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrIJMWRmVeSWpSXmKPExsUiOFM6Qnc90+9wg7UbmCy6rnQzWTT0XmG2
        ONNia/F/Qb4Di8fWkz/YPG69tvW4eEnZ4/MmuQCWKC6blNSczLLUIn27BK6MLTclC+awVXy7
        d56lgXEFaxcjJ4eEgInEj52TmSBsMYkL99azdTFycQgJrGGUWHXjH1iCDajo1p/TLCC2iIC4
        xNvjM9lBipgFGhkl2qY8ZwNJCAtkSPxa9o8RxGYRUJX4PHclO4jNK2AmcffeLKBmDqANehJ7
        XyRNYORawMiwilGgKDUnsdJYL7GgICdVLzk/dxMjyKMNhcE7GP8sszrEKMDBqMTD61DzK1yI
        NbGsuDL3EKMEB7OSCO/t/0Ah3pTEyqrUovz4otKc1OJDjNIcLErivB4aP8KFBNITS1KzU1ML
        UotgskwcnFINjIpsAuVtf12ZJbZHyc2zr2a7032pcGWWN8e/PSY+3Yd4uNz5ExT2lU7N8p74
        cG133P64KbHPDDWjCzevcw48MT/UclajmmOz/BRJgyqvKxeztX2XPf1f21g46wkX59o1n1ii
        ziefbtFM6RPs8VabOcd+S+rM/bMcjPpbVc/PSsp67X164WJlJZbijERDLeai4kQAOkZAmuQB
        AAA=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Regressed-in: 480871e09ed2e5275b4ba16b278681e5a8c122ae
Signed-off-by: Jeremy Huddleston Sequoia <jeremyhu@apple.com>
CC: Josh Triplett <josh@joshtriplett.org>
CC: Junio C Hamano <gitster@pobox.com>
---
 t/t4014-format-patch.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index 8d90a6e..33f6940 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -754,7 +754,7 @@ test_expect_success 'format-patch --ignore-if-in-upstream HEAD' '
 	git format-patch --ignore-if-in-upstream HEAD
 '
 
-git_version="$(git --version | sed "s/.* //")"
+git_version="$(git --version | sed "s/git version //")"
 
 signature() {
 	printf "%s\n%s\n\n" "-- " "${1:-$git_version}"
-- 
2.10.1 (Apple Git-99)

