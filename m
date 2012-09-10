From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH] rebase -i: Teach "--edit" action
Date: Mon, 10 Sep 2012 15:33:19 -0400
Message-ID: <CADgNjamB9wG_Vbt1Zwu8Tmt3vQ8XpYys6ngjQeQb2DgnqKeHJg@mail.gmail.com>
References: <1347293683-27996-1-git-send-email-andrew.kw.w@gmail.com>
	<1347293683-27996-2-git-send-email-andrew.kw.w@gmail.com>
	<vpqk3w1j15v.fsf@bauges.imag.fr>
	<CADgNja=z7EDTV8_2CU9Uc7w=Dmtp90GrPkDUFSPbucfyrEsBaQ@mail.gmail.com>
	<20120910165457.GB14201@sigill.intra.peff.net>
	<504E333B.2010602@kdbg.org>
	<20120910184625.GA32237@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j6t@kdbg.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Sep 10 21:33:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TB9jf-0001sO-EY
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 21:33:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758388Ab2IJTdV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 15:33:21 -0400
Received: from mail-lpp01m010-f46.google.com ([209.85.215.46]:52501 "EHLO
	mail-lpp01m010-f46.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758355Ab2IJTdU (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 15:33:20 -0400
Received: by lagy9 with SMTP id y9so1374372lag.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 12:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wIDdMgIK/kpnFjpq2OQyRvRfEqbJ3A4DZJLZI27PBKw=;
        b=0FCffE8r9s0anmOWQR890OT3z8ign7WRdxgg0+PpYYZRi1CTouFE7fdLWQFww+09JS
         TiqVa7CQ901QDIGV/xh2okfBrD6GGoZ4Zno1N0w5imsV2wwIOvbBU4fMbL5Vd1xexcAx
         GdSPmBvwo2LqleiWojOpxie/cITjeFJlJyH9muj2YtBtOoc82g2quFH+DY3PFX4J0aRP
         APZWceBJB+XAl0WCjmXOk0O4yCLTHtUhFWcbo0FUipBGzFwoSHu7AWs87mLCiIkACn4J
         p0PED3GGXGmLWDyQeCqXEM3IEUHDEalkmUUysQPG2B7zMDbg/e5r90N9Xsi36h6he5/o
         Pcmg==
Received: by 10.152.162.10 with SMTP id xw10mr13417235lab.12.1347305599422;
 Mon, 10 Sep 2012 12:33:19 -0700 (PDT)
Received: by 10.112.28.129 with HTTP; Mon, 10 Sep 2012 12:33:19 -0700 (PDT)
In-Reply-To: <20120910184625.GA32237@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205163>

On Mon, Sep 10, 2012 at 2:46 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Sep 10, 2012 at 08:36:43PM +0200, Johannes Sixt wrote:
>
>> > [1] It does preclude using "--edit" to make a note about a later commit
>> >     while you are in the middle of resolving a conflict or something.
>> >     You'd have to do it at the end. I don't know if anybody actually
>> >     cares about that.
>>
>> Yes, I do care. At times I tend to have a very short attention span. Or
>> it is Windows's slowness that expires my short-term memory more often
>> than not. ;)
>
> OK, then I withdraw my proposal. :)
>
> It sounds like it would be safe to do:
>
>   git rebase --edit-todo
>   hack hack hack
>   git rebase --continue

Johannes took the words right out of my mouth.  Also, "edit and _not_
continue" also gives the user a chance to second guess while editing
the todo.

That got me thinking... Currently, the todo list has this line at the bottome:
    # However, if you remove everything, the rebase will be aborted.

We'd probably want to remove that line, since "remove everything" no
longer aborts the rebase. It'll just finish the rebase.  It'll be ugly
to sed it out.  Maybe one way to do this is to remove all the comments
and append new ones.

It might also be nice to add a note to remind the user that they're
editing a todo file in a stopped rebase state. i.e. not a fresh
interactive rebase
