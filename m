From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6 05/10] git fetch-pack: Add --diag-url
Date: Thu, 21 Nov 2013 14:46:37 -0800
Message-ID: <xmqqob5d2x0y.fsf@gitster.dls.corp.google.com>
References: <201311212140.49698.tboegi@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Thu Nov 21 23:46:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vjd1J-0003PA-LP
	for gcvg-git-2@plane.gmane.org; Thu, 21 Nov 2013 23:46:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755258Ab3KUWql convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Nov 2013 17:46:41 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44882 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754481Ab3KUWqk convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Nov 2013 17:46:40 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0A05D527B0;
	Thu, 21 Nov 2013 17:46:40 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=seIOnA7K9BHX
	/qZiafd+8+bjkU8=; b=AlvpD7WCmxcMIuKCOiISYBgdzRd/xNFfJ+5rO2eprE7E
	13o4Iw1nE70OKJmdLjAAtxAn7yYUehq/nA244eF4JPcr2Gj+eJEpoCFtO3qwF5zK
	NlbsGRzgCAio5ZuZOAaSpz9P7mGu9QEx6YPkVGtWzuwpA/4OHF+SCf4twxiRgIg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mKNyuE
	/JwL3CS3FG4dKp6wbqwjaOGi2HfC5DSrJEyJMxQAEtwqmSCVPZmMSNo90p1opddj
	ChZ0/RCxhnRc5dKtR7vPrUrGvUMr09R7b+fmX55G5/Y1Om9OazR27MPQZSr14Eao
	ZdtlBdAZvxG1Sk7E+N9lXoNA1p0TtE/mpgTt0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F07E1527AC;
	Thu, 21 Nov 2013 17:46:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3DD18527AB;
	Thu, 21 Nov 2013 17:46:39 -0500 (EST)
In-Reply-To: <201311212140.49698.tboegi@web.de> ("Torsten =?utf-8?Q?B?=
 =?utf-8?Q?=C3=B6gershausen=22's?=
	message of "Thu, 21 Nov 2013 21:40:48 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C8A42B90-52FE-11E3-A392-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238161>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> Subject: Re: [PATCH v6 05/10] git fetch-pack: Add --diag-url

s/Add/add/ please.

> The main purpose is to trace the URL parser called by git_connect() i=
n
> connect.c
>
> The main features of the parser can be listed as this:
> - parse out host and path for URLs with a scheme (git:// file:// ssh:=
//)
> - parse host names embedded by [] correctly
> - extract the port number, if present
> - seperate URLs like "file" (which are local)
>   from URLs like "host:repo" which should use ssh
>
> Add the new parameter "--diag-url" to "git fetch-pack",
> which prints the value for protocol, host and path to stderr and exit=
s.
> ---

Sign-off?

>  builtin/fetch-pack.c  | 14 ++++++++++---
>  connect.c             | 27 ++++++++++++++++++++++++
>  connect.h             |  1 +
>  fetch-pack.h          |  1 +
>  t/t5500-fetch-pack.sh | 57 +++++++++++++++++++++++++++++++++++++++++=
++++++++++
>  5 files changed, 97 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
> index c8e8582..758b5ac 100644
> --- a/builtin/fetch-pack.c
> +++ b/builtin/fetch-pack.c
> @@ -7,7 +7,7 @@
>  static const char fetch_pack_usage[] =3D
>  "git fetch-pack [--all] [--stdin] [--quiet|-q] [--keep|-k] [--thin] =
"
>  "[--include-tag] [--upload-pack=3D<git-upload-pack>] [--depth=3D<n>]=
 "
> -"[--no-progress] [-v] [<host>:]<directory> [<refs>...]";
> +"[--no-progress] [--diag-url] [-v] [<host>:]<directory> [<refs>...]"=
;
> =20
>  static void add_sought_entry_mem(struct ref ***sought, int *nr, int =
*alloc,
>  				 const char *name, int namelen)
> @@ -81,6 +81,10 @@ int cmd_fetch_pack(int argc, const char **argv, co=
nst char *prefix)
>  			args.stdin_refs =3D 1;
>  			continue;
>  		}
> +		if (!strcmp("--diag-url", arg)) {
> +			args.diag_url =3D 1;
> +			continue;
> +		}
>  		if (!strcmp("-v", arg)) {
>  			args.verbose =3D 1;
>  			continue;
> @@ -146,10 +150,14 @@ int cmd_fetch_pack(int argc, const char **argv,=
 const char *prefix)
>  		fd[0] =3D 0;
>  		fd[1] =3D 1;
>  	} else {
> +		int flags =3D args.verbose ? CONNECT_VERBOSE : 0;
> +		if (args.diag_url)
> +			flags |=3D CONNECT_DIAG_URL;
>  		conn =3D git_connect(fd, dest, args.uploadpack,
> -				   args.verbose ? CONNECT_VERBOSE : 0);
> +				   flags);
> +		if (!conn)
> +			return args.diag_url ? 0 : 1;
>  	}
> -
>  	get_remote_heads(fd[0], NULL, 0, &ref, 0, NULL);
> =20
>  	ref =3D fetch_pack(&args, fd, conn, ref, dest,
> diff --git a/connect.c b/connect.c
> index a6cf345..1b93b4d 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -236,6 +236,19 @@ enum protocol {
>  	PROTO_GIT
>  };
> =20
> +static const char *prot_name(enum protocol protocol) {

Style: please move that "{" to the beginning of the next line (see the
beginning of existing functions e.g. get_protocol()).

> diff --git a/t/t5500-fetch-pack.sh b/t/t5500-fetch-pack.sh
> index d87ddf7..9136f2a 100755
> --- a/t/t5500-fetch-pack.sh
> +++ b/t/t5500-fetch-pack.sh
> @@ -531,5 +531,62 @@ test_expect_success 'shallow fetch with tags doe=
s not break the repository' '
>  		git fsck
>  	)
>  '
> +check_prot_path() {
> +	> actual &&

Style: no SP between the redirection operator and its target, i.e.

	>actual &&

> +	(git fetch-pack --diag-url "$1" 2>&1 1>stdout) | grep -v host=3D >a=
ctual &&

Do we use "stdout" in this test?  Otherwise "1>/dev/null" would make
it clearer what is going on.

> +	echo "Diag: url=3D$1" >expected &&
> +	echo "Diag: protocol=3D$2" >>expected &&
> +	echo "Diag: path=3D$3" >>expected &&

Perhaps this is a good place to use here-doc, i.e.

	cat >expected <<-EOF &&
	Diag: ...
        ...
        EOF

> +	test_cmp expected actual
> +}
> +
> +check_prot_host_path() {
> +	> actual &&
> +	git fetch-pack --diag-url "$1" 2>actual &&
> +	echo "Diag: url=3D$1" >expected &&
> +	echo "Diag: protocol=3D$2" >>expected &&
> +	echo "Diag: host=3D$3" >>expected &&
> +	echo "Diag: path=3D$4" >>expected &&
> +	test_cmp expected actual
> +}
> +
> +for r in repo re:po re/po
> +do
> +	# git or ssh with scheme
> +	for p in "ssh+git" "git+ssh" git ssh
> +	do
> +		for h in host host:12 [::1] [::1]:23
> +		do
> +			if $(echo $p | grep ssh >/dev/null 2>/dev/null); then

Style: "; then" should be spelled as "LF" followed by "then" on the
next line by itself.

But more ipmportantly, the above tries to do

	if "some computed string"; then

which is very iffy.  I think you meant:

	case "$p" in
        *ssh*)
        	do ssh thing
                ;;
	*)
        	do other thing
	esac
