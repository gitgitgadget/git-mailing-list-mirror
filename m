From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 12/15] add: mark "did not match any files" for translation
Date: Mon, 21 Feb 2011 04:25:56 -0600
Message-ID: <20110221102556.GM32137@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
 <20110221101229.GA32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:26:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSy5-0005wg-C6
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:26:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755291Ab1BUK0F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 05:26:05 -0500
Received: from mail-iw0-f174.google.com ([209.85.214.174]:47979 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118Ab1BUK0D convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 05:26:03 -0500
Received: by mail-iw0-f174.google.com with SMTP id 8so1734490iwn.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 02:26:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=FXgbUpBoy6FozbX+q9xRIG3Noaql2Zb4TnI1Fql+83Y=;
        b=ATDFCKeWrcbkT/lAfqFXEugebWUBkalcU1Jm3MxZmWKA7jlLqkVyZ9kl6a0jFhusXx
         6Csc3p/0Cek7b/gb1xsWCxo7g87CmXTAsvugJKEfu4b9WWPb/Odt0b+myGT4pYJbSBUv
         jW/CX32KPI5OiJOz+Y1HdVuBbxK/rqsd5xrGM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=uz1aKYxOhnv52VebbplsZg3OzDbMS7uTNSJ/l+kEm/YarJ+1ZZeiA6yLXgFrOSOCFI
         6VHOMmsvxQnbpJOXW6jJ/fr1NLQghYAvFK+40o4B2EqW8l27e3dppN2CEPDL5PdmN9Wk
         +VNRaEQw5/1bGKnPT7gW6xQcsj0gmjqQbPU00=
Received: by 10.231.161.15 with SMTP id p15mr1020843ibx.104.1298283963118;
        Mon, 21 Feb 2011 02:26:03 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.ameritech.net [69.209.53.52])
        by mx.google.com with ESMTPS id u9sm5047580ibe.8.2011.02.21.02.26.01
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 02:26:02 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221101229.GA32137@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167468>

=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Date: Sun, 19 Sep 2010 15:48:06 +0000

=2E.. and skip the test that checks for it when the C_LOCALE_OUTPUT
prereq is not present.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/add.c  |    2 +-
 t/t3700-add.sh |    8 ++++++--
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index 21776ac..ffbd459 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -451,7 +451,7 @@ int cmd_add(int argc, const char **argv, const char=
 *prefix)
 					if (excluded(&dir, pathspec[i], &dtype))
 						dir_add_ignored(&dir, pathspec[i], strlen(pathspec[i]));
 				} else
-					die("pathspec '%s' did not match any files",
+					die(_("pathspec '%s' did not match any files"),
 					    pathspec[i]);
 			}
 		}
diff --git a/t/t3700-add.sh b/t/t3700-add.sh
index ac115ed..7de42fa 100755
--- a/t/t3700-add.sh
+++ b/t/t3700-add.sh
@@ -268,8 +268,12 @@ test_expect_success 'git add --dry-run of existing=
 changed file' "
=20
 test_expect_success 'git add --dry-run of non-existing file' "
 	echo ignored-file >>.gitignore &&
-	test_must_fail git add --dry-run track-this ignored-file >actual 2>&1=
 &&
-	echo \"fatal: pathspec 'ignored-file' did not match any files\" | tes=
t_cmp - actual
+	test_must_fail git add --dry-run track-this ignored-file >actual 2>&1
+"
+
+test_expect_success C_LOCALE_OUTPUT 'git add --dry-run of an existing =
file output' "
+	echo \"fatal: pathspec 'ignored-file' did not match any files\" >expe=
ct &&
+	test_cmp expect actual
 "
=20
 cat >expect.err <<\EOF
--=20
1.7.4.1
