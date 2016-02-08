From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/25] upload-pack: add deepen-since to cut shallow repos based on time
Date: Mon, 08 Feb 2016 13:14:29 -0800
Message-ID: <xmqqr3gm7vm2.fsf@gitster.mtv.corp.google.com>
References: <1454576641-29615-1-git-send-email-pclouds@gmail.com>
	<1454576641-29615-16-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 08 22:14:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSt8n-0001L9-MC
	for gcvg-git-2@plane.gmane.org; Mon, 08 Feb 2016 22:14:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044AbcBHVOe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 8 Feb 2016 16:14:34 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57225 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755114AbcBHVOc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Feb 2016 16:14:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2536742E4C;
	Mon,  8 Feb 2016 16:14:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oIngB85rYaJe
	wTXOOan7cWV3BHQ=; b=Q7GybNv95pZs7R9cRdcd71MLev9724PF54ozrSM5xayk
	DUMagz75oMxCCDhlhCYp+hBFSPYJ97ca+/JLW3lvRlkUmxarl6nhnf1Gnziyh4iL
	WckgGtmxpfBJbdrGWUqyIbBBccDzsliLzVpNnvPyPvMh3LxG5/XkwWiWfno7kr4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=EA5Jfj
	1HR6HQWlSp8KIfQD5pmvIfoeGwYZlae9Wh023aaYzXrNtiZQUEX4A68Gqf2IklER
	GbdDpiU4LwgvSRQwUMsotJvZ/tHr9k9i2viENfTFqPJMXQUFfiBxNXOLBsmBdF8/
	wau+oWuL+zb+UjldXjtuHvPCps7ZWtoKj+BLA=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D64B42E4B;
	Mon,  8 Feb 2016 16:14:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 618F942E4A;
	Mon,  8 Feb 2016 16:14:31 -0500 (EST)
In-Reply-To: <1454576641-29615-16-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 4 Feb
 2016 16:03:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F1F9BEBA-CEA8-11E5-A161-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285807>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> This should allow the user to say "create a shallow clone containing =
