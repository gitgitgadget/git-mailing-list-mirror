From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 19/20] refs: add LMDB refs backend
Date: Fri, 15 Jan 2016 14:33:17 +0100
Message-ID: <20160115133317.GJ10612@hank>
References: <1452788777-24954-1-git-send-email-dturner@twopensource.com>
 <1452788777-24954-20-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 14:33:00 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aK4Us-0000f2-8H
	for gcvg-git-2@plane.gmane.org; Fri, 15 Jan 2016 14:32:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932122AbcAONcy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jan 2016 08:32:54 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35886 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586AbcAONcw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jan 2016 08:32:52 -0500
Received: by mail-wm0-f65.google.com with SMTP id l65so2864744wmf.3
        for <git@vger.kernel.org>; Fri, 15 Jan 2016 05:32:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=48assAiYeNl4oj8nN3v9qHKEZhCx7cZz1at9HwYK+mo=;
        b=XB09LmnEFPElPufoyHxVZNjyxMFcocMkywC7nV1GSK1AqxWOHcdtkqQPHcO1I4sHmd
         M+o4PFEupp0ni1cZ5VSSf3td5oIitpgwcOoH9Mui0s1ljEEqKYj0UJmpAh4XzXE4d7Za
         IerlBX+YGoGzDEli74Kj41kTtPgjvFIxMU8EnHfKenjOpD8DkkPSGnBXFUvS2K9XZOES
         bi1BcW+VtqzqPBeE9XQUq/qr7b6syITlvLZYOWoetHwXvHqcxWVQxD/q/HmGewGIyMO3
         OZlN0WvOK05QNQQS52u1/l56J9BeWJ1EzxVU9dksJu+WgiFT73Xs3/Y49lHdnk4HF+LZ
         lIig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=48assAiYeNl4oj8nN3v9qHKEZhCx7cZz1at9HwYK+mo=;
        b=dxPb1FanZLcksmuRcoxCBqpM1VzY1z6IaRrLTNa0QVEeBBF/j4JyFAQvrR2INGj0T8
         EYFVz2p/z2tSkSqpvbz/AIaOWR00mNTOhxVdM9c3hvWpIgSsTvHpU3ueWQj5Jk38cDDr
         WZnDC8mqgI4qNt1xWIN1V6RD9gfgGdkrsOs9LhGT/OHiYI9hqYvZqJuQKnAxQkffUvZh
         GvvkNc/phDLnvsWbTKMSDntDhOnWjUVLAMfQfT/P179noXp+DiKlelb19wFkWsq+24F2
         EBqVrWtIwsc2ZyIIwiaaNKztK3nxOqfSiLvlCEcVeUCsy3k8nfTaimJ7JIXceTmvi8eA
         GX6w==
X-Gm-Message-State: ALoCoQmKVDlfFXsT/x8yGDqa+GA8N3u6+1LnkWu+8dNNAhRFLMzTatTvYbE1FY28XtrVa/3bZ416zk9Y6+Rf3Xf7ve2xkd2qEQ==
X-Received: by 10.195.13.129 with SMTP id ey1mr9808321wjd.132.1452864771450;
        Fri, 15 Jan 2016 05:32:51 -0800 (PST)
Received: from localhost (host143-110-dynamic.40-79-r.retail.telecomitalia.it. [79.40.110.143])
        by smtp.gmail.com with ESMTPSA id c26sm2558142wmi.21.2016.01.15.05.32.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Jan 2016 05:32:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1452788777-24954-20-git-send-email-dturner@twopensource.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284170>

[I don't know too much about the refs code, but was still interested
in this patch series, so below are the few things that I noticed while
reading through it.]

