From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 11/25] git-sh-setup.sh: use rev-parse --git-path to get $GIT_DIR/objects
Date: Wed, 26 Feb 2014 16:00:06 -0800
Message-ID: <xmqqvbw11l2x.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-12-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 27 01:00:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WIoOf-0007ye-Vm
	for gcvg-git-2@plane.gmane.org; Thu, 27 Feb 2014 01:00:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752826AbaB0AAM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Feb 2014 19:00:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54343 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751989AbaB0AAK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Feb 2014 19:00:10 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 55C0470C6F;
	Wed, 26 Feb 2014 19:00:10 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=1eL6GNT4126T
	TGVkrXgWjwy+HAM=; b=ln2ONxFbaeEzfka8NkldTb3Dbmw88vt3dat1fS23aTft
	Uu+jy5riDvU1HUgXwbqTDwiAzb9McfPhlV+4Au3i8fqad4ZK6NTqFChxAp+sWmto
	vgZuYaQHh+0AIwdLpy6PDsoeXpmllvoFcd4eXNTb4CLP6+SotEGzLkGt47WoPyE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Bq9vRx
	GJbmY/IqtBubkrABX9OnFXRyOHGzMRwgWGwKODTDYbLiKLUVT5JOgJ3SoV55MFNy
	lZtXzWgKrdpg+sqkcTuAHJH1FsmoFppGIfUFXTV6OqPBFKEKiwmSeSak+jZj9hJX
	G+cgqIifvWgyO6tAPWkPz4J6peSJaL2TLl9dg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4457A70C6D;
	Wed, 26 Feb 2014 19:00:10 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 65F0470C6A;
	Wed, 26 Feb 2014 19:00:09 -0500 (EST)
In-Reply-To: <1392730814-19656-12-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Tue, 18
 Feb 2014 20:40:00 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 1F5FA9D4-9F42-11E3-9229-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242775>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> If $GIT_COMMON_DIR is set, $GIT_OBJECT_DIRECTORY should be
> $GIT_COMMON_DIR/objects, not $GIT_DIR/objects. Just let rev-parse
> --git-path handle it.
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  git-sh-setup.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/git-sh-setup.sh b/git-sh-setup.sh
> index fffa3c7..fec9430 100644
> --- a/git-sh-setup.sh
> +++ b/git-sh-setup.sh
> @@ -343,7 +343,7 @@ then
>  		echo >&2 "Unable to determine absolute path of git directory"
>  		exit 1
>  	}
> -	: ${GIT_OBJECT_DIRECTORY=3D"$GIT_DIR/objects"}
> +	: ${GIT_OBJECT_DIRECTORY=3D"`git rev-parse --git-path objects`"}

$(...) is the preferred way over `...` in this codebase.

>  fi
> =20
>  peel_committish () {
