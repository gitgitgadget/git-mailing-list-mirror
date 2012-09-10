From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH] rebase -i: Teach "--edit" action
Date: Mon, 10 Sep 2012 17:17:45 -0400
Message-ID: <CADgNjambUXj+WEFg=OWvtDQ1EKFhavwbjMbTVaP69rhh5DrphA@mail.gmail.com>
References: <1347293683-27996-1-git-send-email-andrew.kw.w@gmail.com>
	<1347293683-27996-2-git-send-email-andrew.kw.w@gmail.com>
	<vpqk3w1j15v.fsf@bauges.imag.fr>
	<CADgNja=z7EDTV8_2CU9Uc7w=Dmtp90GrPkDUFSPbucfyrEsBaQ@mail.gmail.com>
	<20120910165457.GB14201@sigill.intra.peff.net>
	<504E333B.2010602@kdbg.org>
	<20120910184625.GA32237@sigill.intra.peff.net>
	<CADgNjamB9wG_Vbt1Zwu8Tmt3vQ8XpYys6ngjQeQb2DgnqKeHJg@mail.gmail.com>
	<7vd31todkq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 23:17:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBBMi-00085O-4u
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 23:17:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434Ab2IJVRr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 17:17:47 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35285 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752177Ab2IJVRq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 17:17:46 -0400
Received: by lbbgj3 with SMTP id gj3so1523223lbb.19
        for <git@vger.kernel.org>; Mon, 10 Sep 2012 14:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=zlhskZbC6PjH28YGdBzZUQ2mj4JM4sVPyvg0ctwnvho=;
        b=0z016i3pUd5B5lP1Jhjf9tJNhD2Ilpa1mjQimR632KICc6UnWl30hM9Ou44vxsv0aw
         YutWK37zh6iBIyFc33TBgj65nw6/L+C62rNp4Pp9dxUSa/FJZ5TIinE2NQ360MntR0XV
         miqv9DAxBN29HyCeAcQbZRZHT+K7Rr6RHPnauIJzI7lQuSIJszb8XnGH8Uak1EBCaG86
         2rbJ0a34WYz/n6rTEl707hgatzH8r3yWmCCktocTy9QNf3v3pgY9bHOi22RzqJE/nZGd
         RBs6rUHEDcfUfjAZhI28f+WF6ieXgD7B02ZCpHqL24MEeFOp07aP7EMPOXZR78EnRg5S
         cqfg==
Received: by 10.112.43.137 with SMTP id w9mr5366116lbl.134.1347311865176; Mon,
 10 Sep 2012 14:17:45 -0700 (PDT)
Received: by 10.112.28.129 with HTTP; Mon, 10 Sep 2012 14:17:45 -0700 (PDT)
In-Reply-To: <7vd31todkq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205182>

On Mon, Sep 10, 2012 at 3:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Hrm...  They see the contents of the todo file immediately after
> they say "rebase --edit-todo" and the sole reason they said that
> command is because they wanted to edit the todo file.  Is it likely
> they need a reminder?

Yes, it's not very likely, but sometimes the todo file takes a bit of
time to finalize.  So there's a good chance that the user can get
interrupted, context switched, or went to do some double checking. And
when the user returns to the editor, it's difficult to tell whether
he's in a fresh rebase or a stopped rebase, unless he remembers.  It's
an unlikely scenario, but if it does happen, I think a short reminder
could avoid some user panic.

I don't plan to change how the todo file looks for a fresh rebase.
I'll probably just add something like this for the stopped rebase
case:
     # You are editing the todo of an ongoing rebase. To continue
rebase after editing, run: "git rebase --continue"

That will also remind the user to run "--continue" afterwards.
