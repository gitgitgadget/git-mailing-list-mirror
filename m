From: Simon Oosthoek <soosthoek@nieuwland.nl>
Subject: Re: [PATCH] Add __git_ps1_pc to use as PROMPT_COMMAND
Date: Mon, 01 Oct 2012 11:13:50 +0200
Message-ID: <50695ECE.5010101@nieuwland.nl>
References: <5064140E.50007@drmicha.warpmail.net> <50658C9B.6030809@nieuwland.nl> <7vipaym3ks.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, s.oosthoek@xs4all.nl,
	Michael J Gruber <git@drmicha.warpmail.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	schwab@linux-m68k.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 01 11:16:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TIc50-0003zF-Kq
	for gcvg-git-2@plane.gmane.org; Mon, 01 Oct 2012 11:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752752Ab2JAJOM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Oct 2012 05:14:12 -0400
Received: from mail.nieuwland.nl ([87.251.35.136]:34423 "HELO nieuwland.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1752593Ab2JAJOL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Oct 2012 05:14:11 -0400
Received: (qmail 10505 invoked by uid 453); 1 Oct 2012 09:13:56 -0000
X-Virus-Checked: Checked by ClamAV on nieuwland.nl
Received: from Unknown (HELO [192.168.216.232]) (192.168.216.232)
  (smtp-auth username soosthoek, mechanism plain)
  by nieuwland.nl (qpsmtpd/0.83) with (AES256-SHA encrypted) ESMTPSA; Mon, 01 Oct 2012 11:13:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <7vipaym3ks.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206727>

On 09/28/2012 07:58 PM, Junio C Hamano wrote:
> Simon Oosthoek <soosthoek@nieuwland.nl> writes:
>
>> +# __git_ps1_pc accepts 0 arguments (for now)
>> +# It is meant to be used as PROMPT_COMMAND, it sets PS1
>> +__git_ps1_pc ()
>> +{
>> +	local g="$(__gitdir)"
>> +	if [ -n "$g" ]; then
>> +...
>> +	fi
>> +}
>
> This looks awfully similar to the existing code in __git_ps1
> function.  Without refactoring to share the logic between them, it
> won't be maintainable.
>

I agree that it's ugly. How about the following:

I modified __git_ps1 to work both in PROMPT_COMMAND mode and in that 
mode support color hints.

This way there's one function, so no overlap.

Shall I send patches for the two changes separately (to support 
PROMPT_COMMAND mode and another to support color hints) or in one?

And what about zsh support? I doubt the PROMPT_COMMAND thing is 
compatible with zsh, but the command substitution mode should probably 
work, unless it is already broken by the use of % to indicate untracked 
files (when GIT_PS1_SHOWUNTRACKEDFILES is set). Unless it is tested 
further in zsh, I'd say it might be better not to claim zsh is supported.

Cheers

Simon
