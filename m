From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: kernel.org git tree corrupt?
Date: Mon, 3 Mar 2008 10:40:15 +1300
Message-ID: <46a038f90803021340uf1c9c6te5501d9fb0565f19@mail.gmail.com>
References: <524f69650803020749o469f2e48l125a55267b0b5d13@mail.gmail.com>
	 <alpine.LFD.1.00.0803021302070.17889@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Steve French" <smfrench@gmail.com>,
	lkml <linux-kernel@vger.kernel.org>, git@vger.kernel.org
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 22:41:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVvvU-0003L9-SH
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 22:40:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757449AbYCBVkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 16:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757428AbYCBVkS
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 16:40:18 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:3011 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757092AbYCBVkQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 16:40:16 -0500
Received: by ug-out-1314.google.com with SMTP id z38so1604546ugc.16
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 13:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=J07bfzR8WPn9RmzElSJ4xC4ikHr0WgY1CTMcE/CNamo=;
        b=fvj6EYf8eHtKwBBy76lC2qD1OmJpEMzC4AnNZSQJ3CAVNXKy3RWGExqbonzVRrt8CjmMaC5yCXgACu9aNjkO1RHxbUI2B9dwfbgBnZqpR/rMbmFJuYwvS0IKfRQ+hApfAlghXn1E+AiEihZypS9RZGRfj38b2iO/m/aYqE/+xVE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Nq7yoqirsQQwRWjaKypZSG+P7tV7zZklqjIqUs2/+QdVPM/6jAua8La7kN6S55gjZoLuYWMnhSHRPq/86Q7bAu/v+7DVSxqtEc8+mjZKbUSBoXHiErfVf9HFuHXSIArVtLvAzYtWTl8yWLca4//CU6KoVKy9sRTz9j3q8BBWdoo=
Received: by 10.66.241.13 with SMTP id o13mr4142634ugh.57.1204494015364;
        Sun, 02 Mar 2008 13:40:15 -0800 (PST)
Received: by 10.66.252.6 with HTTP; Sun, 2 Mar 2008 13:40:15 -0800 (PST)
In-Reply-To: <alpine.LFD.1.00.0803021302070.17889@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75847>

On Mon, Mar 3, 2008 at 10:16 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>  In that case, your "origin" simply isn't updated, but points somewhere
>  long back in history. I can only assume that cogito has done something
>  wrong, like not been able to handle packed refs or something, and you have
>  an updated tree but "origin" pointing to way back in the history.

Strange - cogito over git protocol will use git itself to peek at the
references. Steve, what is your git version?

>  > Ideas for another solution short of recloning and sorting through all
>  > of the last month or two of patches that affect this directory by
>  > hand?

Linus' plan assumes you have a .git/config file. I don't think a
cogito-based checkout follows such modern conventions - here's an
alternative plan:

 - make sure you have a current git

 - get a fresh clone of linux-2.6, and in there

    # tell it about your old checkout
    $ git remote add oldlinux /path/to/your/older/linux/checkout/.git
    $ git fetch oldlinux
    # visualise what's in there
    $ gitk origin/master oldlinux/master

    # you may want to merge your old branch
    $ git merge oldlinux/master

hth,


martin
