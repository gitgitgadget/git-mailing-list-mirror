From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH] mergetools/p4merge: Handle "/dev/null"
Date: Wed, 19 Dec 2012 20:41:31 -0800
Message-ID: <CAJDDKr5rxUPzqkiNAhPpEkK4ajyPNkNsGdPYWca3oggBrWybmg@mail.gmail.com>
References: <1349925756-87801-1-git-send-email-davvid@gmail.com>
	<508B9F89.7050909@game-point.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeremy Morton <admin@game-point.net>
X-From: git-owner@vger.kernel.org Thu Dec 20 05:41:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TlXx9-0005YM-9W
	for gcvg-git-2@plane.gmane.org; Thu, 20 Dec 2012 05:41:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752462Ab2LTEle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2012 23:41:34 -0500
Received: from mail-vc0-f170.google.com ([209.85.220.170]:57461 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752217Ab2LTElc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2012 23:41:32 -0500
Received: by mail-vc0-f170.google.com with SMTP id fl11so3324561vcb.29
        for <git@vger.kernel.org>; Wed, 19 Dec 2012 20:41:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=8RvywE9Z921o6lmGenfpOj0YC5Ldos0GNPJ4ww5Dumw=;
        b=xl6qxQaJS4c9NN0GdbFCgkeoS7SaFOneP2VC0Z5hLUpwxTEJ11wzzkUOEAVHi9zez9
         ylrZIzDpYVQqj0D3+JjxAOc18A2bQZ+bkVewUTau4u7RapwVUT8YKmIFDEJzY2gERLTQ
         BuzKsaq714jCRkVV89UZNb6KEM/T2g84vHQNs18AmME3vqmVi+KXQhYhyyGqxqkpMZnx
         IdvqLqLwkiro7sx2QAzShr6htQ508qCcXoVsFjFJK1bSw29DDDRQ9yjj4GiE8xY3hP9s
         pvYu+LnEXFglhNpESC+SVXB2ucLpcyByGJxjycc03xWNWP60H+L/JwBbCnUR7+mr8Sbp
         GwXg==
Received: by 10.221.2.11 with SMTP id ns11mr12303771vcb.3.1355978492108; Wed,
 19 Dec 2012 20:41:32 -0800 (PST)
Received: by 10.58.182.10 with HTTP; Wed, 19 Dec 2012 20:41:31 -0800 (PST)
In-Reply-To: <508B9F89.7050909@game-point.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/211878>

On Sat, Oct 27, 2012 at 1:47 AM, Jeremy Morton <admin@game-point.net> wrote:
> Sorry to be replying to this so late; I hadn't noticed the post until now!
>
> I've tried putting that code in my p4merge script and yes it does indeed
> work fine.  However, it puts a temporary file in the working directory which
> I'm not sure is a good idea?  If we look at this patch which actually solved
> pretty much the same problem, but when merging and, during a merge conflict,
> a file was created in both branches:
> https://github.com/git/git/commit/ec245ba
>
> ... it is creating a temp file in a proper temp dir, rather than in the
> working dir.  I think that would be the proper solution here.  However, I
> really want to get this fixed so I'd be happy for this band-aid fix of the
> p4merge script to be checked in until we could get a patch more like the
> aforementioned one, at a later date, to create empty files in a proper temp
> dir and pass them as $LOCAL and $REMOTE.  :-)

I had the same thoughts when I wrote it, but I figured that following
the existing pattern used by mergetool for $REMOTE and $LOCAL when
they do exist was simpler as the first step.

I have a patch that fixes this by using mktemp that I will send shortly.
It only does it for the /dev/null file since the existing behavior for
files that do exist is fine.
-- 
David
