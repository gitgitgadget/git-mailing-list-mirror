From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] refs.c: add new functions reflog_exists and delete_reflog
Date: Tue, 06 May 2014 17:55:54 +0200
Message-ID: <5369060A.2050400@alum.mit.edu>
References: <1399330677-17930-1-git-send-email-sahlberg@google.com> <1399330677-17930-2-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Ronnie Sahlberg <sahlberg@google.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 06 21:22:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhiWa-0008Jm-GW
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 18:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758073AbaEFP4O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 11:56:14 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:53921 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758056AbaEFPz5 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 May 2014 11:55:57 -0400
X-AuditID: 12074413-f79076d000002d17-6f-5369060c7fa6
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id DC.F8.11543.C0609635; Tue,  6 May 2014 11:55:56 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97C6E.dip0.t-ipconnect.de [79.201.124.110])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s46Ftsc2000555
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 6 May 2014 11:55:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <1399330677-17930-2-git-send-email-sahlberg@google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFupjleLIzCtJLcpLzFFi42IRYndR1OVhyww2mP5TzaLrSjeTxb8JNQ5M
	Hgs2lXp83iQXwBTFbZOUWFIWnJmep2+XwJ1xuF+v4KxlxeJTNxgbGJfpdjFyckgImEhMnjyJ
	GcIWk7hwbz1bFyMXh5DAZUaJk1s/QTnnmSSubJ7NDlLFK6AtcWL2cSCbg4NFQFXi9VoPkDCb
	gK7Eop5mJpCwqECQxJ+zihDVghInZz5hAbFFBOwk1t9aCLZLWMBPYsedU6wgtpBAtcSvNQcZ
	QWxOAReJiU8+MYOMkRAQl+hpDAIJMwvoSLzre8AMYctLbH87h3kCo8AsJBtmISmbhaRsASPz
	Kka5xJzSXN3cxMyc4tRk3eLkxLy81CJdc73czBK91JTSTYyQ8BTewbjrpNwhRgEORiUe3o4X
	GcFCrIllxZW5hxglOZiURHmF/gOF+JLyUyozEosz4otKc1KLDzFKcDArifCe+w2U401JrKxK
	LcqHSUlzsCiJ86otUfcTEkhPLEnNTk0tSC2CycpwcChJ8FawZgYLCRalpqdWpGXmlCCkmTg4
	QYZzSYkUp+alpBYllpZkxINiNL4YGKUgKR6gvVYg7bzFBYm5QFGI1lOMuhwXGla0MAmx5OXn
	pUqJ87qAFAmAFGWU5sGtgCWjV4ziQB8L89aBVPEAExncpFdAS5iAlnAZp4MsKUlESEk1MOZO
	vmsQy9s9+bfp/DN7zT+v+nbx97uvxYonNwdnrXYXvPOYzTHOuS/7bv+h59W6zAJ7XHf7LN18
	ykLpb+Sn3KvacQZHQ1e33zzv7CA8N7H2yd4NIiE5JQligVk7nx3+m3rG7MQZacdn 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248218>

On 05/06/2014 12:57 AM, Ronnie Sahlberg wrote:
> Add two new functions, reflog_exists and delete_reflog to hide the internal

Need comma after "delete_reflog".

> reflog implementation (that they are files under .git/logs/...) from callers.
> Update checkout.c to use these functions in update_refs_for_switch instead of
> building pathnames and calling out to file access functions. Update reflog.c
> to use these too check if the reflog exists. Now there are still many places

s/too/to/

> in reflog.c where we are still leaking the reflog storage implementation but
> this at least reduces the number of such dependencies by one. Finally
> change two places in refs.c itself to use the new function to check if a ref
> exists or not isntead of build-path-and-stat(). Now, this is strictly not all

s/isntead/instead/

> that important since these are in parts of refs that are implementing the
> actual file storage backend but on the other hand it will not hurt either.

As an aside, I expect long term that reflog handling will be married
more tightly to reference handling and probably both will become
pluggable via a single mechanism.

> In config.c we also change to use the existing function ref_exists instead of

s/config.c/checkout.c/

> checking if the loose ref file exist. The previous code made the assumption
> that the branch we switched from must exist as a loose ref and thus checking
> the file would be sufficent. I think that assumption is always true in the

s/sufficent/sufficient/

> current code but it is still somewhat fragile since if git would change so that
> the checkedout branch could exist as a packed ref without a corresponding

s/checkedout/checked-out/

> loose ref then this subtle 'does the lose ref not exist' check would suddenly
> fail.

I don't understand.  It can *already* be the case that the checked-out
branch only exists as a packed reference:

    $ git checkout master
    $ git pack-refs --all
    $ find .git/refs -type f
    $

So we already have a bug:

    $ git config core.logallrefupdates true
    $ git commit -m Initial --allow-empty
    [master (root-commit) 3a03d51] Initial
    $ git branch foo
    $ git pack-refs --all
    $ find .git/{refs,logs} -type f
    .git/logs/HEAD
    .git/logs/refs/heads/foo
    .git/logs/refs/heads/master
    $ git checkout foo
    Switched to branch 'foo'
    $ find .git/{refs,logs} -type f
    .git/logs/HEAD
    .git/logs/refs/heads/foo
    $ history | tail -10

