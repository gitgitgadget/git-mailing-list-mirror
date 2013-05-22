From: Matt McClure <matthewlmcclure@gmail.com>
Subject: override merge.ff = false using --ff-only
Date: Wed, 22 May 2013 09:21:23 -0400
Message-ID: <CAJELnLFqzVBd57vudsCFrTNMVxETO75GT5T5NO0sDMtgHZJU6g@mail.gmail.com>
References: <CAJELnLEGCshD9z9get62+T6Z83OdPJ+A5BNSzsHA1_OC1Q00Hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 22 15:21:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uf8yu-0003Nb-E3
	for gcvg-git-2@plane.gmane.org; Wed, 22 May 2013 15:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754930Ab3EVNVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 May 2013 09:21:24 -0400
Received: from mail-pb0-f54.google.com ([209.85.160.54]:60779 "EHLO
	mail-pb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753900Ab3EVNVY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 May 2013 09:21:24 -0400
Received: by mail-pb0-f54.google.com with SMTP id ro12so1693537pbb.13
        for <git@vger.kernel.org>; Wed, 22 May 2013 06:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type;
        bh=g6zKLH9qIvPeqipb6EPiUK1bDjkJfw7BHWGvXBys2P0=;
        b=dP1yrKVBlXF9ErCtn3YYbPs70XdLncik8GoDPjJ1xR6npDpASTnv7uW3xsK9ComYjE
         SiSflo2+fhqWRhIVQ0Xd8/sM0jKc3wGRZPtVXfavYHLMXZjoLCUhKm8Ii+gpoSlvAt0T
         dzcJfPgHSLl7Dtf4Q/M3JSMr0DKLXA+OKgfcwZ9/SiHKcbl4AePWgLdggK4ueko7OBSy
         6KylEx5qzdlF9cOVgE5NC5jYHzjChkFE8X5uKZjrVMpHxlV4TDWhsF+QogQo5Xx0CI+a
         4c9CyIhycv8nSIm5yF84JBXDqwNKKZWBJUJTrk2mD/gbHvbm5Zr6hPnUQ30vJ2qLZUBG
         NqPA==
X-Received: by 10.66.162.161 with SMTP id yb1mr8071669pab.213.1369228883467;
 Wed, 22 May 2013 06:21:23 -0700 (PDT)
Received: by 10.68.15.98 with HTTP; Wed, 22 May 2013 06:21:23 -0700 (PDT)
In-Reply-To: <CAJELnLEGCshD9z9get62+T6Z83OdPJ+A5BNSzsHA1_OC1Q00Hw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225153>

I naively tried to override merge.ff = false using --ff-only on the
command line. I expected that it would override the configured default
and perform a fast-forward merge. Instead, it said:

    $ git config -l | grep -F 'merge.ff'
    merge.ff=false

    $ git merge --ff-only foo
    fatal: You cannot combine --no-ff with --ff-only.

On the other hand, I see that --ff works just fine in the same initial state.

    $ git merge --ff foo
    Updating b869407..17b5495
    Fast-forward
    ...
     4 files changed, 2 insertions(+), 5 deletions(-)

Would it be better if --ff-only refused to merge only if the commits
themselves prevented fast-forwarding?

--
Matt McClure
http://matthewlmcclure.com
http://www.mapmyfitness.com/profile/matthewlmcclure
