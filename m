From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v5 25/27] refs: add LMDB refs storage backend
Date: Fri, 19 Feb 2016 17:49:46 -0500
Organization: Twitter
Message-ID: <1455922186.7528.97.camel@twopensource.com>
References: <1455772670-21142-1-git-send-email-dturner@twopensource.com>
	 <1455772670-21142-26-git-send-email-dturner@twopensource.com>
	 <20160218085023.GA30049@lanh>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: Duy Nguyen <pclouds@gmail.com>,
	git mailing list <git@vger.kernel.org>, mhagger@alum.mit.edu
X-From: git-owner@vger.kernel.org Fri Feb 19 23:49:56 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWts3-00072I-4Z
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 23:49:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2993366AbcBSWtv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 17:49:51 -0500
Received: from mail-qg0-f47.google.com ([209.85.192.47]:35205 "EHLO
	mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2993061AbcBSWtt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 17:49:49 -0500
Received: by mail-qg0-f47.google.com with SMTP id y89so73346655qge.2
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 14:49:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:date:in-reply-to:references:organization
         :content-type:mime-version:content-transfer-encoding;
        bh=YFx0sqe81WwqgpT2FeLKeHhV5usglfcY8psKffrd/fE=;
        b=ViZsq4/JDjuRNZq73KyHkeVbLQZ32iigPNbNROagdYYW6v97kdVLRBDO0o1ObMUTkS
         NkOY/Mj5UjhqzgnE7pL9OSwKSKslS+DDIbYY1V7TyWImYoH1F4ijiXuFZ8tEtneNrtZZ
         qKy1rW4uewcBb9SIs3qETd7mesWq4fjt5ZdPXO9WFV3nZ63NpONDOffJfCSq87H1RmWC
         4nBB+KmY06HBa3ceE8mmVi7UEHWHlAXWbyuVBsmgTpO02hlCpCOHBCYmCEuMK8maAcFk
         O3nirVvAASZSa6Ba40o0SdcZObdOKZv9mNQrq6VTZNf0r0QbJsDk1OBQxFY/e+bAGQNe
         MRBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=YFx0sqe81WwqgpT2FeLKeHhV5usglfcY8psKffrd/fE=;
        b=JdKefRfxyS8GeOIm5JGkmd0AgvhPC208Bb5kIzFxiKoxcxgccvoPj0UvVhjljrnAeM
         LoJhcr/g8wAmA8ONf60aL4L/7Nnif+lO0fAgX6hFR0DRKKBciOO5qwscIfKGSJeXyOoE
         Jyw3a0/LHg8U1tMdKmHN5kpuWFhiJs0Ey9Z0I7MbLkeXA0ofmaoCK6JsjjQJWiXblp5c
         W9dzmOWfBGLFeEfC+/UN6n67u0GVaJ3NY/BUN+8/W/7x2g+7B2wtwQKevcKFsBXrXy15
         XOyMRdCBZQyp2suddxQnvYcRI0BwXTdnyv5JmE3jWGsvUb7rI+JhKV+vwpciBUVT1pX1
         EZew==
X-Gm-Message-State: AG10YOQOgHODpZ4wjDTBrZevmeETzXpHQ6eTF65oz3apjugtw4rjmDsIbsMtLGZozVM8rg==
X-Received: by 10.140.88.229 with SMTP id t92mr13010313qgd.8.1455922188279;
        Fri, 19 Feb 2016 14:49:48 -0800 (PST)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id 64sm5526604qhf.40.2016.02.19.14.49.46
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 19 Feb 2016 14:49:46 -0800 (PST)
In-Reply-To: <20160218085023.GA30049@lanh>
X-Mailer: Evolution 3.16.5-1ubuntu3.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286757>

On Thu, 2016-02-18 at 15:50 +0700, Duy Nguyen wrote:
> Caveat: I did not study how to use lmdb. I just guessed what it does
> based on function names. I don't know much about refs handling either
> (especially since the transaction thing is introduced)
> 
> > diff --git a/Documentation/technical/refs-lmdb-backend.txt
> > b/Documentation/technical/refs-lmdb-backend.txt
> > new file mode 100644
> > index 0000000..eb81465
> > --- /dev/null
> > +++ b/Documentation/technical/refs-lmdb-backend.txt
> > +Reflog values are in the same format as the original files-based
> > +reflog, including the trailing LF. The date in the reflog value
> > +matches the date in the timestamp field.
> 
> ..except that SHA-1s are stored in raw values instead of hex strings.
> 
> > diff --git a/Documentation/technical/repository-version.txt
> > b/Documentation/technical/repository-version.txt
> > index 00ad379..fca5ecd 100644
> > --- a/Documentation/technical/repository-version.txt
> > +++ b/Documentation/technical/repository-version.txt
> > @@ -86,3 +86,8 @@ for testing format-1 compatibility.
> >  When the config key `extensions.preciousObjects` is set to `true`,
> >  objects in the repository MUST NOT be deleted (e.g., by `git
> > -prune` or
> >  `git repack -d`).
> > +
> > +`refStorage`
> > +~~~~~~~~~~~~
> > +This extension allows the use of alternate ref storage backends. 
> >  The
> > +only defined value is `lmdb`.
> 
> refStorage accepts empty string and `files` as well, should probably
> be worth mentioning.
> 
> > diff --git a/refs/lmdb-backend.c b/refs/lmdb-backend.c
> > +#include "../cache.h"
> > +#include <lmdb.h>
> > +#include "../object.h"
> > +#include "../refs.h"
> > +#include "refs-internal.h"
> > +#include "../tag.h"
> > +#include "../lockfile.h"
> 
> I'm quite sure we don't need "../". We have plenty of source files in
> subdirs and many of them (haven't checked all) just go with
> #include "cache.h".
> 
> > +struct lmdb_transaction transaction;
> 
> static?
> 
> > +
> > +static int in_write_transaction(void)
> > +{
> > +	return transaction.txn && !(transaction.flags &
> > MDB_RDONLY);
> > +}
> > +
> > +static void init_env(MDB_env **env, const char *path)
> > +{
> > +	int ret;
> > +	if (*env)
> > +		return;
> > +
> > +	assert(path);
> > +
> > +	ret = mdb_env_create(env);
> > +	if (ret)
> > +		die("BUG: mdb_env_create failed: %s",
> > mdb_strerror(ret));
> > +	ret = mdb_env_set_maxreaders(*env, 1000);
> > +	if (ret)
> > +		die("BUG: mdb_env_set_maxreaders failed: %s",
> > mdb_strerror(ret));
> > +	ret = mdb_env_set_mapsize(*env, (1<<30));
> > +	if (ret)
> > +		die("BUG: mdb_set_mapsize failed: %s",
> > mdb_strerror(ret));
> > +	ret = mdb_env_open(*env, path, 0 , 0664);
> 
> This permission makes me wonder if we need adjust_shared_perm() here
> and some other places.
> 
> > +	if (ret)
> > +		die("BUG: mdb_env_open (%s) failed: %s", path,
> > +		    mdb_strerror(ret));
> > +}
> > +
> > +static int lmdb_init_db(int shared, struct strbuf *err)
> > +{
> > +	/*
> > +	 * To create a db, all we need to do is make a directory
> > for
> > +	 * it to live in; lmdb will do the rest.
> > +	 */
> > +
> > +	if (!db_path)
> > +		db_path =
> > xstrdup(real_path(git_path("refs.lmdb")));
> > +
> > +	if (mkdir(db_path, 0775) && errno != EEXIST) {
> > +		strbuf_addf(err, "%s", strerror(errno));
> 
> maybe strbuf_addstr, unless want to add something more, "mkdir
> failed"?
> 
> > +static int read_per_worktree_ref(const char *submodule, const char
> > *refname,
> > +				 struct MDB_val *val, int
> > *needs_free)
> 
> From what I read, I suspect these _per_worktree functions will be
> identical for the next backend. Should we just hand over the job for
> files backend? For all entry points that may deal with per-worktree
> refs, e.g. lmdb_resolve_ref_unsafe, can we check ref_type() first
> thing, if it's per-worktree we call
> refs_be_files.resolve_ref_unsafe()
> instead?  It could even be done at frontend level,
> e.g. refs.c:resolve_ref_unsafe().
> 
> Though I may be talking rubbish here because I don't know how whether
> it has anything to do with transactions.
> 
> > +{
> > +	struct strbuf sb = STRBUF_INIT;
> > +	struct strbuf path = STRBUF_INIT;
> > +	struct stat st;
> > +	int ret = -1;
> > +
> > +	submodule_path(&path, submodule, refname);
> > +
> > +#ifndef NO_SYMLINK_HEAD
> 
> It started with the compiler warns about unused "st" when this macro
> is defined. Which makes me wonder, should we do something like this
> to
> make sure this code compiles unconditionally?
> 
> +#ifndef NO_SYMLINK_HEAD
> +       int no_symlink_head = 0;
> +#else
> +       int no_symlink_head = 1;
> +#endif
> ...
> +       if (!no_symlink_head) {
> ...
> 
> 
> > +int lmdb_transaction_begin_flags(struct strbuf *err, unsigned int
> > flags)
> 
> static?
> 
> > +#define MAXDEPTH 5
> > +
> > +static const char *parse_ref_data(struct lmdb_transaction
> > *transaction,
> > +				  const char *refname, const char
> > *ref_data,
> > +				  unsigned char *sha1, int
> > resolve_flags,
> > +				  int *flags, int bad_name)
> > +{
> > +	int depth = MAXDEPTH;
> > +	const char *buf;
> > +	static struct strbuf refname_buffer = STRBUF_INIT;
> > +	static struct strbuf refdata_buffer = STRBUF_INIT;
> > +	MDB_val key, val;
> > +	int needs_free = 0;
> > +
> > +	for (;;) {
> > +		if (--depth < 0)
> > +			return NULL;
> > +
> > +		if (!starts_with(ref_data, "ref:")) {
> > +			if (get_sha1_hex(ref_data, sha1) ||
> > +			    (ref_data[40] != '\0' &&
> > !isspace(ref_data[40]))) {
> > +				if (flags)
> > +					*flags |= REF_ISBROKEN;
> > +				errno = EINVAL;
> > +				return NULL;
> > +			}
> > +
> > +			if (bad_name) {
> > +				hashclr(sha1);
> > +				if (flags)
> > +					*flags |= REF_ISBROKEN;
> > +			} else if (is_null_sha1(sha1)) {
> > +				if (flags)
> > +					*flags |= REF_ISBROKEN;
> > +			}
> > +			return refname;
> > +		}
> > +		if (flags)
> > +			*flags |= REF_ISSYMREF;
> > +		buf = ref_data + 4;
> > +		while (isspace(*buf))
> > +			buf++;
> > +		strbuf_reset(&refname_buffer);
> > +		strbuf_addstr(&refname_buffer, buf);
> > +		refname = refname_buffer.buf;
> > +		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
> > +			hashclr(sha1);
> > +			return refname;
> > +		}
> > +		if (check_refname_format(buf,
> > REFNAME_ALLOW_ONELEVEL)) {
> > +			if (flags)
> > +				*flags |= REF_ISBROKEN;
> > +
> > +			if (!(resolve_flags &
> > RESOLVE_REF_ALLOW_BAD_NAME) ||
> > +			    !refname_is_safe(buf)) {
> > +				errno = EINVAL;
> > +				return NULL;
> > +			}
> > +			bad_name = 1;
> > +		}
> 
> This code looks a lot like near the end of resolve_ref_1(). Maybe we
> could share the code in refs/backend-common.c or something and call
> here instead?

Something like the following?

commit aad6b84fd1869f6e1cf6ed15bcece0c2f6429e9d
Author: David Turner <dturner@twopensource.com>
Date:   Thu Feb 18 17:09:29 2016 -0500

    refs: break out some functions from resolve_ref_1
    
    A bunch of resolve_ref_1 is not backend-specific, so we can
    break it out into separate internal functions that other
    backends can use.
    
    Signed-off-by: David Turner <dturner@twopensource.com>

diff --git a/refs.c b/refs.c
index c9fa34d..680c2a5 100644
--- a/refs.c
+++ b/refs.c
@@ -1221,6 +1221,66 @@ int for_each_rawref(each_ref_fn fn, void
*cb_data)
 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
 }
 
+int parse_simple_ref(const char *buf, unsigned char *sha1, unsigned
int *flags, int bad_name)
+{
+	/*
+	 * Please note that FETCH_HEAD has a second
+	 * line containing other data.
+	 */
+	if (get_sha1_hex(buf, sha1) ||
+	    (buf[40] != '\0' && !isspace(buf[40]))) {
+		if (flags)
+			*flags |= REF_ISBROKEN;
+		errno = EINVAL;
+		return -1;
+	}
+	if (bad_name) {
+		hashclr(sha1);
+		if (flags)
+			*flags |= REF_ISBROKEN;
+	}
+	return 0;
+}
+
+int check_bad_refname(const char *refname, int *flags, int
resolve_flags)
+{
+	if (!check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
+		return 0;
+
+	if (flags)
+		*flags |= REF_BAD_NAME;
+
+	if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
+	    !refname_is_safe(refname)) {
+		errno = EINVAL;
+		return -1;
+	}
+	/*
+	 * dwim_ref() uses REF_ISBROKEN to distinguish between
+	 * missing refs and refs that were present but invalid,
+	 * to complain about the latter to stderr.
+	 *
+	 * We don't know whether the ref exists, so don't set
+	 * REF_ISBROKEN yet.
+	 */
+	return 1;
+}
+
+/*
+ * Parse a refname out of the contents of a symref into a provided
+ * strbuf.  Return a pointer to the strbuf's contents.
+ */
+char *parse_symref_data(const char *buf, struct strbuf *sb_refname)
+{
+	buf += 4;
+	while (isspace(*buf))
+		buf++;
+	strbuf_reset(sb_refname);
+	strbuf_addstr(sb_refname, buf);
+	return sb_refname->buf;
+}
+
+
 /* backend functions */
 int refs_init_db(int shared, struct strbuf *err)
 {
diff --git a/refs/files-backend.c b/refs/files-backend.c
index da06408..52972e6 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1427,25 +1427,9 @@ static const char *resolve_ref_1(const char
*refname,
 	if (flags)
 		*flags = 0;
 
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
-		if (flags)
-			*flags |= REF_BAD_NAME;
-
-		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
-		    !refname_is_safe(refname)) {
-			errno = EINVAL;
-			return NULL;
-		}
-		/*
-		 * dwim_ref() uses REF_ISBROKEN to distinguish between
-		 * missing refs and refs that were present but
invalid,
-		 * to complain about the latter to stderr.
-		 *
-		 * We don't know whether the ref exists, so don't set
-		 * REF_ISBROKEN yet.
-		 */
-		bad_name = 1;
-	}
+	bad_name = check_bad_refname(refname, flags, resolve_flags);
+	if (bad_name < 0)
+		return NULL;
 	for (;;) {
 		const char *path;
 		struct stat st;
@@ -1541,47 +1525,20 @@ static const char *resolve_ref_1(const char
*refname,
 		 * Is it a symbolic ref?
 		 */
 		if (!starts_with(sb_contents->buf, "ref:")) {
-			/*
-			 * Please note that FETCH_HEAD has a second
-			 * line containing other data.
-			 */
-			if (get_sha1_hex(sb_contents->buf, sha1) ||
-			    (sb_contents->buf[40] != '\0' &&
!isspace(sb_contents->buf[40]))) {
-				if (flags)
-					*flags |= REF_ISBROKEN;
-				errno = EINVAL;
-				return NULL;
-			}
-			if (bad_name) {
-				hashclr(sha1);
-				if (flags)
-					*flags |= REF_ISBROKEN;
-			}
+			if (parse_simple_ref(sb_contents->buf, sha1,
flags, bad_name))
+				refname = NULL;
 			return refname;
 		}
 		if (flags)
 			*flags |= REF_ISSYMREF;
-		buf = sb_contents->buf + 4;
-		while (isspace(*buf))
-			buf++;
-		strbuf_reset(sb_refname);
-		strbuf_addstr(sb_refname, buf);
-		refname = sb_refname->buf;
+		refname = parse_symref_data(sb_contents->buf,
sb_refname);
 		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
 			hashclr(sha1);
 			return refname;
 		}
-		if (check_refname_format(buf, REFNAME_ALLOW_ONELEVEL))
{
-			if (flags)
-				*flags |= REF_ISBROKEN;
-
-			if (!(resolve_flags &
RESOLVE_REF_ALLOW_BAD_NAME) ||
-			    !refname_is_safe(buf)) {
-				errno = EINVAL;
-				return NULL;
-			}
-			bad_name = 1;
-		}
+		bad_name |= check_bad_refname(refname, flags,
resolve_flags);
+		if (bad_name < 0)
+			return NULL;
 	}
 }
 
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index efdde82..7cdfffe 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -218,6 +218,26 @@ int do_for_each_per_worktree_ref(const char
*submodule, const char *base,
 int do_for_each_ref(const char *submodule, const char *base,
 		    each_ref_fn fn, int trim, int flags, void
*cb_data);
 
+/*
+ * Parse a non-symref -- a buf hopefully containing 40 hex characters.
+ * Set errno and flags appropriately.  If the buf can be parsed but
+ * bad_name is set, the ref is broken: zero out sha1.
+ */
+int parse_simple_ref(const char *buf, unsigned char *sha1, unsigned
int *flags,
+		     int bad_name);
+/*
+ * Parse a refname out of the contents of a symref into a provided
+ * strbuf.  Return a pointer to the strbuf's contents.
+ */
+char *parse_symref_data(const char *buf, struct strbuf *sb_refname);
+
+/*
+ * Check the format of refname.  Set flags and errno appropriately.
+ * Returns 0 if the refname is good, -1 if it is bad enough that we
+ * have to stop parsing and 1 if we just have to note that it is bad.
+ */
+int check_bad_refname(const char *refname, int *flags, int
resolve_flags);
+
 /* refs backends */
 typedef int ref_init_db_fn(int shared, struct strbuf *err);
 typedef int ref_transaction_commit_fn(struct ref_transaction
*transaction,




followed by this version of parse_ref_data:

static const char *parse_ref_data(struct lmdb_transaction *transaction,
				  const char *refname, const char
*ref_data,
				  unsigned char *sha1, int
resolve_flags,
				  int *flags, int bad_name)
{
	int depth = MAXDEPTH;
	const char *buf;
	static struct strbuf refname_buffer = STRBUF_INIT;
	static struct strbuf refdata_buffer = STRBUF_INIT;
	MDB_val key, val;
	int needs_free = 0;

	for (;;) {
		if (--depth < 0)
			return NULL;

		/*
		 * Is it a symbolic ref?
		 */
		if (!starts_with(ref_data, "ref:")) {
			if (parse_simple_ref(ref_data, sha1, flags,
bad_name))
				refname = NULL;
			 if (is_null_sha1(sha1) && flags)
				*flags |= REF_ISBROKEN;
			return refname;
		}
		if (flags)
			*flags |= REF_ISSYMREF;

		refname = parse_symref_data(ref_data, &refname_buffer);
		if (resolve_flags & RESOLVE_REF_NO_RECURSE) {
			hashclr(sha1);
			return refname;
		}
		bad_name |= check_bad_refname(refname, flags,
resolve_flags);
		if (bad_name < 0)
			return NULL;

		key.mv_data = (char *)refname;
		key.mv_size = strlen(refname) + 1;
		if (mdb_get_or_die(transaction, &key, &val,
&needs_free)) {
			hashclr(sha1);
			if (bad_name) {
				if (flags)
					*flags |= REF_ISBROKEN;
			}
			if (resolve_flags & RESOLVE_REF_READING)
				return NULL;

			return refname;
		}
		strbuf_reset(&refdata_buffer);
		strbuf_add(&refdata_buffer, val.mv_data, val.mv_size);
		if (needs_free)
			free(val.mv_data);
		ref_data = refdata_buffer.buf;
	}
	return refname;
}

----------------

I'm not sure I like it, because it breaks out these weird tiny
functions that take a lot of arguments.  But maybe it's worth it?  What
do you think?
