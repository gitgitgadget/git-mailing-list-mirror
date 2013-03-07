From: David Aguilar <davvid@gmail.com>
Subject: Re: [PATCH 1/2] p4merge: swap LOCAL and REMOTE for mergetool
Date: Thu, 7 Mar 2013 11:50:36 -0800
Message-ID: <CAJDDKr5-ttcU48r0-qTfov7q736Rj63rS33fTScSsvx53VG4pA@mail.gmail.com>
References: <1362601978-16911-1-git-send-email-kevin@bracey.fi>
	<1362601978-16911-2-git-send-email-kevin@bracey.fi>
	<7vlia0nj0i.fsf@alter.siamese.dyndns.org>
	<513830AD.10302@bracey.fi>
	<7vd2vboepi.fsf@alter.siamese.dyndns.org>
	<5138CAFE.2010602@bracey.fi>
	<7vboavm3fh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Bracey <kevin@bracey.fi>, git@vger.kernel.org,
	Ciaran Jessup <ciaranj@gmail.com>,
	Scott Chacon <schacon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 20:51:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDgqH-0001wX-6F
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 20:51:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932743Ab3CGTui (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 14:50:38 -0500
Received: from mail-wi0-f182.google.com ([209.85.212.182]:51008 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932694Ab3CGTuh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 14:50:37 -0500
Received: by mail-wi0-f182.google.com with SMTP id hi18so557134wib.3
        for <git@vger.kernel.org>; Thu, 07 Mar 2013 11:50:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=/BFggzLOghdLnsOhQUL8QfShvRlmLEZHP7BhBqmqM+4=;
        b=ms8wPZKaYHqgF2LUNJao3D+9Ea5GENAm5xlKHr+ov0WM4TUrZE6+l3DSOHpYrtY5rD
         DctDchNpkaJAEiblwjvLhK3JewA98n6Gn2JVX2KlDW/tjCrVWc8gDOJmyh0V5ePBOw6A
         Z1lT4GCgJ893CcB6/ZhAT2BMSdYb0vg7ZoRfH3Btryk5QlmSB9QOZ4Exw+C47EnzfZ/R
         E8iHbYQQ0CFrLuJj9HFf4X5/iyGZehom+WZK1RjtnySSti0iP4CkxSWz5PLkNZcJe6wA
         5dW/nAw+vqQkRrCKp9bZL6PJUWL9TrItxN4aG39j/rLk5+utvJ8Qfvnroeo4bZex3HJ/
         20LA==
X-Received: by 10.194.76.37 with SMTP id h5mr57657539wjw.21.1362685836287;
 Thu, 07 Mar 2013 11:50:36 -0800 (PST)
Received: by 10.194.13.129 with HTTP; Thu, 7 Mar 2013 11:50:36 -0800 (PST)
In-Reply-To: <7vboavm3fh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217614>

On Thu, Mar 7, 2013 at 11:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Kevin Bracey <kevin@bracey.fi> writes:
>
>> On 07/03/2013 09:23, Junio C Hamano wrote:
>>> If p4merge GUI labels one side clearly as "theirs" and the other
>>> "ours", and the way we feed the inputs to it makes the side that is
>>> actually "ours" appear in p4merge GUI labelled as "theirs", then I
>>> do not think backward compatibility argument does not hold water. It
>>> is just correcting a longstanding 3-4 year old bug in a tool that
>>> nobody noticed.
>>
>> It's not quite that clear-cut. Some years ago, and before p4merge was
>> added as a Git mergetool, P4Merge was changed so its main GUI text
>> says "left" and "right" instead of "theirs" and "ours" when invoked
>> manually.
>>
>> But it appears that's as far as they went. It doesn't seem any of its
>> asymmetric diff display logic was changed; it works better with ours
>> on the right, and the built-in help all remains written on the
>> theirs/ours basis. And even little details like the icons imply it (a
>> square for the base, a downward-pointing triangle for their incoming
>> stuff, and a circle for the version we hold).
>
> So in short, a user of p4merge can see that left side is intended as
> "theirs", even though recent p4merge sometimes calls it "left".  And
> your description on the coloring (green vs blue) makes it clear that
> "left" and "theirs" are still intended to be synonyms.
>
> If that is the case I would think you can still argue such a change
> as "correcting a 3-4-year old bug".

I would prefer to treat this as a bugfix rather than introducing
a new set of configuration knobs if possible.  It really does
seem like a correction.

Users that want the traditional behavior can get that by
configuring a custom mergetool.p4merge.cmd, so we're not
completely losing the ability to get at the old behavior.

Users that want to see a reverse diff with difftool can
already say "--reverse", so there's even less reason to
have it there (though I know we're talking about mergetool only).


>> Would it be going too far to also have "xxxtool.reverse" to choose the
>> global default?
>
> It would be a natural thing to do.  I left it out because I thought
> it would go without saying, given that precedences already exist,
> e.g. mergetool.keepBackup etc.

Medium NACK.  If we can do without configuration all the better.

I would much rather prefer to have the default/mainstream
behavior be the best out-of-the-box sans configuration.

The reasoning behind swapping them for p4merge makes sense
for p4merge only.  I don't think we're quite ready to declare
that all the merge tools need to be swapped or that we need a
mechanism for swapping the order.

>> My only reservation is that I assume it would be implemented by
>> swapping what's passed in $LOCAL and $REMOTE. Which seems a bit icky:
>> $LOCAL="a.REMOTE.1234.c".
>
> Doesn't the UI show the actual temporary filename?  When merging my
> version of hello.c with your version, showing them as hello.LOCAL.c
> and hello.REMOTE.c is an integral part of the UI experience, I
> think, even if the GUI tool does not give its own labels (and
> behaviour differences as you mentioned for p4merge) to mark which
> side is theirs and which side is ours.  The temporary file that
> holds their version should still be named with REMOTE, even when the
> mergetool.reverse option is in effect.
>
> As to the name of the variable, I do not care too deeply about it
> myself, but I think keeping the current LOCAL and REMOTE would help
> people following the code, especially given the option is called
> "reverse", meaning that there is an internal convention that the
> order is "LOCAL and then REMOTE".
>
> One thing to watch out for is from which temporary file we take the
> merged results.  You can present the two sides swapped, but if the
> tool always writes the results out by updating the second file, the
> caller needs to be prepared to read from the one that gets changed.
-- 
David
