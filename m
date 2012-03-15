From: Per Cederqvist <cederp@opera.com>
Subject: Re: [GUILT] [PATCH] Fix fatal "guilt graph" error in sha1sum invocation.
Date: Thu, 15 Mar 2012 09:42:11 +0100
Message-ID: <4F61AB63.5040304@opera.com>
References: <87399bpaq9.fsf@opera.com> <m2k42nmf5g.fsf@igel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff Sipek <jeffpc@josefsipek.net>, git@vger.kernel.org,
	ceder@lysator.liu.se
To: Andreas Schwab <schwab@linux-m68k.org>
X-From: git-owner@vger.kernel.org Thu Mar 15 09:42:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S86GZ-0007Ot-1V
	for gcvg-git-2@plane.gmane.org; Thu, 15 Mar 2012 09:42:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760435Ab2COIma (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Mar 2012 04:42:30 -0400
Received: from smtp.opera.com ([213.236.208.81]:35224 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760121Ab2COIm1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2012 04:42:27 -0400
Received: from [10.30.1.61] (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q2F8gCnO016986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 15 Mar 2012 08:42:19 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
In-Reply-To: <m2k42nmf5g.fsf@igel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193200>

On 03/14/2012 03:27 PM, Andreas Schwab wrote:

> Per Cederqvist<cederp@opera.com>  writes:
>
>> -	openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\).= \(.*\),\2  \1,"
>> +	if [ $# = 1 ]
>> +	then
>> +		openssl dgst -sha1 "$1" | sed "s,SHA1.\(.*\).= \(.*\),\2  \1,"
>> +	else
>> +		openssl dgst -sha1 | sed 's,$,  -,'
>
> $ openssl dgst -sha1</dev/null
> (stdin)= da39a3ee5e6b4b0d3255bfef95601890afd80709

Was that on a Darwin? If so, my fix obviously needs some
work on that platform. I tested openssl-0.9.8o on Ubuntu
11.04, and here it looks like this:

$ openssl dgst -sha1</dev/null
da39a3ee5e6b4b0d3255bfef95601890afd80709
$ openssl version
OpenSSL 0.9.8o 01 Jun 2010

     /ceder

>>   # usage: sha1 [file]
>>   sha1()
>>   {
>> -	sha1sum "$1"
>> +	if [ $# = 1 ]
>> +	then
>> +		sha1sum "$1"
>> +	else
>> +		sha1sum
>> +	fi
>
>          sha1sum "$@"
>
> Andreas.
>
