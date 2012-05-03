From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 08/18] do_for_each_reflog(): use a strbuf to hold logfile
 name
Date: Thu, 03 May 2012 08:47:53 +0200
Message-ID: <4FA22A19.1030009@alum.mit.edu>
References: <1335479227-7877-1-git-send-email-mhagger@alum.mit.edu> <1335479227-7877-9-git-send-email-mhagger@alum.mit.edu> <xmqqaa1y6poq.fsf@junio.mtv.corp.google.com> <4F9A5FE6.40409@alum.mit.edu> <7vwr4ugxel.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 03 08:55:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPpwO-0006ca-KW
	for gcvg-git-2@plane.gmane.org; Thu, 03 May 2012 08:55:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753249Ab2ECGy7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 May 2012 02:54:59 -0400
Received: from ALUM-MAILSEC-SCANNER-6.MIT.EDU ([18.7.68.18]:50519 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752455Ab2ECGy6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 May 2012 02:54:58 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 May 2012 02:54:58 EDT
X-AuditID: 12074412-b7f1c6d00000092d-b3-4fa22a1c12fa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 58.5E.02349.C1A22AF4; Thu,  3 May 2012 02:47:56 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q436lr3U022954
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 3 May 2012 02:47:54 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:11.0) Gecko/20120410 Thunderbird/11.0.1
In-Reply-To: <7vwr4ugxel.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCKsWRmVeSWpSXmKPExsUixO6iqCujtcjfoHm/hcWm5xOZLbqudDNZ
	NPReYbZY+fgus8WKq3OYLebd3cVk8aOlh9mB3WPnrLvsHpdefmfzaH//jtnjWe8eRo+Ll5Q9
	lj94xe7xeZNcAHsUt01SYklZcGZ6nr5dAnfG57cnWQueslUsem/YwLiQtYuRk0NCwESifcd1
	NghbTOLCvfVANheHkMBlRomnExZBOceYJH5N/M4CUsUroC1x+uJGdhCbRUBV4uOjM2BxNgFd
	iUU9zUwgtqhAmET/7S1MEPWCEidnPgGrERFQk5jYdogFZCizwANGietPvoElhAXCJbY1/2KE
	2PaBUaJ75gVGkASngJnE9O+rgCZxAHVYS3zbXQQSZhaQl9j+dg7zBEaBWUh2zEKomoWkagEj
	8ypGucSc0lzd3MTMnOLUZN3i5MS8vNQiXTO93MwSvdSU0k2MkFgQ2sG4/qTcIUYBDkYlHl6m
	qIX+QqyJZcWVuYcYJTmYlER58zUW+QvxJeWnVGYkFmfEF5XmpBYfYpTgYFYS4VVrAyrnTUms
	rEotyodJSXOwKInz/lys7ickkJ5YkpqdmlqQWgSTleHgUJLgzdEEGipYlJqeWpGWmVOCkGbi
	4AQZziUlUpyal5JalFhakhEPitT4YmCsgqR4gPaGgLTzFhck5gJFIVpPMepyzF6y9SqjEEte
	fl6qlDivD0iRAEhRRmke3ApY4nvFKA70sTDEKB5g0oSb9ApoCRPQknzzeSBLShIRUlINjPIn
	Q3YZF5zXnfq/JmGtT/oldd5dAi0L/3t8UVOO7NUsaF84ce+B1/tvz8x8OHvdwQgu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196888>

On 05/02/2012 10:06 PM, Junio C Hamano wrote:
> Michael Haggerty<mhagger@alum.mit.edu>  writes:
>
>> On 04/27/2012 01:25 AM, Junio C Hamano wrote:
>>> Please write this like this:
>>>
>>> 		if (...) {
>>> 			; /* silently ignore */
>>> 		}
>>>
>>> to make the "emptyness" stand out (I amended the previous round when I
>>> queued them to 'pu', but I forgot to point it out in my review message).
>>
>> OK.  A similar construct is in patch 2 of the same series.  I've fixed
>> them in my repo and will use the fixed versions if there are any
>> future re-rolls.
>
> OK.  Has there been any re-roll I missed, or is what I have in 'pu' with
> fixups ready for 'next'?

I haven't gotten any other feedback, so as far as I'm concerned, it's 
ready for next.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
