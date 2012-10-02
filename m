From: Simon Oosthoek <s.oosthoek@xs4all.nl>
Subject: Re: [PATCH] Add __git_ps1_pc to use as PROMPT_COMMAND
Date: Tue, 02 Oct 2012 21:50:48 +0200
Message-ID: <506B4598.1020206@xs4all.nl>
References: <5064140E.50007@drmicha.warpmail.net> <50658C9B.6030809@nieuwland.nl> <7vipaym3ks.fsf@alter.siamese.dyndns.org> <50695ECE.5010101@nieuwland.nl> <7v626udse6.fsf@alter.siamese.dyndns.org> <7v4nmec8fi.fsf@alter.siamese.dyndns.org> <5069EE8D.6050200@nieuwland.nl> <7vr4piaryi.fsf@alter.siamese.dyndns.org> <506A0366.6030009@xs4all.nl> <7va9w5c31w.fsf@alter.siamese.dyndns.org> <506A99DE.7080503@drmicha.warpmail.net> <7vhaqcajvt.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Simon Oosthoek <soosthoek@nieuwland.nl>, git@vger.kernel.org,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	schwab@linux-m68k.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 02 21:52:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TJ8WL-0007tO-OR
	for gcvg-git-2@plane.gmane.org; Tue, 02 Oct 2012 21:52:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754137Ab2JBTwg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Oct 2012 15:52:36 -0400
Received: from smtp-vbr6.xs4all.nl ([194.109.24.26]:2349 "EHLO
	smtp-vbr6.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751756Ab2JBTwf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Oct 2012 15:52:35 -0400
Received: from [192.168.178.21] (simaj.xs4all.nl [83.160.71.26])
	(authenticated bits=0)
	by smtp-vbr6.xs4all.nl (8.13.8/8.13.8) with ESMTP id q92JomLD011448
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 2 Oct 2012 21:50:54 +0200 (CEST)
	(envelope-from s.oosthoek@xs4all.nl)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120912 Thunderbird/15.0.1
In-Reply-To: <7vhaqcajvt.fsf@alter.siamese.dyndns.org>
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206842>

On 02/10/12 19:01, Junio C Hamano wrote:
> If your goal is to use PROMPT_COMMAND and not PS1, then yes between
> the two definitions of PROMPT_COMMAND above, the latter may look
> simpler.  But that does not explain why you want to prefer it over
> PS1 in the first place, which was the central point of my question
> that still has not been answered.
> 
> Even more confused...
> 

The specific answer to your question is that without using
PROMPT_COMMAND it doesn't seem to be possible to use colors based on the
state of the git tree. The reason being that in order to prevent
wrapping problems on the command line (specifically going up/down the
history list in bash or line wrapping on a long command). This is
prevented (and quite the norm in static PS1 strings) by enclosing the
terminal code for color inside \[ and \] so bash doesn't count these and
what is in between them in the length of the prompt string.

The only way to get the colors in without messing up normal functioning
of the prompt is to use PROMPT_COMMAND to set PS1, with colors based
dynamically on the state of the tree.

In my current version (which I haven't had time to properly send out,
sorry!) it can do both using the same __git_ps1 function. But only color
in the PROMPT_COMMAND mode for the reason laid out above.

Having said that, I think there's another benefit to using
PROMPT_COMMAND; I think it is more elegant to use a function via
PROMPT_COMMAND (now that I know of it), than using a function via
command substitution inside the PS1.

I guess your (and my) confusion is more caused by unfamiliarity with
this feature of bash than it being used. Is that correct?

*desperately trying to get out of confused mode*

Cheers

Simon
