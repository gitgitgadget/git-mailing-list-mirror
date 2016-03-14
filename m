From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [ANNOUNCE] Git v2.8.0-rc2
Date: Mon, 14 Mar 2016 11:10:52 -0700
Message-ID: <xmqqvb4p9bgz.fsf@gitster.mtv.corp.google.com>
References: <xmqqr3fiaq9f.fsf@gitster.mtv.corp.google.com>
	<006DA180-E4B6-404E-9377-F2BB41F65591@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org list" <git@vger.kernel.org>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Mon Mar 14 19:11:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afWxO-0000aD-5A
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 19:11:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755324AbcCNSK7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 14:10:59 -0400
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:55350 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755296AbcCNSK4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 14:10:56 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A153F4B440;
	Mon, 14 Mar 2016 14:10:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=h4oX4/jGbI2mTgzE56EGuIZ1cFA=; b=E47vRZ
	4Hlf7pw7HLdk9ZEV7bHUN7P3IEr4gbGDRNDiTwM1nEVK4/DyXhYvd+o2NGTjaEtW
	0WJY7knVlDclDLgFpvVw9F+6VjT9Ngx6jw0D0XVm2eB8l5nIeSi4888j6euIg0+O
	FVzFzFlGuyyg3aREKcAnrxXl5muTrw7uQSh0M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=T8wkaeiuy2EoUxxWmAyKYXOE2iij096+
	Io6vjN++hn73vNvrtYzpPJ8L+rD2qsOVZF5XjkiRvILXwmcY02OAfUYKRG8I9Vpc
	lCy7Bt6ggqAoEL5tb6LO9Zwk9R4JFnIHAIaYpWFcPDTQCUSJ6ASkuJGcjtpuWzDh
	pJAD064L5GI=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8C97C4B43F;
	Mon, 14 Mar 2016 14:10:54 -0400 (EDT)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id EFE424B43E;
	Mon, 14 Mar 2016 14:10:53 -0400 (EDT)
In-Reply-To: <006DA180-E4B6-404E-9377-F2BB41F65591@quendi.de> (Max Horn's
	message of "Sat, 12 Mar 2016 10:11:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 178A17EC-EA10-11E5-8CD2-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288795>

Max Horn <max@quendi.de> writes:

>> On 11 Mar 2016, at 00:04, Junio C Hamano <gitster@pobox.com> wrote:
>> ...
>> * "branch --delete" has "branch -d" but "push --delete" does not.
>
> This states a problem, but not whether (and how) it was resolved?

Thanks; how about

 * "push" learned that its "--delete" option can be shortened to
   "-d", just like "branch --delete" and "branch -d" are the same
   thing.

>> * Across the transition at around Git version 2.0, the user used to
>>   get a pretty loud warning when running "git push" without setting
>>   push.default configuration variable.  We no longer warn, given that
>>   the transition is over long time ago.
>
> That last sentence sounds weird... perhaps "the transition was
> completed a long time ago" ? Or "the transition ended a long time
> ago" ?

 * ... We no longer warn because the transition was completed a long
   time ago.

>> * A slight update to the Makefile to mark "phoney" targets
>>   as such correctly.
>
> phoney -> phony?

Thanks for sharp eyes.

>> * Some calls to strcpy(3) triggers a false warning from static
>>   analysers that are less intelligent than humans, and reducing the
>>   number of these false hits helps us notice real issues.  A few
>>   calls to strcpy(3) in test-path-utils that are already safe has
>>   been rewritten to avoid false wanings.
>> 
>> * Some calls to strcpy(3) triggers a false warning from static
>>   analysers that are less intelligent than humans, and reducing the
>>   number of these false hits helps us notice real issues.  A few
>>   calls to strcpy(3) in "git rerere" that are already safe has been
>>   rewritten to avoid false wanings.
>
> The above two messages are very similar, only the end differs a bit.

That's deliberate as they are two different fixes to a similar
problems.  We can just omit the names of the components to make them
into one entry if we really wanted to.

>> * Asking gitweb for a nonexistent commit left a warning in the server
>>   log.
>> 
>>   Somebody may want to follow this up with an additional test, perhaps?
>>   IIRC, we do test that no Perl warnings are given to the server log,
>>   so this should have been caught if our test coverage were good.
>
> That last paragraph seems odd for a changelog?

I do not think it is wrong to leave a reminder to ourselves that
there are yet more work need to be done.

>> * The underlying machinery used by "ls-files -o" and other commands
>>   have been taught not to create empty submodule ref cache for a
>
> have -> has (the machinery is singular)

Again, thanks for sharp eyes.
