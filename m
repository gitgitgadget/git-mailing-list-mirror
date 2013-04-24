From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv2 7/7] git grep: honor textconv by default
Date: Wed, 24 Apr 2013 11:55:02 -0700
Message-ID: <7v38ufdaih.fsf@alter.siamese.dyndns.org>
References: <517298D4.3030802@drmicha.warpmail.net>
	<043047afd2915dd8f3a68cf164dc516d4c0bb5c2.1366718624.git.git@drmicha.warpmail.net>
	<7vwqrtjmtx.fsf@alter.siamese.dyndns.org>
	<5177AE7F.1040400@drmicha.warpmail.net>
	<7vehdzesr9.fsf@alter.siamese.dyndns.org>
	<vpqwqrrolpl.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael J Gruber <git@drmicha.warpmail.net>, git@vger.kernel.org,
	jeremy.rosen@openwide.fr, Jeff King <peff@peff.net>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Apr 24 20:55:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV4qY-000456-G5
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 20:55:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756933Ab3DXSzI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 14:55:08 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56495 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756367Ab3DXSzH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 14:55:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 92BF419D5D;
	Wed, 24 Apr 2013 18:55:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Dre3xEdC5DkDyuboivzuJe0+3gw=; b=Goj3uk
	EW4kUc+syaeLz0+CGnVbwws0m/8bBLn3WoKCP41ipgtHYB7mWLYGaUgFlBv9TVGD
	JDb/QBMb5s5k2sFfwWVXTgTGAPM7oXYqtmZEFUuVwV8Uz6s0WUGxSHdizru2xp3y
	tjEYKnOTDM16AT/+JelIuJfptYsQf0PhEWmgQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ViI9p33FZe4C3q1Lt9pTEafHxtlZR/N7
	6mUuHQCF4F8gnGwvOOt3cTPW/3N83NdlkjY8UQmLEaPA7PtjW8IHDlH+84KKL2UX
	lXq0IXrRgtaWSQGd2zuWhRJ/M+3X2btzxQwy5J2xQMQyS6WO3wenKlhd5q55sTNU
	q26rWKeDXyQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8A71619D5C;
	Wed, 24 Apr 2013 18:55:04 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1542C19D58;
	Wed, 24 Apr 2013 18:55:03 +0000 (UTC)
In-Reply-To: <vpqwqrrolpl.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Wed, 24 Apr 2013 19:57:42 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7951648E-AD10-11E2-A7B7-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222294>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Grepping through the binary, on the other hand, can very well make
> sense, like:
>
> $ git grep foo
> file.txt: some instance of foo
> binary file bar.bin matches

Yes, 

I am moderately negative on making it the default, mostly because it
goes against established expectations, but I did not mean to say
that an ability to pass blob contents through textconv before
running grep should not exist.  It would be a good option to have.
