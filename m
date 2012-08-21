From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/2] fetch/push: allow refs/*:refs/*
Date: Tue, 21 Aug 2012 08:43:57 +0200
Message-ID: <50332E2D.2070602@alum.mit.edu>
References: <1345484397-10958-1-git-send-email-gitster@pobox.com> <1345484397-10958-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 21 08:51:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T3iIz-0000r2-Db
	for gcvg-git-2@plane.gmane.org; Tue, 21 Aug 2012 08:51:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178Ab2HUGvF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Aug 2012 02:51:05 -0400
Received: from ALUM-MAILSEC-SCANNER-7.MIT.EDU ([18.7.68.19]:60345 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751582Ab2HUGvE (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Aug 2012 02:51:04 -0400
X-Greylist: delayed 423 seconds by postgrey-1.27 at vger.kernel.org; Tue, 21 Aug 2012 02:51:03 EDT
X-AuditID: 12074413-b7f786d0000008bb-7b-50332e302a85
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 8D.15.02235.03E23305; Tue, 21 Aug 2012 02:44:00 -0400 (EDT)
Received: from [192.168.69.140] (p57A25F8F.dip.t-dialin.net [87.162.95.143])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q7L6hviv008249
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 21 Aug 2012 02:43:59 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:14.0) Gecko/20120714 Thunderbird/14.0
In-Reply-To: <1345484397-10958-2-git-send-email-gitster@pobox.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprDKsWRmVeSWpSXmKPExsUixO6iqGugZxxgcOyZhEXXlW4mi4beK8wW
	/cu72ByYPT58jPO4eEnZ4/MmuQDmKG6bpMSSsuDM9Dx9uwTujKf3FrAW/NGpmLb/IVsD40+l
	LkZODgkBE4mz62ezQ9hiEhfurWfrYuTiEBK4zCjx7PoaJgjnDJPEv/W3mECqeAW0JTqezgCz
	WQRUJV5f2cQGYrMJ6Eos6mkGi4sKhEis+TaFEaJeUOLkzCcsILaIgJrExLZDYDazgKfEiYW3
	wXqFBSwk1v/9wwpiCwmUS9yf8wKshlPASeLI2i2MEPU6Eu/6HjBD2PIS29/OYZ7AKDALyYpZ
	SMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXXC83s0QvNaV0EyMkdIV3MO46KXeI
	UYCDUYmH98UUowAh1sSy4srcQ4ySHExKorwrdI0DhPiS8lMqMxKLM+KLSnNSiw8xSnAwK4nw
	NjIA5XhTEiurUovyYVLSHCxK4rxqS9T9hATSE0tSs1NTC1KLYLIyHBxKEryrQYYKFqWmp1ak
	ZeaUIKSZODhBhnNJiRSn5qWkFiWWlmTEg2I1vhgYrSApHqC9PiDtvMUFiblAUYjWU4y6HJ+f
	nrzLKMSSl5+XKiXOGwhSJABSlFGaB7cClqheMYoDfSzMWw5SxQNMcnCTXgEtYQJa8miuAciS
	kkSElFQDo9fnCWzLXX7mdJy47SHotTWW/ULc8vIbTIuPqDnFy03wmL7Q+0yiyKb4bZWxJ59N
	D8g4fNlAtYVZNM39WH/KWx2OTTGh0aYlP6eu/6GuZdEzN0Vrp9DT5t7bN5mu3Wt5 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203944>

On 08/20/2012 07:39 PM, Junio C Hamano wrote:
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
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  builtin/fetch-pack.c   |  2 +-
>  builtin/receive-pack.c |  2 +-
>  connect.c              |  8 ++------
>  remote.c               |  2 +-
>  t/t5516-fetch-push.sh  | 33 +++++++++++++++++++++++++++++++++
>  5 files changed, 38 insertions(+), 9 deletions(-)
> 
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index 6207ecd..a3e3fa3 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -546,7 +546,7 @@ static void filter_refs(struct ref **refs, int nr_match, char **match)
>  	for (ref = *refs; ref; ref = next) {
>  		next = ref->next;
>  		if (!memcmp(ref->name, "refs/", 5) &&
> -		    check_refname_format(ref->name + 5, 0))
> +		    check_refname_format(ref->name, 0))
>  			; /* trash */
>  		else if (args.fetch_all &&
>  			 (!args.depth || prefixcmp(ref->name, "refs/tags/") )) {

I understand that you didn't introduce this code, but it seems like a
suspicious combination of conditions:

    if ((ref->name starts with "refs/")
        and (ref->name has invalid format))

It would seem more plausible to want

    if ((ref->name starts with "refs/")
        and (ref->name has *valid* format))

or its logical inverse

    if ((ref->name does not start with "refs/")
        or (ref->name has invalid format))

If you know the purpose of the code here, maybe you could give it a
quick sanity check.  (I believe the test was originally introduced by
Dscho in 1baaae5e1f9ac09aafe11b5aa4daa69bae68173b.)

> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 7ec68a1..1935b80 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -401,7 +401,7 @@ static const char *update(struct command *cmd)
>  	struct ref_lock *lock;
>  
>  	/* only refs/... are allowed */
> -	if (prefixcmp(name, "refs/") || check_refname_format(name + 5, 0)) {
> +	if (prefixcmp(name, "refs/") || check_refname_format(name, 0)) {
>  		rp_error("refusing to create funny ref '%s' remotely", name);
>  		return "funny refname";
>  	}
> diff --git a/connect.c b/connect.c
> index c8d0ea5..b30639c 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -17,20 +17,16 @@ static int check_ref(const char *name, int len, unsigned int flags)
>  	if (len < 5 || memcmp(name, "refs/", 5))
>  		return 0;
>  
> -	/* Skip the "refs/" part */
> -	name += 5;
> -	len -= 5;
> -
>  	/* REF_NORMAL means that we don't want the magic fake tag refs */
>  	if ((flags & REF_NORMAL) && check_refname_format(name, 0))
>  		return 0;
>  
>  	/* REF_HEADS means that we want regular branch heads */
> -	if ((flags & REF_HEADS) && !memcmp(name, "heads/", 6))
> +	if ((flags & REF_HEADS) && !memcmp(name, "refs/heads/", 11))
>  		return 1;
>  
>  	/* REF_TAGS means that we want tags */
> -	if ((flags & REF_TAGS) && !memcmp(name, "tags/", 5))
> +	if ((flags & REF_TAGS) && !memcmp(name, "refs/tags/", 10))
>  		return 1;
>  
>  	/* All type bits clear means that we are ok with anything */
> diff --git a/remote.c b/remote.c
> index e2ef991..eacd8ad 100644
> --- a/remote.c
> +++ b/remote.c
> @@ -1595,7 +1595,7 @@ static int one_local_ref(const char *refname, const unsigned char *sha1, int fla
>  	int len;
>  
>  	/* we already know it starts with refs/ to get here */
> -	if (check_refname_format(refname + 5, 0))
> +	if (check_refname_format(refname, 0))
>  		return 0;
>  
>  	len = strlen(refname) + 1;
> diff --git a/t/t5516-fetch-push.sh b/t/t5516-fetch-push.sh
> index b69cf57..3fdfaea 100755
> --- a/t/t5516-fetch-push.sh
> +++ b/t/t5516-fetch-push.sh
> @@ -929,6 +929,39 @@ test_expect_success 'push into aliased refs (inconsistent)' '
>  	)
>  '
>  
> +test_expect_success 'push all hierarchies with stash' '
> +	mk_empty &&
> +	git stash clear &&
> +	git reset --hard &&
> +	echo >>path1 &&
> +	git stash save "Tweak path1" &&
> +	git push testrepo "refs/*:refs/*" &&
> +	# without fix to connect.c::check_ref(), the second push
> +	# would fail.
> +	git push testrepo refs/stash &&
> +	git ls-remote . >expect &&
> +	git ls-remote testrepo >actual &&
> +	test_cmp actual expect
> +'
> +
> +test_expect_success 'fetch all hierarchies with stash' '
> +	mk_empty &&
> +	git stash clear &&
> +	git reset --hard &&
> +	echo >>path1 &&
> +	git stash save "Tweak path1" &&
> +	(
> +		cd testrepo &&
> +		git commit --allow-empty -m initial &&
> +		git checkout HEAD^0 &&
> +		git fetch .. "+refs/*:refs/*" &&
> +		git checkout master
> +	) &&
> +	git ls-remote . >expect &&
> +	git ls-remote testrepo >actual &&
> +	test_cmp actual expect
> +'
> +
>  test_expect_success 'push --porcelain' '
>  	mk_empty &&
>  	echo >.git/foo  "To testrepo" &&
> 

Otherwise I see nothing wrong with your changes.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
