From: Kenneth Lorber <keni@his.com>
Subject: Re: bug & patch: exit codes from internal commands are handled incorrectly
Date: Sun, 1 Feb 2015 17:32:52 -0500
Message-ID: <4B764581-0053-467C-93B5-C238EF5AE112@his.com>
References: <13474FB1-5310-42E5-82A9-4047FEFEFF4A@his.com> <885593BD-3024-4811-83A5-D3A0C4CE6AC1@his.com> <xmqqegrw7omv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: multipart/mixed; boundary="Apple-Mail=_2A270FC3-8F24-4DFC-8B89-7B4BD4309535"
Cc: git@vger.kernel.org, Kenneth Lorber <keni@his.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 01 23:38:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YI3AC-0006Oa-L5
	for gcvg-git-2@plane.gmane.org; Sun, 01 Feb 2015 23:38:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753798AbbBAWij (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2015 17:38:39 -0500
Received: from smtp-nf-106.his.com ([216.194.251.35]:43699 "EHLO
	smtp-nf-106.his.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752284AbbBAWii (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2015 17:38:38 -0500
X-Greylist: delayed 342 seconds by postgrey-1.27 at vger.kernel.org; Sun, 01 Feb 2015 17:38:38 EST
Received: from cuda201.his.com (cuda201.his.com [216.194.248.226])
	by smtp-nf-106.his.com (Postfix) with ESMTPS id 7675960986
	for <git@vger.kernel.org>; Sun,  1 Feb 2015 17:32:55 -0500 (EST)
X-ASG-Debug-ID: 1422829974-061c4142fb318a80001-QuoKaX
Received: from smtp-nf-202.his.com (smtp-nf-202.his.com [216.194.248.252]) by cuda201.his.com with ESMTP id D2vA9q5bCcawmbGZ; Sun, 01 Feb 2015 17:32:54 -0500 (EST)
X-Barracuda-Envelope-From: keni@his.com
X-Barracuda-RBL-Trusted-Forwarder: 216.194.248.252
Received: from mail-sterling.his.com (mail-sterling.his.com [216.194.248.141])
	by smtp-nf-202.his.com (Postfix) with ESMTP id 4DE7660271;
	Sun,  1 Feb 2015 17:32:54 -0500 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail-sterling.his.com (Postfix) with ESMTP id A9E243FF0003;
	Sun,  1 Feb 2015 17:32:53 -0500 (EST)
X-Barracuda-RBL-Trusted-Forwarder: 216.194.248.141
X-Virus-Scanned: amavisd-new at mail-sterling.his.com
Received: from mail-sterling.his.com ([127.0.0.1])
	by localhost (mail-sterling.his.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dIx9gDcLUu2n; Sun,  1 Feb 2015 17:32:53 -0500 (EST)
Received: from polyhymnia.home (pool-71-178-17-254.washdc.fios.verizon.net [71.178.17.254])
	by mail-sterling.his.com (Postfix) with ESMTPSA id A6D533FB0009;
	Sun,  1 Feb 2015 17:32:52 -0500 (EST)
X-Barracuda-Apparent-Source-IP: 71.178.17.254
X-ASG-Orig-Subj: Re: bug & patch: exit codes from internal commands are handled incorrectly
In-Reply-To: <xmqqegrw7omv.fsf@gitster.dls.corp.google.com>
X-Mailer: Apple Mail (2.1878.6)
X-Barracuda-Connect: smtp-nf-202.his.com[216.194.248.252]
X-Barracuda-Start-Time: 1422829974
X-Barracuda-URL: https://spam.his.com:443/cgi-mod/mark.cgi
Received-SPF: pass (his.com: domain of keni@his.com designates 216.194.248.141 as permitted sender)
X-Virus-Scanned: by bsmtpd at his.com
X-Barracuda-BRTS-Status: 1
X-Barracuda-Spam-Score: 0.50
X-Barracuda-Spam-Status: No, SCORE=0.50 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=BSF_RULE7568M
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.14842
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.50 BSF_RULE7568M          Custom Rule 7568M
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263243>


--Apple-Mail=_2A270FC3-8F24-4DFC-8B89-7B4BD4309535
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On Dec 18, 2014, at 2:18 PM, Junio C Hamano <gitster@pobox.com> wrote:

> Kenneth Lorber <keni@his.com> writes:
>=20
>>> Bug: exit codes from (at least) internal commands are handled =
incorrectly.
>>> E.g. git-merge-file, docs say:
>>>       The exit value of this program is negative on error, and the =
number of
>>>       conflicts otherwise. If the merge was clean, the exit value is =
0.
>>> But only 8 bits get carried through exit, so 256 conflicts gives
>>> exit(0), which means the merge was clean.
>=20
> Wouldn't any cmd_foo() that returns negative to main() be buggy?

Yes.

>=20
> Your change sweeps such problems under the rug, which is not a
> healthy thing to do.

Agreed.  (See below.)

>=20
> Expecting that the exit code can signal small positive integers and
> other generic kinds of failures is a losing proposition.  I think it
> is a better fix to update cmd_merge_file() to return 1 (when ret is
> positive), 0 (when ret is zero) or 128 (when ret is negative), or
> something simple like that, and update the documentation to match
> that, without touching git.c::main().

The new patch uses 0, 1, and 2 to match diff(1).

> Among the in-tree users, I notice git-cvsserver.perl is already
> using the command incorrectly.  It does this:
>=20
>            my $return =3D system("git", "merge-file", $file_local, =
$file_old, $file_new);
>            $return >>=3D 8;
>=20
>            cleanupTmpDir();
>=20
>            if ( $return =3D=3D 0 )
>            {
>                $log->info("Merged successfully");
>                ...
>            }
>            elsif ( $return =3D=3D 1 )
>            {
>                $log->info("Merged with conflicts");
>                ...
>            }
>            else
>            {
>                $log->warn("Merge failed");
>                next;
>            }
>=20
> which assumes $return =3D=3D 1 is special "half-good", which is not
> consistent with the documented interface.  It will incorrectly
> say "Merge failed" when there are two or more conflicts.
>=20
> And with such a "1 or 0 or -1" change, you will fix that caller as
> well ;-)

I'll call that a win.

The attached patch covers the following:
- fixes all places where "make test" attempts to call exit() with a =
value <0 or >255
- changes git-merge-file.txt to reflect the change in exit codes
- fixes the exit codes for merge-file
- adds a warning (which should probably be changed to something clearer) =
if git.c:run_builtin() is going to cause an out-of-bounds exit
- fixes a typo in t7007-show.sh
- replaces return(0) with exit(0) in test-parse-options.c

The diff is cut against 15598cf41beed0d86cd2ac443e0f69c5a3b40321 =
(2.3.0-rc2)

Thanks,
Keni



--Apple-Mail=_2A270FC3-8F24-4DFC-8B89-7B4BD4309535
Content-Disposition: attachment;
	filename=d2.ship
Content-Type: application/octet-stream;
	name="d2.ship"
Content-Transfer-Encoding: 7bit

diff --git a/Documentation/git-merge-file.txt b/Documentation/git-merge-file.txt
index d2fc12e..425dba3 100644
--- a/Documentation/git-merge-file.txt
+++ b/Documentation/git-merge-file.txt
@@ -40,8 +40,8 @@ however, these conflicts are resolved favouring lines from `<current-file>`,
 lines from `<other-file>`, or lines from both respectively.  The length of the
 conflict markers can be given with the `--marker-size` option.
 
-The exit value of this program is negative on error, and the number of
-conflicts otherwise. If the merge was clean, the exit value is 0.
+The exit value of this program is 0 if the merge was clean, 1 if there were
+conflicts, and 2 if an error occured.
 
 'git merge-file' is designed to be a minimal clone of RCS 'merge'; that is, it
 implements all of RCS 'merge''s functionality which is needed by
diff --git a/builtin/branch.c b/builtin/branch.c
index dc6f0b2..e586846 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -938,10 +938,10 @@ int cmd_branch(int argc, const char **argv, const char *prefix)
 			strbuf_release(&branch_ref);
 
 			if (!argc)
-				return error(_("No commit on branch '%s' yet."),
+				return -error(_("No commit on branch '%s' yet."),
 					     branch_name);
 			else
-				return error(_("No branch named '%s'."),
+				return -error(_("No branch named '%s'."),
 					     branch_name);
 		}
 		strbuf_release(&branch_ref);
diff --git a/builtin/check-attr.c b/builtin/check-attr.c
index 5600ec3..62cacf3 100644
--- a/builtin/check-attr.c
+++ b/builtin/check-attr.c
@@ -169,7 +169,7 @@ int cmd_check_attr(int argc, const char **argv, const char *prefix)
 			name = argv[i];
 			a = git_attr(name);
 			if (!a)
-				return error("%s: not a valid attribute name",
+				return -error("%s: not a valid attribute name",
 					name);
 			check[i].attr = a;
 		}
diff --git a/builtin/config.c b/builtin/config.c
index 15a7bea..23aab25 100644
--- a/builtin/config.c
+++ b/builtin/config.c
@@ -667,7 +667,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		ret = git_config_rename_section_in_file(given_config_source.file,
 							argv[0], argv[1]);
 		if (ret < 0)
-			return ret;
+			return -ret;
 		if (ret == 0)
 			die("No such section!");
 	}
@@ -678,7 +678,7 @@ int cmd_config(int argc, const char **argv, const char *prefix)
 		ret = git_config_rename_section_in_file(given_config_source.file,
 							argv[0], NULL);
 		if (ret < 0)
-			return ret;
+			return -ret;
 		if (ret == 0)
 			die("No such section!");
 	}
diff --git a/builtin/log.c b/builtin/log.c
index 923ffe7..cb6914b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -561,7 +561,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 				break;
 			o = parse_object(t->tagged->sha1);
 			if (!o)
-				ret = error(_("Could not read object %s"),
+				ret = -error(_("Could not read object %s"),
 					    sha1_to_hex(t->tagged->sha1));
 			objects[i].item = o;
 			i--;
@@ -585,7 +585,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			ret = cmd_log_walk(&rev);
 			break;
 		default:
-			ret = error(_("Unknown type: %d"), o->type);
+			ret = -error(_("Unknown type: %d"), o->type);
 		}
 	}
 	free(objects);
diff --git a/builtin/merge-file.c b/builtin/merge-file.c
index 844f84f..8dfb42c 100644
--- a/builtin/merge-file.c
+++ b/builtin/merge-file.c
@@ -61,9 +61,11 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 	if (argc != 3)
 		usage_with_options(merge_file_usage, options);
 	if (quiet) {
-		if (!freopen("/dev/null", "w", stderr))
-			return error("failed to redirect stderr to /dev/null: "
+		if (!freopen("/dev/null", "w", stderr)) {
+			error("failed to redirect stderr to /dev/null: "
 				     "%s", strerror(errno));
+			return 2;
+		}
 	}
 
 	if (prefix)
@@ -74,10 +76,12 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 		if (!names[i])
 			names[i] = argv[i];
 		if (read_mmfile(mmfs + i, fname))
-			return -1;
-		if (buffer_is_binary(mmfs[i].ptr, mmfs[i].size))
-			return error("Cannot merge binary files: %s",
+			return 2;
+		if (buffer_is_binary(mmfs[i].ptr, mmfs[i].size)) {
+			error("Cannot merge binary files: %s",
 					argv[i]);
+			return 2;
+		}
 	}
 
 	xmp.ancestor = names[1];
@@ -100,7 +104,11 @@ int cmd_merge_file(int argc, const char **argv, const char *prefix)
 		else if (fclose(f))
 			ret = error("Could not close %s", filename);
 		free(result.ptr);
+
+		if (ret == -1) return 2;	/* error */
+		if (ret == 0) return 0;		/* no conflicts */
+		return 1;			/* conflicts */
 	}
 
-	return ret;
+	return 2;	/* error */
 }
