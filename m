From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/18] Improve handling of D/F conflicts
Date: Tue, 05 May 2015 18:12:38 +0200
Message-ID: <5548EBF6.1030209@alum.mit.edu>
References: <1430483158-14349-1-git-send-email-mhagger@alum.mit.edu> <xmqqy4l6wgwm.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Stefan Beller <sbeller@google.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 05 18:12:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YpfSs-0006FD-0Y
	for gcvg-git-2@plane.gmane.org; Tue, 05 May 2015 18:12:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753703AbbEEQMx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 May 2015 12:12:53 -0400
Received: from alum-mailsec-scanner-3.mit.edu ([18.7.68.14]:47299 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751877AbbEEQMv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 May 2015 12:12:51 -0400
X-AuditID: 1207440e-f79bc6d000000c43-ec-5548ebf855d9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id 6F.78.03139.8FBE8455; Tue,  5 May 2015 12:12:40 -0400 (EDT)
Received: from [192.168.69.130] (p4FC97BF5.dip0.t-ipconnect.de [79.201.123.245])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t45GCcFi025111
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 5 May 2015 12:12:39 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.6.0
In-Reply-To: <xmqqy4l6wgwm.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJKsWRmVeSWpSXmKPExsUixO6iqPvjtUeowYnPshZdV7qZLBp6rzBb
	/GjpYbbYvLmdxYHFY8GmUo9nvXsYPS5eUvb4vEkugCWK2yYpsaQsODM9T98ugTvj1podbAWb
	hCo+XLzB0sD4jK+LkZNDQsBEYsnHPlYIW0ziwr31bF2MXBxCApcZJR4sWw7lnGeS+NR+H6yK
	V0BbYvnJjUwgNouAqsSpf4vZQGw2AV2JRT3NYHFRgSCJ1mtTGSHqBSVOznzCAmKLCKhJTGw7
	BGYzC8RLbG2/ygxiCwvYSDzu7Qbq5QBaVixxZ749SJhTwFpi56nPjBDlehI7rv9ihbDlJZq3
	zmaewCgwC8mGWUjKZiEpW8DIvIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11gvN7NELzWldBMj
	JJj5djC2r5c5xCjAwajEwxvB5REqxJpYVlyZe4hRkoNJSZSX+RFQiC8pP6UyI7E4I76oNCe1
	+BCjBAezkgjvngtAOd6UxMqq1KJ8mJQ0B4uSOK/aEnU/IYH0xJLU7NTUgtQimKwMB4eSBG/q
	K6BGwaLU9NSKtMycEoQ0EwcnyHAuKZHi1LyU1KLE0pKMeFCkxhcDYxUkxQO0dw5IO29xQWIu
	UBSi9RSjopQ47xGQhABIIqM0D24sLEW9YhQH+lKY9zxIFQ8wvcF1vwIazAQ0eFUh2OCSRISU
	VAOjnAx//YVcGU7VvBlJhu98/guJbUnOP2nGZPVgysHux2dllly/uuXYHN1tgsIb1x2UWsft
	/YkleLmOa1X1VIYpj5VsYtapXF5m2PAlNTRsu5+g3I6n72ewJ71478AsMO/27MvC 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268395>

On 05/03/2015 04:09 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> We currently don't handle D/F conflicts very well.
>>
>> A "D/F conflict" is what we call a conflict between references like
>> "refs/foo" and "refs/foo/bar".
> 
> Could you phrase that slightly differently, so that readers can tell
> between the usual D/F conflict that is between directory and file in
> the tracked contents (i.e. conflict between the branches being
> merged, killing of a directory necessary when checking out a file,
> etc.) and this thing?  They are similar in nature, but "D/F
> conflict" has been used to refer to the clashes that happen to the
> user contents, not refnames.  Starting a paragraph with "... don't
> handle D/F conflicts in refnames very well" and then using "D/F
> conflict" as a short-hand for "D/F conflict in refnames" throughout
> the rest of the message is perfectly fine, as long as the message
> never talks about the D/F conflict in the traditional sense.

Good point. I will clarify this.

>> * D/F conflicts between references being created in a single
>>   transaction used to be detected too late, possibly after part of the
>>   transaction had already been committed.
>>
>> * D/F errors against loose references were typically reported as
> 
> Be consistent by s/errors/conflicts/ perhaps?

Yes, thanks.

>> This patch series applies on top of
>> mh/ref-lock-avoid-running-out-of-fds. I did it that way because I
>> expected significant conflicts between the series, and the older
>> series is simple/mature enough that I expect it to be merged early in
>> the post-2.4 cycle. But in retrospect it turns out that there are only
>> minor conflicts between the two series. So if you would like me to
>> rebase this series to another starting point, please let me know.
> 
> Thanks for being considerate about back-porting necessity.
> 
> As I have written, I actually would prefer to see that the other
> topic, ref-lock-avoid-running-out-of-fds, to be made applicable to
> older maintenance tracks.  So...

OK, I will rebase this branch onto "master", and simultaneously check
how much work it would be to implement a version of
ref-lock-avoid-running-out-of-fds on top of 2.3 and/or 2.2.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
