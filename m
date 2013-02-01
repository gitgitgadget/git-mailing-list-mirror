From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [PATCH 1/3] git-am: record full index line in the patch used
 while rebasing
Date: Thu, 31 Jan 2013 22:25:40 -0800
Message-ID: <CANiSa6gV=C188ZeaPrhdNdG+iPZ_DuBBbYgM0bT55KNOr03rAA@mail.gmail.com>
References: <20130130224904.GB1053@book.hvoigt.net>
	<1359693125-22357-1-git-send-email-gitster@pobox.com>
	<1359693125-22357-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 07:26:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U1A4a-0000yT-5U
	for gcvg-git-2@plane.gmane.org; Fri, 01 Feb 2013 07:26:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568Ab3BAGZn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2013 01:25:43 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:51770 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab3BAGZl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Feb 2013 01:25:41 -0500
Received: by mail-bk0-f46.google.com with SMTP id j5so1687290bkw.5
        for <git@vger.kernel.org>; Thu, 31 Jan 2013 22:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=8pPMAQua6EzYGz8RD6Iz1Ro0mnyFSib4DKEzl3LOsYs=;
        b=qa8wO83YsOvsYFf/Qjx79DKiD7vljrlf7vDz8gMI2JXFpzvvzF1bc22x0FBbSHV0Fa
         YItr3lrzbGeo1XMyJa+GRdzBY3QIIZb4KPf9Tz+0YQbr1DEERZu127nlOLWqVrxcJHXB
         I7z8DQ0JJNeJnkX0QWYlqgYMcKWw6LCfQfudFhDzZDINyWij2Z+lpcRwWFMiRYePLEgu
         lMTqUjZk65wYaRkRsABxrve01yCJ/qbDZufCqolrcIk7JMjaBb8KMMoOFuEevDtm0STk
         X8EC98X7cFeaj1l1DmRhG+nX1KhBL0GpbaCJdJZtr5/9vw48gxUHuh0gWEo7g91DFV+O
         tkJw==
X-Received: by 10.204.145.219 with SMTP id e27mr2965322bkv.140.1359699940620;
 Thu, 31 Jan 2013 22:25:40 -0800 (PST)
Received: by 10.204.15.10 with HTTP; Thu, 31 Jan 2013 22:25:40 -0800 (PST)
In-Reply-To: <1359693125-22357-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215210>

On Thu, Jan 31, 2013 at 8:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Earlier, a230949 (am --rebasing: get patch body from commit, not
> from mailbox, 2012-06-26) learned to regenerate patch body from the
> commit object while rebasing, instead of reading from the rebase-am
> front-end.  While doing so, it used "git diff-tree" but without
> giving it the "--full-index" option.
>
> This does not matter for in-repository objects; during rebasing, any
> abbreviated object name should uniquely identify them.
>
> But we may be rebasing a commit that contains a change to a gitlink,
> in which case we usually should not have the object (it names a
> commit in the submodule).  A full object name is necessary to later
> reconstruct a fake ancestor index for them.

>From what I can understand, this all makes sense. I didn't notice the
emails about the breakage until now, but I wouldn't have known where
to even start looking anyway, so thanks a lot for taking care of it.
