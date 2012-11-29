From: Martin von Zweigbergk <martinvonz@gmail.com>
Subject: Re: [RFC/PATCH 1/2] reset: learn to reset to tree
Date: Thu, 29 Nov 2012 14:00:16 -0800
Message-ID: <CANiSa6hWYsfm0t+s_q7=CcD78yNfpuduxkRc35xW8qDOy97W3g@mail.gmail.com>
References: <CANiSa6isDKAgxHWqh5XiQ-adT3-ASFtvAshp028DTcotjQxzmQ@mail.gmail.com>
	<1354213975-17866-1-git-send-email-martinvonz@gmail.com>
	<1354213975-17866-2-git-send-email-martinvonz@gmail.com>
	<7v4nk8qmaj.fsf@alter.siamese.dyndns.org>
	<7vzk20p6ik.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 23:00:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TeC9v-0007qE-3p
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 23:00:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754551Ab2K2WAT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 17:00:19 -0500
Received: from mail-ie0-f174.google.com ([209.85.223.174]:49717 "EHLO
	mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753239Ab2K2WAR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 17:00:17 -0500
Received: by mail-ie0-f174.google.com with SMTP id k11so12907736iea.19
        for <git@vger.kernel.org>; Thu, 29 Nov 2012 14:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=WmthJk8Fttpjcti0JDsQJRBPmf6N2s994yxvJbwirng=;
        b=jlxkrzY09D/FZ+V29zoM1JCECNG0uOwLdnmCme3PLrr4CyRKoCYdvy5Qx2R+jCRVtt
         mDhOwbhfd68z0h1ObjgIX+ftGQD4dCQPu1WcuH297ppGihWiZa/E545G3fc6b5ty6RPB
         b7TDg7OCIE+yCf0u/LNTUPDjt7wmrxFIh7bzpCuLQBbgYksAq6qYeY6GX8Wu42i3yKxi
         bCE97Oim3E1P1/Mb0zmK6RuHkU0XBoGA/4k7sWsOp+2hLqIIunnErZ+DEDx8E4gLfJrq
         nV/XXEqrHIxLwVWYIzYY+pbjQy9aj5mXivXaMAAHPYSr6teyw7cuSQha6tBk4kHxBrlx
         8drQ==
Received: by 10.50.7.234 with SMTP id m10mr24324040iga.43.1354226416732; Thu,
 29 Nov 2012 14:00:16 -0800 (PST)
Received: by 10.64.91.99 with HTTP; Thu, 29 Nov 2012 14:00:16 -0800 (PST)
In-Reply-To: <7vzk20p6ik.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210879>

On Thu, Nov 29, 2012 at 11:13 AM, Junio C Hamano <gitster@pobox.com> wrote:
> [...]These
> two commands, "reset" and "checkout", share that the source we grab
> the blobs out of only need to be a tree and does not have to be a
> commit, and the only difference between them is where the blobs we
> grabbed out of that tree go, either only to the index or to both the
> index and the working tree.

Slightly off topic, but another difference (or somehow another aspect
of the same difference?) that has tripped me up a few times is that
"git checkout $rev ." only affects added and modified files (in $rev
compared to HEAD), but "git reset $rev ." would also delete deleted
files from the index. I suppose this is also a partial answer to your
question in another message:

> What does it even mean, even when you are on an existing commit, to
> hard reset partially?
>
> Perhaps you looking for "git checkout $tree -- $path"?

A more direct answer would be that I would expect "git reset --hard
$rev -- ." to behave like "git reset --hard $rev", except that it
wouldn't update HEAD. It seems to me that that would be similar to how
"git reset $rev -- ." behaves like "git reset $rev", except that it
doesn't update HEAD. But reset and checkout with and without paths
still confuse me after years of using git, so I wouldn't be surprised
if I'm not making any sense.
