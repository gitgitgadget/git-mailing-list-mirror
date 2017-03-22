Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7AA7B20323
	for <e@80x24.org>; Wed, 22 Mar 2017 17:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935456AbdCVRfe (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 13:35:34 -0400
Received: from mail-wm0-f51.google.com ([74.125.82.51]:34329 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935383AbdCVRfc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 13:35:32 -0400
Received: by mail-wm0-f51.google.com with SMTP id w204so1210321wmd.1
        for <git@vger.kernel.org>; Wed, 22 Mar 2017 10:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=I4i1NPzEpDyrn+/VI7TNFoYsCSZHc9LEe6egLv1reKs=;
        b=XNKl51Bf7zVEWg1murW1qO1fE1xCb30QBtHQo7v6GSR0AiJxLknVhvT7EARBY69a24
         2G+VJWZmERC89E3yiphoG9Ff8yK+nTFnIFvntpob0bz2pt9vCwjSq6ERnwgxHHGexFGb
         Uksnks2mB1KXPGx2DPf8sNup/z2EB8rSb05XuyzyPkJlphR/hWNpEx/h1x2R61WHzNa4
         3PX09DNJRdnRBgIifBbnaAeULvEW76au4Rx1BP04uPBrZHbfeBWeU/Y50DMMR/sUw7+G
         oFMY3N/5exjjTF9YQfRRZWB8kWGTXCUhTtpi1n21x3EFDU3OL7Syqv9+5arFsqXHAigk
         yiAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=I4i1NPzEpDyrn+/VI7TNFoYsCSZHc9LEe6egLv1reKs=;
        b=EGMBXmpSCZzxUthg/m9yiEvPoiucSzssy/pguf7k/zfmv3AeO2XOh3GciYslGkjhND
         8CxndvAKh+fr1lvuKylahgQIpKGv+A3qlBpgr0pAoE3D8NGxFjsWDxKypgR3cLutJIZV
         hPYgyMPFaJBG7SAtwDxH63XbhDL+XhsWs4Bby3TdpBWEcsD/ybLsVkabVNlb2czmtuAG
         ln64nT3Exn+2YPvd5g9MmWhe9LZEBilLfHnlzV0qxRynLYDV5gDVAylCwU/7sOtyZVTp
         xmCQD21yYB/oqycG+d0cWNNz9LFV5OSZKXxBF8b8WapsBkt7toEFRWnktsL4c0+zZDpP
         RDCg==
X-Gm-Message-State: AFeK/H0dAy2XZN3QEitHq64fbWILv8wZX0ZKmhoFaA/OcO5N0HpbSbHtp/ATw615GEPlww==
X-Received: by 10.25.228.131 with SMTP id x3mr10993496lfi.125.1490204130680;
        Wed, 22 Mar 2017 10:35:30 -0700 (PDT)
Received: from localhost (user-94-254-131-200.play-internet.pl. [94.254.131.200])
        by smtp.gmail.com with ESMTPSA id s5sm87111lja.48.2017.03.22.10.35.29
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Mar 2017 10:35:30 -0700 (PDT)
Date:   Wed, 22 Mar 2017 18:35:28 +0100
From:   Jan Palus <jan.palus@gmail.com>
To:     git@vger.kernel.org
Subject: EOF test fixes (t5615/t7004)
Message-ID: <20170322173528.ho43ulndlozq35tu@kalarepa>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="zdwsvh5klwizsvlx"
Content-Disposition: inline
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--zdwsvh5klwizsvlx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi,

attached patch fixes 2 out of 3 tests failing in my env -- missing EOF,
incorrectly placed "&&" after EOF. One test seems to be incorrect as it
fails even after fixing. I suspect the main difference between my env and
others is in shell used -- mksh in my case and probably bash in others.
Looks like bash has a nasty behavior when it encounters syntax error:

$ cat test.sh
cat >/dev/null <<-\EOF
tagname : forged-tag
EOF &&
echo foo

$ bash test.sh && echo success || echo failed
test.sh: line 4: warning: here-document at line 1 delimited by
end-of-file (wanted `EOF')
success

# notice no "foo" printed

$ mksh test.sh && echo success || echo failed    
test.sh[5]: here document 'EOF' unclosed
failed

Test that fails even after fixing EOFs:
t7004-tag.sh:verifying a forged tag with --format fail and format accordingly

Note that I'm not subscribed to mailing list so in case of any questions
please mail me directly.


Regards
Jan

--zdwsvh5klwizsvlx
Content-Type: text/plain; charset=utf-8
Content-Disposition: attachment; filename="git-core-tests.patch"

diff -urN git-2.11.1.orig/t/t5615-alternate-env.sh git-2.11.1/t/t5615-alternate-env.sh
--- git-2.11.1.orig/t/t5615-alternate-env.sh	2017-02-03 02:24:45.115143042 +0100
+++ git-2.11.1/t/t5615-alternate-env.sh	2017-02-03 02:24:58.081809318 +0100
@@ -77,6 +77,7 @@
 	check_obj "$quoted:$unquoted" <<-EOF
 	$one blob
 	$two blob
+	EOF
 '
 
 test_expect_success !MINGW 'broken quoting falls back to interpreting raw' '
diff -ur git-2.12.0.orig/t/t7004-tag.sh git-2.12.0/t/t7004-tag.sh
--- git-2.12.0.orig/t/t7004-tag.sh	2017-02-25 14:10:53.059367179 +0100
+++ git-2.12.0/t/t7004-tag.sh	2017-02-25 14:11:45.105827700 +0100
@@ -880,17 +880,17 @@
 '
 
 test_expect_success 'verifying a proper tag with --format pass and format accordingly' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	tagname : signed-tag
-	EOF &&
+	EOF
 	git tag -v --format="tagname : %(tag)" "signed-tag" >actual &&
 	test_cmp expect actual
 '
 
 test_expect_success 'verifying a forged tag with --format fail and format accordingly' '
-	cat >expect <<-\EOF
+	cat >expect <<-\EOF &&
 	tagname : forged-tag
-	EOF &&
+	EOF
 	test_must_fail git tag -v --format="tagname : %(tag)" "forged-tag" >actual &&
 	test_cmp expect actual
 '

--zdwsvh5klwizsvlx--
