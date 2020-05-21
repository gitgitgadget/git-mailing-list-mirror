Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9C9CC433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 09:52:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DE85207D3
	for <git@archiver.kernel.org>; Thu, 21 May 2020 09:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="c7tUG9ZA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726953AbgEUJwg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 05:52:36 -0400
Received: from mout.web.de ([212.227.15.3]:38225 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgEUJwg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 05:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1590054750;
        bh=9T4SW+r6biplOJwSrg66XBROfmNGjop7Nwmv5kT8zT4=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=c7tUG9ZAmV7WVaA3gcR1b1eNPfau+gEESjqzsUe+KFxSslDbegiLXXNBgPbFAs6Rt
         LdChk0UqdWME3orS/T4qTxKFs91cBZUCHVaylUF+4J16vIY6YKnVH017KEUXVQD94Q
         W30agO5OHLKUEpK8D+Jev3sQmyORIi6G60gTwRFw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.26] ([79.203.24.188]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MLxrY-1jhD733fVE-007nUH; Thu, 21
 May 2020 11:52:29 +0200
Subject: [PATCH 2/4] t1450: increase test coverage of in-tree d/f detection
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Brandon Williams <bwilliamseng@gmail.com>,
        git <git@vger.kernel.org>, Jeff King <peff@peff.net>
References: <CALN-EhTpiLERuB16-WPZaLub6GdaRHJW8xDeaOEqSFtKe0kCYw@mail.gmail.com>
 <d963242a-72f3-7f42-7c95-ea5148f74804@web.de>
 <xmqqpnbduiec.fsf@gitster.c.googlers.com>
 <938f0818-7e57-b883-009f-01db88ef8f65@web.de>
 <xmqqh7wovoop.fsf@gitster.c.googlers.com>
 <aab9512b-a70a-0f5b-5cdc-5d40acd343d0@web.de>
 <2937d635-52a9-5e69-b3d2-fbde415b7315@web.de>
 <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <106c58e1-9c74-46e3-c83a-88eee114d9d6@web.de>
Date:   Thu, 21 May 2020 11:52:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <xmqq4ksmsaks.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Vdy2V8EgEqr0mtMhh3qcOkhnW/6oD3wIr/TdZA6oJcbhuIfa75I
 8AglESiLNEu1jKuMl+bAoG1CyA1dHT1P7fz1s/CIhKgm8Cbm1JwHwvCw+s0X/upcJ09kguA
 JlYhbqPukh2Emt/C94BA7qcW+FXHBMdS+qINPOGBrSIKDDy3COyQP1VPFJe9vkFyHP84KRt
 8WVejsWk5MTmQf+30thGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ioeg4lb5XPE=:ozreVdHpTQl6/ayvkAqFnY
 tw4NghWFm+gAqUjpvUBFpnT1PS5iXs6WqjIaCrGyBgUlUx4Rmo0mF57mRUVuDGvz2WwztxWJK
 R1uV7oDwTO6XancnxwuC/g1jOKfgLEP+xwoIgAsUimB+lrDzX0M0SCK7UknBBGuMgucaTU/jb
 +wE4XAee5dsYgvVMle2ji6eNIMwbGIs78MbQv7LZi4RhtVJOMCVpjBgnaVf37kAWVrscN/LgE
 rnNbyur/ZKVcz8+45vqxjJr66KTyHG6jd0pnj6tCJ6+ymH3KC3SnbxvI0BAV1ziMWCgjV+usx
 DQ7V13bmf7NVZnXaEE/5UdX1wRbZ82HZbM9WeBLCcdBmiCJdtNvIZ6GKHKIDxW4W9B50ykoQi
 C6C/HVmoKVGSuLUcWnEzT2p19hWEKMHfhfK3xUahSbQK7rp5eCoZiJlMVOx3neCO6fU8vGTyf
 +IdRqYCA/Y8Bs5V50gn5eE+PDrfTdGPB1M0mpp9z9765AAPdQHJ3zU56JCyzhYi2t90gJAhg5
 s/u3aonJLGHM+Bcm/esK46nNgB7+vIcSbOdpybnaLusM7hQk+n5IE9l41KgAeXenrUBECOuFg
 upDFocTjtoaoFsGCjtqet0I1wMx8RFjg0CbK9yFVjv/IWHvsXz2fF5bQHL0W1sDqb0f/WiZ4S
 lwLaIHmsI07MszjFPzQiYOBpcPoygaSy/KeZpwrvL5cxMsWAT/Tf8LjwZ7j0qsL0oSZrcgqPM
 OjBv++YSKfcAaAfmK/u9STB3MqDh3SnXnNm8cMPz4cXXdHih10QIrsyEuOdrPtbdgEpXBIWQ1
 Eb2VSiQTGxb6tAUpja3jCWnsTdODE7yjX9NKPOpDjJ3pGIol/gqSugWJWnonhAYxX79P3C5Ap
 9jpL6f5pNZw3WI3NkxD7/THFBWsICmWbJIYITzPfeqtW9SNf/AsFAEkwrh/fyGNUmXLda0f4b
 JMJBeuyRwns51H9uX8b3TrgYCjFQGPznv6z03Bq8vms6mshYy5bDbGA8men6UPplaM7rIsXeS
 MAFUcnjjRZ60/MbxAwCbwT2DVbkFOcQ7JriMpLGe0FErp4FG29M12ROT5yNf1UMdLgZe6NkyV
 UuyE51XAgvIWcFdzwh+cTJnfFqdnnW9/R7UnpUzc709oHRfcMcBFOTkhX7UOdD9vH2YRLabiY
 DLNkq3eOxdvaC+ec7Bw0rSYOuodkYC/MzMBzJPjLlYrel5RC9zl63Vci+VyzGt4IolP1g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Exercise the case of putting a conflict candidate file name back on the
stack because a matching directory might yet come up later.

Do that by factoring out the test code into a function to allow for more
concise notation in the form of parameters indicating names of trees
(with trailing slash) and blobs (without trailing slash) in no
particular order (they are sorted by git mktree).  Then add the new test
case as a second function call.

Fix a typo in the test title while at it ("dublicate").

Reported-by: Derrick Stolee <stolee@gmail.com>
Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t1450-fsck.sh | 42 +++++++++++++++++++++++++++---------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 91a6e34f38..9640ac8ff2 100755
=2D-- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -257,21 +257,33 @@ test_expect_success 'tree object with duplicate entr=
ies' '
 	test_i18ngrep "error in tree .*contains duplicate file entries" out
 '

-test_expect_success 'tree object with dublicate names' '
-	test_when_finished "remove_object \$blob" &&
-	test_when_finished "remove_object \$tree" &&
-	test_when_finished "remove_object \$badtree" &&
-	blob=3D$(echo blob | git hash-object -w --stdin) &&
-	printf "100644 blob %s\t%s\n" $blob x.2 >tree &&
-	tree=3D$(git mktree <tree) &&
-	printf "100644 blob %s\t%s\n" $blob x.1 >badtree &&
-	printf "100644 blob %s\t%s\n" $blob x >>badtree &&
-	printf "040000 tree %s\t%s\n" $tree x >>badtree &&
-	badtree=3D$(git mktree <badtree) &&
-	test_must_fail git fsck 2>out &&
-	test_i18ngrep "$badtree" out &&
-	test_i18ngrep "error in tree .*contains duplicate file entries" out
-'
+check_duplicate_names () {
+	expect=3D$1 &&
+	shift &&
+	names=3D$@ &&
+	test_expect_$expect "tree object with duplicate names: $names" '
+		test_when_finished "remove_object \$blob" &&
+		test_when_finished "remove_object \$tree" &&
+		test_when_finished "remove_object \$badtree" &&
+		blob=3D$(echo blob | git hash-object -w --stdin) &&
+		printf "100644 blob %s\t%s\n" $blob x.2 >tree &&
+		tree=3D$(git mktree <tree) &&
+		for name in $names
+		do
+			case "$name" in
+			*/) printf "040000 tree %s\t%s\n" $tree "${name%/}" ;;
+			*)  printf "100644 blob %s\t%s\n" $blob "$name" ;;
+			esac
+		done >badtree &&
+		badtree=3D$(git mktree <badtree) &&
+		test_must_fail git fsck 2>out &&
+		test_i18ngrep "$badtree" out &&
+		test_i18ngrep "error in tree .*contains duplicate file entries" out
+	'
+}
+
+check_duplicate_names success x x.1 x/
+check_duplicate_names success x x.1.2 x.1/ x/

 test_expect_success 'unparseable tree object' '
 	test_oid_cache <<-\EOF &&
=2D-
2.26.2
