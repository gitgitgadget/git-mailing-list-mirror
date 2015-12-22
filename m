From: Shawn Pearce <spearce@spearce.org>
Subject: Re: RefTree: Alternate ref backend
Date: Tue, 22 Dec 2015 10:50:27 -0800
Message-ID: <CAJo=hJtgfpZn0OjbQ=BVoO_=03yG0Czjfn9vX4RobWLYpNVENg@mail.gmail.com>
References: <CAJo=hJvnAPNAdDcAAwAvU9C4RVeQdoS3Ev9WTguHx4fD0V_nOg@mail.gmail.com>
 <56796F37.1000600@alum.mit.edu> <CAJo=hJtPSxY1YZgEt1AA_ukgY9cTA=1tdv_F+nCetv_Ux9E=3g@mail.gmail.com>
 <567985A8.2020301@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git <git@vger.kernel.org>, David Turner <dturner@twopensource.com>,
	Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Dec 22 19:50:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aBS1N-0007tL-5p
	for gcvg-git-2@plane.gmane.org; Tue, 22 Dec 2015 19:50:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753965AbbLVSut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Dec 2015 13:50:49 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35359 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751382AbbLVSus (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Dec 2015 13:50:48 -0500
Received: by mail-vk0-f45.google.com with SMTP id a189so122660815vkh.2
        for <git@vger.kernel.org>; Tue, 22 Dec 2015 10:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=SkzZBzqF40Y9MOth8QFkqJqEyuxgWsLkxZnXZzWZpf8=;
        b=R9IhrrX79NSnDWz7+QCQuXgCcA6aqnvUvc+gs1UztIHL6RxrQGRMiRrK4cxJe2NupK
         Ci0sZxUQgZidW+89j8xqf+JbKzr09+1l7sI1ANge7rvRGMTYeejexElahPcY5K14qZ5J
         24prJGu1e7U6WqOCAnwB6Q7smp82ejC9twnjQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=SkzZBzqF40Y9MOth8QFkqJqEyuxgWsLkxZnXZzWZpf8=;
        b=kPu4B0hJMIhlQmgpDeHnNMT79ReNdbbNHXx7W353HcOsRdn8376fwGUCwZIZYiAehw
         N2AD2e4MpPtssf6abLuA8CfaPw9jVIXBXoopgd2SyMZWUsADQr2T3PYCMGuUsnT5gOQC
         c0MUOEmMoZUJScx8nmP0PpB6K4N1rcrFQJRrnosX3I0pyvMx8czH3zjUmOVMPZSV9lXV
         5hlpaewtbbTqLPsfn4fd3za1sP2bzwum1YETGXLSQxHrHJMslkH7f6EF7nzjf/3LeJIq
         QI9jjTQzjiRpeL6VDZegknprs28XbwCXo/Oxy2LvfVzePtN0aN61XBDEQE9cStwsk8rw
         BVZw==
X-Gm-Message-State: ALoCoQmn4/uT85D2T4rTms+nTvXrOFTc5VD4g6GxGG670gOV7AwdlvRWpIGQArpqECdhtf1++qiTcLINqsYAiW9KeCksS+3mvQ==
X-Received: by 10.31.163.17 with SMTP id m17mr16752846vke.46.1450810247280;
 Tue, 22 Dec 2015 10:50:47 -0800 (PST)
Received: by 10.103.97.197 with HTTP; Tue, 22 Dec 2015 10:50:27 -0800 (PST)
In-Reply-To: <567985A8.2020301@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282898>

On Tue, Dec 22, 2015 at 9:17 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>
> etc. But we store branches into the main "refs/remotes/origin/"
> namespace, leaving no reserved space for the remote "HEAD" (not to
> mention other namespaces that might appear on the remote, such as
> "refs/changes/*", "refs/pull/*", a separate record of the remote's
> "refs/tags/*", etc).
>
> Maybe that is why my gut reaction to your proposal to elide the "refs"
> part of the reference hierarchy and store "HEAD" as (effectively)
> "refs/..HEAD" was negative, even though I can't think of any practical
> objections.

Good point; if the client's refs/remotes/origin/ namespace more
closely mirrored the remote's own namespace
(refs/remotes/origin/heads/master), this seems a lot less fishy. The
mapping certainly makes a bit more sense. Etc.

Its a user visible shift however; what was origin/master is now
origin/heads/master. Which is part of the reason why the mapping works
the way it does today. We hardly ever call a branch here heads/master,
we just call it master. So we call origin's master, origin/master. :)

> At a deeper level, the "refs/" part of reference names is actually
> pretty useless in general. I suppose it originated in the practice of
> storing loose references under "refs/" to keep them separate from other
> metadata in $GIT_DIR.

Correct. In the beginning you used echo $sha1 >.git/HEAD and it was good.

Later more refs came along and they had to go somewhere, and so
.git/refs was born with .git/refs/heads/master. Existing tools that
knew how to write to .git/HEAD given the name HEAD could magically
work with refs/heads/master too, and it was good. But that was an
awefully long name to type, so shorthand of "master" for maybe
refs/heads/master or maybe refs/tags/master or maybe no prefix at all
(hi HEAD) came along. Basically its the origin story of Git. :)

