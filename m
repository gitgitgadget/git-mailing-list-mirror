From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 04/10] t4209: use helper functions to test --grep
Date: Mon, 24 Mar 2014 11:22:58 -0700
Message-ID: <xmqq38i7qwvx.fsf@gitster.dls.corp.google.com>
References: <1395508560-19893-1-git-send-email-l.s.r@web.de>
	<1395508560-19893-5-git-send-email-l.s.r@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Mon Mar 24 19:23:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS9X0-0006T7-9P
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 19:23:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753785AbaCXSXE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2014 14:23:04 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42249 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753610AbaCXSXC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 24 Mar 2014 14:23:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0E40474613;
	Mon, 24 Mar 2014 14:23:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=iyApkIlGIZJJKEKwb82BSQfPJ
	+s=; b=kYpXy/6NKiDjebnYR8ozZRaSlRmnroySGiw6sLwuKrj1ssiNDEyn2bUtN
	huhh0wK0ZDak8ceItN4O8xuo6NGMvnZumrDu4VNxkb3reNd4j2qX8kJc0qXTQdz9
	bBuoVcqdssr/GqhuroOzh1SSAtFL7bl0egFGu5l0t0U3y9mDg8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=KSgAqm4i6DDWjY4qEPl
	9jDLWIXH0eCHDl0BUV5nC0EtWND0meLa35T1TIxDvm7vlzarvXWFPh50qe7kV2hH
	0K4T8DVcAq/izrHofmna9GwvOZeDYhB2iwEkuyALJPSZw/mP9kebBEv6H6O0LyrQ
	5K6+zWV67JNkearY8ij+eJUI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E95B174612;
	Mon, 24 Mar 2014 14:23:01 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4A1DB74611;
	Mon, 24 Mar 2014 14:23:01 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5537B198-B381-11E3-B86D-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244860>

Ren=C3=A9 Scharfe <l.s.r@web.de> writes:

> -test_expect_success 'log --grep -i' '
> -	git log -i --grep=3DInItial --format=3D%H >actual &&
> -	test_cmp expect_initial actual
> -'
> +test_log	expect_initial	--grep initial
> +test_log	expect_nomatch	--grep InItial

This, and the next --author one, assumes that we will never break
"--grep=3Dfoo" without breaking "--grep foo".  That should be OK, but
we might want to add separate tests e.g.

	test_log expect_initial --grep=3Dinitial

perhaps?  I dunno.

Queued without any tweaks for now.  Thanks.
