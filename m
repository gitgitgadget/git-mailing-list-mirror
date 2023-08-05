Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59DEDC0015E
	for <git@archiver.kernel.org>; Sat,  5 Aug 2023 14:40:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229763AbjHEOkA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Aug 2023 10:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjHEOj7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Aug 2023 10:39:59 -0400
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8928C1720
        for <git@vger.kernel.org>; Sat,  5 Aug 2023 07:39:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1691246393; x=1691851193; i=l.s.r@web.de;
 bh=g5rSZ3b5ed+9YyDCQf/y3FXW13mLRlS4L3+hPruXifc=;
 h=X-UI-Sender-Class:Date:Subject:From:To:Cc:References:In-Reply-To;
 b=PAg+sy1Es75fzEAzMYsnkff7ogVCUqsX0t+WKeh4ATPY0R1twulNrCt6rCBL6N/+EamWu0W
 9J5RXdIFsCUm08EAAOVxB6tNCmoVvwW0m9+AX2qLbhhMvVZpfbYC4GmWnx9JsjGotC6yrYE3D
 2JKXy+s8XtNs4TEA1SYf2PIeW0Y8GBWZ7ddD7GGHbzLLpyA/nENyLwzsrhB3ap5MG+1OPtD5K
 fu8ZL0EFLTmYixCxNrXFSOHXE73smQUnL0HoGu2begi3bhK+Z/9+mnOsFxOeZLLBEGdHlSwsA
 sxtkSRtc5/ELXjSab54jnqup01dHbt5fDVN75hyaSUC1OeG805xg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.150.179]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1Md6xz-1psxUg11ZD-00ZyQ6; Sat, 05
 Aug 2023 16:39:53 +0200
Message-ID: <0c774b88-effa-75a4-27e9-3c21a11c0dba@web.de>
Date:   Sat, 5 Aug 2023 16:39:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: [PATCH v3 4/8] t1502: test option negation
Content-Language: en-US
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
To:     Git List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <d392a005-4eba-7cc7-9554-cdb8dc53975e@web.de>
 <xmqqo7k9fa5x.fsf@gitster.g> <a6326aaa-4f05-4d00-8906-2f50ea8e1e7a@web.de>
 <xmqq351hz5xp.fsf@gitster.g> <43ca3f01-ba11-6c29-a8e8-4e6c262a68cc@web.de>
 <xmqq4jlxuiuu.fsf@gitster.g> <e4d46d97-1cd4-7fea-afd1-7de5023b1b09@web.de>
In-Reply-To: <e4d46d97-1cd4-7fea-afd1-7de5023b1b09@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:xizr6LhOPt4rF1JwUDtd8faLz39Tl4Nx1NGQZvfSbBnFs6mcw45
 SANlM/rVzkS+LagdiYIT4VItKu/qHe05eqjmySVyysOny5DeKzJvLG9pIDfB19Eopg2dFPl
 tKf+eOa0lymGljwVQdnMEPgSBktSbJXG7gvdGjM/ySS1eSF/O4X94zvm4acUkofkl2KjDrp
 MqPAhPVWeIsSwgPIg/ukA==
UI-OutboundReport: notjunk:1;M01:P0:aV0FKWco8Rs=;KMbmHE+Vifttqe61QLqDMLHgidi
 ptdrRvzZTevTQGrjBITo4UdULrTgIEWbB84BjA5eBW33CHaf9utYsxGydgWnK5ray9P0eaIGe
 Ud1FJCYjV+muB58Z324vuPaMeyQcrxz69xu9aLpt1+MEPGMqK//hfGur3g46V4SspUD2zj9WW
 ZfN1OuFaXC4G1GBEhUXdhqGS6wcneiMoSgSBODNkVT4xroLHKiVSLxPxWt1xIGxmT3toAQn5D
 J7+RKNS1yIG/r13ylE0lb1ZAkJMuOuqEDbqg4CXtit3iKwb4gTR+fgK3FltH7BbAsUbQMY8hS
 CfBzORXlocPr+6h4hgciM9ygfPyLnmvKRwJMxrbdaCvUs1H4PC2yhboB/2ebUy7dLxabipj3w
 SqM5TpKjiVoAas41lR6gZ60FxSugpZxlYMvGwTt76iV6uDu5ggir08BW3i70a592Oy8kwMR2a
 p5vycw5Xi+AMIe0jrQQNFSEcXEqvhfETz3P6PFGwA5CiqQgxps3eVzTjIR4hqsEklbFspOKZx
 J+ptRxghvBbPM8yTLpibHX3OgW1szsdzXB1f41vSqdhc/BYc4+S4C4wfIrXsUe/VFNXqrgq5E
 xYlE5KWd+2X6iWtIMTsMeZG+jzs3kc2yC+8GoA/74o8qc07dIKfoaMpuvdMCr6ZosS0ZDLhJJ
 L2Rdm54jzQT5rqoTm6qxVmXhiGt0ivJHW/dKnpCmzkLzIeio5rpMOJJUAg3YeyBfyAlYPiLYI
 XU/os/GeI5EL2J7dXnAw8jZbCgcB8Xm5DbhAGjBKvEJQofNn155WnCkxdyNKNGiGJ/5Hy0huL
 Bxoe42rQKzjxu2zf37RzW+e7z4rduvpfmIM3l1Rm67k5xjNwRVj9l5vqKg4xARAzimtM/0fqA
 3qpWIjthpmYBJ+vhGDTK+jkNo68RTfVch5BCyRigSKx6Augma5YPItmSyKB/mnbT8C/hq1R79
 gP0FLg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for checking the "git rev-parse --parseopt" flag "!" and
