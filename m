Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0270915A853
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 10:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726569700; cv=none; b=Kbh7aNOpPECTgWFORVtRkp7G2i+5chBfWbmcmrlSYWuXyufkGZ7aus7+R7SfsYBATYudObJXPV62GTzCAVm52gD5bgTqiR1eeegnYRJ0A7Q5hfHSbg+Vsi/2cK1PqtHCIUgNLplZGJNZ0UmOazRgQ1siXRfdqVneiU43rN3qoRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726569700; c=relaxed/simple;
	bh=xP/4ThrL/KHZK7ZSRe+mi06vQhmHKeUmm8OfxtVqQSM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=unvsW0Mz2HFtZ8xsKjfRg3PNX2AV+8juo+4Pyb3x2YxDim+jZezzpbgWK3zqpZiwwpZp3ZMzbyQe7nPzx0fiWxjJuLGYcYZP411sShlnSYgZT8B0BWiSeVZlH2sArhPhA6p5nNfapwP8tClAP36cE4+wlWfQ/jCFA/EHIfa5oq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsgoNmYT; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsgoNmYT"
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2f75428b9f8so52788961fa.3
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 03:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726569696; x=1727174496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bzwbtv+hH0KWx01XlTe1z4hXWgD1WclEeSaNQUP30EU=;
        b=GsgoNmYTqiju9M/dykSuyLf5q1XYGRbDdCNOrV8/7mPvY6d2xRmkMeKUSfifsDLj1v
         xj9/vKAh07RZMIf6zHElREB8ktHySm+F6epzslvy9sfB+frubFIcK5KvUC3KhJTVmyW2
         4GnupFq+lE+rqovYCsPzrd3PzjLgvpM6BDVvgZHk3w59zlg4nFpRLdhA5F3cQUxUkqz7
         uhyWLDMPtg11zXZ/XooBiKBfai0LBbdjgISob2tShgwqr+IpeUkK14coC/Xgp/BGmPZl
         vZL1M5lIA37079nOkzIUFBJdtQnBqG/XhyRCV78Z9IAkJpP5YHXhJuPLUHQp+RHbqSHi
         gUyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726569696; x=1727174496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bzwbtv+hH0KWx01XlTe1z4hXWgD1WclEeSaNQUP30EU=;
        b=LMW2yg3F4tBxGBPiCbN/e4vbpYN1LRZ+esjnsFAvSh3HCmST7XfXPtecdMLp6vVc7M
         4KaRWqwxelki8iHke63M4NFd+ob7ObwH7naT8041bjj+DKaqvoPGZ3K1HQwTzMEmCdh9
         mXeOvZ9kWtmFkKINThCuXsgLNiESmP2TJnSAgPQOSrcXbqSi56VXuJdkGgw5XyjMbABD
         WJxac3/uMdmGEdpjl70EJptZ0ZkqhpoEyCNOXZaXk0nroC2EP3sJ7ftemlfXKQfg1RXJ
         lE+aPFuIJ8PMD+1SZ74X457eDwDh6fHioQsh7ubJxzVFqfjkrQDhYXrxByXu0fD8ct45
         QaJA==
X-Gm-Message-State: AOJu0YzYEn9JYZyDfK1V1k9THv0cKq/EHDeBT3JxOk05EtFq7Z0jNucT
	Rtrqmc8TB1brR5iXt70mj7y+xxjpwtZ7Wx3Cixo/lknMVO36EPx6TiLCUGhl0HuvDsMHm3JVM3A
	XEUomwWapJV7Txe+sQLpQm5fWFUs=
X-Google-Smtp-Source: AGHT+IFZNpjRVjtHZxTKWmVch/K3/c1XEdQWu8d9meEy3sF2or4m1itX12RWAjkaX8wR2Tyb/4LSgWUCjyxtPxvy6p0=
X-Received: by 2002:a2e:bea0:0:b0:2ef:28ed:1ff2 with SMTP id
 38308e7fff4ca-2f7918e4aebmr97605761fa.9.1726569695053; Tue, 17 Sep 2024
 03:41:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
