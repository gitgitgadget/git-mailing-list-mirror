Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3DD7C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:55:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BF5323105
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:55:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbhAFKy6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 05:54:58 -0500
Received: from mout.web.de ([212.227.17.12]:41215 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725828AbhAFKy5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 05:54:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1609930383;
        bh=m6FL3O7mfX+nH2Y3Vnc12NjZ+1/fyijD+IlFJ6a2X34=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YNm2ohoaEsj8lNYoOOw2xl2JuiWO/PH5aXvgDoZXyQAEadSFXdQEb/2MAqBpQLr3s
         6/5Pan6BcgeY2E4DBuf6zoaH5CGuBCfdSPPdsxugMCxYizcUBIhvzpqwSwtQYxm+As
         0+CpCBU/5qs4MMWnwxne9PVWma00gbWWmyBq/nUs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from susi.lan ([195.198.252.176]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LxODe-1jvoNo3ug6-0170J8; Wed, 06
 Jan 2021 11:53:03 +0100
From:   tboegi@web.de
To:     git@vger.kernel.org, johannes.schindelin@gmx.de,
        Dan.Moseley@microsoft.com
Cc:     =?UTF-8?q?Torsten=20B=C3=B6gershausen?= <tboegi@web.de>
Subject: [PATCH/RFC v1 1/1] git mv foo FOO ; git mv foo bar gave an assert
Date:   Wed,  6 Jan 2021 11:53:02 +0100
Message-Id: <20210106105302.16878-1-tboegi@web.de>
X-Mailer: git-send-email 2.28.0.97.gdc04167d37
In-Reply-To: <xmqq7doqwvzx.fsf@gitster.c.googlers.com>
References: <xmqq7doqwvzx.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:MLlbLueue7nmDBkmjLjJoJqlAEA/VdzwG/bgi4Rf6Mc+ctsqxxC
 /5219L6I346ug0fSWtaUHL7oER0nhMDag6a8wgKDNtxHi+npyoxZIc20XCOXEUOW79maopu
 gI61M7w/QDZZYNl72T0Uq/0B5P+IXD+CF79xneWn32nbMwl+iouvkHCT0kwMSYb4t0Beplu
 5wmM1hy9zlpmigB3dXr7g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9lAwZUOO0pY=:3aXlieThNfdNr576KHaBhf
 5U0ctyIjW8fL8fV9fvLP4pUdA7E3vhEPW9sY3mgL2OJE6OMzt426YyapW59nYzQuLvaCKFHZj
 i7CeqIqEX2urMKeyQ0du9MhKinonhjiMsxVt3tH+5QJ467w1767l5ypTj0+9RmCxSVYUpeoRy
 whENF9TUE7JFTIX6sksE9rr3rNg3JOJheex26jF5xShhA4MhSIYmMg/ENjwkOzt7mVzclz7px
 lxTZvnNn+CbVFdsuZU5w+04wEQRd6Q5GlQMnPS19doZyQYuDg5ldIoXZWoSaw2Wnf3fNYNhOw
 u5jBsagtzTM8FmbsCsKr7wbakWkaCEY/IRAFhOUyKrI5qn1nN0adhPGXvVvrwTEHG1acZMESB
 IZcFsQM9uT6JkEl4aW69k2QY9ZWnl60fzgvL/MFmXclvVwNJ6pgHIb6p7rTUC1LKC6HIWwIKP
 no6DXEWzUISSLd7LfV9aWSEdlQkL/lonupNVCw278Maok0bVJUzNHcWqf8GuZ3zcuh90GaMkG
 PICkwVDs7Uu/0m82DwVAZb5aVdkoyY26rSTCzkweHostADVtjm8/gDA8ux6PcgmRDTTJ0vSo3
 oQFexSvpteV+E7VDjuhy28qqAuVaJjB/qEDdWoE3/d+VumJxQgolLEe3VNxnTbkW/7YQccmiq
 XxP0Cgjf4xCd+sP/8uee2x3xp1rjHIhBO8uAKkJ4aQQqWXRsR1jqEi2F2xHqPUB4JZJE8plt4
 ee3Pc/L7UnqmPm3gb82j7nzTpw8PphWw8GQ8ifEowJm39PDmsyOs4xJuW+mjdVpZwVOZZKr+5
 2klj/066WTEz4B3bCiFiYRlCYtTsqHsvLqFy/WwFBrGDKDjHyIr3uL7203qEdwulohbg1kfga
 40AUUaLB3EicS0MQug0A==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Torsten B=C3=B6gershausen <tboegi@web.de>

The following sequence, on a case-insensitive file system,
(strictly speeking with core.ignorecase=3Dtrue)
leads to an assertion, and leaves .git/index.lock behind.

git init
echo foo >foo
git add foo
git mv foo FOO
git mv foo bar

This regression was introduced in Commit 9b906af657,
"git-mv: improve error message for conflicted file"

Don't check if the case-insensitive version is in the index.
In the sense of 9b906af657 supply the user with a more helpful message.

This fixes
https://github.com/git-for-windows/git/issues/2920

Reported-By: Dan Moseley <Dan.Moseley@microsoft.com>
Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
=2D--

Note:
There is an ongoing effort to replace cache_file_exists() with
index_file_exists().
So this patch may need to be re-done.

Note2: @Dan Moseley: Do you want to continue with this work ?

builtin/mv.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 7dac714af9..8572a5dae0 100644
=2D-- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -221,8 +221,11 @@ int cmd_mv(int argc, const char **argv, const char *p=
refix)
 				}
 				argc +=3D last - first;
 			}
-		} else if (!(ce =3D cache_file_exists(src, length, ignore_case))) {
-			bad =3D _("not under version control");
+		} else if (!(ce =3D cache_file_exists(src, length, 0))) {
+			if (cache_file_exists(src, length, ignore_case))
+				bad =3D _("not under version control (upper/lower mixup)");
+			else
+				bad =3D _("not under version control");
 		} else if (ce_stage(ce)) {
 			bad =3D _("conflicted");
 		} else if (lstat(dst, &st) =3D=3D 0 &&
=2D-
2.28.0.97.gdc04167d37

