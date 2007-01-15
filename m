From: "Martin Langhoff" <martin.langhoff@gmail.com>
Subject: Re: Commit signing
Date: Tue, 16 Jan 2007 11:26:50 +1300
Message-ID: <46a038f90701151426t7f25b50cl21a65c9b283829ef@mail.gmail.com>
References: <200701151000.58609.andyparkins@gmail.com>
	 <200701151141.51659.andyparkins@gmail.com>
	 <46a038f90701151036k7b9ee5e2sdd3bbf6d69f9a27c@mail.gmail.com>
	 <200701151923.07493.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Jan 15 23:27:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6aIE-0006vl-DV
	for gcvg-git@gmane.org; Mon, 15 Jan 2007 23:27:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751479AbXAOW0x (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 Jan 2007 17:26:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751489AbXAOW0x
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jan 2007 17:26:53 -0500
Received: from wx-out-0506.google.com ([66.249.82.238]:11866 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751479AbXAOW0w (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jan 2007 17:26:52 -0500
Received: by wx-out-0506.google.com with SMTP id h31so1909117wxd
        for <git@vger.kernel.org>; Mon, 15 Jan 2007 14:26:51 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hrwyODR37zxBSnqKkLyJx/ZKXB4iw0lPrlkkhdjRLuLMGHe16hoRlhviPeqgspabiP74Ne9doDY00P25+4aHXuSZc2apdurQAL0S6rylIyN7OY35AltwzglfoWIIbPClgbpZP9xonRIlCBwuplbXCQEhT/FTPFWlom0Syb3ovMI=
Received: by 10.90.103.2 with SMTP id a2mr3485268agc.1168900010826;
        Mon, 15 Jan 2007 14:26:50 -0800 (PST)
Received: by 10.90.28.1 with HTTP; Mon, 15 Jan 2007 14:26:50 -0800 (PST)
To: "Andy Parkins" <andyparkins@gmail.com>
In-Reply-To: <200701151923.07493.andyparkins@gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36896>

On 1/16/07, Andy Parkins <andyparkins@gmail.com> wrote:
> On Monday 2007, January 15 18:36, Martin Langhoff wrote:
>
> > >  * Vandal spends one year developing reasonable relationship with Idiot,
> > > all patches are good.  Occasional big patches are pulled by Idiot.
> >
> > If you are using signatures, the trojan horse would make sure he gets
> > his patches signed. What is the advantage again?
>
> He can't sign it as someone else, and so when it is eventually discovered the
> culprit can be hunted down and flogged.

Fair enough. But you should should not pull from peripheral devs.
Ever. Core developers pull from eachother, everyone else posts
patches. That's how it's meant to be used.

And if you do a pull from a peripheral developer (to grab a specific
interesting patch series), you review it to check it contains what you
expect. As the person doing the merge, _your_ name is on the line.

> > IIRC Linus discussed this early on, and his view was that authorship
> > only gives you false security. The only security is in reviewing code.
> > And that the code-signed patches are dog-slow too.
>
> Eh? It's only a little bit of extra text to carry around.  It's signed by the
> original author when it enters a repository, so it's not a huge price to pay
> in any one place.  The checking, if you wanted to enable it, would only be
> done once per incoming commit to a master repository.  All-in-all, nothing
> that you wouldn't be willing to pay if you wanted this feature.

I guess the argument was against the cost of running expensive checks
in operations that should be fast. On the other hand, if youare happy
for the git internal machinery to ignore alll this, you _could_ add
this trivially with a slight modification of the commit msg.

At commit-time, just add a signature block at the bottom, making sure
you are including the tree and parent SHA1s in the text signed by the
commit (the commit however will have no GPG starts here" line at the
top when it is displayed).

> As an aside; I would also suggest that this isn't just about people trojaning
> a commit.  You could also argue that without it, this whole Signed-Off-By
> business is a bit a moot point.

Well, it's covered by a trust-but-review ethos...

> The signed-off-by lines in the kernel are being used to establish original
> authorship and entry path of every line in the kernel.  It's fairly worthless
> though when the "signing" is just someone writing an easily forged line of
> text.  For example, what is to stop that naughty lad Linus from adding some
> code the infringes a copyright to the kernel and adding a "Signed-Off-By:
> Martin Langhoff" to the bottom?  Equally, when SCO come knocking with
> their "we wrote that line", a secure digital signature chain would go a long
> way to proving that a submission wasn't faked.

Oh, evil Linus. It takes a bit more work to take my name in vain. SMTP
hosts, IP addresses of the sending machine, etc. And yet...

<social, nontechnical commentary follows>

... you probably know about Debian and its keysigning parties. One of
the net results is that pretty much nobody reviews the work developers
do in their packages. Nobody. All signed and pretty, but in most
debian packages the review is nil. And you can mostly trust that a
given upload came from me or someone that has my keys. Sure. But trust
has smothered review.

So while I don't disagree that it can be implemented easily, I doubt
it will improve the technical quality of a project to introduce it.
And it is trivial to prove that it   lowers the social/human quality,
as it brings in all sorts of politics and exclusion games (present in
CVS/SVN today). Starting from the "are you in the keychain?" game, to
forcing passport-based keysigning parties (not bad in itself) that
lead to bs like "I don't trust non-western-central-country-passports",
"I don't think you look like your passport picture". And then smart
people get tired and do stuff like this
http://blog.madduck.net/geek/2006.05.24-tr-id-at-keysigning

Sorry about the rant :-) but I consider this kind of stuff a good
reason to stay away from a project. Judge the patch, nothing else.



martin
