From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] repack.c: rename and unlink pack file if it exists
Date: Wed, 05 Feb 2014 12:10:23 -0800
Message-ID: <xmqqwqh92uds.fsf@gitster.dls.corp.google.com>
References: <xmqqwqha5twg.fsf@gitster.dls.corp.google.com>
	<20140205011632.GA3923@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	Torsten =?utf-8?Q?B?= =?utf-8?Q?=C3=B6gershausen?= 
	<tboegi@web.de>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 05 21:10:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WB8o3-0006jk-OV
	for gcvg-git-2@plane.gmane.org; Wed, 05 Feb 2014 21:10:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753819AbaBEUKh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 5 Feb 2014 15:10:37 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:37621 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752739AbaBEUKd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 5 Feb 2014 15:10:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1CE9667158;
	Wed,  5 Feb 2014 15:10:33 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3+F7e8EtLGi5
	7I4P2ZgSgj7Aa2w=; b=eWtpfUaoLJ6Cp1o5Uy3WxzDgKKjinG6SDY1nkNbEIIgJ
	hE66pl1GsWfXl9n9bv/htaJUzP7FbddfuuGVVMq//rRKgJ5gw6jPnsVKv5dKLCwX
	GJWqLmjqXITmoI1KusQK1nRZ8997TY6DWjw+BKRL+WhsIgfjQ4PKZwKfHkB8j/4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kc2gmC
	4fslHe1Z5lXa9zV82GR/b5AZ6fv54i62lH0O4cRR2DAyBGxqJuc48AtDEPZ8uGgM
	8JtFvnBUjw3jujqkE1OedPCFVL+aE3JKZbrr8eb4I7onLhE2hv8m+z3LMu5PJ5+q
	vesDpRbCQ8KX6D3ObgoNMKmuIN2p59O/fzYlQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E8E3C67157;
	Wed,  5 Feb 2014 15:10:32 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ECC706712C;
	Wed,  5 Feb 2014 15:10:24 -0500 (EST)
In-Reply-To: <20140205011632.GA3923@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 4 Feb 2014 20:16:32 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8C87647C-8EA1-11E3-B458-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241650>

=2E.. and this is the other half that is supposed to be only about
renaming variables.

-- >8 --
=46rom: Torsten B=C3=B6gershausen <tboegi@web.de>
Date: Sun, 2 Feb 2014 16:09:56 +0100
Subject: [PATCH] repack.c: rename a few variables

Rename the variables to match what they are used for: fname for the
final name of the new packfile, fname_old for the name of the
existing one, and fname_tmp for the temporary name pack-objects
created the new packfile in.

Signed-off-by: Torsten B=C3=B6gershausen <tboegi@web.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/repack.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index fe31577..3b01353 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -316,33 +316,33 @@ int cmd_repack(int argc, const char **argv, const=
 char *prefix)
 	/* Now the ones with the same name are out of the way... */
 	for_each_string_list_item(item, &names) {
 		for (ext =3D 0; ext < 2; ext++) {
-			char *fname, *fname_old;
+			char *fname, *fname_tmp;
 			struct stat statbuffer;
 			fname =3D mkpathdup("%s/pack-%s%s",
 					packdir, item->string, exts[ext]);
-			fname_old =3D mkpathdup("%s-%s%s",
+			fname_tmp =3D mkpathdup("%s-%s%s",
 					packtmp, item->string, exts[ext]);
-			if (!stat(fname_old, &statbuffer)) {
+			if (!stat(fname_tmp, &statbuffer)) {
 				statbuffer.st_mode &=3D ~(S_IWUSR | S_IWGRP | S_IWOTH);
-				chmod(fname_old, statbuffer.st_mode);
+				chmod(fname_tmp, statbuffer.st_mode);
 			}
-			if (rename(fname_old, fname))
-				die_errno(_("renaming '%s' failed"), fname_old);
+			if (rename(fname_tmp, fname))
+				die_errno(_("renaming '%s' into '%s' failed"), fname_tmp, fname);
 			free(fname);
-			free(fname_old);
+			free(fname_tmp);
 		}
 	}
=20
 	/* Remove the "old-" files */
 	for_each_string_list_item(item, &names) {
 		for (ext =3D 0; ext < 2; ext++) {
-			char *fname;
-			fname =3D mkpath("%s/old-%s%s",
+			char *fname_old;
+			fname_old =3D mkpath("%s/old-%s%s",
 					packdir,
 					item->string,
 					exts[ext]);
-			if (remove_path(fname))
-				warning(_("removing '%s' failed"), fname);
+			if (remove_path(fname_old))
+				warning(_("removing '%s' failed"), fname_old);
 		}
 	}
=20
--=20
1.9-rc2-217-g24a8b2e
