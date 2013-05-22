From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v6] Add new git-related helper to contrib
Date: Wed, 22 May 2013 15:38:12 -0700
Message-ID: <7vd2siiqsr.fsf@alter.siamese.dyndns.org>
References: <1368978823-18247-1-git-send-email-felipe.contreras@gmail.com>
	<7vr4gyizti.fsf@alter.siamese.dyndns.org>
	<CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 23 00:38:23 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UfHfo-00077r-Em
	for gcvg-git-2@plane.gmane.org; Thu, 23 May 2013 00:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757550Ab3EVWiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 18:38:16 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35005 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756999Ab3EVWiP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 18:38:15 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8E68D219DE;
	Wed, 22 May 2013 22:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=2QM61EMNK5f7D6smulbT140OcCs=; b=x40KBQ
	/W5HuFHssysuJUspW9TDnLaRjV4uGWGHAD97lG+YC1HqpPUsPxqJYnuyToS3tTV4
	GT6vy9AhYbGj1lxWxI/PExFV6X4Eqlc2ORYKjJihpJgq4PWrH5OtOAEi5KhnlKc+
	iKg4mSH7vvVXmlfL6hPot1tcBS800KB+lruC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=OL42rDQ3a+AaK4uT2SekfNXNJag93ro9
	icy1BBO0eADl7/WoVuzmxbtbfm8UzVx8UdRYFKDVfyrzG2Nr/QFMR4xUAa33iWRa
	nJdki+lSzOj7aMn0jORIuWg1F6T0s7aczC28/JNqHIH6ul5ITWlyEr6d2FcmRoIM
	CYnfJC/50KQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 820CD219DD;
	Wed, 22 May 2013 22:38:14 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E5C72219DB;
	Wed, 22 May 2013 22:38:13 +0000 (UTC)
In-Reply-To: <CAMP44s0pXLmjVUwsVWiN2G5QReh80spXjvy_6GuUGRz1RmUbLQ@mail.gmail.com>
	(Felipe Contreras's message of "Wed, 22 May 2013 17:23:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 49DC0FE8-C330-11E2-BDB1-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225200>

Felipe Contreras <felipe.contreras@gmail.com> writes:

>> Depending on the nature of the change in question, it may match well
>> or worse to what you are trying to find out.  When you are trying to
>> say "What were you smoking when you implemented this broken logic?",
>> using -C may be good, but when your question is "Even though all the
>> callers of this function live in that other file, somebody moved
>> this function that used to be file static in that file to here and
>> made it public. Why?", you do not want to use -C.
>>
>> I am reasonably sure that in the finished code later in the series
>> it will become configurable, but a fallback default is better to be
>> not so expensive one.
>
> The script's purpose is to find related commits, -CCC does that, does it not?

As I already said in the above, the answer is no, when you are
trying to find who moved the code from the original place.

>> Makes sense to start from the preimage so that you can find out who
>> wrote the original block of lines your patch is removing.
>>
>> But then if source is /dev/null, wouldn't you be able to stop
>> without running blame at all?  You know the patch is creating a new
>> file at that point and there is nobody to point a finger at.
>
> A patch can touch multiple files.

So?

What line range would you be feeding "blame" with, for such a file
creation event?
