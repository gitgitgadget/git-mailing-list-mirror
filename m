From: Christoph Mallon <mallon@cs.uni-saarland.de>
Subject: Re: Bug in reflog of length 0x2BFF
Date: Thu, 04 Dec 2014 21:37:34 +0100
Message-ID: <5480C60E.3070903@cs.uni-saarland.de>
References: <547C8610.8080301@cs.uni-saarland.de> <20141201233515.GV6527@google.com> <xmqqvblrrwxu.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Dec 04 21:37:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xwd9o-0004x2-1T
	for gcvg-git-2@plane.gmane.org; Thu, 04 Dec 2014 21:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753106AbaLDUhn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Dec 2014 15:37:43 -0500
Received: from theia.rz.uni-saarland.de ([134.96.7.31]:12422 "EHLO
	theia.rz.uni-saarland.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752979AbaLDUhn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Dec 2014 15:37:43 -0500
Received: from Apfeltasche-2.local (srbk-4db7e9a9.pool.mediaWays.net [77.183.233.169])
	(authenticated bits=0)
	by theia.rz.uni-saarland.de (8.14.1/8.14.0) with ESMTP id sB4KbXmv008526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 4 Dec 2014 21:37:34 +0100
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.98.5 at HIZ-Mailrelay theia.rz.uni-saarland.de
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.5; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <xmqqvblrrwxu.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.4
X-Greylist: Sender succeeded SMTP AUTH authentication, not delayed by milter-greylist-3.0 (theia.rz.uni-saarland.de [134.96.7.31]); Thu, 04 Dec 2014 21:37:34 +0100 (CET)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260798>

Am 04.12.14 21:18, schrieb Junio C Hamano:
> Jonathan Nieder <jrnieder@gmail.com> writes:
>> Could you make a test script that illustrates and reproduces the
>> problem?  I.e., a patch to a file like t/t1410-reflog.sh, such that
>> if I run
>>
>> 	cd git
>> 	make
>> 	cd t
>> 	./t1410-reflog.sh
>>
>> then I can reproduce the bug?
> 
> Amen to that.  I am getting the same thing.

I ran reproduce it reliably on multiple machines (OS X, FreeBSD, ia32,
amd64), a friend of mine can, too.
I already sent a test-patch, here it is again:
	http://tron.yamagi.org/zeug/0001-t1410-Test-erroneous-skipping-of-reflog-entries.patch
Using this test, bisect reliably gives
	4207ed285f31ad3e04f08254237c0c1a1609642b
as culprit.
It seems that Linux does not exhibit this particular behaviour.
Maybe there are differences in memory allocation, which mask the symptom.
Stefan Beller experienced some other sporadic bug regarding the reflog:
	http://marc.info/?l=git&m=141748434801505&w=2
