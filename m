From: Ping Yin <pkufranky@gmail.com>
Subject: Re: How to create a new commit with the content of some commit?
Date: Wed, 13 May 2009 00:59:50 +0800
Message-ID: <46dff0320905120959sc69eec9h23cd8ac6b489e5b6@mail.gmail.com>
References: <46dff0320905120735l501dcaf4ia8197d24b7684cfe@mail.gmail.com>
	 <20090512160749.GA29566@coredump.intra.peff.net>
	 <46dff0320905120943j303ef104ve7bad25f1874007f@mail.gmail.com>
	 <20090512165103.GE29566@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 12 19:00:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3vKk-0001mi-Fn
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 19:00:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753278AbZELQ7u convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 12 May 2009 12:59:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753277AbZELQ7u
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 12:59:50 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:28218 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbZELQ7t convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 May 2009 12:59:49 -0400
Received: by yx-out-2324.google.com with SMTP id 3so51844yxj.1
        for <git@vger.kernel.org>; Tue, 12 May 2009 09:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nw9X/duKa5DrYde1rNcks/GYm3MyZ9sQz1IYKCp5PTc=;
        b=W6EWz1cDOvRks75ABQ3V7P59svWDhZT9l6qXb5dvvIOtNNa60ByyGlKIXu+S4xYCXN
         3Hv8EjK8MpNoFruXMoP33KcukZT4J/SxIuwYrCUO6CERplUVeuly57TTlym9qW61lJxR
         owSteVial+YjykZo4XcoZk/WatdwkFtwHAB5Q=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=AqSgvir/4aSdOmlvpD3LfsFDIQMdaNPoy90i6Yy7SrXn9XKFz8MHf1UiNqpxxmTAR5
         NP8SpiKLFg1NOBWNZQFo2zYsm4b2Sx0/H+JEM/wC5UaYFPTUnVIqQIqikevisVo4SxJw
         v7dxrRjgY0yA5xNGFyqZqNVUbhdxneRz0AN+c=
Received: by 10.90.83.2 with SMTP id g2mr60715agb.105.1242147590410; Tue, 12 
	May 2009 09:59:50 -0700 (PDT)
In-Reply-To: <20090512165103.GE29566@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118929>

On Wed, May 13, 2009 at 12:51 AM, Jeff King <peff@peff.net> wrote:
> On Wed, May 13, 2009 at 12:43:33AM +0800, Ping Yin wrote:
>
>> > You can just munge the index directly, and skip the working tree
>> > entirely:
>> >
>> > =C2=A0rm .git/index
>> > =C2=A0git read-tree b
>> > =C2=A0git commit -m 'the copy of b'
>>
>> In a non-conflict status, "git read-tree b" will update the index to
>> full match the tree of b, so "rm .git/index" is unnecessary, right?
>
> For some reason, I was thinking that entries in the index that were n=
ot
> in "b" would remain, but that is not actually the case. So yes, I thi=
nk
> you can do it without removing the index (and you are better off to d=
o
> so, since the index also contains the stat cache for your worktree, s=
o
> it is more efficient).
>
> You can also add "-u" as Junio suggested to update the working tree
> during that step, which should be more efficient.

I don't want to touch the working directory, and -m will keep the stat
cache in the index, so i think "git read-tree -m b" is the best.
