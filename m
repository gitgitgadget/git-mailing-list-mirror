From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Can I fetch an arbitrary commit by sha1?
Date: Thu, 09 Oct 2014 11:08:06 -0700
Message-ID: <xmqqppe16rqx.fsf@gitster.dls.corp.google.com>
References: <CAENte7htO13s91UJFNzW4aBhsGxE=LpnvaZfce+vqQU5+a-cYg@mail.gmail.com>
	<CAPBPrnsA4KxNximtKXcC37kuwBHK0Esytdm4nsgLHkrJSg3Ufw@mail.gmail.com>
	<20141002161006.GB2505@peff.net>
	<CACh33FpWPuyJRryf6hzbAkqWJMwzz1mLLDDRxEQ0niT2CznTRg@mail.gmail.com>
	<CACsJy8B0dbE0C3M0PO-EfaZ_bSxwGJSFVejEGFzjHSOZKOc+Jw@mail.gmail.com>
	<20141007131257.GA24348@lanh>
	<xmqqwq8bizzi.fsf@gitster.dls.corp.google.com>
	<20141008133029.GA23010@lanh>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Patrick Donnelly <batrick@batbytes.com>, Jeff King <peff@peff.net>,
	Dan Johnson <computerdruid@gmail.com>,
	Christian Halstrick <christian.halstrick@gmail.com>,
	Git <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Oct 09 20:08:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XcI8W-0007GA-S2
	for gcvg-git-2@plane.gmane.org; Thu, 09 Oct 2014 20:08:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbaJISIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Oct 2014 14:08:12 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63499 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751060AbaJISIK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Oct 2014 14:08:10 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 489AD13704;
	Thu,  9 Oct 2014 14:08:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YbN1XcloRpqGr1l1nnSH7zrjdFw=; b=LbLaH3
	oRG3JuOm1lqrT7gOhr7CHcqkp+CeGKrt+DIkAkDSN8HCA3SKDXaC20mW4q9+o2UE
	I5Wq316U1u/aQi9sOmSQ9ktP1gdf0IRaMPObtFdkCy5US0a7scB1HihCcsSvNwbl
	K3jwgfdrRCvuImUkc063ukKTjT/yOopaIcYkA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nC95EW8YFHJvpwkfKpvbAal9GoD3eIkM
	8vbboW8s4MsaXzUQCkLTv4osK9yvc5TEGySl4d1qTz2TXphVKcWDQ4vDVprtWNE4
	WtQwmegSR9xaKNH80xSQ+KxciMO+0bJKmTqEkm7FBoo8VTCCLVmKgZYAD02/2lpe
	Y1lqjRW5jgU=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3EF8013703;
	Thu,  9 Oct 2014 14:08:08 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8906B13702;
	Thu,  9 Oct 2014 14:08:07 -0400 (EDT)
In-Reply-To: <20141008133029.GA23010@lanh> (Duy Nguyen's message of "Wed, 8
	Oct 2014 20:30:29 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 38C03300-4FDF-11E4-8A16-855A93717476-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Tue, Oct 07, 2014 at 09:52:33AM -0700, Junio C Hamano wrote:
>> Duy Nguyen <pclouds@gmail.com> writes:
>> 
>> > Hmm.. Junio already did most of the work in 051e400 (helping
>> > smart-http/stateless-rpc fetch race - 2011-08-05), so all we need to
>> > do is enable uploadpack.allowtipsha1inwant and apply this patch
>> 
>> Not that patch, I would think.
>> 
>> I would understand "if !stateless_rpc and !allowtipsha1 then it is
>> an error", though.
>
> Fair enough. It seems to work, technically, using the patch below. But
> I think people would rather have support from "git clone" and "git
> clone --branch" can't deal with SHA-1 this way yet. And --branch might
> be a bad place to enable this..
>
> So it needs more work.

This is so non-standard a thing to do that I doubt it is worth
supporting with "git clone".  "git clone --branch", which is about
"I want to follow that particular branch", would not mesh well with
"I want to see the history that leads to this exact commit", either.
You would not know which branch(es) is that exact commit is on in
the first place.

I would not say that "git archive" is sufficient, however, as "I
want to see the history that leads to the commit" is different from
"I want to grab the state recorded at that commit".

The "uploadpack.allowtipsha1inwant" is a wrong configuration to tie
this into.  The intent of the configuration is to allow *ONLY*
commits at the tip of the (possibly hidden) refs to be asked for.
Those who want to hide some refs using "uploadpack.hiderefs" may
want to enable "allowtipsha1inwant" to allow the tips of the hidden
refs while still disallowing a request to fetch any random reachable
commit not at the tip.

The "check_non_tip()" hack is a work-around for the deficiency of
the smart HTTP protocol (the tips of the refs the client reads off
of the server end are not the tips of the refs the serving server
verifies against the request due to information loss between the two
processes at the server end), and is not necessary for the proper
Git transport, where the server who first grabbed its tips of refs
and advertised them will know what it advertised and can expect the
request to come back asking exactly for those refs, not random
ancestors of those refs.

This new feature needs to be enabled with a different configuration
variable, perhaps "uploadpack.allownontipsha1inwant".  It has
associated cost of having to walk back the history to check the
reachability.

Thanks.
