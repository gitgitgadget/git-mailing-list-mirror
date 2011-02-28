From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] get_remote_url(): use the same data source as ls-remote
 to get remote urls
Date: Mon, 28 Feb 2011 15:38:26 -0800
Message-ID: <7v4o7nhgr1.fsf@alter.siamese.dyndns.org>
References: <20110114090645.GA13060@pengutronix.de>
 <1298885779-10045-1-git-send-email-u.kleine-koenig@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, kernel@pengutronix.de
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Mar 01 00:38:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuCfo-0001Iv-7P
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 00:38:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754560Ab1B1Xih convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Feb 2011 18:38:37 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46317 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753729Ab1B1Xig convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Feb 2011 18:38:36 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2A0F948A2;
	Mon, 28 Feb 2011 18:39:54 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=iej02Aycm2mB
	KE3bjzb02Uk4D6I=; b=H1P3U1NZrOHTkmDiG84ydSslgQdhP0ekybmlr0W0xWwR
	ArE3z9GAIY2mHzqFWFiyKfrjTuxXCjCNhvMhFinbHQyBnYqQYg2a0Mk3XSrsdHsa
	HXzIznhLAreOG4cPeB7Bb6Pr4WyFJJVfccNu+0MApUXgHPv60HT4qEnBCcn3YjQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Kao7ZR
	lZEsr934EILx9JHCXmsSD6TGS1mpxYRbj5MZJmajpDcRKRnMuXfdwH2MlWcUGfg/
	dmqKk+L506w3lCINZj6bo/tsPPjgL3SeTVGCPF7VIEo9EEdSCg4jL6IRyNUjyaBb
	JkQXiEj6zi5Vr9AS0XfjYEFygY6DQ3iAYTTP4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id EB39548A1;
	Mon, 28 Feb 2011 18:39:50 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B080F4890; Mon, 28 Feb 2011
 18:39:46 -0500 (EST)
In-Reply-To: <1298885779-10045-1-git-send-email-u.kleine-koenig@pengutronix.de> ("Uwe
 =?utf-8?Q?Kleine-K=C3=B6nig=22's?= message of "Mon\, 28 Feb 2011 10\:36\:19
 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 091E20CC-4394-11E0-B8E5-AF401E47CF6F-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168165>

Uwe Kleine-K=C3=B6nig  <u.kleine-koenig@pengutronix.de> writes:

> with this patch git-request-pull.sh (=3D=3D the only in-tree user of
> git-parse-remote.sh:get_remote_url()) could directly use
>
> 	git ls-remote --get-url
>
> .  I guess you wouldn't want to remove git-parse-remote.sh:get_remote=
_url()
> though?!

If nobody uses it, why not?  I was actually hoping for the day that nob=
ody
uses any of the defined function so taht we can remove that whole file.
