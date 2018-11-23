Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D7A9A1F97E
	for <e@80x24.org>; Fri, 23 Nov 2018 18:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725844AbeKXFEF (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Nov 2018 00:04:05 -0500
Received: from mail-wm1-f50.google.com ([209.85.128.50]:37936 "EHLO
        mail-wm1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725139AbeKXFEE (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Nov 2018 00:04:04 -0500
Received: by mail-wm1-f50.google.com with SMTP id k198so12814344wmd.3
        for <git@vger.kernel.org>; Fri, 23 Nov 2018 10:18:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=ajTyjpyVCqZZD5pMdQzzo+l+DxqHSao2OeV1bd1YV78=;
        b=VSM/gxfmLypvIi7vGLJxFwZLR9kL8ZWX3pq7PjV4wmZjIhi8Hmr3g0TDU93LhDhxSQ
         0J/NWPP6dnLE5VDvnyKXlPcsIDYoPoPHn7W14gQJ82z4smHRWryZnCiD+hPuV5uDfDyR
         613EUaYnw+roGiZKQfqVv6E0VN6xW0F59KjBEKccdUvRVnCuxNQ8xihlmpPFg7wovvqz
         p4EAnE2Hm+ibxw4FfayPFmgnWXxtB7pbcBfEeXQqZCLfvt2tLliNohCB0Snqv89dk6lM
         MMbPgqy3ILG1DUP/GSmn6asKn9yb7ABAyTl0sODUOkT4sKcPrew8zTHKx/Aa1mstuHFI
         WbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=ajTyjpyVCqZZD5pMdQzzo+l+DxqHSao2OeV1bd1YV78=;
        b=KaWQvJVNAa+mniIVz39nxHLrZiw7cDYQZjW+tvpIu5MapzuWRrstoNIVe75P0f02iP
         8nOEge72/A2CJyw+00Q13d5PSjQAbovXDMhnVXnx67C4a9/xN64td0YWiAqAabQ7Z+E2
         sq+zvhULy1FOEBcutS2Y553d8t1nFPJx6pNiKrA2mNCKX8psmgwZ2fz4sGOZ3LmGt1Mb
         K7UoicwQ/udQL9mRVk0cJ82r1Pf9h4WqZtUpaoJTXjUZU/rfqZYvN7Qf/njpxyC9SQH0
         6pdV40gTOtpAAO+rUOE2vn/5c8UV3j89FFSJj83UCZTtOuB5O14im80XmHHl3xj5TjYo
         7/og==
X-Gm-Message-State: AA+aEWYYfio+cxXmzlyHImaPuIKWVSlC5aOnonuTpLigoivU0hWdp49m
        zG2pqFkEHIsf8eh2Clw=
X-Google-Smtp-Source: AJdET5cua6bNdOnY0TDrYPCdG2jSqwNjRyVWvu2PYVm9eMIUf9HNAbpKutDEfBeBliQMG62PG14Y+w==
X-Received: by 2002:a1c:7d54:: with SMTP id y81mr14713186wmc.106.1542997122099;
        Fri, 23 Nov 2018 10:18:42 -0800 (PST)
Received: from [192.168.25.100] (ip-178-203-17-255.hsi10.unitymediagroup.de. [178.203.17.255])
        by smtp.googlemail.com with ESMTPSA id q3sm25695624wrn.84.2018.11.23.10.18.40
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Nov 2018 10:18:41 -0800 (PST)
To:     git@vger.kernel.org
From:   =?UTF-8?Q?Frank_Sch=c3=a4fer?= <fschaefer.oss@googlemail.com>
Subject: BUG: CR marker ^M doesn't show up in '-' lines of diffs when the
 ending of the removed line is CR+LF
Message-ID: <1f068f3a-d636-9b9c-f501-51d33412b964@googlemail.com>
Date:   Fri, 23 Nov 2018 19:19:41 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: de-DE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The CR marker ^M doesn't show up in '-' lines of diffs when the ending
of the removed line is CR+LF.
It shows up as expected in '-' lines when the ending of the removed line
is CR only.
It also always shows up as expected in '+' lines.

These are the diffs of the 6 possible line ending changes:

LF to CR+LF:
@@ -1,2 +1,2 @@
-aaa
+aaa^M
 bbb
 
CR+LF to LF:
@@ -1,2 +1,2 @@
-aaa            => BUG: should be -aaa^M
+aaa
 bbb

CR to CR+LF:
@@ -1 +1,2 @@
-aaa^Mbbb
+aaa^M
+bbb

CR+LF to CR:
@@ -1,2 +1 @@
-aaa            => BUG: should be -aaa^M
-bbb
+aaa^Mbbb

LF to CR:
@@ -1,2 +1 @@
-aaa
-bbb
+aaa^Mbbb

CR to LF:
@@ -1 +1,2 @@
-aaa^Mbbb
+aaa
+bbb

Tested with version 2.19.1.

Regards,
Frank Schäfer

