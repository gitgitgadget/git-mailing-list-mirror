From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] t4202 (log): add failing test for log with subtree
Date: Mon, 22 Apr 2013 23:30:21 +0530
Message-ID: <CALkWK0madWxOSraZw6u8U_afVeK8tyMB_+D59n1vSBmobxGqqg@mail.gmail.com>
References: <1366632487-28153-1-git-send-email-artagnon@gmail.com>
 <87ppxmogdv.fsf@linux-k42r.v.cablecom.net> <CALkWK0m6vwR9rNNw_GjF4MOK1GZfwjB8ZA5Y0Lo8LbvfAg0g3g@mail.gmail.com>
 <87wqruk2pj.fsf@linux-k42r.v.cablecom.net> <7vk3nupltx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Rast <trast@inf.ethz.ch>, Git List <git@vger.kernel.org>,
	Avery Pennarun <apenwarr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 22 20:01:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUL37-0003iF-Mv
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 20:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754222Ab3DVSBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 14:01:04 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:49807 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753838Ab3DVSBC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 14:01:02 -0400
Received: by mail-ie0-f177.google.com with SMTP id 9so7203917iec.8
        for <git@vger.kernel.org>; Mon, 22 Apr 2013 11:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=7BqCwdgJRFIQbZW1Q/E+quOAadFFNqA/2U5MBs9olCg=;
        b=IhxDUUJLJN+anSpnqUkw2vWoUT4S5XK7RWNZEpusz8EbgOwG7GTWlfN/7dYTCIxw2H
         48/ZPllOyGqBGEyrLsKvAUsODOgoL/8OfnwogVd7qlqAC/gqlxPTg0MVUj/8C+UednzF
         aKe2wWtfRfRgsvKRbYUWlp+bh/dHk30P5uN3VsF7O/wUvSuzQRGgLvPglSp6sCq/nPxq
         8n9/gKX3wti1XFf0W9e+r5PjqT/2F4rStrckxdggts1qBEZL35PghDMiD+FuyJQbT8kD
         dlCWSQ294e5Gly4xgff/7noO1gr1hvKZyT+1b5TVRUfkSBexMtJVY8gohSiHE5skZWTf
         zAHQ==
X-Received: by 10.50.50.71 with SMTP id a7mr21880781igo.14.1366653662045; Mon,
 22 Apr 2013 11:01:02 -0700 (PDT)
Received: by 10.64.63.48 with HTTP; Mon, 22 Apr 2013 11:00:21 -0700 (PDT)
In-Reply-To: <7vk3nupltx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222042>

Junio C Hamano wrote:
> [...]
>  (3) When (1) notices that the path being followed did not exist in
>      any of the parents (be it a merge or a non-merge) and finds a
>      different path with a similar looking content, it _switches_
>      the pathspec to it, but the single pathspec it uses is a global
>      state and affects traversals of other ancestry paths at the
>      same time.  Because of this, "--follow" will not work correctly
>      in a history that contains merges.  It often _appears_ to work
>      only by accident.

This explanation is all very nice, but isn't it completely tangential
to the issue at hand?

Let's say I have a subtree merge M located at HEAD~4.  I ask for the
log of 'HEAD~4 -- README' with --follow.  It follows until it gets to
M: at M, M^1:README is missing, but M^2:README is present.  Should it
follow down and show the history of M^2:README?

You can reserve the discussion about --follow working in the general
case for another thread.  Meanwhile, you're evading the issue of
assuming that all trees are read into /, and are really representing
the same project's history, while this is not the case.
