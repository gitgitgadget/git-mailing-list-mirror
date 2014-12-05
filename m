From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 06/23] expire_reflog(): exit early if the reference has
 no reflog
Date: Fri, 05 Dec 2014 16:10:18 +0100
Message-ID: <5481CADA.7050507@alum.mit.edu>
References: <1417734515-11812-1-git-send-email-mhagger@alum.mit.edu> <1417734515-11812-7-git-send-email-mhagger@alum.mit.edu> <20141204235323.GI16345@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: Stefan Beller <sbeller@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 05 16:10:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XwuWg-0007r2-3E
	for gcvg-git-2@plane.gmane.org; Fri, 05 Dec 2014 16:10:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751190AbaLEPKa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Dec 2014 10:10:30 -0500
Received: from alum-mailsec-scanner-8.mit.edu ([18.7.68.20]:44241 "EHLO
	alum-mailsec-scanner-8.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750920AbaLEPK3 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 5 Dec 2014 10:10:29 -0500
X-AuditID: 12074414-f797f6d000004084-3b-5481caddc767
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-8.mit.edu (Symantec Messaging Gateway) with SMTP id 8D.C7.16516.DDAC1845; Fri,  5 Dec 2014 10:10:21 -0500 (EST)
Received: from [192.168.69.130] (p5DDB07F3.dip0.t-ipconnect.de [93.219.7.243])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id sB5FAJog002970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Fri, 5 Dec 2014 10:10:20 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.2.0
In-Reply-To: <20141204235323.GI16345@google.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsUixO6iqHv3VGOIwcV1chZdV7qZLBp6rzBb
	vL25hNGit+8Tq8Xmze0sDqweO2fdZfdYsKnU4+IlZY/Pm+QCWKK4bZISS8qCM9Pz9O0SuDO2
	7j3DXHCVtWLiqmfsDYwHWLoYOTkkBEwkLp57xgZhi0lcuLceyObiEBK4zChxtvU6M0hCSOAs
	k8S0ZdwgNq+AtsTxGzuZQGwWAVWJhacWsIPYbAK6Eot6msHiogJBEif3XGeHqBeUODnzCdgy
	EQENieefvoEtYBaYwihx8Ns/sM3CAuESz0/OZoXYvJBR4nT3TLBuTgEDiQ+bm1lBbGYBPYkd
	139B2fIS29/OYZ7AKDALyZJZSMpmISlbwMi8ilEuMac0Vzc3MTOnODVZtzg5MS8vtUjXQi83
	s0QvNaV0EyMktEV2MB45KXeIUYCDUYmHd4VEY4gQa2JZcWXuIUZJDiYlUd77x4FCfEn5KZUZ
	icUZ8UWlOanFhxglOJiVRHiTZwPleFMSK6tSi/JhUtIcLErivN8Wq/sJCaQnlqRmp6YWpBbB
	ZGU4OJQkeDWAMSwkWJSanlqRlplTgpBm4uAEGc4lJVKcmpeSWpRYWpIRD4rW+GJgvIKkeID2
	JoK08xYXJOYCRSFaTzHqcrQ0ve1lEmLJy89LlRLnrQcpEgApyijNg1sBS2SvGMWBPhbmXXsS
	qIoHmAThJr0CWsIEtORuMdiSkkSElFQDo65/8TXpSE+RTk5zm8ncS8MXxvX/D+AvnyjLFdVo
	Kmq+MeLOac557nqd9yR4Nz3/NL9X0+DB40++Uk/u7AtNLHJ6P7+A3e/LlqPexx+F 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260869>

On 12/05/2014 12:53 AM, Jonathan Nieder wrote:
> Michael Haggerty wrote:
> 
>> [Subject: expire_reflog(): exit early if the reference has no reflog]
> 
> The caller moves on to expire other reflogs, so it's not exiting.
> "return early", maybe?
> 
> Except the function already returned early.  I think the purpose of
> this patch is to simplify the no-reflog case by handling it separately.
> 
> Anyway, that's just nitpicking about the subject line.  With
> s/exit/return/ it should be clear that this is a refactoring change,
> which for someone looking at the shortlog is the important thing.

Good suggestion. I will change the commit message.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
