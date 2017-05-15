Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB,RP_MATCHES_RCVD shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A18D201A7
	for <e@80x24.org>; Mon, 15 May 2017 15:24:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966113AbdEOPY2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 May 2017 11:24:28 -0400
Received: from mout.gmx.net ([212.227.17.20]:58490 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965907AbdEOPYV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2017 11:24:21 -0400
Received: from virtualbox ([37.201.192.198]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0MHokD-1d8uPK1tgD-003aSS; Mon, 15
 May 2017 17:24:15 +0200
Date:   Mon, 15 May 2017 17:24:14 +0200 (CEST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 2/2] mingw: Suppress warning that <commit>:.gitattributes
 does not exist
In-Reply-To: <cover.1494861793.git.johannes.schindelin@gmx.de>
Message-ID: <7db27408616e21be1d917165d04a1e69adc0db04.1494861793.git.johannes.schindelin@gmx.de>
References: <cover.1494861793.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:pT+2QmT3KGvBssrN2UTYboHGPqWYWHc2cDy7xgzcFcWKCPwwc70
 KFK8g6FtRU84zJyZZtd8SnDKSRbxWy/OvncV4cjOz3jDxBns9ywKS+tcQt2xqsqz6w5O14f
 8TXlr32pA683VpLa8PNBs2l1CbESwJIDLELi96/qs53eUQzWM059gsm7ttRsmEV5yW5SZ9y
 YKPdzF2TPhRVYQLn6xw/g==
X-UI-Out-Filterresults: notjunk:1;V01:K0:6cv4AAY22Eo=:HoCbeW4jSwhB2nmXQWrnaC
 WVF4BZoqp3bVkVgxdEuGxhB/UsAqZe0kN6sgYYGbeCGTCoP7IvHu+3601OJtVtgvbN55npU37
 15AIkvB1Pr4xipxZzIQDknL771kPIQ25k9mEZ8If5LlsOWrQKmxT1uF0OkTK9uJTeF25yuqGu
 8DYBtAuJEkMl6ZShj0R6dshPhtWn4Y/Q4QRLz3lpueMWJjoHO2zXWJ+mHI9j5nIOMu0X9Hna+
 cApsEXdxyxB6DWXbPbEOCyC2VEGtOf+JCvqWqgS8oP/fnXb7QfGSrkpvGFJQntYRrzrEOWddV
 /+XbP7nawEJJgXUWXm41bK+GJmFVMvCaGAB6WwtQRbPGzV9ts8Jkq8J+korJPHsP+q2Fz9uAS
 K6KFYE6CiTqpUkDIc63g2ceviEoFacnG8F0Qgsa+bJIoesCVS0f3w+4MvaHttiacWBRDJYu7Q
 0EDuqLUgtBNGKonrScnnu/IPnI5eWnBBX3L3Tb/K0cA8e7e5ZyZgntEtbQJrgvC0suSI2HjKP
 2tTTjeYbZPB2HWa9Q/jl8vGLTO4loIIBjhSZ6MTbvgp1fhF7fJBrOUcuKGNqf0EtFFRvQiFvH
 53Ke/v6Y5v2BSjoVgxUePnWNrWGJY+NJcKQUNpihU/nZwm9Gr/q36AWjad8vr34xIlSdS8yTh
 vJaGT4B3JQTU/UvN1kn9qVs+UKPN+C4oUU7yfSMZ2eYNgA1Vvsi3aXDh9gLgA5f/pnqlm0OLz
 WdH5D1+A55jY9cZd3rrAwYCJQLC08KpowFM4fi897i2otWayM/OeejI+ilRYcF5A+pP2QVNb/
 ey3b9vj
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Windows, a file name containing a colon is illegal. We should
therefore expect the corresponding errno when `fopen()` is called for a
path of the form <commit>:.gitattributes.

This fixes the symptom reported in

	https://github.com/git-for-windows/git/issues/255

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 attr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/attr.c b/attr.c
index 7e2134471cb..a0297088633 100644
--- a/attr.c
+++ b/attr.c
@@ -726,7 +726,7 @@ static struct attr_stack *read_attr_from_file(const char *path, int macro_ok)
 	int lineno = 0;
 
 	if (!fp) {
-		if (errno != ENOENT && errno != ENOTDIR)
+		if (errno != ENOENT && errno != ENOTDIR && errno != EINVAL)
 			warn_on_inaccessible(path);
 		return NULL;
 	}
-- 
2.13.0.windows.1
