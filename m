From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 21/26] fetch: define shallow boundary with --shallow-exclude
Date: Wed, 13 Apr 2016 19:55:05 +0700
Message-ID: <1460552110-5554-22-git-send-email-pclouds@gmail.com>
References: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 13 14:57:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aqKM4-0004dL-H7
	for gcvg-git-2@plane.gmane.org; Wed, 13 Apr 2016 14:57:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757316AbcDMM5H convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Apr 2016 08:57:07 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:32873 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbcDMM5F (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2016 08:57:05 -0400
Received: by mail-pf0-f195.google.com with SMTP id e190so4082014pfe.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2016 05:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5WqT+g7G+MJi5bhKBBtV8ZUkWW5bUK7aSTMTkTs7dOM=;
        b=yvMUgPO3JaPktExuIiRDimgig+/zp7Ftefnj1zOBvklt5ZUG7fmOTdQEG4f/66/xdo
         OVf7JRJZh0aPWFRuRXwY3cfrSMjd0Azc++RtbRy+byclKRmZVjF0iNkLe68aQRKTpCyG
         BcaYFTt7fi60pZqSgYay0smilyak74axwk4za4OxNn0jdzpzV1q3GLeSbgfjvlb376JM
         OaZgoQeaNyXCCw/rp7NaqJh5x2fJeX/mUodRF4P8VVQQTZK0qszaDdlbckSoPygOSmID
         abhpZBUfm3X1S4s4+rGXPHRQVIXXfotEcqALdFxPcS4B6CCWyXRqqz79IPCBBHEE6tk4
         xIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5WqT+g7G+MJi5bhKBBtV8ZUkWW5bUK7aSTMTkTs7dOM=;
        b=DkbjbD9VPfN3HyaFo6CQPFrsLJ70Fa3aoOjDE6NaOK/KgwuckPSnlrnl8q0d5X+ON8
         vlk7c/nqmQ4087Qc1KzD8VTruR9Mmy54GiKLKazJ4dSP6XlIYK8NWa/uaI626e/ma8SP
         WeCW7CWPwUvrmqj4QiOKomYa9YjaC37cW/Usgg0Q/TafuHvp/hU8KO+Y/mAHNeNjfW9Y
         ey4y10YIS3dRfoISV0vD4e0vQGlesTjlHNhnR3YigIHNEw4GfNlU7hQadonQrRQxDk7v
         MNMbaQ7bjQKR8X58sWqYFPSB5KtMAhoaX3U36NJymvzOiSAAqt2wLkpe7SuJ+LbrSInZ
         DCmg==
X-Gm-Message-State: AOPr4FVL5/mR8nVuEq7GLOSR5cCUuUaww6lEn/Zdtd/oCGNqasEokvYewVQNr7OOa4WxGA==
X-Received: by 10.98.14.67 with SMTP id w64mr12767537pfi.154.1460552224226;
        Wed, 13 Apr 2016 05:57:04 -0700 (PDT)
Received: from lanh ([115.76.233.41])
        by smtp.gmail.com with ESMTPSA id 136sm8155461pfz.44.2016.04.13.05.57.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Apr 2016 05:57:02 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Wed, 13 Apr 2016 19:57:10 +0700
X-Mailer: git-send-email 2.8.0.rc0.210.gd302cd2
In-Reply-To: <1460552110-5554-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291414>

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 Documentation/fetch-options.txt     |  5 +++++
 Documentation/git-fetch-pack.txt    |  5 +++++
 Documentation/gitremote-helpers.txt |  4 ++++
 builtin/fetch-pack.c                |  7 +++++++
 builtin/fetch.c                     | 21 ++++++++++++++++++---
 fetch-pack.c                        | 15 ++++++++++++++-
 fetch-pack.h                        |  1 +
 remote-curl.c                       |  9 +++++++++
 transport-helper.c                  | 24 ++++++++++++++++++++++++
 transport.c                         |  4 ++++
 transport.h                         |  6 ++++++
 11 files changed, 97 insertions(+), 4 deletions(-)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-opti=
ons.txt
index 8738d3d..7aa1285 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -18,6 +18,11 @@
 	Deepen or shorten the history of a shallow repository to
 	include all reachable commits after <date>.
=20
+--shallow-exclude=3D<revision>::
+	Deepen or shorten the history of a shallow repository to
+	exclude commits reachable from a specified remote branch or tag.
+	This option can be specified multiple times.
+
 --unshallow::
 	If the source repository is complete, convert a shallow
 	repository to a complete one, removing all the limitations
diff --git a/Documentation/git-fetch-pack.txt b/Documentation/git-fetch=
-pack.txt
index 99e6257..4d15b04 100644
--- a/Documentation/git-fetch-pack.txt
+++ b/Documentation/git-fetch-pack.txt
@@ -91,6 +91,11 @@ be in a separate packet, and the list must end with =
a flush packet.
 	Deepen or shorten the history of a shallow'repository to
 	include all reachable commits after <date>.
=20
+--shallow-exclude=3D<revision>::
+	Deepen or shorten the history of a shallow repository to
+	exclude commits reachable from a specified remote branch or tag.
+	This option can be specified multiple times.
+
 --no-progress::
 	Do not show the progress.
=20
diff --git a/Documentation/gitremote-helpers.txt b/Documentation/gitrem=
ote-helpers.txt
index 9971d9a..75bb638 100644
--- a/Documentation/gitremote-helpers.txt
+++ b/Documentation/gitremote-helpers.txt
@@ -418,6 +418,10 @@ set by Git if the remote helper has the 'option' c=
apability.
 'option deepen-since <timestamp>::
 	Deepens the history of a shallow repository based on time.
=20
+'option deepen-not <ref>::
+	Deepens the history of a shallow repository excluding ref.
+	Multiple options add up.
+
 'option followtags' {'true'|'false'}::
 	If enabled the helper should automatically fetch annotated
 	tag objects if the object the tag points at was transferred
diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 0402e27..07570be 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -50,6 +50,7 @@ int cmd_fetch_pack(int argc, const char **argv, const=
 char *prefix)
 	struct child_process *conn;
 	struct fetch_pack_args args;
 	struct sha1_array shallow =3D SHA1_ARRAY_INIT;
+	struct string_list deepen_not =3D STRING_LIST_INIT_DUP;
=20
 	packet_trace_identity("fetch-pack");
=20
@@ -108,6 +109,10 @@ int cmd_fetch_pack(int argc, const char **argv, co=
nst char *prefix)
 			args.deepen_since =3D xstrdup(arg);
 			continue;
 		}
