From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2] git config: report when trying to modify a
 non-existing repo config
Date: Wed, 24 Feb 2016 19:59:30 +0700
Message-ID: <20160224125930.GA1422@lanh>
References: <c4027d758b0914dbc2e1ff5df344b0669aac4447.1456299545.git.johannes.schindelin@gmx.de>
 <b225aec8c83a184f90dc6bfa821177b52ef4b3f4.1456318031.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, John Keeping <john@keeping.me.uk>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 24 13:59:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aYZ27-0000nx-Cu
	for gcvg-git-2@plane.gmane.org; Wed, 24 Feb 2016 13:59:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752370AbcBXM7B convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 24 Feb 2016 07:59:01 -0500
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36311 "EHLO
	mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751507AbcBXM7A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Feb 2016 07:59:00 -0500
Received: by mail-pf0-f171.google.com with SMTP id e127so12679955pfe.3
        for <git@vger.kernel.org>; Wed, 24 Feb 2016 04:59:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Em+f+UTfql5+urRJtcxOc1Wfdmy1cbJ1o7qZXmAgscE=;
        b=0F4y293bxr0h74vc0DupHK+9IZXK4eLySvknjvKGd3CaITX8zUIYuAlPDvZLH1Liry
         JPbxIQVh3d/5JewQDqpyS/UrRummmtfv3cQyLOFEog2EvN9Aqbd0mUP/XHd6jv52CN9X
         cAktpMdtOEVya4n89X1ChCJ0RXLpMoMIjG7ixRQpd8r/ijp6zGnrfWlIxJ24tO6xyY4Y
         4nBFLaH+luBDiwjLb/wfE17WpUHAlaIZ+X/QEJzC5dhhPucMeQm1749DC8jG6BbvZR6C
         g3xaXoGZJpB7qAXMY3fEyNIgkkbNyNmuSf8N+ezfNieVfg+3t2V7rIkWWZi2m0YHy8iB
         GnGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Em+f+UTfql5+urRJtcxOc1Wfdmy1cbJ1o7qZXmAgscE=;
        b=Dc7G27IcvyrxZ/Fy9KNuPZAPE5yxdy+69p2/qAsqpel179xoCCmsPJdYT9PFFIriFO
         GzeXWZeCKhJFI85fLM2U8P2Y8oYt+KYtGEymi1Cl7YBDnBUstxBFVaqt7ugUAUlTEreG
         6hv099R72f6VZa9b2QQKhG7XKet6c04YUPBOaA5XZX/AF3RkYT0+jY2dGOgxp/W1PjE2
         91msSGmDTpgptQwtRLVeHGWAf5CUze5Vn7dleKBQYFdiLtynOP8vVROXGXwb3Ddihev6
         0iJ13KnDdrVtv4cJeYXa9TTkqb7HzU240gN3Ty6jTd8G4hqTLAp8bKFNUIOevVl+7tuP
         YPHQ==
X-Gm-Message-State: AG10YOQ20EAqLMfIknLs1V7Kmbv1ZUScgpVcEW3KKas5eMQbGKBghMQphqC7WzXvyVlcaw==
X-Received: by 10.98.34.212 with SMTP id p81mr53859957pfj.23.1456318740041;
        Wed, 24 Feb 2016 04:59:00 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id t29sm5069461pfi.8.2016.02.24.04.58.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Feb 2016 04:58:58 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Wed, 24 Feb 2016 19:59:30 +0700
Content-Disposition: inline
In-Reply-To: <b225aec8c83a184f90dc6bfa821177b52ef4b3f4.1456318031.git.johannes.schindelin@gmx.de>
X-Clacks-Overhead: GNU Terry Pratchett
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287206>

On Wed, Feb 24, 2016 at 01:48:11PM +0100, Johannes Schindelin wrote:
> +		die("not in a git directory");

Maybe wrap this string with _() for translation? Then we can pile this
patch on top to fix the rest in builtin/config.c.

