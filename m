From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: [RFC] git integrated bugtracking
Date: Sun, 10 Jun 2007 20:55:21 +1200
Message-ID: <46a038f90706100155q1da663d7le3bf0345c68e47ae@mail.gmail.com>
References: <20070603114843.GA14336@artemis> <20070609121244.GA2951@artemis>
	 <46a038f90706092359i43a6e834rc096e53a28fbee51@mail.gmail.com>
	 <20070610083754.GC4084@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Jan Hudec" <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Sun Jun 10 10:55:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxJCn-0006hP-2f
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 10:55:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751429AbXFJIzX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 04:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbXFJIzW
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 04:55:22 -0400
Received: from wx-out-0506.google.com ([66.249.82.226]:62731 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750816AbXFJIzV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 04:55:21 -0400
Received: by wx-out-0506.google.com with SMTP id t15so1132948wxc
        for <git@vger.kernel.org>; Sun, 10 Jun 2007 01:55:21 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jWBiiMdBg6fFFIai99+9bnQXD1QE1Ky8N8xzDz3LCjEhk+f3nmdXns7kEGeN6CuwPGnN97eyqOIR+Qfbg7m3YTx2UFr4Tj6C/chYws6UvqIJcLRUj3Z9XAqjTwQ72b65AV60qzUm6yzVBa0OnuOcqxvWW47rCUZ5fn2dwYlv6n0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V8k1TkSdGZdVGgqVYIw72cYreRqV11oZmbmVkDzh20FwCRHfdaCeyl0NoLtUmxcg972i5L2a/IpObieJMWUEJxLuJQbzR4xiWJrsuCKqjFfJr+uovJFJmjBQToMfejrTcGx84fMUwrxyMFIeaYGS0eUdtojD73v5mCxZTu5QIj0=
Received: by 10.90.105.20 with SMTP id d20mr4284209agc.1181465721257;
        Sun, 10 Jun 2007 01:55:21 -0700 (PDT)
Received: by 10.90.35.4 with HTTP; Sun, 10 Jun 2007 01:55:21 -0700 (PDT)
In-Reply-To: <20070610083754.GC4084@efreet.light.src>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49688>

On 6/10/07, Jan Hudec <bulb@ucw.cz> wrote:
> I don't know about any *distributed* bug tracker, which is the point here.

As an end user, I suspect I _don't_ want to have to report a bug in a
distributed bug tracker ;-) In that space, the Malone guys (canonical)
have their fingers on one of the most serious issues, and perhaps it's
interesting to see what they've done there. It's really useful, even
if I don't think I want to have to maintain it :-/

> We have several distributed version control tools, but no other distributed
> tools for the other tasks in configuration management.

Bugtrackers are co-owned by developers, users and (where they exist)
project managers.

>  - The web interface is usually not a good match for the problem. Email
>    interface is better in many respects, but it still does not cut it.

I agree. I love/hate debbugs too.

>  - You can't really use the ability of version control to work disconnected,
>    when you don't also have the bug information.

A cache fixes the reading part  - see my other post, and imagine being
able to have a local sqlite cache of the BT key data indexed by
referenced SHA1, showing up with your commits in gitk.

The write part is solved (in part) by committing to git the fix -- if
you mentionm the bug ID, the central BT will pick it up when your
commit appears in the branches/repos that the BT can see.

For "just adding a comment", the write part is solved by the "email"
interface, like with debbugs.

>  - Distributed version control is designed to decrease the workload of the
>    central maintainer(s) while keeping him in control. But with centralized

And to provide a single place for users to report a problem and track
its status.

> If it uses git as it's database, which it probably will,

Well - hmmm. Git's database is great at tracking _content identity_.
But a bug's content identity (description+comments+status) changes all
the time. I don't think it's naturally a good match.

Perhaps it makes sense to mix git's storage model with something else...?

> Yes. But for many people current bug tracking tools do NOT work 99%.

Hmmm. I agree in that "does not work disconnected" is a big issue with
web tools, but debbugs works disconnected, and is good. Git's
bugtracker (git@vger) works disconnected too ;-) And googlegears might
help the rest of us. Is there any other problem with current BTs?

cheers,


martin
