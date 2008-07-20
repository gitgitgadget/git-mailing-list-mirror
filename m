From: "=?ISO-8859-1?Q?Steve_Fr=E9cinaux?=" <nudrema@gmail.com>
Subject: Re: [PATCH] Add a notice to the doc of git-ls-tree.
Date: Mon, 21 Jul 2008 01:22:58 +0200
Message-ID: <f35478f50807201622n282e7eefve94ae144bfb720a7@mail.gmail.com>
References: <1216592735-23789-1-git-send-email-code@istique.net>
	 <20080720230846.GH32184@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "=?ISO-8859-1?Q?Steve_Fr=E9cinaux?=" <code@istique.net>,
	git@vger.kernel.org
To: "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 21 01:24:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKiG3-0006wc-0X
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 01:24:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753228AbYGTXXE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 19:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753161AbYGTXXB
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 19:23:01 -0400
Received: from an-out-0708.google.com ([209.85.132.245]:8537 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752970AbYGTXXB (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 19:23:01 -0400
Received: by an-out-0708.google.com with SMTP id d40so335360and.103
        for <git@vger.kernel.org>; Sun, 20 Jul 2008 16:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=K3/ZMCDAgBQNzAe/F0Zfut65NVJ8HiOds371gfZeI+0=;
        b=WE+3WO7bS3j59vFxVHSLbb9AqqUgGzS3ha+qfgTBKdOThM+UXmez378GcWDMzFdYH6
         ZB5hRO61wWD+1JoZVF/f5YZDO73wdaZge4r9IQBtsrYLjdeNHKa1ymBgqvcKzLlQrnfx
         J6iQKqA0HBnt2cd5nBBSe9OQztnRPBv5sU97c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=IlfNZY4bHPZfMM1oKaWzKw0VWPal0UWz+UhY+o6KGtGrwgDYxSCY3AbqKfjn2gUYw6
         jDXbe7RexhoAGLnpkDhafWvHQBPtkijQlEcYoFaiXL9OGzB8ixFbPgYt+/GVen9dMYwC
         uA2WFQoB7qm29BE7N5zt73XVhs2IZ5HH+Mkb8=
Received: by 10.100.33.11 with SMTP id g11mr1497313ang.26.1216596178113;
        Sun, 20 Jul 2008 16:22:58 -0700 (PDT)
Received: by 10.100.250.10 with HTTP; Sun, 20 Jul 2008 16:22:58 -0700 (PDT)
In-Reply-To: <20080720230846.GH32184@machine.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89265>

> It's hard to make out what do you mean, the patch description is much
> clearer, paradoxically.

It is hard to explain such a strange behaviour with a description that
is both short and generic enough... But I agree with you. I just got
bitten by this and I thought it was important enough to be specified.

> Also, this in fact holds for the root tree
> instead of the parent tree, and the behaviour changes from "weird" to
> "simply broken" when you try to list a tree object that is _not_ the
> root project tree from within a subdirectory:
>
>        git$ git ls-tree HEAD Documentation
>        040000 tree 066c25e86a44d4c7bde2d3e9b91e6891d752efa1    Documentation
>        git/Documentation$ git ls-tree 066c25e86a44d4c7bde2d3e9b91e6891d752efa1
>        git/Documentation$
>
> I think that ls-tree simply shouldn't auto-fill its pathspec based on
> current prefix in case no pathspec was supplied. Patch to follow.

I also thought this behaviour was broken. But I didn't want to patch
it because I was afraid of breaking things that would rely on it,
despite it seems unexpected enough not to be used...
