Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6DD8C4332F
	for <git@archiver.kernel.org>; Mon, 12 Dec 2022 08:32:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiLLIcy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Dec 2022 03:32:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiLLIcw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Dec 2022 03:32:52 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B822195
        for <git@vger.kernel.org>; Mon, 12 Dec 2022 00:32:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1670833959; bh=d9ss7q18wBl3uQOjo4gb70AHCFJ78tp+/A1RNXQtUQA=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=cHPvwvPKehIxVjy9pCCd4XGVOXfMfTtfAA8gzvWSKFl1nE3ervphU5yyBbnX34dmT
         6YplyYO6udAOeFtToZwvezjQ0ZsLjdw9ttck9zkZMjLLh9QiJnSjTM3rCrxqZAF9j3
         XUo7mXx4+Jr47ihxXrQ669XR/QJD9mUP3OSTgMHmRi6oI6F2No7/gMfpNX2M/SRopA
         5yPvTtFCaNh63OVC44Jx6RH1GoKgwynluC9+dSr6yclygODQQgKAB383t8sbYGGDWs
         wGJ3OY1IgE47Ds4twZMKuk79ZLe1Iyq9QQGU6LjtgSVPjBin7GceQMAWN588sQeb0V
         zbZhwAwEakuhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.29.107.233] ([89.1.215.49]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M4JqV-1p4vDi1wPJ-000MHp; Mon, 12
 Dec 2022 09:32:39 +0100
Date:   Mon, 12 Dec 2022 09:32:38 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Teng Long <dyroneteng@gmail.com>
cc:     git@vger.kernel.org, avarab@gmail.com, tenglong.tl@alibaba-inc.com,
        me@ttaylorr.com
Subject: Re: [RFC PATCH 6/6] ls-tree: introduce '--pattern' option
In-Reply-To: <20221117113023.65865-7-tenglong.tl@alibaba-inc.com>
Message-ID: <2q985o75-p6ro-3319-rqos-004621r0p7pq@tzk.qr>
References: <20221117113023.65865-1-tenglong.tl@alibaba-inc.com> <20221117113023.65865-7-tenglong.tl@alibaba-inc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:gQIA4rWWySiJF+HpActQ+qjn6bQEpD5EzxvYi9euJF5nUFUklV6
 OFTiAXGW3DXXGPIzuBRFQJDpJTNYhDI0ILvi4sG2/D1OZC3B9svvXN+Vu8ymjYGdoNQ8ST9
 0KF/D4O1QxFWtEeWWKIb94e9DeCyf8rD1BoB7uAciJOU/df61TsOv973xGhFtim14MYBYOu
 g3EuFD9P3tIz9wxqPtf6w==
UI-OutboundReport: notjunk:1;M01:P0:c+/mZ1PUTv4=;aQkCFy/o7OKyg9Bz17tdbcuG9Fl
 nVJU4PERZSWjWCTB3PGXDRditX12DAiZkYsVxcb2bTg/FrWZzC87GHcWhZ9pZA2Kq1wgLfZ8a
 EyoDebOT6izC+s7xWq+d5gtHMasmY/jMj3Tu61ocb4zL/pxNSip/Jt+uKiyV0I9Kj1lWPHXFB
 oHQm6u3mYJ4ZNZfFiVSuwYo5Yfv/8Ud3wfGxUKSQZhMrDR4X9OgjV1uOrgmvtqfj5dGtZ/Lg0
 BOsRETnCb+4hqrlRa2Cw8D1LbFmHAmCM3MhMM0+cspsiwe79HxV9ufqzfHjsq2sPkC/Sdzhcd
 OvckPmMYYJuMvnROv9ljBtx7w5IMscsfMz/ai46RB2pznCSLPy9pi1vS6aR0k4f3Xlt/akPR0
 Fw5VNKcYQOtTswGE3WsN7ewOXpBQfAFuhBEIzmi5dHTJh4nW+pk6X0OOu2uuQvS+Uarx6JbPM
 TaTvoE4GEF5rxgT6/qo0pCriQ9BNgjO1cwa6Dr+XtIh96aAy6bLRzpa9OowajT5TVi+YrxJOc
 iZ/2xB8aCd0u8VXGq0/UOiRExwyKb2Z2GT2Y4b8f06TLNv8KP8s3jd73XJPWgJe/54ybn6eA5
 W840zsJIreVSlW1EPf+VEwTwo1mBbB74oWJJb9owKS5g1BDvq91D/3huFit9GC0rvocBriKNo
 im9k01Eu5hr7z1cOubDwAdQF+nR0Xps/Uv9WEiro9gANT1Jezq6qFHr61isFMwCrk1ea8LKRp
 UtPUm3AEg1hZt4eBOpkBqj6kPA5KuXRXp9cepHo55nYx4g0BRKFKcGpXXTYusV+evVK8AJsq8
 J5fof9RtfZj0wZMYWwwrSsy1PkDptavmYWpEQeTwdn6XNbMYIlKsAX5HPdHtQxgSJh8qgihJD
 whX/nMIrADa+ul/URDqhO9bv0Zfop/TNOyd09dYaadQCoj0fumbojrwZO21BC5JeeZZMj3uF8
 x74/5w==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, 17 Nov 2022, Teng Long wrote:

> diff --git a/t/t3106-ls-tree-pattern.sh b/t/t3106-ls-tree-pattern.sh
> new file mode 100755
> index 00000000000..e4a81c8c47e
> --- /dev/null
> +++ b/t/t3106-ls-tree-pattern.sh
> @@ -0,0 +1,70 @@
> +#!/bin/sh
> +
> +test_description=3D'ls-tree pattern'
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> +. ./test-lib.sh
> +. "$TEST_DIRECTORY"/lib-t3100.sh
> +
> +test_expect_success 'setup' '
> +	setup_basic_ls_tree_data
> +'
> +
> +test_expect_success 'ls-tree pattern usage' '
> +	test_expect_code 129 git ls-tree --pattern HEAD &&
> +	test_expect_code 128 git ls-tree --pattern "" HEAD >err 2>&1 &&
> +	grep "Not a valid pattern, the value is empty" err
> +'
> +
> +test_expect_success 'combine with "--object-only"' '
> +	cat > expect <<-EOF &&
> +		6da7993
> +	EOF
> +
> +	git ls-tree --object-only --abbrev=3D7 --pattern "6da7993" HEAD > actu=
al &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'combine with "--name-only"' '
> +	cat > expect <<-EOF &&
> +		.gitmodules
> +		top-file.t
> +	EOF
> +
> +	git ls-tree --name-only --pattern "\." HEAD > actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'combine with "--long"' '
> +	cat > expect <<-EOF &&
> +		100644 blob 6da7993      61	.gitmodules
> +		100644 blob 02dad95       9	top-file.t
> +	EOF
> +	git ls-tree --long --abbrev=3D7 --pattern "blob" HEAD > actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'combine with "--format"' '
> +	# Change the output format by replacing space separators with asterisk=
s.
> +	format=3D"%(objectmode)*%(objecttype)*%(objectname)%x09%(path)" &&
> +	pattern=3D"100644\*blob" &&
> +
> +	cat > expect <<-EOF &&
> +		100644*blob*6da7993	.gitmodules
> +		100644*blob*02dad95	top-file.t
> +	EOF
> +
> +	git ls-tree --abbrev=3D7 --format "$format" --pattern "$pattern" HEAD =
>actual &&
> +	test_cmp expect actual
> +'
> +
> +test_expect_success 'default output format (only with "--pattern" optio=
n)' '
> +	cat > expect <<-EOF &&
> +		100644 blob 6da7993ca1a3435f63c598464f77bdc6dae15aa5	.gitmodules
> +		100644 blob 02dad956d9274a70f7fafe45a5ffa2e123acd9a8	top-file.t
> +	EOF
> +	git ls-tree --pattern "blob" HEAD > actual &&
> +	test_cmp expect actual
> +'
> +
> +test_done

