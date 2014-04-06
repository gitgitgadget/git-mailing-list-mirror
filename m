From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 13/22] config: change write_error() to take a (struct
 lock_file *) argument
Date: Mon, 07 Apr 2014 00:04:34 +0200
Message-ID: <5341CF72.70904@alum.mit.edu>
References: <1396367910-7299-1-git-send-email-mhagger@alum.mit.edu> <1396367910-7299-14-git-send-email-mhagger@alum.mit.edu> <533BB519.8030307@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Apr 07 00:04:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WWvBB-0007jc-As
	for gcvg-git-2@plane.gmane.org; Mon, 07 Apr 2014 00:04:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754273AbaDFWEi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 6 Apr 2014 18:04:38 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:46182 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752575AbaDFWEh (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 Apr 2014 18:04:37 -0400
X-AuditID: 1207440c-f79656d000003eba-fc-5341cf74853c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 4D.00.16058.47FC1435; Sun,  6 Apr 2014 18:04:36 -0400 (EDT)
Received: from [192.168.69.148] (p4FDD47DB.dip0.t-ipconnect.de [79.221.71.219])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s36M4YiH007730
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Sun, 6 Apr 2014 18:04:35 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <533BB519.8030307@web.de>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsUixO6iqFty3jHYYNsDI4uuK91MFg29V5gt
	frT0MFt0dnxldGDxeNa7h9Hj4iVlj8+b5DxuP9vGEsASxW2TlFhSFpyZnqdvl8CdcfRYcsEM
	zorXB2azNDBuYu9i5OSQEDCRuDL1FSOELSZx4d56ti5GLg4hgcuMEvs3HWWBcM4xSTR3NLOC
	VPEKaEpse7QXzGYRUJU4MeM9G4jNJqArsainmamLkYNDVCBI4s9ZRYhyQYmTM5+wgNgiAtYS
	r55cYgEpYRaIl3hyNBkkLCyQKNGzbCfYFCGBaYwSy/crg9icAmoSz7vegpVLCIhL9DQGgYSZ
	BXQk3vU9YIaw5SWat85mnsAoOAvJsllIymYhKVvAyLyKUS4xpzRXNzcxM6c4NVm3ODkxLy+1
	SNdQLzezRC81pXQTIyTAeXYwflsnc4hRgINRiYd3xSHHYCHWxLLiytxDjJIcTEqivGpngEJ8
	SfkplRmJxRnxRaU5qcWHGCU4mJVEeDVNgHK8KYmVValF+TApaQ4WJXFe1SXqfkIC6Yklqdmp
	qQWpRTBZGQ4OJQneb2eBGgWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBsRtfDIxe
	kBQP0N4OkHbe4oLEXKAoROspRl2ODdvWNDIJseTl56VKifMuBikSACnKKM2DWwFLZ68YxYE+
	FublPgdUxQNMhXCTXgEtYQJa0hBmB7KkJBEhJdXA6LVSfcXBleu5lY5zvL7JVmbB1H/72e1b
	L/K1WOcH8E9sqnT2vrziVd2pf1wmLBVJcbz6ztLx0XqxVdVPd/fNKDbtNw05oMx1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245796>

On 04/02/2014 08:58 AM, Torsten B=F6gershausen wrote:
> On 04/01/2014 05:58 PM, Michael Haggerty wrote:
>> Reduce the amount of code that has to know about the lock_file's
>> filename field.
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>   config.c | 10 +++++-----
>>   1 file changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/config.c b/config.c
>> index 6821cef..1ea3f39 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -1303,9 +1303,9 @@ static int store_aux(const char *key, const ch=
ar
>> *value, void *cb)
>>       return 0;
>>   }
>>   -static int write_error(const char *filename)
>> +static int write_error(struct lock_file *lk)
> Does the write_error() really need to know about  struct lock_file ?
> (The name of the function does not indicate that it is doing somethin=
g
> with lk)
> And if, would it make sense to rename it into
> write_error_and_do_something() ?

I'm going to leave this part out of the next re-roll, because you are
right: this change is mostly a distraction and probably not an improvem=
ent.

Michael

--=20
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