+		if (skip_prefix(arg, "--shallow-exclude=3D", &arg)) {
+			string_list_append(&deepen_not, arg);
+			continue;
+		}
 		if (!strcmp("--no-progress", arg)) {
 			args.no_progress =3D 1;
 			continue;
@@ -135,6 +140,8 @@ int cmd_fetch_pack(int argc, const char **argv, con=
st char *prefix)
 		}
 		usage(fetch_pack_usage);
 	}
+	if (deepen_not.nr)
+		args.deepen_not =3D &deepen_not;
=20
 	if (i < argc)
 		dest =3D argv[i++];
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 283aa95..154b9ad 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -41,6 +41,7 @@ static int max_children =3D 1;
 static const char *depth;
 static const char *deepen_since;
 static const char *upload_pack;
+static struct string_list deepen_not =3D STRING_LIST_INIT_NODUP;
 static struct strbuf default_rla =3D STRBUF_INIT;
 static struct transport *gtransport;
 static struct transport *gsecondary;
@@ -50,6 +51,13 @@ static int shown_url =3D 0;
 static int refmap_alloc, refmap_nr;
 static const char **refmap_array;
=20
+static int option_parse_deepen_not(const struct option *opt,
+				   const char *arg, int unset)
+{
+	string_list_append(&deepen_not, arg);
+	return 0;
+}
+
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
 {
@@ -118,6 +126,9 @@ static struct option builtin_fetch_options[] =3D {
 		   N_("deepen history of shallow clone")),
 	OPT_STRING(0, "shallow-since", &deepen_since, N_("time"),
 		   N_("deepen history of shallow repository based on time")),
+	{ OPTION_CALLBACK, 0, "shallow-exclude", NULL, N_("revision"),
+		    N_("deepen history of shallow clone by excluding rev"),
+		    PARSE_OPT_NONEG, option_parse_deepen_not },
 	{ OPTION_SET_INT, 0, "unshallow", &unshallow, NULL,
 		   N_("convert to a complete repository"),
 		   PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1 },
@@ -875,6 +886,9 @@ static struct transport *prepare_transport(struct r=
emote *remote, int deepen)
 		set_option(transport, TRANS_OPT_DEPTH, depth);
 	if (deepen && deepen_since)
 		set_option(transport, TRANS_OPT_DEEPEN_SINCE, deepen_since);
+	if (deepen && deepen_not.nr)
+		set_option(transport, TRANS_OPT_DEEPEN_NOT,
+			   (const char *)&deepen_not);
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
 	return transport;
@@ -889,9 +903,10 @@ static void backfill_tags(struct transport *transp=
ort, struct ref *ref_map)
 	 * when remote helper is used (setting it to an empty string
 	 * is not unsetting). We could extend the remote helper
 	 * protocol for that, but for now, just force a new connection
-	 * without deepen-since.
+	 * without deepen-since. Similar story for deepen-not.
 	 */
-	cannot_reuse =3D transport->cannot_reuse || deepen_since;
+	cannot_reuse =3D transport->cannot_reuse ||
+		deepen_since || deepen_not.nr;
 	if (cannot_reuse) {
 		gsecondary =3D prepare_transport(transport->remote, 0);
 		transport =3D gsecondary;
@@ -1182,7 +1197,7 @@ int cmd_fetch(int argc, const char **argv, const =
char *prefix)
 	/* no need to be strict, transport_set_option() will validate it agai=
n */
 	if (depth && atoi(depth) < 1)
 		die(_("depth %s is not a positive number"), depth);
-	if (depth || deepen_since)
+	if (depth || deepen_since || deepen_not.nr)
 		deepen =3D 1;
=20
 	if (recurse_submodules !=3D RECURSE_SUBMODULES_OFF) {
diff --git a/fetch-pack.c b/fetch-pack.c
index a2f25c1..ad7d00f 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -22,6 +22,7 @@ static int unpack_limit =3D 100;
 static int prefer_ofs_delta =3D 1;
 static int no_done;
 static int deepen_since_ok;
+static int deepen_not_ok;
 static int fetch_fsck_objects =3D -1;
 static int transfer_fsck_objects =3D -1;
 static int agent_supported;
@@ -328,6 +329,7 @@ static int find_common(struct fetch_pack_args *args=
,
 			if (args->include_tag)   strbuf_addstr(&c, " include-tag");
 			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
 			if (deepen_since_ok)    strbuf_addstr(&c, " deepen-since");
+			if (deepen_not_ok)      strbuf_addstr(&c, " deepen-not");
 			if (agent_supported)    strbuf_addf(&c, " agent=3D%s",
 							    git_user_agent_sanitized());
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
@@ -351,6 +353,13 @@ static int find_common(struct fetch_pack_args *arg=
s,
 		unsigned long max_age =3D approxidate(args->deepen_since);
 		packet_buf_write(&req_buf, "deepen-since %lu", max_age);
 	}
+	if (args->deepen_not) {
+		int i;
+		for (i =3D 0; i < args->deepen_not->nr; i++) {
+			struct string_list_item *s =3D args->deepen_not->items + i;
+			packet_buf_write(&req_buf, "deepen-not %s", s->string);
+		}
+	}
 	packet_buf_flush(&req_buf);
 	state_len =3D req_buf.len;
=20
@@ -818,7 +827,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_=
args *args,
=20
 	if ((args->depth > 0 || is_repository_shallow()) && !server_supports(=
"shallow"))
 		die(_("Server does not support shallow clients"));
-	if (args->depth > 0 || args->deepen_since)
+	if (args->depth > 0 || args->deepen_since || args->deepen_not)
 		args->deepen =3D 1;
 	if (server_supports("multi_ack_detailed")) {
 		print_verbose(args, _("Server supports multi_ack_detailed"));
@@ -870,6 +879,10 @@ static struct ref *do_fetch_pack(struct fetch_pack=
_args *args,
 		deepen_since_ok =3D 1;
 	else if (args->deepen_since)
 		die(_("Server does not support --shallow-since"));
+	if (server_supports("deepen-not"))
+		deepen_not_ok =3D 1;
+	else if (args->deepen_not)
+		die(_("Server does not support --shallow-exclude"));
=20
 	if (everything_local(args, &ref, sought, nr_sought)) {
 		packet_flush(fd[1]);
diff --git a/fetch-pack.h b/fetch-pack.h
index f7eadb2..144301f 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -11,6 +11,7 @@ struct fetch_pack_args {
 	int unpacklimit;
 	int depth;
 	const char *deepen_since;
+	const struct string_list *deepen_not;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
 	unsigned lock_pack:1;
diff --git a/remote-curl.c b/remote-curl.c
index ffa4faa..71122ac 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -21,6 +21,7 @@ struct options {
 	int verbosity;
 	unsigned long depth;
 	char *deepen_since;
+	struct string_list deepen_not;
 	unsigned progress : 1,
 		check_self_contained_and_connected : 1,
 		cloning : 1,
@@ -65,6 +66,10 @@ static int set_option(const char *name, const char *=
value)
 		options.deepen_since =3D xstrdup(value);
 		return 0;
 	}
+	else if (!strcmp(name, "deepen-not")) {
+		string_list_append(&options.deepen_not, value);
+		return 0;
+	}
 	else if (!strcmp(name, "followtags")) {
 		if (!strcmp(value, "true"))
 			options.followtags =3D 1;
@@ -756,6 +761,9 @@ static int fetch_git(struct discovery *heads,
 		argv_array_pushf(&args, "--depth=3D%lu", options.depth);
 	if (options.deepen_since)
 		argv_array_pushf(&args, "--shallow-since=3D%s", options.deepen_since=
);
+	for (i =3D 0; i < options.deepen_not.nr; i++)
+		argv_array_pushf(&args, "--shallow-exclude=3D%s",
+				 options.deepen_not.items[i].string);
 	argv_array_push(&args, url.buf);
=20
 	for (i =3D 0; i < nr_heads; i++) {
@@ -977,6 +985,7 @@ int main(int argc, const char **argv)
 	options.verbosity =3D 1;
 	options.progress =3D !!isatty(2);
 	options.thin =3D 1;
+	string_list_init(&options.deepen_not, 1);
=20
 	remote =3D remote_get(argv[1]);
=20
diff --git a/transport-helper.c b/transport-helper.c
index 35023da..d644568 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -282,6 +282,26 @@ static int strbuf_set_helper_option(struct helper_=
data *data,
 	return ret;
 }
=20
+static int string_list_set_helper_option(struct helper_data *data,
+					 const char *name,
+					 struct string_list *list)
+{
+	struct strbuf buf =3D STRBUF_INIT;
+	int i, ret =3D 0;
+
+	for (i =3D 0; i < list->nr; i++) {
+		strbuf_addf(&buf, "option %s ", name);
+		quote_c_style(list->items[i].string, &buf, NULL, 0);
+		strbuf_addch(&buf, '\n');
+
+		if ((ret =3D strbuf_set_helper_option(data, &buf)))
+			break;
+		strbuf_reset(&buf);
+	}
+	strbuf_release(&buf);
+	return ret;
+}
+
 static int set_helper_option(struct transport *transport,
 			  const char *name, const char *value)
 {
@@ -294,6 +314,10 @@ static int set_helper_option(struct transport *tra=
nsport,
 	if (!data->option)
 		return 1;
=20
+	if (!strcmp(name, "deepen-not"))
+		return string_list_set_helper_option(data, name,
+						     (struct string_list *)value);
+
 	for (i =3D 0; i < ARRAY_SIZE(unsupported_options); i++) {
 		if (!strcmp(name, unsupported_options[i]))
 			return 1;
diff --git a/transport.c b/transport.c
index f04a302..3e6f3aa 100644
--- a/transport.c
+++ b/transport.c
@@ -154,6 +154,9 @@ static int set_git_option(struct git_transport_opti=
ons *opts,
 	} else if (!strcmp(name, TRANS_OPT_DEEPEN_SINCE)) {
 		opts->deepen_since =3D value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_DEEPEN_NOT)) {
+		opts->deepen_not =3D (const struct string_list *)value;
+		return 0;
 	}
 	return 1;
 }
@@ -209,6 +212,7 @@ static int fetch_refs_via_pack(struct transport *tr=
ansport,
 	args.no_progress =3D !transport->progress;
 	args.depth =3D data->options.depth;
 	args.deepen_since =3D data->options.deepen_since;
+	args.deepen_not =3D data->options.deepen_not;
 	args.check_self_contained_and_connected =3D
 		data->options.check_self_contained_and_connected;
 	args.cloning =3D transport->cloning;
diff --git a/transport.h b/transport.h
index 9c10a44..ab61932 100644
--- a/transport.h
+++ b/transport.h
@@ -5,6 +5,8 @@
 #include "run-command.h"
 #include "remote.h"
=20
+struct string_list;
+
 struct git_transport_options {
 	unsigned thin : 1;
 	unsigned keep : 1;
@@ -14,6 +16,7 @@ struct git_transport_options {
 	unsigned update_shallow : 1;
 	int depth;
 	const char *deepen_since;
+	const struct string_list *deepen_not;
 	const char *uploadpack;
 	const char *receivepack;
 	struct push_cas_option *cas;
@@ -175,6 +178,9 @@ int transport_restrict_protocols(void);
 /* Limit the depth of the fetch based on time if not null */
 #define TRANS_OPT_DEEPEN_SINCE "deepen-since"
=20
+/* Limit the depth of the fetch based on revs if not null */
+#define TRANS_OPT_DEEPEN_NOT "deepen-not"
+
 /* Aggressively fetch annotated tags if possible */
 #define TRANS_OPT_FOLLOWTAGS "followtags"
=20
--=20
2.8.0.rc0.210.gd302cd2
