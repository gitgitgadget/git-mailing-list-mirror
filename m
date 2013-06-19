From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 00/12] Fix some reference-related races
Date: Wed, 19 Jun 2013 07:51:22 +0200
Message-ID: <51C146DA.5000500@alum.mit.edu>
References: <1370987312-6761-1-git-send-email-mhagger@alum.mit.edu> <51BCCAD2.9070106@ramsay1.demon.co.uk> <51BD5232.20205@alum.mit.edu> <51C0A33A.7060802@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Johan Herland <johan@herland.net>,
	git discussion list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Jun 19 07:52:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UpBKD-0005lf-QQ
	for gcvg-git-2@plane.gmane.org; Wed, 19 Jun 2013 07:52:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756429Ab3FSFvc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Jun 2013 01:51:32 -0400
Received: from alum-mailsec-scanner-1.mit.edu ([18.7.68.12]:42904 "EHLO
	alum-mailsec-scanner-1.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756390Ab3FSFv1 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Jun 2013 01:51:27 -0400
X-AuditID: 1207440c-b7f016d000005997-36-51c146df9f3c
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-1.mit.edu (Symantec Messaging Gateway) with SMTP id 46.9E.22935.FD641C15; Wed, 19 Jun 2013 01:51:27 -0400 (EDT)
Received: from [192.168.101.152] (mx.berlin.jpk.com [212.222.128.135] (may be forged))
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r5J5pNWW030235
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 19 Jun 2013 01:51:25 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <51C0A33A.7060802@ramsay1.demon.co.uk>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqHvf7WCgwZ+pPBZdV7qZLBp6rzBb
	zLu7i8niR0sPs8XuaQvYHFg9Lr38zubxrHcPo8fFS8oejyeeYPX4vEkugDWK2yYpsaQsODM9
	T98ugTtj4Yuwgge8FZ97V7E0MH7j6mLk5JAQMJG4ueUqE4QtJnHh3nq2LkYuDiGBy4wS2+5M
	Y4dwrjFJbFn3jxmkildAW6L1WxtQgoODRUBV4n9nAkiYTUBXYlFPM9ggUYEwiffLprJClAtK
	nJz5hAXEFgGqWTzvJDPITGaBhYwS+54+BWsQFrCW+Pz4JTPEsvWMEm83/AdbxilgLPHl3G1G
	EJtZQEfiXd8DZghbXmL72znMExgFZiFZMgtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm
	5aUW6Rrq5WaW6KWmlG5ihAQ5zw7Gb+tkDjEKcDAq8fDeWH0gUIg1say4MvcQoyQHk5Io7wfX
	g4FCfEn5KZUZicUZ8UWlOanFhxglOJiVRHj1HIByvCmJlVWpRfkwKWkOFiVxXtUl6n5CAumJ
	JanZqakFqUUwWRkODiUJ3rsgQwWLUtNTK9Iyc0oQ0kwcnCDDuaREilPzUlKLEktLMuJBsRpf
	DIxWkBQP0N7LIO28xQWJuUBRiNZTjLocB35sec8oxJKXn5cqJc57D6RIAKQoozQPbgUspb1i
	FAf6WJj3MUgVDzAdwk16BbSECWiJ0Pd9IEtKEhFSUg2MBW8l7r1yqn2ySE5xXtLv67Glc+K+
	+n+30SoVuv/wsP7Z+MW+zHUB71j3L3gcvzn+fn/JP1l2aw3l+xtvadwXW7L/9ZXu 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/228346>

On 06/18/2013 08:13 PM, Ramsay Jones wrote:
> Michael Haggerty wrote:
>> On 06/15/2013 10:13 PM, Ramsay Jones wrote:
>>> Now, turning to the new code, t3211-peel-ref.sh test #7 now works, but
>>> test #8 still fails...
> 
> [ ... ]
> 
>>             It should be impossible, because the current process is
>> holding packed-refs.lock, and therefore other git processes should
>> refuse to change the packed-refs file.
> 
> :-P You are assuming that a single process can't lie to itself ...
> 
> [ ... ]
> 
> I should not have assumed that you knew what I meant by "schizophrenic
> stat() functions" above; sorry about that! If you are interested, then
> the following commits may be useful reading: adbc0b6, 7faee6b, 7974843,
> 05bab3ea, 924aaf3e and b8a97333.

Thanks, that helps.

>>> I haven't checked the remaining test failures to see if they are
>>> caused by this code (I don't think so, but ...), but this failure
>>> is clearly a cygwin specific issue.
>>
>> Thanks again for the testing and analysis,
> 
> So, unless you feel the need to fix this yourself, you can probably
> ignore this issue for now. I will hopefully find time to fix it up
> before this topic progresses to next. (Although I don't have any
> feeling for the time-frame of this topic).

Despite reading the commits that you referenced, I still don't feel
competent to fix this myself so I gratefully accept your offer.
Ideally, whatever complexity is needed would be hidden in the functions
stat_validity_check() and stat_validity_update() added by patch 09/12 of
my series, and possibly match_stat_data() from 08/12.

Let me know if I can help.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
