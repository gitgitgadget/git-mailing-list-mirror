From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 6/8] fetch: add --resume-pack=<path>
Date: Fri,  5 Feb 2016 15:57:55 +0700
Message-ID: <1454662677-15137-7-git-send-email-pclouds@gmail.com>
References: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 05 09:58:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aRcE4-0007f0-Ro
	for gcvg-git-2@plane.gmane.org; Fri, 05 Feb 2016 09:58:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbcBEI6o convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 5 Feb 2016 03:58:44 -0500
Received: from mail-pf0-f179.google.com ([209.85.192.179]:36304 "EHLO
	mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbcBEI6n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Feb 2016 03:58:43 -0500
Received: by mail-pf0-f179.google.com with SMTP id n128so65141995pfn.3
        for <git@vger.kernel.org>; Fri, 05 Feb 2016 00:58:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=iOBdUUqJeB+QCgQeq65TdAi4218RJ2eigjIFtwo1Wx8=;
        b=plAWAl3qGa1SvhoX/6BIn9G/r3XpJIfcSmpWHbYaMRY8AQCjX0/8mmckySY56k0UZU
         gbcb/FpwnuFC3JS5rSDvChns5RYmOXxweIMhDTknhf599uz6b4Z+2HXoBdp0YySxYaxL
         wLF/1bRWLPIyPF3/fqf/SthCgpjr/TUBYx/a2oOyef1A+gAp7du+DOZaui/fd9YBAbRO
         Hjg5BKp0TnbJZBQ3DjO2cUtDhjR6u2QOFzLCJUwyp4+qAAXQVYCUUZoAS+qjwc9UHXyR
         Vxg5cGE8lGefjqex878msckukwakXzK/noiRuQoC3cekpjsohHPcjLvEtZ4/x4hYZKRQ
         X+cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=iOBdUUqJeB+QCgQeq65TdAi4218RJ2eigjIFtwo1Wx8=;
        b=fb1tpKLxCEqL3gSua9Nrs+S6K6TOpqXRj/aCYk7mYl3WlZCogXBoQ2R/oKJOznS3wL
         L/mFKF+W1fvDFj3SdCAK/+uD31+g3m6Cc++0JapmMKno1uC9Z/ttRA6peyaXbFLu7oqW
         Zmneg/1t7OmW9vyfgOSlgLNWLFE6FRw33V4J6khZO7QEbQuvRgesV0//RZ98ktMnxrVi
         K4os0fB97a7dF84frvEThcJ1zTw53C3GeEfVnHAtbWFYXKI/TtcdfZjYahg0L3vWJmE3
         aJOqQ+6aEvwZtAd9DBWsXjGMrFX3OwI5gEGCkXjDEBs6T4u+C0nknZZ1uE9fz7Fy2Rf/
         dh8A==
X-Gm-Message-State: AG10YOQoBhWlgBFmfYt2a0KKTMXXAHwWR4++hDFjT6t2A0TDop/fX5k0AGMsrNo1c03j9A==
X-Received: by 10.98.69.78 with SMTP id s75mr18356085pfa.102.1454662722776;
        Fri, 05 Feb 2016 00:58:42 -0800 (PST)
Received: from lanh ([115.76.228.161])
        by smtp.gmail.com with ESMTPSA id l14sm22657559pfb.73.2016.02.05.00.58.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 05 Feb 2016 00:58:41 -0800 (PST)
Received: by lanh (sSMTP sendmail emulation); Fri, 05 Feb 2016 15:58:57 +0700
X-Mailer: git-send-email 2.7.0.377.g4cd97dd
In-Reply-To: <1454662677-15137-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285561>

This is a low-level option for resumable fetch. You start a resumable
fetch with

    git fetch --resume-pack=3Dblah <host>

where "blah" file does not exist. If the fetch is interrupted, "blah"
will contain what's been fetched so far. Run the same command again.

On the server side, pack-objects performs the exact same operation to
produce full pack again, but it will not send what is already in
"blah". pack-objects does check if the skipped part is the same between
two sides, in case of configuration change or whatever, and abort early=
=2E

On the client side, index-pack feeds itself with what's in "blah",
then the input stream from pack-objects. index-pack does strict
verification as usual. Even if pack-objects fails to produce a stable
pack, index-pack should catch it and complain loudly. If everything
goes well, "blah" is removed and a new good pack is put in $GIT_DIR.

Improvement point. We should be able to perform some heavy operations
locally before connecting to the server (e.g. produce the skip hash
from "blah", or index-pack consuming "blah").

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/fetch-pack.c | 4 ++++
 builtin/fetch.c      | 5 +++++
 remote-curl.c        | 8 +++++++-
 transport.c          | 4 ++++
 transport.h          | 4 ++++
 5 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 9b2a514..996ad30 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -129,6 +129,10 @@ int cmd_fetch_pack(int argc, const char **argv, co=
nst char *prefix)
 			args.update_shallow =3D 1;
 			continue;
 		}