diff --git a/builtin/replace.c b/builtin/replace.c
index 85d39b5..5ff7ee1 100644
--- a/builtin/replace.c
+++ b/builtin/replace.c
@@ -299,7 +299,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
 	free(tmpfile);
 
 	if (!hashcmp(old, new))
-		return error("new object is the same as the old one: '%s'", sha1_to_hex(old));
+		return -error("new object is the same as the old one: '%s'", sha1_to_hex(old));
 
 	return replace_object_sha1(object_ref, old, "replacement", new, force);
 }
@@ -410,7 +410,7 @@ static int create_graft(int argc, const char **argv, int force)
 	strbuf_release(&buf);
 
 	if (!hashcmp(old, new))
-		return error("new commit is the same as the old one: '%s'", sha1_to_hex(old));
+		return -error("new commit is the same as the old one: '%s'", sha1_to_hex(old));
 
 	return replace_object_sha1(old_ref, old, "replacement", new, force);
 }
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index b564a77..7b7f6cd 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -277,7 +277,7 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 
 	/* match them up */
 	if (match_push_refs(local_refs, &remote_refs, nr_refspecs, refspecs, flags))
-		return -1;
+		return 1;
 
 	if (!is_empty_cas(&cas))
 		apply_push_cas(&cas, remote, remote_refs);
