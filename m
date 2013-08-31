From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 7/8] update-ref: support multiple simultaneous updates
Date: Sat, 31 Aug 2013 20:42:32 +0200
Message-ID: <52223918.6040603@alum.mit.edu>
References: <cover.1377784597.git.brad.king@kitware.com> <cover.1377885441.git.brad.king@kitware.com> <ba564b6566b54d780a24355ca893294d814d8d24.1377885441.git.brad.king@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	Martin Fick <mfick@codeaurora.org>
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Sat Aug 31 20:49:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFqEx-0006VG-2i
	for gcvg-git-2@plane.gmane.org; Sat, 31 Aug 2013 20:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754333Ab3HaStj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Aug 2013 14:49:39 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:58174 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753088Ab3HaSti (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 31 Aug 2013 14:49:38 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Aug 2013 14:49:38 EDT
X-AuditID: 1207440c-b7f016d000005997-72-5222391b05ee
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id D0.82.22935.B1932225; Sat, 31 Aug 2013 14:42:35 -0400 (EDT)
Received: from [192.168.69.9] (p57A2512F.dip0.t-ipconnect.de [87.162.81.47])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r7VIgX2h002452
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 31 Aug 2013 14:42:34 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804 Thunderbird/17.0.8
In-Reply-To: <ba564b6566b54d780a24355ca893294d814d8d24.1377885441.git.brad.king@kitware.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGKsWRmVeSWpSXmKPExsUixO6iqCttqRRkcH6XjcXOdRIWXVe6mSwa
	eq8wW9x/v47JgcXjcl8vk8fHZ8vZPS5eUvb4vEkugCWK2yYpsaQsODM9T98ugTvjzdK5rAWt
	VhVTujrZGhiX6XYxcnJICJhIzD92hBXCFpO4cG89WxcjF4eQwGVGiXXfW9khnDNMEpc+fGQH
	qeIV0JZouvOVDcRmEVCV2H33BJjNJqArsainmQnEFhUIk9gxfSIbRL2gxMmZT1hAbBGg+lXr
	GsDizAJ+El1PZoNtFhbwldi8YC8TxLKtjBLrp+4EauDg4BSIkVh+rwiiXkfiXd8DZghbXmL7
	2znMExgFZiFZMQtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Rrq5WaW6KWmlG5i
	hIQzzw7Gb+tkDjEKcDAq8fAmLFUIEmJNLCuuzD3EKMnBpCTKa2yhFCTEl5SfUpmRWJwRX1Sa
	k1p8iFGCg1lJhPf0SsUgId6UxMqq1KJ8mJQ0B4uSOK/qEnU/IYH0xJLU7NTUgtQimKwMB4eS
	BK8AyFDBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4UKzGFwOjFSTFA7RXGKSdt7gg
	MRcoCtF6ilGX413TvE+MQix5+XmpUuK8KiBFAiBFGaV5cCtgyesVozjQx8K8/iBVPMDEBzfp
	FdASJqAl1yaCPFdckoiQkmpgZFoS4yXqmXXZWFm6/PtajhWilz6rlc3w5Xz02f6LkMUVrup1
	ghtlxHZMi55wb8sSo7erRfmOPr7U8+RZ2xa2v9N237yz62fmi/cLVn3of2Tc/YHt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233529>

On 08/30/2013 08:12 PM, Brad King wrote:
> Add a --stdin signature to read update instructions from standard input
> and apply multiple ref updates together.  Use an input format that
> supports any update that could be specified via the command-line,
> including object names like 'branch:path with space'.
> 
> Signed-off-by: Brad King <brad.king@kitware.com>
> ---
>  Documentation/git-update-ref.txt |   21 ++++++-
>  builtin/update-ref.c             |  121 +++++++++++++++++++++++++++++++++++++-
>  2 files changed, 140 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-ref.txt
> index 0df13ff..295d0bb 100644
> --- a/Documentation/git-update-ref.txt
> +++ b/Documentation/git-update-ref.txt
> @@ -8,7 +8,7 @@ git-update-ref - Update the object name stored in a ref safely
>  SYNOPSIS
>  --------
>  [verse]
> -'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] <ref> <newvalue> [<oldvalue>])
> +'git update-ref' [-m <reason>] (-d <ref> [<oldvalue>] | [--no-deref] <ref> <newvalue> [<oldvalue>] | --stdin)
>  
>  DESCRIPTION
>  -----------
> @@ -58,6 +58,25 @@ archive by creating a symlink tree).
>  With `-d` flag, it deletes the named <ref> after verifying it
>  still contains <oldvalue>.
>  
> +With `--stdin`, update-ref reads instructions from standard input and
> +performs all modifications together.  Empty lines are ignored.
> +Each non-empty line is parsed as whitespace-separated arguments.
> +Use single-quotes to enclose whitespace and backslashes and an
> +unquoted backslash to escape a single quote.  Specify updates with
> +lines of the form:
> +
> +	[--no-deref] [--] <ref> <newvalue> [<oldvalue>]
> +
> +Lines of any other format or a repeated <ref> produce an error.
> +Specify a zero <newvalue> to delete a ref and/or a zero <oldvalue>
> +to make sure that a ref not exist.  Use either 40 "0" or the
> +empty string (written as '') to specify a zero value.
> +
> +If all <ref>s can be locked with matching <oldvalue>s
> +simultaneously all modifications are performed.  Otherwise, no

Comma after "simultaneously".

