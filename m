From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH/PATCH] graph: give an extra gap after showing root commit
Date: Fri, 20 Dec 2013 14:03:17 -0800
Message-ID: <xmqqy53fch96.fsf@gitster.dls.corp.google.com>
References: <1382717268-21884-1-git-send-email-milton.soares.filho@gmail.com>
	<xmqqeh79jmtr.fsf@gitster.dls.corp.google.com>
	<CAPNngRMP29s9gZg9R987yRd2qJ=UuaMWnFphtQdGDRgG_SCxsQ@mail.gmail.com>
	<87mwlwn4e0.fsf@gmail.com>
	<xmqqeh75h087.fsf@gitster.dls.corp.google.com>
	<CAPNngRMprE3QwDn3y74QqitAs+-DCBm1oO33uKRHsn9jLrNSnA@mail.gmail.com>
	<xmqqsivlfg6z.fsf@gitster.dls.corp.google.com>
	<xmqqbo0be0hc.fsf_-_@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Keshav Kini <keshav.kini@gmail.com>,
	Milton Soares Filho <milton.soares.filho@gmail.com>,
	Adam Simpkins <simpkins@facebook.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 20 23:04:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vu8AS-0001Ao-Dj
	for gcvg-git-2@plane.gmane.org; Fri, 20 Dec 2013 23:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752317Ab3LTWDW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Dec 2013 17:03:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:55623 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751035Ab3LTWDV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Dec 2013 17:03:21 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 844705B982;
	Fri, 20 Dec 2013 17:03:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=9jPNxSJ+LXqTvv9KYqCmYqobURo=; b=hRwBTV
	FqAm+5KVVCjtRr0pBWjlHGzCTzAm8tiCIr1faZlUR5hLocHd7+6YYBRJvSBpZQvA
	Ij8ePwUnFFaF4mpu1SHeoPJuYXqRV8jKNnoCfXNNnW5YOUWyP+7Ei5yZIkW10LYy
	2e5nzKlns7N0V3Hscdq7kJeG7FpHqUNUSyUPA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nzZCm4qRooF68anfBbyoQSdivnYVW7vP
	asdhQ+rDEkpkQCw3eXjE5fG9ABHfmWLVhN3eSz5dzZ5sWTAqK/hn7sHPCd9NAaLo
	YjlxPKEGfX3d17MUERfxP6LyGxBYWM3lDzW45KDablEowOhdo9jMNrrI5zGhqdrR
	KKzAKiqLomI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69B415B981;
	Fri, 20 Dec 2013 17:03:20 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id ACC915B97F;
	Fri, 20 Dec 2013 17:03:19 -0500 (EST)
In-Reply-To: <xmqqbo0be0hc.fsf_-_@gitster.dls.corp.google.com> (Junio
	C. Hamano's message of "Fri, 20 Dec 2013 12:22:39 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 892BD848-69C2-11E3-9A60-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239583>

Junio C Hamano <gitster@pobox.com> writes:

>  Note that this still does not work very well for --boundary case
>  (see the last test added to t6016).
> ...
> +test_expect_failure 'multi-root does not emit unnecessary post-root gap' '
> +	git log --oneline --graph merge210~1...merge210~1^2~2 >actual &&
> +	! grep "^$" actual
> +'

Obviously, this needs to be

    git log --oneline --graph --boundary merge210~1...merge210~1^2~2 >actual &&

for it to fail.
