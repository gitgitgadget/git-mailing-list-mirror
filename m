From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v3 02/14] t5500: add tests of fetch-pack --all --depth=N
 $URL $REF
Date: Mon, 10 Sep 2012 23:53:05 +0200
Message-ID: <504E6141.1080306@alum.mit.edu>
References: <1347171589-13327-1-git-send-email-mhagger@alum.mit.edu> <1347171589-13327-3-git-send-email-mhagger@alum.mit.edu> <7vmx0xmwr9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Philip Oakley <philipoakley@iee.org>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 23:53:24 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBBv2-0006OK-08
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 23:53:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837Ab2IJVxM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 17:53:12 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:65107 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753136Ab2IJVxK (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 17:53:10 -0400
X-AuditID: 1207440f-b7fde6d00000095c-30-504e6145a9b5
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 86.CD.02396.5416E405; Mon, 10 Sep 2012 17:53:09 -0400 (EDT)
Received: from [192.168.69.140] (p57A25B0C.dip.t-dialin.net [87.162.91.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8ALr6lK021634
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Sep 2012 17:53:07 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7vmx0xmwr9.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrCKsWRmVeSWpSXmKPExsUixO6iqOua6BdgcPqRlEXXlW4mi4beK8wW
	P1p6mC06p8o6sHgsX7qO0eNZ7x5Gj4uXlD0+b5ILYInitklKLCkLzkzP07dL4M743rWVpeA0
	V8X13QYNjHs4uhg5OSQETCSunn3ACmGLSVy4t54NxBYSuMwocXBjShcjF5B9mkni9YsnjCAJ
	XgFtiRPXJ7F3MXJwsAioSpzcFQQSZhPQlVjU08wEYosKhEjMuDyZGaJcUOLkzCcsILaIgJrE
	xLZDYDazQKLEv0WPwfYKC0RIbL28lhli13JGiftbD4MlOAXMJC5e2swG0aAj8a7vATOELS+x
	/e0c5gmMArOQ7JiFpGwWkrIFjMyrGOUSc0pzdXMTM3OKU5N1i5MT8/JSi3RN9HIzS/RSU0o3
	MUJCmX8HY9d6mUOMAhyMSjy8Gjx+AUKsiWXFlbmHGCU5mJREeXdGA4X4kvJTKjMSizPii0pz
	UosPMUpwMCuJ8MZrAuV4UxIrq1KL8mFS0hwsSuK86kvU/YQE0hNLUrNTUwtSi2CyMhwcShK8
	hQlAjYJFqempFWmZOSUIaSYOTpDhXFIixal5KalFiaUlGfGgOI0vBkYqSIoHaK8+SDtvcUFi
	LlAUovUUoy7H3Y8r7jMKseTl56VKifPygBQJgBRllObBrYAlrleM4kAfC/NKgFTxAJMe3KRX
	QEuYgJb4eviALClJREhJNTB2qBZaFN403L/fdrL1+Xc+rBFyV6YeNZp4q+XIQffGhv3qnbM5
	tsX1rDsvVNB4sFjWWLtIfNd7UfXQryr73z/lWG00oV2ubbVnR6Oiz/tpTusd3hk8 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205196>

On 09/10/2012 10:46 PM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Document some bugs in "git fetch-pack":
>>
>> 1. If "git fetch-pack" is called with "--all", "--depth", and an
>> explicit existing non-tag reference to fetch, then it falsely reports
>> that the reference was not found, even though it was fetched
>> correctly.
>>
>> 2. If "git fetch-pack" is called with "--all", "--depth", and an
>> explicit existing tag reference to fetch, then it segfaults in
>> filter_refs() because return_refs is used without having been
>> initialized.
> 
> I guess the first one is because "all" already marks the fetched one
> "used", and does not allow the explicit one to match any unused one
> from the other side?

Yes, more or less.  Spoiler: these failures are fixed later in the patch
series :-)

> I wonder what happens when "--all" with an
> explicit refspec that names non-existing ref is asked for (it should
> notice that refs/heads/no-such-ref does not exist.  I do not know if
> it is something that belongs to this set of new tests)?

Good idea; I just wrote such tests.  They appear to pass regardless of
this patch series.  I will submit them after I am sure that I understand
them.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
