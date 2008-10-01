From: Andreas Ericsson <ae@op5.se>
Subject: Re: [PATCH] Builtin-commit: show on which branch a commit was added
Date: Wed, 01 Oct 2008 17:22:39 +0200
Message-ID: <48E395BF.5080005@op5.se>
References: <7vzlmkpltb.fsf@gitster.siamese.dyndns.org> <20080921104238.GA9217@sigill.intra.peff.net> <A36A4B61-D223-4821-9969-FA76EAECD1EC@ai.rug.nl> <20080929224430.GA11545@sigill.intra.peff.net> <48E1C39F.4070906@op5.se> <836C204F-F5AF-4887-99C9-04E70FEEB998@wincent.com> <20080930070938.GA14757@sigill.intra.peff.net> <48E1F87D.2010906@op5.se> <20081001031400.GA24513@coredump.intra.peff.net> <48E3312E.4090601@op5.se> <20081001151011.GA21310@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Wincent Colaiuta <win@wincent.com>,
	Pieter de Bie <pdebie@ai.rug.nl>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailinglist <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Oct 01 17:24:09 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kl3YX-0008Oy-Jo
	for gcvg-git-2@gmane.org; Wed, 01 Oct 2008 17:24:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752744AbYJAPWv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2008 11:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752601AbYJAPWv
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Oct 2008 11:22:51 -0400
Received: from mail.op5.se ([193.201.96.20]:53171 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751341AbYJAPWu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2008 11:22:50 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 34DF724B004E;
	Wed,  1 Oct 2008 17:14:14 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -3.72
X-Spam-Level: 
X-Spam-Status: No, score=-3.72 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, AWL=0.679, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CBSab8BYxO6c; Wed,  1 Oct 2008 17:14:07 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.20])
	by mail.op5.se (Postfix) with ESMTP id 45A551B8005F;
	Wed,  1 Oct 2008 17:14:06 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20081001151011.GA21310@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/97235>

Shawn O. Pearce wrote:
> Andreas Ericsson <ae@op5.se> wrote:
>> Jeff King wrote:
>>> On Tue, Sep 30, 2008 at 11:59:25AM +0200, Andreas Ericsson wrote:
>>>> Another way would be to write
>>>> <branch>: Created <hash>: "subject line..."
>>> I think I like this even better.
>> Me too, but I thought it up after I sent out the first patch. The nicest
>> part is that the info that's always present will always end up in the
>> same place, while my patch moves the branch-name around depending on
>> the length of the subject line.
>>
>> Let's agree here and now that the subject should be last and that "commit "
>> should be dropped, at least for the normal cases.
> 
> Actually I rather like the patch you submitted yesterday:
> 
>         normal case
>         Created abc9056 (i386: Snib the sprock) on i386
> 
>         detached head
>         Created DETACHED commit abc9056 (i386: Snib the sprock)
> 
>         initial commit
>         Created root-commit abc9056 (i386: Snib the sprock) on i386
> 
> The detached HEAD and root-commit cases are clearly denoted at the
> very start of the line, where your eyes are likely to start scanning
> from first before you say "Doh, its just line noise because Git wants
> a pat on the back for doing what I asked".  Thus you are likely
> to notice something out of the ordinary (commit on detached HEAD)
> pretty quick.
> 
> The "<branch>: Created <hash>: subject" format described above
> has the problem that a lot of errors look like "error: foo: bar"
> and the human eye is probably trained to glance over it.  IMHO its
> formatted too much like an error message line.
> 
>>> My only concern is that many programs
>>> say "program: some error", so you could potentially have a confusing
>>> branch name. But I personally have never used a branch name that would
>>> cause such confusion.
>> A valid concern, certainly. We needn't use colons for the branch-name
>> though, but could instead use some other delimiter, like this:
>> [<branch>] Created <hash>: "subject line..."
>> although I do believe we're close to nitpicking this issue to death
>> now. It's not *that* important after all.
> 
> Yup, its a bikeshed.
> 
> Right now I'm happy with your patch in next.  I don't like taking
> the paint brush away from folks, but I also don't want to be applying
> a ton of commit message reformatting patches over the next week.  ;-)
> 

Thanks for putting your foot down. Having thought more about it, I
was quite disgusted to realize I spent brain-time on something so
unimportant.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
