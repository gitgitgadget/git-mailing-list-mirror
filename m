From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC] pull/fetch rename
Date: Fri, 23 Oct 2009 23:30:16 -0700
Message-ID: <7v4opp9udj.fsf@alter.siamese.dyndns.org>
References: <200910201947.50423.trast@student.ethz.ch>
 <alpine.LNX.2.00.0910201912390.14365@iabervon.org>
 <20091021063008.GA3349@glandium.org>
 <7v3a5db6ij.fsf@alter.siamese.dyndns.org>
 <7v63a99pok.fsf@alter.siamese.dyndns.org>
 <20091021074522.GA13531@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Mike Hommey <mh@glandium.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Thomas Rast <trast@student.ethz.ch>, git@vger.kernel.org,
	=?utf-8?Q?Bj=C3=B6rn?= Steinbrink <B.Steinbrink@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 24 08:30:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1a9L-0006s4-8I
	for gcvg-git-2@lo.gmane.org; Sat, 24 Oct 2009 08:30:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbZJXGae (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 Oct 2009 02:30:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751541AbZJXGae
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Oct 2009 02:30:34 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33738 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751525AbZJXGad (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Oct 2009 02:30:33 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 07E9683CCA;
	Sat, 24 Oct 2009 02:30:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gEwiJrvTOfuG5t/vfX7PzYd7LOo=; b=FTuHRX
	/nIgmFQUGWKtunz6jUr0pbYUq0sCM6wPrKegHTlHRjUdZ+Q5CGWaufmJm19kGAh9
	5IBhKaIPIOvZMM/iTZjjUu94M+Rigj4XKXWSKd/MX5a7SfsfaQV7IcNoH/nqJKxN
	/QUtgXOJeUHs2jcKnfq2tyPGSs3ETuoYHi2g4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vsXRjqTYI0ybLlTqvwgl4c5Fs/vtrbHp
	L/KfKh2xHEnJO6uL096GTU55C8ffFeDCO1WLGZwpPkMwPNbbdEIskLYgQ/N5vWsd
	wfWZFVmMfqM08ArpoqQ1resGH8Cq0XAn66/gZ63t/rbJensCBLDW5JRTSDDl6dBT
	rvVMMVwrAS4=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A4B4983CC5;
	Sat, 24 Oct 2009 02:30:27 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 755A983CC3; Sat, 24 Oct 2009
 02:30:18 -0400 (EDT)
In-Reply-To: <20091021074522.GA13531@coredump.intra.peff.net> (Jeff King's
 message of "Wed\, 21 Oct 2009 03\:45\:22 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B8220B40-C066-11DE-99ED-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131142>

Jeff King <peff@peff.net> writes:

> On Wed, Oct 21, 2009 at 12:22:35AM -0700, Junio C Hamano wrote:
>
>> It is not even a typesaver.  "git fetch" updates from the default remote,
>> so does "git remote update".  Personally I think the people who invented
>> "git remote update" were misguided, and that is why I say it was a failed
>> UI experiment that failed, but that is hindsight talking [*1*].
>
> Declaring it a failure depends on what you consider the goal of "git
> remote update" to be. I find it very useful as a shorthand for "fetch
> from _all_ remotes"[1]. Which does save typing over
>
>   $ for i in `git remote`; do git fetch $i; done

You've since read my footnote about "git fetch <group>", so I do not think
this part is controversial anymore.

> And of course, there is "git remote" again, saving us a few keystrokes
> over:
>
>   $ git config --get-regexp 'remote..*.url' | cut -d. -f2

And as you may have already realized by now, I was saying two things.

 (1) "git remote" in general is a good management interface for remote
     nicknames and attributes attached to them, in the similar spirit as
     "git config" is a good management interface for the underlying
     configuration files.

 (2) "git remote update" is a misguided UI expariment that failed.

So there is no disagreement between us on the "and of course" part,
either.
