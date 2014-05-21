From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5] format-patch --signature-file <file>
Date: Wed, 21 May 2014 11:26:18 -0700
Message-ID: <xmqqsio3ounp.fsf@gitster.dls.corp.google.com>
References: <1400572806-21092-1-git-send-email-jmmahler@gmail.com>
	<1400572806-21092-2-git-send-email-jmmahler@gmail.com>
	<20140520082740.GB27590@sigill.intra.peff.net>
	<xmqq61l01gmw.fsf@gitster.dls.corp.google.com>
	<20140520182443.GA30533@sigill.intra.peff.net>
	<xmqq7g5gz3s4.fsf@gitster.dls.corp.google.com>
	<20140521164255.GA2040@sigill.intra.peff.net>
	<xmqq61kzqbi6.fsf@gitster.dls.corp.google.com>
	<20140521175930.GA4588@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed May 21 20:26:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnBDg-0007Sl-1f
	for gcvg-git-2@plane.gmane.org; Wed, 21 May 2014 20:26:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753068AbaEUS0Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 14:26:24 -0400
Received: from smtp.pobox.com ([208.72.237.35]:64058 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751137AbaEUS0X (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 14:26:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 509BC18047;
	Wed, 21 May 2014 14:26:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3sgGNp8910hzjgYf5vvS2LqF5AY=; b=JhGs/X
	24fTR+p7O4funmvmkP2dtzAKpYYzwhODxGCnZf4gsll/aRHrgi0RuSmOFFNQM0Uv
	oJxxdkeWrEpjSmGJeEsMAkrfmP3JXn06Yj+9Vm8HNvcafwnDMUHl7wBuE9chUc/4
	s5xYKmzhE+4gO+NnybEwl1z0ELoygDnttKWKg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JmBMEzfmcSPDFEyMLF1VFlMY4M4lTZ6a
	w6SWiZYhaL+lUsedM/g7Qz8kQGoux/+ibTSBTw0ki2dh2Q3C5wkrNSVuz1+UwIfo
	mOOvidWkRXJ+a0qmuvoc6GhmDfNXrIiMNxcj/mB6EDo8Vvgnq6oJxE30VMY21M7T
	dxCeNsumM6U=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 476F318046;
	Wed, 21 May 2014 14:26:23 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E33A718041;
	Wed, 21 May 2014 14:26:19 -0400 (EDT)
In-Reply-To: <20140521175930.GA4588@sigill.intra.peff.net> (Jeff King's
	message of "Wed, 21 May 2014 13:59:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 6791DAAA-E115-11E3-B8AF-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249819>

Jeff King <peff@peff.net> writes:

> On Wed, May 21, 2014 at 10:37:05AM -0700, Junio C Hamano wrote:
>
>> > I wasn't planning on anything as drastic as stripspace. I really just
>> > wanted to suppress the one newline, which is almost certainly the right
>> > thing to include for "--signature", but the wrong thing for
>> > "--signature-file" (i.e., the patch I posted earlier).
>> > ...
>> > I dunno. Maybe it is not worth caring too much about.
>> 
>> I suggested stripspace() because I know we do not care too
>> much, actually.
>> 
>> Cleansing blank lines in one way for many types of user input
>> (e.g. commit log messages and tag messages) while doing it in a
>> completely different way just for "--signature-file" is warranted if
>> there is a good reason for them to be different, but I did not think
>> of any, and I still don't.  So...
>
> I didn't think of mine as cleansing. It is more like "do not duplicate a
> newline ourselves if there is already one there".  But I guess those are
> two sides of the same coin.

Yeah, I agree with the last sentence.  My mention of "cleansing"
took into account your "do we want to omit the leading blank as
well?" as well.  In any case, wouldn't reusing stripspace() make the
fix-up shorter?
