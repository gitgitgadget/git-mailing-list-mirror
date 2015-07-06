From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 6/7] git-reflog: add create and exists functions
Date: Mon, 06 Jul 2015 18:51:12 +0200
Message-ID: <559AB200.5020108@alum.mit.edu>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com> <1435609076-8592-7-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 18:51:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC9c4-0007qa-Np
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 18:51:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755436AbbGFQvU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 12:51:20 -0400
Received: from alum-mailsec-scanner-5.mit.edu ([18.7.68.17]:51281 "EHLO
	alum-mailsec-scanner-5.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751499AbbGFQvS (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jul 2015 12:51:18 -0400
X-AuditID: 12074411-f797e6d000007df3-28-559ab20188c6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-5.mit.edu (Symantec Messaging Gateway) with SMTP id F2.7E.32243.102BA955; Mon,  6 Jul 2015 12:51:13 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB05DB.dip0.t-ipconnect.de [93.219.5.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t66GpCbu019042
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jul 2015 12:51:13 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1435609076-8592-7-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqMu4aVaowd3l1hbzN51gtOi60s3k
	wOSx4Pl9do/Pm+QCmKK4bZISS8qCM9Pz9O0SuDP2rOxnLXhlV3HzzyuWBsbnhl2MnBwSAiYS
	a4++Y4GwxSQu3FvP1sXIxSEkcJlRYsW6d8wQzlkmiZvztoNV8QpoS8y/v4kVxGYRUJXYe/MO
	WJxNQFdiUU8zUxcjB4eoQJDE65e5EOWCEidnPgErERFwkLi86ygziC0s4C5x6+9LJhBbSKCZ
	UWL6omgQm1PAQ+L0xW9g45kF9CR2XP8FZctLNG+dzTyBkX8WkrGzkJTNQlK2gJF5FaNcYk5p
	rm5uYmZOcWqybnFyYl5eapGuqV5uZoleakrpJkZIQAruYJxxUu4QowAHoxIPb0TNzFAh1sSy
	4srcQ4ySHExKoryGa2aFCvEl5adUZiQWZ8QXleakFh9ilOBgVhLh/bcUKMebklhZlVqUD5OS
	5mBREuflW6LuJySQnliSmp2aWpBaBJOV4eBQkuD9sQGoUbAoNT21Ii0zpwQhzcTBCTKcS0qk
	ODUvJbUosbQkIx4UkfHFwJgESfEA7e0GaectLkjMBYpCtJ5iVJQS5w0GSQiAJDJK8+DGwtLM
	K0ZxoC+FebeAVPEAUxRc9yugwUxAg5frgg0uSURISTUwCl33sJ59SW1xJfvzYr+XKQquk45O
	iqsKqjuuGLN6Xe0RgZqkdIP+3f6ph2ZOFI6N5dDbbWkwfZI7d+7sfiH5TNFfi2MD3t6+frxF
	rIbx8+8zT2tML7NPnPbrIePWXM4zzy6y/NvT/GZdfOgiM8V9VUKTi6M3ScVXbFhY 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273404>

On 06/29/2015 10:17 PM, David Turner wrote:
> These are necessary because alternate ref backends might store reflogs
> somewhere other than .git/logs.  Code that now directly manipulates
> .git/logs should instead go through git-reflog.
> 
> In a moment, we will use these functions to make git stash work with
> alternate ref backends.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  Documentation/git-reflog.txt | 10 ++++++
>  builtin/reflog.c             | 75 +++++++++++++++++++++++++++++++++++++++++++-
>  t/t1411-reflog-show.sh       | 12 +++++++
>  3 files changed, 96 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/git-reflog.txt b/Documentation/git-reflog.txt
> index 5e7908e..2bf8aa6 100644
> --- a/Documentation/git-reflog.txt
> +++ b/Documentation/git-reflog.txt
> @@ -23,6 +23,8 @@ depending on the subcommand:
>  	[--dry-run] [--verbose] [--all | <refs>...]
>  'git reflog delete' [--rewrite] [--updateref]
>  	[--dry-run] [--verbose] ref@\{specifier\}...
> +'git reflog create' <refs>...
> +'git reflog exists' <ref>
>  
>  Reference logs, or "reflogs", record when the tips of branches and
>  other references were updated in the local repository. Reflogs are
> @@ -52,6 +54,14 @@ argument must be an _exact_ entry (e.g. "`git reflog delete
>  master@{2}`"). This subcommand is also typically not used directly by
>  end users.
>  
> +The "create" subcommand creates a reflog for one or more refs. Most
> +refs (those under refs/heads, refs/remotes, and refs/tags) will
> +automatically have reflogs created. Other refs will not. This command
> +allows manual ref creation.
> +
> +The "exists" subcommand checks whether a ref has a reflog.  It exists
> +with zero status if the reflog exists, and non-zero status if it does
> +not.
>  
>  OPTIONS
>  -------
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index c2eb8ff..3080865 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -13,6 +13,10 @@ static const char reflog_expire_usage[] =
>  "git reflog expire [--expire=<time>] [--expire-unreachable=<time>] [--rewrite] [--updateref] [--stale-fix] [--dry-run | -n] [--verbose] [--all] <refs>...";
>  static const char reflog_delete_usage[] =
>  "git reflog delete [--rewrite] [--updateref] [--dry-run | -n] [--verbose] <refs>...";
> +static const char reflog_create_usage[] =
> +"git reflog create <refs>...";
> +static const char reflog_exists_usage[] =
> +"git reflog exists <ref>";
>  
>  static unsigned long default_reflog_expire;
>  static unsigned long default_reflog_expire_unreachable;
> @@ -699,12 +703,75 @@ static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
>  	return status;
>  }
>  
> +static int cmd_reflog_create(int argc, const char **argv, const char *prefix)
> +{
> +	int i, status = 0, start = 0;

It looks like start is initialized unconditionally after the first loop,
so the initialization here is a red herring.

> +	struct strbuf err = STRBUF_INIT;
> +
> +	for (i = 1; i < argc; i++) {
> +		const char *arg = argv[i];
> +		if (!strcmp(arg, "--")) {
> +			i++;
> +			break;
> +		}
> +		else if (arg[0] == '-')
> +			usage(reflog_create_usage);
> +		else
> +			break;
> +	}
> +
> +	start = i;
> +
> +	if (argc - start < 1)

    if (start == argc)

seems clearer, but that might just be me.

> +		return error("Nothing to create?");
> +
> +	for (i = start; i < argc; i++) {
> +		if (check_refname_format(argv[i], REFNAME_ALLOW_ONELEVEL))
> +			die("invalid ref format: %s", argv[i]);
> +	}
> +	for (i = start; i < argc; i++) {
> +		if (safe_create_reflog(argv[i], &err, 1)) {
> +			error("could not create reflog %s: %s", argv[i],
> +			      err.buf);
> +			status = 1;
> +			strbuf_release(&err);
> +		}
> +	}
> +	return status;
> +}
> +

So, I have a philosophical question here with a practical side...

It appears that this command allows you to create a reflog for a
reference that doesn't yet exist. At first blush, this seems to make
sense. Suppose you want the creation of a reference to be logged. Then
you can first turn on its reflog, then create it.

But I think this is going to create problems. Reflogs are rather
intimately connected to their references. For example, writes to a
reflog are guarded by locking the corresponding reference. And currently
a reflog file is deleted when the corresponding reference is deleted.
Also, there are constraints about which references can coexist; for
example, references "refs/heads/foo" and "refs/heads/foo/bar" cannot
exist at the same time, because (at least when using the filesystem
backend), "refs/heads/foo" would have to be both a file and a directory
at the same time. So if one of these references already exists, it would
be an error to create a reflog for the other one.

Similarly, if there is a reflog file for one of these references that
was created by this command, but there is not yet a corresponding
reference, then any command that later tries to create the other
reference will not be able to create the reflog for *that* reference
because it will conflict with the existing reflog. I doubt that the
reference creation is smart enough to deal with this situation.

So all in all, I think it is unwise to allow a reflog to be created
without its corresponding reference.

This, in turn, suggests one or both of the following alternatives:

1. Allow "git reflog create", but only for references that already exist.

2. If we want to allow a reflog to be created at the same time as the
corresponding reference, the reference-creation commands ("git branch",
"git tag", "git update-ref", and maybe some others) probably need a new
option like "--create-reflog" (and, for symmetry, probably
"--no-create-reflog").

At the API level, it might make sense for the ref-transaction functions
to get a new "REF_FORCE_CREATE_REFLOG" flag or something.

> +static int cmd_reflog_exists(int argc, const char **argv, const char *prefix)
> +{
> +	int i, start = 0;
> +
> +	for (i = 1; i < argc; i++) {
> +		const char *arg = argv[i];
> +		if (!strcmp(arg, "--")) {
> +			i++;
> +			break;
> +		}
> +		else if (arg[0] == '-')
> +			usage(reflog_exists_usage);
> +		else
> +			break;
> +	}
> +
> +	start = i;
> +
> +	if (argc - start != 1)
> +		usage(reflog_exists_usage);
> +
> +	if (check_refname_format(argv[start], REFNAME_ALLOW_ONELEVEL))
> +		die("invalid ref format: %s", argv[start]);
> +	return !reflog_exists(argv[start]);
> +}
> +
>  /*
>   * main "reflog"
>   */
>  
>  static const char reflog_usage[] =
> -"git reflog [ show | expire | delete ]";
> +"git reflog [ show | expire | delete | create | exists ]";
>  
>  int cmd_reflog(int argc, const char **argv, const char *prefix)
>  {
> @@ -724,5 +791,11 @@ int cmd_reflog(int argc, const char **argv, const char *prefix)
>  	if (!strcmp(argv[1], "delete"))
>  		return cmd_reflog_delete(argc - 1, argv + 1, prefix);
>  
> +	if (!strcmp(argv[1], "create"))
> +		return cmd_reflog_create(argc - 1, argv + 1, prefix);
> +
> +	if (!strcmp(argv[1], "exists"))
> +		return cmd_reflog_exists(argc - 1, argv + 1, prefix);
> +
>  	return cmd_log_reflog(argc, argv, prefix);
>  }
> diff --git a/t/t1411-reflog-show.sh b/t/t1411-reflog-show.sh
> index 6f47c0d..6e1abe7 100755
> --- a/t/t1411-reflog-show.sh
> +++ b/t/t1411-reflog-show.sh
> @@ -166,4 +166,16 @@ test_expect_success 'git log -g -p shows diffs vs. parents' '
>  	test_cmp expect actual
>  '
>  
> +test_expect_success 'reflog exists works' '
> +	git reflog exists refs/heads/master &&
> +	! git reflog exists refs/heads/nonexistent
> +'
> +
> +test_expect_success 'reflog create works' '
> +	git update-ref non-refs-dir HEAD &&
> +	! git reflog exists non-refs-dir &&
> +	git reflog create non-refs-dir &&
> +	git reflog exists non-refs-dir
> +'
> +
>  test_done
> 

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
