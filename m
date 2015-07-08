From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v7 7/8] update-ref and tag: add --create-reflog arg
Date: Wed, 08 Jul 2015 15:44:26 +0200
Message-ID: <559D293A.9040307@alum.mit.edu>
References: <1436316963-25520-1-git-send-email-dturner@twopensource.com> <1436316963-25520-7-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 08 15:45:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCpf6-0006c4-8s
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jul 2015 15:45:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758655AbbGHNpO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jul 2015 09:45:14 -0400
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:63628 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758382AbbGHNoh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jul 2015 09:44:37 -0400
X-AuditID: 12074414-f794f6d000007852-98-559d293c0e1a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 1A.4D.30802.C392D955; Wed,  8 Jul 2015 09:44:28 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB0310.dip0.t-ipconnect.de [93.219.3.16])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t68DiQSQ010335
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 8 Jul 2015 09:44:27 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1436316963-25520-7-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrFIsWRmVeSWpSXmKPExsUixO6iqGujOTfU4NRZSYv5m04wWnRd6WZy
	YPJY8Pw+u8fnTXIBTFHcNkmJJWXBmel5+nYJ3Blt898wFjQ6V/Rem8vawLjBtIuRk0NCwESi
	424zE4QtJnHh3nq2LkYuDiGBy4wSK3cfZIRwzjBJPDlyiw2kildAW+LKujtACQ4OFgFViT0n
	pEHCbAK6Eot6QAZxcIgKBEm8fpkLUS0ocXLmExYQW0TAQeLyrqPMILawgLvEzetPoMa3Mkq8
	O7mXDaSXU8BTYt8zGZAaZgE9iR3Xf7FC2PISzVtnM09g5J+FZOwsJGWzkJQtYGRexSiXmFOa
	q5ubmJlTnJqsW5ycmJeXWqRroZebWaKXmlK6iRESjiI7GI+clDvEKMDBqMTD+yFyTqgQa2JZ
	cWXuIUZJDiYlUd64R0AhvqT8lMqMxOKM+KLSnNTiQ4wSHMxKIryhinNDhXhTEiurUovyYVLS
	HCxK4rzfFqv7CQmkJ5akZqemFqQWwWRlODiUJHi3qwM1ChalpqdWpGXmlCCkmTg4QYZzSYkU
	p+alpBYllpZkxIPiMb4YGJEgKR6gvbIaIHuLCxJzgaIQracYFaXEeS+AzBUASWSU5sGNhSWZ
	V4ziQF8K894HqeIBJii47ldAg5mABi/XnQUyuCQRISXVwLjySljVmQz1W1VCup/mdvqvO9C2
	88+Vefos4jeczl0RKPcxltHaPWOisYTdS/5LOxWanFT/BMTbzGN5soXp4fuSx8Ey2jmix70Z
	V0zc//DE7kPau4LSzRNO79Ozzf2jsFFi3Uab6dtd/03OOnz8xKSdHFqeJso5b3Ie 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273683>

Please see my email about v6 [*] for an argument for why, at the API
level, the create-reflog functionality for new references needs to be
implemented within the ref_transaction API.

[*] http://article.gmane.org/gmane.comp.version-control.git/273682

On 07/08/2015 02:56 AM, David Turner wrote:
> update-ref and tag: add --create-reflog arg

`--create-reflog` is an "option", not an "arg".

> Allow the creation of a ref (e.g. stash) with a reflog already in
> place. For most refs (e.g. those under refs/heads), this happens
> automatically, but for others, we need this option.

As I mentioned, this fact is only true if core.logAllRefUpdates is
turned on (or by default in non-bare repos).

> Currently, git does this by pre-creating the reflog, but alternate ref
> backends might store reflogs somewhere other than .git/logs.  Code
> that now directly manipulates .git/logs should instead use git
> plumbing commands.
> 
> I also added --create-reflog to git tag, just for completeness.
> 
> In a moment, we will use this argument to make git stash work with
> alternate ref backends.

For a moment I thought that there should be a corresponding
`--no-create-reflog` option. But it would be pretty pointless, because
if this call to `update-ref` would want to create a reflog, then so
would *every* subsequent update to the reference. So the effect of
`--no-create-reflog` could at best be temporary.

> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  Documentation/git-tag.txt        |  5 ++++-
>  Documentation/git-update-ref.txt |  5 ++++-
>  builtin/tag.c                    |  5 +++++
>  builtin/update-ref.c             | 17 +++++++++++++++--
>  t/t1400-update-ref.sh            | 38 ++++++++++++++++++++++++++++++++++++++
>  t/t7004-tag.sh                   |  9 ++++++++-
>  6 files changed, 74 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/git-tag.txt b/Documentation/git-tag.txt
> index 034d10d..2312980 100644
> --- a/Documentation/git-tag.txt
> +++ b/Documentation/git-tag.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  	<tagname> [<commit> | <object>]
>  'git tag' -d <tagname>...
>  'git tag' [-n[<num>]] -l [--contains <commit>] [--points-at <object>]
> -	[--column[=<options>] | --no-column] [<pattern>...]
> +	[--column[=<options>] | --no-column] [--create-reflog] [<pattern>...]
>  	[<pattern>...]
>  'git tag' -v <tagname>...
>  
> @@ -143,6 +143,9 @@ This option is only applicable when listing tags without annotation lines.
>  	all, 'whitespace' removes just leading/trailing whitespace lines and
>  	'strip' removes both whitespace and commentary.
>  
> +--create-reflog::
> +	Create a reflog for the tag.
> +
>  <tagname>::
>  	The name of the tag to create, delete, or describe.
>  	The new tag name must pass all checks defined by
> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
> index c8f5ae5..969bfab 100644
> --- a/Documentation/git-update-ref.txt
> +++ b/Documentation/git-update-ref.txt
> @@ -8,7 +8,7 @@ git-update-ref - Update the object name stored in a ref safely
>  SYNOPSIS
>  --------
>  [verse]
> -'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] <ref> <newvalue> [<oldvalue>] | --stdin [-z])
> +'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] [--create-reflog] <ref> <newvalue> [<oldvalue>] | --stdin [-z])
>  
>  DESCRIPTION
>  -----------
> @@ -67,6 +67,9 @@ performs all modifications together.  Specify commands of the form:
>  	verify SP <ref> [SP <oldvalue>] LF
>  	option SP <opt> LF
>  
> +With `--create-reflog`, update-ref will create a reflog for each ref
> +even if one would not ordinarily be created.
> +
>  Quote fields containing whitespace as if they were strings in C source
>  code; i.e., surrounded by double-quotes and with backslash escapes.
>  Use 40 "0" characters or the empty string to specify a zero value.  To
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 5f6cdc5..896f434 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -579,6 +579,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	struct create_tag_options opt;
>  	char *cleanup_arg = NULL;
>  	int annotate = 0, force = 0, lines = -1;
> +	int create_reflog = 0;
>  	int cmdmode = 0;
>  	const char *msgfile = NULL, *keyid = NULL;
>  	struct msg_arg msg = { 0, STRBUF_INIT };
> @@ -605,6 +606,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  		OPT_STRING('u', "local-user", &keyid, N_("key-id"),
>  					N_("use another key to sign the tag")),
>  		OPT__FORCE(&force, N_("replace the tag if exists")),
> +		OPT_BOOL(0, "create-reflog", &create_reflog, N_("create_reflog")),
>  
>  		OPT_GROUP(N_("Tag listing options")),
>  		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
> @@ -730,6 +732,9 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
>  	if (annotate)
>  		create_tag(object, tag, &buf, &opt, prev, object);
>  
> +	if (create_reflog && safe_create_reflog(ref.buf, &err, 1))
> +		die("failed to create reflog for %s: %s", ref.buf, err.buf);
> +

This reflog should not be left around if the tag creation ultimately
fails for any reason.

>  	transaction = ref_transaction_begin(&err);
>  	if (!transaction ||
>  	    ref_transaction_update(transaction, ref.buf, object, prev,
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 6763cf1..d570e5e 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -14,6 +14,7 @@ static const char * const git_update_ref_usage[] = {
>  
>  static char line_termination = '\n';
>  static int update_flags;
> +int create_reflog;
>  static const char *msg;
>  
>  /*
> @@ -198,6 +199,9 @@ static const char *parse_cmd_update(struct ref_transaction *transaction,
>  	if (*next != line_termination)
>  		die("update %s: extra input: %s", refname, next);
>  
> +	if (create_reflog && safe_create_reflog(refname, &err, 1))
> +		die("failed to create reflog for %s: %s", refname, err.buf);
> +

It is valid to pass the empty string or 0{40} to the `update` command as
the "new" value, in which case the reference will be deleted. In that
case, no reflog should be created.

>  	if (ref_transaction_update(transaction, refname,
>  				   new_sha1, have_old ? old_sha1 : NULL,
>  				   update_flags, msg, &err))
> @@ -230,6 +234,9 @@ static const char *parse_cmd_create(struct ref_transaction *transaction,
>  	if (*next != line_termination)
>  		die("create %s: extra input: %s", refname, next);
>  
> +	if (create_reflog && safe_create_reflog(refname, &err, 1))
> +		die("failed to create reflog for %s: %s", refname, err.buf);
> +
>  	if (ref_transaction_create(transaction, refname, new_sha1,
>  				   update_flags, msg, &err))
>  		die("%s", err.buf);

Should the "verify" command also create a reflog, at least if the
reference is not being verified to be missing?

> @@ -361,6 +368,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
>  					N_("update <refname> not the one it points to")),
>  		OPT_BOOL('z', NULL, &end_null, N_("stdin has NUL-terminated arguments")),
>  		OPT_BOOL( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
> +		OPT_BOOL( 0 , "create-reflog", &create_reflog, N_("create_reflog")),
>  		OPT_END(),
>  	};
>  
> @@ -421,7 +429,7 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
>  
>  	if (no_deref)
>  		flags = REF_NODEREF;
> -	if (delete)
> +	if (delete) {
>  		/*
>  		 * For purposes of backwards compatibility, we treat
>  		 * NULL_SHA1 as "don't care" here:
> @@ -429,7 +437,12 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
>  		return delete_ref(refname,
>  				  (oldval && !is_null_sha1(oldsha1)) ? oldsha1 : NULL,
>  				  flags);
> -	else
> +	} else {
> +		struct strbuf err = STRBUF_INIT;
> +		if (create_reflog && safe_create_reflog(refname, &err, 1))
> +			die("failed to create reflog for %s: %s", refname, err.buf);

This reflog also should not be left around if the reference does not
exist at the end of this command.

> +
>  		return update_ref(msg, refname, sha1, oldval ? oldsha1 : NULL,
>  				  flags, UPDATE_REFS_DIE_ON_ERR);
> +	}
>  }
> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
> index d787bf5..9d21c19 100755
> --- a/t/t1400-update-ref.sh
> +++ b/t/t1400-update-ref.sh
> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
