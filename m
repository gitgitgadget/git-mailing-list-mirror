From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 07/14] imap-send.c: inline imap_parse_list() in imap_list()
Date: Thu, 17 Jan 2013 05:43:59 +0100
Message-ID: <50F7818F.5010106@alum.mit.edu>
References: <1358237193-8887-1-git-send-email-mhagger@alum.mit.edu> <1358237193-8887-8-git-send-email-mhagger@alum.mit.edu> <20130115185147.GB14552@ftbfs.org> <50F66422.3010502@alum.mit.edu> <7vip6xywdf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Matt Kraai <kraai@ftbfs.org>, git@vger.kernel.org,
	Jonathan Nieder <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 17 05:44:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TvhL1-0003ih-45
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jan 2013 05:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758538Ab3AQEoF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Jan 2013 23:44:05 -0500
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:48504 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757464Ab3AQEoE (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2013 23:44:04 -0500
X-AuditID: 1207440f-b7f276d0000008b2-79-50f78192a17b
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 3A.B9.02226.29187F05; Wed, 16 Jan 2013 23:44:02 -0500 (EST)
Received: from [192.168.69.140] (p57A25AE7.dip.t-dialin.net [87.162.90.231])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r0H4i0uF015788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Wed, 16 Jan 2013 23:44:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106 Thunderbird/17.0.2
In-Reply-To: <7vip6xywdf.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrOKsWRmVeSWpSXmKPExsUixO6iqDup8XuAwfT3phZdV7qZLBp6rzBb
	vL25hNGidfYZFgcWj1dP+tk8ds66y+5x8ZKyx+dNcgEsUdw2SYklZcGZ6Xn6dgncGWfmb2cs
	WMpWMflAWgPjFNYuRk4OCQETiRfdu1kgbDGJC/fWs3UxcnEICVxmlDi7ookVwjnDJPHh8XxG
	kCpeAW2Je2+ugXWwCKhK9D97yA5iswnoSizqaWYCsUUFwiR6X5+DqheUODnzCVi9iICaxMS2
	Q2A2s0CKxMJj68B6hQWCJNZ0dLFDLHvBKLH/0kU2kASngJnEudn/mSAadCTe9T1ghrDlJba/
	ncM8gVFgFpIds5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqRrolebmaJXmpK6SZG
	SEDz72DsWi9ziFGAg1GJh9fi1rcAIdbEsuLK3EOMkhxMSqK8OlXfA4T4kvJTKjMSizPii0pz
	UosPMUpwMCuJ8K7JA8rxpiRWVqUW5cOkpDlYlMR51Zeo+wkJpCeWpGanphakFsFkZTg4lCR4
	pzQANQoWpaanVqRl5pQgpJk4OEGGc0mJFKfmpaQWJZaWZMSDYjW+GBitICkeoL0NIO28xQWJ
	uUBRiNZTjLoc23+3P2cUYsnLz0uVEuedCFIkAFKUUZoHtwKWvl4xigN9LMw7A6SKB5j64Ca9
	AlrCBLRk097PIEtKEhFSUg2M/Zq8XALFAiKJlbIfl3Xc6PTR/3t1i3Ns4C6e5T13FvW+2qK+
	Jp/x/KrnRd134oJ2T7xf3ad8bnHOJWt3E0dP+7en45S/vf7+4M7aaNajHWlZrVcv 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/213841>

On 01/16/2013 04:34 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> On 01/15/2013 07:51 PM, Matt Kraai wrote:
>>> On Tue, Jan 15, 2013 at 09:06:25AM +0100, Michael Haggerty wrote:
>>>> -static struct imap_list *parse_imap_list(struct imap *imap, char **sp)
>>>> +static struct imap_list *parse_list(char **sp)
>>>
>>> The commit subject refers to imap_parse_list and imap_list whereas the
>>> code refers to parse_imap_list and parse_list.
>>
>> Yes, you're right.  Thanks.
> 
> I think I've fixed this (and some other minor points in other
> patches in the series) while queuing; please check master..3691031c
> after fetching from me.

Looks good.  Thanks.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
