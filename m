Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BF7C433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 06:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbiCLGXE (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Mar 2022 01:23:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiCLGXD (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Mar 2022 01:23:03 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFDFAF65D6
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 22:21:57 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id w4so9368426ply.13
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 22:21:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xgMQ29idduJbgJK9hiZE/hgGPWQGzVWmbDe+EO96sB0=;
        b=lYoYJb7xv81EaGbYfBY9QvpDIs6aPV7VRVWnGkV94jgqkfzB68svpNF7E+aDzjjzq+
         UOuy/FeCVerYRcMmk2BsLLkwKQTKMMWiaViaGIQecyL+04mrga6DQ8QuqlSMq5xxGLrX
         lJo89jD2+jcYTYMCAnYktEOwxwHnH8dUhzYd693IXvw9jKPy8EoCEavM851Tohb2Qq5e
         PRMHk4xSA8MQ15/USJUYbA/Ei+XS3ybFyKzNe5Bnh3R1CRu4Nl7MeZ5LaVSRgotRMiaO
         cakQ7QEBd3SEaJCZiDgFRq+beKqUBTu180k3Wwn5Ax5AbYJNeVJdlLxqdDWGv0iyC+Zi
         3eZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xgMQ29idduJbgJK9hiZE/hgGPWQGzVWmbDe+EO96sB0=;
        b=4pRd6EFl6oZckD9rKnrAcNpvrBJsma4GOF5Ij1Qwk7GQZQc/2R8EU20drIgvqgYKTu
         UXMVmnP6TqV683vGZvKngk4TzMJxQFsD5z+9XqveXBK8OHqer/1QnbeMuVlhjKBmlbMh
         xIlqE+gTFA07kyH169a/a/p7OswHKVlANEFE1/cdqIHrlHHpv/+KECPXUHhjam8k9ioB
         MEK096ZAQ7+4VjyOYJgpj8uOKKcXR4hFxfEm8Isv5JDCoeg9CqEiVeCZvDaZ+L8lVJH7
         vBTzhVh+FYxSHKPNLyACLEHtsa3VI2xyTxpAvuFMa6yyUi9G6teluYs/YIk6Opskc8kV
         uw3w==
X-Gm-Message-State: AOAM531klD0GOhx0keTQ/+zmMhIk+RJHArjzxxt7QoH4jK+HyWNutKMQ
        2VhzJYg/Ov81s8iUpqtv393mMXGImx7w9scrTtk=
X-Google-Smtp-Source: ABdhPJzfUmMv6wnarL2PitHzBvFGS0yn30Jvx3gkVFkC+DogBikmGkzT7I1wR5hBfBVxHtYB9ti3kg==
X-Received: by 2002:a17:902:6505:b0:153:2ed8:1f9b with SMTP id b5-20020a170902650500b001532ed81f9bmr8417822plk.40.1647066117097;
        Fri, 11 Mar 2022 22:21:57 -0800 (PST)
Received: from DESKTOP-MEF584H.localdomain ([103.108.4.246])
        by smtp.gmail.com with ESMTPSA id z25-20020a637e19000000b0037c90292bebsm10225330pgc.55.2022.03.11.22.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 22:21:56 -0800 (PST)
From:   Shubham Mishra <shivam828787@gmail.com>
To:     git@vger.kernel.org
Cc:     j6t@kdbg.org, me@ttaylorr.com, kaartic.sivaraam@gmail.com,
        Shubham Mishra <shivam828787@gmail.com>
Subject: [GSoC] [PATCH v3 0/2] avoid pipes with Git on LHS
Date:   Sat, 12 Mar 2022 11:51:24 +0530
Message-Id: <20220312062126.31988-1-shivam828787@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220224054720.23996-1-shivam828787@gmail.com>
References: <20220224054720.23996-1-shivam828787@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

changes since v2:
* t0000: remove git command out of subshell
* t0030: fix missing redirections to "tmp" file
Shubham Mishra (2):
  t0001-t0028: avoid pipes with Git on LHS
  t0030-t0050: avoid pipes with Git on LHS

 t/t0000-basic.sh            | 10 +++--
 t/t0022-crlf-rename.sh      |  4 +-
 t/t0025-crlf-renormalize.sh |  4 +-
 t/t0027-auto-crlf.sh        | 12 +++---
 t/t0030-stripspace.sh       | 75 ++++++++++++++++++++++++-------------
 t/t0050-filesystem.sh       |  3 +-
 6 files changed, 66 insertions(+), 42 deletions(-)

Range-diff against v2:
1:  2a219ace42 ! 1:  5e122c0acf t0001-t0028: avoid pipes with Git on LHS
    @@ t/t0000-basic.sh: test_expect_success 'update-index D/F conflict' '
      '
      
     @@ t/t0000-basic.sh: test_expect_success 'very long name in the index handled sanely' '
    + 
      	>path4 &&
      	git update-index --add path4 &&
    ++	git ls-files -s path4 >tmp &&
      	(
     -		git ls-files -s path4 |
     -		sed -e "s/	.*/	/" |
    -+		git ls-files -s path4 >tmp &&
     +		sed -e "s/	.*/	/" tmp |
      		tr -d "\012" &&
      		echo "$a"
2:  c90fc271d9 ! 2:  c412380af3 t0030-t0050: avoid pipes with Git on LHS
    @@ t/t0030-stripspace.sh: test_expect_success \
     -    ! (printf "$ttt$sss$sss$sss" | git stripspace | grep "  " >/dev/null)
     +    printf "$ttt$sss" | git stripspace >tmp &&
     +    ! grep "  " tmp >/dev/null &&
    -+    printf "$ttt$ttt$sss" | git stripspace &&
    ++    printf "$ttt$ttt$sss" | git stripspace >tmp &&
     +    ! grep "  " tmp >/dev/null &&
    -+    printf "$ttt$ttt$ttt$sss" | git stripspace &&
    ++    printf "$ttt$ttt$ttt$sss" | git stripspace >tmp &&
     +    ! grep "  " tmp >/dev/null &&
    -+    printf "$ttt$sss$sss" | git stripspace &&
    ++    printf "$ttt$sss$sss" | git stripspace >tmp &&
     +    ! grep "  " tmp >/dev/null &&
    -+    printf "$ttt$ttt$sss$sss" | git stripspace &&
    ++    printf "$ttt$ttt$sss$sss" | git stripspace >tmp &&
     +    ! grep "  " tmp >/dev/null &&
    -+    printf "$ttt$sss$sss$sss" | git stripspace &&
    ++    printf "$ttt$sss$sss$sss" | git stripspace >tmp &&
     +    ! grep "  " tmp >/dev/null
      '
      
    @@ t/t0030-stripspace.sh: test_expect_success \
     +    echo "$ttt$sss" | git stripspace >tmp &&
     +    ! grep "  " tmp >/dev/null &&
     +    echo "$ttt$ttt$sss" | git stripspace >tmp &&
    -+    ! grep "  " tmp>/dev/null &&
    -+    echo "$ttt$ttt$ttt$sss" &&
    ++    ! grep "  " tmp >/dev/null &&
    ++    echo "$ttt$ttt$ttt$sss" | git stripspace >tmp &&
     +    ! grep "  " tmp >/dev/null &&
     +    echo "$ttt$sss$sss" | git stripspace >tmp &&
     +    ! grep "  " tmp >/dev/null &&
-- 
2.25.1

