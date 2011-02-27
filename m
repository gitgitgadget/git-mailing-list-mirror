From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Consistent terminology: cached/staged/index
Date: Sat, 26 Feb 2011 18:46:37 -0600
Message-ID: <20110227004637.GC20712@elie>
References: <AANLkTi=9OWqz66Ab6O9tc4eYSrhZZ1YC_+ta9sutAn30@mail.gmail.com>
 <20110213193738.GA26868@elie>
 <7v8vxjwnhj.fsf@alter.siamese.dyndns.org>
 <AANLkTim4UKxYwRagCk3R20e7wsRb7CxvS_ze9b8MfWjL@mail.gmail.com>
 <20110214231920.GA24814@elie>
 <AANLkTik-jc0ZX9S4bCYV8VBgPXJZsX0U08W2H+jufO8r@mail.gmail.com>
 <20110226215139.GA19176@elie>
 <AANLkTimyXciScc5K6ozggMHsy9YmgyOFpy6pgKBEypC9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Piotr Krukowiecki <piotr.krukowiecki.news@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 27 01:46:57 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtUmm-0003PM-PO
	for gcvg-git-2@lo.gmane.org; Sun, 27 Feb 2011 01:46:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751123Ab1B0Aqm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 19:46:42 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:46026 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750915Ab1B0Aqm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 19:46:42 -0500
Received: by vws12 with SMTP id 12so2309438vws.19
        for <git@vger.kernel.org>; Sat, 26 Feb 2011 16:46:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=8SMlmlmsujy7HQ6ZVgrdLwi2CeZnjjNHzBnmiRIUC44=;
        b=K+kJBXLVabPnpF7tmL4vW+4gymcghNFi0TacamLic/PvYCNTCAdk+XH6X1kar27vvd
         /J7v5tZ4qrgX3Pn1VUiofIvLWQQHtnLztXnYz+KB1tFpmk18SRuXWrMkJZJPOaR+6076
         0Q3AHVXXN9RSUMsJkvWlrjbByH3Z6O6HWEQj8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=DX52QdcgV6POfW16uB5+5CAUd84vNBjmIhoOFLD3vraZEAs/HQduudZNZyX57ZQqOA
         ZGT2w8j0vDRgoMQNpJCoWA6vBeBV7eAzelJmMQredh2vJFLn4uk65zCiWw2c9mMfBJfM
         zWiWbrQd+oxDuUM8bVI+uuIf5IuQZzy22xpNw=
Received: by 10.52.172.15 with SMTP id ay15mr2091906vdc.257.1298767601023;
        Sat, 26 Feb 2011 16:46:41 -0800 (PST)
Received: from elie (adsl-76-206-235-173.dsl.chcgil.sbcglobal.net [76.206.235.173])
        by mx.google.com with ESMTPS id cc8sm311099vdb.28.2011.02.26.16.46.39
        (version=SSLv3 cipher=OTHER);
        Sat, 26 Feb 2011 16:46:40 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <AANLkTimyXciScc5K6ozggMHsy9YmgyOFpy6pgKBEypC9@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168004>

Hi,

Felipe Contreras wrote:
[out of order for convenience]

> Why should the users care about the stat() information? Or how the
> merge conflicts are being tracked?

The second question is very easy to answer (depending on what "how"
means, of course).  Because people integrating changes from multiple
places need to be able to resolve a conflicted merge.

> That's plumbing, not porcelain.

I don't disagree.  The analogy is almost perfect.

And the thing is, in the real world, people know about plumbing.  They
don't care about the details, but they know there are these things
called pipes, and that water tends to flow downward, and that if one
of them freezes, it will burst.  This knowledge is useful.

Likewise, it is useful to know:

 - After you use "cp -a" to copy a repository, the first operation
   you perform is going to be slower.  The cached stat() information
   is stale.

 - Until you run "git add", there is only one copy of your data, in
   the worktree.  After you run "git add", there are two copies.
   Once you run "git commit", that second copy will last at least
   as long as your commit does.

   So there is some chance of recovery from fat-finger mistakes,
   even before a commit.

 - During a merge, you can mark your progress by collapsing index
   entries with 'git add'.  "git diff" will show the state of the
   merge.  You can read the competing versions of a file with
   "git show :2:path/to/file" and "git show :3:path/to/file".

 - Index-only operations tend to be faster, since

    (1) the cached blobs are not changing, so we can save time
        stat(2)-ing and read(2)-ing files
    (2) blobs are compressed: less I/O.  Longstanding blobs are
        in pack files: good caching and I/O patterns.

   So you can speed up your slow "git grep" by using
   "git grep --cached".

 - When scripting, you can use a temporary index file to avoid
   affecting the remembered worktree state.

But so what?  I have nothing against clearer terms.  I am just saying
that (1) we should be explaining these things somewhere and (2) a
global s/index/only one of the things the index does/ is a bad idea,
because it would make the documentation *wrong*.

> There's always resistance, but 1.8 is supposed to contain stuff as "if
> git was written from scratch".

I thought 1.8 was supposed to provide an opportunity to correct some
long-known mistakes that we had been holding back on for backward
compatibility reasons.  That doesn't mean we should forget the cost of
change.

Thanks for your work, and hope that helps.
Jonathan
