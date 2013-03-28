From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Bug in "git rev-parse --verify"
Date: Thu, 28 Mar 2013 16:52:15 +0100
Message-ID: <5154672F.10303@alum.mit.edu>
References: <51543FDB.9010109@alum.mit.edu> <CAPc5daUqzz=9TBmj2Q0MHqEc6gMHxXoGr9+JV3hq76zDKJAyCw@mail.gmail.com> <515462FB.9040605@alum.mit.edu> <20130328153808.GB3337@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junio@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Mar 28 16:52:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ULF8D-0001lm-5i
	for gcvg-git-2@plane.gmane.org; Thu, 28 Mar 2013 16:52:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756050Ab3C1PwV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Mar 2013 11:52:21 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:59956 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756089Ab3C1PwU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 28 Mar 2013 11:52:20 -0400
X-AuditID: 1207440f-b7f466d0000009dc-0d-5154673110fa
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 8B.6C.02524.13764515; Thu, 28 Mar 2013 11:52:18 -0400 (EDT)
Received: from [192.168.101.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r2SFqFKW027607
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 28 Mar 2013 11:52:17 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
In-Reply-To: <20130328153808.GB3337@sigill.intra.peff.net>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNKsWRmVeSWpSXmKPExsUixO6iqGuUHhJoMDXQoutKN5PFiin3WCx+
	tPQwOzB7POvdw+hx8ZKyx+dNcgHMUdw2SYklZcGZ6Xn6dgncGY2d7WwFvawV0/9+ZW1gbGbp
	YuTkkBAwkdi7qZUdwhaTuHBvPVsXIxeHkMBlRolfK/eyQzjHmSSezV/KDFLFK6ApcWbpLjCb
	RUBV4kTvfbBJbAK6Eot6mplAbFGBMIm9F6axQdQLSpyc+QSsRkRAVuL74Y2MIDazgI/E5197
	WUFsYQEdieM9HSwQy/YxSmx80ALWwClgJTHv5wKgoRxADeoS6+cJQfTKS2x/O4d5AqPALCQr
	ZiFUzUJStYCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrolebmaJXmpK6SZGSODy72DsWi9z
	iFGAg1GJh3dGREigEGtiWXFl7iFGSQ4mJVFejRSgEF9SfkplRmJxRnxRaU5q8SFGCQ5mJRHe
	pjigHG9KYmVValE+TEqag0VJnFd9ibqfkEB6YklqdmpqQWoRTFaGg0NJgtc/DahRsCg1PbUi
	LTOnBCHNxMEJMpxLSqQ4NS8ltSixtCQjHhSp8cXAWAVJ8QDtdQRp5y0uSMwFikK0nmLU5eha
	9PkVoxBLXn5eqpQ4rwVIkQBIUUZpHtwKWJp6xSgO9LEwbyhIFQ8wxcFNegW0hAloyfKvwSBL
	ShIRUlINjPxzKqPecJru6PB9Xu/kemXyi4xQLeHjntsjz/7Rb22o2713uzvTpKU6M/rzfjwW
	nbP30ZfoZb7HDebMNHYoEXtnPOGuOiuv2c5yn0gN48b28Jlu+rKfeyVcp+19+8Zz 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219413>

On 03/28/2013 04:38 PM, Jeff King wrote:
> On Thu, Mar 28, 2013 at 04:34:19PM +0100, Michael Haggerty wrote:
> 
>> Is there a simple way to verify an object name more strictly and convert
>> it to an SHA1?  I can only think of solutions that require two commands,
>> like
>>
>>     git cat-file -e $ARG && git rev-parse --verify $ARG
> 
> Is the rev-parse line doing anything there? If $ARG does not resolve to
> a sha1, then wouldn't cat-file have failed?

It's outputting the SHA1, which cat-file seems incapable of providing in
a useful way.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
