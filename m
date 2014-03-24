From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/10] t4209: factor out helper function test_log_icase()
Date: Mon, 24 Mar 2014 11:22:30 -0700
Message-ID: <xmqqa9cfqwwp.fsf@gitster.dls.corp.google.com>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
	<1395508560-19893-4-git-send-email-l.s.r@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 19:23:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS9Wz-0006T7-LJ
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 19:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbaCXSWh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2014 14:22:37 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49275 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753716AbaCXSWe convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 14:22:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 034D9745EE;
	Mon, 24 Mar 2014 14:22:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=CVcLKKRUb6UGkn4TfnP/IF5Sl
	w8=; b=HM9RhgsEXSooiYc7XXClcI+Uc4IMpCDXpJW3GHBjwa2Mzkvw5cRi/KP7x
	1jiOqTlMzBtT00FJ8knQm79pNltOoRFHr1i0q8Jpuj26zRc09GCYHCc/V3vjGUlu
	sCvNxJsbSs4/HOYFMI3dkOgU1chkKmgmdaxlt/QMA+H+SCjnP0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=PAN6lIAQ1oCdYizUV3d
	d+6gJHLAPhRit/ft0VTm5cB1WB+n0MB62IgzbKJIFDuzlBPMmiugWBj8cYPMagc8
	KzB8Kgl2f98B6Ow33QfjbzFlFxSWN2q/q01jcK7f7YAUaNXUzcgeh3zsoy80CFZ4
	iXe+clXqYFpUyEJbMXERvLjo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E5BDD745ED;
	Mon, 24 Mar 2014 14:22:33 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 47759745EB;
	Mon, 24 Mar 2014 14:22:33 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 4485AA94-B381-11E3-8F8E-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244859>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> Reduce code duplication by introducing test_log_icase() that runs the
> same test with both --regexp-ignore-case and -i.  The specification o=
f
> the four basic test scenarios (matching/nomatching combined with case
> sensitive/insensitive) becomes easier to read and write.
>
> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
>  t/t4209-log-pickaxe.sh | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/t/t4209-log-pickaxe.sh b/t/t4209-log-pickaxe.sh
> index 9f3bb40..dd911c2 100755
> --- a/t/t4209-log-pickaxe.sh
> +++ b/t/t4209-log-pickaxe.sh
> @@ -25,6 +25,11 @@ test_log() {
>  	"
>  }
> =20
> +test_log_icase() {
> +	test_log $@ --regexp-ignore-case
> +	test_log $@ -i

&&-cascade broken?  Will squash in an obvious fix.

> +}
