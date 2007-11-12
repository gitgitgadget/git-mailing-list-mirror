From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: Cloning from kernel.org, then switching to another repo
Date: Mon, 12 Nov 2007 15:51:35 -0500
Message-ID: <9e4733910711121251y50560f41h19c4e96310e2a359@mail.gmail.com>
References: <9e4733910711120557w62a9966bvb61a02a2bf9b99e9@mail.gmail.com>
	 <Pine.LNX.4.64.0711121412410.4362@racer.site>
	 <alpine.LFD.0.9999.0711121229090.3062@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Nov 12 21:52:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrgGO-0007CM-Rf
	for gcvg-git-2@gmane.org; Mon, 12 Nov 2007 21:52:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751636AbXKLUvh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Nov 2007 15:51:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752184AbXKLUvh
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Nov 2007 15:51:37 -0500
Received: from rv-out-0910.google.com ([209.85.198.190]:17602 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750944AbXKLUvg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Nov 2007 15:51:36 -0500
Received: by rv-out-0910.google.com with SMTP id k20so1281018rvb
        for <git@vger.kernel.org>; Mon, 12 Nov 2007 12:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=4NM+Q4GP774R5BCFK//FGA0fz2iAnGGmLilhuD+wi8w=;
        b=oC9tyTAHBYtG9o4TyDD57EfqKOsAVrR5dSABPe48UadiFW51HdFEwak/9Be+jTE6mkvlqmZC98JOC3h2+OpnZzrgFLQcWBssgGMBi4NBTCY4cU5afjMzDyyrqrRX1F2bzoKBb05H3UZZYytIdNvISFIR/4hjRD8msKgJhvmG7Is=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DKbOpW4Ofkl650xvz51azS9r/jh7UZHd0+KRNw17qFr5C7jxXqTz4d6onEV47JYzJl34+WJ3RsJYz2qZVPJjfXP17L0xmtSR/jPAPu4/IYMZ5oYAvsQaRw4UToJr/OT5fzsVe9Ya2+UQbGcNjS6kaMy4P3swbY7MmPj1aGySRtY=
Received: by 10.114.152.17 with SMTP id z17mr228872wad.1194900695187;
        Mon, 12 Nov 2007 12:51:35 -0800 (PST)
Received: by 10.115.54.19 with HTTP; Mon, 12 Nov 2007 12:51:35 -0800 (PST)
In-Reply-To: <alpine.LFD.0.9999.0711121229090.3062@woody.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64707>

On 11/12/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
>
> On Mon, 12 Nov 2007, Johannes Schindelin wrote:
> >
> > On Mon, 12 Nov 2007, Jon Smirl wrote:
> >
> > > I'd like to do this sequence, but I can't figure out how without editing
> > > the config file. There doesn't seem to be a simple command to move the
> > > origin.
> > >
> > > git clone linus
> > > move origin to digispeaker.git
> >
> > AKA "git config remote.origin.url <your-digispeaker-url-here>"
>
> I really think people should at least also mention:
>
>         "Or just edit your .git/config file by hand"
>
> Quite frankly, the latter is *easier* to do. It's really hard to remember
> all the config entry names and then run "git config <entry> <value>". The
> command itself may be fairly simple, but rememberign the options is *not*.

I finally got everything working. There is still some issue where I
need to run update-server-info manually. The error messages at the
client side when update-server-info needs to be run are not useful.

This sequence does work:
git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
digispeaker
cd digispeaker
git config remote.origin.url
http://git.digispeaker.com/projects/digispeaker-kernel.git
git pull

Should we allow this instead:
   git remote add origin
http://git.digispeaker.com/projects/digispeaker-kernel.git
and print a message saying the origin was changed? That would teach
people more about how remotes work.


I did need to go back to my server and clone kernel.org first, then
push my changes into it. That step is necessary so that my changes
don't end up in the giant pack along with the base kernel.

It is also a requirement to compile the git tools with NO_MMAP if
there are going to work in a shared hosting environment like
dreamhost. NO_MMAP is the key, changing git config doesn't help.

After my initial clone from kernel.org it only takes a minute now to
pull my in changes.


>
> In contrast, when you open up .git/config in your editor, it's all almost
> totally *obvious*.
>
> So telling people to edit the config file is usually much more helpful in
> the long run.
>
>                 Linus
>


-- 
Jon Smirl
jonsmirl@gmail.com
