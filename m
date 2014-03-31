From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 03/27] parse_arg(): Really test that argument is properly
 terminated
Date: Tue, 01 Apr 2014 00:11:00 +0200
Message-ID: <5339E7F4.1090805@alum.mit.edu>
References: <1395683820-17304-1-git-send-email-mhagger@alum.mit.edu>	<1395683820-17304-4-git-send-email-mhagger@alum.mit.edu> <xmqqlhvq3vaj.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Brad King <brad.king@kitware.com>,
	Johan Herland <johan@herland.net>, Jeff King <peff@peff.net>,
	Vicent Marti <tanoku@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 00:14:11 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WUkQD-0007Ka-6K
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 00:11:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751543AbaCaWLH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Mar 2014 18:11:07 -0400
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:51774 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751191AbaCaWLF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Mar 2014 18:11:05 -0400
X-AuditID: 12074413-f79076d000002d17-12-5339e7f70b80
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id 77.CB.11543.7F7E9335; Mon, 31 Mar 2014 18:11:03 -0400 (EDT)
Received: from [192.168.69.148] (p5B156503.dip0.t-ipconnect.de [91.21.101.3])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s2VMB0G1014265
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Mon, 31 Mar 2014 18:11:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.3.0
In-Reply-To: <xmqqlhvq3vaj.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrGKsWRmVeSWpSXmKPExsUixO6iqPv9uWWwwfPZ2hY710lYdF3pZrJo
	6L3CbDHv7i4mix8tPcwWHzsXMDuweeycdZfd49LL72weH58tZ/d41ruH0ePiJWWPz5vkAtii
	uG2SEkvKgjPT8/TtErgzer4sZiv4rFBxefFX5gbGbVJdjJwcEgImEodXPmOHsMUkLtxbz9bF
	yMUhJHCZUeJL+yRGCOcsk8SiLT+YQKp4BbQlej82g9ksAqoS2xa1g9lsAroSi3og4qICQRKH
	N5xihagXlDg58wkLiC0ioCYxse0QC8hQZoHVjBJLp8wAWsfBISwQK/F2BzfEsjWMEtu//QNr
	4BSwllhz/wIrSI2EgLhET2MQSJhZQEfiXd8DZghbXmL72znMExgFZyFZNwtJ2SwkZQsYmVcx
	yiXmlObq5iZm5hSnJusWJyfm5aUW6Zrr5WaW6KWmlG5ihMSD8A7GXSflDjEKcDAq8fBalFsG
	C7EmlhVX5h5ilORgUhLlffgYKMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmEd+sCoBxvSmJlVWpR
	PkxKmoNFSZxXbYm6n5BAemJJanZqakFqEUxWhoNDSYJXBBj3QoJFqempFWmZOSUIaSYOTpDh
	XFIixal5KalFiaUlGfGgGI4vBkYxSIoHaK8BSDtvcUFiLlAUovUUoy7Hhm1rGpmEWPLy81Kl
	xHl1nwEVCYAUZZTmwa2AJb9XjOJAHwvzCoKM4gEmTrhJr4CWMAEtcSsyA1lSkoiQkmpgtHn2
	XMUrfiHbeXOpiUZHDy6SiJ7q9Vjvy5v9Ic8Mlkiohl00EbgXq/f6Yo5P7ytFk4tt 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245552>

On 03/31/2014 11:36 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Test that the argument is properly terminated by either whitespace or
>> a NUL character, even if it is quoted, to be consistent with the
>> non-quoted case.  Adjust the tests to expect the new error message.
>> Add a docstring to the function, incorporating the comments that were
>> formerly within the function plus some added information.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  builtin/update-ref.c  | 20 +++++++++++++++-----
>>  t/t1400-update-ref.sh |  4 ++--
>>  2 files changed, 17 insertions(+), 7 deletions(-)
>>
>> diff --git a/builtin/update-ref.c b/builtin/update-ref.c
>> index 1292cfe..02b5f95 100644
>> --- a/builtin/update-ref.c
>> +++ b/builtin/update-ref.c
>> @@ -62,16 +62,26 @@ static void update_store_old_sha1(struct ref_update *update,
>>  	update->have_old = *oldvalue || line_termination;
>>  }
>>  
>> +/*
>> + * Parse one whitespace- or NUL-terminated, possibly C-quoted argument
>> + * and append the result to arg.  Return a pointer to the terminator.
>> + * Die if there is an error in how the argument is C-quoted.  This
>> + * function is only used if not -z.
>> + */
>>  static const char *parse_arg(const char *next, struct strbuf *arg)
>>  {
>> -	/* Parse SP-terminated, possibly C-quoted argument */
>> -	if (*next != '"')
>> +	if (*next == '"') {
>> +		const char *orig = next;
>> +
>> +		if (unquote_c_style(arg, next, &next))
>> +			die("badly quoted argument: %s", orig);
>> +		if (*next && !isspace(*next))
>> +			die("unexpected character after quoted argument: %s", orig);
>> +	} else {
>>  		while (*next && !isspace(*next))
>>  			strbuf_addch(arg, *next++);
>> -	else if (unquote_c_style(arg, next, &next))
>> -		die("badly quoted argument: %s", next);
>> +	}
>>  
>> -	/* Return position after the argument */
>>  	return next;
>>  }
>>  
>> diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
>> index 29391c6..774f8c5 100755
>> --- a/t/t1400-update-ref.sh
>> +++ b/t/t1400-update-ref.sh
>> @@ -356,10 +356,10 @@ test_expect_success 'stdin fails on badly quoted input' '
>>  	grep "fatal: badly quoted argument: \\\"master" err
>>  '
>>  
>> -test_expect_success 'stdin fails on arguments not separated by space' '
>> +test_expect_success 'stdin fails on junk after quoted argument' '
>>  	echo "create \"$a\"master" >stdin &&
>>  	test_must_fail git update-ref --stdin <stdin 2>err &&
>> -	grep "fatal: expected SP but got: master" err
>> +	grep "fatal: unexpected character after quoted argument: \\\"$a\\\"master" err
>>  '
> 
> Interesting.
> 
> I would have expected that "We used to check only one of the two
> codepaths and the other was loose, fix it" to be accompanied by "So
> here is an _addition_ to the test suite to validate the other case
> that used to be loose, now tightened", not "We update one existing
> case".  The test before and after the patch is about a c-quoted
> string, so I am not sure if we are still testing the right thing.
> 
> The code in update-ref.c after the patch does look reasonable,
> though.

The old parse_arg(), when fed an argument

    "refs/heads/a"master

parsed 'refs/heads/a' off of the front of the argument and considered
itself successful.  It was only when parse_next_arg() tried to parse the
*next* argument that a problem was noticed.  But in fact, the definition
of the input format requires arguments to be terminated by SP or NUL, so
*this* argument is already erroneous and parse_arg() should diagnose the
problem.

The point of this patch is to move the error detection for C-quoted
arguments that have trailing junk to the parse_arg() call for the broken
argument and to make the error message more descriptive of the situation.

There is no corresponding error case for non-C-quoted arguments, because
the end of the argument is *by definition* a space or NUL, so there is
no way to insert other junk between the "end" of the argument and the
argument terminator.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
