From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Branch deletion (Re: [RFC] fast-import: note deletion command)
Date: Sun, 18 Sep 2011 16:49:54 -0500
Message-ID: <20110918214954.GL2308@elie>
References: <CA+gfSn9sdTzQghqQp6hcO-9kN9mPx2JLRig79Rgx2FqGWXXp=A@mail.gmail.com>
 <20110918203506.GG2308@elie>
 <CAGdFq_hpA95Kj4eMr4e1duuXTpr+OkkwF4K5bTapXEi9UjWcSA@mail.gmail.com>
 <20110918211836.GI2308@elie>
 <CAGdFq_gH=u1BU6k3Z23Lo9mOSE4Rq-6nWU0EE91CQNpxksGw5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dmitry Ivankov <divanorama@gmail.com>,
	Git List <git@vger.kernel.org>,
	David Barr <davidbarr@google.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Thomas Rast <trast@student.ethz.ch>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun Sep 18 23:50:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5PFY-00050f-3H
	for gcvg-git-2@lo.gmane.org; Sun, 18 Sep 2011 23:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932656Ab1IRVt6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Sep 2011 17:49:58 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62432 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932255Ab1IRVt5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Sep 2011 17:49:57 -0400
Received: by iaqq3 with SMTP id q3so4589694iaq.19
        for <git@vger.kernel.org>; Sun, 18 Sep 2011 14:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QvQsRr1CgJsvVBgXzgX7tB2Y2ZDeQq8dpQtZTbEOiwk=;
        b=fQBwRZrKOatBBoEPYD71uLJC3hfnHOGZY0WrC66OjQ4H40r7OuOna9/pRN64H9MZQm
         Qm6YOJXfnw9In4V5dl5w5K+WA9LpjEOcdSgjBX+cEkarBp3RMolVD95B2lPhd8z2snPe
         TYUdvOVTc0ZN3+mawg/FppjDlJHK3Ol+b9EuY=
Received: by 10.42.168.198 with SMTP id x6mr3168001icy.148.1316382597367;
        Sun, 18 Sep 2011 14:49:57 -0700 (PDT)
Received: from elie (99-120-124-35.lightspeed.cicril.sbcglobal.net. [99.120.124.35])
        by mx.google.com with ESMTPS id j2sm22415735ibx.11.2011.09.18.14.49.56
        (version=SSLv3 cipher=OTHER);
        Sun, 18 Sep 2011 14:49:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAGdFq_gH=u1BU6k3Z23Lo9mOSE4Rq-6nWU0EE91CQNpxksGw5w@mail.gmail.com>
User-Agent: Mutt/1.5.21+46 (b01d63af6fea) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181649>

Sverre Rabbelier wrote:

> The problem currently is that when
> you try to "git push origin :experimental-branch", there is no way for
> the transport-helper code to tell the helper to delete the ref.

Ah!  Thanks for explaining.

It also occurs to me that

	reset refs/heads/experimental-branch

	... rest of the fast-import stream comes here ...

could be used as an especially non-self-explanatory way to express
this kind of thing. :)  No idea whether that works already.  A
deleteref command and deleteref feature documented to be meant for
this purpose sound handy to me.

By the way, what does the "export" command do in the following
situation?

	git push origin something-big:master

Does it assume the remote-tracking branch for master reflects what's
available on the other end and send a stream for
origin/master..something-big, or does it send the entire history of
something-big?
