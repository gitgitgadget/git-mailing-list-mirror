From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/6] test: add test_write_lines helper
Date: Wed, 23 Apr 2014 10:34:30 -0700
Message-ID: <xmqqd2g80x21.fsf@gitster.dls.corp.google.com>
References: <1398255277-26303-1-git-send-email-mst@redhat.com>
	<1398255277-26303-2-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 19:34:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wd14C-00022y-8u
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 19:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754537AbaDWReg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 13:34:36 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33417 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752302AbaDWRee (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 13:34:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AA047ECD0;
	Wed, 23 Apr 2014 13:34:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8PIqdrExIja/Bwef/RDBIYIoDqA=; b=nmTWsS
	K0iHjXhVwL3vHSoNHTHNaaEsQ7U1bHaZrBxAf/eX14uWsiZfX0/NIRG+E+aKmmTT
	kCxh6Q76Gs6/hI/4fB3afe3yQdKPbRodju7UeiBouCc0Xu79TNhm4wPq0Pp8H6Ev
	xBHHb8PBjYEfIC3rKbdgpJzF/WnjfyYwwaI34=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fKNJ/2Q00GlbC40ZWaINnACzjtPACUsr
	SoT/g8WkS+aSJJPxy4wQO5k1LG7L5wCkzCfOfto6lhg9xtXxkJihjXksjXMyyy8C
	WW7JStL2X7dVHHIcnePn6rCoLeWzGah1EFCx3KdVKxhvBbuSBilrjwOOffnvTHXp
	2aHqh+opHuU=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3464D7ECCE;
	Wed, 23 Apr 2014 13:34:34 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 5CEC97ECC2;
	Wed, 23 Apr 2014 13:34:32 -0400 (EDT)
In-Reply-To: <1398255277-26303-2-git-send-email-mst@redhat.com> (Michael
	S. Tsirkin's message of "Wed, 23 Apr 2014 15:14:55 +0300")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 87C32838-CB0D-11E3-BB58-0731802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246854>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> As suggested by Junio.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---

Ehh, I would probably not suggest such an implementation though.

	test_write_lines () {
		printf "%s\n" "$@"
	}

might be, but not with "echo" and semicolon on the same line as
"for" ;-).

>  t/test-lib-functions.sh | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
> index aeae3ca..2fa6453 100644
> --- a/t/test-lib-functions.sh
> +++ b/t/test-lib-functions.sh
> @@ -712,6 +712,13 @@ test_ln_s_add () {
>  	fi
>  }
>  
> +# This function writes out its parameters, one per line
> +test_write_lines () {
> +	for line in "$@"; do
> +		echo "$line"
> +	done
> +}
> +
>  perl () {
>  	command "$PERL_PATH" "$@"
>  }