+		if (skip_prefix(arg, "--resume-path=3D", &arg)) {
+			args.resume_path =3D arg;
+			continue;
+		}
 		usage(fetch_pack_usage);
 	}
=20
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8e74213..34f32c6 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -48,6 +48,7 @@ static const char *recurse_submodules_default;
 static int shown_url =3D 0;
 static int refmap_alloc, refmap_nr;
 static const char **refmap_array;
+static const char *resume_path;
=20
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
@@ -115,6 +116,8 @@ static struct option builtin_fetch_options[] =3D {
 	OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 	OPT_STRING(0, "depth", &depth, N_("depth"),
 		   N_("deepen history of shallow clone")),
+	OPT_FILENAME(0, "resume-pack", &resume_path,
+		     N_("perform resumable fetch on the given pack")),
 	{ OPTION_SET_INT, 0, "unshallow", &unshallow, NULL,
 		   N_("convert to a complete repository"),
 		   PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1 },
@@ -872,6 +875,8 @@ static struct transport *prepare_transport(struct r=
emote *remote)
 		set_option(transport, TRANS_OPT_DEPTH, depth);
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
+	if (resume_path)
+		set_option(transport, TRANS_OPT_RESUME_PATH, resume_path);
 	return transport;
 }
=20
diff --git a/remote-curl.c b/remote-curl.c
index c704857..36835fb 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -20,6 +20,7 @@ static struct strbuf url =3D STRBUF_INIT;
 struct options {
 	int verbosity;
 	unsigned long depth;
+	const char *resume_path;
 	unsigned progress : 1,
 		check_self_contained_and_connected : 1,
 		cloning : 1,
@@ -119,6 +120,9 @@ static int set_option(const char *name, const char =
*value)
 		else
 			return -1;
 		return 0;
+	} else if (!strcmp(name, "resume-path")) {
+		options.resume_path =3D xstrdup(value);
+		return 0;
 	} else {
 		return 1 /* unsupported */;
 	}
@@ -727,7 +731,7 @@ static int fetch_git(struct discovery *heads,
 	struct strbuf preamble =3D STRBUF_INIT;
 	char *depth_arg =3D NULL;
 	int argc =3D 0, i, err;
-	const char *argv[17];
+	const char *argv[18];
=20
 	argv[argc++] =3D "fetch-pack";
 	argv[argc++] =3D "--stateless-rpc";
@@ -755,6 +759,8 @@ static int fetch_git(struct discovery *heads,
 		depth_arg =3D strbuf_detach(&buf, NULL);
 		argv[argc++] =3D depth_arg;
 	}
+	if (options.resume_path)
+		argv[argc++] =3D xstrfmt("--resume-path=3D%s", options.resume_path);
 	argv[argc++] =3D url.buf;
 	argv[argc++] =3D NULL;
=20
diff --git a/transport.c b/transport.c
index 67f3666..6378bed 100644
--- a/transport.c
+++ b/transport.c
@@ -467,6 +467,9 @@ static int set_git_option(struct git_transport_opti=
ons *opts,
 	} else if (!strcmp(name, TRANS_OPT_UPDATE_SHALLOW)) {
 		opts->update_shallow =3D !!value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_RESUME_PATH)) {
+		opts->resume_path =3D value;
+		return 0;
 	} else if (!strcmp(name, TRANS_OPT_DEPTH)) {
 		if (!value)
 			opts->depth =3D 0;
@@ -534,6 +537,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
 		data->options.check_self_contained_and_connected;
 	args.cloning =3D transport->cloning;
 	args.update_shallow =3D data->options.update_shallow;
+	args.resume_path =3D data->options.resume_path;
=20
 	if (!data->got_remote_heads) {
 		connect_setup(transport, 0, 0);
diff --git a/transport.h b/transport.h
index 8ebaaf2..765e4e5 100644
--- a/transport.h
+++ b/transport.h
@@ -16,6 +16,7 @@ struct git_transport_options {
 	const char *uploadpack;
 	const char *receivepack;
 	struct push_cas_option *cas;
+	const char *resume_path;
 };
=20
 struct transport {
@@ -180,6 +181,9 @@ int transport_restrict_protocols(void);
 /* Send push certificates */
 #define TRANS_OPT_PUSH_CERT "pushcert"
=20
+/* Resumable fetch */
+#define TRANS_OPT_RESUME_PATH "resume-path"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
--=20
2.7.0.377.g4cd97dd
