From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/2] remote-bzr: couple of fixes
Date: Sun, 05 May 2013 12:03:55 -0700
Message-ID: <7v4nehuu3o.fsf@alter.siamese.dyndns.org>
References: <1367627467-15132-1-git-send-email-felipe.contreras@gmail.com>
	<7vd2t5uvi2.fsf@alter.siamese.dyndns.org>
	<CAMP44s1D7LOhDGkZguosPiXyuJ5cP2hmgq4AWagwadrJYK1Pgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 05 21:04:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZ4E7-0006SG-Gs
	for gcvg-git-2@plane.gmane.org; Sun, 05 May 2013 21:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752016Ab3EETD6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 May 2013 15:03:58 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47067 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751943Ab3EETD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 May 2013 15:03:57 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 30E611CC8B;
	Sun,  5 May 2013 19:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=eMJv2/nUZwHrJoVswU6p6jKjuDA=; b=w7tFzo
	WUf9A6PWmt6gEaEXyaez9o+j/Iv/PCJsZYE2H7ynj5xp/YyJTvGsWprsw0AqCW38
	ay9TAILVSEplzik/8FKK/5mp1/eFHQjmLNAh3eKf+1B6p2Huf/G3ZjQERYW8PfqY
	9EF54/iIjPih5Qiv4+74RYw677NAsYiZnyA5o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R1OBlGdt5/HM1Vvw0sGkehohUokv8Y4x
	oTkzfJG3Rheqv6dqaXATXyrewRh2yyMOYA9EVGj3mmQuADPCy1jmvS87/CANbZ2r
	jCRiiR5tjQ/4RiNQFY8EsEK/vik+Bh+PYpdDIoXgyM3byCJaug31Y1f4hiqUMx/h
	7dvVWG+py7w=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2914D1CC8A;
	Sun,  5 May 2013 19:03:57 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9D9621CC89;
	Sun,  5 May 2013 19:03:56 +0000 (UTC)
In-Reply-To: <CAMP44s1D7LOhDGkZguosPiXyuJ5cP2hmgq4AWagwadrJYK1Pgg@mail.gmail.com>
	(Felipe Contreras's message of "Sun, 5 May 2013 13:42:22 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8949D3E0-B5B6-11E2-922A-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223415>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> On Sun, May 5, 2013 at 1:33 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Felipe Contreras <felipe.contreras@gmail.com> writes:
>>
>>> The previous version had an indentation bug (did I mention I hate python?).
>>>
>>> A few fixes to be applied on top of the massive changes already queued. Nothing
>>> major.
>>
>> [2/2] may not matter much in the context of my tree (people would
>> use post 1.8.2 fast-export if they are using remote-bzr from 1.8.3
>> from my tree ;-),
>
> Maybe, but if even if they have the latest git, pushing a tag will
> fail miserably, and with the patch it would fail nicely :)
>
>> but [1/2] sounds like it is a good thing to have
>> in 1.8.3 (not "on top of that 'massive' series").
>>
>> Assuming the "otherwise some version of bzr might barf" problem is
>> that repo.generate_revision_history() in those versions may not
>> apply str() to its first parameter and the caller is expected to
>> pass a string there, or something?
>
> No, there's no change to repo.generate_revision_history(), because we
> already convert the elements of the array to strings, it's the other
> callers of Marks::to_rev() that see a change, namely code that pushes
> to a remote, I think.
>
> And BTW, they are already strings, but unicode strings, because they
> come from a json file, somehow bazaar doesn't like that, but it works
> fine in my machine without the patch. Shrugs.
>
> Also, the emacs developers seem to be fine with all these changes,
> there's only one patch pending that I need to cleanup.

So do you want to queue these on top of the "massive" in 'next', not
directly on 'master'?
