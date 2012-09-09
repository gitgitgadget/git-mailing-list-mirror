From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 5/7] t0000: verify that real_path() works correctly with
 absolute paths
Date: Sun, 09 Sep 2012 06:31:06 +0200
Message-ID: <504C1B8A.3000406@alum.mit.edu>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu> <1346746470-23127-6-git-send-email-mhagger@alum.mit.edu> <7v627q21hl.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 09 06:32:07 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAZBm-0004tK-DF
	for gcvg-git-2@plane.gmane.org; Sun, 09 Sep 2012 06:32:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206Ab2IIEbP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Sep 2012 00:31:15 -0400
Received: from ALUM-MAILSEC-SCANNER-1.MIT.EDU ([18.7.68.12]:47940 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750888Ab2IIEbO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Sep 2012 00:31:14 -0400
X-AuditID: 1207440c-b7f616d00000270b-a4-504c1b91473c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 62.D8.09995.19B1C405; Sun,  9 Sep 2012 00:31:13 -0400 (EDT)
Received: from [192.168.69.140] (p57A25CBD.dip.t-dialin.net [87.162.92.189])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q894V9FY025316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Sep 2012 00:31:11 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7v627q21hl.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprHKsWRmVeSWpSXmKPExsUixO6iqDtR2ifAYPlfcYuuK91MFg29V5gt
	nsy9y+zA7PHwVRe7x8VLyh6fN8kFMEdx2yQllpQFZ6bn6dslcGf8ermEveA2f0XfrveMDYzn
	eboYOTkkBEwkHizczQRhi0lcuLeerYuRi0NI4DKjxIsN/1ghnNNMEptvHQSr4hXQljhy/wcj
	iM0ioCox7cs7dhCbTUBXYlFPM1iNqECIxIzLk5kh6gUlTs58wgJiiwioSUxsOwRmMwuYStx6
	OJMNxBYWiJW4dH411LLljBI/etaANXMKmEksmvGEFaJBR+Jd3wNmCFteYvvbOcwTGAVmIdkx
	C0nZLCRlCxiZVzHKJeaU5urmJmbmFKcm6xYnJ+blpRbpGurlZpbopaaUbmKEhC/PDsZv62QO
	MQpwMCrx8DLf8Q4QYk0sK67MPcQoycGkJMqrJekTIMSXlJ9SmZFYnBFfVJqTWnyIUYKDWUmE
	9yo7UI43JbGyKrUoHyYlzcGiJM6rukTdT0ggPbEkNTs1tSC1CCYrw8GhJMHbIwXUKFiUmp5a
	kZaZU4KQZuLgBBnOJSVSnJqXklqUWFqSEQ+K1vhiYLyCpHiA9paBtPMWFyTmAkUhWk8x6nLc
	/bjiPqMQS15+XqqUOG80SJEASFFGaR7cCliyesUoDvSxMO98kCoeYKKDm/QKaAkT0BKRZx4g
	S0oSEVJSDYy+XTuSPJjXO8yM01P/4Djzo2+R+Zz7rvNS66S0bp3pM/7OKSihZVPO9EXjeuqW
	wkreXRMXLf7LlRqmcVpANjJT6ZHjHgbZc397dviGPmxr2qfKN4N9no7Szqt/uD7X 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205036>

On 09/07/2012 01:08 AM, Junio C Hamano wrote:
> mhagger@alum.mit.edu writes:
> 
>> From: Michael Haggerty <mhagger@alum.mit.edu>
>>
>> There is currently a bug: if passed an absolute top-level path that
>> doesn't exist (e.g., "/foo") it incorrectly interprets the path as a
>> relative path (e.g., returns "$(pwd)/foo").  So mark the test as
>> failing.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  t/t0000-basic.sh | 12 +++++++++++-
>>  1 file changed, 11 insertions(+), 1 deletion(-)
>>
>> diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
>> index 1a51634..ad002ee 100755
>> --- a/t/t0000-basic.sh
>> +++ b/t/t0000-basic.sh
>> @@ -458,7 +458,17 @@ test_expect_success 'real path rejects the empty string' '
>>  	test_must_fail test-path-utils real_path ""
>>  '
>>  
>> -test_expect_success SYMLINKS 'real path works as expected' '
>> +test_expect_failure 'real path works on absolute paths' '
>> +	nopath="hopefully-absent-path" &&
>> +	test "/" = "$(test-path-utils real_path "/")" &&
>> +	test "/$nopath" = "$(test-path-utils real_path "/$nopath")" &&
> 
> You could perhaps do
> 
> 	sfx=0 &&
>         while test -e "/$nopath$sfx"
>         do
> 		sfx=$(( $sfx + 1 ))
> 	done && nopath=$nopath$sfx &&
> 	test "/$nopath" = "$(test-path-utils real_path "/$nopath")" &&
> 
> if you really cared.

The possibility is obvious.  Are you advocating it?

I considered that approach, but came to the opinion that it would be
overkill that would only complicate the code for no real advantage,
given that (1) I picked a name that is pretty implausible for an
existing file, (2) the test suite only reads the file, never writes it
(so there is no risk that a copy from a previous run gets left behind),
(3) it's only test suite code, and any failures would have minor
consequences.

Please let me know if you assess the situation differently.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
