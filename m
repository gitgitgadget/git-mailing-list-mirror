From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Jabber, question on push,pull and --tags, and no help but jabber
Date: Tue, 07 Jun 2011 07:47:02 +0200
Message-ID: <4DEDBB56.7000200@drmicha.warpmail.net>
References: <20110606130205.GA41674@sherwood.local> <4DECE4D6.9000204@drmicha.warpmail.net> <20110606214639.GA38620@sherwood.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Steffen Daode Nurpmeso <sdaoden@googlemail.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 07:47:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QTp8C-0004M0-4L
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 07:47:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750971Ab1FGFrG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 01:47:06 -0400
Received: from out3.smtp.messagingengine.com ([66.111.4.27]:34428 "EHLO
	out3.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750882Ab1FGFrF (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Jun 2011 01:47:05 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.messagingengine.com (Postfix) with ESMTP id D0F152075F;
	Tue,  7 Jun 2011 01:47:04 -0400 (EDT)
Received: from frontend1.messagingengine.com ([10.202.2.160])
  by compute1.internal (MEProxy); Tue, 07 Jun 2011 01:47:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=OEZb2eBS5vWy1hR9Iks6ONNNIIA=; b=FhNF2Yb8aeZty6HpxG/M1xVi2i43ZXj9d6N6B1mk4BtCuMzzKaJQAcmUdlubFdyGCRa5hXsk0DDzmRtMyKO6dlr8dbgoeodUUTcGMJ/Kbd0MkeIJO1pZzxX6CtFpiPA0KZGvDE3FdCmnz3i0DhMI8kpY2Rj7eW7SCCt+foABA+c=
X-Sasl-enc: EsBvYbjforj34anre3YkA4y20pJQAs2mkvU81Byjt0yK 1307425624
Received: from localhost.localdomain (whitehead.math.tu-clausthal.de [139.174.44.62])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 1E1234095FF;
	Tue,  7 Jun 2011 01:47:04 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110428 Fedora/3.1.10-1.fc15 Lightning/1.0b3pre Thunderbird/3.1.10
In-Reply-To: <20110606214639.GA38620@sherwood.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175186>

Steffen Daode Nurpmeso venit, vidit, dixit 06.06.2011 23:46:
> @ Michael J Gruber <git@drmicha.warpmail.net> wrote (2011-06-06 16:31+0200):
>> "git tag" and "git verify-tag" call out to "gpg". That could be easily
>> adapted to call out to "openssl smime", or put your S/MIME signatures in
>> a note.
>>
>> Cheers
>> Michael
> 
> Hum.  It will indeed be possible to place a wrapper script 'gpg'
> in the path on my box (and catch '--verify' - or sign otherwise).

I didn't mean to shove a disguised openssl-smime into the path, I meant
that that there is little to change in code because git calls out to gpg
rather than doing it itself.

> But in the meanwhile i've found out that git(1) is heavily
> developed, stale .git_vtag_ files of an 1.7.3? version are no
> longer produced by 'git version 1.7.6.rc0' to which i've updated
> after i've seen those.  So maybe there is hope that the hardcoded
> gpg invocation will be replaced by configuration options in the
> future, too?

I don't know if it needs to be configurable. That may open a can of worms.

> I still don't understand the design with pull and --tags.
> Because, if i do 'git log' it'll display the relationship as in
> 
>     commit fd040fb[...] (tag: refs/tags/v0.3.0, refs/remotes/origin/master)

git log does that only when you ask it to decorate the commits.
"decoration" means looking up all refs and checking whether one of them
references that commit. Neither the tag (object) nor the ref names (tag
name, branch name) are part of the commit, so:

> So i'll push this commit object as part of pushing a branch, and
> the tag refers to *it*.  I don't want to be impertinent though,

The tag name is not pushed, but the commit object is and has the same
sha1 on "both sides", which is why the remote branch name shows up as a
decoration.

> and it's better that explicit way than implicitely pushing some
> distressing stuff.  Still i would have appreciated a note in the
> docu, because it took a look at the mentioned webspace to realize
> the situation.  I'll append a short diff to be able to provide
> something useful.  (No attachments allowed here i guess.)
> 
> I'll try to be less tiny from the start the next time.
> --
> Ciao, Steffen
> sdaoden(*)(gmail.com)
> () ascii ribbon campaign - against html e-mail
> /\ www.asciiribbon.org - against proprietary attachments
> 
> --
> diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
> index 88acfcd..da4a71a 100644
> --- a/Documentation/git-push.txt
> +++ b/Documentation/git-push.txt
> @@ -69,7 +69,7 @@ nor in any Push line of the corresponding remotes file---see below).
>  
>  --all::
>  	Instead of naming each ref to push, specifies that all
> -	refs under `refs/heads/` be pushed.
> +	refs under `refs/heads/` be pushed explicitely.

I don't mind but I don't think it adds clarity.

>  
>  --mirror::
>  	Instead of naming each ref to push, specifies that all
> @@ -98,7 +98,7 @@ nor in any Push line of the corresponding remotes file---see below).
>  --tags::
>  	All refs under `refs/tags` are pushed, in
>  	addition to refspecs explicitly listed on the command
> -	line.
> +	line.  Note that tags are not pushed automatically.

That is implicit in the line before it. In any case: The main problem of
git-push(1) seems to be that one has to read all the way down (through
all options) in order to grasp the default case, so I feel the first
paragraph needs to improve.

>  
>  --receive-pack=<git-receive-pack>::
>  --exec=<git-receive-pack>::
> 
