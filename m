Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2AD9F1F454
	for <e@80x24.org>; Sat, 10 Nov 2018 18:23:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726837AbeKKEJX (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 23:09:23 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39212 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726244AbeKKEJX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 23:09:23 -0500
Received: by mail-lf1-f68.google.com with SMTP id n18so3537961lfh.6
        for <git@vger.kernel.org>; Sat, 10 Nov 2018 10:23:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2hY+aKWhoU+lSTvcenMLygWjX8OBwCqTtfG/Db3vhho=;
        b=k4y7et0XcKQmdCOVlib7t5h9/D258+E/UhRJYm/TDqKXNDYkXpQoSkUGcCBC/ddO7d
         fUxckZbxBJA3w856LfV5GaCZtBjh2ujHHN1KOZRooI8rT8yCuOytaACWNQ1xOH6y22WI
         9RqjN7VTOR1frxP4JguFQZ9sf4m9o2QjGv4/2MXsJSvyfckNu9hfdMgXQq1+X+2O95Js
         w9cGX2MkfU97Kf8Ta6saowBsEs0J4Al373XUrZvSwsxT+fE2E+3fvyzd51nT9dM6wJCx
         fTvBCVbom+UmdJtsY6QtywtgSzrMbGOY8bONrgIeoHMIlC9vrw5XvlswpFbF3cNbFE5u
         IIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2hY+aKWhoU+lSTvcenMLygWjX8OBwCqTtfG/Db3vhho=;
        b=uRWJwVt5H3mwgpVvQZNBkzcQiouY0BiKsFM2b6IkK4ZO20kSqbEUbVdAs0R52H9Ou7
         qHJVYQg4qMI7568XefSEDIcua1afL4K+9hd2h/sZTkbDisOvp2H7JsM7oGKbPGJb9FSu
         ZUYHFWetmbbwoeDQUkq2JfPAvt8LphcPw/to8EP53sD5EVdEvs2kgmHmZFxyfAL58A6M
         9OVmd18M+sP8xsGJTvCVEsJYNXY5wCPl/3Wbc1u25HkEUWvBwx6MqNR4ISh4vsrLJ7s1
         XgLSrNuOrTRN6UbY2rjBsVDz3L7DD8tdgmQM5f30T2gyHp8Hc7xPj0BKhoTkX6QQgp7x
         Z+5g==
X-Gm-Message-State: AGRZ1gKfkc6+GuQQmhKIclm9Sdcl9RxKqqvEETAmK8nhjNu432b2sQsI
        0UTutCzxP9dZrnIJZOTcNEKbJQ2M
X-Google-Smtp-Source: AJdET5d6I2+0XI05jOFM5E1kmZaT8sJ0YgQ5N2xUaWwh+tr88GWsRCXvqONRfAZBRZAOS1xuM/M2TA==
X-Received: by 2002:a19:c4cc:: with SMTP id u195mr7670708lff.141.1541874207502;
        Sat, 10 Nov 2018 10:23:27 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id m1sm1986207lfb.56.2018.11.10.10.23.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Nov 2018 10:23:26 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH] Fix broken command-list.h generation with core.autocrlf
Date:   Sat, 10 Nov 2018 19:23:23 +0100
Message-Id: <20181110182323.26053-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The script generate-cmdlist.sh needs input text files in UNIX line
ending to work correctly. It's been fine even with core.autocrlf set
because Documentation/git-*.txt is forced LF conversion.

But this leaves out gitk.txt and also Documentation/*config.txt that
recently becomes new input for this script. Update the attribute file
to force LF on all *.txt files to be on the safe side.

For more details, please see 00ddc9d13c (Fix build with
core.autocrlf=true - 2017-05-09)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 Some tests must have broken out of the test repo and set
 core.autocrlf on my $GIT_DIR/config. Fun was not had.

 .gitattributes | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitattributes b/.gitattributes
index 49b3051641..acf853e029 100644
--- a/.gitattributes
+++ b/.gitattributes
@@ -5,7 +5,7 @@
 *.pl eof=lf diff=perl
 *.pm eol=lf diff=perl
 *.py eol=lf diff=python
-/Documentation/git-*.txt eol=lf
+/Documentation/**/*.txt eol=lf
 /command-list.txt eol=lf
 /GIT-VERSION-GEN eol=lf
 /mergetools/* eol=lf
-- 
2.19.1.1231.g84aef82467

