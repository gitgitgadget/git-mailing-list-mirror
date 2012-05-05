From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH] fetch/push: allow refs/*:refs/*
Date: Sat, 05 May 2012 08:03:56 +0200
Message-ID: <4FA4C2CC.7080205@alum.mit.edu>
References: <7vsjfj7des.fsf@alter.siamese.dyndns.org> <7vwr4r8tpm.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 05 08:11:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SQYCy-00051O-R2
	for gcvg-git-2@plane.gmane.org; Sat, 05 May 2012 08:11:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752345Ab2EEGLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 May 2012 02:11:03 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:55824 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752329Ab2EEGLB (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 May 2012 02:11:01 -0400
X-Greylist: delayed 422 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 May 2012 02:11:01 EDT
X-AuditID: 1207440c-b7fc26d0000008c0-e0-4fa4c2cffafc
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 16.4E.02240.FC2C4AF4; Sat,  5 May 2012 02:03:59 -0400 (EDT)
Received: from [192.168.69.140] (p4FC0D13D.dip.t-dialin.net [79.192.209.61])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q4563vBr031230
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 5 May 2012 02:03:58 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <7vwr4r8tpm.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprAKsWRmVeSWpSXmKPExsUixO6iqHv+0BJ/g8nTBS26rnQzWTT0XmF2
	YPK4eEnZ4/MmuQCmKG6bpMSSsuDM9Dx9uwTujN3futkKfqlVdL05yNjA+Fqui5GTQ0LARGJm
	/302CFtM4sK99UA2F4eQwGVGidtLnzNCOKeZJE7tWM0MUsUroC0xvfk9WAeLgKrE0XcdYHE2
	AV2JRT3NTCC2qECYRP/tLUwQ9YISJ2c+YQGxRQTUJCa2HQKyOTiYBcQl+v+BhYWBjljy7Q47
	iC0kEC9x6vBysDingJnE1P5NTBDl1hLfdheBhJkF5CW2v53DPIFRYBaSBbMQqmYhqVrAyLyK
	US4xpzRXNzcxM6c4NVm3ODkxLy+1SNdQLzezRC81pXQTIyREeXYwflsnc4hRgINRiYc3g3eJ
	vxBrYllxZe4hRkkOJiVR3mUHgEJ8SfkplRmJxRnxRaU5qcWHGCU4mJVEeJO+LvYX4k1JrKxK
	LcqHSUlzsCiJ86ouUfcTEkhPLEnNTk0tSC2CycpwcChJ8HIDY1FIsCg1PbUiLTOnBCHNxMEJ
	MpxLSqQ4NS8ltSixtCQjHhSl8cXAOAVJ8QDtvXcQqJ23uCAxFygK0XqKUZdj9pKtVxmFWPLy
	81KlxHnvgxQJgBRllObBrYAlpFeM4kAfC/N+AaniASYzuEmvgJYwAS2RNlgEsqQkESEl1cCo
	UhDa9eQ7w+qnvWmy1Uonb1lMtuRZsE/8rv7LB7/P2cVmvDubNz/8C6tQzVKpH68krSL4dSfe
	Spq5anbn6mOs/7x5V+p83cf2rbo89bnArlXB23SWJt67Kn2QhSfTvPjPk6Idkw4u 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197097>

On 05/05/2012 12:30 AM, Junio C Hamano wrote:
> There are a handful of places where we call check_refname_format() on a
> substring after "refs/" of a refname we are going to use, and filter out a
> valid match with "refs/stash" with such a pathspec.  Not sending a stash
> may arguably be a feature (as stash is inherently a local workflow
> element), but the code in the transport layer is oblivious to this
> filtering performed by the lower layer of the code, and complains that the
> other side did not send all the objects that needs to complete refs/stash
> at the end, even though the code will not write refs/stash out anyway, and
> making the whole command fail.
>
> This is an attempt to "fix" it by using check_refname_format() on the
> whole "refs/....." string and allowing refs/stash to be also copied.
>
> Signed-off-by: Junio C Hamano<gitster@pobox.com>
> ---
>
>   * With this patch:
>
>      $ git checkout HEAD^0 ;# make sure we are on detached HEAD
>      $ git fetch $somewhere +refs/*:refs/*
>
>     and
>
>      victim$ git config receive.denyCurrentBranch warn
>      master$ git push victim +refs/*:refs/*
>
>     should work.
>
>   builtin/fetch-pack.c   |  2 +-
>   builtin/receive-pack.c |  2 +-
>   remote.c               |  2 +-
>   t/t5516-fetch-push.sh  | 30 ++++++++++++++++++++++++++++++
>   4 files changed, 33 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 6207ecd..a3e3fa3 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -546,7 +546,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
>   	for (ref = *refs; ref; ref = next) {
>   		next = ref->next;
>   		if (!memcmp(ref->name, "refs/", 5)&&
> -		    check_refname_format(ref->name + 5, 0))
> +		    check_refname_format(ref->name, 0))

The patch looks fine to me.

This combination "!memcmp(ref->name, "refs/", 5) && 
check_refname_format(ref->name, 0)" is the reason that I suggested 
adding a REFNAME_FULL option [1], in which case it could be written 
"check_refname_format(ref->name, REFNAME_FULL)".  However, now I think 
that the options should be constructed a little differently:

flags==0: Require refname to start with "refs/"

flags==REFNAME_ALLOW_SPECIAL: Also accept single-level ALL_CAPS refnames.

flags==REFNAME_ALLOW_PARTIAL: Don't check the namespace or require '/'). 
  This could be used for checking partial names like "master" as 
shorthand for "refs/master".

Does this sound reasonable to you?

Michael

[1] http://article.gmane.org/gmane.comp.version-control.git/196632

>   			; /* trash */
>   		else if (args.fetch_all&&
>   			(!args.depth || prefixcmp(ref->name, "refs/tags/") )) {
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 7ec68a1..1935b80 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -401,7 +401,7 @@ static const char *update(struct command *cmd)
>   	struct ref_lock *lock;
>
>   	/* only refs/... are allowed */
> -	if (prefixcmp(name, "refs/") || check_refname_format(name + 5, 0)) {
> +	if (prefixcmp(name, "refs/") || check_refname_format(name, 0)) {
>   		rp_error("refusing to create funny ref '%s' remotely", name);
>   		return "funny refname";
>   	}
> diff --git a/remote.c b/remote.c
> index e2ef991..eacd8ad 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1595,7 +1595,7 @@ static int one_local_ref(const char *refname, const unsigned char *sha1, int fla
>   	int len;
>
>   	/* we already know it starts with refs/ to get here */
> -	if (check_refname_format(refname + 5, 0))
> +	if (check_refname_format(refname, 0))
>   		return 0;
>
>   	len = strlen(refname) + 1;
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index b69cf57..1a45b19 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -929,6 +929,36 @@ test_expect_success 'push into aliased refs (inconsistent)' '
>   	)
>   '
>
> +test_expect_success 'push all hierarchies with stash' '
> +	mk_empty&&
> +	git stash clear&&
> +	git reset --hard&&
> +	echo>>path1&&
> +	git stash save "Tweak path1"&&
> +	git push testrepo "refs/*:refs/*"&&
> +	git ls-remote .>expect&&
> +	git ls-remote testrepo>actual&&
> +	test_cmp actual expect
> +'
> +
> +test_expect_success 'fetch all hierarchies with stash' '
> +	mk_empty&&
> +	git stash clear&&
> +	git reset --hard&&
> +	echo>>path1&&
> +	git stash save "Tweak path1"&&
> +	(
> +		cd testrepo&&
> +		git commit --allow-empty -m initial&&
> +		git checkout HEAD^0&&
> +		git fetch .. "+refs/*:refs/*"&&
> +		git checkout master
> +	)&&
> +	git ls-remote .>expect&&
> +	git ls-remote testrepo>actual&&
> +	test_cmp actual expect
> +'
> +
>   test_expect_success 'push --porcelain' '
>   	mk_empty&&
>   	echo>.git/foo  "To testrepo"&&


-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
