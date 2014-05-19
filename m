From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH] remote-helpers: point at their upstream repositories
Date: Sun, 18 May 2014 20:31:36 -0500
Message-ID: <53795ef8e4023_10da88d30825@nysa.notmuch>
References: <xmqqa9aid52a.fsf@gitster.dls.corp.google.com>
 <20140516084126.GB21468@sigill.intra.peff.net>
 <xmqq8uq1br9c.fsf@gitster.dls.corp.google.com>
 <20140516225228.GA3988@sigill.intra.peff.net>
 <5376f2ca5c90d_65b915db2f877@nysa.notmuch>
 <20140517062413.GA13003@sigill.intra.peff.net>
 <xmqq1tvq4r43.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 19 03:42:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmCbH-0008SB-4i
	for gcvg-git-2@plane.gmane.org; Mon, 19 May 2014 03:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752431AbaESBmn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2014 21:42:43 -0400
Received: from mail-oa0-f43.google.com ([209.85.219.43]:62406 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752221AbaESBmn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2014 21:42:43 -0400
Received: by mail-oa0-f43.google.com with SMTP id l6so5494570oag.16
        for <git@vger.kernel.org>; Sun, 18 May 2014 18:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Z394ewDfZHmOLO1OWt8r/h5OKVYNKzj2DyQmwbkfZDA=;
        b=MzyMzL+Q7+QO0UaOgPAKdM3OprKA9lAivEkaxI21MURbm47v1cfHv5NkH4IcHNQICz
         hg+A8JwJPn1KXhO93aSgtiDEniAPfO0fW4bit34UsjE8AnYlaS2pT8d/ohAHJ0YhOM4x
         jmJODHT1TFLd5Q6Uw4/lVc4j59AKN33ET3ModMAzhNCcbJ1po0whhvHhmW9wxH9gpEBw
         0VCjrvtRWowcE6e18m368edqRz/2sN2AWhCREBgK6ENhI052zydyGBJvXy8ZkJDzNWW+
         6vds1Dod/TCsMC4NilAe8y1NU3eB0H4dpaNE3nAHU6c7gLu35dZcNETxHNfZILpiFtQ7
         UlUA==
X-Received: by 10.182.38.199 with SMTP id i7mr5297435obk.68.1400463762651;
        Sun, 18 May 2014 18:42:42 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id cb5sm18433741oec.11.2014.05.18.18.42.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 May 2014 18:42:41 -0700 (PDT)
In-Reply-To: <xmqq1tvq4r43.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249559>

Junio C Hamano wrote:
> My suggestion to rename the directory without smudging the scripts
> was meant to be a step that can come before that step, and I think
> its necessity is debatable.  It depends on how gradual a transition
> you want to give, and being always the more cautious type,

> I think having such a step will give packagers who pay attention to
> what they package and users who pay attention to what they install
> without packaging an early chance to notice and prepare.

Immaginary packagers.

>  - The "always warn" does not force update at the point of use, but
>    it still does not help them to notice well before they try to use
>    it for the first time after update;

I don't understand this sentence. They will see a big fat warning every
time they run the tool, of course they'll notice.

>  - "Break the build" attempts to help them notice when they try to
>    update, not when they need to use the updated one right at this
>    moment.

This cannot be done.

> But I am fine with an expedited transition schedule without the
> "break the build" step.  That was an optional first step, because
> "warn but still work" state we must have before the endgame will
> give the users the choice of when to adjust anyway.
> 
> I also thought about adding an extra step to have even more gradual
> transition, by the way.  A step before the endgame will ship these
> scripts without anything but "instruct and fail" (this is not "warn
> and fail", as it is too late "warn", as the scripts are crippled not
> to work at this point).
> 
> That will still force the user to update at the point when the user
> needs to use it, but seeing the instruction (e.g. "run this curl
> command to fetch from this URL and store it in a file called
> git-remote-xx on your $PATH") that is easy to follow immediately
> would be better than seeing only a failure (i.e. "remote-hg not
> found"), having to go fish the README, visiting the GitHub pages
> and figuring out how to fetch and install the script, which would
> be what the user will get with "README only, no scripts" endgame.

I don't see what's so complicated about this:

  WARNING: git-remote-hg is now maintained independently.
  WARNING: For more information visit https://github.com/felipec/git-remote-hg

They click that URL, and the are immediately greated with this:

  To enable this, simply add the git-remote-hg script anywhere in your $PATH:

    wget https://raw.github.com/felipec/git-remote-hg/master/git-remote-hg -O ~/bin/git-remote-hg
    chmod +x ~/bin/git-remote-hg

Clearly you haven't even bothered to visit the home pages of the
projects you threw to the wolves.

> So to summarize, the following timeline is a full possibility:
> 
>   1. (optional) break the build by renaming directory and add
>      README. Include not just the repository URL but a blob URL
>      and instruction to download via wget/curl.

That won't break the build.

>   2. add warning that is given every time the scripts are run and
>      give the same instruction as in README.
> 
>   3. (optional) cripple the script to make them always fail after
>      showing the same warning as above.

This is what I want, and I already sent the patches for; the scripts
will be stubs. At this point you would have effectively removed the
code, which what I want.
 
>   4. Keep README and retire everything else.

After you've removed the code, I don't care what you do, but I'd say you
should remove the stubs after a long period of time.

-- 
Felipe Contreras
