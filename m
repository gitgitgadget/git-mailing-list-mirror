From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 16/25] commit_lock_file(): die() if called for unlocked
 lockfile object
Date: Wed, 16 Apr 2014 17:17:26 +0200
Message-ID: <534E9F06.6010300@alum.mit.edu>
References: <1397483695-10888-1-git-send-email-mhagger@alum.mit.edu> <1397483695-10888-17-git-send-email-mhagger@alum.mit.edu> <534CD695.20306@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	=?ISO-8859-15?Q?Torst?= =?ISO-8859-15?Q?en_B=F6gershausen?= 
	<tboegi@web.de>, Eric Sunshine <sunshine@sunshineco.com>
To: Johannes Sixt <j.sixt@viscovery.net>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 16 17:17:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WaRak-0003y5-DM
	for gcvg-git-2@plane.gmane.org; Wed, 16 Apr 2014 17:17:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161610AbaDPPRc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Apr 2014 11:17:32 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47153 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1161469AbaDPPRb (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Apr 2014 11:17:31 -0400
X-AuditID: 1207440e-f79c76d000003e2c-31-534e9f0aa4d1
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 59.81.15916.A0F9E435; Wed, 16 Apr 2014 11:17:30 -0400 (EDT)
Received: from [192.168.69.130] (p4FC9722C.dip0.t-ipconnect.de [79.201.114.44])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id s3GFHQ0d017048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 16 Apr 2014 11:17:28 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Icedove/24.4.0
In-Reply-To: <534CD695.20306@viscovery.net>
X-Enigmail-Version: 1.6
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEKsWRmVeSWpSXmKPExsUixO6iqMs13y/YoPempkXXlW4mi4beK8wW
	K3/WWPxo6WG2OPOmkdGis+MrowObx7PePYweFy8peyx+4OXxeZOcx93/O5k8bj/bxhLAFsVt
	k5RYUhacmZ6nb5fAnXHg/QbGglbWimkn7RsY21m6GDk5JARMJLad3wZli0lcuLeerYuRi0NI
	4DKjRP+nn6wgCSGB80wS9zY4gdi8AtoSl5+dZASxWQRUJd5OnA5mswnoSizqaWbqYuTgEBUI
	kvhzVhGiXFDi5MwnYPNFBHwkfr5vZgaxmQX2MEq83KwEYgsLJEjMfrMKau9cRolFt/exgyQ4
	gXbN2XubFWSmhIC4RE9jEESvrsSPppVsELa8xPa3c5gnMArOQrJuFpKyWUjKFjAyr2KUS8wp
	zdXNTczMKU5N1i1OTszLSy3SNdbLzSzRS00p3cQIiQO+HYzt62UOMQpwMCrx8DLU+gYLsSaW
	FVfmHmKU5GBSEuWtbPELFuJLyk+pzEgszogvKs1JLT7EKMHBrCTCazkNKMebklhZlVqUD5OS
	5mBREudVW6LuJySQnliSmp2aWpBaBJOV4eBQkuD9MReoUbAoNT21Ii0zpwQhzcTBCTKcS0qk
	ODUvJbUosbQkIx4UvfHFwPgFSfEA7T0C0s5bXJCYCxSFaD3FqMtxoWFFC5MQS15+XqqUOK/M
	PKAiAZCijNI8uBWwpPeKURzoY2FeVpAqHmDChJv0CmgJE9CSQ+G+IEtKEhFSUg2M7LdSG5lS
	CzwX9mrO0N3Vyfmy6ne1buw5ByfDoi2/znDwLn7M9+dMbunVv+czX840X1b3gkH8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246336>

On 04/15/2014 08:49 AM, Johannes Sixt wrote:
> Am 4/14/2014 15:54, schrieb Michael Haggerty:
>> diff --git a/lockfile.c b/lockfile.c
>> index 664b0c3..1453a7a 100644
>> --- a/lockfile.c
>> +++ b/lockfile.c
>> @@ -292,6 +292,9 @@ int commit_lock_file(struct lock_file *lk)
>>  	if (lk->fd >= 0 && close_lock_file(lk))
>>  		return -1;
>>  
>> +	if (!lk->filename[0])
>> +		die("BUG: attempt to commit unlocked object");
>> +
> 
> Shouldn't this be the first thing to check after entering the function?

You're right; I will change it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