> But really, aside from slightly helping
> disambiguate references from paths in the command line, what is it good
> for?

Nothing really; today refs/ prefix is used to encourage to the tools
that you really meant refs/heads/master and not
refs/heads/heads/master or some other crazy construct. You can thank
the DWIMery inside the ref rev parse logic for needing this.

> The client not only has to remember the server's reftree, but also must
> verify that it still has all of the objects implied by that reftree, in
> case a reference somehow got deleted under "refs/remotes/origin/*". At
> that point, there is no special reason to use a SHA-1 in the
> negotiation; any unique token generated by the server would suffice if
> the server can connect it back to a set of references that was sent to
> the client in the past.

True, but its a nicer implementation if the token exchanged has simple
meaning to the server. And its just a diff-tree at the server to
compute the modifications the client might need to learn about.

I see your point about the client being able to use that to say "If I
not only have this, I also have all of the objects". It vastly
simplifies the client's negotiation with the server. The client is
negotiating the common ancestor of the reftree and that immediately
gets the main graph ancestor negotiation system very close to a good
set. The client may still be usefully ahead on other branches, e.g.
she has pulled from the upstream and is now pulling from a
lieutenant's tree, who also recently pulled from the upstream.

> In practice, in my first "haves" announcement I would probably list a
> few "famous" namespaces in the hope that one or more of them are
> recognized by the server:
>
>     have-tree <SHA-1 for "refs/">
>     have-tree <SHA-1 for "refs/heads/">
>     have-tree <SHA-1 for "refs/tags/">
>     have-tree <SHA-1 for "refs/remotes/origin/heads/">
>     have-tree <SHA-1 for "refs/remotes/other/heads/">

Yes, but we also have to be careful about how long we get the "famous"
list get. :)

>> [...]
>> FWIW, JGit is able to scan the canonical trees out of a pack file and
>> inflate them in approximately the same time it takes to scan the
>> packed-refs file for some 70k references. So we don't really slow down
>> much to use this. And there's huge gains to be had by taking advantage
>> of the tree structure and only inflating the components you need to
>> answer a particular read.
>
> Yes, that's another nice aspect of the design.
>
> I do worry a bit that the hierarchical storage only helps if people
> shard their reference namespace reasonably. Somebody who stores 100k
> references in a single reference "directory" (imagine a
> "refs/ci-tests/*") is going to suffer from expensive reference update
> performance. But I guess they will suffer from poor performance within
> Git as well, and that will probably encourage them to improve their
> practices :-) I suppose this is not really much different than people
> who store 100k files within a single directory of their working tree.

Yup. Gerrit Code Review shards refs/changes/ across 100 directories
for this reason as local filesystems don't like large numbers of files
or directories in a directory. But at 100k change entries you are
still dealing with 10k subtrees in each shard. The 100-sharding isn't
quite enough.

I started considering doing a notemap like sharding for reftree. Its
harder because the names aren't a uniform shape the way object ids are
in a notemap. But it could be possible to split by prefix, for example
start by building a table of all 2 character prefixes in the tree. If
this produces too many entries in any single 2 character subtree,
retry as a 4 character subtree. Continue extending the prefix until
either the number of unique prefixes in the parent tree is too many,
or the subtrees are acceptable sizes. If the parent gets to be too
many (1000?), freeze the parent prefix length and start splitting the
subtrees instead.

For tags you may wind up with a structure like:

  tags/
    v1../
      .0
      .2
    v2../
      .0
      0.125
    v3../
      0.98

Or whatever. Here I used ".." as a suffix on the splits like "v1.." to
indicate the name isn't itself a directory component, but a sharding
split. Thus we have tags "v1.0", "v2.0", "v20.125", "v30.98", etc.

It doesn't help the scalability of a source code tree having too many
files. But we could do some smarter splitting inside reftree to help
it scale even if people aren't sharding their ref namespaces. Sadly
this has a lot of downsides, its complex to write and its ugly.
