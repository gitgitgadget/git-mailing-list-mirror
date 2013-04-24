From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [BUG] Highly inconsistent diff UI
Date: Wed, 24 Apr 2013 22:21:20 +0530
Message-ID: <CALkWK0mVDT5ESnVJAWQ83gQnmxmGDoM_Y0nE4FGybcjcenA_KA@mail.gmail.com>
References: <CALkWK0n2ZZTgYxi3Fk2UxY8TXFAt1Xt3+11G98GKxbYdoMOT+Q@mail.gmail.com>
 <7va9ong9oa.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 24 18:52:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UV2vR-0004n1-7q
	for gcvg-git-2@plane.gmane.org; Wed, 24 Apr 2013 18:52:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756988Ab3DXQwD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Apr 2013 12:52:03 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:41572 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754978Ab3DXQwA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Apr 2013 12:52:00 -0400
Received: by mail-ie0-f171.google.com with SMTP id e11so2392043iej.2
        for <git@vger.kernel.org>; Wed, 24 Apr 2013 09:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=N7yPspDxIbDeqLFNU9F8kB0pZmuSiQwbU+36VjSpqDM=;
        b=rAnCebfSIPcx+riNeoWhllAZ2AZYc2GrPWo5EFnK3Fhxku4CemG0cmK4GZvfxYNqg4
         xJL4j4chkq31YUwNYSi89Qgty/bfT2zhCyLoPSy8Ok/mJRzkVVq0J6UwqjlkaC419uaL
         xiPJ/iQ0DT4xDD3RWCZI4rtHb58lz4tt6QGbkOp8GA0RmMP0u35IIsjmK9KDiG4UuBLg
         QN93/usPanhgMNXYVxeA9cf2KmH6VQobq2S+ekhKdAJKWQbOF+bkHNoCks0D9YEMx6+n
         j081PpOFtw6IIrR2I+YGY/gnI3VTvQjBY82/YEG3UvpCiKTpWPkxWzk9mXoAJEH6yavz
         hkRg==
X-Received: by 10.42.27.146 with SMTP id j18mr7995730icc.54.1366822320448;
 Wed, 24 Apr 2013 09:52:00 -0700 (PDT)
Received: by 10.64.46.1 with HTTP; Wed, 24 Apr 2013 09:51:20 -0700 (PDT)
In-Reply-To: <7va9ong9oa.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222271>

Junio C Hamano wrote:
> The first thing to do is to eradicate "diff A..B" from the
> documentation, and a dozen or more lines in your complaint will go
> away with that single change.
>
> As you know, diff is about two endpoints, and A..B is not a way to
> specify two endpoints, and not erroring it out whenever we see a
> negative revision is a mere courtesy to old timers who knew the
> command line parser was shared with rev-list machinery.
>
> There is no reason to forbid the syntax, but encouraging its use is
> counterproductive and will lead to confusions to new people as you
> pointed out.

Excellent.  I agree wholeheartedly with this reasoning.

> The only issue is to come up with a concise alternative way to
> express "diff A...B", perhaps "diff --compare-with-base A B", and
> then you can choose not to say anything but an object name (and no
> range notation) on the command line (if you do not "diff A...B", it
> can already be done by not using "diff A..B").

What are your thoughts on inventing a new syntax A~B = $(git
merge-base A B) B which can be used by both range commands like log
and non-range commands like diff ?  (In other words, why shouldn't log
be able to do this?).  Does it matter which merge base we pick though?
