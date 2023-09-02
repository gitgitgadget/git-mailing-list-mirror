Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BA53C83F2C
	for <git@archiver.kernel.org>; Sat,  2 Sep 2023 18:55:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231916AbjIBSzA (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Sep 2023 14:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231451AbjIBSzA (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Sep 2023 14:55:00 -0400
Received: from mout.web.de (mout.web.de [212.227.17.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C9D3DD
        for <git@vger.kernel.org>; Sat,  2 Sep 2023 11:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=s29768273; t=1693680894; x=1694285694; i=l.s.r@web.de;
 bh=hhw6X9mWRn+rFx9mBiut9Q4wAHW0MbrTL4QaeW9oI3Y=;
 h=X-UI-Sender-Class:Date:To:From:Subject;
 b=MRFn1azyVdcjijPFA+QIJ1RnppRP8FbKq35kLP45cY6pWsyFfoca86fzMB3vy7xEo05dl94
 cQn12zdSinn4Gc1f9v2P/b/1zllgHwwV8mhJInij3L8benqMwI6dnsL5BnfTJL1tO6MtqEVZ+
 yO3o+uCQAywYrqXVRwb/xOcuNv43JR1vzmPnrk4KPZt/ghwo1i6b/fHfkcgoJMoOWjgXpSUHS
 h01oeQRLwl485FcIYhcILrfiexNOCEK8itqdyOMs230Lrc4DLuH0O/ojGLFz7YB3wgm3C9xwx
 nu5MOX2M0Z5QGCM/vozwObcNK/bhwbaJxn6oFsPtZTEL53CcRMuQ==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([91.47.152.246]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Myf3v-1pkIDL3IVh-00yXlS for
 <git@vger.kernel.org>; Sat, 02 Sep 2023 20:54:54 +0200
Message-ID: <4d2eb736-4f34-18f8-2eb7-20e7f7b8c2f8@web.de>
Date:   Sat, 2 Sep 2023 20:54:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Content-Language: en-US
To:     Git List <git@vger.kernel.org>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Subject: [PATCH] grep: use OPT_INTEGER_F for --max-depth
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MEnW7OH2Eett9V/kJa6BeBUc7u+PgKLUtngcryQEvkz3vdpJG8K
 +TlX/qkADrGdHGevdYB4g46GlrvT/9NdaZw5XXdY64qsnaQWPl5P7IE9/UcI+ZhzHSITte+
 jSmMMNYEXwUSgiQWRG0uuortYlV+50IujEHxQyhANu70oaSkTp53LZTZqnQtx6AkxzscT7z
 0LMISX773sjKjrtYmNHQQ==
UI-OutboundReport: notjunk:1;M01:P0:UAzDvq5YCV4=;vT40HcvvIkDMxB6MgwMRh9TeCs3
 QGHAfOVFD6fWNtqOZFB59pON3IwK8nN9EBCyXaVhJsOft2PojNamBmMrH9Z7ah9wbI/MAc92U
 vl0FhGC4zh0FOwk6UzWLhJebg0dWfTG+pI5ZTYYyzvmPL2sJ1GmQOQ18dZMtjbxeztG7kk7Ny
 szMk4l6FHxNIC2hkKEL465yIflqmYujxcfOI8ZcQOWdk/o19+oETjlGD+EjFc2H84dnqTvdx2
 4g7D3TelfeErckNfKFsYupqXuEHbTXD4kSFZSB10p6cgMDS+ICSxoen+GFVylySjI7TNuP9Bv
 2PhuSESypwbLGIIWARhhva8BvyTMN2eEd034O9zEV4HjvMuoxIfeiMhb/pOSr3l1Z01KHaYnH
 l9vaS2caUprTmtE11awGJiOfJmxvz18dx90nPRLLNJc32+WnRACQlgbIUpxv1vqAKUincsiiD
 g7uMdGSbQbexvY6R8/hL90zqPIzaoEe0cYncl3jUrw0c2vzGw0TDlLj/Iahx6zFPIb4OgoRYv
 kwOfUpW+AIv1LwU5mC8eh9ISjG0Z1ZWT14FXzxlutwWK/fxj1KVXOOoRoGeoY3ir3gOggTSTt
 5rXfMH++Xlno4r2+OJ5WxFDe26YasVYBYxLQnG9HPcSCpyOh/RslCfAp8k+GYkCI85RclNxpS
 AE1XtVCAqKuwTQIadRWoJ06lH5UVA2WfvaAHeWE4fPNdR0VkfhNYArbQrfwh6KCpZW+H4w4ip
 6a/n61t7+nzLdss7VJBdb9xp4LmetNbl40jXnC5UKnz/NpvNn6XC3BbvyebRSRfNlRZrJX52l
 SmqawlmOxmIUc9kQgG+V4XIzFO32y6gFgLdqCf7lnhU4pq3Nyxz27VsxXvlmoGBwvBwOdYgkC
 PmdAEnfA4+86u7evECqRuEvJ5BLNUehI6hw54deMo/n0fqKJHTnB+zczNqbT52wtNq3soLZs8
 voWjnA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

a91f453f64 (grep: Add --max-depth option., 2009-07-22) added the option
=2D-max-depth, defining it using a positional struct option initializer of
type OPTION_INTEGER.  It also sets defval to 1 for some reason, but that
value would only be used if the flag PARSE_OPT_OPTARG was given.

Use the macro OPT_INTEGER_F instead to standardize the definition and
specify only the necessary values.  This also normalizes argh to N_("n")
as a side-effect, which is OK.

Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
=2D--
 builtin/grep.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 50e712a184..f5f5f6dbe1 100644
=2D-- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -924,9 +924,8 @@ int cmd_grep(int argc, const char **argv, const char *=
prefix)
 			 N_("process binary files with textconv filters")),
 		OPT_SET_INT('r', "recursive", &opt.max_depth,
 			    N_("search in subdirectories (default)"), -1),
-		{ OPTION_INTEGER, 0, "max-depth", &opt.max_depth, N_("depth"),
-			N_("descend at most <depth> levels"), PARSE_OPT_NONEG,
-			NULL, 1 },
+		OPT_INTEGER_F(0, "max-depth", &opt.max_depth,
+			N_("descend at most <n> levels"), PARSE_OPT_NONEG),
 		OPT_GROUP(""),
 		OPT_SET_INT('E', "extended-regexp", &opt.pattern_type_option,
 			    N_("use extended POSIX regular expressions"),
=2D-
2.42.0