The hard-coded object IDs break the `linux-sha256` job, as pointed out in
https://github.com/git/git/blob/6ab7651d8669/whats-cooking.txt#L522-L537.

Please squash this in to address this (Junio, please feel free to
cherry-pick this on top of `tl/ls-tree--pattern` to reduce the number of
CI failures):

=2D- snipsnap --
Subject: [PATCH] fixup! ls-tree: introduce '--pattern' option

We need to avoid hard-coding OIDs because of the SHA-256 support.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
=2D--
 t/t3106-ls-tree-pattern.sh | 23 +++++++++++++++--------
 1 file changed, 15 insertions(+), 8 deletions(-)

diff --git a/t/t3106-ls-tree-pattern.sh b/t/t3106-ls-tree-pattern.sh
index e4a81c8c47e..8aaca307804 100755
=2D-- a/t/t3106-ls-tree-pattern.sh
+++ b/t/t3106-ls-tree-pattern.sh
@@ -17,11 +17,12 @@ test_expect_success 'ls-tree pattern usage' '
 '

 test_expect_success 'combine with "--object-only"' '
+	oid=3D"$(git rev-parse --short HEAD:.gitmodules)" &&
 	cat > expect <<-EOF &&
-		6da7993
+		$oid
 	EOF

-	git ls-tree --object-only --abbrev=3D7 --pattern "6da7993" HEAD > actual=
 &&
