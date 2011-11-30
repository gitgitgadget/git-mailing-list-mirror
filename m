From: Junio C Hamano <gitster@pobox.com>
Subject: Re: log: option "--follow" not the default for a single file?
Date: Wed, 30 Nov 2011 10:27:26 -0800
Message-ID: <7vipm1qxdd.fsf@alter.siamese.dyndns.org>
References: <CAN0XMOJsiw0c4j_LooRrj80CVVy0omGLUcjDg4QoD4mNS3y1GA@mail.gmail.com>
 <20111130063743.GB5317@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ralf Thielow <ralf.thielow@googlemail.com>,
	git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 30 19:27:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVosY-0006pw-Fi
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 19:27:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751416Ab1K3S13 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 13:27:29 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50846 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751154Ab1K3S12 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 13:27:28 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4CA8255A3;
	Wed, 30 Nov 2011 13:27:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=330+U/Nmpe7AZPumvbkXRecrjNI=; b=CBqUVU
	e1/9UTPwqO2xzWsIPeX5aJwYrbt/mCzu2kI5RGWC1sLgdOLekKgo3NuGP5olnTqW
	rgtYvFDTeePO7FKW4c0nT7WFPujtswzJ21PB3SQwBlAIKKJacKz4un4DjVX8HpLM
	mcmi45pMB9yiF+flKlyl13AiZ5l7r7G5TLSmk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=PjHgufgkZ/Ax3GytwZr8Y7rpyPZkaRts
	LNzda+MGvehaytfizsEeT6oITEP+KHhlly1v49LB6iQAEJAunQeVl3mOFanU7DHE
	DwnhAEdNgzbxwJl59dXykvwUzPVxu9HyUP9DwOoOdChN1LturhgMhadEgRojS2xi
	qzbxkCi+QoI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42E9C55A2;
	Wed, 30 Nov 2011 13:27:28 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B099655A1; Wed, 30 Nov 2011
 13:27:27 -0500 (EST)
In-Reply-To: <20111130063743.GB5317@sigill.intra.peff.net> (Jeff King's
 message of "Wed, 30 Nov 2011 01:37:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F4F6412C-1B80-11E1-BEE2-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186133>

Jeff King <peff@peff.net> writes:

>   2. It can be slower than a regular traversal, since we have to do
>      rename detection whenever we see a deletion. In practice I don't
>      think it is much slower, though (mainly because files don't get
>      moved all that much).

There is no difference between a regular traversal and a follow traversal
while the path is still there. When a path disappear during a regular
traversal, most likely the remaining traversal will yield nothing but the
user has already seen what is there to see. If a follow traversal was in
use, the user has seen the same as the regular traversal up to that point,
we spend a bit of time in rename detection, and then we start showing the
result of the traversal using an updated pathspec. I doubt that "slowness"
is an issue here.
