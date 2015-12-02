From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clean: new option --exclude-from
Date: Tue, 01 Dec 2015 18:18:30 -0800
Message-ID: <xmqq37vl7fux.fsf@gitster.mtv.corp.google.com>
References: <1448549065-16337-1-git-send-email-rouzier@gmail.com>
	<20151202005338.GD28197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: James <rouzier@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Dec 02 03:18:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3x09-0008Jd-KJ
	for gcvg-git-2@plane.gmane.org; Wed, 02 Dec 2015 03:18:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756236AbbLBCSd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Dec 2015 21:18:33 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55756 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755882AbbLBCSc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Dec 2015 21:18:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1A2D3309CC;
	Tue,  1 Dec 2015 21:18:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5eK2mzhWlJPwIbmhMfLMXC81L0g=; b=jml1d/
	oWiSf2ieFHxXLD6gBfT8arWF2y4tkcT8DTFUavu78GHZyIvE/AcwzxN7Y5FmhNjt
	02AjRdx9NeZgxBDxZYlo5RSdu7CY9SY8+xZ/xeE7NOIh691O4k9xZ9U/JjjFSGiI
	Oc2oQSoTMxO0hr5xPfHFgNsRfM6JS07MB4Gp0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=dA2+mmU3g9QjaR7kPKZjYAlpRjqn1ew/
	oidsUArrHFG5eFCE/X9vJ+5YQR/D9pt2zPMKPCj7dM4y9pvCI3E7Qi1Qrh+M55KY
	0AtUe7PXCK6tbyVG147W1FAARx2CWU8sarwMNOgm2CeQEyO8zw43Ni4f0Vb1hvcx
	NvGZNGT+Nig=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 10219309CB;
	Tue,  1 Dec 2015 21:18:32 -0500 (EST)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 827D7309CA;
	Tue,  1 Dec 2015 21:18:31 -0500 (EST)
In-Reply-To: <20151202005338.GD28197@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 1 Dec 2015 19:53:38 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: FB6FE0EE-989A-11E5-B8EB-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281874>

Jeff King <peff@peff.net> writes:

> On Thu, Nov 26, 2015 at 09:44:25AM -0500, James wrote:
>
>> From: James Rouzier <rouzier@gmail.com>
>> 
>> Specify a file to read for exclude patterns.
>> ---
>
> Lots of commands care about excludes (e.g., "add", "status").
>
> Should this perhaps be an option to the main "git" to append to the set
> of excludes?
>
> You can kind-of do this already with:
>
>   git -c core.excludesfile=/path/to/whatever clean ...
>
> but of course you might be using core.excludesfile already. I wonder if
> that config option should take multiple values and respect all of them,
> rather than last-one-wins.

It is likely that existing users are already using $HOME/.gitconfig
that sets core.excludesfile=$HOME/.gitconfig as the personal
fallback, that is overriden, not tweaked, by project specific
settings of the same variable in .git/config, so that would not fly
very well, I suspect.
