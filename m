From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/2] Document limited recursion pathspec matching with
 wildcards
Date: Sat, 14 Jan 2012 18:38:30 -0800
Message-ID: <7vfwfhwuzd.fsf@alter.siamese.dyndns.org>
References: <1326341371-16628-1-git-send-email-pclouds@gmail.com>
 <1326533003-19686-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 15 03:38:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RmFzT-0001Ju-9l
	for gcvg-git-2@lo.gmane.org; Sun, 15 Jan 2012 03:38:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753407Ab2AOCie convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 14 Jan 2012 21:38:34 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56462 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753199Ab2AOCid convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jan 2012 21:38:33 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A797F75F9;
	Sat, 14 Jan 2012 21:38:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=nsy5VfUNy8oR
	EzwGKPzsH5SNUh0=; b=YEf/J82tpx2jENh15+6rEYTBXDjkkex7mD1UJ5TnbvhC
	Gu/0ST7W0+32FP+JH0b7DDkygE2pRBw5rKmsKJX7C7DU3LYz1Nr+ldqUZcHFuNQs
	+KZeIpbReUXbUgtv1LsVjZdzX57547REqiCzhDnX1DXEm5Mb9NaSKUsgF7ipd9Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=m72VGw
	h4x029d1sE+nNrB09VowEm2oGYEN2FwhjHR6t9vdINRziYt5uFaJeNumS2s7Lq7U
	DhJV8oJh8+3B0NnjPaV4pGMvufJAXQ3PSgQHFOKItuFq/Y1Y1xSX07pGzWLUKkqO
	S9DlgVBKObazAlhh2XFZzKz7wT+C6C4h35d1Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9E29C75F7;
	Sat, 14 Jan 2012 21:38:32 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 318BC75F4; Sat, 14 Jan 2012
 21:38:32 -0500 (EST)
In-Reply-To: <1326533003-19686-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 14 Jan
 2012 16:23:22 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 03BF5DB4-3F22-11E1-A481-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188588>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> It's actually unlimited recursion if wildcards are active regardless
> --max-depth
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  Regarding Junio's question earlier:
>
>  >  - Shouldn't "onelevel_only" be the same as limiting to a single d=
epth
>  >   with "max_depth"?
>
>  Doing that would change the behavior of "git grep --max-depth=3D0 --=
 'a*'"
>  from unlimited recursion currently to limited. We did not come to ag=
ree
>  how --max-depth should behave with wildcards last time it was discus=
sed,
>  so it's best separating two flags (in the next patch) for now.

Ok, I 100% agree with the "at least for now" reasoning. Thanks for digg=
ing
into the archive.

>  Documentation/git-grep.txt |    3 +++
>  tree-walk.c                |    3 +++
>  2 files changed, 6 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
> index 15d6711..6a8b1e3 100644
> --- a/Documentation/git-grep.txt
> +++ b/Documentation/git-grep.txt
> @@ -79,6 +79,9 @@ OPTIONS
>  --max-depth <depth>::
>  	For each <pathspec> given on command line, descend at most <depth>
>  	levels of directories. A negative value means no limit.
> +	This option is ignored if <pathspec> contains active wildcards.
> +	In other words if "a*" matches a directory named "a*",
> +	"*" is matched literally so --max-depth is still effective.

Do we have a definition of "active wildcard"?

> diff --git a/tree-walk.c b/tree-walk.c
> index f82dba6..492c7cd 100644
> --- a/tree-walk.c
> +++ b/tree-walk.c
> @@ -661,6 +661,9 @@ match_wildcards:
>  		/*
>  		 * Match all directories. We'll try to match files
>  		 * later on.
> +		 * max_depth is ignored but we may consider support it
> +		 * in future, see
> +		 * http://thread.gmane.org/gmane.comp.version-control.git/163757/f=
ocus=3D163840
>  		 */
>  		if (ps->recursive && S_ISDIR(entry->mode))
>  			return entry_interesting;
