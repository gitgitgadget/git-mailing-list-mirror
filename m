From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 03/13] delete_ref(): handle special case more explicitly
Date: Tue, 09 Jun 2015 12:17:31 +0200
Message-ID: <5576BD3B.1060005@alum.mit.edu>
References: <cover.1433763494.git.mhagger@alum.mit.edu>	<1a8670c63b4e8b3b2f99d0e1acbb18162111f166.1433763494.git.mhagger@alum.mit.edu> <CAGZ79kZvmf0WWEAHb5Hq6o5ayu7ADxQoAS4xsewoc==VEHKoPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 09 12:17:41 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z2GbD-0004F8-Nj
	for gcvg-git-2@plane.gmane.org; Tue, 09 Jun 2015 12:17:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752106AbbFIKRg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2015 06:17:36 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:55982 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753171AbbFIKRe (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 9 Jun 2015 06:17:34 -0400
X-AuditID: 12074412-f79066d000000bc5-c7-5576bd3d7ec2
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 43.45.03013.D3DB6755; Tue,  9 Jun 2015 06:17:34 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97525.dip0.t-ipconnect.de [79.201.117.37])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t59AHWgh015667
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 9 Jun 2015 06:17:33 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.7.0
In-Reply-To: <CAGZ79kZvmf0WWEAHb5Hq6o5ayu7ADxQoAS4xsewoc==VEHKoPw@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprOKsWRmVeSWpSXmKPExsUixO6iqGu3tyzUYKadRdeVbiaLht4rzBY/
	WnqYLTZvbmdxYPFYsKnU41nvHkaPi5eUPT5vkgtgieK2SUosKQvOTM/Tt0vgzvizcw5jwT2u
	igW3ljM1MG7i6GLk4JAQMJE48k6+i5ETyBSTuHBvPVsXIxeHkMBlRokH5y4xQTjnmCS2f/rB
	DFLFK6AtsfxlKxOIzSKgKvHjXQ8biM0moCuxqKeZCWSoqECQxOuXuRDlghInZz5hAbFFBNQk
	Zq6aDVbOLFAu8efyInYQW1jAR2LG/rdgcSGB04wSCzcWg9icAoESc/p+MUPUq0v8mXcJypaX
	aN46m3kCo8AsJCtmISmbhaRsASPzKka5xJzSXN3cxMyc4tRk3eLkxLy81CJdM73czBK91JTS
	TYyQQBbawbj+pNwhRgEORiUe3hMKZaFCrIllxZW5hxglOZiURHl/rwQK8SXlp1RmJBZnxBeV
	5qQWH2KU4GBWEuFl6QLK8aYkVlalFuXDpKQ5WJTEeX8uVvcTEkhPLEnNTk0tSC2CycpwcChJ
	8H7bDdQoWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rT+GJgpIKkeID2su4B2Vtc
	kJgLFIVoPcWoKCXOuxdkrgBIIqM0D24sLD29YhQH+lKYVwuknQeY2uC6XwENZgIa/P1rMcjg
	kkSElFQD48KcaS4v7aRXdE2do5Q/T0lj6XumM7fWmN6dLrZaxcVQ6KDh4Vkr/BvDa7elZ/69
	xnFSplog2UOpjNtCecOmm63S59oatv+v3XyOo/DQrZ0zq5V0TdjO/f/ubrl0w3cp 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271161>

On 06/08/2015 06:48 PM, Stefan Beller wrote:
> On Mon, Jun 8, 2015 at 4:45 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> delete_ref() uses a different convention for its old_sha1 parameter
>> than, say, ref_transaction_delete(): NULL_SHA1 means not to check the
>> old value. Make this fact a little bit clearer in the code by handling
>> it in explicit, commented code rather than burying it in a conditional
>> expression.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>  refs.c | 7 +++++--
>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/refs.c b/refs.c
>> index b575bb8..f9d87b6 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2795,10 +2795,13 @@ int delete_ref(const char *refname, const unsigned char *old_sha1,
>>         struct ref_transaction *transaction;
>>         struct strbuf err = STRBUF_INIT;
>>
>> +       /* Treat NULL_SHA1 as "don't care" */
> 
> and by "don't care" you mean we still care about getting it deleted,
> the part we don't care about is the particular sha1 (could be a bogus ref).

Correct. I will to change the comment to

	/*
	 * Treat NULL_SHA1 and NULL alike, to mean "we don't care what
	 * the old value of the reference was (or even if it didn't
	 * exist)":
	 */

to make that clearer.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
