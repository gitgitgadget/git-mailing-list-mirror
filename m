From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 7/7] archive: provide builtin .tar.gz filter
Date: Wed, 15 Jun 2011 16:55:57 -0700
Message-ID: <7vboxyir8y.fsf@alter.siamese.dyndns.org>
References: <20110615223030.GA16110@sigill.intra.peff.net>
 <20110615223501.GG16807@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>,
	"J.H." <warthog19@eaglescrag.net>, git@vger.kernel.org,
	git-dev@github.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 16 01:56:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QWzwM-0001Xf-NH
	for gcvg-git-2@lo.gmane.org; Thu, 16 Jun 2011 01:56:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753098Ab1FOX4A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Jun 2011 19:56:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:38523 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751573Ab1FOX4A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Jun 2011 19:56:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1A6EC655B;
	Wed, 15 Jun 2011 19:58:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XUGspjlalnt+AtmWyLY89eV2ZwE=; b=Yzh86s
	64Szui3gh1xKxA07zaCHm62FEppA5rge/zScvp96eBza1muB6OhQv0a8ng87XiBv
	/WD27weJp6bkvHoSETmQVbItfXlO0MGafIcacx2xBKHP1eIvvdWfZDKvOaK1w9ET
	9DoTu5Y3x19lCSfckOjxMwvF2gvIGopoe0SGA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Xc54VRl27CASAXF1UhyuTDUGxmNJFh3x
	dv5LmudqmUbwRoPDFEazgPJyN6no0XWQD2MedRXygSAhBa8FkW0dSEdNHzhfBkBm
	hvT7p13Mh7itkR9mjU4kcycTsLDrlcQwmomMX7+OzKXVyW4Gj9egrYjWShCcCbFU
	6U50FjJHaI0=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1364A655A;
	Wed, 15 Jun 2011 19:58:10 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 75C316559; Wed, 15 Jun 2011
 19:58:09 -0400 (EDT)
In-Reply-To: <20110615223501.GG16807@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 15 Jun 2011 18:35:01 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 522BC4CA-97AB-11E0-82A0-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175873>

Jeff King <peff@peff.net> writes:

> +test_expect_success 'git archive --format=tgz' '
> +	git archive --format=tgz HEAD >j.tgz
> +'
> +
> +test_expect_success 'infer tgz from .tgz filename' '
> +	git archive --output=j1.tgz HEAD &&
> +	test_cmp j.tgz j1.tgz
> +'

I suspect this would get intermittent failures for the same reason as
0c8c385 (gitweb: supply '-n' to gzip for identical output, 2011-04-26)
