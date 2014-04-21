From: Richard Hansen <rhansen@bbn.com>
Subject: Re: [SECURITY PATCH] git-prompt.sh: don't put unsanitized branch
 names in $PS1
Date: Mon, 21 Apr 2014 18:58:08 -0400
Message-ID: <5355A280.6020409@bbn.com>
References: <1398107248-32140-1-git-send-email-rhansen@bbn.com>	<xmqq61m28gqj.fsf@gitster.dls.corp.google.com> <xmqq1twq8g91.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, sitaramc@gmail.com,
	=?ISO-8859-1?Q?SZEDER_G=E1?= =?ISO-8859-1?Q?bor?= 
	<szeder@ira.uka.de>, Simon Oosthoek <s.oosthoek@xs4all.nl>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 22 00:58:31 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcNAU-0003QO-E5
	for gcvg-git-2@plane.gmane.org; Tue, 22 Apr 2014 00:58:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754770AbaDUW61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 18:58:27 -0400
Received: from smtp.bbn.com ([128.33.1.81]:31569 "EHLO smtp.bbn.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754569AbaDUW60 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 18:58:26 -0400
Received: from socket.bbn.com ([192.1.120.102]:42577)
	by smtp.bbn.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.77 (FreeBSD))
	(envelope-from <rhansen@bbn.com>)
	id 1WcNAI-0006Q3-58; Mon, 21 Apr 2014 18:58:18 -0400
X-Submitted: to socket.bbn.com (Postfix) with ESMTPSA id 806CC3FF81
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.4.0
In-Reply-To: <xmqq1twq8g91.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246676>

On 2014-04-21 18:33, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Richard Hansen <rhansen@bbn.com> writes:
>>
>>> Both bash and zsh subject the value of PS1 to parameter expansion,
>>> command substitution, and arithmetic expansion.  Rather than include
>>> the raw, unescaped branch name in PS1 when running in two- or
>>> three-argument mode, construct PS1 to reference a variable that holds
>>> the branch name.  Because the shells do not recursively expand, this
>>> avoids arbitrary code execution by specially-crafted branch names such
>>> as '$(IFS=_;cmd=sudo_rm_-rf_/;$cmd)'.
>>>
>>> Signed-off-by: Richard Hansen <rhansen@bbn.com>
>>
>> I'd like to see this patch eyeballed by those who have been involved
>> in the script (shortlog and blame tells me they are SZEDER and
>> Simon, CC'ed), so that we can hopefully merge it by the time -rc1 is
>> tagged.
>>
>> Will queue so that I won't lose it in the meantime.
>>
>> Thanks.
> 
> Sadly, this does not seem to pass t9903.41 for me.
> 
>     $ bash t9903-*.sh -i -v

Oops!  Because git-prompt.sh is in contrib I didn't realize there was a
test for it.

The test will have to change.  I'll think about the best way to adjust
the test and send a reroll.

Thanks,
Richard
