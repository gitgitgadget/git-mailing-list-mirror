Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B57F7200B9
	for <e@80x24.org>; Thu,  3 May 2018 15:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751447AbeECPax (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 May 2018 11:30:53 -0400
Received: from mout.gmx.net ([212.227.17.22]:49329 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751141AbeECPat (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 May 2018 11:30:49 -0400
Received: from virtualbox.mshome.net ([37.201.195.116]) by mail.gmx.com
 (mrgmx102 [212.227.17.168]) with ESMTPSA (Nemesis) id
 0MfjJY-1f2Feb4BgS-00N7p8; Thu, 03 May 2018 17:30:46 +0200
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Thomas Rast <tr@thomasrast.ch>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 06/18] branch-diff: right-trim commit messages
Date:   Thu,  3 May 2018 17:30:45 +0200
Message-Id: <303419c56c4ea7d59381f48b3b613418dfd0043b.1525361419.git.johannes.schindelin@gmx.de>
X-Mailer: git-send-email 2.17.0.409.g0f525fc0ba7
In-Reply-To: <cover.1525361419.git.johannes.schindelin@gmx.de>
References: <cover.1525361419.git.johannes.schindelin@gmx.de>
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:sJaV8IvILONGHaJGVECIPp8Ei6nF5acKGshZODagPGjMkk5+TMa
 CTgnJ2Gd8io7btytaTDKBPmxUhR7qMdqV1OvvF60CWc+1uGbyTXbIcfgZSYAAaukw0Sr0Ku
 P8Z7gA4Eo/Ks/QfccMEJfH+l6i2SaRTTUGRXR78ak5Hp0JSCRnPlE89KRji8dkTHGBZ+R2p
 YossmLBV3JXYMzo3WpOGw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:2Jx+bi8X63s=:rBcQ3wBVinilxdd20Zyu1o
 aP84HGlrusOcghRgybpBc3ywMC2J9AfLjV4jKJ1ty8UrW/RoJNagk82w7UMWF7XVot64gQkcn
 Q9mVNMwLv3byek8IqRJVR25jX8E4lKZQSKuIpP2Nt+wlQUNydhAtvRIk9Zm3hpfsMC6TCRS2X
 kGLpqZypQol8C5LNOEMTJ9DBYbAdeJeCxvykO+a/em1w3yP4MEmnKx1RmTvTXTY5tO6iJaCYa
 i11dkKrizn7DvvJPitDKvPVy5wYT8OTFMPZtRYgmrDZ8dQpGTetlWG6vgV4IdRfTMuS/0/RbF
 r0bWActw+P1ig8r5yjCs4la/s+Duj4iANT5rNxpz+CKVNeELsBkLqx10iog+cIS71iYQ5PKux
 fXJUb/hVvhNyxIZQ4PH4gVeAOmxO3itG1j9YBNh36792cm/I76xzAHZn/Au5iWUV6ZT0ekxb1
 tzj6YCvtf6eivWDk13sWfn23QOZGhaRGRzoECVmvKXvuuuQLLxmTRJOwHTHa8E4SFz6UCpSTs
 VSzut6Q4nNxBl4/QGnSH4mMWzliqEfdwc2kBJcykLuHP8r9pC0M9i+2d4b5whlDD0KMLG6MOl
 Dd6ElrrcuL5ZN+Lw3JhnpsZNg2gTX6+UyvXSNYm7UHGzCPBj3Uy1wxYDGWP5OV+kMLbyEY1he
 VoJbx3aWG3l97sOtcZlqEmhve8xuhmjIpmPHBqAQi7cDTTdc+PVjUSnlaf1tWCOMZ+ChPmEga
 lUhteJlLlIaZkz+BJSkvOjW9C39UJIfoNIEdsTXn6pK0nCl6FA1yv9+r0RN6BbB4UsYyyKxLr
 lMR9VYt
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When comparing commit messages, we need to keep in mind that they are
indented by four spaces. That is, empty lines are no longer empty, but
have "trailing whitespace". When displaying them in color, that results
in those nagging red lines.

Let's just right-trim the lines in the commit message, it's not like
trailing white-space in the commit messages are important enough to care
about in branch-diff.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/branch-diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/builtin/branch-diff.c b/builtin/branch-diff.c
index 3b565a37492..9dc581087bb 100644
--- a/builtin/branch-diff.c
+++ b/builtin/branch-diff.c
@@ -102,6 +102,7 @@ static int read_patches(const char *range, struct string_list *list)
 				strbuf_addbuf(&buf, &line);
 				strbuf_addstr(&buf, "\n\n");
 			} else if (starts_with(line.buf, "    ")) {
+				strbuf_rtrim(&line);
 				strbuf_addbuf(&buf, &line);
 				strbuf_addch(&buf, '\n');
 			}
-- 
2.17.0.395.g6a618d6010f.dirty


