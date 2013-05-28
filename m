From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/5] test: improve rebase -q test
Date: Tue, 28 May 2013 10:28:46 -0700
Message-ID: <7vfvx710a9.fsf@alter.siamese.dyndns.org>
References: <1369745671-22418-1-git-send-email-felipe.contreras@gmail.com>
	<1369745671-22418-5-git-send-email-felipe.contreras@gmail.com>
	<7vvc6311dr.fsf@alter.siamese.dyndns.org>
	<20130528171907.GA28153@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Neil Horman <nhorman@tuxdriver.com>,
	Christian Couder <chriscool@tuxfamily.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 19:28:55 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhNhe-0004R1-1Y
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 19:28:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785Ab3E1R2u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 13:28:50 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59599 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934735Ab3E1R2t (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 13:28:49 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1222723658;
	Tue, 28 May 2013 17:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aiUX6JsHF83rhQr5nz60r4dObq4=; b=UAvCLP
	Be9CfuJ6SBkJa6a1ywJfuAHMkRCKdA5InyC7z6Soh4eDHjiVhNlBMDsh3aJdxe9i
	y7j6wa+fOpOhkxJphxY1HJjKdhS9pWqSjqw5JIfa0ehTL0c5NtPvezv6zdOB0mVI
	GLKrbCQgRnHjoxcB8YqRx1IyfnB0NzPeCHhjo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Elam1b2vE1vhvipdk2HWP4RwYqaX1wNZ
	8/7nmLvDipVHkQ0jD+zM5S26X1PVxznCMjluDqFMbzm8q/kMaPZXyvRcVkEcS9Jz
	qjsav+MjUacBJFQ8etwL0Igm4rCPvcPrD88MxARfjpfPLMQqhTuOgWqscbRocDOX
	pf+YdwcWN6c=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 07DC623657;
	Tue, 28 May 2013 17:28:49 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 67A2F23655;
	Tue, 28 May 2013 17:28:48 +0000 (UTC)
In-Reply-To: <20130528171907.GA28153@google.com> (Jonathan Nieder's message of
	"Tue, 28 May 2013 10:19:07 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0E6D045E-C7BC-11E2-AFBB-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225673>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Junio C Hamano wrote:
>
>> A more preferrable alternative may be adding something like this to
>> test-lib.sh and call it from here and elsewhere (there are about 50
>> places that do "test ! -s <filename>"), perhaps?
>>
>>         test_must_be_an_empty_file () {
>>                 if test -s "$1"
>>                 then
>>                         cat "$1"
>>                         false
>>                 fi
>>         }
>
> I generally just use the two-liner
>
> 	>empty &&
> 	test_cmp empty output
>
> directly in cases like this.

That would work, too.
