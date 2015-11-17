From: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH 2/5] parse-options: inline parse_options_usage() at its only
 remaining caller
Date: Tue, 17 Nov 2015 11:25:27 +0100
Message-ID: <564B0097.9050206@web.de>
References: <564AFF32.1030406@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 11:26:12 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZydSS-0004Qj-SV
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 11:25:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753579AbbKQKZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Nov 2015 05:25:45 -0500
Received: from mout.web.de ([212.227.17.11]:57826 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753555AbbKQKZm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Nov 2015 05:25:42 -0500
Received: from [192.168.178.36] ([79.253.153.213]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0Lky6L-1aYngP41Zd-00alWI; Tue, 17 Nov 2015 11:25:33
 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <564AFF32.1030406@web.de>
X-Provags-ID: V03:K0:OE+WI3kOYW/XVh+miELpgQXwt+MQWtXpIhYtqevu0beJi3Jc6cM
 YrwMyYvoIkTGrB70Hvx3uL/+keimaJ4OKUonWJwS2aXIfn2BsWZXAoBiBAFpo5UEy3OaYaT
 7WA/Z60+0Fq9ns5GoilO4urSpiDNOowg3FlHgEO7qSAftZgDITSTmiAkFsepIuF1cYXtnYW
 9QMDaarduuD9lfPGfkGYg==
X-UI-Out-Filterresults: notjunk:1;V01:K0:US+znmdQ3zw=:+q2YmN4ikxmjl2Y9xGHkSt
 eZoB/0+4oQoCZlGjmTxmeAXXeaTVnMQC9vMX9Rp2TwmW66Ks89AZsTT1SvP9Dl2YfCMIGA7mi
 G92zB3B0yjByVyvQOzvmH5DKj4Ar9p0wxnV5GkSw0iZBV3OSlFZHjo9qJvmeu4UfqKTtPYTAF
 74OWyG7+AGJ0DqTaTHFsip0c1v6nhnlPXy3QYhGiTiOjekwtv9inVqdOK9+r3Coq5UW7u7e3Q
 uvYarh30WEOKCCLmmiTxkIUTNGD+y9vfSRefdtHYOzkaaStfUpybaWDsmjjl9xaQsl/kTbHOg
 x82SYmkIWuOb934LZW3JSTY94glEKMvJnZmD/1SjedElft2asESQKwET2QMetmvkxpoMV18xR
 lA1YSTpRSJGjhc72XESuHFp+hEosGJV85f9jmIHzVJLOHKHE7HdiTSxI6hl4h6fA8U8gCDDxK
 kfrize923ilc41Q1Glqmz/nwy6INw+UYpnltpkYtURAoEtUzo3nJ7RP037k4FKU0U/G7oS0rg
 RsEDzaaQflq1Fa+0y8x9HOGQiy6LkldHjTOjQAXRqKJsggMlK06Af2tcSS89j7vrx8P0veyu+
 w1POqM/YVTolK7DhB0tV7qONdAwz3PlGvca2q18K+TsTTSMU333iykMDgvrk7pfPWleE6nHYu
 Yag32Q6OCc3rvfRM79tlJYXUw2XYoMt2rOfHIJHu8RcGn/7cWvtrQ1/znYdRQTAJVN0nO/J4e
 +OwhQb58nWt+CXLl6PiREj3aWWatyqMjYTCaait1zziMAC64XH7FdXY9El6iu/NBwL6pyTrC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281396>

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 parse-options.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index f0b6d9b..4863966 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -5,10 +5,6 @@
 #include "color.h"
 #include "utf8.h"
 
-static int parse_options_usage(struct parse_opt_ctx_t *ctx,
-			       const char * const *usagestr,
-			       const struct option *opts, int err);
-
 #define OPT_SHORT 1
 #define OPT_UNSET 2
 
@@ -516,7 +512,7 @@ unknown:
  show_usage_error:
 	err = 1;
  show_usage:
-	return parse_options_usage(ctx, usagestr, options, err);
+	return usage_with_options_internal(ctx, usagestr, options, 0, err);
 }
 
 int parse_options_end(struct parse_opt_ctx_t *ctx)
@@ -662,13 +658,6 @@ void NORETURN usage_msg_opt(const char *msg,
 	usage_with_options(usagestr, options);
 }
 
-static int parse_options_usage(struct parse_opt_ctx_t *ctx,
-			       const char * const *usagestr,
-			       const struct option *opts, int err)
-{
-	return usage_with_options_internal(ctx, usagestr, opts, 0, err);
-}
-
 #undef opterror
 int opterror(const struct option *opt, const char *reason, int flags)
 {
-- 
2.6.3
