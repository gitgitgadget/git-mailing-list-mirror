From: Durham Goode <durham@fb.com>
Subject: Re: bug: sparse config interpretation incorrectness in 2.8.0-rc2
Date: Thu, 17 Mar 2016 10:51:46 -0700
Message-ID: <56EAEEB2.4020002@fb.com>
References: <56E9F5B3.6030903@fb.com>
 <xmqqfuvp36wu.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <pclouds@gmail.com>,
	Mateusz Kwapich <mitrandir@fb.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 17 18:52:01 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agc5U-00073n-Fp
	for gcvg-git-2@plane.gmane.org; Thu, 17 Mar 2016 18:51:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932983AbcCQRvx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Mar 2016 13:51:53 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:33347 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753159AbcCQRvv (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 17 Mar 2016 13:51:51 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u2HHpZ1m026719;
	Thu, 17 Mar 2016 10:51:48 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fb.com; h=subject : to : references
 : cc : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=facebook;
 bh=9ivzNrPW/b7WKdBqNEt9JhXvcaftwqSQ3Mbm4YDYwP8=;
 b=geqKJrGr2I0VaxtCPZNdfOGB1Ajpcwrg9bH0GvZ6QgmRLFEAMLayMn9U6UOyoZ7TZAkJ
 gca8c62RooYH/G6rZ5Zcbxk5aZR9VLnIMScNKg26SIsv+no1SNsuWE/gMIdKdVKpE1eF
 T/mVnCd2ZkFolMiD68W5UmJiHH4dJzcUShc= 
Received: from mail.thefacebook.com ([199.201.64.23])
	by mx0a-00082601.pphosted.com with ESMTP id 21qxcv8vg4-2
	(version=TLSv1 cipher=AES128-SHA bits=128 verify=NOT);
	Thu, 17 Mar 2016 10:51:48 -0700
Received: from durham-mbp1.dhcp.thefacebook.com (192.168.52.123) by
 mail.thefacebook.com (192.168.16.11) with Microsoft SMTP Server (TLS) id
 14.3.248.2; Thu, 17 Mar 2016 10:51:47 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.10; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
In-Reply-To: <xmqqfuvp36wu.fsf@gitster.mtv.corp.google.com>
X-Originating-IP: [192.168.52.123]
X-Proofpoint-Spam-Reason: safe
X-FB-Internal: Safe
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10432:,, definitions=2016-03-17_06:,,
 signatures=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289132>

On 3/17/16 12:22 AM, Junio C Hamano wrote:
> Durham Goode <durham@fb.com> writes:
>
>> Using git 2.8.0-rc2, given a repo with the following files:
>>
>> - one/hideme
>> - one/donthide
>> - two/foo
>>
>> A sparse config of:
>>
>> cat > .git/info/sparse-checkout <<EOF
>> /*
>> !one/hideme
>> EOF
>>
>> Results in a repository that only has `one/donthide` in it.  I would
>> expect `two/foo`to be present as well.  This worked in 2.6,...
> 2.6 is a tad too old as a reference, as the "!reinclusion" has been
> in flux in recent releases.  Can you test these?
>
>   - 2.7.0
>   - 2.7.1
>   - e79112d
>
> I suspect that v2.7.0 would be broken, v2.7.1 is OK and e79112d
> would also be OK (I am guessing this from [1]).  e79112d is the last
> version on the 'master' branch without the topic that contains the
> commit you bisected down to, but between 2.7.0 and 2.7.1 there was a
> reversion of a commit that introduced the original issue.
>
> The commit you bisected down to that is on 'master', IIUC, was a
> (faulty) attempt to fix the breakage in a different way.
Since Duy has already sent a fix, I assume it's a real bug and he 
understands what's going on.  If you still want me to test those hashes 
let me know.
