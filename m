From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 6/8] refs: add update_refs for multiple simultaneous
 updates
Date: Tue, 03 Sep 2013 06:43:05 +0200
Message-ID: <522568D9.3080808@alum.mit.edu>
References: <cover.1377784597.git.brad.king@kitware.com> <cover.1377885441.git.brad.king@kitware.com> <edaddbd4e303866f789f1a4f755a9da77590aeef.1377885441.git.brad.king@kitware.com> <xmqqob8dul99.fsf@gitster.dls.corp.google.com> <5224C8C6.4050500@kitware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Brad King <brad.king@kitware.com>
X-From: git-owner@vger.kernel.org Tue Sep 03 06:50:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VGiZG-0008Kg-0p
	for gcvg-git-2@plane.gmane.org; Tue, 03 Sep 2013 06:50:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759356Ab3ICEuM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Sep 2013 00:50:12 -0400
Received: from alum-mailsec-scanner-6.mit.edu ([18.7.68.18]:64224 "EHLO
	alum-mailsec-scanner-6.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1759344Ab3ICEuL (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Sep 2013 00:50:11 -0400
X-Greylist: delayed 421 seconds by postgrey-1.27 at vger.kernel.org; Tue, 03 Sep 2013 00:50:10 EDT
X-AuditID: 12074412-b7f656d00000102f-92-522568dcac2d
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-6.mit.edu (Symantec Messaging Gateway) with SMTP id 81.FB.04143.CD865225; Tue,  3 Sep 2013 00:43:08 -0400 (EDT)
Received: from [192.168.69.9] (p57A2446A.dip0.t-ipconnect.de [87.162.68.106])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r834h6pQ008177
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 3 Sep 2013 00:43:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130804 Thunderbird/17.0.8
In-Reply-To: <5224C8C6.4050500@kitware.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrIKsWRmVeSWpSXmKPExsUixO6iqHsnQzXI4MR7WYud6yQsuq50M1k0
	9F5hdmD2+PhsObvHxUvKHp83yQUwR3HbJCWWlAVnpufp2yVwZzRcbWctaOeumNZxib2B8SlH
	FyMHh4SAicTy825djJxAppjEhXvr2boYuTiEBC4zSsy+vp8RwjnDJPF4zlwWkCpeAW2J9Q8n
	M4I0swioSqzaWwwSZhPQlVjU08wEYosKhEnsmD6RDaJcUOLkzCdgrSIg5esawOLMAtYSK14f
	BqsXFgiVmPZ1IxPErmYmiR07noElOIF2fbrziQmiQUfiXd8DZghbXmL72znMExgFZiHZMQtJ
	2SwkZQsYmVcxyiXmlObq5iZm5hSnJusWJyfm5aUW6Zrp5WaW6KWmlG5ihASu0A7G9SflDjEK
	cDAq8fBy7FUJEmJNLCuuzD3EKMnBpCTK6w4MeyG+pPyUyozE4oz4otKc1OJDjBIczEoivELf
	gMp5UxIrq1KL8mFS0hwsSuK8Pxer+wkJpCeWpGanphakFsFkZTg4lCR4b6YDDRUsSk1PrUjL
	zClBSDNxcIIM55ISKU7NS0ktSiwtyYgHRWp8MTBWQVI8QHs/g7TzFhck5gJFIVpPMRpz/Fk5
	9xMjx7umeZ8YhVjy8vNSpcR51UHOFwApzSjNg1sES1mvGMWB/hbmNQep4gGmO7h5r4BWMQGt
	ujZREWRVSSJCSqqBMUCGW58x/MBczSjvcyKTlveGNx8+WMB+x39r2vbs5AWLltZNM376gX3D
	y5ndJTsiarfP17mVERTR17NcUptVo+pFHHNmyKy3uyw/Nopo74u/6sL8/VKwrthX 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233679>

On 09/02/2013 07:20 PM, Brad King wrote:
> On 09/01/2013 02:08 AM, Junio C Hamano wrote:
>>> Though the refs themeselves cannot be modified together in a single
>>
>> "themselves".
> 
> Fixed.
> 
>> I notice that we are using an array of structures and letting qsort
>> swap 50~64 bytes of data
> 
> Michael suggested this too, so fixed.

Hmmm, I see that you changed the signature of update_refs() to take an
array of pointers.  My suggestion was unclear, but I didn't mean that
the function signature had to be changed.  Rather, I meant that *within*
the function, you could have created an array of pointers to the
structures in the input array and thereafter accessed it via the pointers:

int update_refs(const char *action, const struct ref_update *updates_orig,
		int n, enum action_on_err onerr)
{
	[...]
	struct ref_update **updates;

	[...]
	updates = xcalloc(n, sizeof(*updates));
	for (i = 0; i < n; i++)
		updates[i] = &updates_orig[i];
	[...]
}

However, your approach is also fine.  It will typically involve more
malloc()s but smaller memcpy()s (i.e., via ALLOC_GROW()) at the caller,
and since usually the number of ref_updates being done at one time will
be limited anyway, I don't see a reason to prefer one version over the
other.

Thanks for making the change.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
