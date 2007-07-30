From: Eric Lesh <eclesh@ucla.edu>
Subject: Re: [GUILT PATCH 1/4] get_series: Remove comments from end of series lines
Date: Sun, 29 Jul 2007 22:15:54 -0700
Message-ID: <87r6mqcvzp.fsf@hubert.paunchy.net>
References: <118569541814-git-send-email-eclesh@ucla.edu>
	<11856954183111-git-send-email-eclesh@ucla.edu>
	<20070730035422.GB22017@filer.fsl.cs.sunysb.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jsipek@cs.sunysb.edu, git@vger.kernel.org
To: Josef Sipek <jsipek@fsl.cs.sunysb.edu>
X-From: git-owner@vger.kernel.org Mon Jul 30 07:16:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFNc6-0004XO-JC
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 07:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756221AbXG3FQL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 Jul 2007 01:16:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756505AbXG3FQK
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jul 2007 01:16:10 -0400
Received: from smtp-7.smtp.ucla.edu ([169.232.46.138]:41861 "EHLO
	smtp-7.smtp.ucla.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753794AbXG3FQJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2007 01:16:09 -0400
Received: from mail.ucla.edu (mail.ucla.edu [169.232.48.150])
	by smtp-7.smtp.ucla.edu (8.13.8/8.13.8) with ESMTP id l6U5G0ci007815;
	Sun, 29 Jul 2007 22:16:00 -0700
Received: from localhost (adsl-75-26-170-90.dsl.scrm01.sbcglobal.net [75.26.170.90])
	(authenticated bits=0)
	by mail.ucla.edu (8.13.8/8.13.8) with ESMTP id l6U5Fx1q000674
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 29 Jul 2007 22:16:00 -0700
Received: by localhost (Postfix, from userid 1000)
	id 371A01E80A8; Sun, 29 Jul 2007 22:15:54 -0700 (PDT)
In-Reply-To: <20070730035422.GB22017@filer.fsl.cs.sunysb.edu> (Josef Sipek's message of "Sun\, 29 Jul 2007 23\:54\:22 -0400")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/23.0.0 (gnu/linux)
X-Probable-Spam: no
X-Spam-Report: none
X-Scanned-By: smtp.ucla.edu on 169.232.46.138
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54186>


[ Do you mind if these messages go to both your email addresses, or
should I remove one or the other? ]

Josef Sipek <jsipek@fsl.cs.sunysb.edu> writes:

> On Sun, Jul 29, 2007 at 12:50:15AM -0700, Eric Lesh wrote:
> ... 
>> diff --git a/guilt b/guilt
>> index f67bfb5..774909e 100755
>> --- a/guilt
>> +++ b/guilt
>> @@ -178,7 +178,8 @@ get_series()
>>  	#	- whitespace only
>>  	#	- optional whitespace followed by '#' followed by more
>>  	#	  optional whitespace
>> -	grep -ve '^[[:space:]]*\(#.*\)*$' "$series"
>> +	# also remove comments from end of lines
>> +	grep -ve '^[[:space:]]*\(#.*\)*$' < "$series" | sed -e 's/[[:space:]]*#.*$//'
>
> I'd be tempted to replace the whole thing with one sed script...something
> like (not tested):
>
> "
> /^[[:space:]]*#/ ! {
> 	s/[[:space:]]*#.*$//
>
> 	p
> }
> "
>

sed -e "/^[[:space:]]*\(#.*\)*$/d
	/^[[:space:]]*\(#.*\)*$/!{
	s/[[:space:]]*#.*$//
	}
	" $series

is the best I can do.

sed -e "/^[[:space:]]*\(#.*\)*$/d" -e "s/[[:space:]]*#.*$//" $series

works too, and is maybe more readable.

My sed-foo is weak, though.

	Eric
