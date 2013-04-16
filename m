From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [Resend PATCH] t3903 (stash): add failing test for ref of form ^{/message}
Date: Wed, 17 Apr 2013 01:41:30 +0530
Message-ID: <CALkWK0=L4mqVBqDMWgzN+BT5bnEF0L6d=GPXvrNhPL_Asvdq8Q@mail.gmail.com>
References: <1366135765-18437-1-git-send-email-artagnon@gmail.com> <CA+sFfMfkoBcoPvJSYBGUe46EbMfiC7q6tVZs6db2NHrEb2gb7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Brandon Casey <drafnel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 16 22:12:19 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USCEj-0000si-Aa
	for gcvg-git-2@plane.gmane.org; Tue, 16 Apr 2013 22:12:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936115Ab3DPUMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Apr 2013 16:12:12 -0400
Received: from mail-ia0-f170.google.com ([209.85.210.170]:43446 "EHLO
	mail-ia0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S936095Ab3DPUML (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Apr 2013 16:12:11 -0400
Received: by mail-ia0-f170.google.com with SMTP id 21so580916iay.1
        for <git@vger.kernel.org>; Tue, 16 Apr 2013 13:12:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=pFABTZmAveDXkCFwDD7ORWvICP7BzwpU2nw4B/c0Ozg=;
        b=WgFrjT5VHyPJnWLYVtzmcVZcQPtwIfrkAXPNPkWJwRnSCeur5gFeob8X+avS113Bls
         TD9nHU5XX9RNszi0W2qf8cVjF93lYNwrKzZo7FZKVvqAYy4cHDICJl0uLotcPTLMnxbi
         R47juTzmFt8o2DjDlTWF/O+UyAw0WzJUWs3PQzBbqsksvHMpLP9Jh27Ec77BJEfa6h1Y
         9DFIhm92f4Uy2whgv0U1mvMoZWYAUuaH/axJ3PP9mdZRtHpUM5bwkxD+USoHlchTMyOq
         Vx5fK9pNON7qBiXwnZRudjPdutZkDLoFnjyxi7gJjlT5JSUrMO0Y9Zd8/TaaET/UKz1r
         a6Ow==
X-Received: by 10.50.119.102 with SMTP id kt6mr2410218igb.12.1366143131026;
 Tue, 16 Apr 2013 13:12:11 -0700 (PDT)
Received: by 10.64.34.80 with HTTP; Tue, 16 Apr 2013 13:11:30 -0700 (PDT)
In-Reply-To: <CA+sFfMfkoBcoPvJSYBGUe46EbMfiC7q6tVZs6db2NHrEb2gb7Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221463>

Brandon Casey wrote:
>             # Save another stash here
>
>             echo bash >file
>             git add file
>             git stash save "something"
>
>             # Now git stash show stash^{/quuxery} no longer works.

Ah, yes.  My stupidity.  Why was I expecting ^{/quuxery} to dig
through the reflog?

> An extension to the reflog dwimery that implements @{/<text>} could be
> interesting though.

Yeah, this sounds interesting.

My initial itch that led up to this: I wanted a way to stash something
away and recover it at a later time predictably for rebase.autostash
(there might have been other stash invocations in between).
Originally, I thought I'd need a refs/stashes/* or something of the
sort to solve this problem, but git-stash.sh hard-codes refs/stash
everywhere (and so do other things like reflog).  So, I was thinking
about retrieving it based on commit message, but the solution is still
short of ideal.  What are your thoughts on my original refs/stashes/*
idea?
