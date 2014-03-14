From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH 3/3] reset: Print a warning when user uses "git reset"
 during a merge
Date: Fri, 14 Mar 2014 13:04:42 -0400
Message-ID: <CADgNjan9kCTMPczFzO4jQvM63EU4x7KnJKszhno5PjHivE9ENg@mail.gmail.com>
References: <1394771872-25940-1-git-send-email-andrew.kw.w@gmail.com>
	<1394771872-25940-4-git-send-email-andrew.kw.w@gmail.com>
	<5323131C.7070506@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Marc Branchaud <marcnarc@xiplink.com>
X-From: git-owner@vger.kernel.org Fri Mar 14 18:05:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WOVXr-0006Cg-Bh
	for gcvg-git-2@plane.gmane.org; Fri, 14 Mar 2014 18:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755052AbaCNREp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Mar 2014 13:04:45 -0400
Received: from mail-wg0-f42.google.com ([74.125.82.42]:45103 "EHLO
	mail-wg0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754809AbaCNREo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Mar 2014 13:04:44 -0400
Received: by mail-wg0-f42.google.com with SMTP id y10so2368484wgg.1
        for <git@vger.kernel.org>; Fri, 14 Mar 2014 10:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aQKLar2Di9T554sRM5x1Uf3Wyt+7tqOGmyfLdp/Jg9w=;
        b=kxcJyFY3NZt+DoX07L9epP6/Dx90yYmeD4WeQrE5IocHH/xtoF4YUtKI8UNu0JU08T
         Gq/Aaq6a06UoA2jPvJ5yhvAga0lTH/ubchobvotndU3OLGN+3a4UBYW9YtfZnwrBuPj2
         bxwk/JEkLBY9K19XhlryEwOjjRoMdwoZaJkFq4NfF7uO7svpYZlrIC0Y6QsNq27ooQPx
         FZUUjTP1/zTjlr59qp06sdtku6c7u03Crd/FPZMI8VTatMx3fg/JjBGdhb304RQrTFtY
         2P1YqINvcPA4ib5jzPUvuDwO2G+PeDV45GRtWvo9G2GcTmDljF2XQbRyG0ZrsIi8XcBX
         EAFQ==
X-Received: by 10.180.97.72 with SMTP id dy8mr7019133wib.5.1394816682926; Fri,
 14 Mar 2014 10:04:42 -0700 (PDT)
Received: by 10.194.81.65 with HTTP; Fri, 14 Mar 2014 10:04:42 -0700 (PDT)
In-Reply-To: <5323131C.7070506@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244097>

On Fri, Mar 14, 2014 at 10:33 AM, Marc Branchaud <marcnarc@xiplink.com> wrote:
> I know this approach was suggested earlier, but given these dangers it seems
> silly to give this big warning on a plain "git reset" but still go ahead and
> do the things the warning talks about.
>
> Is there any issue with changing "git reset" to error-out now but letting
> "git reset --mixed" proceed?  Something like (note the reworded warning message):

Yeah, I would have preferred to have "git reset" error out right now,
because the messed up work tree can be quite a pain to clean up. The
main argument for issuing the warning is about maintaining
compatibility.

For the users that really did mean "--merge", the warning is silly.
It's basically saying "We know that you're about to mess up your work
tree, but we let you mess up anyway. Learn the correct way so that you
don't mess up next time".

It actually doesn't seem too bad if we did make "git reset" to error
out (during a merge) right away. By erroring out, the command won't
cause some irreversible damage, and users don't lose data. Yes, it
breaks compatibility, but perhaps not in a bad way?

I'm really fine with either. Junio?
