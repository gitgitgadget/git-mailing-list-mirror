From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 06/11] commit: add tests of commit races
Date: Wed, 11 Feb 2015 16:05:00 +0100
Message-ID: <54DB6F9C.7060600@alum.mit.edu>
References: <1423412045-15616-1-git-send-email-mhagger@alum.mit.edu>	<1423412045-15616-7-git-send-email-mhagger@alum.mit.edu>	<CAGZ79kYmgeXt1k22h3fbDR04BTHOQRxryNVSJDOL2DC5yLLHpw@mail.gmail.com> <xmqq1tlxwpgi.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>,
	Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 11 16:05:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLYqx-0007v7-Ht
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 16:05:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752896AbbBKPFQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2015 10:05:16 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44155 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752448AbbBKPFP (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 11 Feb 2015 10:05:15 -0500
X-AuditID: 12074414-f797f6d000004084-43-54db6fa04319
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id C7.24.16516.0AF6BD45; Wed, 11 Feb 2015 10:05:04 -0500 (EST)
Received: from [192.168.69.130] (p4FC9687D.dip0.t-ipconnect.de [79.201.104.125])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1BF51hY013101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 11 Feb 2015 10:05:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <xmqq1tlxwpgi.fsf@gitster.dls.corp.google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprPKsWRmVeSWpSXmKPExsUixO6iqLsg/3aIwZ1NXBZdV7qZLBp6rzBb
	vL25hNGie8pbRovevk+sFps3t7M4sHnsnHWX3WPBplKPi5eUPT5vkgtgieK2SUosKQvOTM/T
	t0vgzti0YidTwTLxiptH5zI3MO4W6mLk5JAQMJFYtOwlI4QtJnHh3nq2LkYuDiGBy4wSB/5d
	YYdwLjBJfNwxj6WLkZ2DV0Bb4mk8SD2LgKpE05cbYL1sAroSi3qamUBsUYEgiUOnH7OA2LwC
	ghInZz4Bsjk4RAS8JNpmFoOEmQUeMUosepcLYgsL2EjsXniUFcQWEvjIKLFzmwuIzSlgLdG3
	YTUrSCuzgLrE+nlCEK3yEs1bZzNPYBSYhWTBLISqWUiqFjAyr2KUS8wpzdXNTczMKU5N1i1O
	TszLSy3StdDLzSzRS00p3cQICWyRHYxHTsodYhTgYFTi4f2w6VaIEGtiWXFl7iFGSQ4mJVHe
	+ym3Q4T4kvJTKjMSizPii0pzUosPMUpwMCuJ8PJnAeV4UxIrq1KL8mFS0hwsSuK83xar+wkJ
	pCeWpGanphakFsFkZTg4lCR41+cBNQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSD
	IjS+GBijICkeoL2OIO28xQWJuUBRiNZTjIpS4rz7QBICIImM0jy4sbB09YpRHOhLYYgqHmCq
	g+t+BTSYCWhwQcENkMEliQgpqQbGrsLJ/9m/b541x1zqqMebj20uRUZlfvO807JtvtTetv06
	d86xfVILBd6KXD+sKn4uMNzB66qZuWtz8TOzj9pi3Qn8J7uOmZR1LBEx+i/Z2qQq 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263677>

On 02/10/2015 08:12 PM, Junio C Hamano wrote:
> Stefan Beller <sbeller@google.com> writes:
> 
>> On Sun, Feb 8, 2015 at 8:14 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>>
>>> +# Copyright (c) 2014 Michael Haggerty <mhagger@alum.mit.edu>
>>
>> What is the projects stance on copyright lines?
> 
> I do not think we have a strong one.
> 
>> I've seen files (most of them from the beginning) having some copyright lines,
>> other files (often introduced way later) not having them, "because
>> we're git and have
>> history, so we know who did it".
> 
> I personally agree with that statement.  Also, a copyright notice
> per file is often added when a new file is added, but that ends up
> giving false sense of "ownership" to everybody else down the line
> even after the file has been extensively modified.  It's not like
> Michael solely owns all lines in this file in later versions.  And
> even if people added their name at the top every time they make any
> change, their names tend to stay even when their contributions are
> later completely rewritten or removed.
> 
> In a sense, my agreement with your statement is stronger than "Yes,
> Git can tell us who did what anyway".  What we can find in the
> history is the sole source of truth, and in-file copyright notice is
> misleading.  You do not even have to have one in the Berne signatory
> nations anyway.

I only put a copyright notice there because I thought it was standard
practice. I think it is ugly and would rather do without it, even aside
from the practical problems that Junio mentioned.

On the other hand, there's this [1] and this [2] from the FSF, which
recommend a copyright blurb at the beginning of every source file.
Though actually the recommendation is to include a GPL blurb too, not
just a naked copyright line like I used. But I get the feeling that the
FSF's recommendation is more for ideological than for legal reasons.

If I don't hear anything else, I'll delete the copyright line in the reroll.

>> The tests themselves look fine.
>>
>> Is there a reason you did not append the tests in 7509 ?
> 
> Hmph.

I don't know what "Hmph" means in this context.

The description for t7509 is "git commit --reset-author", which doesn't
seem to describe the new tests.

There are also

    t7500 "git commit / Tests for selected commit options"
    t7501 "git commit"
    t7502 "git commit porcelain-ish"

I suppose the new tests could go in any of these. But since the tests
are thematically a bit unusual (dealing with races rather than testing
command-line options) and they start with an orphan commit, I thought it
would be just as easy to put them in their own file to make it clear
that they are independent.

I really don't care either way.

Michael

[1] http://www.gnu.org/licenses/gpl-howto.html
[2] http://www.gnu.org/licenses/gpl-faq.html#NoticeInSourceFile

-- 
Michael Haggerty
mhagger@alum.mit.edu
