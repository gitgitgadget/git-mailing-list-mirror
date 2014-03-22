From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 03/10] t4018: an infrastructure to test hunk headers
Date: Sat, 22 Mar 2014 07:56:17 +0100
Message-ID: <532D3411.2000109@kdbg.org>
References: <53282741.5010609@web.de> <cover.1395433874.git.j6t@kdbg.org>	<52505977c20a480941ae1f85f50ffb7a0bbffedb.1395433874.git.j6t@kdbg.org> <xmqqk3bnrz3m.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Brandon Casey <drafnel@gmail.com>,
	git@vger.kernel.org, Thomas Rast <tr@thomasrast.ch>, l.s.r@web.de,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 22 07:56:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WRFr1-0008JG-F2
	for gcvg-git-2@plane.gmane.org; Sat, 22 Mar 2014 07:56:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750883AbaCVG4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 22 Mar 2014 02:56:22 -0400
Received: from bsmtp2.bon.at ([213.33.87.16]:27193 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750853AbaCVG4W (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 22 Mar 2014 02:56:22 -0400
X-Greylist: delayed 35297 seconds by postgrey-1.27 at vger.kernel.org; Sat, 22 Mar 2014 02:56:21 EDT
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id AD94813004B;
	Sat, 22 Mar 2014 07:56:18 +0100 (CET)
Received: from dx.sixt.local (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 8343C19F6A4;
	Sat, 22 Mar 2014 07:56:17 +0100 (CET)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqqk3bnrz3m.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244762>

Am 21.03.2014 23:00, schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> Add an infrastructure that simplifies adding new tests of the hunk
>> header regular expressions.
>>
>> To add new tests, a file with the syntax to test can be dropped in the
>> directory t4018. The README file explains how a test file must contain;
> 
> s/how/what/, or "how a test file must be written" you mean?

I do mean one of those, preferably the latter ;)

>> -for p in ada bibtex cpp csharp fortran html java matlab objc pascal perl php python ruby tex
>> +diffpatterns="
>> +	ada
>> +	bibtex
>> +	cpp
>> +	csharp
>> +	fortran
>> +	html
>> +	java
>> +	matlab
>> +	objc
>> +	pascal
>> +	perl
>> +	php
>> +	python
>> +	ruby
>> +	tex
>> +"
>> +
>> +for p in $diffpatterns
>>  do
>>  	test_expect_success "builtin $p pattern compiles" '
>>  		echo "*.java diff=$p" >.gitattributes &&
> 
> I always found this "Let's apply rules for language $p to these
> *.java files" strange.  I have wonder if it makes sense to further
> change the framework to read the name of the rule to be applied from
> the file in t/t4018/ directory, instead of using filename that is
> the same as the name of the rule?  That way, you can list the files
> in t/t4018/ directory to come up with the above list, without having
> to maintain the list of rules separately like the above.

I see what you mean. Notice, however, that we also test whether the
regular expressions can be compiled successfully, and for this it is
desirable to have the complete list of userdiff drivers. Until we have
at least one test-case for each driver, we wouldn't get the complete
list. In summary, I do agree that a bit more automation is also
desirable, but we are not there, yet.

-- Hannes
