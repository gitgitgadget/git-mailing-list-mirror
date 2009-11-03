From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: git subtree issues
Date: Tue, 3 Nov 2009 11:43:37 -0400
Message-ID: <32541b130911030743i4dcd9e37q34ead6a4a9a9814c@mail.gmail.com>
References: <26159961.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: morgflast <daniel@sibblingz.com>
X-From: git-owner@vger.kernel.org Tue Nov 03 16:44:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5LYD-0006x1-Di
	for gcvg-git-2@lo.gmane.org; Tue, 03 Nov 2009 16:44:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751187AbZKCPny convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Nov 2009 10:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750928AbZKCPny
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Nov 2009 10:43:54 -0500
Received: from mail-yx0-f187.google.com ([209.85.210.187]:41272 "EHLO
	mail-yx0-f187.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750796AbZKCPnx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Nov 2009 10:43:53 -0500
Received: by yxe17 with SMTP id 17so5500020yxe.33
        for <git@vger.kernel.org>; Tue, 03 Nov 2009 07:43:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=tH486zQOOWGaNkYUP/7ui5yJpZNab4qkWy8xiH9Z3Gs=;
        b=N/IuYLWTunigXNXGApNFsBpGXswCLGGW3ADe/RrLPZK5Kzd9n+Fwa4qYYcWu7rXDHC
         0spLIiKOnXWmMXEheDnFNi6njPQEDYp3k7rYWS8L+culuL7xCJOy2i/NG3CYVDfW1lfT
         Mtz/oQW8ahDzghvfKfRlpKGonQ3VSJEP2L5Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Y2xwh/baUVkD2mQkzHGPN5g8QXKZWPPkPQ/NVLKv/++PSH9NKNNcPA1xADSnAaeZvk
         II+flh3l6UO0DPnnSwkDk/Cj7rSNKjc4FhsmJzGCGkt8oW0hW49Ggr0/ZuBpNp6H7Vao
         K7bs42C87uZkI60FopSEJU0vtIB2zBkYQdeHw=
Received: by 10.150.16.14 with SMTP id 14mr415188ybp.246.1257263037121; Tue, 
	03 Nov 2009 07:43:57 -0800 (PST)
In-Reply-To: <26159961.post@talk.nabble.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131974>

On Mon, Nov 2, 2009 at 11:56 PM, morgflast <daniel@sibblingz.com> wrote=
:
> git pull -s subtree vw_extensions master remote: Counting objects: 5,=
 done.
> remote: Compressing objects: 100% (3/3), done.
> remote: Total 3 (delta 2), reused 0 (delta 0)
> Unpacking objects: 100% (3/3), done.
> From git@github.com:sibblingz/vw_extensions
> =A0* branch =A0 =A0 =A0 =A0 =A0 =A0master =A0 =A0 -> FETCH_HEAD
> Already uptodate!
> Merge made by subtree.
>
> However, when I looked at the README file in the first project, the c=
hanges
> weren't there. =A0I was wondering if anyone might have any suggestion=
s about
> what to do.

Hmm, the output certainly wasn't very helpful :(

Usually what "already uptodate" means is that the commit it merged
didn't actually cause any changes.  Is it possible there's another
README file that already contained this change?

The other problem with subtree merge is that it tries to *guess* which
subtree you want to merge, which unfortunately fails almost as often
as it succeeds.  If it guessed incorrectly, it might have thrown away
all the directories except one that didn't change at all.  If this is
the problem, I don't have an easy fix; my git-subtree command (which
makes it a bit easier to do the things you're trying to do in your
email) suffers from this too.  Eventually I was thinking of giving in
and making subtree merge properly configurable, but I haven't had
time.

Or maybe this is a totally different problem.  What do you get from:

  git diff --stat $(git merge-base HEAD^ FETCH_HEAD) FETCH_HEAD

?

Avery
