From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH] t9700: Use Test::More->builder, not $Test::Builder::Test
Date: Sat, 26 Jun 2010 12:21:12 +0000
Message-ID: <1277554872-6402-1-git-send-email-avarab@gmail.com>
References: <1277401489-27885-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 26 14:21:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSUON-0000GB-3D
	for gcvg-git-2@lo.gmane.org; Sat, 26 Jun 2010 14:21:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754210Ab0FZMVi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Jun 2010 08:21:38 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:57121 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753485Ab0FZMVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jun 2010 08:21:37 -0400
Received: by wwi17 with SMTP id 17so1628593wwi.19
        for <git@vger.kernel.org>; Sat, 26 Jun 2010 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=0lWuNWsj9EO8or2PttlGyqN0nf4W6DseY1vvMl0o9uo=;
        b=rIxKzjLDOlj2CHu6Tg5Dhv/XxpHAY4HGCX8NbyBnNAsOIp2Jt2rI+8xOBWZJOqa+V8
         CMCjCySLMyVKQdOjavmrtwkSdsyJodYYCC4xEb5PDWykxc69WpkeoTUuqbdw/Z2mXSpF
         hhu1N/tNhNUsnXXCVjSeWNDrexS/oYlcfiZLs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=OgaPFBnpi/njjZmynjvdM4+zdk9xJz1TuiQvoDtnls28teGbVo9C2IlTB8EquP9e/7
         7ZO1YVZJ7NMu6kAs87r+2XvY9ApQ2ugIpC6mUVu+YaytxGdP8Wacq6yUyzzHK4cvPyez
         BmsH7GO1m0n30JFEQQhbrjtbcSJxrVU5TTzWs=
Received: by 10.227.127.83 with SMTP id f19mr1664240wbs.83.1277554893461;
        Sat, 26 Jun 2010 05:21:33 -0700 (PDT)
Received: from localhost.localdomain ([188.105.94.3])
        by mx.google.com with ESMTPS id t15sm86443394wbc.23.2010.06.26.05.21.31
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 26 Jun 2010 05:21:32 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.251.g92a7
In-Reply-To: <1277401489-27885-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149740>

$Test::Builder::Test was only made into an `our' variable in 0.94
released in September 2009, older distros are more likely to have 0.92
or earlier. Use the singleton Test::More->builder constructor instead,
the test now works on 0.92 too.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---

This patch fixes the TAP output in pu for older Test::More
libraries. It could be applied as a fixup to "test-lib: Make the
test_external_* functions TAP-aware", but it's probably useful to note
this in the version history.

 t/t9700/test.pl |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/t9700/test.pl b/t/t9700/test.pl
index e5d4b03..3e6a27c 100755
--- a/t/t9700/test.pl
+++ b/t/t9700/test.pl
@@ -10,8 +10,8 @@ use Test::More qw(no_plan);
 BEGIN {
 	# t9700-perl-git.sh kicks off our testing, so we have to go from
 	# there.
-	$Test::Builder::Test->{Curr_Test} =3D 1;
-	$Test::Builder::Test->{No_Ending} =3D 1;
+	Test::More->builder->{Curr_Test} =3D 1;
+	Test::More->builder->{No_Ending} =3D 1;
 }
=20
 use Cwd;
@@ -113,6 +113,6 @@ like($last_commit, qr/^[0-9a-fA-F]{40}$/, 'rev-pars=
e returned hash');
 my $dir_commit =3D $r2->command_oneline('log', '-n1', '--pretty=3Dform=
at:%H', '.');
 isnt($last_commit, $dir_commit, 'log . does not show last commit');
=20
-printf "1..%d\n", $Test::Builder::Test->{Curr_Test};
+printf "1..%d\n", Test::More->builder->{Curr_Test};
=20
-exit($Test::Builder::Test->{Is_Passing} ? 0 : 1);
+exit(Test::More->builder->{Is_Passing} ? 0 : 1);
--=20
1.7.1.251.g92a7
