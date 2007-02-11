From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Efficiency of initial clone from server
Date: Sun, 11 Feb 2007 18:29:00 -0500
Message-ID: <9e4733910702111529g715c7c0ch9246947fd70d40eb@mail.gmail.com>
References: <9e4733910702111153p1691ad99nda97325b34b7a13f@mail.gmail.com>
	 <20070211225326.GC31488@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 00:29:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGO84-0007hH-68
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:29:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932593AbXBKX3F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932825AbXBKX3F
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:29:05 -0500
Received: from wr-out-0506.google.com ([64.233.184.229]:52720 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932593AbXBKX3C (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:29:02 -0500
Received: by wr-out-0506.google.com with SMTP id i21so1462289wra
        for <git@vger.kernel.org>; Sun, 11 Feb 2007 15:29:01 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ttJswce3A41YbS8UFJkhWbzPmv8OLTnlR+Jmgflc6Muj5d0JWtAjfDFtUfqTLe4/aYGLlB6uUhc+CW0HxxrmHMkCxg3Pe3fpZhbQiQc1lM/ctpk1KtKg56F67xuE5kyQwiHzSzzn9nd+8YJjFOOj+mQ6UBfN9kaBpS5j/sR2bPQ=
Received: by 10.114.170.1 with SMTP id s1mr5532181wae.1171236540996;
        Sun, 11 Feb 2007 15:29:00 -0800 (PST)
Received: by 10.114.195.13 with HTTP; Sun, 11 Feb 2007 15:29:00 -0800 (PST)
In-Reply-To: <20070211225326.GC31488@spearce.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39329>

On 2/11/07, Shawn O. Pearce <spearce@spearce.org> wrote:
> Jon Smirl <jonsmirl@gmail.com> wrote:
> > Is this happening because the repository on the server is not
> > completely packed? It is basically building a pack of the whole thing
> > and shipping it to me, right?
>
> Correct.  The wire protocol only allows us to send one pack.
> So we have to pack everything and transmit it as a single unit.
>
> > If that is the case, why not first pack the whole repository and then
> > copy it down the wire? Now the next clone that comes along doesn't
> > have to do so much work. Would this help to eliminate some of the load
> > at kernel.org?
>
> Probably, but then the daemon needs write access to the repository.
> This isn't required right now; it can be strictly read-only and
> still serve the contents.

Does it need write access for push to work, can the server check for
write access and save the complete repack if it has access? This
appears to be causing a lot of needless work for kernel.org.

-- 
Jon Smirl
jonsmirl@gmail.com
