Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D2CD1F803
	for <e@80x24.org>; Mon,  7 Jan 2019 20:51:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727025AbfAGUvq (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Jan 2019 15:51:46 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43514 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726767AbfAGUvq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Jan 2019 15:51:46 -0500
Received: by mail-lj1-f194.google.com with SMTP id q2-v6so1517048lji.10
        for <git@vger.kernel.org>; Mon, 07 Jan 2019 12:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:user-agent:mime-version;
        bh=PglDOl/bu7hYWuXhRJSpE2alIp0QvG0P2G2i7R5bcPo=;
        b=vCKMkqthWTOwtK7HQAQFGOu49ONh6yUFHWbpbxPrdPxFmivZMrcASgbxHUZS7GmU46
         5aah8F11QKl83a0EtESsjgGx99H/2I7VJJmpveJZcLp98d8MRfCKXBFXgXd0On8lVFbW
         mComt0ar0l3MKIALKswxFU4cH23vV1YhtAyC43Y6ybrjHQJ97iP86goXVgOqEsxK4b8f
         VnSg9gacvM+9QiSFQ4F66JlMuS3dJP6PpUqQ4OoSY4HibcQJFEhzt+r7lVEwcwZr22/b
         YZzP6zy/G7xwzu+Xd9vPk5+j8fhY0cdq6wbzlcGiavxatxLl23aE68nKQZqPazDWM3Wo
         YB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:user-agent
         :mime-version;
        bh=PglDOl/bu7hYWuXhRJSpE2alIp0QvG0P2G2i7R5bcPo=;
        b=g8CapLXmthuFXwd5kD1jgt4zLODbr0KBbF0ZO/KWprmB2k/6Hbm4PiLnHHJxkSJz70
         J5e0EcBMuCLgfWNvUfUNMgVbrQ1rSpj+72rSPrbIAzGPyJtS64nR/anBTEmEetF7XY7m
         kDAtq2tC85pBhFJltAufiNAPeeClnpKqvgwi5u0vROvtDAdFhxON7R+/N8Ukm95CjU4U
         qPYi0Z4zxsHcngy+zr00KznMNRLu7xOZTO9VzMdxZzml0rhXKvpz4RYavKip0X3i0Blz
         1rU2+8XZtRA2j33rxCGimzlKqhiXZvh84PErQmJmBpcJGgqnKY7ZovpH938rQIeXyg10
         Rfew==
X-Gm-Message-State: AJcUukeVdB6YZLuZmLLsN3xFQNmJ/vOj0Rk2WGHBWK/oLrgeyCqQMNly
        RtF+TJGKxQYwnuw1i92Eqpfxe0Lc/ig=
X-Google-Smtp-Source: ALg8bN5tJdXG9QWPnK8S64AltCME6wBnFXx+SRs52Mhgx3/T3u5lES41IFkZNaJWV49txJmgBmAYBA==
X-Received: by 2002:a2e:81a:: with SMTP id 26-v6mr38127127lji.14.1546894304095;
        Mon, 07 Jan 2019 12:51:44 -0800 (PST)
Received: from fractal (c-3e3f70d5.031-170-73746f28.bbcust.telenor.se. [213.112.63.62])
        by smtp.gmail.com with ESMTPSA id f16-v6sm14107040lji.88.2019.01.07.12.51.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Jan 2019 12:51:43 -0800 (PST)
Date:   Mon, 7 Jan 2019 21:51:38 +0100 (CET)
From:   Peter Osterlund <peterosterlund2@gmail.com>
X-X-Sender: petero@fractal.localdomain
To:     Git Users <git@vger.kernel.org>
cc:     gitster@pobox.com, Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: fix problem when p4 login is not necessary
Message-ID: <alpine.LFD.2.21.1901072148380.20807@fractal.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a perforce setup where login is not required, communication fails 
because p4_check_access does not understand the response from the p4 
client. Fixed by detecting and ignoring the "info" response.

Signed-off-by: Peter Osterlund <peterosterlund2@gmail.com>
---
  git-p4.py | 2 ++
  1 file changed, 2 insertions(+)

diff --git a/git-p4.py b/git-p4.py
index 1998c3e141..3e12774f96 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -332,6 +332,8 @@ def p4_check_access(min_expiration=1):
              die_bad_access("p4 error: {0}".format(data))
          else:
              die_bad_access("unknown error")
+    elif code == "info":
+        return
      else:
          die_bad_access("unknown error code {0}".format(code))


-- 
Peter Osterlund - peterosterlund2@gmail.com
http://hem.bredband.net/petero2b
