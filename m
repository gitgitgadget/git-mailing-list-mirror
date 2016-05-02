From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH] git-prompt: make colors available in custom prompts
Date: Mon, 02 May 2016 09:15:55 +0200
Message-ID: <87oa8p0w2c.fsf@linux-m68k.org>
References: <1461301201-92142-1-git-send-email-andrew@schwartzmeyer.com>
	<5726F647.6030805@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Andrew Schwartzmeyer <andrew@schwartzmeyer.com>,
	git@vger.kernel.org, erdavila@gmail.com
To: Simon Oosthoek <s.oosthoek@xs4all.nl>
X-From: git-owner@vger.kernel.org Mon May 02 09:16:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ax85N-0006e6-QW
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 09:16:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbcEBHQB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 03:16:01 -0400
Received: from mail-out.m-online.net ([212.18.0.9]:49872 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbcEBHQA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 03:16:00 -0400
Received: from frontend01.mail.m-online.net (unknown [192.168.8.182])
	by mail-out.m-online.net (Postfix) with ESMTP id 3qywZQ23Xlz3hknW;
	Mon,  2 May 2016 09:15:58 +0200 (CEST)
Received: from localhost (dynscan1.mnet-online.de [192.168.6.68])
	by mail.m-online.net (Postfix) with ESMTP id 3qywZQ1YczzvhMg;
	Mon,  2 May 2016 09:15:58 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.182])
	by localhost (dynscan1.mail.m-online.net [192.168.6.68]) (amavisd-new, port 10024)
	with ESMTP id BI4CxHMltrJW; Mon,  2 May 2016 09:15:56 +0200 (CEST)
X-Auth-Info: LGzpZoj6yBxIQxiZOMKEfvvQtmt0AAvZDTfihmxn7vvCfzr82AZDpTEu4VBOYksf
Received: from igel.home (ppp-88-217-24-154.dynamic.mnet-online.de [88.217.24.154])
	by mail.mnet-online.de (Postfix) with ESMTPA;
	Mon,  2 May 2016 09:15:56 +0200 (CEST)
Received: by igel.home (Postfix, from userid 1000)
	id 0A4EC2C3730; Mon,  2 May 2016 09:15:55 +0200 (CEST)
X-Yow: This is my WILLIAM BENDIX memorial CORNER where I worship William
 Bendix like a GOD!!
In-Reply-To: <5726F647.6030805@xs4all.nl> (Simon Oosthoek's message of "Mon, 2
	May 2016 08:40:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.0.93 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293224>

Simon Oosthoek <s.oosthoek@xs4all.nl> writes:

> Hi Andrew
>
> sorry, I only noticed your request this morning...
>
> On 22/04/16 07:00, Andrew Schwartzmeyer wrote:
>> diff --git a/contrib/completion/git-prompt.sh b/contrib/completion/git-prompt.sh
>> index f18aedc73..ffe79168c 100644
>> --- a/contrib/completion/git-prompt.sh
>> +++ b/contrib/completion/git-prompt.sh
>> @@ -12,8 +12,8 @@
>>   #        source ~/.git-prompt.sh
>>   #    3a) Change your PS1 to call __git_ps1 as
>>   #        command-substitution:
>> -#        Bash: PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
>> -#        ZSH:  setopt PROMPT_SUBST ; PS1='[%n@%m %c$(__git_ps1 " (%s)")]\$ '
>> +#        Bash: PS1="[\u@\h \W$(__git_ps1 ' (%s)')]\$ "
>> +#        ZSH:  setopt PROMPT_SUBST ; PS1="[%n@%m %c$(__git_ps1 ' (%s)')]\$ "
>
> I haven't tested this at all, but when using double quotes, you need to at
> least check all the escapings, like \$ should probably be: \\\$ when used
> in double quotes.

By using double quotes the command subsititution is expanded when PS1 is
set, which makes it pretty useless.

> The original reason for not using colors in command substitution mode was
> that the prompt string length was not calculated correctly by bash and it
> messed up the commandline with very long commands (relative to the
> terminal width), when browsing the command history.

If you want to include control characters in the prompt that don't
contribute to the length you have to enclose them in \[ \].  The problem
is that \[ \] are processed before embedded command substitutions are
expanded, thus they cannot produce such control characters.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
