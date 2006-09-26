From: Luben Tuikov <ltuikov@yahoo.com>
Subject: Re: [PATCH] gitweb: "raw" links to blobs at HEAD
Date: Tue, 26 Sep 2006 11:53:26 -0700 (PDT)
Message-ID: <20060926185326.10590.qmail@web31810.mail.mud.yahoo.com>
References: <7v8xk7rup3.fsf@assigned-by-dhcp.cox.net>
Reply-To: ltuikov@yahoo.com
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 26 20:53:59 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSI3n-00046r-R2
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 20:53:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWIZSx2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 14:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932172AbWIZSx2
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 14:53:28 -0400
Received: from web31810.mail.mud.yahoo.com ([68.142.207.73]:4958 "HELO
	web31810.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932168AbWIZSx1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 14:53:27 -0400
Received: (qmail 10592 invoked by uid 60001); 26 Sep 2006 18:53:26 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Reply-To:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=pqC2mXYjGEtVuKR2MBnXn35vbqfhP1BUiwHaPfEDvjlYLopxc+VNebdm167RJToUk+lSqbRbSlftEGKhEKQsEC8Rd2qXBcVPp0XtcmaCiRngaZLYiEAghDQIytAHv8OlPDBeD6zxGa4a5LCy7IUFUBWclEqwTMCY9lyL+XfnlC0=  ;
Received: from [64.215.88.90] by web31810.mail.mud.yahoo.com via HTTP; Tue, 26 Sep 2006 11:53:26 PDT
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xk7rup3.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27810>

--- Junio C Hamano <junkio@cox.net> wrote:
> This does not feel right.  Go to summary view, pick the tree
> link of a non-head commit from the shortlog list, and the raw
> links on the resulting page all say hb=HEAD.

I see your point.

> Doesn't this make clicking the entry itself (blob view) and
> clicking on the raw link (blob-plain view) inconsistent?

It this exactly this consistency which the patch used to de-couple
it and use the "raw" to point to HEAD.

> The former goes to the blob from that revision while the latter
> always goes to the HEAD.

Yes, I completely understand the conundrum.

Ideally, hb would equal HEAD from the _context_, but
  1) hb and h != HEAD for any "raw" link,
  2) one can set hb=HEAD in the context only when the "blob page"
     can be loaded, which is impossible for binary blobs.

So the fix would be that, unless the user had selected a hb/h
explicitly, set "raw" to HEAD (i.e. by default), but leave the entry
with hb/h in SHA.  This way, one can take a reference to HEAD or
SHA of the head depending on what is needed.  And if they had
selected a hb/h explicitly then both the entry and the "raw"
would point to the SHA.

Such a patch can go on top of those two.

    Luben