+	git ls-tree --object-only --abbrev=3D7 --pattern "$oid" HEAD > actual &&
 	test_cmp expect actual
 '

@@ -36,22 +37,26 @@ test_expect_success 'combine with "--name-only"' '
 '

 test_expect_success 'combine with "--long"' '
+	oid1=3D"$(git rev-parse --short HEAD:.gitmodules)" &&
+	oid2=3D"$(git rev-parse --short HEAD:top-file.t)" &&
 	cat > expect <<-EOF &&
-		100644 blob 6da7993      61	.gitmodules
-		100644 blob 02dad95       9	top-file.t
+		100644 blob $oid1      61	.gitmodules
+		100644 blob $oid2       9	top-file.t
 	EOF
 	git ls-tree --long --abbrev=3D7 --pattern "blob" HEAD > actual &&
 	test_cmp expect actual
 '

 test_expect_success 'combine with "--format"' '
+	oid1=3D"$(git rev-parse --short HEAD:.gitmodules)" &&
+	oid2=3D"$(git rev-parse --short HEAD:top-file.t)" &&
 	# Change the output format by replacing space separators with asterisks.
 	format=3D"%(objectmode)*%(objecttype)*%(objectname)%x09%(path)" &&
 	pattern=3D"100644\*blob" &&

 	cat > expect <<-EOF &&
-		100644*blob*6da7993	.gitmodules
-		100644*blob*02dad95	top-file.t
+		100644*blob*$oid1	.gitmodules
+		100644*blob*$oid2	top-file.t
 	EOF

 	git ls-tree --abbrev=3D7 --format "$format" --pattern "$pattern" HEAD >a=
ctual &&
@@ -59,9 +64,11 @@ test_expect_success 'combine with "--format"' '
 '

 test_expect_success 'default output format (only with "--pattern" option)=
' '
+	oid1=3D"$(git rev-parse HEAD:.gitmodules)" &&
+	oid2=3D"$(git rev-parse HEAD:top-file.t)" &&
 	cat > expect <<-EOF &&
-		100644 blob 6da7993ca1a3435f63c598464f77bdc6dae15aa5	.gitmodules
-		100644 blob 02dad956d9274a70f7fafe45a5ffa2e123acd9a8	top-file.t
+		100644 blob $oid1	.gitmodules
+		100644 blob $oid2	top-file.t
 	EOF
 	git ls-tree --pattern "blob" HEAD > actual &&
 	test_cmp expect actual
=2D-
2.38.1.windows.1.24.g5ff6506c583.dirty

