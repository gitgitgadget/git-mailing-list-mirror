Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D10941F404
	for <e@80x24.org>; Fri, 20 Apr 2018 22:20:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752243AbeDTWUn (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Apr 2018 18:20:43 -0400
Received: from mout.gmx.net ([212.227.17.22]:45621 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751865AbeDTWUm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Apr 2018 18:20:42 -0400
Received: from [192.168.0.129] ([37.201.195.116]) by mail.gmx.com (mrgmx101
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lx4dh-1eLO4z0BFh-016gfr; Sat, 21
 Apr 2018 00:20:36 +0200
Date:   Sat, 21 Apr 2018 00:20:18 +0200 (DST)
From:   Johannes Schindelin <johannes.schindelin@gmx.de>
X-X-Sender: virtualbox@MININT-6BKU6QN.europe.corp.microsoft.com
To:     git@vger.kernel.org
cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 00/11] Deprecate .git/info/grafts
In-Reply-To: <cover.1524125760.git.johannes.schindelin@gmx.de>
Message-ID: <cover.1524262793.git.johannes.schindelin@gmx.de>
References: <cover.1524125760.git.johannes.schindelin@gmx.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:IoYvcpiUPxOFkJtbiBA3M1k/7jcRWo791KaD6M5xC4qTB6+cgWr
 mGOjQa/BLUNzziCbteplNl26mel4WS50Emcz33g4Z6krPQtZf4YYp+8pQyVNBK1j7lIE/ZQ
 KOr+0yhnIEVTa0RF48YyVvjx8lPfKvJoaZaxydlb2hjFuZnuppDMnWeQTWtjF/+rSyzePdk
 P2BoEajePum6aWw184+Fw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:nhKy1fMTY90=:5nvw1QUYo/e0K2ieGk2sPv
 dbePRuwN2sI+1CDvq5KZMJy/ekdB8HfmEEywpJMNUdkarVkT0nr5vMzit6Dtl68Qik6SMSoP+
 VgXHWMw7DO+EkTo9gd+h0ED2XewUa594z/MMD3ubTz71kotYWaSkXwrX3qnjtwruJbqYlCIcT
 eagpw7EQ/W33frmnY9YTeH63rkUZBoj08qJN0wE4pGmvB3CDp0esYFJa0YuVxvhHN4IvWKgwQ
 pAd+VEVzSQFUN1do9uSe0cb15339c05aX/UPM2Ou0T/n8SOppd79Dbyy389qPlkKNAietMYzN
 TasrDENy7v/JTJoOuFfRrpOlruckka7zmKmEyPh9EHagfxdKnzA5t96PP9FhqWBGhRihaEuad
 ze7k+nWZAByvk5t5no3Uw0SHKyFdnjJtI/Xjt6me9KSKXUXTnf0flrcj75Bw1mONUhf9r75iF
 pGwtHGVadurot2/g/3DR0pBXe42cSvuRs8rXBmEZrZJ7lolU0tNnnuBHI8DyAFwyg06XYJwb6
 fuERn5tTDyWSNjFTlLpkfF+ScgV7VEsV8ff6JF5AUc+DADY5E85Ae7ZOkG6FcEM0j1Ve3Yi5Z
 gE8OdJlMWH88d7EX0J1//7sxRQbPAUmQtUsCE59cy8tXyd+X3QzYUU+H9i4DIWdOlPYvgM3Fl
 hFaePrL8tvvnJ+PJUf6qMrylQloLJiU/J/gZKYO1sug23/sdT2eH2EZsncxGnYaS7L6ikmenZ
 W3385E66Wsxq+YQyIzjSFH/63yXWheNuMo5Z5/D6OY4QCCmKO2o0AgUgK4IUp3KuLjQwLC088
 lHzDuvD7k4X60vX1kYVVM9uG62YDWgP5CZQsHqLG7w9J9z347g=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is fragile, as there is no way for the revision machinery to say "but
now I want to traverse the graph ignoring the graft file" e.g. when
pushing commits to a remote repository (which, as a consequence, can
miss commits).

And we already have a better solution with `git replace --graft <comit>
[<parent>...]`.

Changes since v2:

- Fixed tyop in the description of --graft where it suggests
  --convert-graft-file instead.

- Dropped the rant from the "libify create_graft()" commit.

- Changed a die("BUG: ...") call to BUG() (instead of libifying it).

- Truly libified create_graft() by replacing every single instance where die()
  (or lookup_commit_or_die()) was called with a proper error(), adding resource
  handling to avoid leaks, so that that rant that was dropped from the commit
  message would now truly be merited.

- Graft files with commented lines are now handled correctly.

- Graft files with empty lines are now handled correctly, too.

- The graft file parser is now based on a shiny new argv_array_split().

- The script in contrib/ whose functionality is superseded by `git replace
  --convert-graft-file` was removed.


Johannes Schindelin (11):
  argv_array: offer to split a string by whitespace
  commit: Let the callback of for_each_mergetag return on error
  replace: avoid using die() to indicate a bug
  replace: "libify" create_graft() and callees
  replace: introduce --convert-graft-file
  Add a test for `git replace --convert-graft-file`
  Deprecate support for .git/info/grafts
  filter-branch: stop suggesting to use grafts
  technical/shallow: describe the relationship with replace refs
  technical/shallow: describe why shallow cannot use replace refs
  Remove obsolete script to convert grafts to replace refs

 Documentation/git-filter-branch.txt       |   2 +-
 Documentation/git-replace.txt             |  11 +-
 Documentation/technical/shallow.txt       |  24 ++-
 advice.c                                  |   2 +
 advice.h                                  |   1 +
 argv-array.c                              |  20 +++
 argv-array.h                              |   1 +
 builtin/replace.c                         | 189 +++++++++++++++-------
 commit.c                                  |  18 ++-
 commit.h                                  |   4 +-
 contrib/convert-grafts-to-replace-refs.sh |  28 ----
 log-tree.c                                |  13 +-
 t/t6001-rev-list-graft.sh                 |   9 ++
 t/t6050-replace.sh                        |  20 +++
 14 files changed, 235 insertions(+), 107 deletions(-)
 delete mode 100755 contrib/convert-grafts-to-replace-refs.sh


base-commit: fe0a9eaf31dd0c349ae4308498c33a5c3794b293
Published-As: https://github.com/dscho/git/releases/tag/deprecate-grafts-v3
Fetch-It-Via: git fetch https://github.com/dscho/git deprecate-grafts-v3

Interdiff vs v2:
 diff --git a/Documentation/git-replace.txt b/Documentation/git-replace.txt
 index 4dc0686f7d6..246dc9943c2 100644
 --- a/Documentation/git-replace.txt
 +++ b/Documentation/git-replace.txt
 @@ -89,7 +89,7 @@ OPTIONS
  	[<parent>...] instead of <commit>'s parents. A replacement ref
  	is then created to replace <commit> with the newly created
  	commit. Use `--convert-graft-file` to convert a
 -	`$GIT_DIR/info/grafts` file use replace refs instead.
 +	`$GIT_DIR/info/grafts` file and use replace refs instead.
  
  --convert-graft-file::
  	Creates graft commits for all entries in `$GIT_DIR/info/grafts`
 diff --git a/argv-array.c b/argv-array.c
 index 5d370fa3366..cb5bcd2c064 100644
 --- a/argv-array.c
 +++ b/argv-array.c
 @@ -64,6 +64,26 @@ void argv_array_pop(struct argv_array *array)
  	array->argc--;
  }
  
 +void argv_array_split(struct argv_array *array, const char *to_split)
 +{
 +	while (isspace(*to_split))
 +		to_split++;
 +	for (;;) {
 +		const char *p = to_split;
 +
 +		if (!*p)
 +			break;
 +
 +		while (*p && !isspace(*p))
 +			p++;
 +		argv_array_push_nodup(array, xstrndup(to_split, p - to_split));
 +
 +		while (isspace(*p))
 +			p++;
 +		to_split = p;
 +	}
 +}
 +
  void argv_array_clear(struct argv_array *array)
  {
  	if (array->argv != empty_argv) {
 diff --git a/argv-array.h b/argv-array.h
 index 29056e49a12..c7c397695df 100644
 --- a/argv-array.h
 +++ b/argv-array.h
 @@ -19,6 +19,7 @@ LAST_ARG_MUST_BE_NULL
  void argv_array_pushl(struct argv_array *, ...);
  void argv_array_pushv(struct argv_array *, const char **);
  void argv_array_pop(struct argv_array *);
 +void argv_array_split(struct argv_array *, const char *);
  void argv_array_clear(struct argv_array *);
  const char **argv_array_detach(struct argv_array *);
  
 diff --git a/builtin/replace.c b/builtin/replace.c
 index 4cdc00a96df..6b3e0301e90 100644
 --- a/builtin/replace.c
 +++ b/builtin/replace.c
 @@ -80,9 +80,9 @@ static int list_replace_refs(const char *pattern, const char *format)
  	else if (!strcmp(format, "long"))
  		data.format = REPLACE_FORMAT_LONG;
  	else
 -		die("invalid replace format '%s'\n"
 -		    "valid formats are 'short', 'medium' and 'long'\n",
 -		    format);
 +		return error("invalid replace format '%s'\n"
 +			     "valid formats are 'short', 'medium' and 'long'\n",
 +			     format);
  
  	for_each_replace_ref(show_reference, (void *)&data);
  
 @@ -135,7 +135,7 @@ static int delete_replace_ref(const char *name, const char *ref,
  	return 0;
  }
  
 -static void check_ref_valid(struct object_id *object,
 +static int check_ref_valid(struct object_id *object,
  			    struct object_id *prev,
  			    struct strbuf *ref,
  			    int force)
 @@ -143,12 +143,13 @@ static void check_ref_valid(struct object_id *object,
  	strbuf_reset(ref);
  	strbuf_addf(ref, "%s%s", git_replace_ref_base, oid_to_hex(object));
  	if (check_refname_format(ref->buf, 0))
 -		die("'%s' is not a valid ref name.", ref->buf);
 +		return error("'%s' is not a valid ref name.", ref->buf);
  
  	if (read_ref(ref->buf, prev))
  		oidclr(prev);
  	else if (!force)
 -		die("replace ref '%s' already exists", ref->buf);
 +		return error("replace ref '%s' already exists", ref->buf);
 +	return 0;
  }
  
  static int replace_object_oid(const char *object_ref,
 @@ -162,28 +163,31 @@ static int replace_object_oid(const char *object_ref,
  	struct strbuf ref = STRBUF_INIT;
  	struct ref_transaction *transaction;
  	struct strbuf err = STRBUF_INIT;
 +	int res = 0;
  
  	obj_type = oid_object_info(object, NULL);
  	repl_type = oid_object_info(repl, NULL);
  	if (!force && obj_type != repl_type)
 -		die("Objects must be of the same type.\n"
 -		    "'%s' points to a replaced object of type '%s'\n"
 -		    "while '%s' points to a replacement object of type '%s'.",
 -		    object_ref, type_name(obj_type),
 -		    replace_ref, type_name(repl_type));
 -
 -	check_ref_valid(object, &prev, &ref, force);
 +		return error("Objects must be of the same type.\n"
 +			     "'%s' points to a replaced object of type '%s'\n"
 +			     "while '%s' points to a replacement object of "
 +			     "type '%s'.",
 +			     object_ref, type_name(obj_type),
 +			     replace_ref, type_name(repl_type));
 +
 +	if (check_ref_valid(object, &prev, &ref, force))
 +		return -1;
  
  	transaction = ref_transaction_begin(&err);
  	if (!transaction ||
  	    ref_transaction_update(transaction, ref.buf, repl, &prev,
  				   0, NULL, &err) ||
  	    ref_transaction_commit(transaction, &err))
 -		die("%s", err.buf);
 +		res = error("%s", err.buf);
  
  	ref_transaction_free(transaction);
  	strbuf_release(&ref);
 -	return 0;
 +	return res;
  }
  
  static int replace_object(const char *object_ref, const char *replace_ref, int force)
 @@ -191,9 +195,11 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
  	struct object_id object, repl;
  
  	if (get_oid(object_ref, &object))
 -		die("Failed to resolve '%s' as a valid ref.", object_ref);
 +		return error("Failed to resolve '%s' as a valid ref.",
 +			     object_ref);
  	if (get_oid(replace_ref, &repl))
 -		die("Failed to resolve '%s' as a valid ref.", replace_ref);
 +		return error("Failed to resolve '%s' as a valid ref.",
 +			     replace_ref);
  
  	return replace_object_oid(object_ref, &object, replace_ref, &repl, force);
  }
 @@ -203,7 +209,7 @@ static int replace_object(const char *object_ref, const char *replace_ref, int f
   * If "raw" is true, then the object's raw contents are printed according to
   * "type". Otherwise, we pretty-print the contents for human editing.
   */
 -static void export_object(const struct object_id *oid, enum object_type type,
 +static int export_object(const struct object_id *oid, enum object_type type,
  			  int raw, const char *filename)
  {
  	struct child_process cmd = CHILD_PROCESS_INIT;
 @@ -211,7 +217,7 @@ static void export_object(const struct object_id *oid, enum object_type type,
  
  	fd = open(filename, O_WRONLY | O_CREAT | O_TRUNC, 0666);
  	if (fd < 0)
 -		die_errno("unable to open %s for writing", filename);
 +		return error_errno("unable to open %s for writing", filename);
  
  	argv_array_push(&cmd.args, "--no-replace-objects");
  	argv_array_push(&cmd.args, "cat-file");
 @@ -224,7 +230,8 @@ static void export_object(const struct object_id *oid, enum object_type type,
  	cmd.out = fd;
  
  	if (run_command(&cmd))
 -		die("cat-file reported failure");
 +		return error("cat-file reported failure");
 +	return 0;
  }
  
  /*
 @@ -232,14 +239,14 @@ static void export_object(const struct object_id *oid, enum object_type type,
   * interpreting it as "type", and writing the result to the object database.
   * The sha1 of the written object is returned via sha1.
   */
 -static void import_object(struct object_id *oid, enum object_type type,
 +static int import_object(struct object_id *oid, enum object_type type,
  			  int raw, const char *filename)
  {
  	int fd;
  
  	fd = open(filename, O_RDONLY);
  	if (fd < 0)
 -		die_errno("unable to open %s for reading", filename);
 +		return error_errno("unable to open %s for reading", filename);
  
  	if (!raw && type == OBJ_TREE) {
  		const char *argv[] = { "mktree", NULL };
 @@ -251,27 +258,38 @@ static void import_object(struct object_id *oid, enum object_type type,
  		cmd.in = fd;
  		cmd.out = -1;
  
 -		if (start_command(&cmd))
 -			die("unable to spawn mktree");
 +		if (start_command(&cmd)) {
 +			close(fd);
 +			return error("unable to spawn mktree");
 +		}
  
 -		if (strbuf_read(&result, cmd.out, 41) < 0)
 -			die_errno("unable to read from mktree");
 +		if (strbuf_read(&result, cmd.out, 41) < 0) {
 +			close(fd);
 +			close(cmd.out);
 +			return error_errno("unable to read from mktree");
 +		}
  		close(cmd.out);
  
 -		if (finish_command(&cmd))
 -			die("mktree reported failure");
 -		if (get_oid_hex(result.buf, oid) < 0)
 -			die("mktree did not return an object name");
 +		if (finish_command(&cmd)) {
 +			strbuf_release(&result);
 +			return error("mktree reported failure");
 +		}
 +		if (get_oid_hex(result.buf, oid) < 0) {
 +			strbuf_release(&result);
 +			return error("mktree did not return an object name");
 +		}
  
  		strbuf_release(&result);
  	} else {
  		struct stat st;
  		int flags = HASH_FORMAT_CHECK | HASH_WRITE_OBJECT;
  
 -		if (fstat(fd, &st) < 0)
 -			die_errno("unable to fstat %s", filename);
 +		if (fstat(fd, &st) < 0) {
 +			close(fd);
 +			return error_errno("unable to fstat %s", filename);
 +		}
  		if (index_fd(oid, fd, &st, type, NULL, flags) < 0)
 -			die("unable to write object to database");
 +			return error("unable to write object to database");
  		/* index_fd close()s fd for us */
  	}
  
 @@ -279,6 +297,7 @@ static void import_object(struct object_id *oid, enum object_type type,
  	 * No need to close(fd) here; both run-command and index-fd
  	 * will have done it for us.
  	 */
 +	return 0;
  }
  
  static int edit_and_replace(const char *object_ref, int force, int raw)
 @@ -289,19 +308,23 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
  	struct strbuf ref = STRBUF_INIT;
  
  	if (get_oid(object_ref, &old_oid) < 0)
 -		die("Not a valid object name: '%s'", object_ref);
 +		return error("Not a valid object name: '%s'", object_ref);
  
  	type = oid_object_info(&old_oid, NULL);
  	if (type < 0)
 -		die("unable to get object type for %s", oid_to_hex(&old_oid));
 +		return error("unable to get object type for %s",
 +			     oid_to_hex(&old_oid));
  
 -	check_ref_valid(&old_oid, &prev, &ref, force);
 +	if (check_ref_valid(&old_oid, &prev, &ref, force))
 +		return -1;
  	strbuf_release(&ref);
  
 -	export_object(&old_oid, type, raw, tmpfile);
 +	if (export_object(&old_oid, type, raw, tmpfile))
 +		return -1;
  	if (launch_editor(tmpfile, NULL, NULL) < 0)
 -		die("editing object file failed");
 -	import_object(&new_oid, type, raw, tmpfile);
 +		return error("editing object file failed");
 +	if (import_object(&new_oid, type, raw, tmpfile))
 +		return -1;
  
  	free(tmpfile);
  
 @@ -311,7 +334,7 @@ static int edit_and_replace(const char *object_ref, int force, int raw)
  	return replace_object_oid(object_ref, &old_oid, "replacement", &new_oid, force);
  }
  
 -static void replace_parents(struct strbuf *buf, int argc, const char **argv)
 +static int replace_parents(struct strbuf *buf, int argc, const char **argv)
  {
  	struct strbuf new_parents = STRBUF_INIT;
  	const char *parent_start, *parent_end;
 @@ -329,8 +352,10 @@ static void replace_parents(struct strbuf *buf, int argc, const char **argv)
  	for (i = 0; i < argc; i++) {
  		struct object_id oid;
  		if (get_oid(argv[i], &oid) < 0)
 -			die(_("Not a valid object name: '%s'"), argv[i]);
 -		lookup_commit_or_die(&oid, argv[i]);
 +			return error(_("Not a valid object name: '%s'"),
 +				     argv[i]);
 +		if (!lookup_commit_reference(&oid))
 +			return error(_("could not parse %s"), argv[i]);
  		strbuf_addf(&new_parents, "parent %s\n", oid_to_hex(&oid));
  	}
  
 @@ -339,6 +364,7 @@ static void replace_parents(struct strbuf *buf, int argc, const char **argv)
  		      new_parents.buf, new_parents.len);
  
  	strbuf_release(&new_parents);
 +	return 0;
  }
  
  struct check_mergetag_data {
 @@ -346,7 +372,7 @@ struct check_mergetag_data {
  	const char **argv;
  };
  
 -static void check_one_mergetag(struct commit *commit,
 +static int check_one_mergetag(struct commit *commit,
  			       struct commit_extra_header *extra,
  			       void *data)
  {
 @@ -359,30 +385,32 @@ static void check_one_mergetag(struct commit *commit,
  	hash_object_file(extra->value, extra->len, type_name(OBJ_TAG), &tag_oid);
  	tag = lookup_tag(&tag_oid);
  	if (!tag)
 -		die(_("bad mergetag in commit '%s'"), ref);
 +		return error(_("bad mergetag in commit '%s'"), ref);
  	if (parse_tag_buffer(tag, extra->value, extra->len))
 -		die(_("malformed mergetag in commit '%s'"), ref);
 +		return error(_("malformed mergetag in commit '%s'"), ref);
  
  	/* iterate over new parents */
  	for (i = 1; i < mergetag_data->argc; i++) {
  		struct object_id oid;
  		if (get_oid(mergetag_data->argv[i], &oid) < 0)
 -			die(_("Not a valid object name: '%s'"), mergetag_data->argv[i]);
 +			return error(_("Not a valid object name: '%s'"),
 +				     mergetag_data->argv[i]);
  		if (!oidcmp(&tag->tagged->oid, &oid))
 -			return; /* found */
 +			return 0; /* found */
  	}
  
 -	die(_("original commit '%s' contains mergetag '%s' that is discarded; "
 -	      "use --edit instead of --graft"), ref, oid_to_hex(&tag_oid));
 +	return error(_("original commit '%s' contains mergetag '%s' that is "
 +		       "discarded; use --edit instead of --graft"), ref,
 +		     oid_to_hex(&tag_oid));
  }
  
 -static void check_mergetags(struct commit *commit, int argc, const char **argv)
 +static int check_mergetags(struct commit *commit, int argc, const char **argv)
  {
  	struct check_mergetag_data mergetag_data;
  
  	mergetag_data.argc = argc;
  	mergetag_data.argv = argv;
 -	for_each_mergetag(check_one_mergetag, commit, &mergetag_data);
 +	return for_each_mergetag(check_one_mergetag, commit, &mergetag_data);
  }
  
  static int create_graft(int argc, const char **argv, int force)
 @@ -395,7 +423,7 @@ static int create_graft(int argc, const char **argv, int force)
  	unsigned long size;
  
  	if (get_oid(old_ref, &old_oid) < 0)
 -		die(_("Not a valid object name: '%s'"), old_ref);
 +		return error(_("Not a valid object name: '%s'"), old_ref);
  	commit = lookup_commit_reference(&old_oid);
  	if (!commit)
  		return error(_("could not parse %s"), old_ref);
 @@ -404,17 +432,20 @@ static int create_graft(int argc, const char **argv, int force)
  	strbuf_add(&buf, buffer, size);
  	unuse_commit_buffer(commit, buffer);
  
 -	replace_parents(&buf, argc - 1, &argv[1]);
 +	if (replace_parents(&buf, argc - 1, &argv[1]) < 0)
 +		return -1;
  
  	if (remove_signature(&buf)) {
  		warning(_("the original commit '%s' has a gpg signature."), old_ref);
  		warning(_("the signature will be removed in the replacement commit!"));
  	}
  
 -	check_mergetags(commit, argc, argv);
 +	if (check_mergetags(commit, argc, argv))
 +		return -1;
  
  	if (write_object_file(buf.buf, buf.len, commit_type, &new_oid))
 -		die(_("could not write replacement commit for: '%s'"), old_ref);
 +		return error(_("could not write replacement commit for: '%s'"),
 +			     old_ref);
  
  	strbuf_release(&buf);
  
 @@ -435,28 +466,13 @@ static int convert_graft_file(int force)
  		return -1;
  
  	while (strbuf_getline(&buf, fp) != EOF) {
 -		int i = 0, j;
 -
 -		while (i != buf.len) {
 -			char save;
 -
 -			for (j = i; j < buf.len && !isspace(buf.buf[j]); j++)
 -				; /* look further */
 -			save = buf.buf[j];
 -			buf.buf[j] = '\0';
 -			argv_array_push(&args, buf.buf + i);
 -			buf.buf[j] = save;
 -
 -			while (j < buf.len && isspace(buf.buf[j]))
 -				j++;
 -			i = j;
 -		}
 +		if (*buf.buf == '#')
 +			continue;
  
 -		if (create_graft(args.argc, args.argv, force))
 +		argv_array_split(&args, buf.buf);
 +		if (args.argc && create_graft(args.argc, args.argv, force))
  			strbuf_addf(&err, "\n\t%s", buf.buf);
 -
  		argv_array_clear(&args);
 -		strbuf_reset(&buf);
  	}
  
  	strbuf_release(&buf);
 @@ -560,6 +576,6 @@ int cmd_replace(int argc, const char **argv, const char *prefix)
  		return list_replace_refs(argv[0], format);
  
  	default:
 -		die("BUG: invalid cmdmode %d", (int)cmdmode);
 +		BUG("invalid cmdmode %d", (int)cmdmode);
  	}
  }
 diff --git a/commit.c b/commit.c
 index 1a5e8777617..451d3ce8dfe 100644
 --- a/commit.c
 +++ b/commit.c
 @@ -1298,17 +1298,19 @@ struct commit_extra_header *read_commit_extra_headers(struct commit *commit,
  	return extra;
  }
  
 -void for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data)
 +int for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data)
  {
  	struct commit_extra_header *extra, *to_free;
 +	int res = 0;
  
  	to_free = read_commit_extra_headers(commit, NULL);
 -	for (extra = to_free; extra; extra = extra->next) {
 +	for (extra = to_free; !res && extra; extra = extra->next) {
  		if (strcmp(extra->key, "mergetag"))
  			continue; /* not a merge tag */
 -		fn(commit, extra, data);
 +		res = fn(commit, extra, data);
  	}
  	free_commit_extra_headers(to_free);
 +	return res;
  }
  
  static inline int standard_header_field(const char *field, size_t len)
 diff --git a/commit.h b/commit.h
 index 0fb8271665c..9000895ad91 100644
 --- a/commit.h
 +++ b/commit.h
 @@ -291,10 +291,10 @@ extern const char *find_commit_header(const char *msg, const char *key,
  /* Find the end of the log message, the right place for a new trailer. */
  extern int ignore_non_trailer(const char *buf, size_t len);
  
 -typedef void (*each_mergetag_fn)(struct commit *commit, struct commit_extra_header *extra,
 +typedef int (*each_mergetag_fn)(struct commit *commit, struct commit_extra_header *extra,
  				 void *cb_data);
  
 -extern void for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data);
 +extern int for_each_mergetag(each_mergetag_fn fn, struct commit *commit, void *data);
  
  struct merge_remote_desc {
  	struct object *obj; /* the named object, could be a tag */
 diff --git a/contrib/convert-grafts-to-replace-refs.sh b/contrib/convert-grafts-to-replace-refs.sh
 deleted file mode 100755
 index 0cbc917b8cf..00000000000
 --- a/contrib/convert-grafts-to-replace-refs.sh
 +++ /dev/null
 @@ -1,28 +0,0 @@
 -#!/bin/sh
 -
 -# You should execute this script in the repository where you
 -# want to convert grafts to replace refs.
 -
 -GRAFTS_FILE="${GIT_DIR:-.git}/info/grafts"
 -
 -. $(git --exec-path)/git-sh-setup
 -
 -test -f "$GRAFTS_FILE" || die "Could not find graft file: '$GRAFTS_FILE'"
 -
 -grep '^[^# ]' "$GRAFTS_FILE" |
 -while read definition
 -do
 -	if test -n "$definition"
 -	then
 -		echo "Converting: $definition"
 -		git replace --graft $definition ||
 -			die "Conversion failed for: $definition"
 -	fi
 -done
 -
 -mv "$GRAFTS_FILE" "$GRAFTS_FILE.bak" ||
 -	die "Could not rename '$GRAFTS_FILE' to '$GRAFTS_FILE.bak'"
 -
 -echo "Success!"
 -echo "All the grafts in '$GRAFTS_FILE' have been converted to replace refs!"
 -echo "The grafts file '$GRAFTS_FILE' has been renamed: '$GRAFTS_FILE.bak'"
 diff --git a/log-tree.c b/log-tree.c
 index d1c0bedf244..f3a51a6e726 100644
 --- a/log-tree.c
 +++ b/log-tree.c
 @@ -488,9 +488,9 @@ static int is_common_merge(const struct commit *commit)
  		&& !commit->parents->next->next);
  }
  
 -static void show_one_mergetag(struct commit *commit,
 -			      struct commit_extra_header *extra,
 -			      void *data)
 +static int show_one_mergetag(struct commit *commit,
 +			     struct commit_extra_header *extra,
 +			     void *data)
  {
  	struct rev_info *opt = (struct rev_info *)data;
  	struct object_id oid;
 @@ -502,7 +502,7 @@ static void show_one_mergetag(struct commit *commit,
  	hash_object_file(extra->value, extra->len, type_name(OBJ_TAG), &oid);
  	tag = lookup_tag(&oid);
  	if (!tag)
 -		return; /* error message already given */
 +		return -1; /* error message already given */
  
  	strbuf_init(&verify_message, 256);
  	if (parse_tag_buffer(tag, extra->value, extra->len))
 @@ -536,11 +536,12 @@ static void show_one_mergetag(struct commit *commit,
  
  	show_sig_lines(opt, status, verify_message.buf);
  	strbuf_release(&verify_message);
 +	return 0;
  }
  
 -static void show_mergetag(struct rev_info *opt, struct commit *commit)
 +static int show_mergetag(struct rev_info *opt, struct commit *commit)
  {
 -	for_each_mergetag(show_one_mergetag, commit, opt);
 +	return for_each_mergetag(show_one_mergetag, commit, opt);
  }
  
  void show_log(struct rev_info *opt)
 diff --git a/t/t6050-replace.sh b/t/t6050-replace.sh
 index 77ded6df653..8a3ee7c3db9 100755
 --- a/t/t6050-replace.sh
 +++ b/t/t6050-replace.sh
 @@ -446,7 +446,7 @@ test_expect_success GPG '--graft on a commit with a mergetag' '
  
  test_expect_success '--convert-graft-file' '
  	: add and convert graft file &&
 -	printf "%s\n%s %s\n%s\n" \
 +	printf "%s\n%s %s\n\n# comment\n%s\n" \
  		$(git rev-parse HEAD^^ HEAD^ HEAD^^ HEAD^2) \
  		>.git/info/grafts &&
  	git replace --convert-graft-file &&
-- 
2.17.0.windows.1.15.gaa56ade3205

