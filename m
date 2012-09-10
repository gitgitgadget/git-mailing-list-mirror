From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 00/14] Clean up how fetch_pack() handles the heads
 list
Date: Mon, 10 Sep 2012 23:59:59 +0200
Message-ID: <504E62DF.5030408@alum.mit.edu>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu> <7v7gs3sdjx.fsf@alter.siamese.dyndns.org> <20120909130532.GA27754@sigill.intra.peff.net> <7vhar7qd07.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 11 00:00:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBC1g-0002dT-5Z
	for gcvg-git-2@plane.gmane.org; Tue, 11 Sep 2012 00:00:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755489Ab2IJWAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 18:00:07 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:61823 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750886Ab2IJWAF (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 18:00:05 -0400
X-AuditID: 1207440e-b7f036d0000008b5-d2-504e62e31eca
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 05.22.02229.3E26E405; Mon, 10 Sep 2012 18:00:03 -0400 (EDT)
Received: from [192.168.69.140] (p57A25B0C.dip.t-dialin.net [87.162.91.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8ALxx15021927
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Sep 2012 18:00:02 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vhar7qd07.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqPs4yS/A4EODlUXXlW4mi4beK8wW
	P1p6mC06p8o6sHgsX7qO0eNZ7x5Gj4uXlD0+b5ILYInitklKLCkLzkzP07dL4M5oX7aCsWAb
	V8XeB2tYGhg3cXQxcnJICJhITD22jgnCFpO4cG89WxcjF4eQwGVGiWdn9jBDOKeZJBr/nmEF
	qeIV0JZYtHwqC4jNIqAqcavhPCOIzSagK7GopxlskqhAiMSMy5OZIeoFJU7OfAJWLyKgJjGx
	7RCYzSyQKPFv0WOwmcICARKn1/dDLTvOKDHx5GOwZk4BM4kpl7YzQzToSLzrewBly0tsfzuH
	eQKjwCwkO2YhKZuFpGwBI/MqRrnEnNJc3dzEzJzi1GTd4uTEvLzUIl1jvdzMEr3UlNJNjJCA
	5tvB2L5e5hCjAAejEg+vBo9fgBBrYllxZe4hRkkOJiVR3p3RQCG+pPyUyozE4oz4otKc1OJD
	jBIczEoivPGaQDnelMTKqtSifJiUNAeLkjiv2hJ1PyGB9MSS1OzU1ILUIpisDAeHkgSvODBy
	hQSLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJB0RpfDIxXkBQP0F5vkHbe4oLEXKAo
	ROspRl2Oux9X3GcUYsnLz0uVEud1AikSACnKKM2DWwFLX68YxYE+FuY1BqniAaY+uEmvgJYw
	AS3x9fABWVKSiJCSamDs8o3iuhd0/ZfJjYRnEq9i5vYF7XyXJx/r39/WwrGuqS1+ovr+/Z8P
	zxFLCZv77kqAwJUM3gqunzEmElLMiWyiloePrjF9+SNx9rl9nzkUjiwM3G1kra3/ 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205199>

On 09/09/2012 08:15 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> On Sun, Sep 09, 2012 at 03:20:18AM -0700, Junio C Hamano wrote:
>>
>>> Michael Haggerty <mhagger@alum.mit.edu> writes:
>>>
>>>> This patch series depends on the "Add some string_list-related
>>>> functions" series that I just submitted.
>>>
>>> Makes sense.  The only worry (without reading the series first) I
>>> have is that the use of string list may make the responsiblity of
>>> sorting the list fuzzier. I am guessing that we never sorted the
>>> refs we asked to fetch (so that FETCH_HEAD comes out in an expected
>>> order), so use of unsorted string list would be perfectly fine.
>>
>> I haven't read the series yet, but both the list of heads from the user
>> and the list of heads from the remote should have been sorted by 4435968
>> and 9e8e704f, respectively.
> 
> OK.  As long as the sort order matches the order string-list
> internally uses for its bisection search, it won't be a problem,
> then.

The sorting is crucial but there is no bisection involved.  The sorted
linked-list of references available from the remote and the sorted
string_list of requested references are iterated through in parallel.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
