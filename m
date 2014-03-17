From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] test-lib.sh: use printf instead of echo
Date: Mon, 17 Mar 2014 12:26:42 -0700
Message-ID: <xmqq61nceidp.fsf@gitster.dls.corp.google.com>
References: <20140314235735.GA6959@ibr.ch> <20140315001855.GK15625@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Uwe Storbeck <uwe@ibr.ch>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 17 20:26:52 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WPdBT-0001pv-O7
	for gcvg-git-2@plane.gmane.org; Mon, 17 Mar 2014 20:26:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbaCQT0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2014 15:26:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47293 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750749AbaCQT0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2014 15:26:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4D3E276898;
	Mon, 17 Mar 2014 15:26:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=+w2E7TSh9B2FEnWWK6jmc4Ad8ak=; b=nvgqGK
	ieEIBfL4ciblWYp5UligRV22ayu7pM5Fh9EggV8gmF/o84/DdvZQB3BKMu70A0xu
	rW3Lwu4xDQ5AG6+09VixLjNIootzAcN9S46N3tWnSceFFKol5BuYFbIyNxdM31VP
	M5/ferP8T3kGcTD1i9XOz2RVz0stLzdS6/NGk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=fBciI2E9vUNdUXUf3Rzxw0CNpmNGjr78
	B4oYX3XlHj3EZjINi8GqA2xUGEicRDbdOaalNIoqFKM9Hn+r92zQcC+QRW26RRek
	kNlwEe4ayeSUdSLS+uE+uq5nHKMXyohVArFhToUvLv+dF1uN5JZh1bk+pSKs8OOa
	nMZ6Mr4ZLxs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 38C6876896;
	Mon, 17 Mar 2014 15:26:46 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8C59A76894;
	Mon, 17 Mar 2014 15:26:45 -0400 (EDT)
In-Reply-To: <20140315001855.GK15625@google.com> (Jonathan Nieder's message of
	"Fri, 14 Mar 2014 17:18:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 13C55A98-AE0A-11E3-B994-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244271>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Uwe Storbeck wrote:
>
>> Backslash sequences are interpreted as control characters
>> by the echo command of some shells (e.g. dash).
>
> This has bothered me for a while but never enough to do anything about
> it.  Thanks for fixing it.
>
>> Signed-off-by: Uwe Storbeck <uwe@ibr.ch>
>
> Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>
>
> (patch left unsnipped for reference)
>> ---
>>  t/test-lib.sh | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>> 
>> diff --git a/t/test-lib.sh b/t/test-lib.sh
>> index 1531c24..8209204 100644
>> --- a/t/test-lib.sh
>> +++ b/t/test-lib.sh
>> @@ -277,7 +277,7 @@ error "Test script did not set test_description."
>>  
>>  if test "$help" = "t"
>>  then
>> -	echo "$test_description"
>> +	printf '%s\n' "$test_description"
>>  	exit 0
>>  fi
>>  
>> @@ -328,7 +328,7 @@ test_failure_ () {
>>  	test_failure=$(($test_failure + 1))
>>  	say_color error "not ok $test_count - $1"
>>  	shift
>> -	echo "$@" | sed -e 's/^/#	/'
>> +	printf '%s\n' "$@" | sed -e 's/^/#	/'

This is wrong, isn't it?  Why do we want one line per item here?

>>  	test "$immediate" = "" || { GIT_EXIT_OK=t; exit 1; }
>>  }
>>  
