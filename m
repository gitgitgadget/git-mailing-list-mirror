From: Simon Oosthoek <soosthoek@nieuwland.nl>
Subject: Re: bash completion with colour hints
Date: Thu, 27 Sep 2012 13:57:53 +0200
Message-ID: <50643F41.8090301@nieuwland.nl>
References: <50631885.8090604@nieuwland.nl> <CALkWK0=9KKZvvNFoLUNRKWkfrqR7+RByYaWP9XXg7Pd3ym7CUQ@mail.gmail.com> <506356AA.3050005@nieuwland.nl> <7vfw64rm6s.fsf@alter.siamese.dyndns.org> <5064140E.50007@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 27 13:58:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1THCjS-0005JA-Gc
	for gcvg-git-2@plane.gmane.org; Thu, 27 Sep 2012 13:58:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751610Ab2I0L6J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Sep 2012 07:58:09 -0400
Received: from mail.nieuwland.nl ([87.251.35.136]:60245 "HELO nieuwland.nl"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1751071Ab2I0L6I (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Sep 2012 07:58:08 -0400
Received: (qmail 20447 invoked by uid 453); 27 Sep 2012 11:58:00 -0000
X-Virus-Checked: Checked by ClamAV on nieuwland.nl
Received: from Unknown (HELO [192.168.216.232]) (192.168.216.232)
  (smtp-auth username soosthoek, mechanism plain)
  by nieuwland.nl (qpsmtpd/0.83) with (AES256-SHA encrypted) ESMTPSA; Thu, 27 Sep 2012 13:58:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <5064140E.50007@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206476>

On 09/27/2012 10:53 AM, Michael J Gruber wrote:

>
>  From trying myself, I'm convinced that you need a clever combination of
> PROMPT_COMMAND and PS1 to make this work. Setting PS1 in PROMPT_COMMAND
> is probably a no-go because that makes it difficult to customize PS1. I
> have something in the works which reproduces the current prompt but need
> to clean it up further. The actual coloring would require setting a lot
> of variables which communicate data from PROMPT_COMMAND to PS1, and I
> actually don't like that.
>
> An alternative approach would be:
>
> - Tell users to activate git prompt by doing something like
>
> PROMPT_COMMAND='__git_prompt "[\u@\h \W (%s)]\$ '
>
> rather than the current
>
> PS1='[\u@\h \W$(__git_ps1 " (%s)")]\$ '
>
> - set PS1 from __git_prompt
>
> I'm not sure about the performance implications of re-setting PS1 on
> (before) each prompt invocation, though. Would that be OK?

After some research, I completely agree with your assessment!

I don't think the performance issue is that big and it's the only way to 
get the colors in there without messing up word wrapping.

I'm afraid that either this will need a new function just to get the 
coloring hints or that it will break the usage of __git_ps1 entirely (if 
you'd require the user to use it as PROMPT_COMMAND instead of via PS1)

And I suppose this will not be compatible with zsh?

/Simon

PS, I'd rather have colours with wrapping issues, than no colour hints. 
But I realise this has to be fixed before inclusion into the main tree.
