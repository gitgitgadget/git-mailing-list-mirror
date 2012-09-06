From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 5/7] t0000: verify that real_path() works correctly with
 absolute paths
Date: Thu, 06 Sep 2012 23:11:53 +0200
Message-ID: <50491199.8090306@alum.mit.edu>
References: <1346746470-23127-1-git-send-email-mhagger@alum.mit.edu> <1346746470-23127-6-git-send-email-mhagger@alum.mit.edu> <50470FFB.2070204@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Sep 06 23:12:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T9jNA-0006PC-8S
	for gcvg-git-2@plane.gmane.org; Thu, 06 Sep 2012 23:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933225Ab2IFVMA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Sep 2012 17:12:00 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:50912 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933189Ab2IFVL5 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2012 17:11:57 -0400
X-AuditID: 1207440f-b7fde6d00000095c-03-5049119c4fa1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 56.19.02396.C9119405; Thu,  6 Sep 2012 17:11:56 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q86LBsDq021447
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 6 Sep 2012 17:11:55 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <50470FFB.2070204@viscovery.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqDtH0DPAoH+fsUXXlW4mi4beK8wW
	K3/WODB7XLyk7PF5k5zH3f87mQKYo7htkhJLyoIz0/P07RK4M9580Cq4KFAxa4F5A+NR3i5G
	Tg4JAROJ/z/6WCBsMYkL99azdTFycQgJXGaUePPvEBOEc4xJYv2HHewgVbwC2hJXXp1iBrFZ
	BFQlWmfcAYuzCehKLOppZgKxRQVCJGZcnswMUS8ocXLmE7ANIgIaErtP94LVMwtYS6x4fRis
	XlggVuLS+dWsEMvmMUpMnrASLMEJNHTX7ymMEA26Ej+aVrJB2PIS29/OYZ7AKDALyY5ZSMpm
	ISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXRC83s0QvNaV0EyMkcPl3MHatlznEKMDB
	qMTDa3TWI0CINbGsuDL3EKMkB5OSKK8Yt2eAEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHeib+A
	ynlTEiurUovyYVLSHCxK4rzqS9T9hATSE0tSs1NTC1KLYLIyHBxKErxHBYCGChalpqdWpGXm
	lCCkmTg4QYZzSYkUp+alpBYllpZkxIMiNb4YGKsgKR6gvY9A2nmLCxJzgaIQracYdTnuflxx
	n1GIJS8/L1VKnHcVSJEASFFGaR7cCliaesUoDvSxMO9kkCoeYIqDm/QKaAkT0BKRZyDPFZck
	IqSkGhhTxLZ2XpB+8J5xho59rcyjZ1f1935hct5x5UrBHumTh7K7DErLJm2w7EtdXX0pP+3V
	pzr1sk13Mt4Evjy7cu5fg72nLZ3/rk7oes4wI+9CRrHa9YwkzY33m6ZoT91w/LHP 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204925>

On 09/05/2012 10:40 AM, Johannes Sixt wrote:
> Am 9/4/2012 10:14, schrieb mhagger@alum.mit.edu:
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
> 
> These tests should really be in t0060-path-utils.sh.
> 
>> -test_expect_success SYMLINKS 'real path works as expected' '
>> +test_expect_failure 'real path works on absolute paths' '
>> +	nopath="hopefully-absent-path" &&
>> +	test "/" = "$(test-path-utils real_path "/")" &&
>> +	test "/$nopath" = "$(test-path-utils real_path "/$nopath")" &&
> 
> These tests fail on Windows because test-path-utils operates on a
> DOS-style absolute path even if a POSIX style absolute path is passed as
> argument. The best thing would be to move this to a separate test that is
> protected by a POSIX prerequisite (which is set in t0060).
> 
>> +	# Find an existing top-level directory for the remaining tests:
>> +	d=$(pwd -P | sed -e "s|^\(/[^/]*\)/.*|\1|") &&
> 
> pwd -P actually expands to pwd -W on Windows, and produces a DOS-style
> path. I suggest to insert [^/]* to skip drive letter-colon like so:
> 
> 	d=$(pwd -P | sed -e "s|^\([^/]*/[^/]*\)/.*|\1|") &&
> 
>> +	test "$d" = "$(test-path-utils real_path "$d")" &&
>> +	test "$d/$nopath" = "$(test-path-utils real_path "$d/$nopath")"
> 
> Then these tests pass.

Thanks for the help.  They will be incorporated in v2.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
