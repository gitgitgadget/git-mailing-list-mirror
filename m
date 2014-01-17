From: Siddharth Agarwal <sid0@fb.com>
Subject: Re: with git-next, git pull --rebase can print out "fatal: No such
 ref: ''" for branches without an upstream
Date: Fri, 17 Jan 2014 10:09:39 -0800
Message-ID: <52D971E3.8090406@fb.com>
References: <52D8827E.3060007@fb.com> <20140117022152.GB12444@sigill.intra.peff.net> <52D899CA.5050409@fb.com> <20140117084010.GL7608@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, <git@vger.kernel.org>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Fri Jan 17 19:09:57 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W4Drf-0002NN-0e
	for gcvg-git-2@plane.gmane.org; Fri, 17 Jan 2014 19:09:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753155AbaAQSJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jan 2014 13:09:51 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:54545 "EHLO
	mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752600AbaAQSJt (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jan 2014 13:09:49 -0500
Received: from pps.filterd (m0004077 [127.0.0.1])
	by mx0b-00082601.pphosted.com (8.14.5/8.14.5) with SMTP id s0HI7u1w010233;
	Fri, 17 Jan 2014 10:09:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=message-id : date : from :
 mime-version : to : cc : subject : references : in-reply-to : content-type
 : content-transfer-encoding; s=facebook;
 bh=jGsX5RbANN0oAodE4lzQ3BeuWi+b88vlkjQzZtMI1BA=;
 b=Mt+azQOzhKj+z0yrqGBLmmjB59emFXT9k9QYzS7ixxy4lTKGPgIpS/LZYFrtcymU3+TD
 k6luoum/J8UDkRosx61RHQoiwcSVpbHnk7GsEYCRWoFYWeD43dWX4R0SyxDX3QaHbETi
 HkrtrU81Vv5I5fY8ZyNtwf6ajHRIINu6Gt0= 
Received: from mail.thefacebook.com (mailwest.thefacebook.com [173.252.71.148])
	by mx0b-00082601.pphosted.com with ESMTP id 1hf71mrk8h-1
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=OK);
	Fri, 17 Jan 2014 10:09:42 -0800
Received: from [172.20.35.76] (192.168.16.4) by mail.thefacebook.com
 (192.168.16.15) with Microsoft SMTP Server (TLS) id 14.3.174.1; Fri, 17 Jan
 2014 10:09:40 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140117084010.GL7608@serenity.lan>
X-Originating-IP: [192.168.16.4]
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:5.11.87,1.0.14,0.0.0000
 definitions=2014-01-17_06:2014-01-16,2014-01-17,1970-01-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0
 kscore.is_bulkscore=7.86215537118551e-12 kscore.compositescore=0
 circleOfTrustscore=0 compositescore=0.997600857122248
 urlsuspect_oldscore=0.997600857122248 suspectscore=0
 recipient_domain_to_sender_totalscore=0 phishscore=0 bulkscore=0
 kscore.is_spamscore=0 recipient_to_sender_totalscore=0
 recipient_domain_to_sender_domain_totalscore=64355
 rbsscore=0.997600857122248 spamscore=0
 recipient_to_sender_domain_totalscore=0 urlsuspectscore=0.9 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=7.0.1-1305240000
 definitions=main-1401170103
X-FB-Internal: deliver
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240603>

On 01/17/2014 12:40 AM, John Keeping wrote:
> On Thu, Jan 16, 2014 at 06:47:38PM -0800, Siddharth Agarwal wrote:
>> On 01/16/2014 06:21 PM, Jeff King wrote:
>>> On Thu, Jan 16, 2014 at 05:08:14PM -0800, Siddharth Agarwal wrote:
>>>
>>>> With git-next, where git pull --rebase can print out "fatal: No such
>>>> ref: ''" if git pull --rebase is run on branches without an upstream.
>>> This is already fixed in bb3f458 (rebase: fix fork-point with zero
>>> arguments, 2014-01-09), I think.
>> If I'm reading the patch correctly, that only fixes it for git rebase,
>> not for git pull --rebase. git-pull.sh contains a separate invocation of
>> git merge-base --fork-point.
> I'm pretty sure the invocation in git-pull.sh is OK.  The error then
> comes out of git-rebase.sh when git-pull invokes it.

That doesn't square with 48059e4 being the culprit commit.

> Are you running a version of git-next that includes bb3f458?

Yes, I am.
