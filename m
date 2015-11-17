From: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Subject: Re: [PATCH v1] blame: avoid checking if a file exists on the working
 tree if a revision is provided
Date: Mon, 16 Nov 2015 19:16:33 -0600
Message-ID: <CAOc6etbsqZ=gTGido2b3FXZyY+1JRkeF1O9pk37+7qOogaN6oA@mail.gmail.com>
References: <1447722437-14937-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: max@max630.net, Jeff King <peff@peff.net>,
	Edmundo Carmona Antoranz <eantoranz@gmail.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Nov 17 02:16:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZyUsw-0007jQ-BB
	for gcvg-git-2@plane.gmane.org; Tue, 17 Nov 2015 02:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752125AbbKQBQe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Nov 2015 20:16:34 -0500
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33200 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751786AbbKQBQd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Nov 2015 20:16:33 -0500
Received: by pabfh17 with SMTP id fh17so195649648pab.0
        for <git@vger.kernel.org>; Mon, 16 Nov 2015 17:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=jskSemX8PnwDUTLf6jU4yp+o0xm7rVDDqglA7dcPxto=;
        b=JpaleiQHVRIdgkox4PojpNRa6vZl893DEbTQJh1o2TGo/PLKGwFRPbDag6AhAQTFRW
         c5e67f3PB+YsXrsQO/hRgHcq5rv0fdwauWFjQ2yJ9U2dLhVBxUIJcQU3S27pMZFAd041
         TtOnvFVGeF4m44RL2SEqf57SlN5No3EfPzjMR7yxBHwTGzDwQAOxOe5/RG1c1nNukVe/
         sOhoiTPgS5E1rMWfScip3dwgoGqyowxp+UghiOP+PaLIEvJMdBfZ8oyK1Tf56CmUW72R
         nq1YLtGkUhJjAiM7Q8CZfUHYPiHA2nT18bG0vgToRzRlF+47W6SLA90hqI5VcicngL9X
         0C5w==
X-Received: by 10.66.62.202 with SMTP id a10mr58216954pas.131.1447722993448;
 Mon, 16 Nov 2015 17:16:33 -0800 (PST)
Received: by 10.66.97.70 with HTTP; Mon, 16 Nov 2015 17:16:33 -0800 (PST)
In-Reply-To: <1447722437-14937-1-git-send-email-eantoranz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281378>

On Mon, Nov 16, 2015 at 7:07 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> -               if (!file_exists(path))
> -                       die_errno("cannot stat path '%s'", path);

Two things:
1
What I would love to do is check if revisions were provided. Something like:

if (no_revisions() && !file_exists(path))
    die_errno("cannot stat path '%s'", path);

_but_ revisions are set up a little bit later. I don't know right now
if I could just move it up (I don't think it would be that simple
because I see there's some messing up with argv and argc in that 'if'
that encloses the lines I'm removing). Maybe it would make sense to
move the check for file existence to _after_ revisions have been set
up? Even without the check for revisions, it's behaving kind of the
way I mean it to. But I'm sure it'd be more elegant if I checked if
revisions were provided.

2 It makes sense to create test cases for this patch, right?

Looking forward to your comments. Thanks in advance.
