From: Junio C Hamano <gitster@pobox.com>
Subject: Re: difftool -d symlinks, under what conditions
Date: Wed, 13 Mar 2013 08:30:07 -0700
Message-ID: <7vtxof48sg.fsf@alter.siamese.dyndns.org>
References: <CAJELnLEL8y0G3MBGkW+YDKtVxX4n4axJG7p0oPsXsV4_FRyGDg@mail.gmail.com>
 <CAJELnLGOK5m-JLwgfUdmQcS1exZMQdf1QR_g-GB_UhryDw3C9w@mail.gmail.com>
 <20130312190956.GC2317@serenity.lan>
 <CAJDDKr7S0ex1RvZS0QeBXxAuqcKrQJzhZeJP0MoMGmpGXyMOrA@mail.gmail.com>
 <20130312194306.GE2317@serenity.lan>
 <7vfw0073pm.fsf@alter.siamese.dyndns.org>
 <20130312210630.GF2317@serenity.lan>
 <CAJELnLGBr1wOX4-3rCNjPpPLezc_6FgyeuPqty268JR0==qtvQ@mail.gmail.com>
 <7vehfk5kn2.fsf@alter.siamese.dyndns.org> <3222724986386016520@unknownmsgid>
 <20130313001758.GH2317@serenity.lan>
 <CAJDDKr7ZU16XWtCfYX9-RMzcpKa_FF80Od+mUMG4n8dUKeLsvw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: John Keeping <john@keeping.me.uk>,
	Matt McClure <matthewlmcclure@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 13 16:30:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFndd-00081D-3v
	for gcvg-git-2@plane.gmane.org; Wed, 13 Mar 2013 16:30:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933007Ab3CMPaP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Mar 2013 11:30:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57429 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932391Ab3CMPaO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Mar 2013 11:30:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7A199B45B;
	Wed, 13 Mar 2013 11:30:09 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vFhg5YliqWlYGoXfBf8djylff+8=; b=du18az
	WTTGhouPUAhnBsv2jqRmMUZI1IA+vtlW9d10L24lBY60S8KlBMbZXfkP6X7t77kH
	Cn5mvwiCOxuw7DVdzzRftRE4jbiBOm9fnvvDX++p3W4DpHukGnkaks1rMu8f96xX
	64R3SrXPZQ4SMBKtvnPwvOOcEiydDf20canMI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DkTbBHTsUOBQSbdwiE/BNwT4Tb2q5XRt
	qGMV9gk/szm7yCmH0ICHOLXwmMmwQBnrH5UK/XxWx/8NCLOjc6IwK20ffNPrpqc6
	30EJCgm0hUAiT+JZGF7w/HIcRS0pgxDIAAvyVYc5qWHCidTVRSb2i8Da5KpbGr5n
	1LNO/Dpr/pA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 69541B45A;
	Wed, 13 Mar 2013 11:30:09 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C38E0B457; Wed, 13 Mar 2013
 11:30:08 -0400 (EDT)
In-Reply-To: <CAJDDKr7ZU16XWtCfYX9-RMzcpKa_FF80Od+mUMG4n8dUKeLsvw@mail.gmail.com> (David
 Aguilar's message of "Wed, 13 Mar 2013 01:24:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E36AAA5E-8BF2-11E2-B62B-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218058>

David Aguilar <davvid@gmail.com> writes:

>> The implementation of Junio's suggestion is relatively straightforward
>> (this is untested, although t7800 passes, and can probably be improved
>> by someone better versed in Perl).  Does this work for your original
>> scenario?
>
> This is a nice straightforward approach.
>
> As Junio mentioned, a good next step would be this patch in
> combination with making the truly temporary files created by
> dir-diff readonly.

Even though I agree that the idea Matt McClure mentioned to run a
three-way merge to take the modification back when the path checked
out to the temporary tree as a temporary file (because it does not
match the working tree version) gets edited by the user might be a
better longer-term direction to go, marking the temporaries that the
users should not modify clearly as such needs to be done in the
shorter term.  This thread wouldn't have had to happen if we had
such a safety measure in the first place.
