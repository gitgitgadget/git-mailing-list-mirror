From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] parse-options.c:parse_options_check() change OPTION_NUMBER to OPTION_CMDMODE
Date: Fri, 28 Feb 2014 11:42:30 -0800
Message-ID: <xmqq1tynuiqh.fsf@gitster.dls.corp.google.com>
References: <1393578442-2822-1-git-send-email-sunheehnus@gmail.com>
	<531061D1.2060206@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sun He <sunheehnus@gmail.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Fri Feb 28 20:42:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJTKR-0008A8-Oj
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 20:42:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752139AbaB1Tmg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 14:42:36 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54337 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751911AbaB1Tmf (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 14:42:35 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 760CE6EF6C;
	Fri, 28 Feb 2014 14:42:34 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=BlV7TwArzNk1Y+GRrJ40Wz34XC8=; b=YZYvc0
	y0/yxFwTsGIqwO7LAdrl2fPk+5NH7wdqsniQz145zswlbltzNQLbfqmdvzESDl8J
	58D6wWdDhHY51GWeYzG1zxMtx8Bc29SAudIhT6E7lJWw21PxkC6h5O8luqh4qJ3N
	7kXqsGpVxOAYEzU9bMf7XSQu6IkeLPiOPfCXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=heQ/RMsAdBEI3VqcDtWGNL9TPqA7SEu7
	qaKPKjTMr+zAnWRl9zYul1aMkIYesikc+ajYkjxCZ3IbrQrGcAvxbp650+z4XfXV
	BhrHIGwGPol7JdG9Q92ALoVbcAjf0tk/LICx/rOhGUvJgmwrHW/+sim/AxZcv7tn
	b2Eu2LdjBaI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4EFEA6EF6A;
	Fri, 28 Feb 2014 14:42:34 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 8F2B66EF67;
	Fri, 28 Feb 2014 14:42:33 -0500 (EST)
In-Reply-To: <531061D1.2060206@alum.mit.edu> (Michael Haggerty's message of
	"Fri, 28 Feb 2014 11:15:45 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 77CE858A-A0B0-11E3-8C7A-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243009>

Michael Haggerty <mhagger@alum.mit.edu> writes:

> On 02/28/2014 10:07 AM, Sun He wrote:
>> Signed-off-by: Sun He <sunheehnus@gmail.com>
>> ---
>>  parse-options.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/parse-options.c b/parse-options.c
>> index 7b8d3fa..59a52b0 100644
>> --- a/parse-options.c
>> +++ b/parse-options.c
>> @@ -371,7 +371,7 @@ static void parse_options_check(const struct option *opts)
>>  		case OPTION_NEGBIT:
>>  		case OPTION_SET_INT:
>>  		case OPTION_SET_PTR:
>> -		case OPTION_NUMBER:
>> +		case OPTION_CMDMODE:
>>  			if ((opts->flags & PARSE_OPT_OPTARG) ||
>>  			    !(opts->flags & PARSE_OPT_NOARG))
>>  				err |= optbug(opts, "should not accept an argument");
>> 
>> -- 
>> 1.9.0.138.g2de3478.dirty
>> 
>> Hi,
>> When I was reading code yesterday, I came across this protential bug.
>> parse-options.h says that OPTION_CMDMODE is an option with no arguments and OPTION_NUMBER is special type option.

Please, no overlong line in the text part that makes things
unnecessarily hard to read.

I agree with all the comments in the message I am responding to.

> BTW, none of my comments should be taken to indicate whether the commit
> itself makes sense or not.  I haven't checked that far.

While I think it is sensible to make sure CMDMODE is not marked to
allow arguments, I do not understand why "special type" would imply
"it is allowed to be marked to take an argument".  Why is it a
good change to remove "case OPTION_NUMBER:" here?
