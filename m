From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 1/4] instaweb: ignore GITWEB_CONFIG_SYSTEM
Date: Thu, 2 Sep 2010 18:54:29 -0500
Message-ID: <20100902235429.GB6466@burratino>
References: <20100812131152.2333.9604.reportbug@octopus.hi.pengutronix.de>
 <20100902221211.GA4789@burratino>
 <20100902223624.GA9613@dcvr.yhbt.net>
 <20100902235237.GA6466@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git@vger.kernel.org,
	Jakub Narebski <jnareb@gmail.com>,
	Pavan Kumar Sunkara <pavan.sss1991@gmail.com>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Fri Sep 03 01:56:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OrJds-0007ss-W4
	for gcvg-git-2@lo.gmane.org; Fri, 03 Sep 2010 01:56:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755822Ab0IBX4Y convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 2 Sep 2010 19:56:24 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:36541 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755754Ab0IBX4X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Sep 2010 19:56:23 -0400
Received: by qyk33 with SMTP id 33so1230923qyk.19
        for <git@vger.kernel.org>; Thu, 02 Sep 2010 16:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=TnejOp4x7S1Rn5ATmSSKXCJswuhXl38hUrZ1bXAImaU=;
        b=Zx7eCGEEOdhulWO6AwzI9qjdpHwhBjU79prFmCf5b1U2jr9z3PyUseX5QS5BY0U2Im
         6zjnolF9MpwBs1w5wTqqVLUGdx3l3O4/KddlEqQS0juYgYoLvYHB14vIMxd1Wm5bjRsu
         ltO5njwzTJsspNPezIvlomOmzJFlUUu1tCmEg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=cQYo7qRLPdKq7XKqNS5EGYiAko83CqxjXmL0lqGhsSViRQUZNWGlOJ5yEF6vv69MGl
         8suS6yVjg5Bv9D9P0eFas87kcevDChvcn5WS9qbjlYVgASyN4Ut1pHU0ny+j3zptobGT
         or8DlhQ9yorUylT4qTz46lUoMLNiCGrocOhUo=
Received: by 10.229.51.210 with SMTP id e18mr6492871qcg.249.1283471782420;
        Thu, 02 Sep 2010 16:56:22 -0700 (PDT)
Received: from burratino (dhcp-11-17.cs.uchicago.edu [128.135.11.176])
        by mx.google.com with ESMTPS id t4sm1112643qcs.28.2010.09.02.16.56.21
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 02 Sep 2010 16:56:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100902235237.GA6466@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155225>

The configuration in /etc/gitweb.conf might specify any old
layout; in particular, it is likely not to be identical to that
which git instaweb sets up.  Noticed by Uwe Kleine-K=C3=B6nig.

Reported-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
Cc: Eric Wong <normalperson@yhbt.net>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 git-instaweb.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/git-instaweb.sh b/git-instaweb.sh
index f608014..6279f4d 100755
--- a/git-instaweb.sh
+++ b/git-instaweb.sh
@@ -375,7 +375,8 @@ script=3D'
 s#^(my|our) \$projectroot =3D.*#$1 \$projectroot =3D "'$(dirname "$fqg=
itdir")'";#;
 s#(my|our) \$gitbin =3D.*#$1 \$gitbin =3D "'$GIT_EXEC_PATH'";#;
 s#(my|our) \$projects_list =3D.*#$1 \$projects_list =3D \$projectroot;=
#;
-s#(my|our) \$git_temp =3D.*#$1 \$git_temp =3D "'$fqgitdir/gitweb/tmp'"=
;#;'
+s#(my|our) \$git_temp =3D.*#$1 \$git_temp =3D "'$fqgitdir/gitweb/tmp'"=
;#;
+s#(my|our) \$GITWEB_CONFIG_SYSTEM =3D.*#$1 \$GITWEB_CONFIG_SYSTEM =3D =
"";#;'
=20
 gitweb_cgi () {
 	cat > "$1.tmp" <<\EOFGITWEB
--=20
1.7.2.2
