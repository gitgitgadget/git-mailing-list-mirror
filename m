From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 3/7] git.1: Clarify the behavior of the --paginate option
Date: Fri, 19 Feb 2010 01:06:39 -0600
Message-ID: <20100219070639.GC29916@progeny.tock>
References: <20100219065010.GA22258@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Celis <sebastian@sebastiancelis.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 08:06:40 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiMwg-0002AA-RG
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 08:06:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388Ab0BSHGd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 02:06:33 -0500
Received: from mail-yx0-f200.google.com ([209.85.210.200]:49512 "EHLO
	mail-yx0-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754242Ab0BSHGb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 02:06:31 -0500
Received: by yxe38 with SMTP id 38so7203598yxe.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 23:06:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=cI+PtCzTq9QFBQKbyQO868acU0tNoMWilb5p0MZUhGk=;
        b=nnT7Gzs0ZHdw5sLgbB70fRI1+NhfGN7IFMZLKhYPNf11787K34BEponqgveWtUk4Bn
         j2sVlMZqhmS9fZiHBJC848jLccVfMSIM2ZzzpHI/Qpx6ymV2n1s9jBBukffgrI61Va3E
         uCGcOlrorZXPezZvv67jrzKXv+pQB0ufjczCs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Y88c3aExgNNr+sGtx3VoBo5gGVd9yottY1DFUVz+zLQjGJ8MZUhtQ1gczqX49xeEYa
         kYH9ZSOZtGBTsJUsNF07tvn5H7FNtAxVzj+GYjEZ38lJKj9GlLezix7xY9kUilEr5WlE
         5R7fXNtc28zUzwN/IsYRiJ53eaeFqQ5nviVMI=
Received: by 10.101.132.14 with SMTP id j14mr11154752ann.58.1266563190815;
        Thu, 18 Feb 2010 23:06:30 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm1268565gxk.2.2010.02.18.23.06.29
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 23:06:30 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100219065010.GA22258@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140420>

The --paginate option is meant to negate the effect of an explicit or
implicit pager.<cmd> =3D false setting.  Thus it turns the pager on if
output is going to a terminal rather than unconditionally.

Explaining this requires mentioning configuration options very early
in the manual, when some users might not be familiar with them yet.
Provide some pointers to help: to the relevant section of git.1 for
the configuration mechanism in general and to git-config.1 for the
pager.<cmd> options.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
Add a second paragraph to explain the less obvious part of the patch.
Jeff reverse-engineered this all correctly in [1], but one shouldn=E2=80=
=99t
have to think that hard to see where a patch is coming from.

http://thread.gmane.org/gmane.comp.version-control.git/139831/focus=3D1=
39971

 Documentation/git.txt |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 01c4631..f26641a 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -229,7 +229,10 @@ help ...`.
=20
 -p::
 --paginate::
-	Pipe all output into 'less' (or if set, $PAGER).
+	Pipe all output into 'less' (or if set, $PAGER) if standard
+	output is a terminal.  This overrides the `pager.<cmd>`
+	configuration options (see the "Configuration Mechanism" section
+	below).
=20
 --no-pager::
 	Do not pipe git output into a pager.
@@ -401,7 +404,8 @@ people.  Here is an example:
 ------------
=20
 Various commands read from the configuration file and adjust
-their operation accordingly.
+their operation accordingly.  See linkgit:git-config[1] for a
+list.
=20
=20
 Identifier Terminology
--=20
1.7.0
