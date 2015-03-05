From: Junio C Hamano <gitster@pobox.com>
Subject: Re: feature request: excluding files/paths from "git grep"
Date: Wed, 04 Mar 2015 22:03:54 -0800
Message-ID: <xmqqy4nc3rqt.fsf@gitster.dls.corp.google.com>
References: <20150225185128.GA16569@peff.net>
	<xmqqbnkholx9.fsf@gitster.dls.corp.google.com>
	<20150225191108.GA17467@peff.net>
	<20150227100441.GA11861@tsaunders-iceball.corp.tor1.mozilla.com>
	<xmqqvbilh0wn.fsf@gitster.dls.corp.google.com>
	<20150301130142.GA24782@tsaunders-iceball.corp.tor1.mozilla.com>
	<xmqqr3t8fgm4.fsf@gitster.dls.corp.google.com>
	<20150302125017.GA4464@tsaunders-iceball.corp.tor1.mozilla.com>
	<54F6EB96.6080500@peralex.com>
	<xmqq385k8ot1.fsf@gitster.dls.corp.google.com>
	<20150305052206.GC3344@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Noel Grandin <noel@peralex.com>,
	Trevor Saunders <tbsaunde@tbsaunde.org>,
	Duy Nguyen <pclouds@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 05 07:04:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTOt7-0008GP-Gn
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 07:04:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753066AbbCEGD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 01:03:57 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:55351 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752825AbbCEGD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 01:03:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 31EB232C82;
	Thu,  5 Mar 2015 01:03:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=O9Nsl8q5WJmU/LyGSzk2zNNSGdY=; b=Z4ndmW
	oAwN6+EnWbdnK6oA4+Kc/6O/OIZzWBBLUBfp7ldIoKHTDFQqfLsvoXqqYyau9B05
	nnNak6L4R0ZhD/Qv29LAdS0W2ULIiIXfS23xrIHEAxQYXX1i1CV9Ew7oz0Q3p3P7
	mQNQTw8S+ubba/YgnLP4emFZPibaDc8zBTZoI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=G8upDp7bkgu0z6YgoiH31P+ZON8gGFk/
	1A3ElchKwL9QR+yq68hS16EZlumI8f4zoTxOIRyXtRJK51C3pzUlhGdHT8re2QmG
	LP6e0YaPDGvyN5PxpEtgXRVg1iHf6gGSMbcaWvNhfy6XyCl20g3ti/SsRPl2Lscc
	qcDm0+7B22w=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 29BBC32C81;
	Thu,  5 Mar 2015 01:03:56 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9D54D32C7B;
	Thu,  5 Mar 2015 01:03:55 -0500 (EST)
In-Reply-To: <20150305052206.GC3344@peff.net> (Jeff King's message of "Thu, 5
	Mar 2015 00:22:06 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 68140EE2-C2FD-11E4-8DD0-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264816>

Jeff King <peff@peff.net> writes:

> On Wed, Mar 04, 2015 at 12:56:10PM -0800, Junio C Hamano wrote:
>
>> > As in, while working on a specific project, I sometimes just want to
>> > exclude, for the time being, a bunch of stuff from 'git grep'.
>> 
>> The key word here is "for the time being", though.  What would you
>> do once you are done with the "for the time being" activity?  "git
>> config --unset"?
>
> IMHO this is being too paternalistic. You can already shoot yourself
> in the foot by configuring an alias to grep, running your alias, and
> wondering why it does not produce the results you wanted.

Yeah, as I said, it is a deliberately paternalistic stance.  But at
least when I say "git mygrep" using the alias mechanism and get a
result that is different from what I expect from "git grep", I would
know I am doing something different with "mygrep" from "grep", no?

And a great thing about that "use alias" approach is that we can
sidestep the entire "then what should I do when I have to override
the configured thing for one-shot invocation?" question, as there is
an obvious simple answer "don't use that alias but use the
underlying command".
