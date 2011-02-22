From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v4 68/73] gettextize: git-notes GIT_NOTES_REWRITE_MODE error message
Date: Tue, 22 Feb 2011 23:42:27 +0000
Message-ID: <1298418152-27789-69-git-send-email-avarab@gmail.com>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jakub Narebski <jnareb@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 23 00:45:42 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ps1vG-0000K1-Lv
	for gcvg-git-2@lo.gmane.org; Wed, 23 Feb 2011 00:45:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755623Ab1BVXos convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 22 Feb 2011 18:44:48 -0500
Received: from mail-bw0-f51.google.com ([209.85.214.51]:39209 "EHLO
	mail-bw0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755588Ab1BVXop (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Feb 2011 18:44:45 -0500
Received: by mail-bw0-f51.google.com with SMTP id 10so3866615bwz.10
        for <git@vger.kernel.org>; Tue, 22 Feb 2011 15:44:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=CrfSDQbSF+0Frq815JVbaqChaPTMsDvOf6fdnjgWNPs=;
        b=eR2jY7XLh/sOqk9p03KaMy5+GzmtGuXNu1bglnZjGpGFu2MGx/dxCoBnPwFoMKD3Ip
         EIh6dlXoCJzHHDA5VYuceAi1azyU+LMO753zrdw7+zqauHNbIOczosHvmGTBasKS20HJ
         ik1IoZ4mdS7oXbo4jHXP9EjK61aH53VVtdQVI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=fu6eY/UDG208o6WYePJ5sSTIDb8wocAh6v3SpVgUJnlG1H0xjqjUJw007NpPT+YIsv
         jmZ0eBHIzsnE2+5h9XKxEHADBba3IZAUYG7jedPxzcuvXQqyftKvLbnrkMaBFe8CkGab
         joy7rUoRzmc3fFqD4YpRLu3LPb+871w+Ge1xU=
Received: by 10.204.128.200 with SMTP id l8mr3055794bks.60.1298418284626;
        Tue, 22 Feb 2011 15:44:44 -0800 (PST)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id z18sm4913415bkf.8.2011.02.22.15.44.42
        (version=SSLv3 cipher=OTHER);
        Tue, 22 Feb 2011 15:44:43 -0800 (PST)
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
In-Reply-To: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
References: <7vhbbwdjnm.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167618>

Use sprintf format for the error message that's displayed if
GIT_NOTES_REWRITE_MODE is invalid, and leave a note in a TRANSLATORS
comment indicating what the message means.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 builtin/notes.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/notes.c b/builtin/notes.c
index 4c6cf85..a0aa995 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -382,8 +382,10 @@ struct notes_rewrite_cfg *init_copy_notes_for_rewr=
ite(const char *cmd)
 		c->mode_from_env =3D 1;
 		c->combine =3D parse_combine_notes_fn(rewrite_mode_env);
 		if (!c->combine)
-			error("Bad " GIT_NOTES_REWRITE_MODE_ENVIRONMENT
-			      " value: '%s'", rewrite_mode_env);
+			/* TRANSLATORS: The first %s is the name of the
+			   environment variable, the second %s is its value */
+			error(_("Bad %s value: '%s'"), GIT_NOTES_REWRITE_MODE_ENVIRONMENT,
+					rewrite_mode_env);
 	}
 	if (rewrite_refs_env) {
 		c->refs_from_env =3D 1;
--=20
1.7.2.3
