From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 24/25] register_ref(): make a copy of the bad reference
 SHA-1
Date: Thu, 30 May 2013 23:51:36 +0200
Message-ID: <51A7C9E8.10108@alum.mit.edu>
References: <1369472904-12875-1-git-send-email-mhagger@alum.mit.edu> <1369472904-12875-25-git-send-email-mhagger@alum.mit.edu> <7vk3mhviaw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Johan Herland <johan@herland.net>,
	Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 30 23:51:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiAlI-0008EK-Ua
	for gcvg-git-2@plane.gmane.org; Thu, 30 May 2013 23:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757789Ab3E3Vvl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 May 2013 17:51:41 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:51815 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756179Ab3E3Vvk (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 17:51:40 -0400
X-AuditID: 1207440c-b7ff06d0000008f7-20-51a7c9eb0daf
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 60.4A.02295.BE9C7A15; Thu, 30 May 2013 17:51:39 -0400 (EDT)
Received: from [192.168.69.140] (p57A24A59.dip0.t-ipconnect.de [87.162.74.89])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r4ULpa0D030332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 30 May 2013 17:51:37 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <7vk3mhviaw.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqPv65PJAgw/7lCy6rnQzWTT0XmG2
	mHd3F5PFj5YeZou7l1exO7B6XHr5nc3j9uv5zB7Pevcwely8pOzxeZNcAGsUt01SYklZcGZ6
	nr5dAnfG82PtLAV72SuWP7zF2MD4h7WLkZNDQsBEYsbWVnYIW0ziwr31bF2MXBxCApcZJS4d
	O80O4Zxjkuht3M8CUsUroCnx7mIfkM3BwSKgKjFzuw1ImE1AV2JRTzMTiC0qECbxftlUVohy
	QYmTM5+AtYoIqElMbDsEZjML1EucWnMZzBYGqj/07TALxK4VjBL/fkLs4hQwk1izfAEzRIOO
	xLu+B1C2vMT2t3OYJzAKzEKyYxaSsllIyhYwMq9ilEvMKc3VzU3MzClOTdYtTk7My0st0jXU
	y80s0UtNKd3ECAlynh2M39bJHGIU4GBU4uHNSFoeKMSaWFZcmXuIUZKDSUmU1/0YUIgvKT+l
	MiOxOCO+qDQntfgQowQHs5IIr+RRoBxvSmJlVWpRPkxKmoNFSZxXdYm6n5BAemJJanZqakFq
	EUxWhoNDSYK35wRQo2BRanpqRVpmTglCmomDE2Q4l5RIcWpeSmpRYmlJRjwoVuOLgdEKkuIB
	2st4HGRvcUFiLlAUovUUoy7HjB+T3zEKseTl56VKifOeAtkhAFKUUZoHtwKW0l4xigN9LMxb
	BVLFA0yHcJNeAS1hAlryxBpsSUkiQkqqgXHWwuUS8/JeznxS6ist43b4+5EV/j5vXVadCl3c
	KG2wRFB4wuXm2IOBW7Qbuzg7SmosZB7PeGx5+HJnaDqryl+d46I5ZTuTj+76dm9p 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226038>

On 05/29/2013 06:53 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> [...]
>> +		current_bad_sha1 = xmalloc(20);
>> +		hashcpy(current_bad_sha1, sha1);
> 
> This, together with 18/25, may hint that we want hashdup()?

I thought about it, but was surprised that I could only find one or two
other places in the existing code that would use such a function.  But
sure, I would be happy to submit a patch.

I think hashdup() needn't be inline, so the definition can't go with its
cousins in cache.h.  There is no cache.c.  So where would be the best
place to define hashdup()?  object.c?  sha1_name.c?

While I'm at it, I think it would be nice to have constants like

#define SHA1_LEN 20
#define SHA1_HEX_LEN 40

and start using those instead of magic numbers.  Any objections (or
suggestions for better names)?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
