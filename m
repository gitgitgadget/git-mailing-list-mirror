Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 203A6E75433
	for <git@archiver.kernel.org>; Tue,  3 Oct 2023 08:55:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239450AbjJCIz1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 3 Oct 2023 04:55:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239261AbjJCIz0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Oct 2023 04:55:26 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781A3A9
        for <git@vger.kernel.org>; Tue,  3 Oct 2023 01:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
 t=1696323321; x=1696928121; i=l.s.r@web.de;
 bh=Upl80EkYSFTT9tVQe4O1AzRTjRc2KeFYOocoUClxa/k=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=jagNo0BKr6sNXbDsQ5ds2Q/1NOxLPHaQE3Kd2tqSCiGVc1drHugO5ECdFtQi8V2gPeepZB0DATw
 y/eFznX4clKatUYJuZ31KNE1YH0rG3I8ifILMSHq07KupRtYNmPnBiPi6pXgKm2xYVP1F51/WyMM2
 eWH20aGZKiirmv7FOWQzx5uuJl11IEf7geU7CxaDiqL5lYpxlwsQW2jbusHnNDEu0vQ+No+9N/b8O
 M58MtJzt37dHrZg6DTNYkn2Pa2UmJJ2SJr5+xvBnZMTKTCEgcq8OkIED6xFnWlFx1eZjfMNwXZ9It
 JzIif0TM4Rb1DLsD/fVcMF8E50Yt0kqQH13A==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.147.159]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mmymz-1rVlIE38q7-00joQD for
 <git@vger.kernel.org>; Tue, 03 Oct 2023 10:55:21 +0200
Message-ID: <ebcaa9e1-d306-4c93-adec-3f35d7040531@web.de>
Date:   Tue, 3 Oct 2023 10:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] parse-options: drop unused parse_opt_ctx_t member
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:qkgjryxFtIoEO97n3LAatM+msL44uNL+vgGzJXx3dpEZOf7rP6o
 kC6WnbA/sJchoi3Y7Fg48hAu7them3osEceeeOeVCVf16ULnGCset2g/10LJB6oND3rCsyW
 XrkCkRVspWFGiver8X3vAAxReek5H04ep/qLLpGCWXg7/S+DrgMtl3OR5UelBJ3DDcKqnnK
 FCcASJH5/DKZrmsFnJJPg==
UI-OutboundReport: notjunk:1;M01:P0:+P1d5x054WM=;9iuulAe3JnYhJ/CQz4KYMA9yw2d
 knfLJPgI1O0eH58XTPynDUytbZFQB3f/gJ3hnpEWPk33jpFF6qhs3QkNK7PDim93+cYCnO1oA
 fSSxqJXktHvZjIVhe2/veUuI5Mdofs0mdfIjlD4TjqpDX1iWhR/aq8wlmB9SQ+fJ2t0B04iAm
 2X3aPukqcO3l9lY2dtfLtzwJRDD425ST+Bcz3QqUjcnu76yhaVR1Di2F0OR9qJ8j2qVWNgWAa
 OixdrvFe0AtiVbFNGBfQz17TiLXzHpZSAzfgG9yc79dyDj7XVMy+kV5Yo2hlEJQ3E0qFZ5F/I
 FnJktH0QtlZnlkWiPEdmEbcJxIhO6fik3fLBQ7IMN1LF45RiavxAuCTH9w0F7wHJtpaKTap/I
 fS4OehhfejO47/HHq9l1vQ9Yrm949bHLHGqUlx3bH2OZgC2I2ClxcFHkja9AfpEgpv5yCg7fk
 p3v6slX+NA1/Tl8DTGqW5fWKe20Ua0xs7iWecXsiDJBr5DkR5sc5eq7lGl4vOPnJ9MeWNc4O+
 mULDenTvlhcFMSEWB2QRr/le46MzMMK9y0kgWCtO4g5oRid9BOna+6hqcH8x31EgpKaC3wlDy
 WzQ1D4h0MwKI9Kv9FhgSDRhGBnmuwKl02XcVk8MeN41WHaSlQ11YNviSHv6iT7QQPiWddBdtt
 gw9HAFw5XJP4seVPuXXwqfw3A7MkaHVlbCPHam8KGB2cJUC6+jmB6Fwulf2s5JefLGV/oYrCX
 SQKTqoxarUgWvfjLyhAvlgUnsO2yLSgn4+4E+kEz+ABYcJEXpB+SXl1RM5cA0rDax912xSZ9M
 Ltb2/h40NAPYO5FC2RR2aCg+WeqGxZ1f7TkFk/3NxNxrlmFCJ6ixnF3v0S2HbVsqyRleOkOpT
 jVlfMU9rdjBui//tHIfH+ctcV+JXdKSH3XlA0Q17PDPSNrXMtVs6//SSoyWVCWdrIwIhOWVGl
 Yr9ylA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

5c387428f1 (parse-options: don't emit "ambiguous option" for aliases,
2019-04-29) added "updated_options" to struct parse_opt_ctx_t, but it
has never been used.  Remove it.
=2D--
 parse-options.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index 57a7fe9d91..4a66ec3bf5 100644
=2D-- a/parse-options.h
+++ b/parse-options.h
@@ -459,7 +459,6 @@ struct parse_opt_ctx_t {
 	unsigned has_subcommands;
 	const char *prefix;
 	const char **alias_groups; /* must be in groups of 3 elements! */
-	struct option *updated_options;
 };

 void parse_options_start(struct parse_opt_ctx_t *ctx,
=2D-
2.42.0
