From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Re: I have end-of-lifed cvsps
Date: Thu, 12 Dec 2013 14:08:33 -0500
Message-ID: <CACPiFCJ22xiedXAoQktMLd=gASgD0NS24Pya9TvCo9aQP5JaBQ@mail.gmail.com>
References: <20131212001738.996EB38055C@snark.thyrsus.com> <CACPiFCK+Z7dOfO2v29PMKz+Y_fH1++xqMuTquSQ84d8KyjjFeQ@mail.gmail.com>
 <20131212042624.GB8909@thyrsus.com> <CACPiFC+bopf32cgDcQcVpL5vW=3KxmSP8Oh1see4KduQ1BNcPw@mail.gmail.com>
 <20131212171756.GA6954@inner.h.apk.li> <20131212182932.GB16960@thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Andreas Krey <a.krey@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raymond <esr@thyrsus.com>
X-From: git-owner@vger.kernel.org Thu Dec 12 20:09:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VrBd7-0003bq-Nv
	for gcvg-git-2@plane.gmane.org; Thu, 12 Dec 2013 20:09:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752502Ab3LLTI5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Dec 2013 14:08:57 -0500
Received: from mail-vb0-f50.google.com ([209.85.212.50]:46782 "EHLO
	mail-vb0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752462Ab3LLTIz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Dec 2013 14:08:55 -0500
Received: by mail-vb0-f50.google.com with SMTP id w18so603539vbj.37
        for <git@vger.kernel.org>; Thu, 12 Dec 2013 11:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=UjwtIvvZr6qNQbDKjaCsQAk1cnU/L6Iw5NFIJ398hck=;
        b=ZWvTzS/sRc4Pl89yR79Noj/E9bfMzg+jpBwB24KyN1jy9hI1IdG5fKO8XZZbseVc/S
         lpQr6jmacDK7yIzW50r1OEuU1EbkNjuf6lhXLsXLUMcoWpVC6HTBer7kjQJIJElKg+Li
         5rh7WVaaoWtauhw4uUDiwC1bx57/h3Unr63smSUXTXmbPYNqIQqZgTO7+ZBfjSbYFgRF
         eqb93r9YHXdv/pbLAknUycLvVe1u6WexwfIs1PqIczvyrCsNpN+Ug6pJiyj1iTt0jt85
         Odye4W94Hj8RvchF01MY39fd5LFrbTicyTzu0LMRfDm26LA+PZpU3mT8mOk7ksMFcQwD
         26Dw==
X-Received: by 10.58.11.73 with SMTP id o9mr4644868veb.8.1386875334328; Thu,
 12 Dec 2013 11:08:54 -0800 (PST)
Received: by 10.220.74.133 with HTTP; Thu, 12 Dec 2013 11:08:33 -0800 (PST)
In-Reply-To: <20131212182932.GB16960@thyrsus.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239237>

On Thu, Dec 12, 2013 at 1:29 PM, Eric S. Raymond <esr@thyrsus.com> wrote:
> I am almost certain the output of cvs-fast-export is stable.  I
> believe the output of cvsps-3.x was, too.  Not sure about 2.x.

IIRC, making the output stable is nontrivial, specially on branches.
Two cases are still in my mind, from when I was wrestling with cvsps.

1 - For a history with CVS HEAD and a long-running "stable release"
branch ("STABLE"), which branched at P1...

   a - adding a file only at the tip of STABLE "retroactively changes
history"  for P1 and perhaps CVS HEAD

   b - forgetting to properly tag a subset of files with the branch
tag, and doing it later retroactively changes history

2 - you can create a new branch or tag with files that do not belong
together in any "commit". Doing so changes history retroactively

... when I say "changes history", I mean that the importers I know
revise their guesses of what files were seen together in a 'commit'.
This is specially true for history recorded with early cvs versions
that did not record a 'commit id'.

cvsps has the strange "feature" that it will cache its
assumptions/guesses, and continue incrementally from there. So if a
change in the CVS repo means that the old guess is now invalidated, it
continues the charade instead of forcing a complete rewrite of the git
history.

Maybe the current crop of tools have developed stronger magic than
what was available a few years ago... the task did seem impossible to
me.

cheers,




m
-- 
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
