From: John Tapsell <johnflux@gmail.com>
Subject: Re: [RFC PATCH] git push: Push nothing if no refspecs are given or 
	configured
Date: Fri, 6 Mar 2009 12:26:59 +0000
Message-ID: <43d8ce650903060426y776474fi10acc5495b88fa7@mail.gmail.com>
References: <20090305221529.GA25871@pvv.org>
	 <fabb9a1e0903051418k3fb6c8baqd0189c772893844e@mail.gmail.com>
	 <200903052322.02098.markus.heidelberg@web.de>
	 <200903052325.44648.markus.heidelberg@web.de>
	 <fabb9a1e0903051426p1222f151s8f466abf319706da@mail.gmail.com>
	 <alpine.DEB.1.00.0903061124000.10279@pacific.mpi-cbg.de>
	 <7v4oy7szze.fsf@gitster.siamese.dyndns.org>
	 <20090306114812.GA19534@pvv.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	markus.heidelberg@web.de, git@vger.kernel.org,
	Andreas Ericsson <ae@op5.se>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Fri Mar 06 13:29:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LfZB4-0006tv-8T
	for gcvg-git-2@gmane.org; Fri, 06 Mar 2009 13:29:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbZCFM1F convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Mar 2009 07:27:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751232AbZCFM1E
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 07:27:04 -0500
Received: from wf-out-1314.google.com ([209.85.200.174]:25774 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750862AbZCFM1B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Mar 2009 07:27:01 -0500
Received: by wf-out-1314.google.com with SMTP id 28so515282wfa.4
        for <git@vger.kernel.org>; Fri, 06 Mar 2009 04:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=PpBeqSVGoyeG+62osjTmNN17ahZ0adUtLACpuNgaAK0=;
        b=S1QZTXjPxmRpr9IRerumApd4fCeDIwo78q9YNoNYKnDgwEBaXKJe7c7eN+erhJWB23
         ROZNpujXLTFO5goZEItm8nnJT/WYQqDd6T7tIhX5r3itsYLRHoLemkF6MN9IMavNS3r9
         nt4PwT1Gu7j2FqvTzOJBjgDrfrvmmgC0uneGw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=paBEB3hAjHyMV/GAKZDss2ypGniVc0kNhmr5q6UWIWtB56cKCMzFPYlpUyNpcMvTog
         p4BrxqQ36fenZF5c5keA1dfdKyaSFeddKCl8MUP5xZBRJBuMAWGH0xtUxhUfAtf6zLhv
         KjuqQuwfxCaOg5XPuVsHdgAIUPz3vvRNterlk=
Received: by 10.142.199.15 with SMTP id w15mr494727wff.150.1236342419189; Fri, 
	06 Mar 2009 04:26:59 -0800 (PST)
In-Reply-To: <20090306114812.GA19534@pvv.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112433>

2009/3/6 Finn Arne Gangstad <finnag@pvv.org>:
> On Fri, Mar 06, 2009 at 02:32:53AM -0800, Junio C Hamano wrote:
>> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>>
>> > On Thu, 5 Mar 2009, Sverre Rabbelier wrote:
>> >
>> >> On Thu, Mar 5, 2009 at 23:25, Markus Heidelberg
>> >> <markus.heidelberg@web.de> wrote:
>> >> > Oh, I confused "config option" with "command line argument"...
>> >>
>> >> Right, I'd like to be able to do:
>> >> $ git config push.iamnotretarded true
>> >> $ git push
>> >
>> > LOL! =C2=A0Sverre, you have a way to crack me up...
>>
>> I found it amusing, too.
>>
>> It may have some correlation with how well organized your work habit=
 is,
>> but I do not think it has much correlation with being retarded. =C2=A0=
It is
>> more about "'matching refs' is the perfect default for _my_ use patt=
ern,
>> don't mess with it, please".
>
> So here is my current WIP suggestion for a new "push.default"
> variable, I am not sure if a single entry can express all useful
> choices, or if it is a good idea to introduce more default choices
> other than "nothing" (with the goal of making it the default in a
> later release).
>
> I think all the values here make sense as a --option to git push
> though (except --nothing...)
>
> Suggested new entry in config.txt:
>
> push.default::
> =C2=A0 =C2=A0 =C2=A0 =C2=A0Defines the action git push should take if=
 no refspec is given
> =C2=A0 =C2=A0 =C2=A0 =C2=A0on the command line, no refspec is configu=
red in the branch, and
> =C2=A0 =C2=A0 =C2=A0 =C2=A0no refspec is implied by any of the option=
s given on the command
> =C2=A0 =C2=A0 =C2=A0 =C2=A0line.
> +
> =C2=A0 =C2=A0 =C2=A0 =C2=A0The term `current remote` means the remote=
 configured for the current
> =C2=A0 =C2=A0 =C2=A0 =C2=A0branch, or `origin` if no remote is set. `=
origin` is also used if
> =C2=A0 =C2=A0 =C2=A0 =C2=A0you are not on a branch at all.
> +
> * `nothing` do not push anything
> * `matching` push all matching branches to the current remote.
> =C2=A0All branches having the same name in both ends are considered t=
o be
> =C2=A0matching. This is the default value.
> * `same-remote` push all matching branches that are configured to use
> =C2=A0the current remote. Branches with no remote configuration are n=
ot pushed.
> * `tracked` push all branches that are tracking a branch on the curre=
nt
> =C2=A0remote to their counterpart.

How about 'current', to simply push the current the branch.  It could
even prompt if it's not tracked yet.

Most (all?) other revision control systems have this 'current'
behaviour by default.

John