In-Reply-To: <pull.1786.git.1725935335.gitgitgadget@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Tue, 17 Sep 2024 12:41:22 +0200
Message-ID: <CAP8UFD0uyVk5WPX12sGhWWXkdQWGpBhG29Q-9EmBxHos1XQ_uQ@mail.gmail.com>
Subject: Re: [PATCH 00/30] [RFC] Path-walk API and applications
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de, 
	peff@peff.net, ps@pks.im, me@ttaylorr.com, johncai86@gmail.com, 
	newren@gmail.com, Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 10, 2024 at 4:29=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> This RFC is ultimately about introducing a new way to walk objects, calle=
d
> the "path-walk API" in the new path-walk.[ch] files. Before digging into =
the
> details of the API, let's discuss the applications which will hint at the
> API's design.
>
>
> APPLICATIONS OF THE PATH-WALK API
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The applications of this API were discovered in the following order, thou=
gh
> I recommend reversing the order for the priority of their actual
> implementation in future patch series:
>
>  * git backfill: a builtin to download missing blobs in a blobless partia=
l
>    clone, done in batches and grouped by the path they appear in to maxim=
ize
>    delta compression in each batch. Allows focusing on the paths of the
>    sparse-checkout to only get the blobs necessary for history queries in
>    the current focus.