> +modifications are performed.  Note that while each individual
> +<ref> is updated or deleted atomically, a concurrent reader may
> +still see a subset of the modifications.
>  
>  Logging Updates
>  ---------------
> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
> index 51d2684..eb8db85 100644
> --- a/builtin/update-ref.c
> +++ b/builtin/update-ref.c
> @@ -6,19 +6,129 @@
>  static const char * const git_update_ref_usage[] = {
>  	N_("git update-ref [options] -d <refname> [<oldval>]"),
>  	N_("git update-ref [options]    <refname> <newval> [<oldval>]"),
> +	N_("git update-ref [options] --stdin"),
>  	NULL
>  };
>  
> +static const char blank[] = " \t\r\n";
> +
> +static int updates_size;
> +static int updates_count;
> +static struct ref_update *updates;
> +
> +static const char* update_refs_stdin_next_arg(const char* next,
> +					      struct strbuf *arg)
> +{
> +	/* Skip leading whitespace: */
> +	while (isspace(*next))
> +		++next;
> +
> +	/* Return NULL when no argument is found: */
> +	if (!*next)
> +		return NULL;
> +
> +	/* Parse the argument: */
> +	strbuf_reset(arg);
> +	for (;;) {
> +		char c = *next;
> +		if (!c || isspace(c))
> +			break;
> +		++next;
> +		if (c == '\'') {
> +			size_t len = strcspn(next, "'");

I agree with Junio that your quoting rules are peculiar.

> +			if (!next[len])
> +				die("unterminated single-quote: '%s", next);
> +			strbuf_add(arg, next, len);
> +			next += len + 1;
> +			continue;
> +		}
> +		if (c == '\\') {
> +			if (*next == '\'')
> +				c = *next++;
> +			else
> +				die("unquoted backslash not escaping "
> +				    "single-quote: \\%s", next);
> +		}
> +		strbuf_addch(arg, c);
> +	}
> +	return next;
> +}
> +
> +static void update_refs_stdin(const char *line)
> +{
> +	int options = 1, flags = 0, argc = 0;
> +	char *argv[3] = {0, 0, 0};
> +	struct strbuf arg = STRBUF_INIT;
> +	struct ref_update *update;
> +	const char *next = line;
> +
> +	/* Skip blank lines: */
> +	if (!line[0])
> +		return;
> +
> +	/* Parse arguments on this line: */
> +	while ((next = update_refs_stdin_next_arg(next, &arg)) != NULL) {
> +		if (options && arg.buf[0] == '-')
> +			if (!strcmp(arg.buf, "--no-deref"))
> +				flags |= REF_NODEREF;
> +			else if (!strcmp(arg.buf, "--"))
> +				options = 0;
> +			else
> +				die("unknown option %s", arg.buf);
> +		else if (argc >= 3)
> +			die("too many arguments on line: %s", line);
> +		else {
> +			argv[argc++] = xstrdup(arg.buf);
> +			options = 0;
> +		}
> +	}
> +	strbuf_release(&arg);
> +
> +	/* Allocate and zero-init a struct ref_update: */
> +	if (updates_count == updates_size) {
> +		updates_size = updates_size ? (updates_size * 2) : 16;
> +		updates = xrealloc(updates, sizeof(*updates) * updates_size);
> +		memset(updates + updates_count, 0,
> +		       sizeof(*updates) * (updates_size - updates_count));
> +	}

Here you can use ARRAY_GROW().  See

    Documentation/technical/api-allocation-growing.txt

> +	update = &updates[updates_count++];
> +	update->flags = flags;
> +
> +	/* Set the update ref_name: */
> +	if (!argv[0])
> +		die("no ref on line: %s", line);
> +	if (check_refname_format(argv[0], REFNAME_ALLOW_ONELEVEL))
> +		die("invalid ref format on line: %s", line);
> +	update->ref_name = argv[0];
> +	argv[0] = 0;
> +
> +	/* Set the update new_sha1 and, if specified, old_sha1: */
> +	if (!argv[1])
> +		die("missing new value on line: %s", line);
> +	if (*argv[1] && get_sha1(argv[1], update->new_sha1))
> +		die("invalid new value on line: %s", line);
> +	if (argv[2]) {
> +		update->have_old = 1;
> +		if (*argv[2] && get_sha1(argv[2], update->old_sha1))
> +			die("invalid old value on line: %s", line);
> +	}
> +
> +	while (argc > 0)
> +		free(argv[--argc]);
> +}
> +
>  int cmd_update_ref(int argc, const char **argv, const char *prefix)
>  {
>  	const char *refname, *oldval, *msg = NULL;
>  	unsigned char sha1[20], oldsha1[20];
> -	int delete = 0, no_deref = 0, flags = 0;
> +	int delete = 0, no_deref = 0, read_stdin = 0, flags = 0;
> +	struct strbuf line = STRBUF_INIT;
>  	struct option options[] = {
>  		OPT_STRING( 'm', NULL, &msg, N_("reason"), N_("reason of the update")),
>  		OPT_BOOLEAN('d', NULL, &delete, N_("delete the reference")),
>  		OPT_BOOLEAN( 0 , "no-deref", &no_deref,
>  					N_("update <refname> not the one it points to")),
> +		OPT_BOOLEAN( 0 , "stdin", &read_stdin, N_("read updates from stdin")),
>  		OPT_END(),
>  	};
>  
> @@ -28,6 +138,15 @@ int cmd_update_ref(int argc, const char **argv, const char *prefix)
>  	if (msg && !*msg)
>  		die("Refusing to perform update with empty message.");
>  
> +	if (read_stdin) {
> +		if (delete || no_deref || argc > 0)
> +			usage_with_options(git_update_ref_usage, options);
> +		while (strbuf_getline(&line, stdin, '\n') != EOF)
> +			update_refs_stdin(line.buf);
> +		strbuf_release(&line);
> +		return update_refs(msg, updates, updates_count, DIE_ON_ERR);
> +	}
> +
>  	if (delete) {
>  		if (argc < 1 || argc > 2)
>  			usage_with_options(git_update_ref_usage, options);
> 


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