@@ -307,5 +307,5 @@ int cmd_send_pack(int argc, const char **argv, const char *prefix)
 	if (!ret && !transport_refs_pushed(remote_refs))
 		fprintf(stderr, "Everything up-to-date\n");
 
-	return ret;
+	return (ret<0) ? -ret : ret;
 }
diff --git a/git.c b/git.c
index 6b5ae6a..b6a75e9 100644
--- a/git.c
+++ b/git.c
@@ -346,6 +346,8 @@ static int run_builtin(struct cmd_struct *p, int argc, const char **argv)
 	trace_argv_printf(argv, "trace: built-in: git");
 
 	status = p->fn(argc, argv, prefix);
+	if(status < 0 || status >255)
+		warning("internal bad status (no effect on the git command)");
 	if (status)
 		return status;
 
diff --git a/run-command.c b/run-command.c
index 0b432cc..353acc8 100644
--- a/run-command.c
+++ b/run-command.c
@@ -567,6 +567,14 @@ int run_command(struct child_process *cmd)
 	return finish_command(cmd);
 }
 
+int run_command2(struct child_process *cmd)
+{
+	int code = start_command(cmd);
+	if (code)
+		return code<0 ? -code : code;
+	return finish_command(cmd);
+}
+
 int run_command_v_opt(const char **argv, int opt)
 {
 	return run_command_v_opt_cd_env(argv, opt, NULL, NULL);
diff --git a/run-command.h b/run-command.h
index d6868dc..afa0212 100644
--- a/run-command.h
+++ b/run-command.h
@@ -51,6 +51,7 @@ void child_process_init(struct child_process *);
 int start_command(struct child_process *);
 int finish_command(struct child_process *);
 int run_command(struct child_process *);
+int run_command2(struct child_process *);
 
 extern char *find_hook(const char *name);
 LAST_ARG_MUST_BE_NULL
diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index 1b824fe..e7272bb 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -13,7 +13,7 @@ test_expect_success setup '
 	rm -f .git/objects/$HH/$H38
 '
 
-test_expect_success 'showing a tag that point at a missing object' '
+test_expect_success 'showing a tag that points at a missing object' '
 	test_must_fail git --no-pager show foo-tag
 '
 
diff --git a/test-parse-options.c b/test-parse-options.c
index 5dabce6..8dba84f 100644
--- a/test-parse-options.c
+++ b/test-parse-options.c
@@ -97,5 +97,5 @@ int main(int argc, char **argv)
 	for (i = 0; i < argc; i++)
 		printf("arg %02d: %s\n", i, argv[i]);
 
-	return 0;
+	exit(0);
 }
diff --git a/test-run-command.c b/test-run-command.c
index 89c7de2..4d8c230 100644
--- a/test-run-command.c
+++ b/test-run-command.c
@@ -28,7 +28,7 @@ int main(int argc, char **argv)
 		return 1;
 	}
 	if (!strcmp(argv[1], "run-command"))
-		exit(run_command(&proc));
+		exit(run_command2(&proc));
 
 	fprintf(stderr, "check usage\n");
 	return 1;

--Apple-Mail=_2A270FC3-8F24-4DFC-8B89-7B4BD4309535
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii




--Apple-Mail=_2A270FC3-8F24-4DFC-8B89-7B4BD4309535--
