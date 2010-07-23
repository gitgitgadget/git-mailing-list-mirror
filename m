From: Will Palmer <wmpalmer@gmail.com>
Subject: Re: rfc - Changing the way gitk and git-gui are managed
Date: Fri, 23 Jul 2010 07:54:58 +0100
Message-ID: <1279868098.2846.45.camel@dreddbeard>
References: <7vocdygbw0.fsf@alter.siamese.dyndns.org>
Reply-To: wmpalmer@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 23 08:55:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OcCA3-00016b-EZ
	for gcvg-git-2@lo.gmane.org; Fri, 23 Jul 2010 08:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751344Ab0GWGzE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Jul 2010 02:55:04 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:32961 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750788Ab0GWGzC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jul 2010 02:55:02 -0400
Received: by wwj40 with SMTP id 40so4236759wwj.1
        for <git@vger.kernel.org>; Thu, 22 Jul 2010 23:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:date:message-id:mime-version
         :x-mailer:content-transfer-encoding;
        bh=9IuJb8C25DV+2fcrujA8BRYxB8mRqe+Ox8I+o/R5ACQ=;
        b=DaH6pcVTpu9Yp1kWszMPnQ4k+vX4DNDICltP7UaoR7k9pVdgaCZ5W5bZnC34JmJDUb
         yN7yq/5HSH6el577swhpUYl3RyTAj5S7RbiERGXnWcH51cyCR/uSyFiQwh88VsGD34P9
         NR2zEHe7D7XfOkMqXPBCLP7HhsiK/NP+S9bhg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :date:message-id:mime-version:x-mailer:content-transfer-encoding;
        b=p9CmuzodLdLMMno00P7Rlj5T4aFdMwXMCQikgGBi2BZRPVK3bpe5aZeLIkUSSg5rYI
         WgAYyCb1tja2xWNwBmCcz4EC29B0Js6uIerSa4KKkQ6J4h67ZLFUJmjO5LhqSntsXRJB
         Cc6lr63FB4Kuxlh4htdBCozlXjeriCCR48WYU=
Received: by 10.216.185.72 with SMTP id t50mr2983951wem.77.1279868101221;
        Thu, 22 Jul 2010 23:55:01 -0700 (PDT)
Received: from [192.168.0.254] (5acc3a9a.bb.sky.com [90.204.58.154])
        by mx.google.com with ESMTPS id p82sm4516078weq.3.2010.07.22.23.55.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 22 Jul 2010 23:55:00 -0700 (PDT)
In-Reply-To: <7vocdygbw0.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/151505>

On Thu, 2010-07-22 at 19:39 -0700, Junio C Hamano wrote:
> Somebody off-list suggested removing gitk and git-gui directories from my
> repository and I've been playing with the idea and kind of like the end
> result.
...snip...
> 
> I am wondering what people think.
...snip...

I really like the idea of using submodules, though only so that they
will almost certainly get the UI attention they deserve. Indeed, in my
mind that attention is needed enough that this sort of switch shouldn't
be made until it's been given for a while.

The problem is that, unlike so much of git, submodules make themselves
known. They're loud, they're in the way, they require management to
work. Case in point:
"Switching from 1.7.2 to this tree will of course give you a tree
without gitk and git-gui (nothing a simple "git submodule init/update"
cannot fix)"

So already in order to build a working git again, someone needs to
manually run some extra commands, which could potentially (but not
necessarily) download a bunch of objects they already have. Basic
operations like switching branches, get an extra (and easily overlooked)
burden, to which there is sometimes no obvious solution Ouch.

I've always hated how clunky and non-transparent submodules are. There
are some serious issues which would need to be worked out in order to
make them more transparent (not the least of which is "to be
transparent, where do you put the extra data, and when do you put it
there / when do you remove it?". I do wish that these issues would get
resolved, and it's hard to give them the attention they need because [I
assume, like me] the people who don't like them simply avoid using
submodules, as "just track everything" just sounds more like the git
way.

Git is simple. It's easy to understand because of some simple
assumptions and definitions. Submodules are less-simple. There are a lot
of edge-cases and a lot of not-so-edge cases which need to be looked out
for in order to make them sane. Handling the tricky-but-common cases by
putting it on the user to always hand-hold the VCS is stupid and broken.

What do people really want which a move to submodules would get them?
  - Sub-Projects can obviously be developed separately (no need to clone
all of git in order to work on gitk, for example)
  - Merges that make more sense, since you don't need to pass special
"subtree" options, all you need to do is update the commit which gitk
points to. This ignores that merges across the submodule/subtree
boundary will not work, and similarly changes which span submodules have
no way of being blamed or sanely merged.

It certainly doesn't help that whenever I think about "how to fix
submodules", the more I think about them, the less I think they make any
sense at all. [rant deleted]

Put me down as: I've wanted to use submodules in the past, and I like
the idea of using them in the future, but I've yet to be at the point
where I wanted to use submodules "now".

-- 
-- Will
