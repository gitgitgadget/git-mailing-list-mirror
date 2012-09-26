From: Simon Oosthoek <soosthoek@nieuwland.nl>
Subject: Re: bash completion with colour hints
Date: Wed, 26 Sep 2012 21:25:30 +0200
Message-ID: <506356AA.3050005@nieuwland.nl>
References: <50631885.8090604@nieuwland.nl> <CALkWK0=9KKZvvNFoLUNRKWkfrqR7+RByYaWP9XXg7Pd3ym7CUQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 21:26:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGxFw-0000Bm-MM
	for gcvg-git-2@plane.gmane.org; Wed, 26 Sep 2012 21:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757366Ab2IZT0h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Sep 2012 15:26:37 -0400
Received: from smtp-vbr4.xs4all.nl ([194.109.24.24]:3582 "EHLO
	smtp-vbr4.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754626Ab2IZT0h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Sep 2012 15:26:37 -0400
Received: from [192.168.178.21] (simaj.xs4all.nl [83.160.71.26])
	(authenticated bits=0)
	by smtp-vbr4.xs4all.nl (8.13.8/8.13.8) with ESMTP id q8QJPUwg040871
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 26 Sep 2012 21:25:32 +0200 (CEST)
	(envelope-from soosthoek@nieuwland.nl)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <CALkWK0=9KKZvvNFoLUNRKWkfrqR7+RByYaWP9XXg7Pd3ym7CUQ@mail.gmail.com>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206430>

On 26/09/12 17:24, Ramkumar Ramachandra wrote:
> Hi Simon,
> 
> Could you follow the guidelines in Documentation/SubmittingPatches, so
> that the patch can be considered for inclusion?

Hi Ram, thanks for your feedback.

I gather now that this file is part of the entire git tree ;-)

this is my first time to submit a patch to git and frankly I coded this
up very quickly and did only a small test.

I read the guide and now I have some questions:

- It suggests to use the oldest commit that contains the "bug" and can
support the fix. This would be the very first mention of __git_ps1
function I think commit d3d717a4ad0c8d7329e79f7d0313baec57c6b585
However, I guess that although I have been using something similar since
about 2009, I should at least base it on the relatively new
git-prompt.sh file, is this a correct interpretation of the guide?
(BTW, I wonder how this will affect ultimately the current master?)

- I read that git-prompt.sh is meant to support bash and zsh, I have
only tested it on bash. Should I attempt to test it on zsh or is there a
kind person with zsh as his/her shell to test it for me?

My instinct is to just apply my patch to the current master, but I'm
open to starting from a different base, but I'm too new to the tree to
know which one, any suggestions?



> 
>> --- git-orig-bak	2012-09-26 16:39:47.000000000 +0200
>> +++ git-bashcompletion	2012-09-26 16:50:57.000000000 +0200
>> @@ -59,6 +59,9 @@
>>  #       per-repository basis by setting the bash.showUpstream config
>>  #       variable.
>>  #
>> +#       If you would like an additional hint in colour in your prompt
>> +#       set GIT_PS1_SHOWCOLORHINT to a nonempty value. Currently
>> +#       the colours are hardcoded in the function...
> 
> Nit: I think it's spelt "color" everywhere else in git.
> 

I can adapt ;-)

>> +		local c_red=' [31m'
>> +		local c_yellow=' [33m'
>> +		local c_lblue=' [1,34m'
>> +		local c_green=' [32m'
>> +		local c_purple=' [35m'
>> +		local c_cyan=' [36m'
>> +		local c_clear=' [0m'
>> +		local printf_format="${1:- (%s)}"
>> +
>> +		if [ -n "${GIT_PS1_SHOWCOLORHINT-}" ]; then
>> +			if [ "$w" != "*" ]; then
>> +				printf_format="$c_green$printf_format$c_clear"
>> +			else
>> +				printf_format="$c_red$printf_format$c_clear"
>> +			fi
>> +			if [ -n "$i" ]; then
>> +				i="$c_yellow$i$c_clear"
>> +			fi
>> +			if [ -n "$s" ]; then
>> +				s="$c_lblue$i$c_clear"
>> +			fi
>> +			if [ -n "$u" ]; then
>> +				u="$c_purple$i$c_clear"
>> +			fi
>> +		fi
>> +			
>>  		local f="$w$i$s$u"
>> -		printf "${1:- (%s)}" "$c${b##refs/heads/}${f:+ $f}$r$p"
>> +		echo $(printf "$printf_format" "$c${b##refs/heads/}${f:+ $f}$r$p")

I'm still in some doubt over this last line, including the color codes
is confusing me...

I'll go ahead and try some more polishing and whatever more comes as
suggestions. Is it ok to bother the list with intermediate stuff in this
thread?

Cheers

Simon
