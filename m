From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] pack-objects: Fix compilation with NO_PTHREDS
Date: Sat, 25 Feb 2012 01:02:42 -0800
Message-ID: <7vty2fffpp.fsf@alter.siamese.dyndns.org>
References: <1330157769-7884-1-git-send-email-michal.kiedrowicz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 25 10:02:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S1DWn-00049F-Lk
	for gcvg-git-2@plane.gmane.org; Sat, 25 Feb 2012 10:02:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755156Ab2BYJCr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 25 Feb 2012 04:02:47 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47987 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752588Ab2BYJCp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 25 Feb 2012 04:02:45 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 060155660;
	Sat, 25 Feb 2012 04:02:45 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=tb7/ot9eYVzb
	x0vmLmBtkbTzwCc=; b=LXd+7lOlr493dQlr5iLgl8hGBzfa6XhA1CzjMeLa1mLa
	434jWyDDnEqCYPBWenCiBcQwO1goPYEhLBv/HiyMAxqlSsrrznCGp0KuZmEi8m8/
	TC8PW1vsfgJVhJYU007m0ir7YqFkfioraGAh7GMjsVxVs8dDgXJisyg0hkTyvjg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=L9AQSQ
	s3ey92pKwWVlp7xfkaUzqKiEZNnu1+gyM/+A9U+LNqYxu1ojpSbZapVbhAq0U2Z0
	Q892Mlnbfl2dRA0+vNs0Zg1vwa13jtLsFWvpIVVH+a/2ebwMYHVku0LAf69CWZFb
	m7qeSh6ZqyQBJpEtnZ8Bl2T3d1WscJuhQnlOk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F1D84565F;
	Sat, 25 Feb 2012 04:02:44 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 85E16565E; Sat, 25 Feb 2012
 04:02:44 -0500 (EST)
In-Reply-To: <1330157769-7884-1-git-send-email-michal.kiedrowicz@gmail.com>
 (=?utf-8?Q?=22Micha=C5=82?= Kiedrowicz"'s message of "Sat, 25 Feb 2012
 09:16:09 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7AF3E2D2-5F8F-11E1-B421-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191510>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> It looks like commit 99fb6e04 (pack-objects: convert to use
> parse_options(), 2012-02-01) moved the #ifdef NO_PTHREDS around but
> hasn't noticed that the 'arg' variable no longer is available.
>
> Signed-off-by: Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com>

Thanks.  Nguy=E1=BB=85n, a quick double-check and an Ack?

> ---
>  builtin/pack-objects.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index db09cf7..71af246 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -2449,7 +2449,7 @@ int cmd_pack_objects(int argc, const char **arg=
v, const char *prefix)
>  		die("bad pack compression level %d", pack_compression_level);
>  #ifdef NO_PTHREADS
>  	if (delta_search_threads !=3D 1)
> -		warning("no threads support, ignoring %s", arg);
> +		warning("no threads support, ignoring --threads");
>  #endif
>  	if (!pack_to_stdout && !pack_size_limit)
>  		pack_size_limit =3D pack_size_limit_cfg;