On 01/14, David Turner wrote:
> Add a database backend for refs using LMDB.  This backend runs git
> for-each-ref about 30% faster than the files backend with fully-packed
> refs on a repo with ~120k refs.  It's also about 4x faster than using
> fully-unpacked refs.  In addition, and perhaps more importantly, it
> avoids case-conflict issues on OS X.
>
> LMDB has a few features that make it suitable for usage in git:
>
> 1. It is relatively lightweight; it requires only one header file, and
> the library code takes under 64k at runtime.
>
> 2. It is well-tested: it's been used in OpenLDAP for years.
>
> 3. It's very fast.  LMDB's benchmarks show that it is among
> the fastest key-value stores.
>
> 4. It has a relatively simple concurrency story; readers don't
> block writers and writers don't block readers.
>
> Ronnie Sahlberg's original version of this patchset used tdb.  The
> major disadvantage of tdb is that tdb is hard to build on OS X.  It's
> also not in homebrew.  So lmdb seemed simpler.
>
> To test this backend's correctness, I hacked test-lib.sh and
> test-lib-functions.sh to run all tests under the refs backend. Dozens
> of tests use manual ref/reflog reading/writing, or create submodules
> without passing --ref-storage to git init.  If those tests are
> changed to use the update-ref machinery or test-refs-lmdb-backend (or,
> in the case of packed-refs, corrupt refs, and dumb fetch tests, are
> skipped), the only remaining failing tests are the git-new-workdir
> tests and the gitweb tests.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  .gitignore                                     |    1 +
>  Documentation/config.txt                       |    7 +
>  Documentation/git-clone.txt                    |    3 +-
>  Documentation/git-init.txt                     |    2 +-
>  Documentation/technical/refs-lmdb-backend.txt  |   52 +
>  Documentation/technical/repository-version.txt |    5 +
>  Makefile                                       |   12 +
>  config.c                                       |   29 +
>  configure.ac                                   |   33 +
>  contrib/workdir/git-new-workdir                |    3 +
>  refs.h                                         |    2 +
>  refs/lmdb-backend.c                            | 2051 ++++++++++++++++++++++++
>  setup.c                                        |   11 +-
>  test-refs-lmdb-backend.c                       |   64 +
>  transport.c                                    |    7 +-
>  15 files changed, 2275 insertions(+), 7 deletions(-)
>  create mode 100644 Documentation/technical/refs-lmdb-backend.txt
>  create mode 100644 refs/lmdb-backend.c
>  create mode 100644 test-refs-lmdb-backend.c
>

[...]

> diff --git a/Documentation/technical/refs-lmdb-backend.txt b/Documentation/technical/refs-lmdb-backend.txt
> new file mode 100644
> index 0000000..c328bfc
> --- /dev/null
> +++ b/Documentation/technical/refs-lmdb-backend.txt
> @@ -0,0 +1,52 @@
> +Notes on the LMDB refs backend
> +==============================
> +
> +Design:
> +------
> +
> +Refs and reflogs are stored in a lmdb database in .git/refdb.  All
> +keys and values are \0-terminated.
> +
> +Keys for refs are the name of the ref (e.g. refs/heads/master).
> +Values are the value of the ref, in hex
> +(e.g. 61f23eb0f81357c19fa91e2b8c6f3906c3a8f9b0).
> +
> +All per-worktree refs (refs/bisect/* and HEAD) are stored using
> +the traditional files-based backend.
> +
> +Reflogs are stored as a series of database entries.
> +
> +For non-empty reflogs, there is one entry per logged ref update.  The
> +key format is logs/[refname]\0[timestamp].  The timestamp is a 64-bit
> +unsigned integer number of nanoseconds since 1/1/1970, stored in
> +network byte order.  This means that reflog entries are
> +chronologically ordered.  Because LMDB is a btree database, we can
> +efficiently iterate over these keys.
> +
> +For an empty reflog, there is a "header" entry to show that a reflog
> +exists.  The header has the same format as an ordinary reflog, but with
> +a timeztamp of all zeros and an empty value.

s/timeztamp/timestamp/

> +
> +Reflog values are in the same format as the original files-based
> +reflog, including the trailing LF. The date in the reflog value
> +matches the date in the timestamp field.
> +
> +Weaknesses:
> +-----------
> +
> +The reflog format is somewhat inefficient: a binary format could store
> +reflog date/time information in somewhat less space.
> +
> +The rsync and file:// transports don't work yet, because they
> +don't use the refs API.
> +
> +git new-workdir is incompatible with the lmdb backend.  Fortunately,
> +git new-workdir is deprecated, and worktrees work fine.
> +
> +LMDB locks the entire database for write.  Any other writer waits
> +until the first writer is done before beginning.  Readers do not wait
> +for writers, and writers do not wait for readers.  The underlying
> +scheme is approximately MVCC; each reader's queries see the state of
> +the database as-of the time that the reader acquired its read lock.
> +This is not too far off from the files backend, which loads all refs
> +into memory when one is requested.

[...]

> diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
> index 888c34a..c035a43 100755
> --- a/contrib/workdir/git-new-workdir
> +++ b/contrib/workdir/git-new-workdir
> @@ -28,6 +28,9 @@ git_dir=$(cd "$orig_git" 2>/dev/null &&
>    git rev-parse --git-dir 2>/dev/null) ||
>    die "Not a git repository: \"$orig_git\""
>
> +
> +test "$(git config extensions.refstorage)" = "lmdb" && die "git-new-workdir is incompatible with the refs lmdb storage"
> +

Is it expected that other potential ref backends are compatible with
git-new-workdir?  Otherwise I think it would make more sense to
whitelist the files backend here instead of blacklisting the lmdb
backend, so we don't risk forgetting about this when adding another
backend.

>  case "$git_dir" in
>  .git)
>  	git_dir="$orig_git/.git"

[...]

> +static int lmdb_init_db(struct strbuf *err, int shared)
> +{
> +	/*
> +	 * To create a db, all we need to do is make a directory for
> +	 * it to live in; lmdb will do the rest.
> +	 */
> +
> +	if (!db_path)
> +		db_path = xstrdup(real_path(get_refdb_path(get_git_common_dir())));

I think we're leaking some memory from get_refdb_path() here.
get_refdb_path() uses strbuf_detach(), which according to its docstring
makes its caller take care of the memory of the returned string.
real_path() then uses strbuf_addstr() to add the string to its
internal strbuf, but leaves the string we get from get_refdb_path()
alone, so it leaks.

> +
> +	if (mkdir(db_path, 0775) && errno != EEXIST) {
> +		strbuf_addf(err, "%s", strerror(errno));
> +		return -1;
> +	}
> +
> +	return 0;
> +}
> +

