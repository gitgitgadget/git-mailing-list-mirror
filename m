From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] defaults for where to merge from (take 3, inline)
Date: Thu, 1 Mar 2007 23:01:14 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703012240210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <es450f$d58$1@sea.gmane.org>
 <Pine.LNX.4.63.0703010221000.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0702282355i176ad7e5t7b9e417b27e524fb@mail.gmail.com>
 <45E68897.8000607@lu.unisi.ch> <81b0412b0703010010o24513f60x937b5af52362e0c8@mail.gmail.com>
 <45E68EDE.2090405@lu.unisi.ch> <81b0412b0703010033w2e1079a3l6ac6e38c59bdefd5@mail.gmail.com>
 <45E69297.8070001@lu.unisi.ch> <81b0412b0703010059w52a33b54n4d3c25ada6b96369@mail.gmail.com>
 <45E69EEE.8070905@lu.unisi.ch> <81b0412b0703010212w5367c8cek51f22e9098f8e22f@mail.gmail.com>
 <7vvehls1h9.fsf@assigned-by-dhcp.cox.net> <45E70041.1030705@lu.unisi.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, Alex Riesen <raa.lkml@gmail.com>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Paolo Bonzini <paolo.bonzini@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 01 23:01:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HMtKz-0008Lg-6e
	for gcvg-git@gmane.org; Thu, 01 Mar 2007 23:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030396AbXCAWBR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Mar 2007 17:01:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030399AbXCAWBR
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Mar 2007 17:01:17 -0500
Received: from mail.gmx.net ([213.165.64.20]:56744 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030396AbXCAWBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2007 17:01:16 -0500
Received: (qmail invoked by alias); 01 Mar 2007 22:01:14 -0000
X-Provags-ID: V01U2FsdGVkX1+66aJXkY66nUVo4WGe8hcCNupMEKBPUVZxkmL9K7
	M1zIlEWohOs1TQ
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45E70041.1030705@lu.unisi.ch>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41135>

Hi,

please don't take my comments as insults or even strict rules. It is 
purely for your consideration. (I say this because I haven't seen you so 
often on this list, so you might not know that discussions about patches 
are sometimes, erm, lively...)

On Thu, 1 Mar 2007, Paolo Bonzini wrote:

> >  (2) by reviewing the changes to the .config writer.  That
> >      traditionally has been one of the more fragile parts of the
> >      system, and I am reluctant to look at it.
> 
> Just FYI, this was broken into a separate patch.
> 
> > I would just feel better to see a patch like this, which is a
> > significant improvement to the system, to be properly signed-off
> > by the submitter.
> 
> I hope this is better, I tried to follow the steps in
> SubmittingPatches properly.  The code is actually the same
> as take 3.

According to SubmittingPatches, this is a cover letter.

	You often want to add additional explanation about the patch, 
	other than the commit message itself.  Place such "cover letter" 
	material between the three dash lines and the diffstat.

So, please put it after the three dashes and the diffstat next time.

> * git-branch: register where to merge from, when branching off a remote branch.

This is the oneline description, which should have been the Subject of the 
mail, preferably prefixed by "[PATCH]" to make it obvious that it is not 
yet another reply in a medium-sized thread, but actually a code 
contribution. SubmittingPatches is not clear about this: you can write 
_anything_ in brackets, and it will be stripped from the commit message 
automatically. In your case, I would have preferred "[PATCH, 3rd 
version]".

> A rather standard (in 1.5) procedure for branching off a remote archive is:

Since this will go into the commit message, which is usually shown in the 
output of "git log", indented, it would be nice to break lines early.

Again, I think that SubmittingPatches is not totally clear about this: I 
try to maintain a maximum width of 76 characters (which seems to be the 
default with pine -- my mail program -- anyway).

> The behavior is controlled by core.trackremotebranches,

I'd make it obvious here that it is on by default -- even if you state 
that earlier, too.

[I leave comments on documentation to others, since I cannot write them 
myself.]

> diff --git a/builtin-branch.c b/builtin-branch.c
> index d0179b0..20de049 100644
> --- a/builtin-branch.c
> +++ b/builtin-branch.c
> @@ -12,7 +12,7 @@
>  #include "builtin.h"
>  
>  static const char builtin_branch_usage[] =
> -  "git-branch [-r] (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length>]]";
> +  "git-branch [-r] (-d | -D) <branchname> | [--track | --no-track] [-l] [-f] <branchname> [<start-point>] | (-m | -M) [<oldbranch>] <newbranch> | [--color | --no-color] [-r | -a] [-v [--abbrev=<length>]]";
>  
>  #define REF_UNKNOWN_TYPE    0x00
>  #define REF_LOCAL_BRANCH    0x01
> @@ -308,15 +307,36 @@ static void print_ref_list(int kinds, int detached, int verbose, int abbrev)
>  	free_ref_list(&ref_list);
>  }
>  
> +static void register_branch_pull (const char *name, const char *remote_name)

It is not yet remote_name, right? it is branch_name. You extract the 
remote_name by finding the first slash.

> +{
> +	char *slash = strchr(remote_name, '/');
> +
> +	char *config_key = xmalloc(strlen(name) + 15);
> +	char *merge_value = xmalloc(strlen(remote_name) + 10);
> +
> +	char *remote_value = xstrdup(remote_name);

I'd use "char key[1024], value[1024]" instead, erroring out if one of the 
buffers are too small. It's not like you have to be memory efficient, and 
it is easier to read.

> +	remote_value[slash - remote_name] = 0;

You should check if slash == NULL and error out before using it.

> +	sprintf(config_key, "branch.%s.remote", name);

This would be a snprintf(key, sizeof(key), "branch.%s.remote", name); and 
snprintf(value, sizeof(value), "%.*s", slash - branch_name, branch_name);

> +	git_config_set(config_key, remote_value);
> +
> +	sprintf(merge_value, "refs/heads/%s", slash + 1);
> +	sprintf(config_key, "branch.%s.merge", name);
> +	git_config_set(config_key, merge_value);
> +
> +	free (config_key);
> +	free (remote_value);
> +	free (merge_value);
> +}
> +
>  static void create_branch(const char *name, const char *start_name,
>  			  unsigned char *start_sha1,
> -			  int force, int reflog)
> +			  int force, int reflog, int track)
>  {
>  	struct ref_lock *lock;
>  	struct commit *commit;
>  	unsigned char sha1[20];
> -	char ref[PATH_MAX], msg[PATH_MAX + 20];
> -	int forcing = 0;
> +	char *real_ref = NULL, ref[PATH_MAX], msg[PATH_MAX + 20];
> +	int forcing = 0, remote = 0;
>  
>  	snprintf(ref, sizeof ref, "refs/heads/%s", name);
>  	if (check_ref_format(ref))
> @@ -333,7 +353,9 @@ static void create_branch(const char *name, const char *start_name,
>  	if (start_sha1)
>  		/* detached HEAD */
>  		hashcpy(sha1, start_sha1);
> -	else if (get_sha1(start_name, sha1))
> +	else if (dwim_ref(start_name, strlen (start_name), sha1, &real_ref))
> +		remote = !prefixcmp(real_ref, "refs/remotes/");
> +	else
>  		die("Not a valid object name: '%s'.", start_name);

Yes, that is how I imagined it. The rest of your patch looks perfect to 
me.

Ciao,
Dscho
