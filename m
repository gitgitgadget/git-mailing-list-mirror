Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0EAFC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Feb 2023 15:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbjBIPp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Feb 2023 10:45:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230508AbjBIPpY (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2023 10:45:24 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CF865673
        for <git@vger.kernel.org>; Thu,  9 Feb 2023 07:44:48 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id w13so994527ilv.3
        for <git@vger.kernel.org>; Thu, 09 Feb 2023 07:44:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3G57TwIiVhRQmIhY623f6Uw8EcvAVl/DuD991JTlhgg=;
        b=JDBTowO4UDslwvEDVW7o/Sd2xkzGSn7SC0gf4f3Z8SfiFKv5JeCta6sVjfX0NMP084
         T09j1lwp3RG3yITyB4ut5FBU87YheJ6Fprtjn5BAtHXLszgCqJzB8fpcoAfN4KknhOwB
         qk5OtvP3xoRlTb3NzaSEE5nYJYTZKGPfe+C2pctpA0XfZZGA2YX+9xeA+2XzInj2VvrA
         ZHnU/gOkCBcZXFUNYHdPqxJc7VepX4OYQnSoDC3/KKWabI/S3R/DIySX2iJwrROqt2zp
         m/f5IEHWNyHEWNmhCxPwjqmeaD9mp099qeISAha6Y6h8gY55O6utGLYmk08Jo22mendW
         Xyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3G57TwIiVhRQmIhY623f6Uw8EcvAVl/DuD991JTlhgg=;
        b=TZgaI4w0t84pfpUpSrL7zmX3uMbAmlmMQyUEZK9X5KkVTVga9BHyR7pu0sgcSBJD6p
         JN5J9VnJUwWpezbtqemTzfQrAB57C3crNC0CCxRF0QPcSIh3K6s7Zs55+IVfycIEWdW8
         aSfmAIu9bHAM2ra4NQzOc3Ev5F2q3q3pr8WMPgTkecq45NGAkn6E/+aEecUJ6mNq/j+B
         SKbh+WvsMTWogNK3KVe3AkkEolxJ5UTIKIIdPWDk0FW2Isf0/wTpCkS7xV5TglilGI/F
         8a1cF2zQGFshL7Fk8XS4/g4UiNKpab8VKYuu6OEGyVB7xIECIlU2WU6zOaptQdgh7A9x
         BCIQ==
X-Gm-Message-State: AO0yUKUZyEldsN2z7WHz7lfK5fIAGoDh7Y46cPksKPg9e0fnXX+Vlppo
        lwMb8nFeBW8IxKbmI3YT6Qe3uGQZPa9Ll39m
X-Google-Smtp-Source: AK7set8nP/AbLhZ48wan/+WQ3qVpx128iX7iwy8cVHH6jjpGbVV/Bc13RHw01aW0Onw1PQDtm9pv2Q==
X-Received: by 2002:a05:6e02:1d8b:b0:30f:641b:d12b with SMTP id h11-20020a056e021d8b00b0030f641bd12bmr13488815ila.21.1675957478422;
        Thu, 09 Feb 2023 07:44:38 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id a1-20020a92d581000000b0030c0dce44b1sm563570iln.15.2023.02.09.07.44.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Feb 2023 07:44:37 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, gitster@pobox.com,
        rybak.a.v@gmail.com, avarab@gmail.com, sunshine@sunshineco.com
Subject: [PATCH v5 0/3] t4113: modernize style
Date:   Thu,  9 Feb 2023 10:44:14 -0500
Message-Id: <20230209154417.10763-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230206211823.8651-1-cheskaqiqi@gmail.com>
References: <20230206211823.8651-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

different with V4: 
1.chain test assertions

For example:

-cat >test-patch <<\EOF
-diff --git a/file b/file

+ cat >test-patch <<-\EOF &&
+ diff --git a/file b/file


2.change the modern style with echo 
   echo x >file &&
        echo y >>file &&
        echo z >>file

  Change it to this stlye :
        {
        echo x &&
        echo y &&
        echo z
        } >file

3.In order to escape for executable lines inside the test_expect_success.
Change ' in executable lines to '\'' in order to escape.



(V4 didn't test before sumbit so I show the difference between orgin t4113 )

Shuqi Liang (3):
  t4113: modernize test script
  t4113: indent with tab
  t4113: put executable lines to test_expect_success

 t/t4113-apply-ending.sh | 81 ++++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 41 deletions(-)


base-commit: c48035d29b4e524aed3a32f0403676f0d9128863
-- 
2.39.0

