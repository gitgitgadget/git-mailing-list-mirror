From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH 09/16] documentation: add documentation for the bitmap format
Date: Wed, 26 Jun 2013 19:29:19 -0600
Message-ID: <CAJo=hJuH98sT5WNykxQ5JX+yKxOH-5p3CCRGa-WLAYtMGAj6oA@mail.gmail.com>
References: <1372116193-32762-1-git-send-email-tanoku@gmail.com>
 <1372116193-32762-10-git-send-email-tanoku@gmail.com> <CAJo=hJtcQwh-N-9_i84y1ZsL0mdREHcxhP2gepcrREiaxvxS6A@mail.gmail.com>
 <CAFFjANRwBBcORhu4mwjESBfr4GJ3zDrgYvUhY=VxK9abv7k2MA@mail.gmail.com> <20130626051117.GB26755@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Vicent_Mart=ED?= <tanoku@gmail.com>,
	Colby Ranger <cranger@google.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 27 03:29:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Us11t-0001Zk-3D
	for gcvg-git-2@plane.gmane.org; Thu, 27 Jun 2013 03:29:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751557Ab3F0B3l convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Jun 2013 21:29:41 -0400
Received: from mail-ie0-f178.google.com ([209.85.223.178]:33196 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751517Ab3F0B3k convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Jun 2013 21:29:40 -0400
Received: by mail-ie0-f178.google.com with SMTP id u16so393270iet.9
        for <git@vger.kernel.org>; Wed, 26 Jun 2013 18:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=KhIEsY9+dZYMg2vBmtuE7i/Wk490JFfzHPu4QVGo0U0=;
        b=Bs8RoYj0dZHjmRh/sDwxDmXYzql0+IYEEFTeAvKJO9RUWFFe/xuiCBYzMUxQmTrqEn
         Ehv07eYyyUpougD/T4bkJQVjCyT+d4o3Kgi3O7Y+k5XMGjx+Lq9ljRvNHaYr2DvJRkqG
         Y9xGe9QT1SMPS/2hK/O3YYk9qGpT9wH0clKxA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=KhIEsY9+dZYMg2vBmtuE7i/Wk490JFfzHPu4QVGo0U0=;
        b=NU754SEz+vzwwzvmh40d0UIdTVhTbTnacSB93OKDl+ZdED0oLJ7O7ldFDBHnadE2y0
         PSTjo7jZZB0TzZBiQ+PGuvTsSzFz5k/ssfLsyWNQDrnmRv/tTTPaLAgg6MiIqjbpGn/E
         jK+2ZoMFcNw8EJ6FDrpwG7Fa+pZpJ/wby4pKwk/rOmCZzREsY3M+6S0ZsmHsfxPgjgfC
         OQUfVgnRJ1aUONY0tZxnzTjrQAMldHdWa/OneTKDKb03oBKxE9eQZKhl4Hnkqy13Xt9n
         lcKV6KHLAApNZcbIO2eU3yPeKJRa+S8K2n4zGN5urQv/ykJwwVNIwKDBsdui2Lz1BX7r
         d2Hw==
X-Received: by 10.42.98.69 with SMTP id r5mr3573984icn.95.1372296579721; Wed,
 26 Jun 2013 18:29:39 -0700 (PDT)
Received: by 10.64.82.38 with HTTP; Wed, 26 Jun 2013 18:29:19 -0700 (PDT)
In-Reply-To: <20130626051117.GB26755@sigill.intra.peff.net>
X-Gm-Message-State: ALoCoQl89BAGAvw6uvncN/8FBF9KoXzetY1XlRC3XIyQaOtRRVaoiz7KM1qnbxfrLGKb0/chC/1j
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229079>

On Tue, Jun 25, 2013 at 11:11 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Jun 25, 2013 at 09:33:11PM +0200, Vicent Mart=ED wrote:
>
>> > One way we side-stepped the size inflation problem in JGit was to =
only
>> > use the bitmap index information when sending data on the wire to =
a
>> > client. Here delta reuse plays a significant factor in building th=
e
>> > pack, and we don't have to be as accurate on matching deltas. Duri=
ng
>> > the equivalent of `git repack` bitmaps are not used, allowing the
>> > traditional graph enumeration algorithm to generate path hash
>> > information.
>>
>> OH BOY HERE WE GO. This is worth its own thread, lots to discuss her=
e.
>> I think peff will have a patchset regarding this to upstream soon,
>> we'll get back to it later.
>
> We do the same thing (only use bitmaps during on-the-wire fetches).  =
But
> there a few problems with assuming delta reuse.
>
> For us (GitHub), the foremost one is that we pack many "forks" of a
> repository together into a single packfile. That means when you clone
> torvalds/linux, an object you want may be stored in the on-disk pack
> with a delta against an object that you are not going to get. So we h=
ave
> to throw out that delta and find a new one.

Gerrit Code Review ran into the same problem a few years ago with the
refs/changes namespace. Objects reachable from a branch were often
delta compressed against dropped code review revisions, making for
some slow transfers. We fixed this by creating a pack of everything
reachable from refs/heads/* and then another pack of the other stuff.

I would encourage you to do what you suggest...

> I'm dealing with that by adding an option to respect "islands" during
> packing, where an island is a set of common objects (we split it by
> fork, since we expect those objects to be fetched together, but you
> could use other criteria). The rule is that an object cannot delta
> against another object that is not in all of its islands. So everybod=
y
> can delta against shared history, but objects in your fork can only
> delta against other objects in the fork.  You are guaranteed to be ab=
le
> to reuse such deltas during a full clone of a fork, and the on-disk p=
ack
> size does not suffer all that much (because there is usually a good
> alternate delta base within your reachable history).

Yes, exactly. I want to do the same thing on our servers, as we have
many forks of some popular open source repositories that are also not
small (Linux kernel, WebKit). Unfortunately Google has not had the
time to develop the necessary support into JGit.

> So with that series, we can get good reuse for clones. But there are
> still two cases worth considering:
>
>   1. When you fetch a subset of the commits, git marks only the edges=
 as
>      preferred bases, and does not walk the full object graph down to
>      the roots. So any object you want that is delta'd against someth=
ing
>      older will not get reused. If you have reachability bitmaps, I
>      don't think there is any reason that we cannot use the entire
>      object graph (starting at the "have" tips, of course) as preferr=
ed
>      bases.

In JGit we use the reachability bitmap to provide proof a client has
an object. Even if its not in the edges. This allows us much better
delta reuse, as often frequently deltas will be available pointing to
something behind the edge, but that the client certainly has given the
edges we know about.

We also use the reachability bitmap to provide proof a client does not
need an object. We found a reduction in number of objects transferred
because the "want AND NOT have" subtracted out a number of objects not
in the edge. Apparently merges, reverts and cherry-picks happen often
enough in the repositories we host that this particular optimization
helps reduce data transfer, and work at both server and client ends of
the connection. Its a nice freebie the bitmap algorithm gives us.

>   2. The server is not necessarily fully packed. In an active repo, y=
ou
>      may have a large "base" pack with bitmaps, with several recently
>      pushed packs on top. You still need to delta the recently pushed
>      objects against the base objects.

Yes, this is unfortunate. One way we avoid this in JGit is to keep
everything in pack files, rather than exploding loose. The
reachability bitmap often proves the client has the delta base the
pusher used to make the object, allowing us to reuse the delta. It may
not be the absolute best delta in the world, but reuse is faster than
inflate()+delta()+deflate(), and the delta is probably "good enough"
until the server can do a real GC in the background.

We combine small packs from pushes together by almost literally just
concat'ing the packs together and creating a new .idx. Newer pushed
data is put in front of the older data, the pack is clustered by
"commit, tree, blob" ordering, duplicates are removed, and its written
back to disk. Typically we complete this "pack concat" operation mere
seconds after a push finishes, so readers have very few packs to deal
with.

> I don't have measurements on how much the deltas suffer in those two
> cases. I know they suffered quite badly for clones without the name
> hashes in our alternates repos, but that part should go away with my
> patch series.

JGit doesn't poke objects into the object table (or even the object
list) when a bitmap is used. We spool the bits out of the bitmap in
bitmap order and write them to the wire in that order. Its way faster,
but depends on the bitmap being in pack-ordering. So clones are crazy
fast even though we don't have the path-hash table.

JGit also has another optimization where we figure out based on the
bitmap if the client needs *everything* in this pack. Which given a
pack created only for refs/heads/* is the common case for a clone. If
the client is getting all objects we essentially just do a sendfile()
for the region starting at offset 12 through end-20. It can't be a
sendfile() syscall because it has to be computed into the trailer
SHA-1 the client sees, but its a crazy tight IO copy loop with no Git
smarts beyond the SHA-1 updating.

Like I said, there are a ton of optimizations you guys missed. And we
think they make a bigger difference than screwing around with
little-endian format to favor x86 CPUs.
