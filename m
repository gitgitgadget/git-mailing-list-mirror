From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH v2 06/12] commit: add tests of commit races
Date: Tue, 17 Feb 2015 15:44:42 +0100
Message-ID: <54E353DA.7080608@alum.mit.edu>
References: <1423739543-1025-1-git-send-email-mhagger@alum.mit.edu>	<1423739543-1025-7-git-send-email-mhagger@alum.mit.edu> <CAGZ79kbz5+CNO3fgy+UyY1z45a+cTkhtroRbHSNdmUWdQdKeqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>, "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Tue Feb 17 15:44:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNjOM-0007WM-Cm
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 15:44:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752976AbbBQOoq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2015 09:44:46 -0500
Received: from alum-mailsec-scanner-7.mit.edu ([18.7.68.19]:61650 "EHLO
	alum-mailsec-scanner-7.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751977AbbBQOop (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Feb 2015 09:44:45 -0500
X-AuditID: 12074413-f79f26d0000030e7-24-54e353dc5ea9
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-7.mit.edu (Symantec Messaging Gateway) with SMTP id B7.C5.12519.CD353E45; Tue, 17 Feb 2015 09:44:44 -0500 (EST)
Received: from [192.168.69.130] (p5DDB008A.dip0.t-ipconnect.de [93.219.0.138])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id t1HEigqp026242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES128-SHA bits=128 verify=NOT);
	Tue, 17 Feb 2015 09:44:43 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Icedove/31.4.0
In-Reply-To: <CAGZ79kbz5+CNO3fgy+UyY1z45a+cTkhtroRbHSNdmUWdQdKeqQ@mail.gmail.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrIKsWRmVeSWpSXmKPExsUixO6iqHsn+HGIwfIPFhZdV7qZLBp6rzBb
	vL25hNGie8pbRovevk+sFps3t7M4sHnsnHWX3WPBplKPi5eUPT5vkgtgieK2SUosKQvOTM/T
	t0vgzvj94xN7wRS2iruT17E2MP5i6WLk5JAQMJH4fuQolC0mceHeejYQW0jgMqPEmeUZXYxc
	QPY5JonOqU/BingFtCWW3J7PCmKzCKhKzFl0FSzOJqArsainmQnEFhUIkjh0+jFUvaDEyZlP
	wGwRATWJmatms4EMZRaYxyRxpf0n2DZhAXuJo08eM0JsO8AoMWl1GzNIglMgUOLvoddg3cwC
	6hJ/5l1ihrDlJba/ncM8gVFgFpIls5CUzUJStoCReRWjXGJOaa5ubmJmTnFqsm5xcmJeXmqR
	rrlebmaJXmpK6SZGSJAL72DcdVLuEKMAB6MSD6/FhEchQqyJZcWVuYcYJTmYlER5o4Iehwjx
	JeWnVGYkFmfEF5XmpBYfYpTgYFYS4a3zA8rxpiRWVqUW5cOkpDlYlMR51Zao+wkJpCeWpGan
	phakFsFkZTg4lCR4p4IMFSxKTU+tSMvMKUFIM3FwggznkhIpTs1LSS1KLC3JiAdFa3wxMF5B
	UjxAe7eBtPMWFyTmAkUhWk8x6nIsaN8/k0mIJS8/L1VKnLcepEgApCijNA9uBSylvWIUB/pY
	mFcImOCEeIDpEG7SK6AlTEBL5v95BLKkJBEhJdXAuFw5zUT9avSPf5vsJi14rtIkKTsz7s78
	6cXHjWtrDu0LtnVdmLx62px5r2w31QpKG5Ut0Pr21q1BqOFV5tQwS4sJVnafOb8t 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263946>

On 02/12/2015 07:13 PM, Stefan Beller wrote:
> On Thu, Feb 12, 2015 at 3:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> Committing involves the following steps:
>> [...]
>> diff --git a/t/t7516-commit-races.sh b/t/t7516-commit-races.sh
>> new file mode 100755
>> index 0000000..08e6a6c
>> --- /dev/null
>> +++ b/t/t7516-commit-races.sh
>> @@ -0,0 +1,33 @@
>> +#!/bin/sh
>> +
>> +test_description='git commit races'
>> +. ./test-lib.sh
>> +
>> +test_tick
> 
> So I am wondering why we need to have a test_tick here.
> In case we need to pass simulation time after loading the
> test-lib, we should rather have it inside the test-lib.

You're right; I don't think it's necessary. I will remove it.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
