From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [PATCH] Remove various dead assignments and dead increments found 
	by the clang static analyzer
Date: Sat, 26 Sep 2009 22:46:06 +0100
Message-ID: <3f4fd2640909261446t412d0c26mcee27535be2b8954@mail.gmail.com>
References: <87ab0hepcn.fsf@master.homenet>
	 <alpine.DEB.1.00.0909261756510.4985@pacific.mpi-cbg.de>
	 <871vltefdj.fsf@master.homenet>
	 <fabb9a1e0909261134qd90dba1n9637fe4adc253fc1@mail.gmail.com>
	 <87ske9cya9.fsf@master.homenet>
	 <20090926204604.GA2960@coredump.intra.peff.net>
	 <3f4fd2640909261403n78a7e45cm3d2cd48408b5ff52@mail.gmail.com>
	 <20090926211220.GA3387@coredump.intra.peff.net>
	 <3f4fd2640909261420h2588df4cld8dd3e49f9654e9e@mail.gmail.com>
	 <20090926213602.GA3756@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Scrivano <gscrivano@gnu.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 26 23:55:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrfEp-00059X-9K
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 23:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbZIZVyM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Sep 2009 17:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753106AbZIZVyM
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 17:54:12 -0400
Received: from mail-vw0-f203.google.com ([209.85.212.203]:48048 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052AbZIZVyL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Sep 2009 17:54:11 -0400
Received: by vws41 with SMTP id 41so2199409vws.4
        for <git@vger.kernel.org>; Sat, 26 Sep 2009 14:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=w4jpFV/zv/D/isqDRS+6BuZqMfvffii8EQuR0G3uWaM=;
        b=dGljq6DrxkRL5fcptAcUrgq4r6a6Y3M5FG3p5pxG4s2gnNq6jU6dFuL6VZ+GBhKohV
         ynkCEKX1qlNjDUtUw2toUp02BSf9n9lplqEXYMFgiXYzdZiNcJ+DA/kXc76Yb9HfYYjH
         WKjx30SKTh0ZKfNY3S1IDS7OSZKSpT+x2VXzg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dThdGYgj32wrwO4QXAufrqTS6YB6PMw3cGWQci6zxunJzynVsYNqm+sKxwhiqOxPmI
         paqGRkIa0oRR4TjGk70dsjcqWpQuwEc05iVzUb6tiJ8hxq46ainZ0+zPlUzbvRimsL4C
         ndwtUa1ZmyT9zHRugesy8TZt55CkcMJr1r9zc=
Received: by 10.220.42.11 with SMTP id q11mr2910171vce.88.1254001566864; Sat, 
	26 Sep 2009 14:46:06 -0700 (PDT)
In-Reply-To: <20090926213602.GA3756@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129184>

2009/9/26 Jeff King <peff@peff.net>:
> On Sat, Sep 26, 2009 at 10:20:18PM +0100, Reece Dunn wrote:
>
>> > I suspect nobody has cared about this before, though, because the =
stderr
>> > channel for the hook is also directed to the user. So if
>> > update-server-info (or whatever) fails, presumably it is complaini=
ng to
>> > stderr and the user sees that. Adding an additional "by the way, y=
our
>> > hook failed" is just going to be noise in most cases.
>>
>> It could be used to return an error status from main if it is used i=
n
>> a chained command in a script. Other than that, I agree.
>
> I'm not sure that's a good idea. Your push _did_ happen, and the remo=
te
> repo was updated. So you have no way of knowing from an error exit co=
de
> that changes were in fact made, and it was simply the post-update hoo=
k
> failing.

Ok.

> Of course, you can argue that the current behavior is similarly broke=
n:
> on success, you have no idea if the post-update hook failed or not. B=
ut
> I would argue that whether the push itself happened is more important
> than whether the hook succeeded or not. If you really care, you shoul=
d
> either:
>
> =A01. Use some sort of side channel to report hook status.
>
> =A02. Use the pre-receive hook, which can abort the push if it wants =
to.
>
> But all of that is "if we were designing this hook from scratch". At
> this point, it doesn't make sense to change the semantics. People may=
 be
> relying on the current behavior, and in fact it is documented (in
> githooks(5)):
>
> =A0This hook is meant primarily for notification, and cannot
> =A0affect the outcome of git-receive-pack.

That's fine. As long as the behaviour is documented (which as you
pointed out, it is).

- Reece
