From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/2] submodule: pass on http.extraheader config settings
Date: Thu, 28 Apr 2016 12:06:56 -0700
Message-ID: <xmqq1t5p5z8v.fsf@gitster.mtv.corp.google.com>
References: <3b71deffa5d07cf73a793773cc3d60ff611843fa.1461759454.git.johannes.schindelin@gmx.de>
	<cover.1461837783.git.johannes.schindelin@gmx.de>
	<89d0024450b0e6e9997ad9e3d681248bde1bafc0.1461837783.git.johannes.schindelin@gmx.de>
	<20160428112912.GB11522@sigill.intra.peff.net>
	<alpine.DEB.2.20.1604281405540.2896@virtualbox>
	<20160428134953.GB25364@sigill.intra.peff.net>
	<CA+P7+xq-_D2Mszyjd11CyYLiKBBh9A2e1exaZQVmWz1qVKv7ug@mail.gmail.com>
	<20160428153902.GF31063@sigill.intra.peff.net>
	<CAGZ79kZFLTARQ25h4u4SGgNn=Q4TQi-kxFLN3sQvOmejsRmAWA@mail.gmail.com>
	<20160428165031.GA31421@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Stefan Beller <sbeller@google.com>,
	Jacob Keller <jacob.keller@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 28 21:07:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avrHH-0006pM-No
	for gcvg-git-2@plane.gmane.org; Thu, 28 Apr 2016 21:07:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751932AbcD1THB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Apr 2016 15:07:01 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62406 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751513AbcD1THA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2016 15:07:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B112915D53;
	Thu, 28 Apr 2016 15:06:58 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Ui5epAXpnYuj6mNVTVBq3KpqXuQ=; b=FRbaNf
	Orb1DgEawQ6eN1Z8adZgIhRW7ABwdQnQORJ8dlx1pLRc74alRvVC9+FqWLbGbsMP
	+5mW0JsqyY9xPeNvQD2ibKnHI+0JlrdiGadUtqGjfwy38bqOSYVhpPcQvbt044LO
	51R8qLkTN57rzGyO3zBixi7VNRBcshmNa48yg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=I5JRs0jVYdiozPoqbCVXJVjaBjXTmo/m
	v8D/ri1+d8ODZxcUaSEQCs2tR6deeLyTTjXGItSzTbpPpCLh80PKKYjvaaRO1MC8
	oj8LId1xUN49rsZUjamREsFzhdDEDZOyOwU0XnU6jPactwDTUsJNynjONkS6Q28y
	WD+Q8cW59DI=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A763415D51;
	Thu, 28 Apr 2016 15:06:58 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 1939F15D4C;
	Thu, 28 Apr 2016 15:06:58 -0400 (EDT)
In-Reply-To: <20160428165031.GA31421@sigill.intra.peff.net> (Jeff King's
	message of "Thu, 28 Apr 2016 12:50:31 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 614CAE30-0D74-11E6-A639-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292935>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 28, 2016 at 09:09:44AM -0700, Stefan Beller wrote:
>
>> > I think the key thing with a blacklist is somebody has to go to the work
>> > to audit the existing keys.
>> 
>> Would it be sufficient to wait until someone screams at the mailing list
>> for some key to be blacklisted? (I mean in the short term that would be
>> of less quality, but relying on the larger community would result in a better
>> end result? So your going through is just a jump start this process of
>> listening to the community?)
>
> Yeah, I think ultimately we will rely on the community. But I would feel
> a lot more comfortable if somebody made at least a single pass.
>
> I'll be curious what Junio says, too. I generally defer to him on how
> conservative we want to be in cases like this.

Starting from an empty whitelist and waiting for people to scream
with valid use cases would automatically give us the single pass to
identify the set of essential ones that users must be able to pass,
no?

Of course, the screamed proposal to add something to whitelist must
be vetted (i.e. "yeah, we can see passing X in _your_ usecase might
be useful, but here are downsides (e.g. security implications) of
allowing X in other usecases").  And we might even find that it is
insufficient safety to allow/disallow per variable name during that
discussion, in which case choice between whitelist and blacklist
becomes moot.
