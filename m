From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] prepare_packed_git(): refactor garbage reporting in pack directory
Date: Wed, 28 Oct 2015 10:48:13 -0700
Message-ID: <xmqqbnbilw9u.fsf@gitster.mtv.corp.google.com>
References: <xmqqwpx6wx74.fsf@gitster.dls.corp.google.com>
	<1439488973-11522-1-git-send-email-dougk.ff7@gmail.com>
	<CAPig+cS0ntr1sYzVAPjNCwd8ei4oGQRNs+W=qMBV4Z6NaRWCWA@mail.gmail.com>
	<xmqq37zhg8la.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Doug Kelly <dougk.ff7@gmail.com>, Git List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed Oct 28 18:48:20 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZrUpf-0001u6-QL
	for gcvg-git-2@plane.gmane.org; Wed, 28 Oct 2015 18:48:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755486AbbJ1RsQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2015 13:48:16 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:62308 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755391AbbJ1RsP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2015 13:48:15 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D6FD223152;
	Wed, 28 Oct 2015 13:48:14 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZVKZXtrOHiC86i6Ks99rvGH3tE4=; b=rsMnXO
	Mk3hCRIqWvsEI/8dcDmI04XRR0anLlU7IH/fsOU76Itzd6rtEq1Un6oDn2kVFZX/
	6LzjniioFvBy7aehdFPSoUI2R3OuFS9kBmXv2KfqquOWGVj27k6mw2C1lS2/dCE2
	x98T3VQ2VfB6rJVtBmiKOrkE87jjcx4O/0oDo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=vNqG0J6ugd951HOEZdcP5//pzGxB0NBo
	LjaFFDNbxwXYlXm4YYfbX6pbG3W18RSKhyttSVUjTb+U3ZBDqW9i75HZjK+fYJv1
	uWtbkupOPd2Fa25CxnrVmbvE5NONNzKh8owBBCX6g1ElWsdUFsIeYNyFCEMK/Ul0
	upru1CiMsrM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD28923150;
	Wed, 28 Oct 2015 13:48:14 -0400 (EDT)
Received: from pobox.com (unknown [216.239.45.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 51EFE2314D;
	Wed, 28 Oct 2015 13:48:14 -0400 (EDT)
In-Reply-To: <xmqq37zhg8la.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Mon, 17 Aug 2015 09:53:21 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 101F6916-7D9C-11E5-9B54-6BD26AB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280385>

Junio C Hamano <gitster@pobox.com> writes:

> Eric Sunshine <sunshine@sunshineco.com> writes:
>
>>> -static void real_report_garbage(const char *desc, const char *path)
>>> +const char *bits_to_msg(unsigned seen_bits)
>>
>> If you don't expect other callers outside this file, then this should
>> be declared 'static'. If you do expect future external callers, then
>> this should be declared in a public header file (but renamed to be
>> more meaningful).
>
> I think this can be private to this file.  The sole point of moving
> this logic to this file is to make it private, after all ;-)  Thanks
> for sharp eyes.
>
> Together with the need for a description on "why", this probably
> deserves a test or two, probably at the end of t5304.
>
> Thanks.

Does somebody want to help tying the final loose ends on this topic?
It has been listed in the [Stalled] section for too long, I _think_
what it attempts to do is a worthy thing, and it is shame to see the
initial implementation and review cycles we have spent so far go to
waste.

If I find nothing else to do before any taker appears, I could
volunteer myself, but thought I should ask first.

Thanks.
