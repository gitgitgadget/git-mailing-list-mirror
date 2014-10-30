From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Is there way to set git commit --date to be older than 1970 ?
Date: Thu, 30 Oct 2014 15:11:53 -0700
Message-ID: <xmqqtx2ltdg6.fsf@gitster.dls.corp.google.com>
References: <CAOE_JxJp0nA_p_42yOyk_nMjsyMaovj0Fx6AJ5nywiEQfB5XAQ@mail.gmail.com>
	<xmqqh9ymy8np.fsf@gitster.dls.corp.google.com>
	<CAPBPrnuxAPmKe_aRb9USh=cOu4jMZaYzOorXC_RJa8b8ROq+iA@mail.gmail.com>
	<20141030214852.GB21017@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dan Johnson <computerdruid@gmail.com>,
	Peter Vojtek <peter.vojtek@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 23:12:05 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xjxwn-0007xP-ER
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 23:12:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161314AbaJ3WL5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 18:11:57 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:61936 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1161019AbaJ3WL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 18:11:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CCE781A43B;
	Thu, 30 Oct 2014 18:11:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DLDSQwfRYcrOcEQHwOtcjXoQ0dg=; b=lNILN7
	gar5JE7qFzw45uLuZ0B1F8z5S9XbJuG+lmVHXlqQyyyrHyZqPemLFffUx1kOLztJ
	69g4EuYzGizEM2mKx54M+rw1JyZzhgD34P6Th9Jm1rvEXGoTkUkd2Q3yMqP3zObX
	cNGMGyLMqxygS4XurEb6JtTp3Gadu/UIHMcJ4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QwlaE14SA8i0nCQ42LtyLR0sqCfS/ngR
	E+TJeQUYQehs2xFRBdxRY26VJrR0qJ5GNePLCLrhj4FbULnuveyhalyruFjVyb5J
	6WBaGw5mjIWgYD1NihSND2IlDqJ1sLhLbjqECzhyLv3Ooq+a1sLEHMzYQV9+xHxC
	8YQBl8AFqZ8=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C21C01A43A;
	Thu, 30 Oct 2014 18:11:55 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 2B3CC1A439;
	Thu, 30 Oct 2014 18:11:55 -0400 (EDT)
In-Reply-To: <20141030214852.GB21017@peff.net> (Jeff King's message of "Thu,
	30 Oct 2014 17:48:52 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C2205F0A-6081-11E4-BA23-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I think it would be a nice project to convert git to consistently use
> signed 64-bit times internally, and then everything would Just Work
> going back to the beginning of history. But the demand for such a
> feature has been low enough that nobody has really dug in and tried the
> conversion.
>
> We do also gain some small amount of efficiency by storing commit
> timestamps as 32-bit values. However, those should always be "current"
> times anyway. I think we are really talking about author timestamps
> here (and of course the underlying time-manipulation functions).

There are only three places we store timestamps that matter in the
on-disk representations, so if we were to go 64-bit internally,
which I do not mind at all, we probably should do all three i.e.,
committer, tagger and author dates.
