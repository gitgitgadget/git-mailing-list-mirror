From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib: simplify '--option=value' parsing
Date: Fri, 22 Apr 2016 13:54:55 -0700
Message-ID: <xmqq1t5xpdnk.fsf@gitster.mtv.corp.google.com>
References: <1461339503-6854-1-git-send-email-szeder@ira.uka.de>
	<20160422183703.GA7595@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 22 22:55:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ati6R-0000iC-RC
	for gcvg-git-2@plane.gmane.org; Fri, 22 Apr 2016 22:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbcDVUy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Apr 2016 16:54:59 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61863 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751172AbcDVUy7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Apr 2016 16:54:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 79C9C13006;
	Fri, 22 Apr 2016 16:54:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=84P0JNc9pzueWSfDrvd7F3FDi/w=; b=PlqitN
	DC2iE2x8TIM8ptAQC4UTBgVmtKC1WoM6PoSOoIwo9WdX7y9b0X6Lg2O1vDQvCJio
	2abQYyB6UA9OTTLpMNQ28Y6spLo5WNVpF5dL8V/AR3NYmsHeSLKYluoAvpxT6q9w
	WiiCUerjEW5uB5oyl6inPbqtpGebOM+zMUdN8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=TBKxbhRx5H9R9gU/S5bdW1pQivXAnw2w
	xfLR6Jm/w+ODUzaOXcysmUHjc8Gv9zDCN0DC6/AwIGu4NB3ZZbKEFk3aQyyelBMj
	CBrrZ13k6RJSeYiSu/6w6rb4BgGwhX+HLN9v7XvPdpQIOEpfQR92hXfvh+BjLSvM
	NORgb1WpESw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 61C3713005;
	Fri, 22 Apr 2016 16:54:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CEA8913004;
	Fri, 22 Apr 2016 16:54:56 -0400 (EDT)
In-Reply-To: <20160422183703.GA7595@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 22 Apr 2016 14:37:03 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 78744282-08CC-11E6-A181-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292266>

Jeff King <peff@peff.net> writes:

> For some reason I had always assumed that complicated pattern matching
> with "#" was non-POSIX, but I checked and it is definitely in there.

No, the offending code really dates back to the days back when I was
writing most of the shell scripts (or others were mostly copying
from what I have written).  I had this irrational aversion against
variable substitutions that are beyond ${var-default}, ${var=assign}
and ${var+isset}.

The conversion looks fine (modulo one missed one you noticed).

Thanks for cleaning things up.