[...]

> +/*
> + * Begin a transaction. Because only one transaction per thread is
> + * permitted, we use a global transaction object.  If a read-write
> + * transaction is presently already in-progress, and a read-only
> + * transaction is requested, the read-write transaction will be
> + * returned instead.  If a read-write transaction is requested and a
> + * read-only transaction is open, the read-only transaction will be
> + * closed.
> + *
> + * It is a bug to request a read-write transaction during another
> + * read-write transaction.
> + *
> + * As a result, it is unsafe to retain read-only transactions past the
> + * point where a read-write transaction might be needed.  For
> + * instance, any call that has callbacks outside this module must
> + * conclude all of its reads from the database before calling those
> + * callbacks, or must reacquire the transaction after its callbacks
> + * are completed.
> + */
> +int lmdb_transaction_begin_flags(struct strbuf *err, unsigned int flags)
> +{
> +	int ret;
> +	MDB_txn *txn;
> +	static size_t last_txnid = 0;
> +	int force_restart = 0;
> +	MDB_envinfo stat;
> +
> +	if (!db_path)
> +		db_path = xstrdup(real_path(get_refdb_path(get_git_common_dir())));

Same comment about leaking memory from get_refdb_path() as above applies.

> +	init_env(&env, db_path);
> +
> +	/*
> +	 * Since each transaction sees a consistent view of the db,
> +	 * downstream processes that write the db won't be seen in
> +	 * this transaction.  We can check if the last transaction id
> +	 * has changed since this read transaction was started, and if
> +	 * so, we want to reopen the transaction.
> +	 */
> +
> +	mdb_env_info(env, &stat);
> +	if (stat.me_last_txnid != last_txnid) {
> +		force_restart = 1;
> +		last_txnid = stat.me_last_txnid;
> +	}
> +
> +	if (!transaction.txn) {
> +		ret = mdb_txn_begin(env, NULL, flags, &txn);
> +		if (ret) {
> +			strbuf_addf(err, "mdb_txn_begin failed: %s",
> +				    mdb_strerror(ret));
> +			return -1;
> +		}
> +		ret = mdb_dbi_open(txn, NULL, 0, &transaction.dbi);
> +		if (ret) {
> +			strbuf_addf(err, "mdb_txn_open failed: %s",
> +				    mdb_strerror(ret));
> +			return -1;
> +		}
> +		transaction.txn = txn;
> +		transaction.flags = flags;
> +		return 0;
> +	}
> +
> +	if (transaction.flags == flags && !(flags & MDB_RDONLY))
> +		die("BUG: rw transaction started during another rw txn");
> +
> +	if (force_restart || (transaction.flags != flags && transaction.flags & MDB_RDONLY)) {
> +		/*
> +		 * RO -> RW, or forced restart due to possible changes
> +		 * from downstream processes.
> +		 */
> +		mdb_txn_abort(transaction.txn);
> +		ret = mdb_txn_begin(env, NULL, flags, &txn);
> +		if (ret) {
> +			strbuf_addf(err, "restarting txn: mdb_txn_begin failed: %s",
> +				    mdb_strerror(ret));
> +			return -1;
> +		}
> +		ret = mdb_dbi_open(txn, NULL, 0, &transaction.dbi);
> +		if (ret) {
> +			strbuf_addf(err, "mdb_txn_open failed: %s",
> +				    mdb_strerror(ret));
> +			return -1;
> +		}
> +		transaction.txn = txn;
> +		transaction.flags = flags;
> +	}
> +	/* RW -> RO just keeps the RW txn */
> +	return 0;
> +}

[...]
