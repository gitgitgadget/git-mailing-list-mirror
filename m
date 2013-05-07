From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] clone: allow cloning local paths with colons in them
Date: Tue, 07 May 2013 08:34:51 -0700
Message-ID: <7vehdils6c.fsf@alter.siamese.dyndns.org>
References: <1367033778-13923-1-git-send-email-pclouds@gmail.com>
	<1367633973-26214-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jonathan Niedier <jrnieder@gmail.com>,
	William Giokas <1007380@gmail.com>, fsckdaemon@gmail.com,
	Daniel Barkalow <barkalow@iabervon.org>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 07 17:35:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZjut-0004Wf-0G
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 17:34:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757111Ab3EGPey convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 May 2013 11:34:54 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58385 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752781Ab3EGPex convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 May 2013 11:34:53 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72B1A1A58D;
	Tue,  7 May 2013 15:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=VnxFsbZ86Ggq
	bplXBZcktrYFvTg=; b=smy/mw0K33+SGOJHpql2ojoTuvCsWFuDir572Sl1lvJB
	58ko21AVwevunhRNFJgoOmYzRJtinmQDefOR03gkMO9H3lKc42SF6tQHZYnAoHIk
	45Ghek666R15migY9J5d2h5LBuJT1jt9VA10oOF3dHFw+/U2xKcKrS3oA558Mqc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=YJ7y0J
	xXBEiZD436EnWfRNJPKbEXll9y6Q1NBfxcTjK3aJHSHf+zHcSN4N4uC21p3FCL//
	uSV8N+XNpg6NO+aqv/xBSF6o7dMGM+FfmQ8OW2/VzE6yAU4BFuHTKeKkdZUw0cDu
	iZ/8WaPGPBHQyzKz/ZHIdtdJHRQQX8/GSKCqI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65EFA1A58C;
	Tue,  7 May 2013 15:34:53 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D2FED1A58B;
	Tue,  7 May 2013 15:34:52 +0000 (UTC)
In-Reply-To: <1367633973-26214-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 4 May
 2013 09:19:33 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A970F25E-B72B-11E2-95FB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223581>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:

> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 67869b4..0629149 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -280,4 +280,9 @@ test_expect_success 'clone checking out a tag' '
>  	test_cmp fetch.expected fetch.actual
>  '
> =20
> +test_expect_success NOT_MINGW,NOT_CYGWIN 'clone local path foo:bar' =
'
> +	cp -R src "foo:bar" &&
> +	git clone "./foo:bar" foobar
> +'

Hmph, why not

	git clone --mirror src foo:bar &&
        git clone ./foo:bar foobar

or something?  Also do we have a easy negative case we want to test,
i.e. a case where we do not want the new codepath to trigger by
mistake?
