Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B5C5C61DA4
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 02:39:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBOCjz (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Feb 2023 21:39:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBOCjw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2023 21:39:52 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30292234D0
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:39:51 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id c2so20502684qtw.5
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 18:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+Q7tdXt6dDDWV7wL4N2Xt76V3tOuDw396GDpWKvHpFs=;
        b=LpwuuRswov4IG3WE40OICHMqBExm6i+XPUKsFz8QBWJXfdQuElwy6tRvQBLJ2veRLa
         bPsTKDXue1Bf71zco5Se0Dr59VWeZUDsqoQmSIy0OyRU2YE2HeG4Va2+DYnZ0QZzAMYh
         3V2IdcIhve5Q9dWcs4dOPG5tDjh/dWXFWwrjhhEEr+SvIZvav1aeooC+LmQASZyTCSen
         fSUrfeafgLAwCK4jPKzFBWI/kU6nhAaW1ZeWmlGZSvqxcoXGrPkWjvpPixmfdhO6zRLl
         tsZ7yDWqa/F8nL/86k5iZsaJegmNS1RfUSEHIfqwiB57v2v3/NlSNidLKX5oDkLC8F48
         lCIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+Q7tdXt6dDDWV7wL4N2Xt76V3tOuDw396GDpWKvHpFs=;
        b=2FE1p9tA/urrRdaUoKlghqj3ugmbDhXGVdS7ofMkusB61P7ZfPeJ9OZoZ5zfVPeee9
         NirnA+yagaz4PAsbooRv2wLvzXd7Y/0cqOALBAXxR9ZWTT0ksJ3xe8XSNycW1SpWz2n/
         b8ExSH5ng03KEOsL62qJFNCqMOWcda2NCDCUCZ1GFFMVlEBiqXkee3HPNISA+nGCchFI
         Qu6jTPRNPgA2uaj9E+YZtPC+6O+o3qB/FxTAVtYGn1osQ58cFfUbwFZCcDYrAhxJom7g
         0gyPaUoK6v1yYRzA8PR/xVqOQV8/c8dEGIFDnRR36+/RzCpYVvW+wNG6PUpXam4aZCy/
         1AVA==
X-Gm-Message-State: AO0yUKVJgDVz9/lMMOOoUgANCU5lsnfW0CNVBGd3sAMuey0wEsre3aGn
        +ivSOL24fIlAfn6NlB6yIa9uwjKZycw+oQ==
X-Google-Smtp-Source: AK7set8H28sKrWzwH79fL/LPVNxSVVAFIZDbCQwSRwwQIRsPtKYogYZs9jmtjWyUfxtZgoXHw+YGzQ==
X-Received: by 2002:a05:622a:5d3:b0:3b6:3a16:a19 with SMTP id d19-20020a05622a05d300b003b63a160a19mr647355qtb.54.1676428789895;
        Tue, 14 Feb 2023 18:39:49 -0800 (PST)
Received: from cheska.uwo-x-22.wireless.uwo.pri (eclipse-22.wireless.uwo.ca. [129.100.255.37])
        by smtp.googlemail.com with ESMTPSA id o73-20020a37414c000000b0072b5242bd0bsm12978425qka.77.2023.02.14.18.39.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 18:39:35 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>
Subject: [PATCH v6 0/3] t4113: modernize style
Date:   Tue, 14 Feb 2023 21:38:57 -0500
Message-Id: <20230215023900.11854-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230209154417.10763-1-cheskaqiqi@gmail.com>
References: <20230209154417.10763-1-cheskaqiqi@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

different with 5 :

1.change the commit message to be more succinct.

2.
use  

test_write_lines a b c >file && 

instead of :
 
{
    echo a &&
    echo b &&
    echo c
} >file &&




Shuqi Liang (3):
  t4113: modernize test script
  t4113: indent with tab
  t4113: put executable lines to test_expect_success

 t/t4113-apply-ending.sh | 75 +++++++++++++++++++----------------------
 1 file changed, 34 insertions(+), 41 deletions(-)

Range-diff against v5:
1:  4d55e522a6 ! 1:  cb29da5d42 t4113: modernize test script
    @@ Commit message
         where the test_expect_success command and test title are written on
         separate lines. Change the old style to modern style.
     
    -    for example :
    -    -test_expect_success setup \
    -    -    'git update-index --add file'
    -    -
    -    +test_expect_success setup '
    -    +    git update-index --add file
    -    +'
    -
         Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
     
      ## t/t4113-apply-ending.sh ##
2:  cb997bc422 = 2:  09efa23ba4 t4113: indent with tab
3:  726d2fcb47 ! 3:  0169cbd402 t4113: put executable lines to test_expect_success
    @@ Commit message
         t4113: put executable lines to test_expect_success
     
         As t/README says, put all code inside test_expect_success and
    -    other assertions. This script is written in old style,where there are
    -    some executable lines outside test_expect_success. Put the executable
    -    lines inside the test_expect_success.
    -
    -    As t/README says,use "<<-" instead of "<<"
    -    to strip leading TABs used for indentation. Change the "<<" to "<<-"
    -
    -    for example:
    -    -cat >test-patch <<\EOF
    -    -diff a/file b/file
    -
    -     test_expect_success 'apply at the beginning' '
    -    +       cat >test-patch <<-\EOF
    -    +       diff a/file b/file
    -    +       --- a/file
    -
    -    As t/README says,chain test assertions.Chain this test assertions
    -    with &&.
    -
    -    For example:
    -
    -    -cat >test-patch <<\EOF
    -    -diff --git a/file b/file
    -
    -    + cat >test-patch <<-\EOF &&
    -    + diff --git a/file b/file
    -
    -    This script is written in old style,where there are something like
    -
    -            echo x >file &&
    -            echo y >>file &&
    -            echo z >>file
    -
    -      Change it to this stlye :
    -            {
    -            echo x &&
    -            echo y &&
    -            echo z
    -            } >file
    -
    -    In order to escape for executable lines inside the test_expect_success.
    -    Change ' in executable lines to '\'' in order to escape.
    +    other assertions. This old test scripts have setup code
    +    outside of tests. This is problematic since any failures of the
    +    setup code will go unnoticed. Therefore, move setup code into the tests
    +    themselves so that failures are properly flagged. t/README also says,
    +    use "<<-" instead of "<<" to strip leading TABs used for indentation.
    +    Fix it. We should chain test assertions(t/README). Therefore,Chain
    +    this test assertions with &&. What's more,take advantage of modern
    +    style. Use test_write_lines instead.
     
         Signed-off-by: Shuqi Liang <cheskaqiqi@gmail.com>
     
    @@ -1,2 +1,3 @@
     +	+c
     +	EOF
     +
    -+	{
    -+	echo '\''a'\'' &&
    -+	echo '\''b'\'' &&
    -+	echo '\''c'\''
    -+	} >file &&
    ++	test_write_lines a b c >file &&
      	git update-index --add file
      '
     -# test
    @@ -1,2 +1,3 @@
     +	 c
     +	EOF
     +
    -+	echo >file '\''a
    -+	b
    -+	c'\'' &&
    ++	test_write_lines a b c >file &&
     +	git update-index file &&
      	test_must_fail git apply --index test-patch
      '
-- 
2.39.0

