From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] t3400 (rebase): don't set GIT_AUTHOR_{NAME,EMAIL}
Date: Fri, 10 May 2013 10:34:17 -0700
Message-ID: <7vr4he20yu.fsf@alter.siamese.dyndns.org>
References: <1368196178-5807-1-git-send-email-artagnon@gmail.com>
	<1368196178-5807-2-git-send-email-artagnon@gmail.com>
	<CAPig+cSW39bnmKOeNDz0H5ZyNzPt3oCLnCUttaMJU9fGuKvJeQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 10 19:34:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UarD7-0005rU-Mg
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 19:34:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756350Ab3EJReV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 May 2013 13:34:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62444 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754079Ab3EJReU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 May 2013 13:34:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DA19B1DF55;
	Fri, 10 May 2013 17:34:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=0maPALolI9q/XBO/ha7nPOt9NnM=; b=lapRl9
	7aEG7xnmTI1tW0VmXMB3cQ5fr6LvKYAjtKO8Wm4I2CQUDAfC2T3/QQ0KSzE/+hbH
	CxTPwAGI9a7ogJyjTzvAdImpE4HbeS1rEqqQn9xFA630VtBib5go6QsJ6tvaKgM0
	kWyBYYtH5GaDTARGRmA89FhUVL+kiIIP0c3s8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=RWeNUr5XNnXaDUiHMvkstX96jnRdhy8S
	cOPQjvYP17nLmqjL2vMj3P2z4AC7uwfV5ACukCI/gcbCMg7IzQfkenrXHp3OS/GA
	1AzzE2glRDE80nVYTy1wKjmi3ee3uBUmFT3hxuhUC6ugllBU8ilyHLjOGCxenlMf
	xNls72J0jW0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CF1941DF54;
	Fri, 10 May 2013 17:34:19 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 31DD01DF52;
	Fri, 10 May 2013 17:34:19 +0000 (UTC)
In-Reply-To: <CAPig+cSW39bnmKOeNDz0H5ZyNzPt3oCLnCUttaMJU9fGuKvJeQ@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 10 May 2013 10:53:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D82670BA-B997-11E2-BF17-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223883>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Fri, May 10, 2013 at 10:29 AM, Ramkumar Ramachandra
> <artagnon@gmail.com> wrote:
>> test-lib.sh already sets a sane GIT_AUTHOR_{NAME,EMAIL} for all test
>> scripts to use.  Don't unnecessarily duplicate the work.
>>
>> Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
>> ---
>>  t/t3400-rebase.sh | 4 ----
>>  1 file changed, 4 deletions(-)
>>
>> diff --git a/t/t3400-rebase.sh b/t/t3400-rebase.sh
>> index b58fa1a..a7ca2f1 100755
>> --- a/t/t3400-rebase.sh
>> +++ b/t/t3400-rebase.sh
>> @@ -10,10 +10,6 @@ among other things.
>>  '
>>  . ./test-lib.sh
>>
>> -GIT_AUTHOR_NAME=author@name
>> -GIT_AUTHOR_EMAIL=bogus@email@address
>
> These values are intentionally bogus. Doesn't this change defeat the
> purpose of 43c2325 (am: use get_author_ident_from_commit instead of
> mailinfo when rebasing; 2010-06-16)?
>
>> -export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL
>> -

Then perhaps there needs an in-code comment before these three lines
to explain why they are deliberately set to bogus values, no?
