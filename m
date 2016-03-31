From: Elena Petrashen <elena.petrashen@gmail.com>
Subject: [PATCH v3][Outreachy] branch -D: allow - as abbreviation of @{-1}
Date: Thu, 31 Mar 2016 12:25:27 +0300
Message-ID: <1459416327-795-1-git-send-email-elena.petrashen@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	matthieu.moy@grenoble-inp.fr,
	Elena Petrashen <elena.petrashen@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 11:25:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alYrQ-0005js-MY
	for gcvg-git-2@plane.gmane.org; Thu, 31 Mar 2016 11:25:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756342AbcCaJZn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 31 Mar 2016 05:25:43 -0400
Received: from mail-lb0-f196.google.com ([209.85.217.196]:36218 "EHLO
	mail-lb0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756021AbcCaJZj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2016 05:25:39 -0400
Received: by mail-lb0-f196.google.com with SMTP id q4so6365431lbq.3
        for <git@vger.kernel.org>; Thu, 31 Mar 2016 02:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ckwGSUG7UCXO0RoJuCNZ+AQMq0EzjBlUID9UVOzBD8=;
        b=lsubzeABJGhawr3B6vW++lcnDh9CeTv46VRCVEjeAnKpfN8JDFsuxLiPclbmvjQhGL
         +Ylt1+at0+Y3vLJP91z+V5TT0NDrfVQn5GTPznEad5f7pH26pjFP1Hvpf9EVQoAtxQcP
         nypi66maGJ0V7KtholuWt7QyqS9N6Z1qlvelf13zhLL1hVM3qRdy1jdryfwZ0S67zbnm
         lgMZ7SnEoZFKx+/zjh6VNB8ySXDK9TBLNsFJS6N8nF5vwj3lHZlYFgnIDIZo+LSOwJib
         wh05af2XKzVyS0uyQFt3kSow7DZlnzGaNbUI522VwE9m/8T+JsyBuB2Hv6m95l7samTd
         IApA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1ckwGSUG7UCXO0RoJuCNZ+AQMq0EzjBlUID9UVOzBD8=;
        b=g0cIw7BACLo+7z06pGZK2F2BXqHIVcGIn7UxKIQcEf/ZEJAnZfUeo9VWnj7iv2y3tw
         pyGvllgglG/2AWaJcDaydcHwaBCXuyFqDqc1ISy+amWJ8N0/5qQXoIv0J4AhjNhZEHnW
         r2AcQkXNzeKsaw62o6yRspZmqDGY2EJFx97Y0y3bdbrn7rFd3S0S2Tv2INenXmcOPcsB
         eGB7zRH8cRIYzAUaQrjtcfQZwKuvBr+n8hC1SjQYHgwHSH6rl1BSrpZZpkmuiMwiJKEE
         SJHvYog0qR0zTqZGrOaeMGcIzXoDKebtC1sVPrULK14cqksd91qBQJAu0mj1w2FdbE3l
         L52g==
X-Gm-Message-State: AD7BkJJ1d/AN0ejowZ1cY2WL6sgq453UcIuYYGwU7FpA1SCxwwS2mMGtRPEQpqlLjTsMLg==
X-Received: by 10.112.185.68 with SMTP id fa4mr6132254lbc.143.1459416337337;
        Thu, 31 Mar 2016 02:25:37 -0700 (PDT)
Received: from localhost.localdomain ([37.153.43.108])
        by smtp.gmail.com with ESMTPSA id ub6sm1223242lbb.17.2016.03.31.02.25.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 31 Mar 2016 02:25:36 -0700 (PDT)
X-Mailer: git-send-email 2.8.0.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290377>

Signed-off-by: Elena Petrashen <elena.petrashen@gmail.com>
---
This micro-patch is meant to allow =E2=80=9C-=E2=80=9C as a short-hand =
for
=E2=80=9C@{-1} for branch -d (Cf. $gmane/230828). Based on feedback
for v2:

* suppressable advice on restoring if a user deletes a branch
via @{-x} or - reference (to ensure safety: if a user deleted
the wrong branch instead what she thought is @{-1}, which seems
to be more likely compared with the situation when branch name
has to be typed in)

* if not enough switches exist to delete branch via @{-x} or -
reference, a corresponding warning is displayed=20

Thank you! Looking forward to any feedback.

 Documentation/git-branch.txt |  2 ++
 advice.c                     | 10 ++++++++++
 advice.h                     |  2 ++
 builtin/branch.c             | 22 +++++++++++++++++++---
 t/t3200-branch.sh            | 10 ++++++++++
 5 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
index 4a7037f..42b96ed 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -65,6 +65,8 @@ to happen.
 With a `-d` or `-D` option, `<branchname>` will be deleted.  You may
 specify more than one branch for deletion.  If the branch currently
 has a reflog then the reflog will also be deleted.
+The "@{-N}" syntax for the N-th last branch deletes the specified bran=
ch.
+You may also specify - which is synonymous with "@{-1}".
=20
 Use `-r` together with `-d` to delete remote-tracking branches. Note, =
that it
 only makes sense to delete remote-tracking branches if they no longer =
exist
diff --git a/advice.c b/advice.c
index 4dc5cf1..f14eb68 100644
--- a/advice.c
+++ b/advice.c
@@ -15,6 +15,7 @@ int advice_detached_head =3D 1;
 int advice_set_upstream_failure =3D 1;
 int advice_object_name_warning =3D 1;
 int advice_rm_hints =3D 1;
+int advice_delete_branch_via_at_ref =3D 1;
=20
 static struct {
 	const char *name;
@@ -35,6 +36,7 @@ static struct {
 	{ "setupstreamfailure", &advice_set_upstream_failure },
 	{ "objectnamewarning", &advice_object_name_warning },
 	{ "rmhints", &advice_rm_hints },
+	{ "deletebranchviaatref", &advice_delete_branch_via_at_ref },
=20
 	/* make this an alias for backward compatibility */
 	{ "pushnonfastforward", &advice_push_update_rejected }
@@ -117,3 +119,11 @@ void detach_advice(const char *new_name)
=20
 	fprintf(stderr, fmt, new_name);
 }
+
+void delete_branch_advice(const char *name, const char *ref)
+{
+	const char fmt[] =3D
+	"\nNote: to restore the deleted branch:\n\ngit branch %s %s\n";
+
+	fprintf(stderr, fmt, name, ref);
+}
diff --git a/advice.h b/advice.h
index b341a55..192eef7 100644
--- a/advice.h
+++ b/advice.h
@@ -18,6 +18,7 @@ extern int advice_detached_head;
 extern int advice_set_upstream_failure;
 extern int advice_object_name_warning;
 extern int advice_rm_hints;
+extern int advice_delete_branch_via_at_ref;
=20
 int git_default_advice_config(const char *var, const char *value);
 __attribute__((format (printf, 1, 2)))
@@ -26,5 +27,6 @@ int error_resolve_conflict(const char *me);
 extern void NORETURN die_resolve_conflict(const char *me);
 void NORETURN die_conclude_merge(void);
 void detach_advice(const char *new_name);
+void delete_branch_advice(const char *name, const char *ref);
=20
 #endif /* ADVICE_H */
diff --git a/builtin/branch.c b/builtin/branch.c
index 7b45b6b..4f5ec72 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -178,6 +178,12 @@ static void delete_branch_config(const char *branc=
hname)
 	strbuf_release(&buf);
 }
=20
+static void expand_dash_shortcut(const char **argv, int dash_position)
+{
+	if (!strcmp(argv[dash_position], "-"))
+		argv[dash_position] =3D "@{-1}";
+}
+
 static int delete_branches(int argc, const char **argv, int force, int=
 kinds,
 			   int quiet)
 {
@@ -187,6 +193,7 @@ static int delete_branches(int argc, const char **a=
rgv, int force, int kinds,
 	const char *fmt;
 	int i;
 	int ret =3D 0;
+	int at_shortcut =3D 0;
 	int remote_branch =3D 0;
 	struct strbuf bname =3D STRBUF_INIT;
=20
@@ -214,6 +221,9 @@ static int delete_branches(int argc, const char **a=
rgv, int force, int kinds,
 		const char *target;
 		int flags =3D 0;
=20
+		expand_dash_shortcut (argv, i);
+		if(!strncmp(argv[i], "@{-", strlen("@{-")))
+			at_shortcut =3D 1;
 		strbuf_branchname(&bname, argv[i]);
 		if (kinds =3D=3D FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
 			error(_("Cannot delete the branch '%s' "
@@ -231,9 +241,12 @@ static int delete_branches(int argc, const char **=
argv, int force, int kinds,
 					    | RESOLVE_REF_ALLOW_BAD_NAME,
 					    sha1, &flags);
 		if (!target) {
-			error(remote_branch
-			      ? _("remote-tracking branch '%s' not found.")
-			      : _("branch '%s' not found."), bname.buf);
+			error((!strncmp(bname.buf, "@{-", strlen("@{-")))
+				? _("There is not enough branch switches to"
+					" delete '%s'.")
+				: remote_branch
+					? _("remote-tracking branch '%s' not found.")
+					: _("branch '%s' not found."), bname.buf);
 			ret =3D 1;
 			continue;
 		}
@@ -262,6 +275,9 @@ static int delete_branches(int argc, const char **a=
rgv, int force, int kinds,
 			       (flags & REF_ISBROKEN) ? "broken"
 			       : (flags & REF_ISSYMREF) ? target
 			       : find_unique_abbrev(sha1, DEFAULT_ABBREV));
+			if (at_shortcut && advice_delete_branch_via_at_ref)
+			       delete_branch_advice (bname.buf,
+				find_unique_abbrev(sha1, DEFAULT_ABBREV));
 		}
 		delete_branch_config(bname.buf);
 	}
diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index a897248..0b59c94 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -372,6 +372,16 @@ test_expect_success 'test overriding tracking setu=
p via --no-track' '
 	! test "$(git config branch.my2.merge)" =3D refs/heads/master
 '
=20
+test_expect_success 'test deleting "-" deletes previous branch' '
+	git checkout -b prev &&
+	test_commit prev &&
+	git checkout master &&
+	git branch -D - >actual &&
+	sha1=3D$(git rev-parse prev | cut -c 1-7) &&
+	echo "Deleted branch prev (was $sha1)." >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'no tracking without .fetch entries' '
 	git config branch.autosetupmerge true &&
 	git branch my6 s &&
--=20
2.8.0.dirty
