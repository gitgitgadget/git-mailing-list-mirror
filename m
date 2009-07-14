From: Yakup Akbay <yakbay@ubicom.com>
Subject: Re: Weird behavior of git rev-parse
Date: Tue, 14 Jul 2009 13:01:54 +0300
Message-ID: <4A5C5792.3050704@ubicom.com>
References: <4A5C31CF.2090204@ubicom.com> <7vvdlvhbtg.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 14 12:08:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MQevM-0004Wn-8Z
	for gcvg-git-2@gmane.org; Tue, 14 Jul 2009 12:07:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754546AbZGNKHn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Jul 2009 06:07:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754544AbZGNKHn
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 06:07:43 -0400
Received: from server70.appriver.com ([69.20.119.203]:3146 "EHLO
	server70.appriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754483AbZGNKHm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 06:07:42 -0400
X-Greylist: delayed 9496 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Jul 2009 06:07:42 EDT
Received: by server70.appriver.com (CommuniGate Pro PIPE 5.2.14)
  with PIPE id 98422803; Tue, 14 Jul 2009 06:07:13 -0400
Received: from [216.112.109.98] (HELO stork.scenix.com)
  by server70.appriver.com (CommuniGate Pro SMTP 5.2.14)
  with ESMTP id 98422789; Tue, 14 Jul 2009 06:07:08 -0400
Received: from [172.18.200.186] ([172.18.200.186]) by stork.scenix.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 14 Jul 2009 02:59:48 -0700
User-Agent: Thunderbird 2.0.0.22 (X11/20090608)
In-Reply-To: <7vvdlvhbtg.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 14 Jul 2009 09:59:49.0265 (UTC) FILETIME=[D310C810:01CA0469]
X-Policy: GLOBAL - ubicom.com
X-Policy: GLOBAL - ubicom.com
X-Primary: yakbay@ubicom.com
X-Note: This Email was scanned by AppRiver SecureTide
X-Virus-Scan: V-
X-Note: TCH-CT/SI:0-34/SG:2 7/14/2009 6:06:57 AM
X-GBUdb-Analysis: 0, 216.112.109.98, Ugly c=0.627009 p=-0.886105 Source Normal
X-Signature-Violations: 0-0-0-3770-c
X-Note: Spam Tests Failed: 
X-Country-Path: PRIVATE->UNITED STATES->UNITED STATES
X-Note-Sending-IP: 216.112.109.98
X-Note-Reverse-DNS: 216.112.109.98.ptr.us.xo.net
X-Note-WHTLIST: yakbay@ubicom.com
X-Note: User Rule Hits: 
X-Note: Global Rule Hits: 114 115 116 117 121 122 214 
X-Note: Mail Class: VALID
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123235>

Junio C Hamano wrote:
> Yakup Akbay <yakbay@ubicom.com> writes:
>
>   
>> Then I've tried
>>
>>    $ git rev-parse -'hi, this is a test!'
>>
>> the output is:
>>
>>    -hi, this is a test!
>>
>> Is this an expected behavior?
>>     
>
> Absolutely.  rev-parse was originally written as a way for Porcelain
> scripts to sift parameters into four different categories.
>
>  * options and non-options (that's two)
>
>  * args meant for rev-list and others (that's another two)
>
> Multiplying two x two gives you four combinations.
>
> Because you are not giving options like --revs-only, --no-revs, --flags,
> nor --no-flags, rev-parse outputs everything.  You can try these:
>
> $ git rev-parse --no-flags -'Hi'
> $ git rev-parse --no-revs HEAD
> $ git rev-parse --flags --no-revs -Hi HEAD
>   
Got it!

>> Another questions is, usage is printed if you omit the commit id in
>> git rev-list (E.g. `git rev-list -2`). Is there a reason why HEAD is
>> not taken as the default?
>>     
>
> The reason is because that is the way it has been, that is the way it is,
> and changing it will break existing behaviour and scripts.  In other
> words, it is a historical accident without any deep logic.
>
> Besides, "git rev-list" is a plumbing and didn't necessarily want a
> user-friendliness niceties such as "defaulting to X when nothing is
> given".
>
>   
Makes sense, thanks!

Yakup
