From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 4/8] config: Improve variable 'type' handling.
Date: Sun, 15 Feb 2009 15:34:49 +0200
Message-ID: <20090215133449.GA13810@annwn>
References: <1234688460-9248-1-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-2-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-3-git-send-email-felipe.contreras@gmail.com> <1234688460-9248-4-git-send-email-felipe.contreras@gmail.com> <alpine.DEB.1.00.0902151323100.10279@pacific.mpi-cbg.de> <94a0d4530902150443t38d9253bi85ec42f3afbf0a1d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 15 14:36:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYhAT-00019X-HD
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 14:36:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755076AbZBONez (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 08:34:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755166AbZBONez
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 08:34:55 -0500
Received: from mail-fx0-f20.google.com ([209.85.220.20]:32819 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755076AbZBONex (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Feb 2009 08:34:53 -0500
Received: by fxm13 with SMTP id 13so4898053fxm.13
        for <git@vger.kernel.org>; Sun, 15 Feb 2009 05:34:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=7o830tjSNHvbEvt8Nj8QT+bBdY001L2GOsqjy6PL5MM=;
        b=ZuiEKBuJkhlj6jf7eZFOY8MzpbOOh7++MVENwPoY8vM5uqW05MmAVxKI0SJpE1F8em
         9HiPGU/w3WGLccLgtGPqCIO3ixvW5NBlsEcX8LxUpsyFD8v//arUy8j6tmlHO1EoyuF9
         ieBYA+p65Mtno0Rlrou32rK6KWQ5a/pzCHgZI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=AVxw8lyRWpuInJ9EgfiVQHgmGQhfsJ9kyqIabZ/aKWlc7u0OfdXPnxQfvUUto9s3GY
         VC6hYjq0TZL4WmkovLWa1VGxp3hnT2f6eVgqYxFhZZ1XCQFbUhsIhbP7qbLD4a4OTYeu
         C1N/+4/fukf1fnQQG//7/aS3Lhmig6zNbLUT8=
Received: by 10.180.232.9 with SMTP id e9mr1060851bkh.198.1234704892063;
        Sun, 15 Feb 2009 05:34:52 -0800 (PST)
Received: from @ (a91-153-251-222.elisa-laajakaista.fi [91.153.251.222])
        by mx.google.com with ESMTPS id p9sm6012015fkb.21.2009.02.15.05.34.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 15 Feb 2009 05:34:51 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <94a0d4530902150443t38d9253bi85ec42f3afbf0a1d@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110008>

On Sun, Feb 15, 2009 at 02:43:15PM +0200, Felipe Contreras wrote:
> On Sun, Feb 15, 2009 at 2:24 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Hi,
> >
> > On Sun, 15 Feb 2009, Felipe Contreras wrote:
> >
> >> +     switch (types) {
> >> +     case TYPE_BOOL: type = T_BOOL; break;
> >> +     case TYPE_INT: type = T_INT; break;
> >> +     case TYPE_BOOL_OR_INT: type = T_BOOL_OR_INT; break;
> >> +     default: break;
> >> +     }
> >
> > Would it not be nicer to get rid of the variable named "type" and use
> > "types == TYPE_BOOL" and similar statements instead?
> 
> I'm not too sure about that. If you read the code you might think you
> could actually have multiple types, but the same can be said about
> actions.
> 
> Anyway, attached is a patch with that change.

Sorry, again, but now inlined:

---
 builtin-config.c |   32 ++++++++++++++++++++------------
 1 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/builtin-config.c b/builtin-config.c
index 084222a..30de93e 100644
--- a/builtin-config.c
+++ b/builtin-config.c
@@ -19,11 +19,10 @@ static int seen;
 static char delim = '=';
 static char key_delim = ' ';
 static char term = '\n';
-static enum { T_RAW, T_INT, T_BOOL, T_BOOL_OR_INT } type = T_RAW;
 
 static int use_global_config, use_system_config;
 static const char *given_config_file;
-static int actions;
+static int actions, types;
 static const char *get_color_slot, *get_colorbool_slot;
 static int end_null;
 
@@ -39,6 +38,10 @@ static int end_null;
 #define ACTION_LIST (1<<9)
 #define ACTION_EDIT (1<<10)
 
+#define TYPE_BOOL (1<<0)
+#define TYPE_INT (1<<1)
+#define TYPE_BOOL_OR_INT (1<<2)
+
 static struct option builtin_config_options[] = {
 	OPT_GROUP("Config file location"),
 	OPT_BOOLEAN(0, "global", &use_global_config, "use global config file"),
@@ -57,9 +60,9 @@ static struct option builtin_config_options[] = {
 	OPT_BIT('l', "list", &actions, "list all", ACTION_LIST),
 	OPT_BIT('e', "edit", &actions, "opens an editor", ACTION_EDIT),
 	OPT_GROUP("Type"),
-	OPT_SET_INT(0, "bool", &type, "value is \"true\" or \"false\"", T_BOOL),
-	OPT_SET_INT(0, "int", &type, "value is decimal number", T_INT),
-	OPT_SET_INT(0, "bool-or-int", &type, NULL, T_BOOL_OR_INT),
+	OPT_BIT(0, "bool", &types, "value is \"true\" or \"false\"", TYPE_BOOL),
+	OPT_BIT(0, "int", &types, "value is decimal number", TYPE_INT),
+	OPT_BIT(0, "bool-or-int", &types, NULL, TYPE_BOOL_OR_INT),
 	OPT_STRING(0, "get-color", &get_color_slot, "slot", "find the color configured: [default]"),
 	OPT_STRING(0, "get-colorbool", &get_colorbool_slot, "slot", "find the color setting: [stdout-is-tty]"),
 	OPT_GROUP("Other"),
@@ -105,11 +108,11 @@ static int show_config(const char* key_, const char* value_, void *cb)
 	}
 	if (seen && !do_all)
 		dup_error = 1;
-	if (type == T_INT)
+	if (types & TYPE_INT)
 		sprintf(value, "%d", git_config_int(key_, value_?value_:""));
-	else if (type == T_BOOL)
+	else if (types & TYPE_BOOL)
 		vptr = git_config_bool(key_, value_) ? "true" : "false";
-	else if (type == T_BOOL_OR_INT) {
+	else if (types & TYPE_BOOL_OR_INT) {
 		int is_bool, v;
 		v = git_config_bool_or_int(key_, value_, &is_bool);
 		if (is_bool)
@@ -208,18 +211,18 @@ static char *normalize_value(const char *key, const char *value)
 	if (!value)
 		return NULL;
 
-	if (type == T_RAW)
+	if (types == 0)
 		normalized = xstrdup(value);
 	else {
 		normalized = xmalloc(64);
-		if (type == T_INT) {
+		if (types & TYPE_INT) {
 			int v = git_config_int(key, value);
 			sprintf(normalized, "%d", v);
 		}
-		else if (type == T_BOOL)
+		else if (types & TYPE_BOOL)
 			sprintf(normalized, "%s",
 				git_config_bool(key, value) ? "true" : "false");
-		else if (type == T_BOOL_OR_INT) {
+		else if (types & TYPE_BOOL_OR_INT) {
 			int is_bool, v;
 			v = git_config_bool_or_int(key, value, &is_bool);
 			if (!is_bool)
@@ -336,6 +339,11 @@ int cmd_config(int argc, const char **argv, const char *unused_prefix)
 		key_delim = '\n';
 	}
 
+	if (HAS_MULTI_BITS(types)) {
+		error("only one type at a time.");
+		usage_with_options(builtin_config_usage, builtin_config_options);
+	}
+
 	if (HAS_MULTI_BITS(actions)) {
 		error("only one action at a time.");
 		usage_with_options(builtin_config_usage, builtin_config_options);
-- 
1.6.1.3

-- 
Felipe Contreras
