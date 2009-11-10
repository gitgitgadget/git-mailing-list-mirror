From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC, PATCH] git send-email: Make --no-chain-reply-to the
 default
Date: Mon, 09 Nov 2009 21:29:44 -0800
Message-ID: <7v4op3gd6f.fsf@alter.siamese.dyndns.org>
References: <1257786206-9208-1-git-send-email-mitake@dcl.info.waseda.ac.jp>
 <1257789555.4108.348.camel@laptop> <20091110040847.GC29454@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Zijlstra <peterz@infradead.org>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Tue Nov 10 06:30:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N7jIo-0005Lp-Hw
	for gcvg-git-2@lo.gmane.org; Tue, 10 Nov 2009 06:30:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751402AbZKJF3v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Nov 2009 00:29:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbZKJF3v
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Nov 2009 00:29:51 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43554 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751120AbZKJF3u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Nov 2009 00:29:50 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B24AD99022;
	Tue, 10 Nov 2009 00:29:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=IQ4Y5aSEEE3EYsWumFjhO5Oqdfs=; b=AzKBxl
	6SM1BBnM8CTOoRH5fLra392849NBX+v1Uzt23JIOl5IGi375MYkt4gqgaWQe1M99
	4iVTkRbZ+nPWcv86evKM4e+1M8j8f94tYYiqiqf1+bPNb0yWbg0kwxDUSyoMQd56
	e/iSDrdi81XUnOju6DlLBAD8DoUJK2f3ss7u0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qZqKCxosHzCPMeXjkFKp6xzvN41kCVj5
	PJLcoydG71VHAom+VerpuZLUXl7408n5anvXcFiVdBBnzYjaF9moKGvNOZ8HVzbp
	UqFm6y+62FJSVC590Ihx1c3czwGcT4VL3s09dR4t9FrDG8ALRh8A0V7moXeBJS8B
	6MPbb5WeI1I=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 89A5999021;
	Tue, 10 Nov 2009 00:29:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9A91F9901F; Tue, 10 Nov 2009
 00:29:46 -0500 (EST)
In-Reply-To: <20091110040847.GC29454@elte.hu> (Ingo Molnar's message of
 "Tue\, 10 Nov 2009 05\:08\:47 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 1278A828-CDBA-11DE-8143-BD45BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132539>

Ingo Molnar <mingo@elte.hu> writes:

> (moved from lkml to the Git list)
>
> * Peter Zijlstra <peterz@infradead.org> wrote:
>
>> >                            Mailer: 
>> > git-send-email 1.6.5.2
>> 
>> Please teach your git-send-email thing to use --no-chain-reply-to.
> ...
> So ... the question would be ... could git-send-email flip its default 
> please, via the patch below? Am i missing something subtle about why 
> this default was chosen?

I do not think there was any conscious decision made when the
chain-reply-to was added.  It was done and it got stuck.

I think the _only_ argument anybody _could_ make (and I won't be making
it, as I'd rather wish we had no-chain-reply-to the default from day one)
against the change of default is that it is a change [*1*].

Lkml already had two rather heated discussion in the past,

After the first round, I said we'd change the default to no-chain-reply-to
in release 1.6.3 unless somebody makes a convincing argument why the
default should not change, back around the time we were preparing for
1.6.2 (February 2009).

    http://thread.gmane.org/gmane.comp.version-control.git/109790

Nobody complained.

Then I forgot to make such a declaration in the release notes to 1.6.3,
and no such declaration appeard in later release notes, either.

But nobody complained (nor reminded me).

The second round of the discussion was in August 2009.  This time I did
something to prevent me from forgetting in the future.

    http://thread.gmane.org/gmane.linux.kernel/879975/focus=880938

This patch is queued in 'next', scheduled to graduate to 'master' for the
1.7.0 release.


[Footnote]

*1* To spell it out...  The people who are in the "hate chain-reply-to
very much" camp would have already done their own configuration to get the
behaviour they want by now, so changing the default would not help them
much, while potentially hurting "love chain-reply-to" people who have been
content because they got what they wanted without setting any
configuration.
