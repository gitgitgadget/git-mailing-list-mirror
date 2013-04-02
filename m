From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] count-objects: output "KiB" instead of "kilobytes"
Date: Tue, 02 Apr 2013 15:01:42 -0700
Message-ID: <7vip44a8xl.fsf@alter.siamese.dyndns.org>
References: <1364903010-644-1-git-send-email-mihai@mihaic.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Mihai =?utf-8?Q?Capot=C4=83?= <mihai@mihaic.ro>
X-From: git-owner@vger.kernel.org Wed Apr 03 00:02:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UN9HS-00051I-CD
	for gcvg-git-2@plane.gmane.org; Wed, 03 Apr 2013 00:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759752Ab3DBWBp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Apr 2013 18:01:45 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52198 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757058Ab3DBWBo convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Apr 2013 18:01:44 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 399B212891;
	Tue,  2 Apr 2013 22:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qDZzx12JXAiH
	zKNwR/cTUtQiidg=; b=RAo8RwwSDpEqQZY6tPMy/9xzoKZaZlxe8axw+ie0O4L8
	EBk5qXD/U2TlrLOBiKnLkRYBpTPK/9XB6XLUI+zFffrLNbibs2ADZMy59r38ddS+
	7B8GM8G1x9NqjQItr+gijzbXbDnBmR64D/Kd3dmNkwvtCD0yfWb3loRrZeY5Obw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=tZMfC9
	jcuwjGpJFPniIhP8t4X+4elvWyPWM349sMMoLr83eV4RoH45/O3vzIUF49pkLaOR
	uWes+JV4GApxp5uKgPyGUL9Jei6XDFrJLuHqUELighoUNaCvOhstwh+oRQAsYtVn
	56HGjr7cnkGCzQ0CV8JXVBFzkyOboj3sAYVYs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2E5EE12890;
	Tue,  2 Apr 2013 22:01:44 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 864B31288E; Tue,  2 Apr
 2013 22:01:43 +0000 (UTC)
In-Reply-To: <1364903010-644-1-git-send-email-mihai@mihaic.ro> ("Mihai
 =?utf-8?Q?Capot=C4=83=22's?= message of "Tue, 2 Apr 2013 13:43:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E7A0F12A-9BE0-11E2-ABAD-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219892>

Mihai Capot=C4=83 <mihai@mihaic.ro> writes:

> The code uses division by 1024. Also, the manual uses "KiB".
>
> Signed-off-by: Mihai Capot=C4=83 <mihai@mihaic.ro>
> ---
>  builtin/count-objects.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/count-objects.c b/builtin/count-objects.c
> index 9afaa88..ecc13b0 100644
> --- a/builtin/count-objects.c
> +++ b/builtin/count-objects.c
> @@ -124,7 +124,7 @@ int cmd_count_objects(int argc, const char **argv=
, const char *prefix)
>  		printf("garbage: %lu\n", garbage);
>  	}
>  	else
> -		printf("%lu objects, %lu kilobytes\n",
> +		printf("%lu objects, %lu KiB\n",
>  		       loose, (unsigned long) (loose_size / 1024));
>  	return 0;
>  }

This breaks existing tests (5301, 7408 and 5700); I noticed it too
late and wasted 20 minutes, having to re-run today's integration
cycle.

Next time, please run the testsuite before sending a patch.
