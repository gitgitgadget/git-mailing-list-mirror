Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5301C433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:19:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92AF8610C8
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 09:19:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352897AbhJAJUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 05:20:53 -0400
Received: from mout.web.de ([217.72.192.78]:36851 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229792AbhJAJUw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 05:20:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1633079945;
        bh=NK1d8BUqZNtz2yCWpgNz7R1A5M0Sd9cY3FfIvIlPQ0Y=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
        b=PDXmZFA9N/Eh+/yKgL3z8jjBXKbkkLgMjRQyPbXQPKmX01ryVnMnLyw3lZ61zKAx2
         EiPVjA7Pk3O3Q9U7cOzGwTl8WkjLgezOCrPr2Ae71QP3PtSSzd5NEW/19wo2+4v0jb
         43KY5KK915ZXp48p/QTr+bUO98X/0oPAzr+vQlRw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.20.171]) by smtp.web.de
 (mrweb105 [213.165.67.124]) with ESMTPSA (Nemesis) id
 1MQgl2-1m8VJf0mu6-00O41I; Fri, 01 Oct 2021 11:19:05 +0200
Subject: [PATCH 7/9] p0071: measure sorting of already sorted and reversed
 files
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>
References: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Message-ID: <3fa28f14-5e53-7367-b628-6eab2d5737be@web.de>
Date:   Fri, 1 Oct 2021 11:19:04 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <943b1e01-465e-5def-a766-0adf667690de@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:mMPo3rTo3Lx6pJp15jKk6UXxSWP0vGa6Ln+GzQxwbkSXq5sov3W
 rLusTQnK4mbJ/ObQf538BSOxYaXiszbH+aRDXV2K5OcsKVmEBsXSViNvQkQlnfzDC5YjKav
 ftU1LoQYKddY20+x5t2zHT8ILXyoiaHIL6h94jN6IV3UdH2k/Y0pGRxwwVmQTsS5m6j7xk3
 0lHQQ56DXrVRbfjqr/Sqw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/JfHREKQ3s8=:XcIeDSIeD1jzrzVRpme/oQ
 ONsqZFXQiTyA1Wa9RVnzfsS6IQVID3/QCAuxLlp+s3prsHuTRJApfF36EiQOCAt6oSxuebKM/
 9StG2SIJHlzMgT51W/v3p9y0oiGXogb5+fcZYAzRNrmqs7sY4DBdwHPYxGlLCMo7/6gQi+Uod
 BaK/mBJrT3kcDIV4gA1O5870jW5Gd7SHTP4KW+YxpYhHrKzR2nG2ukto+zWh3NVnYL0xN+sEh
 6Di5nCuK7YV22pGteweMqozfwjiIT7mw+mFOE5wa3f1Jca2KuJkbcCwO9FJySLR1SZY8coXRM
 pVI+cj2onO4F1iOEjeDoV3LQRmUCZS/SxChx+NNTHpiAhf43AiV8TFBB0T42dXrYsALpjoyO+
 fCOlHi7PDdu+JstpAais0uJaRr90bmcstBJHPA20v37CK5HA02dL1ZsOVitjb+RLh6sK7fXER
 mTZX7cnGFVHNng9hLmEubylGQGlQewH+mMbZ8PJY7pgtZRrb+Oj55DE/l97TODBy+0WppSubK
 ouLPJK9pdQShA4PVa3ptMyxH+j6ZbUaRqbJ+qpS9B1U3tmfSGep7j3n0S5igb/GOVP1zpRxqI
 o5qS0aHN0xvaBCoa2wXvGJI+gkpG/Fp6eREW3LmahUl5I01HtbDikP+eo4K1YoUCkJave14zE
 xV/aMVmliPIw0W3sxYuQTmtBmvH0kURIPPnFm3CtYpUPkg1tqOshC864LlxcS3/goTV5cwodU
 pNlW9XAZwit4qObB1VFOpdDjhr9Sca3OnbTxdnQwWmhBkha+VMYs6q+myhLPdYtkX44WAnCjq
 HWzyxrK2QMvT+SNilHb+rQi/O4xuAHEnaSrObzwbwq6xEmM22B0BKcOos9WXjQSWmiEngq/5G
 HGtVfMnbde3d4ko8bb5ZzS/CkUywwb9njjcQxBEworKiXEQFA/7YTqotj5qOgxo/u0s6xTmQq
 Q5fd6c3kJck2Ps/5ar2BOjc1KF6gNozYMD4CcfUkC9mm9zA4g+OBHjpINUExVTnTKSDr/U0Lo
 JW5yoR0JcMYYIY2W81RxsnhmILhPgUHOOZhiThnDD74VLR1rTY+eZT5cyC8UqkW3lxstwlVrP
 9A2CcecixASSyI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Check if sorting takes advantage of already sorted or reversed content,
or if that corner case actually decreases performance, like it would for
a simplistic quicksort implementation.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/perf/p0071-sort.sh | 29 ++++++++++++++++++++++-------
 1 file changed, 22 insertions(+), 7 deletions(-)

diff --git a/t/perf/p0071-sort.sh b/t/perf/p0071-sort.sh
index 6e924f5fa3..5b39b68f35 100755
=2D-- a/t/perf/p0071-sort.sh
+++ b/t/perf/p0071-sort.sh
@@ -11,16 +11,31 @@ test_expect_success 'setup' '
 	git cat-file --batch >unsorted
 '

-test_perf 'sort(1)' '
-	sort <unsorted >expect
+test_perf 'sort(1) unsorted' '
+	sort <unsorted >sorted
 '

-test_perf 'string_list_sort()' '
-	test-tool string-list sort <unsorted >actual
+test_expect_success 'reverse' '
+	sort -r <unsorted >reversed
 '

-test_expect_success 'string_list_sort() sorts like sort(1)' '
-	test_cmp_bin expect actual
-'
+for file in sorted reversed
+do
+	test_perf "sort(1) $file" "
+		sort <$file >actual
+	"
+done
+
+for file in unsorted sorted reversed
+do
+
+	test_perf "string_list_sort() $file" "
+		test-tool string-list sort <$file >actual
+	"
+
+	test_expect_success "string_list_sort() $file sorts like sort(1)" "
+		test_cmp_bin sorted actual
+	"
+done

 test_done
=2D-
2.33.0
