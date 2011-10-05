From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 5 Oct 2011 09:11:47 -0400
Message-ID: <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
	<CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 15:11:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBRGM-0006vu-Gj
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 15:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934668Ab1JENLt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 09:11:49 -0400
Received: from mail-gx0-f174.google.com ([209.85.161.174]:63238 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934332Ab1JENLs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 09:11:48 -0400
Received: by ggnv2 with SMTP id v2so734595ggn.19
        for <git@vger.kernel.org>; Wed, 05 Oct 2011 06:11:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/BKQChZjHnJZBnyLB5FL5TgSORf+YoWHPP/puyTWTW0=;
        b=m0lE+iPDXY4TbiIGisPJ3kUI0SqrRP+3+26LrnF3u3liWoSBED9BnZQn5JoJu7WNz2
         TK4EG2Yu6wWhG7umiP3lFz/dNdnrrrVUPjgC2NqM0aGd+OSRwEdcT7LUnsryflDjfpkq
         21g7B/e7aOcLc4MJ+33z01sb1hQWTDtmUPyqo=
Received: by 10.236.155.1 with SMTP id i1mr13765439yhk.8.1317820308000; Wed,
 05 Oct 2011 06:11:48 -0700 (PDT)
Received: by 10.147.32.18 with HTTP; Wed, 5 Oct 2011 06:11:47 -0700 (PDT)
In-Reply-To: <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182841>

On Wed, Oct 5, 2011 at 12:02 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> Could you please consider a more generic approach? What I have in mind
> is a mechanism to "lock" a branch, so that only commands that have the
> key can update it.
>
> So instead of branch.<name>.checkout, I would have something like
> branch.<name>.locked = <key>, where <key> is just a string. Only
> commands that provide the matching <key> are allowed to update the
> branch. In checkout case, <key> could be "checkout: worktree".

In this case, each workdir needs its own key, so I'd have to record
the key somewhere, unless you meant using a key of "checkout:
</path/to/workdir>".

> This approach addresses more cases than just multiple workdir. We
> could relax restrictions on pushing to a non-bare repository: we only
> disallow pushing to locked branches.

Isn't that another case where you only care if the branch is checked
out and where? So using "branch.<name>.checkout = </path/to/workdir>"
should be fine there too.

> We can also use this to prevent
> users from checking out another branch (by locking HEAD) while in the
> middle of interactive rebase/bisect/...

I dunno, that seems like a really different use case.

j.
