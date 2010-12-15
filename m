From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] get_sha1: support ref^{/regex} syntax
Date: Tue, 14 Dec 2010 16:50:31 -0800
Message-ID: <7vaak7rh9k.fsf@alter.siamese.dyndns.org>
References: <1292209275-17451-1-git-send-email-pclouds@gmail.com>
 <1292209275-17451-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>,
	Kevin Ballard <kevin@sb.org>, Yann Dirson <dirson@bertin.fr>,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 15 01:51:06 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PSfaD-0008HB-Di
	for gcvg-git-2@lo.gmane.org; Wed, 15 Dec 2010 01:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760299Ab0LOAu5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Dec 2010 19:50:57 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48214 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760251Ab0LOAu4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Dec 2010 19:50:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 925B73B36;
	Tue, 14 Dec 2010 19:51:19 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=EtL99LLPE1F5
	5Off6m4TAAdjaRk=; b=DSLxO1NMeXDsKgDUqabq+ZlryF2PEzFmKtXtAfX4PD9j
	6C+7K4rDLP9Vp0040ibjrDK+7/jYh8tfojA9ZbiRXGGWeVPCBwWg2pwZXjj0J0fp
	xjgcTAUQF+P2KP2jICiDL5vkbbmo8km/A5I2YR+y8mik8FggeBowGtNowfzHGRE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=OoTxIn
	nS8fjp3WiPIZcFUF80axJq4FUWA7hVGvDQxQePArF4rk0tMe/ainBdiCwNfmWQuh
	ms9aJStk5fRRgsvTBv5BUVDsHO57IuayR1sLI4EwE1nEGYXkPPxvHnEOfMvuDvgK
	R6B/QKPnSLf5vZv+yCMfkSHrPN0+6zBQ6DafU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0BB8A3B2A;
	Tue, 14 Dec 2010 19:51:11 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id BAC4D3B17; Tue, 14 Dec 2010
 19:51:00 -0500 (EST)
In-Reply-To: <1292209275-17451-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuIFRow6FpIE5n4buNYw==?= Duy"'s message of "Mon\, 13 Dec
 2010 10\:01\:15 +0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 68E8752E-07E5-11E0-8C25-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163727>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> +test_expect_success 'ref^{/}' '
> +	git rev-parse master >expected &&
> +	git rev-parse master^{/} >actual &&
> +	test_cmp expected actual
> +'

This test fails on FBSD 8, which refuses to regcomp("")
saying "empty (sub)expression", which is somewhat bogus.

I'd change it to "/." for now ;-).
