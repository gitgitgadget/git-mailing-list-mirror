From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v6 5/7] refs: new public ref function: safe_create_reflog
Date: Mon, 06 Jul 2015 18:21:44 +0200
Message-ID: <559AAB18.1090701@alum.mit.edu>
References: <1435609076-8592-1-git-send-email-dturner@twopensource.com> <1435609076-8592-6-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: David Turner <dturner@twopensource.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 06 18:21:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZC99V-0006Uz-3D
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 18:21:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755317AbbGFQVr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 12:21:47 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:57068 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750862AbbGFQVq (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jul 2015 12:21:46 -0400
X-AuditID: 1207440c-f79e16d000002a6e-d1-559aab192350
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 0F.3F.10862.91BAA955; Mon,  6 Jul 2015 12:21:45 -0400 (EDT)
Received: from [192.168.69.130] (p5DDB05DB.dip0.t-ipconnect.de [93.219.5.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t66GLicp017128
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 6 Jul 2015 12:21:45 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <1435609076-8592-6-git-send-email-dturner@twopensource.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNIsWRmVeSWpSXmKPExsUixO6iqCu5elaowZwPuhbzN51gtOi60s3k
	wOSx4Pl9do/Pm+QCmKK4bZISS8qCM9Pz9O0SuDPeHu1iKdipUrHgQyNbA+MjmS5GTg4JAROJ
	F0tOsUDYYhIX7q1n62Lk4hASuMwo8XnLdRYI5yyTxOut91hBqngFtCX+vjzP1MXIwcEioCrx
	/nAWSJhNQFdiUU8zWFhUIEji9ctciGpBiZMzn4DNFxFwkLi86ygziC0s4Ctx4vNTVojxzYwS
	66Z/ABvPKeAhsWTbbjCbWUBPYsf1X1C2vETz1tnMExj5ZyGZOwtJ2SwkZQsYmVcxyiXmlObq
	5iZm5hSnJusWJyfm5aUW6Rrq5WaW6KWmlG5ihAQkzw7Gb+tkDjEKcDAq8fBuqJsZKsSaWFZc
	mXuIUZKDSUmU98WKWaFCfEn5KZUZicUZ8UWlOanFhxglOJiVRHj/LQXK8aYkVlalFuXDpKQ5
	WJTEeVWXqPsJCaQnlqRmp6YWpBbBZGU4OJQkeLevBGoULEpNT61Iy8wpQUgzcXCCDOeSEilO
	zUtJLUosLcmIB0VkfDEwJkFSPEB7nUDaeYsLEnOBohCtpxgVpcR5d4MkBEASGaV5cGNhaeYV
	ozjQl8K8OiBVPMAUBdf9CmgwE9Dg5bpgg0sSEVJSDYyWk1wvWjg1P8t5+G+DyWabWa8nbWgR
	zruvvOel1jT/e2c6rJOSZ+jJy/osCF/M+DRP4dmsS+a2Ymf5/y9XWKykeOfwDwu5C7+nufmu
	3il6NGyC18LNQUzTp7IHxgimXiroufgstpuL8+fzmy99Y7jVT3BW26qbTEg+tNmW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273398>

On 06/29/2015 10:17 PM, David Turner wrote:
> The safe_create_reflog function creates a reflog, if it does not
> already exist.
> 
> The log_ref_setup function becomes private and gains a force_create
> parameter to force the creation of a reflog even if log_all_ref_updates
> is false or the refname is not one of the special refnames.
> 
> The new parameter also reduces the need to store, modify, and restore
> the log_all_ref_updates global before reflog creation.
> 
> In a moment, we will use this to add reflog creation commands to
> git-reflog.
> 
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---
>  builtin/checkout.c | 10 +---------
>  refs.c             | 25 +++++++++++++++++++++----
>  refs.h             |  2 +-
>  3 files changed, 23 insertions(+), 14 deletions(-)
> 
> diff --git a/builtin/checkout.c b/builtin/checkout.c
> index 93f63d3..9f68399 100644
> --- a/builtin/checkout.c
> +++ b/builtin/checkout.c
> @@ -620,19 +620,11 @@ static void update_refs_for_switch(const struct checkout_opts *opts,
>  	if (opts->new_branch) {
>  		if (opts->new_orphan_branch) {
>  			if (opts->new_branch_log && !log_all_ref_updates) {
> -				int temp;
> -				struct strbuf log_file = STRBUF_INIT;
> -				int ret;
>  				const char *ref_name;
>  				struct strbuf err = STRBUF_INIT;
>  
>  				ref_name = mkpath("refs/heads/%s", opts->new_orphan_branch);
> -				temp = log_all_ref_updates;
> -				log_all_ref_updates = 1;
> -				ret = log_ref_setup(ref_name, &log_file, &err);
> -				log_all_ref_updates = temp;
> -				strbuf_release(&log_file);
> -				if (ret) {
> +				if (safe_create_reflog(ref_name, &err, 1)) {
>  					fprintf(stderr, _("Can not do reflog for '%s'. %s\n"),
>  						opts->new_orphan_branch, err.buf);
>  					strbuf_release(&err);

This was probably already dangerous before your change, but...

mkpath() returns a pointer to a static buffer. It is subject to being
overwritten if any of a number of path-related functions is called. So
passing it into a function is dangerous.

Instead, you should store it into memory that you control, for example
by using a strbuf and strbuf_addf().

Also, we usually call variables holding reference names "refname", not
"ref_name". Maybe rename the variable while you are in the area.

> diff --git a/refs.c b/refs.c
> index 30e81ba..1e53ef0 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -3128,8 +3128,14 @@ static int should_autocreate_reflog(const char *refname)
>  		!strcmp(refname, "HEAD");
>  }
>  
> -/* This function will fill in *err and return -1 on failure */
> -int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err)
> +/*
> + * This function creates a reflog for a ref.  If force_create = 0, the
> + * reflog will only be created for certain refs (those for which
> + * should_autocreate_reflog returns non-zero.  Otherwise, it will be
> + * created regardless of the ref name.  This function will fill in *err
> + * and return -1 on failure
> + */

It is preferable to write function docstrings in the imperative voice:

    Create a reflog for a ref. If force_create == 0, only create
    the reflog for certain refs...

> +static int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf *err, int force_create)
>  {
>  	int logfd, oflags = O_APPEND | O_WRONLY;
>  	char *logfile;
> @@ -3138,7 +3144,7 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
>  	logfile = sb_logfile->buf;
>  	/* make sure the rest of the function can't change "logfile" */
>  	sb_logfile = NULL;
> -	if (should_autocreate_reflog(refname)) {
> +	if (force_create || should_autocreate_reflog(refname)) {
>  		if (safe_create_leading_directories(logfile) < 0) {
>  			strbuf_addf(err, "unable to create directory for %s. "
>  				    "%s", logfile, strerror(errno));
> @@ -3173,6 +3179,17 @@ int log_ref_setup(const char *refname, struct strbuf *sb_logfile, struct strbuf
>  	return 0;
>  }
>  
> +
> +int safe_create_reflog(const char *refname, struct strbuf *err, int force_create)
> +{
> +	int ret;
> +	struct strbuf sb = STRBUF_INIT;
> +
> +	ret = log_ref_setup(refname, &sb, err, force_create);
> +	strbuf_release(&sb);
> +	return ret;
> +}
> +

Is it really necessary to have two functions, safe_create_reflog() and
log_ref_setup()? I don't see any of the callers doing anything special
with the sb_logfile argument from the latter, so maybe it could be
inlined into safe_create_reflog()? Maybe I'm overlooking something.

> [...]

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