-- 8< --
Subject: [PATCH] builtin/config.c: mark strings for translation

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/config.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/builtin/config.c b/builtin/config.c
index adc7727..7dad412 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -87,7 +87,7 @@ static struct option builtin_config_options[] =3D {
 static void check_argc(int argc, int min, int max) {
 	if (argc >=3D min && argc <=3D max)
 		return;
-	error("wrong number of arguments");
+	error(_("wrong number of arguments"));
 	usage_with_options(builtin_config_usage, builtin_config_options);
 }
=20
@@ -188,7 +188,7 @@ static int get_value(const char *key_, const char *=
regex_)
=20
 		key_regexp =3D (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(key_regexp, key, REG_EXTENDED)) {
-			error("invalid key pattern: %s", key_);
+			error(_("invalid key pattern: %s"), key_);
 			free(key_regexp);
 			key_regexp =3D NULL;
 			ret =3D CONFIG_INVALID_PATTERN;
@@ -209,7 +209,7 @@ static int get_value(const char *key_, const char *=
regex_)
=20
 		regexp =3D (regex_t*)xmalloc(sizeof(regex_t));
 		if (regcomp(regexp, regex_, REG_EXTENDED)) {
-			error("invalid pattern: %s", regex_);
+			error(_("invalid pattern: %s"), regex_);
 			free(regexp);
 			regexp =3D NULL;
 			ret =3D CONFIG_INVALID_PATTERN;
@@ -353,10 +353,10 @@ static int get_colorbool(const char *var, int pri=
nt)
 static void check_write(void)
 {
 	if (given_config_source.use_stdin)
-		die("writing to stdin is not supported");
+		die(_("writing to stdin is not supported"));
=20
 	if (given_config_source.blob)
-		die("writing config blobs is not supported");
+		die(_("writing config blobs is not supported"));
 }
=20
 struct urlmatch_current_candidate_value {
@@ -461,7 +461,7 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
=20
 	if (use_global_config + use_system_config + use_local_config +
 	    !!given_config_source.file + !!given_config_source.blob > 1) {
-		error("only one config file at a time.");
+		error(_("only one config file at a time."));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
=20
@@ -482,7 +482,7 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 			 * location; error out even if XDG_CONFIG_HOME
 			 * is set and points at a sane location.
 			 */
-			die("$HOME not set");
+			die(_("$HOME not set"));
=20
 		if (access_or_warn(user_config, R_OK, 0) &&
 		    xdg_config && !access_or_warn(xdg_config, R_OK, 0))
@@ -512,17 +512,17 @@ int cmd_config(int argc, const char **argv, const=
 char *prefix)
 	}
=20
 	if (HAS_MULTI_BITS(types)) {
-		error("only one type at a time.");
+		error(_("only one type at a time."));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
=20
 	if ((actions & (ACTION_GET_COLOR|ACTION_GET_COLORBOOL)) && types) {
-		error("--get-color and variable type are incoherent");
+		error(_("--get-color and variable type are incoherent"));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
=20
 	if (HAS_MULTI_BITS(actions)) {
-		error("only one action at a time.");
+		error(_("only one action at a time."));
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 	if (actions =3D=3D 0)
@@ -535,7 +535,7 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 		}
 	if (omit_values &&
 	    !(actions =3D=3D ACTION_LIST || actions =3D=3D ACTION_GET_REGEXP)=
) {
-		error("--name-only is only applicable to --list or --get-regexp");
+		error(_("--name-only is only applicable to --list or --get-regexp"))=
;
 		usage_with_options(builtin_config_usage, builtin_config_options);
 	}
 	if (actions =3D=3D ACTION_LIST) {
@@ -544,10 +544,10 @@ int cmd_config(int argc, const char **argv, const=
 char *prefix)
 					    &given_config_source,
 					    respect_includes) < 0) {
 			if (given_config_source.file)
-				die_errno("unable to read config file '%s'",
+				die_errno(_("unable to read config file '%s'"),
 					  given_config_source.file);
 			else
-				die("error processing config file(s)");
+				die(_("error processing config file(s)"));
 		}
 	}
 	else if (actions =3D=3D ACTION_EDIT) {
@@ -555,11 +555,11 @@ int cmd_config(int argc, const char **argv, const=
 char *prefix)
=20
 		check_argc(argc, 0, 0);
 		if (!given_config_source.file && nongit)
-			die("not in a git directory");
+			die(_("not in a git directory"));
 		if (given_config_source.use_stdin)
-			die("editing stdin is not supported");
+			die(_("editing stdin is not supported"));
 		if (given_config_source.blob)
-			die("editing blobs is not supported");
+			die(_("editing blobs is not supported"));
 		git_config(git_default_config, NULL);
 		config_file =3D xstrdup(given_config_source.file ?
 				      given_config_source.file : git_path("config"));
@@ -584,8 +584,9 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 		value =3D normalize_value(argv[0], argv[1]);
 		ret =3D git_config_set_in_file(given_config_source.file, argv[0], va=
lue);
 		if (ret =3D=3D CONFIG_NOTHING_SET)
-			error("cannot overwrite multiple values with a single value\n"
-			"       Use a regexp, --add or --replace-all to change %s.", argv[0=
]);
+			error(_("cannot overwrite multiple values with a single value\n"
+				"Use a regexp, --add or --replace-all to change %s."),
+			      argv[0]);
 		return ret;
 	}
 	else if (actions =3D=3D ACTION_SET_ALL) {
@@ -655,7 +656,7 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret =3D=3D 0)
-			die("No such section!");
+			die(_("No such section!"));
 	}
 	else if (actions =3D=3D ACTION_REMOVE_SECTION) {
 		int ret;
@@ -666,7 +667,7 @@ int cmd_config(int argc, const char **argv, const c=
har *prefix)
 		if (ret < 0)
 			return ret;
 		if (ret =3D=3D 0)
-			die("No such section!");
+			die(_("No such section!"));
 	}
 	else if (actions =3D=3D ACTION_GET_COLOR) {
 		check_argc(argc, 1, 2);
--=20
2.7.2.531.gc9e018c

-- 8< --