the
> work from last year" (once the client side is fixed up, of course).
>
> In theory deepen-since and deepen (aka --depth) can be used together =
to
> draw the shallow boundary (whether it's intersection or union is up t=
o
> discussion, but if rev-list is used, it's likely intersection). Howev=
er,
> because deepen goes with a custom commit walker, we can't mix the two
> yet.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

Looks quite straight-forward.

Thanks.

>  Documentation/technical/pack-protocol.txt         |  3 +-
>  Documentation/technical/protocol-capabilities.txt |  9 +++++
>  upload-pack.c                                     | 45 +++++++++++++=
+++++++++-
>  3 files changed, 54 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/technical/pack-protocol.txt b/Documentatio=
n/technical/pack-protocol.txt
> index c6977bb..9251df1 100644
> --- a/Documentation/technical/pack-protocol.txt
> +++ b/Documentation/technical/pack-protocol.txt
> @@ -219,7 +219,8 @@ out of what the server said it could do with the =
first 'want' line.
> =20
>    shallow-line      =3D  PKT-LINE("shallow" SP obj-id)
> =20
> -  depth-request     =3D  PKT-LINE("deepen" SP depth)
> +  depth-request     =3D  PKT-LINE("deepen" SP depth) /
> +		       PKT-LINE("deepen-since" SP timestamp)
> =20
>    first-want        =3D  PKT-LINE("want" SP obj-id SP capability-lis=
t)
>    additional-want   =3D  PKT-LINE("want" SP obj-id)
> diff --git a/Documentation/technical/protocol-capabilities.txt b/Docu=
mentation/technical/protocol-capabilities.txt
> index eaab6b4..f08cc4e 100644
> --- a/Documentation/technical/protocol-capabilities.txt
> +++ b/Documentation/technical/protocol-capabilities.txt
> @@ -179,6 +179,15 @@ This capability adds "deepen", "shallow" and "un=
shallow" commands to
>  the  fetch-pack/upload-pack protocol so clients can request shallow
>  clones.
> =20
> +deepen-since
> +------------
> +
> +This capability adds "deepen-since" command to fetch-pack/upload-pac=
k
> +protocol so the client can request shallow clones that are cut at a
> +specific time, instead of depth. Internally it's equivalent of doing
> +"rev-list --max-age=3D<timestamp>" on the server side. "deepen-since=
"
> +cannot be used with "deepen".
> +
>  no-progress
>  -----------
> =20
> diff --git a/upload-pack.c b/upload-pack.c
> index c8dafe8..794736c 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -14,6 +14,7 @@
>  #include "sigchain.h"
>  #include "version.h"
>  #include "string-list.h"
> +#include "argv-array.h"
> =20
>  static const char upload_pack_usage[] =3D "git upload-pack [--strict=
] [--timeout=3D<n>] <dir>";
> =20
> @@ -612,11 +613,25 @@ static void deepen(int depth, const struct obje=
ct_array *shallows)
>  	packet_flush(1);
>  }
> =20
> +static void deepen_by_rev_list(int ac, const char **av,
> +			       struct object_array *shallows)
> +{
> +	struct commit_list *result;
> +
> +	result =3D get_shallow_commits_by_rev_list(ac, av, SHALLOW, NOT_SHA=
LLOW);
> +	send_shallow(result);
> +	free_commit_list(result);
> +	send_unshallow(shallows);
> +	packet_flush(1);
> +}
> +
>  static void receive_needs(void)
>  {
>  	struct object_array shallows =3D OBJECT_ARRAY_INIT;
>  	int depth =3D 0;
>  	int has_non_tip =3D 0;
> +	unsigned long deepen_since =3D 0;
> +	int deepen_rev_list =3D 0;
> =20
>  	shallow_nr =3D 0;
>  	for (;;) {
> @@ -653,6 +668,16 @@ static void receive_needs(void)
>  				die("Invalid deepen: %s", line);
>  			continue;
>  		}
> +		if (skip_prefix(line, "deepen-since ", &arg)) {
> +			char *end =3D NULL;
> +			deepen_since =3D strtoul(arg, &end, 0);
> +			if (!end || *end || !deepen_since ||
> +			    /* revisions.c's max_age -1 is special */
> +			    deepen_since =3D=3D -1)
> +				die("Invalid deepen-since: %s", line);
> +			deepen_rev_list =3D 1;
> +			continue;
> +		}
>  		if (!skip_prefix(line, "want ", &arg) ||
>  		    get_sha1_hex(arg, sha1_buf))
>  			die("git upload-pack: protocol error, "
> @@ -704,10 +729,26 @@ static void receive_needs(void)
>  	if (!use_sideband && daemon_mode)
>  		no_progress =3D 1;
> =20
> -	if (depth =3D=3D 0 && shallows.nr =3D=3D 0)
> +	if (depth =3D=3D 0 && !deepen_rev_list && shallows.nr =3D=3D 0)
>  		return;
> +	if (depth > 0 && deepen_rev_list)
> +		die("--depth and --shallow-since cannot be used together");
>  	if (depth > 0)
>  		deepen(depth, &shallows);
> +	else if (deepen_rev_list) {
> +		struct argv_array av =3D ARGV_ARRAY_INIT;
> +		int i;
> +
> +		argv_array_push(&av, "rev-list");
> +		if (deepen_since)
> +			argv_array_pushf(&av, "--max-age=3D%lu", deepen_since);
> +		for (i =3D 0; i < want_obj.nr; i++) {
> +			struct object *o =3D want_obj.objects[i].item;
> +			argv_array_push(&av, oid_to_hex(&o->oid));
> +		}
> +		deepen_by_rev_list(av.argc, av.argv, &shallows);
> +		argv_array_clear(&av);
> +	}
>  	else
>  		if (shallows.nr > 0) {
>  			int i;
> @@ -756,7 +797,7 @@ static int send_ref(const char *refname, const st=
ruct object_id *oid,
>  		    int flag, void *cb_data)
>  {
>  	static const char *capabilities =3D "multi_ack thin-pack side-band"
> -		" side-band-64k ofs-delta shallow no-progress"
> +		" side-band-64k ofs-delta shallow deepen-since no-progress"
>  		" include-tag multi_ack_detailed";
>  	const char *refname_nons =3D strip_namespace(refname);
>  	struct object_id peeled;