It's not very clear if this would be useful when doing a `git
sparse-checkout add`, or a `git blame` on a file path not covered by
the current sparse-checkout, or both. I think it would be clearer if
there were a few examples.

>  * git survey: Jeff Hostetler built this feature [1] as a way to get
>    functionality similar to git-sizer [2], but using the internals of Git=
 to
>    do it faster. It also displays information not available to git-sizer,
>    like the on-disk size of objects. This RFC presents a simplified versi=
on
>    of the builtin focused on listing the paths that contribute the most t=
o
>    the on-disk size of trees and blobs.

Not sure how `git survey` works, but `git sizer` works on a whole
repo, so, if they work in the same way, I am not sure I see what a new
path oriented way to walk repos would bring to the tool.

>  * git pack-objects --path-walk: In order to find a way to compute deltas
>    among objects of the same path, I applied the path-walk API to 'git
>    pack-objects' behind an optional flag. There are overlaps with the
>    '--sparse' option [3], [4] that can be used here. This provides perfec=
t
>    partitioning by path name, without any possible collisions from the
>    name-hash algorithm. It also allows using the name-hash values to find
>    cross-path delta chains in a second pass.

Do you mean that the new way to walk repos allows pack-object to
perform better in the general case or maybe only in the case where
partial clone without blobs and sparse-checkout are used as described
in the git backfill related point above?

>  * git repack --full-name-hash: If we are worried about name-hsah

s/name-hsah/name-hash/

>    collisions, an easier thing to implement is a different name-hash
>    algorithm that is less likely to have collisions.

Maybe it could help to remind people a bit (perhaps in a note or using
a link) what name-hash collisions are and why we could be worried
about them.

Actually there is a "DISCUSSION OF NAME HASH" section below with
explanations, so maybe a note could just tell about that section.

> This feature was
>    already sent to the mailing list as a fully-reviewable series [5]. It =
is
>    included here because this series allows testing the --path-walk optio=
n
>    against the --full-name-hash.

Do you mean that the new way to walk repos can be used along with `git
repack --full-name-hash` (maybe with `git repack --full-name-hash
--path-walk` or a config option or otherwise?) and that it brings some
performance or other kind (better packs or which ones?) of
improvements?

> [1] https://github.com/microsoft/git/pull/667 [2]
> https://github.com/github/git-sizer [3]
> https://github.com/git/git/compare/5d826e972970a784bd7a7bdf587512510097b8=
c7...99dbbfa8ddbba2b620965d026d4ec199b8837a6f
> [4]
> https://devblogs.microsoft.com/devops/exploring-new-frontiers-for-git-pus=
h-performance/
> [5]
> https://lore.kernel.org/git/pull.1785.git.1725890210.gitgitgadget@gmail.c=
om

It looks like adding line breaks could help make the above link list
more readable.

> TIMELINE FOR CREATING THESE APPLICATIONS IN THIS ORDER
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
>
> Here's the story about how these applications came about: I was tasked wi=
th
> understanding why certain internal repositories were growing larger than
> expected. (Feel free to skip. Otherwise, thank you for indulging me.)
>
> I first prototyped 'git backfill' as a way to download some of the larges=
t
> repositories without being blocked on a full clone. This batched download
> mechanism allowed me to essentially have a retryable clone, since the cli=
ent
> could restart the process from scratch and skip any objects that were
> already on disk. It was natural to batch based on the path of the blobs i=
n
> order to theoretically save time and network bandwidth due to better delt=
a
> calculations.
>
> While investigating these repositories, I had some data hinting at the to=
tal
> size of the objects by type.

By type (blob, tree, commit, tag?) or by path? Why would the size of
the objects by type be interesting? Could trees delta poorly?

> But I was most interested in learning what
> exactly was causing this growth. I did have a hint that the "release"
> branches were taking up much more space than the default branch, since
> cloning with --single-branch resulted in ~55GB of data but then fetching =
the
> release branches led to an additional ~125GB of data. Using "git diff" it
> was clear that these branches stored some CHANGELOG.json and CHANGELOG.md
> files, but the diffs were relatively small (but multiple such changes wer=
e
> batched together into a single new commit). I needed to see why exactly
> these paths were taking up so much space.
>
> To this, I turned to Jeff Hostetler's new "git survey" command. This told=
 me
> information about the total size of trees and blobs and told me the path
> name for the individual blobs that were the largest in the repository.

Nice.

> These
> paths were typically binary files that appeared only once or twice and di=
d
> not account for the scale issues.

You mean they couldn't account for a 55GB to 125GB change in data size?

> I modified 'git survey' to use the same
> path-batching logic as in 'git backfill' to then consider each batch of
> objects and their size. Thus, the "path-walk API" was born. (This RFC
> contains a version that looks like it was created before 'git backfill'.)
>
> The repository I was looking at had a clear pattern in its top 100 file
> paths by on-disk size: 99 of them were CHANGELOG.json and CHANGELOG.md
> files. The .md files surprised me, since they were always simple appends =
of
> the previous .md file at the same path. The .json files were capped in ho=
w
> many versions were being listed (at least in recent versions) but the dat=
a
> it stored was harder to compress. So I went looking into how 'git push' w=
as
> calculating these delta bases. Adding some debug information to 'git
> pack-objects' demonstrated that the previous file versions were not being
> matched as delta bases. Instead, other new blobs in the push were being u=
sed
> as delta bases.

Interesting.

> This meant that what should have been a trivial set of deltas bloated to
> 20-60 MB. (We will see later that it is possible for these to be 100-500
> KB.)
>
> Here is where I went on a little bit of a detour. (Come with me, it's
> important.) I knew that 'git pack-objects' used a name-hash to group obje=
cts
> by path, so I assumed that the reason these delta bases were not found wa=
s
> because the UNINTERESTING objects were not being added to the packing lis=
t.
> I have since discovered that this is incorrect, but I might have gotten
> stuck if I didn't think this.
>
> This seemed like a natural reason to extend the path-walk API to allow
> walking commits and tags as part of 'git pack-objects' behind a new
> '--path-walk' option. The idea here is to compute deltas among the object=
s
> that share a common path and then later go through the (type, name-hash,
> size) sorting system to find other delta bases across path boundaries. Af=
ter
> a lot of testing, failing, and testing again, the implementation in this =
RFC
> finally works to achieve the goal. It's not pretty (especially with how i=
t
> handles tags) but it gets the job done.

Yeah, if it can significantly improve the generated packfiles (without
drawbacks), it looks like a great improvement.

> In hindsight, I realized that the UNINTERESTING objects were being
> considered, but due to collisions in the name-hash algorithm these object=
s
> were being sorted outside of the delta computation window. For this reaso=
n,
> I thought to create a new name-hash algorithm. Thus, the --full-name-hash
> option for 'git pack-objects' and 'git repack' was born. This feature was
> split out and sent to the mailing list independently from this RFC.

So the question is "Is the problem fully solved by the new name-hash
algorithm or are there still benefits to using a new way to walk
repos?"

> RFC GOALS
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The goals of this RFC are:
>
>  1. To demonstrate potential applications of the path-walk API to motivat=
e
>     its generality

Yeah, the "Path-walk API and applications" title summarizes this well.

> as these features are sent in full-quality patch series,
>     but in a different order.

I wonder if the patch series could have been separated and not all
sent in a 30 patch long series.

>  2. To communicate the discoveries found during the --path-walk and
>     --full-name-hash features in 'git pack-objects' and 'git repack'. Thi=
s
>     includes comparing and contrasting the effectiveness of these feature=
s.

Thanks for communicating that.

>  3. To demonstrate the value of the path-based batching in the 'git surve=
y'
>     feature, and to inspire others to think about what other statistics
>     would be valuable in that feature. (I anticipate that once a base is
>     established, multiple contributors will help expand its functionality
>     long into the future.)

Yeah, a better git sizer would be valuable for GitLab too and probably
everyone hosting a significant number of repos.

> RFC OUTLINE
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The patches are grouped roughly by the application, in order of discovery=
:
>
>
> PART I: 'git backfill'
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> These patches introduce the 'git backfill' builtin including its
> '--batch-size' and '--sparse' options. While this is the first and simple=
st
> application, it is also the lowest priority in terms of user need.
>
>  * path-walk: introduce an object walk by path
>  * backfill: add builtin boilerplate
>  * backfill: basic functionality and tests
>  * backfill: add --batch-size=3D option
>  * backfill: add --sparse option
>  * backfill: assume --sparse when sparse-checkout is enabled

I would prefer a first patch series with all the above and the first
patch creating a technical doc called maybe
Documentation/technical/path-walk.txt which could contain a lot of
information from this RFC and perhaps technical details of how the
path-walk works and how it is different from a regular walk.

> DISCUSSION OF NAME HASH
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> One thing to talk about before digging into --path-walk and --full-name-h=
ash
> features is the existing name-hash algorithm. This hash algorithm creates=
 a
> uint32_t based on the final 16 characters of the path name, weighing the
> last characters more. There are multiple benefits to this:
>
>  1. Files of common types (.c, .txt, ...) may be grouped together.
>
>  2. Files that are renamed across directories may be grouped together.
>
> (Thanks, Junio, for making this second benefit clear.)
>
> The issue here is that some common patterns arise in repositories that us=
e
> common path names across directories, and those files are creating name-h=
ash
> collisions and making the sort less effective. One thing that can counter=
act
> these collisions is to increase the --window setting, but this significan=
tly
> slows the delta computations.
>
> Thus, the --path-walk and --full-name-hash features both attempt to comba=
t
> these name-hash collisions in very different ways. The --path-walk mechan=
ism
> uses the path-walk API to consider batches of objects that all share the
> same path. This avoids storing every possible path names in memory while
> doing the object walk, but still gives nice boundaries for delta compress=
ion
> possibilities. After the path-walk is complete, the full packing list is
> still sorted via name-hash and this allows for cross-path deltas. This is
> critical!
>
> The --full-name-hash feature does the simpler choice of replacing the
> name-hash method with one that has fewer collisions, but loses the benefi=
ts
> of "nearby" paths having close hash values.

The benefits of "nearby" paths are only available with --path-walk,
not in the current way object packing works.

> This naturally leads to these two main differences in the two approaches:
>
>  1. The --full-name-hash feature is not good for 'git push' or similarly
>     small pack-files. Since it limits the delta chains to objects with th=
e
>     same full path and loses the benefit of "nearby" paths, this feature
>     should be used for larger repacks. In my testing, 'git push' simulati=
ons
>     almost always have poor packing but 'git repack -adf' simulations hav=
e
>     packing rivaling the --path-walk option.

Interesting.

>  2. The --path-walk option changes the object ordering significantly,
>     meaning it may not ever be appropriate to combine with advanced
>     repacking features such as delta islands or even reachability bitmaps=
.
>     While my testing has shown that the --path-walk repacks are the most
>     efficient of all options, this limitation makes me hesitate to recomm=
end
>     it wider than client repositories.

Might still be interesting to have it for client repos.

> One natural question to consider is to think about storing both the
> name-hash and the full-name-hash and doing two delta passes, each one
> sorting the objects by a different hash function. The first issue is that=
 we
> don't want to store two hash values per object, as that will significantl=
y
> increase the memory pressure during repacking.

Is one more uint32_t per object really increasing the memory pressure
so much? Isn't there a way to pack bits together to avoid that?

> This could be side-stepped by
> storing the full-name-hash in the packing list and then a second mapping
> from full-name-hash to name-hash. However, that still leads to the two
> passes taking extra time.

Isn't there a way to sort using both hash functions in a single pass?
(That is to perform a single pass and when considering an object sort
it using both hash functions before considering a different object.)

> The --path-walk approach is faster than even a
> single pass.

Is there a reason for that?

> And in the right scenarios, the --full-name-hash option is very
> close to the --path-walk results.
>
>
> ANALYSIS OF PACKING STRATEGIES
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
>
> Since I was focused on an internal monorepo that stored a large collectio=
n
> of Javascript packages, it should be no surprise that I eventually found
> other Javascript repositories that used similar tooling and thus had simi=
lar
> issues with unexplained scale problems. I'll use these four repositories =
as
> examples repeatedly, but one is actually public: microsoft/fluentui [6].
> I'll use Repo B, C, and D for the others, in increasing size.
>
> [6] https://github.com/microsoft/fluentui
>
> In each of these repositories, doing a full repack ('git repack -adf') ri=
ght
> after cloning presents a sizeable reduction in space. This is expected fo=
r
> servers not being optimized for exactly the reachable set I'm cloning. So=
,
> I'll focus on how much the default repacking parameters compare to using =
the
> --full-name-hash or --path-walk options:
>
> | Repo     | Standard Repack | With --full-name-hash | With --path-walk |
> |----------|-----------------|-----------------------|------------------|
> | fluentui |         438 MB  |               168 MB  |          148 MB  |
> | Repo B   |       6,255 MB  |               829 MB  |          778 MB  |
> | Repo C   |      37,737 MB  |             7,125 MB  |        6,158 MB  |
> | Repo D   |     130,049 MB  |             6,190 MB  |        4,432 MB  |
>
>
> Hopefully these reductions show how much these name-hash collisions are
> causing issues in these repositories.

Yeah, right. It might be interesting to see the size reduction in % too.

> For the fluentui repo, I'm also able to share highlights from the 'git
> survey' output immediately after cloning and after repacking with the
> --path-walk option.
>
> First, we can consider the total reachable objects in each scenario:
>
> TOTAL OBJECT SIZES BY TYPE
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Object Type |  Count | Disk Size | Inflated Size
> ------------+--------+-----------+--------------
>     Commits |  20579 |  10443669 |      15092790
>       Trees | 276503 |  40212070 |     244429615
>       Blobs | 294500 | 635365661 |   10791187920
>
> TOTAL OBJECT SIZES BY TYPE
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Object Type |  Count | Disk Size | Inflated Size
> ------------+--------+-----------+--------------
>     Commits |  20579 |  10450605 |      15092790
>       Trees | 276503 |  31136263 |     244429615
>       Blobs | 294500 |  94442401 |   10791187920

Using % of size reduction or increase might help make it a bit clearer here=
 too.

> Now, we can consider the top 10 file paths before and after repacking wit=
h
> the --path-walk feature:
>
> TOP FILES BY DISK SIZE
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                            Path | Count | Disk Size | Inflated Size
> --------------------------------+-------+-----------+--------------
>                       yarn.lock |   802 |  58060531 |     889120488
>  ...-experiments/CHANGELOG.json |   505 |  28439452 |     252723999
>  ...fabric-react/CHANGELOG.json |  1270 |  25556510 |     902756623
>  ...t-components/CHANGELOG.json |   176 |  20366365 |     244936649
>  ...act-charting/CHANGELOG.json |   590 |  20106422 |     208224460
>  ...e-components/CHANGELOG.json |   559 |  15761271 |     189061764
>  ...act-examples/CHANGELOG.json |   577 |  13615569 |     234949961
>  ...react-charting/CHANGELOG.md |   564 |  11205840 |     104337986
>  .../experiments/CHANGELOG.json |   569 |  10596377 |     123662770
>  ...i-fabric-react/CHANGELOG.md |  1263 |   8154248 |     261494258
>
>
> TOP FILES BY DISK SIZE
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>                            Path | Count | Disk Size | Inflated Size
> --------------------------------+-------+-----------+--------------
>                       yarn.lock |   802 |   9909326 |     889120488
>  ...iceBrandGuide_16Sep2016.pdf |     1 |   2106334 |       2186005
>  ...out/src/images/download.jpg |     1 |   1845249 |       1846117
>  ...fluent-ui-logo-inverted.png |     3 |   1370372 |       1447493
>           .yarn/releases/cli.js |     1 |   1335657 |       6741614
>  ...c/images/fluent-ui-logo.png |     3 |   1272902 |       1341139
>  ...ages/fluent-ui-logo-dev.png |     3 |   1130989 |       1186897
>  ...nents/public/SegoeUI-VF.ttf |     1 |   1074046 |       1844524
>  ...ig/rush/npm-shrinkwrap.json |   138 |   1058531 |      89326567
>  ...Accessibility_29Sep2016.pdf |     1 |    856621 |        927268
>
>
> As we can see from this example, before the repack we are mainly seeing t=
he
> disk space be dominated by objects that appear at paths with CHANGELOG.js=
on
> or CHANGELOG.md, which are frequently hitting collisions with the default
> name-hash. After the repack with the --path-walk feature, we see the larg=
est
> paths are what we expect: checked in binaries, frequently-edited yarn fil=
es,
> and other hard-to- compress data.
>
> The nice thing about this result is that we can point to files that are
> taking up space because there is no other way around it, not that the nam=
ing
> convention for the files is causing confusion during packing.

Yeah, nice result. I guess the result is the same or very similar when
the improved name-hash algorithm is used.

> WHAT TO DO NOW?
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Thank you for reading this far. I hope that this has added context on the
> patch series for the --full-name-hash option, but also provided the right
> context for when I come back in a week or so with a review-ready version =
of
> the --path-walk option.
>
> These patches are rough and I want to make sure everyone knows that.
> Reviewing them for style or even basic organization may lead to some wast=
ed
> time. I know that at least one of the patches got mangled and its diff do=
es
> not match its description (I'm thinking specifically about "pack-objects:
> extract should_attempt_deltas()" but this could apply elsewhere).

Ok, I will wait for the next iteration before reviewing the patches then.

> But I think that interested parties could take my branch, build it, and g=
ive
> these features a try on their favorite repos. I'd love to hear feedback o=
n
> the usability and effectiveness, especially if someone finds a case where
> the --path-walk option is less effective at packing data.

I might do that when reviewing the patch series later. I think it can
still be valuable for you to get some first feedback from just reading
this RFC.

Thanks.
