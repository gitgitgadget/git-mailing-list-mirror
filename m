From: Charles Bailey <charles@hashpling.org>
Subject: Re: [PATCH] mergetool: Remove explicit references to /dev/tty
Date: Fri, 20 Aug 2010 14:50:50 +0100
Message-ID: <4C6E883A.2030301@hashpling.org>
References: <20100820035236.GA18267@gmail.com> <1282303049-11201-1-git-send-email-charles@hashpling.org> <20100820122724.GS10407@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>, git@vger.kernel.org,
	Thomas Rast <trast@student.ethz.ch>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Magnus_B=E4ck?= <magnus.back@sonyericsson.com>,
	Avery Pennarun <apenwarr@gmail.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 20 15:50:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OmRzi-000077-11
	for gcvg-git-2@lo.gmane.org; Fri, 20 Aug 2010 15:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752045Ab0HTNut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Aug 2010 09:50:49 -0400
Received: from relay.pcl-ipout02.plus.net ([212.159.7.100]:6179 "EHLO
	relay.pcl-ipout02.plus.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751821Ab0HTNus (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Aug 2010 09:50:48 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAF8lbkxUXeb0/2dsb2JhbACgTHG7MoU3BA
Received: from outmx03.plus.net ([84.93.230.244])
  by relay.pcl-ipout02.plus.net with ESMTP; 20 Aug 2010 14:50:46 +0100
Received: from hashpling.plus.com ([212.159.69.125])
	 by outmx03.plus.net with esmtp (Exim) id 1OmRza-00086T-AQ; Fri, 20 Aug 2010 14:50:46 +0100
Received: from heisenberg2.hashpling.org ([192.168.76.29])
	by hashpling.plus.com with esmtps (TLSv1:CAMELLIA256-SHA:256)
	(Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1OmRzZ-0003Dm-Bq; Fri, 20 Aug 2010 14:50:45 +0100
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 6.1; en-GB; rv:1.9.2.8) Gecko/20100802 Thunderbird/3.1.2
In-Reply-To: <20100820122724.GS10407@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154039>

On 20/08/2010 13:27, Jonathan Nieder wrote:
>> +++ b/git-mergetool.sh
>> @@ -292,14 +292,15 @@ if test $# -eq 0 ; then
>>       printf "Merging:\n"
>>       printf "$files\n"
>>
>> -    files_to_merge |
>> +    # Save original stdin to fd 3
>> +    files_to_merge 3<&0 |
>
> I would think this should work, but it doesn't feel idiomatic.  Why
> not save stdin a little earlier, so the reader does not have to track
> down whether it has been redirected?

No special reason, I just thought it was more natural to save it at the 
time that we do the redirect..

> The test quietly passes for me with dash but fails with ksh:
>
>   /home/jrn/src/git4/git-mergetool: line 303: 3: cannot open [Bad file descriptor]

... but given that this approach is evidently less portable your way is 
clearly better.

> With the patch below on top, it passes with dash and ksh.

Thanks, I'll re-roll in a bit at squash your fixes in, if that's OK?

Charles.