Note that the reflog for refs/heads/master is incorrectly deleted when
we run "git checkout foo".

By the way, in case it wasn't clear to you I think the code in question
is trying to avoid leaving a reflog file behind when leaving an orphan
branch that hasn't actually been created yet.  So I think your change to
using ref_exists() will indeed fix the bug (but please test!)

Given that this is a real bug, I suggest breaking this change out into a
separate patch with a corresponding addition to the test suite.

> Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
> ---
>  builtin/checkout.c |  8 ++------
>  builtin/reflog.c   |  2 +-
>  refs.c             | 20 ++++++++++++++------
>  refs.h             |  6 ++++++
>  4 files changed, 23 insertions(+), 13 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index ff44921..f1dc56e 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -651,12 +651,8 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  			}
>  		}
>  		if (old->path && old->name) {
> -			char log_file[PATH_MAX], ref_file[PATH_MAX];
> -
> -			git_snpath(log_file, sizeof(log_file), "logs/%s", old->path);
> -			git_snpath(ref_file, sizeof(ref_file), "%s", old->path);
> -			if (!file_exists(ref_file) && file_exists(log_file))
> -				remove_path(log_file);
> +			if (!ref_exists(old->path) && reflog_exists(old->path))
> +				delete_reflog(old->path);
>  		}
>  	}
>  	remove_branch_state();
> diff --git a/builtin/reflog.c b/builtin/reflog.c
> index c12a9784..0e7ea74 100644
> --- a/builtin/reflog.c
> +++ b/builtin/reflog.c
> @@ -369,7 +369,7 @@ static int expire_reflog(const char *ref, const unsigned char *sha1, int unused,
>  	if (!lock)
>  		return error("cannot lock ref '%s'", ref);
>  	log_file = git_pathdup("logs/%s", ref);
> -	if (!file_exists(log_file))
> +	if (!ref_exists(ref))

Shouldn't this be reflog_exists()?

>  		goto finish;
>  	if (!cmd->dry_run) {
>  		newlog_path = git_pathdup("logs/%s.lock", ref);
> diff --git a/refs.c b/refs.c
> index e59bc18..7d12ac7 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2013,7 +2013,6 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
>  
>  	*log = NULL;
>  	for (p = ref_rev_parse_rules; *p; p++) {
> -		struct stat st;
>  		unsigned char hash[20];
>  		char path[PATH_MAX];
>  		const char *ref, *it;
> @@ -2022,12 +2021,9 @@ int dwim_log(const char *str, int len, unsigned char *sha1, char **log)
>  		ref = resolve_ref_unsafe(path, hash, 1, NULL);
>  		if (!ref)
>  			continue;
> -		if (!stat(git_path("logs/%s", path), &st) &&
> -		    S_ISREG(st.st_mode))
> +		if (reflog_exists(path))
>  			it = path;
> -		else if (strcmp(ref, path) &&
> -			 !stat(git_path("logs/%s", ref), &st) &&
> -			 S_ISREG(st.st_mode))
> +		else if (strcmp(ref, path) && reflog_exists(ref))
>  			it = ref;
>  		else
>  			continue;
> @@ -3030,6 +3026,18 @@ int read_ref_at(const char *refname, unsigned long at_time, int cnt,
>  	return 1;
>  }
>  
> +int reflog_exists(const char *ref)

We try to use the variable name "refname" for variables that hold the
full names of references (the same comment applies to delete_reflog()).

> +{
> +	struct stat st;
> +
> +	return !lstat(git_path("logs/%s", ref), &st) && S_ISREG(st.st_mode);
> +}
> +
> +int delete_reflog(const char *ref)
> +{
> +	return remove_path(git_path("logs/%s", ref));
> +}
> +
>  static int show_one_reflog_ent(struct strbuf *sb, each_reflog_ent_fn fn, void *cb_data)
>  {
>  	unsigned char osha1[20], nsha1[20];
> diff --git a/refs.h b/refs.h
> index 71e39b9..5a93f27 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -159,6 +159,12 @@ extern int read_ref_at(const char *refname, unsigned long at_time, int cnt,
>  		       unsigned char *sha1, char **msg,
>  		       unsigned long *cutoff_time, int *cutoff_tz, int *cutoff_cnt);
>  
> +/** Check if a particular ref log exists */
> +extern int reflog_exists(const char *);

We usually spell s/ref log/reflog/.  The same thing below.

My preference is that you give a name "refname" to the parameter in this
function signature.  That makes it clear at a glance what is expected.
(Though I admit that this practice is far from universally practiced in
the Git project so maybe other people disagree.)

> +
> +/** Delete a ref log */
> +extern int delete_reflog(const char *);
> +
>  /* iterate over reflog entries */
>  typedef int each_reflog_ent_fn(unsigned char *osha1, unsigned char *nsha1, const char *, unsigned long, int, const char *, void *);
>  int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
> 

Thanks!
Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