whether options can be negated with a "no-" prefix.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 t/t1502-rev-parse-parseopt.sh | 44 +++++++++++++++++++++++++++++++++++
 t/t1502/optionspec-neg        |  8 +++++++
 t/t1502/optionspec-neg.help   | 11 +++++++++
 3 files changed, 63 insertions(+)
 create mode 100644 t/t1502/optionspec-neg
 create mode 100644 t/t1502/optionspec-neg.help

diff --git a/t/t1502-rev-parse-parseopt.sh b/t/t1502-rev-parse-parseopt.sh
index 813ee5872f..0f7c2db4c0 100755
=2D-- a/t/t1502-rev-parse-parseopt.sh
+++ b/t/t1502-rev-parse-parseopt.sh
@@ -3,6 +3,22 @@
 test_description=3D'test git rev-parse --parseopt'
 . ./test-lib.sh

+check_invalid_long_option () {
+	spec=3D"$1"
+	opt=3D"$2"
+	test_expect_success "test --parseopt invalid switch $opt help output for=
 $spec" '
+		{
+			cat <<-\EOF &&
+			error: unknown option `'${opt#--}\''
+			EOF
+			sed -e 1d -e \$d <"$TEST_DIRECTORY/t1502/$spec.help"
+		} >expect &&
+		test_expect_code 129 git rev-parse --parseopt -- $opt \
+			2>output <"$TEST_DIRECTORY/t1502/$spec" &&
+		test_cmp expect output
+	'
+}
+
 test_expect_success 'setup optionspec' '
 	sed -e "s/^|//" >optionspec <<\EOF
 |some-command [options] <args>...
@@ -278,4 +294,32 @@ test_expect_success 'test --parseopt help output: mul=
ti-line blurb after empty l
 	test_cmp expect actual
 '

+test_expect_success 'test --parseopt help output for optionspec-neg' '
+	test_expect_code 129 git rev-parse --parseopt -- \
+		-h >output <"$TEST_DIRECTORY/t1502/optionspec-neg" &&
+	test_cmp "$TEST_DIRECTORY/t1502/optionspec-neg.help" output
+'
+
+test_expect_success 'test --parseopt valid options for optionspec-neg' '
+	cat >expect <<-\EOF &&
+	set -- --foo --no-foo --no-bar --positive-only --no-negative --
+	EOF
+	git rev-parse --parseopt -- <"$TEST_DIRECTORY/t1502/optionspec-neg" >out=
put \
+	       --foo --no-foo --no-bar --positive-only --no-negative &&
+	test_cmp expect output
+'
+
+test_expect_success 'test --parseopt positivated option for optionspec-ne=
g' '
+	cat >expect <<-\EOF &&
+	set -- --no-no-bar --no-no-bar --
+	EOF
+	git rev-parse --parseopt -- <"$TEST_DIRECTORY/t1502/optionspec-neg" >out=
put \
+	       --no-no-bar --bar &&
+	test_cmp expect output
+'
+
+check_invalid_long_option optionspec-neg --no-positive-only
+check_invalid_long_option optionspec-neg --negative
+check_invalid_long_option optionspec-neg --no-no-negative
+
 test_done
diff --git a/t/t1502/optionspec-neg b/t/t1502/optionspec-neg
new file mode 100644
index 0000000000..28992ee303
=2D-- /dev/null
+++ b/t/t1502/optionspec-neg
@@ -0,0 +1,8 @@
+some-command [options] <args>...
+
+some-command does foo and bar!
+--
+foo		can be negated
+no-bar		can be positivated
+positive-only!	cannot be negated
+no-negative!	cannot be positivated
diff --git a/t/t1502/optionspec-neg.help b/t/t1502/optionspec-neg.help
new file mode 100644
index 0000000000..591f4dcd9f
=2D-- /dev/null
+++ b/t/t1502/optionspec-neg.help
@@ -0,0 +1,11 @@
+cat <<\EOF
+usage: some-command [options] <args>...
+
+    some-command does foo and bar!
+
+    --foo                 can be negated
+    --no-bar              can be positivated
+    --positive-only       cannot be negated
+    --no-negative         cannot be positivated
+
+EOF
=2D-
2.41.0
