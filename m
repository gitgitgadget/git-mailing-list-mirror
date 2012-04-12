From: "Philip Oakley" <philipoakley@iee.org>
Subject: Re: push.default: current vs upstream
Date: Thu, 12 Apr 2012 23:59:58 +0100
Organization: OPDS
Message-ID: <A13E3113738743C6B002BB6B076E1FEE@PhilipOakley>
References: <vpqwr5uceis.fsf@bauges.imag.fr> <20120406071520.GD25301@sigill.intra.peff.net> <vpqr4w12tjj.fsf@bauges.imag.fr> <20120406080004.GA27940@sigill.intra.peff.net> <4F7FF19B.1060407@alum.mit.edu> <20120407075150.GA18168@sigill.intra.peff.net> <4F7FFD7A.80104@pileofstuff.org> <20120412071150.GB31122@sigill.intra.peff.net> <4F874639.5090207@pileofstuff.org> <7vlim04ou1.fsf@alter.siamese.dyndns.org> <20120412221110.GA22426@sigill.intra.peff.net>
Reply-To: "Philip Oakley" <philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="UTF-8";
	reply-type=original
Content-Transfer-Encoding: 7bit
Cc: "Andrew Sayers" <andrew-git@pileofstuff.org>,
	"Michael Haggerty" <mhagger@alum.mit.edu>,
	"Matthieu Moy" <Matthieu.Moy@grenoble-inp.fr>,
	"Git List" <git@vger.kernel.org>
To: "Jeff King" <peff@peff.net>, "Junio C Hamano" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 01:09:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIT93-0000Zj-VV
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 01:09:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934210Ab2DLXJd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 19:09:33 -0400
Received: from out1.ip04ir2.opaltelecom.net ([62.24.128.240]:3033 "EHLO
	out1.ip04ir2.opaltelecom.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S934179Ab2DLXJc (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Apr 2012 19:09:32 -0400
X-Greylist: delayed 589 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Apr 2012 19:09:32 EDT
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AhYKABReh09cHI01/2dsb2JhbABFhWaFSK1FA4EDgQiCBAUBAQQBCAEBGRUeAQETDgUGAgMFAgEDDgcBAgICBSECAhQBBBoGBxcGARIIAgECAwEKh24JB6cZkneBL4o5hH41YwSNb4kOjyWCaA
X-IronPort-AV: E=Sophos;i="4.75,414,1330905600"; 
   d="scan'208";a="368444915"
Received: from host-92-28-141-53.as13285.net (HELO PhilipOakley) ([92.28.141.53])
  by out1.ip04ir2.opaltelecom.net with SMTP; 12 Apr 2012 23:59:40 +0100
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.5931
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.6157
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195385>

From: "Jeff King" <peff@peff.net> Sent: Thursday, April 12, 2012 11:11 PM
> On Thu, Apr 12, 2012 at 02:33:58PM -0700, Junio C Hamano wrote:
>
>> Andrew Sayers <andrew-git@pileofstuff.org> writes:
>>
>> > So if the problem is that the documentation cues the reader to think
>> > about upstreams but not to think about downstreams, the solution is to
>> > find excuses to talk more about downstreams.  As far as I'm concerned
>> > @{upstream} means "the place that commits come from when I `git pull`",
>> > so it makes perfect sense to me that @{downstream} would mean "the
>> > place
>> > commits go to when I `git push`".

>> In a separate message I completely misunderstood what you meant by
>> "downstream".
>

It would be useful to have "upstream" and "downstream" clarified in the 
documentation, say the Workflows man pages or some suitable place. Upstream 
is used often but isn't well defined (no obvious link anyway) - it's more of 
concept than a place (hence Andrew's option), while downstream is hardly 
mentioned at all.

For the push.default option can I suggest a different approach focused on
the beginner? If both current and upstream are potentially problematic, then
surely the default initially should be unset, so that a beginner's push is
refused with a pleasant message, e.g.
"  git push.default is unset,
   please use 'git push <remote> <branch>', or see its man page;
  or set the push.default to match your work style."

This offers the beginner a cause, an immediate solution, and guidance for
the long term. I deliberately called it a work style rather than workflow.

One work style for push.default could be "beginner" which would reduce the
message to:
-  git push.default is unset, use 'git push <remote> <branch>'

This gives the beginner time to learn their workflow, and gives a friendly 
version of the command.

While the expert user's regression would be to select _their_
current/upstream work style.

This approach does take the opposite route to most of the default settings
as it is about stopping beginners making major mistakes, rather than helping
them become productive.

One issue I had with the 'git push' man page is that 'refspec's are a fairly 
advanced (at least intermediate) concept that would confuse the beginner who 
is still getting to grips with their branches and remotes, so using the 'git 
push <remote> <branch>' version [*1*] will be friendlier to those beginners.

Philip

> Yeah, I also took it to mean that the "downstream" of your "upstream"
> would be where you started (though as you mentioned, it is not 1-to-1,
> so that would not work anyway).
>
> But this:
>
>> If you had something like this:
>>
>> [remote "origin"]
>>         url = ...
>>         [remote "destination"]
>>                 pushURL = ...
>>
>> [branch "topic"]
>>         remote = origin
>>                 merge = refs/heads/master
>> pushRemote = destination # new
>>                 push = refs/heads/topic # new
>>
>> you could express that asymmetric layout in a natural way.  When you say
>> "git push" while on your "topic" branch, it will go to "destination"
>> remote to update their "topic" branch.
>
> is much more useful (and I already complained about the lack of
> something like pushRemote recently). I just think it should not be
> called "downstream", as it is not the reverse of upstream.
>
> -Peff
> --
[1] http://gitready.com/beginner/2009/01/21/pushing-and-pulling.html 
