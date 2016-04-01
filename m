From: Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v3 00/16] port branch.c to use ref-filter's printing
 options
Date: Fri, 1 Apr 2016 16:15:37 +0100
Message-ID: <56FE9099.3030004@ramsayjones.plus.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
 <1459517477.3493.5.camel@kaarsemaker.net> <20160401134435.GA16027@spirit>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Cc: gitster@pobox.com, jacob.keller@gmail.com
To: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 01 17:15:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1am0nk-0005QO-QU
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 17:15:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758600AbcDAPPo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2016 11:15:44 -0400
Received: from avasout07.plus.net ([84.93.230.235]:41224 "EHLO
	avasout07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754765AbcDAPPn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2016 11:15:43 -0400
Received: from [10.0.2.15] ([91.125.197.102])
	by avasout07 with smtp
	id d3Fg1s0012D2Veb013FhG9; Fri, 01 Apr 2016 16:15:41 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.1 cv=QqujpgGd c=1 sm=1 tr=0
 a=mTUfFwB0nGOO66Ym8a+i3w==:117 a=mTUfFwB0nGOO66Ym8a+i3w==:17
 a=L9H7d07YOLsA:10 a=9cW_t1CCXrUA:10 a=s5jvgZ67dGcA:10 a=N659UExz7-8A:10
 a=jHlU7fWTpmTqS7GeayQA:9 a=pILNOxqGKmIA:10
X-AUTH: ramsayjones@:2500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
In-Reply-To: <20160401134435.GA16027@spirit>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290544>



On 01/04/16 14:44, Dennis Kaarsemaker wrote:
> On Fri, Apr 01, 2016 at 03:31:17PM +0200, Dennis Kaarsemaker wrote:
>> On wo, 2016-03-30 at 15:09 +0530, Karthik Nayak wrote:
>>>
>>> This is part of unification of the commands 'git tag -l, git branch -l
>>> and git for-each-ref'. This ports over branch.c to use ref-filter's
>>> printing options.
>>>
>>> Initially posted here: $(gmane/279226). It was decided that this series
>>> would follow up after refactoring ref-filter parsing mechanism, which
>>> is now merged into master (9606218b32344c5c756f7c29349d3845ef60b80c).
>>
>> Interaction between this series and something I've not yet been able to
>> identify
> 
> That someting is es/test-gpg-tags. Karthik, can you maybe squash this
> fix in if you do another reroll?

Yes, I sent the same patch to Karthik yesterday. Unfortunately, I didn't
send it as a response to this email thread, so it may have been hard to
spot on the mailing list. My bad. Sorry for wasting your time. :(

ATB,
Ramsay Jones


> 
> diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
> index 98a1c49..7420e48 100755
> --- a/t/t6302-for-each-ref-filter.sh
> +++ b/t/t6302-for-each-ref-filter.sh
> @@ -349,6 +349,8 @@ test_expect_success 'check %(if)...%(then)...%(end) atoms' '
>  	A U Thor: refs/heads/side
>  	A U Thor: refs/odd/spot
>  
> +
> +
>  	A U Thor: refs/tags/foo1.10
>  	A U Thor: refs/tags/foo1.3
>  	A U Thor: refs/tags/foo1.6
> @@ -367,7 +369,9 @@ test_expect_success 'check %(if)...%(then)...%(else)...%(end) atoms' '
>  	A U Thor: refs/heads/master
>  	A U Thor: refs/heads/side
>  	A U Thor: refs/odd/spot
> -	No author: refs/tags/double-tag
> +	No author: refs/tags/annotated-tag
> +	No author: refs/tags/doubly-annotated-tag
> +	No author: refs/tags/doubly-signed-tag
>  	A U Thor: refs/tags/foo1.10
>  	A U Thor: refs/tags/foo1.3
>  	A U Thor: refs/tags/foo1.6
> @@ -385,7 +389,9 @@ test_expect_success 'ignore spaces in %(if) atom usage' '
>  	master: Head ref
>  	side: Not Head ref
>  	odd/spot: Not Head ref
> -	double-tag: Not Head ref
> +	annotated-tag: Not Head ref
> +	doubly-annotated-tag: Not Head ref
> +	doubly-signed-tag: Not Head ref
>  	foo1.10: Not Head ref
>  	foo1.3: Not Head ref
>  	foo1.6: Not Head ref
> 
> 
