From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 13/15] add -u --verbose: mark "remove '%s'" for translation
Date: Mon, 21 Feb 2011 04:26:25 -0600
Message-ID: <20110221102625.GN32137@elie>
References: <1298143495-3681-1-git-send-email-avarab@gmail.com>
 <20110221040012.GB26968@elie>
 <20110221101229.GA32137@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:26:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSyS-00066u-Gb
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:26:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755315Ab1BUK0c convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Feb 2011 05:26:32 -0500
Received: from mail-iy0-f174.google.com ([209.85.210.174]:54933 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755118Ab1BUK0b convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Feb 2011 05:26:31 -0500
Received: by iyb26 with SMTP id 26so563440iyb.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 02:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=INLxqbc8lmLI/hSAxaPwlhAHu4m1DejDBZT75AENRis=;
        b=kh4LvmO5O/KHv0L2hxXXHApPJvHwxtoV89SnD3tKQONgVnjgqTtMZwxswC/wH1CLhZ
         k/XXoRnvBBtoBdgXUA14DDLQt0GyErYfYrzjZeoWnkempUKbk6EdVDUMxNp/5Z4yfA7C
         GlXnRXg0AqLo1u4Hdk6ZvotsyFXe86iKl8tng=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=f2rYc2qVfv+NIDDcrpTlTlKj8XXBPnQM3wFkjOdXrHzowbTf5/PPMwvDhMEwx4MLYV
         PlqwfmYnZbvuqeBIdDI3xpEzDy5JpgzjgV2w1qeluqK4dUE7Et2mFPZU29+OjxvLFjHn
         HS+iqRX4Fa0a7lnyaxL6OAC2HJYsVGFLrawzM=
Received: by 10.42.220.132 with SMTP id hy4mr1710768icb.297.1298283991189;
        Mon, 21 Feb 2011 02:26:31 -0800 (PST)
Received: from elie (adsl-69-209-53-52.dsl.chcgil.sbcglobal.net [69.209.53.52])
        by mx.google.com with ESMTPS id i16sm5055362ibl.18.2011.02.21.02.26.29
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 02:26:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110221101229.GA32137@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167469>

=46rom: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Date: Sun, 19 Sep 2010 14:48:59 +0000

=2E.. and skip the corresponding test when output is not in the
C locale.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/add.c         |    2 +-
 t/t2200-add-update.sh |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index ffbd459..33b9970 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -74,7 +74,7 @@ static void update_callback(struct diff_queue_struct =
*q,
 			if (!(data->flags & ADD_CACHE_PRETEND))
 				remove_file_from_index(&the_index, path);
 			if (data->flags & (ADD_CACHE_PRETEND|ADD_CACHE_VERBOSE))
-				printf("remove '%s'\n", path);
+				printf(_("remove '%s'\n"), path);
 			break;
 		}
 	}
diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 0692427..856e7da 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -111,7 +111,7 @@ test_expect_success 'touch and then add explicitly'=
 '
=20
 '
=20
-test_expect_success 'add -n -u should not add but just report' '
+test_expect_success C_LOCALE_OUTPUT 'add -n -u should not add but just=
 report' '
=20
 	(
 		echo "add '\''check'\''" &&
--=20
1.7.4.1
