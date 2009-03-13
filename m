From: Benjamin Kramer <benny.kra@googlemail.com>
Subject: [PATCH] Remove unused assignments
Date: Fri, 13 Mar 2009 13:51:33 +0100
Message-ID: <49BA56D5.5050807@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 13 13:53:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li6sv-0005VB-2w
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 13:53:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753056AbZCMMvm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 08:51:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752389AbZCMMvl
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 08:51:41 -0400
Received: from mail-fx0-f176.google.com ([209.85.220.176]:44975 "EHLO
	mail-fx0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750910AbZCMMvk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 08:51:40 -0400
Received: by fxm24 with SMTP id 24so2633202fxm.37
        for <git@vger.kernel.org>; Fri, 13 Mar 2009 05:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:content-type
         :content-transfer-encoding;
        bh=pu8/TCDDMKL9wBr5UDY1vZnaZ93YTbJkO7kn54Of1Gc=;
        b=sL2OTHvGG94TZcHij8wEXFCa734Nlt6T0gNpnN/cK8qiPCsEsW5dvprl8C7Qj/REut
         tWOl89xjaWbL8NtJCLFx6r3L41hCuOz0HVZiC4oroBzQLAY+H8FnmQYfu17roOLjJNhd
         NVT5y5iP4ukjWzvyy0JHhUGYLW8oiMzBFi8Ec=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :content-type:content-transfer-encoding;
        b=s+6pwvf4YFQVGd7pu/PCb2yY+rFYXlMdBjfVIm0dTOhX4frVLEqB+7hG64u9pG9pY6
         DK3f6xxV1ANnGHolNCoXCM22FoteJlou09DNDv3FZyPovHUX7dn0JrmO1CV90g2+tF1I
         N+rmjWZbs/lJlAlY2Q6LqXs0peHF9r90uAjGc=
Received: by 10.103.24.17 with SMTP id b17mr631371muj.112.1236948696684;
        Fri, 13 Mar 2009 05:51:36 -0700 (PDT)
Received: from golden.local (p5B01EE39.dip.t-dialin.net [91.1.238.57])
        by mx.google.com with ESMTPS id b9sm3522536mug.2.2009.03.13.05.51.35
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 13 Mar 2009 05:51:36 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.19 (Macintosh/20081209)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113180>

These variables were always overwritten or the assigned
value was unused:

builtin-diff-tree.c::cmd_diff_tree(): nr_sha1
builtin-for-each-ref.c::opt_parse_sort(): sort_tail
builtin-mailinfo.c::decode_header_bq(): in
builtin-shortlog.c::insert_one_record(): len
connect.c::git_connect(): path
imap-send.c::v_issue_imap_cmd(): n
pretty.c::pp_user_info(): filler
remote::parse_refspec_internal(): llen

Signed-off-by: Benjamin Kramer <benny.kra@googlemail.com>
---
 builtin-diff-tree.c    |    1 -
 builtin-for-each-ref.c |    1 -
 builtin-mailinfo.c     |    1 -
 builtin-shortlog.c     |    1 -
 connect.c              |    2 +-
 imap-send.c            |    2 +-
 pretty.c               |    1 -
 remote.c               |    2 +-
 8 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/builtin-diff-tree.c b/builtin-diff-tree.c
index 8ecefd4..79cedb7 100644
--- a/builtin-diff-tree.c
+++ b/builtin-diff-tree.c
@@ -102,7 +102,6 @@ int cmd_diff_tree(int argc, const char **argv, const char *prefix)
 
 	init_revisions(opt, prefix);
 	git_config(git_diff_basic_config, NULL); /* no "diff" UI options */
-	nr_sha1 = 0;
 	opt->abbrev = 0;
 	opt->diff = 1;
 	argc = setup_revisions(argc, argv, opt, NULL);
diff --git a/builtin-for-each-ref.c b/builtin-for-each-ref.c
index e46b7ad..5cbb4b0 100644
--- a/builtin-for-each-ref.c
+++ b/builtin-for-each-ref.c
@@ -943,7 +943,6 @@ static int opt_parse_sort(const struct option *opt, const char *arg, int unset)
 		return -1;
 
 	*sort_tail = s = xcalloc(1, sizeof(*s));
-	sort_tail = &s->next;
 
 	if (*arg == '-') {
 		s->reverse = 1;
diff --git a/builtin-mailinfo.c b/builtin-mailinfo.c
index 2789ccd..1eeeb4d 100644
--- a/builtin-mailinfo.c
+++ b/builtin-mailinfo.c
@@ -537,7 +537,6 @@ static int decode_header_bq(struct strbuf *it)
 				 */
 				strbuf_add(&outbuf, in, ep - in);
 			}
-			in = ep;
 		}
 		/* E.g.
 		 * ep : "=?iso-2022-jp?B?GyR...?= foo"
diff --git a/builtin-shortlog.c b/builtin-shortlog.c
index badd912..b28091b 100644
--- a/builtin-shortlog.c
+++ b/builtin-shortlog.c
@@ -101,7 +101,6 @@ static void insert_one_record(struct shortlog *log,
 	}
 	while (*oneline && isspace(*oneline) && *oneline != '\n')
 		oneline++;
-	len = eol - oneline;
 	format_subject(&subject, oneline, " ");
 	buffer = strbuf_detach(&subject, NULL);
 
diff --git a/connect.c b/connect.c
index 0a35cc1..7636bf9 100644
--- a/connect.c
+++ b/connect.c
@@ -504,7 +504,7 @@ struct child_process *git_connect(int fd[2], const char *url_orig,
 				  const char *prog, int flags)
 {
 	char *url = xstrdup(url_orig);
-	char *host, *path = url;
+	char *host, *path;
 	char *end;
 	int c;
 	struct child_process *conn;
diff --git a/imap-send.c b/imap-send.c
index cb518eb..8154cb2 100644
--- a/imap-send.c
+++ b/imap-send.c
@@ -579,7 +579,7 @@ static struct imap_cmd *v_issue_imap_cmd(struct imap_store *ctx,
 			n = socket_write(&imap->buf.sock, cmd->cb.data, cmd->cb.dlen);
 			free(cmd->cb.data);
 			if (n != cmd->cb.dlen ||
-			    (n = socket_write(&imap->buf.sock, "\r\n", 2)) != 2) {
+			    socket_write(&imap->buf.sock, "\r\n", 2) != 2) {
 				free(cmd->cmd);
 				free(cmd);
 				return NULL;
diff --git a/pretty.c b/pretty.c
index c018408..3a24cd5 100644
--- a/pretty.c
+++ b/pretty.c
@@ -154,7 +154,6 @@ void pp_user_info(const char *what, enum cmit_fmt fmt, struct strbuf *sb,
 		while (line < name_tail && isspace(name_tail[-1]))
 			name_tail--;
 		display_name_length = name_tail - line;
-		filler = "";
 		strbuf_addstr(sb, "From: ");
 		add_rfc2047(sb, line, display_name_length, encoding);
 		strbuf_add(sb, name_tail, namelen - display_name_length);
diff --git a/remote.c b/remote.c
index d7079c6..7efaa02 100644
--- a/remote.c
+++ b/remote.c
@@ -495,7 +495,7 @@ static struct refspec *parse_refspec_internal(int nr_refspec, const char **refsp
 		int is_glob;
 		const char *lhs, *rhs;
 
-		llen = is_glob = 0;
+		is_glob = 0;
 
 		lhs = refspec[i];
 		if (*lhs == '+') {
-- 
1.6.2.169.g92418
