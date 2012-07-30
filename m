From: Sitaram Chamarty <sitaramc@gmail.com>
Subject: Re: Enhancements to git-protocoll
Date: Mon, 30 Jul 2012 14:01:11 +0530
Message-ID: <CAMK1S_iRh0qVonQ5aDdrqh4H_E+-2WRYt=LzK4MAnnnuWY+DuQ@mail.gmail.com>
References: <20120728214116.GA3591@paksenarrion.iveqy.com>
	<7vehnvvyta.fsf@alter.siamese.dyndns.org>
	<20120729142458.GB16223@paksenarrion.iveqy.com>
	<CAMK1S_iTv3BOV3LEoj83feuO2iQnPqTrOq0wyFC-GrvvJQqWTA@mail.gmail.com>
	<7vvch6uw89.fsf@alter.siamese.dyndns.org>
	<7vr4ruuu2e.fsf@alter.siamese.dyndns.org>
	<CAMK1S_geKq5DkNAy2wxGt5EmoOesxaSKKuQjVaQVcbRVdR+9gA@mail.gmail.com>
	<CAJo=hJsgMz-=pdG=HB3KtTE7g6Gvu9mr56dg2+V3WUST+rpAQg@mail.gmail.com>
	<7vehnut1kt.fsf@alter.siamese.dyndns.org>
	<CAJo=hJvjFP0m96YPNBCwvnkRGWhMZQdbL7C3Shsa6HQ62a9FuA@mail.gmail.com>
	<7vy5m1sqz3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 30 10:31:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SvlNo-0002hH-PA
	for gcvg-git-2@plane.gmane.org; Mon, 30 Jul 2012 10:31:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753714Ab2G3IbO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Jul 2012 04:31:14 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:35907 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752192Ab2G3IbN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jul 2012 04:31:13 -0400
Received: by lbbgm6 with SMTP id gm6so3341084lbb.19
        for <git@vger.kernel.org>; Mon, 30 Jul 2012 01:31:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rO8e7lPEq/jHMBP1LM4cOz5BFNcUej7bBVhHSzkYPOY=;
        b=Q0arSxNpBDfHuC8+UsJHDTKIjTD2UwGBW1gPnOZFd46OPeGbQ+l+XGDCPt06z99TwC
         p6mMmCdR5tEBu1QIhbEJ/RQ6PxbO3pAnkF8Xlu7UfaM4zQmyER6GRffZUexxTyql0NT1
         LsYg/YO4FkC5nGF1F8K2faQEHVRyHPMqH7vtH4P4yIXLBuIxgL+j7BgmXhJLm1zmXMEh
         fuvvZaFIjHMPerOzbjtaSLGWgGxcFA1buo4Z+uSbx0ZJQasI8zrVRrPiyJpqogKsWCPx
         75jS4o9pKpVEz8yPw6AYgYG/ILLiX2UnmEo09Tvb7Uc1QhuP57FMItBX5PIPwlGkotPP
         059Q==
Received: by 10.112.39.135 with SMTP id p7mr4939759lbk.78.1343637071495; Mon,
 30 Jul 2012 01:31:11 -0700 (PDT)
Received: by 10.112.60.194 with HTTP; Mon, 30 Jul 2012 01:31:11 -0700 (PDT)
In-Reply-To: <7vy5m1sqz3.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202529>

On Mon, Jul 30, 2012 at 11:58 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Shawn Pearce <spearce@spearce.org> writes:
>
>>> The way to expose the extra information parsed by Git to the server
>>> side could be made into calling out to hooks, and at that point,
>>> gitolite would not even have to know about the pack protocol.
>>
>> Good point. The case that spawned this thread however still has a
>> problem with this approach. gitolite would need to create a repository
>> to invoke the receive-pack process within, and install that new hook
>> script into... when the hook was trying to prevent the creation of
>> that repository in the first place.
>
> Heh.  While I do not particularly consider auto-creation-upon-push a
> useful thing to begin with (after all, once you created a
> repository, you would want ways to manage it, setting up ACL for it
> and stuff like that, so adding a "create" command to the management
> interface suite would be a more natural direction to go), as long as
> we are discussing a hack that involves hooks, I do not think your
> observation is a show-stopper downside.
>
> The hook can interact with the end user over the back channel and
> decide to abort the transaction, while leaving some clue in the
> repository that is pre-agreed between the gitlite server and the
> hook.  When gitolite culls the process with wait4(2), it could
> notice that "clue", read the wish of the hook that the repository
> needs to be removed from it, and remove the repository. Up to that
> point, there is no real data transferred, so there isn't much wasted
> time or network resource anyway.
>
>> An ancient Git would abort hard if passed this flag. An updated Git
>> could set environment variables before calling hooks, making the
>> arguments visible that way. And gitolite can still scrape what it
>> needs from the command line without having to muck about inside of the
>> protocol, but only if it needs to observe this new data from pusher to
>> pushee?
>
> I do not think the details of how the extra information is passed
> via the Git at the receiving end to its surrounding matters that
> much.  It would even work fine if we let the hook to talk with the
> end user sitting at the "git push" end, by using two extra sidebands
> to throw bits between them, while the Git process that spawned the
> hook acts as a relay, to establish a custom bi-di conversation (but
> again, I do not think it is useful, because such an out of band
> conversation cannot affect the outcome of the main protocol exchange
> in a meaningful way other than aborting).
>
> Or you could export environment variables, which would be far more
> limiting with respect to the nature of the data (i.e. needs to be
> free of NUL) and the size of data you can pass.  The limitation may
> actually be a feature to discourage people from doing wacky things,
> though.
>
>> `git push -Rfoo=baz host:dest.git master` on the client would turn
>> into `git-receive-pack -Rfoo=baz dest.git` in the SSH and git://
>> command line, and cause GIT_PUSH_ARG_FOO=baz to appear in the
>> environment of hooks. Over smart HTTP requests would get an additional
>> query parameter of foo=baz.
>
> I think using the same "extra args on the command line" would be a
> good way to upgrade the protocol version in a way the current
> "capability" system does not allow us to (namely, stop the party
> that accepts the connection from immediately advertising its refs).

More importantly from gitolite's point of view, this is the only way
gitolite can see those variables in some situations, because gitolite
runs *before* git, (and then again later via the update hook for
pushes).

>> The other hacky idea I had was to use a fake reference and have the
>> client push a structured blob to that ref. The server would decode the
>> blob, and deny the creation of the fake reference, but be able to get
>> additional data from that blob. Its hacky, and I don't like making a
>> new blob on the server just to transport a few small bits of data from
>> the client.
>
> That way lies madness, and at that point, you are better off doing a
> proper protocol extension by registering a new capability and defining
> the semantics for it.



-- 
Sitaram
