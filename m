From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] merge: simplify code flow
Date: Thu, 23 Apr 2015 13:15:07 -0700
Message-ID: <xmqqd22u38l0.fsf@gitster.dls.corp.google.com>
References: <xmqqh9s6397b.fsf@gitster.dls.corp.google.com>
	<20150423201019.GA28338@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 22:15:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YlNWm-0005W0-E4
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 22:15:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754254AbbDWUPL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Apr 2015 16:15:11 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55157 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754245AbbDWUPK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Apr 2015 16:15:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 606114BFCD;
	Thu, 23 Apr 2015 16:15:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=16pNZuhVeYD5u421v7pOFdanMrY=; b=OShgLd
	QoIxMg5vgJlteQPydy1Fdum4+PocohLfRPD2L+GCEz0qsy5+uvZOBOIi69jqxPnB
	Jhiy51ksTDZflLpQyCjT80rFfNLSOxOwV7344wZc4tl0niLF58DD/BlMvq3mGHus
	rG5v1udyvMzSD5ut5lnnH7fLD68JsCB/goO8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nv4BF6Hbvectsb0+35ZneHJvNo6CRg7d
	NwqZjCCf9OzAUnFIgvBggpbTBl9l53POnHPws75ZQuXJg2nwo8p4Jr3/fI+8KOjp
	nDq9jDccgpbRydBda/NT9nZJcfLSjHwdVd5RTUsr/TL93aoT1e31tVUdtOUubVrT
	Ok4v4wAr35M=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 598A34BFCC;
	Thu, 23 Apr 2015 16:15:09 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id C8E514BFCA;
	Thu, 23 Apr 2015 16:15:08 -0400 (EDT)
In-Reply-To: <20150423201019.GA28338@peff.net> (Jeff King's message of "Thu,
	23 Apr 2015 16:10:19 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 704D965E-E9F5-11E4-AD3C-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267707>

Jeff King <peff@peff.net> writes:

> Yeah, this looks obviously correct.

It is funny that this dates back to the very beginning of defaulting
to the upstream, the code that "if ()" block implements, introduced
at 93e535a5 (merge: merge with the default upstream branch without
argument, 2011-03-23).

> As an aside, the fact that the actual "if (abort_current_merge)"
> conditional ends with a "goto" to a cleanup label that is 500 lines away
> is...kind of gross.

Reading "git show 93e535a5" output, I see that it is a more recent
"breakage" ;-)
