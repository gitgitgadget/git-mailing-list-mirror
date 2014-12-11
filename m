From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 22/23] lock_any_ref_for_update(): inline function
Date: Thu, 11 Dec 2014 01:13:10 +0100
Message-ID: <5488E196.1000107@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu> <1417734515-11812-23-git-send-email-mhagger@alum.mit.edu> <20141208233422.GM25562@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu Dec 11 01:13:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XyrNp-0006HI-Qg
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 01:13:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758301AbaLKAN0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 19:13:26 -0500
Received: from alum-mailsec-scanner-2.mit.edu ([18.7.68.13]:56059 "EHLO
	alum-mailsec-scanner-2.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758073AbaLKANZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2014 19:13:25 -0500
X-AuditID: 1207440d-f79976d000005643-1d-5488e1993d4a
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-2.mit.edu (Symantec Messaging Gateway) with SMTP id 7B.9B.22083.991E8845; Wed, 10 Dec 2014 19:13:13 -0500 (EST)
Received: from [192.168.69.130] (p5DDB0BBF.dip0.t-ipconnect.de [93.219.11.191])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sBB0DB19004420
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Wed, 10 Dec 2014 19:13:12 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <20141208233422.GM25562@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKKsWRmVeSWpSXmKPExsUixO6iqDvzYUeIQeMzaYuuK91MFg29V5gt
	3t5cwmjR2/eJ1eLfhBqLzZvbWRzYPHbOusvusWBTqcfFS8oenzfJBbBEcdskJZaUBWem5+nb
	JXBnTPj7l6ngKU/Fsg2zmRoYl3N1MXJySAiYSNxZ/p0FwhaTuHBvPVsXIxeHkMBlRol1+5+z
	QjjnmSRWLZgHVsUroC3R/GoVI4jNIqAqsbr5ECuIzSagK7Gop5kJxBYVCJI4uec6O0S9oMTJ
	mU/AekUE1CRmrpoNtoFZ4BijRGP7WrAiYQFXiY7lK9khti1ilPjR9RkswSlgIHHi5SxmEJtZ
	QE9ix/VfrBC2vETz1tnMExgFZiFZMgtJ2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW
	6Rrp5WaW6KWmlG5ihAQ57w7G/+tkDjEKcDAq8fCuuNoeIsSaWFZcmXuIUZKDSUmUt/d6R4gQ
	X1J+SmVGYnFGfFFpTmrxIUYJDmYlEd6kG0A53pTEyqrUonyYlDQHi5I4r9oSdT8hgfTEktTs
	1NSC1CKYrAwHh5IEr8gDoEbBotT01Iq0zJwShDQTByfIcC4pkeLUvJTUosTSkox4ULzGFwMj
	FiTFA7R3Nkg7b3FBYi5QFKL1FKOilDivK0hCACSRUZoHNxaWul4xigN9Kcx7DKSKB5j24Lpf
	AQ1mAhq8fAvY4JJEhJRUA2P66b1rlTeliO28+l3Pc+L6MuHHNlcn7hN9lf5E7/0C/o8N7HdN
	p8qI256t6/xsFfle9OmUA+9FzvdtSg9uYE7Y8fOK7zSRklkGV21qv3oo/SzwzNZh 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261265>

On 12/09/2014 12:34 AM, Stefan Beller wrote:
> On Fri, Dec 05, 2014 at 12:08:34AM +0100, Michael Haggerty wrote:
>> From: Ronnie Sahlberg <sahlberg@google.com>
>>
>> Inline the function at its one remaining caller (which is within
>> refs.c) and remove it.
>>
> 
> 
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
> 
> It's originally from Ronnie, but his sign off is missing?
> 
> If that sign off is found again, 
> Reviewed-by: Stefan Beller <sbeller@google.com>

Sorry for the confusion.

This patch ultimately descends from a patch by Ronnie that completely
deleted lock_any_ref_for_update() because (in the context that he wrote
it) there were no remaining callers of that function.

In the context of this patch, there *is* a remaining caller. So this
patch is different--it deletes the obvious stuff as in Ronnie's patch,
but it also inlines the function at its last caller. And the commit
message is completely different.

Given those differences and the fact that the only overlap with Ronnie's
original patch is the *deletion* of content, I thought it most
appropriate to change the authorship of the patch. So I removed Ronnie's
Signed-off-by line but I forgot to remove his authorship.

If anybody thinks it would be more appropriate to leave Ronnie as author
of the new patch or leave his Signed-off-by line, I am totally OK with
doing so. I'm just trying to figure out what's right.

Otherwise, I will change the authorship of the patch to myself in the
upcoming reroll and include only my own Signed-off-by line.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
