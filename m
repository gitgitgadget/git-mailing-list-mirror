Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD4B11F424
	for <e@80x24.org>; Thu, 21 Dec 2017 21:26:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755365AbdLUV0v (ORCPT <rfc822;e@80x24.org>);
        Thu, 21 Dec 2017 16:26:51 -0500
Received: from mout.web.de ([212.227.17.12]:63690 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753593AbdLUV0u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Dec 2017 16:26:50 -0500
Received: from tor.lan ([195.198.252.176]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M1o86-1fHUh81CNG-00tlZ3; Thu, 21
 Dec 2017 22:26:48 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, Johannes.Schindelin@gmx.de
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH v3 1/1] check-non-portable-shell.pl: Quoted `wc -l` is not portable
Date:   Thu, 21 Dec 2017 22:26:46 +0100
Message-Id: <20171221212646.24461-1-tboegi@web.de>
X-Mailer: git-send-email 2.15.1.271.g1a4e40aa5d
In-Reply-To: <xmqqh8t2ckgw.fsf@gitster.mtv.corp.google.com>
References: <xmqqh8t2ckgw.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K0:R+KChyDp4wyA6Q2FDBpt4BKHqqe+m0XpoTywtzv0NZj6lHqTedu
 sMRAKVprqJsxUT0tH5clWN0S5ygmHEb8DnIOvhIKKyvL+I2KvpWrvZVGA3XeFUkQPFPF+OS
 8eWh3Fj6UfDPHK+CyRAjMwT+PbxrHjFV2mGOE3XLs8yexWo4ubH/Hv/uGp+7WVF1wOIdQIs
 h/TCsxLQB94mZSLsle8YQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GJ7Xc7Gxj5E=:6jX/1pOplm1QhZuSBDNvIS
 OdcUv+sbQggZ6+RRrFIo/notaVwPfBdq7gh+qgZRsMfyT7jKd5IuG1TxEiyQNhjyslaYPpVQT
 77csLEA2wr5fFF2EN/5YKudzS1dd8f3OYZbbiLzfdL67u77VDqG24HPSFZUCjob9BD6BHd/EX
 ajzyRdy/h6gWgfC0gCax/UY5PFNrMkjSURgpFMvhXeimjjo6dn9HJXcsuoCOnuPyxmXCr+DIi
 uUpxaPUyvovac0St9AHtkMrlsTYrHaJk3Q5BInAS5jkmbhp5uqgWD/CgFs+xEDiAS5rcPojJp
 Pwpepo77zrcR/ryaohtBIXuZSAp+17DTgcB034aoqzOOEj53ChYpt6aIFA5VfrrIkXsY1/8KO
 0vpQjSYR6NHAqjXeXaJN4szsoeDtvPLJTp6U/v9nlZSpTbS1ZsIWZVysKfMdjmcTM1OXbFrB8
 AEZFZnKTAAmg+EaO9yXcmTfgGvjHzRBWIeyfGjiMgldhDep15RnmhKdvyccg9nPRuyu6+JsEb
 gc+WVJ/pamao8mrkbhTWqQCLv21r6MqiKw2P4x8EB9avRtvwsHybNUadNsPvgff5wVlvx/OUk
 OxLFqmN8++7WiHh5NUKSIOS8KlS861I8/o/N1F/pH0UQHbpd14HQHtvJ7ScnOYebFsIq8OCT6
 YgFQIK/+VYw5dcJoUzxxsAs30y/TJhS42eix+4NNbljhDUL1VyBaJ4N1dYqt0PNHeXI31Vixj
 S0TSAnJoTsJQqHLkUDZgdKf0rnZctuSqhSU38z+9IMteqMGKPyaE9MQsPJSKQH7QFZqwmqAgu
 JjCqn3H5QI01qDc8Dg8nSQrofUcF9x5Xvqxpr0zDZ9G8Sq186DoFVPggZT5IXJ67zb3P8Av
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten Bögershausen <tboegi@web.de>

wc -l was used to count the number if lines in test scripts.
$ wc -l Makefile
gives a line like this:
105 Makefile
while Mac OS has 4 leading spaces:
     105 Makefile

And this means that shell expressions like
test "$(wc -l <expect)" = "4" don't work under Mac OS,

Commit fb3340a6 introduced test_line_count() as a portable solution.

Add a check in check-non-portable-shell.pl to find '"' between
`wc -l` and '=' and hint the user about test_line_count().

Reviewed-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: Torsten Bögershausen <tboegi@web.de>
---
 t/check-non-portable-shell.pl | 1 +
 1 file changed, 1 insertion(+)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index 03dc9d285..e07f02843 100755

Use () around the hint.
Thanks to Eric for the sharp eyes.

--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -21,6 +21,7 @@ while (<>) {
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (please use type)';
 	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (please use =)';
+	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable (please use test_line_count)';
 	/\bexport\s+[A-Za-z0-9_]*=/ and err '"export FOO=bar" is not portable (please use FOO=bar && export FOO)';
 	# this resets our $. for each file
 	close ARGV if eof;
-- 
2.15.1.271.g1a4e40aa5d

