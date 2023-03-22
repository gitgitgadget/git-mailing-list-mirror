Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE5FCC6FD1C
	for <git@archiver.kernel.org>; Wed, 22 Mar 2023 12:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCVMOQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Mar 2023 08:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjCVMOO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2023 08:14:14 -0400
Received: from weald2.air.saab.se (weald2.air.saab.se [136.163.212.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4D81C587
        for <git@vger.kernel.org>; Wed, 22 Mar 2023 05:14:12 -0700 (PDT)
Received: from mailhub1.air.saab.se ([136.163.213.4])
        by weald2.air.saab.se (8.14.7/8.14.7) with ESMTP id 32MCEAjm023727
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Mar 2023 13:14:10 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 weald2.air.saab.se 32MCEAjm023727
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=saabgroup.com;
        s=weald2_2; t=1679487250;
        bh=WbQ6LJlqRD6+zPUO8ynGAiqqZZ2wpAz8kPnbbxUapsc=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=AMa68SRI6KSgS2bfEKIXtuHv3UOgDNj0iE90QPEKca5ZaEfB4ZwnaSEJZUrJWUJMF
         WSyHY/UkbUEjAJ19rGXyEN8Lrzm+3fttIDWip7Wgkm8hnUGv1EwUWW+K2oWVgljpUb
         EJNCioTGNu1PRm84LIZK4E++GQOU9YP6F39eAL0xZPt5gItN0EgUGaJ+WaDiEGHtLO
         6Qd95GvQfxWMXUfeyQ+mJ3ZURHVUHjyL1CKlvjqUNvTinZjVJOyhoIZ+c14TCICq/9
         cDrHhPcuF7xgBnRnOttOzliZGVu4UxsQRoVLEQ8wdlXca5OFXEWQ3sD3Q1yY+mOhAM
         ETT1tH7OFwLOA==
Received: from corpappl17782.corp.saab.se (corpappl17782.corp.saab.se [10.12.196.89])
        by mailhub1.air.saab.se (8.15.2/8.15.2) with ESMTPS id 32MCEALG363606
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Mar 2023 13:14:10 +0100
Received: from corpappl17778.corp.saab.se (10.12.196.85) by
 corpappl17782.corp.saab.se (10.12.196.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 22 Mar 2023 13:14:09 +0100
Received: from corpappl17778.corp.saab.se ([fe80::8df4:c4d8:a91e:cc18]) by
 corpappl17778.corp.saab.se ([fe80::8df4:c4d8:a91e:cc18%14]) with mapi id
 15.02.1118.026; Wed, 22 Mar 2023 13:14:09 +0100
From:   Lundkvist Per <per.lundkvist@saabgroup.com>
To:     Elijah Newren <newren@gmail.com>
CC:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [EXTERNAL] Re: Soundness of signature verification excluding
 unsigned empty merges
Thread-Topic: [EXTERNAL] Re: Soundness of signature verification excluding
 unsigned empty merges
Thread-Index: AQHZW9YuL0XHoZNDkEewevJzAqRee68F9kUAgAC7M1g=
Date:   Wed, 22 Mar 2023 12:14:09 +0000
Message-ID: <573a64fb04584a4aa2329c471037d717@saabgroup.com>
References: <27a7d2956ed94d7ea8eb6d17f1414525@saabgroup.com>,<CABPp-BGnYWHtrM8fJN+79QLvm-GeXgJpxH4u=zvjJ0j9bUaE3A@mail.gmail.com>
In-Reply-To: <CABPp-BGnYWHtrM8fJN+79QLvm-GeXgJpxH4u=zvjJ0j9bUaE3A@mail.gmail.com>
Accept-Language: en-AU, sv-SE, en-US
Content-Language: en-AU
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.12.197.17]
x-tm-as-product-ver: SMEX-14.0.0.3092-9.0.1002-27518.007
x-tm-as-result: No-10--48.257700-8.000000
x-tmase-matchedrid: Q+Qb/1W9sw2JVA+ukO+5MXpXbwx9aHgaKQNhMboqZlrGZbX3v50Wr1et
        2+X+8Ssk+h4WVqRDM2SlSAHrgJy+OayIojbPJPaLsWltH2OCDLhbVWMeHOeZaKBp/T5dSs2TnRw
        gpbfXKvNrcB4GOn+Ce1VjJl6w+9eHbpOfTFQFY51HcypzEXqVgfNkoMDX+kiumbc4hVJ/g/mKUm
        aUXynhB5VWyI5X7Jg/P0VdPfZSP6pMKhDraAiV+QQ6EfMOwvTm8FHp8LCpZ7TmWHHSYEnI8dtfm
        9cFsPB5m7e8kZMMIGEvI7XVWcvnx2ob6A84c/fIko6EUr8mSdDBOVz0Jwcxl9cUntbeUinj46Pg
        N+edpY1uzWd9DcHaseL+aEy0JmjW9RYy+aTqMwVE34UwpVkGEXZljA0Gozoiw6juv/EevUBJSAn
        bpIXILN7Aqx9s620W52W0jAJ5nUROcNR3zaWyONfeP+V/VXwsZR+OFNkbtdpf/JRqlbLSV0kwqD
        rjScm94Necrk97o2gskT+41HfwKPn/om5XE6y/OH1VCwfyKqHlsyZ05iz8b4Ajsy+r+wvnFACu+
        6f4ntamHQmxPIP4pez5eKL49Xrm6OH0+FhIoVXHM1p4NoWyg1mirzmgRbYUrvcsxx7tGYlCmbBu
        CcqmbbRfnUuG1C+8EXKNPbUop13CTf+oLmtxdKoXHZz/dXlx1KDIlODIu+XLwwwRZ45jJVzzJKQ
        55jKCk3rwc5HCvnJp1Na7mcDSAlm+57/b5h33olgN5cVNNRM2vbWaKPnQ242cB1+t/hlep1L8iU
        73P/NvbrfceL5NR9vMFFvsTlAzDscsGb8cRiSeAiCmPx4NwFkMvWAuahr8+gD2vYtOFhgqtq5d3
        cxkNQP90fJP9eHt
x-tm-as-user-approved-sender: No
x-tm-as-user-blocked-sender: No
x-tmase-result: 10--48.257700-8.000000
x-tmase-version: SMEX-14.0.0.3092-9.0.1002-27518.007
x-tm-snts-smtp: 436497A8BD7B1A33B716FC6942D30A3276B45DD16B3B147B4CD4694CF02A62BB2002:B
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> wrote:

...
> What does "validate" mean in this context?  Junio asked a bit about this.
>
> An alternative he didn't bring up is perhaps you are trying to protect
> against supply chain attacks, with a scenario such as someone gains
> remote access to some computers on your system, but not to any gpg
> keys (because developers are using gpgs on yubikey or something like
> that).  In such a case, you might ask the question of whether you can
> determine if such an attacker has inserted additional commits to your
> history.  You can use gpg-signed commits by known gpg-keys to rule out
> most commits as being from a potential attacker, but odds are your git
> hosting service does merges but doesn't sign them.  You want a way to
> differentiate between merges it makes and ones an attacker might sneak
> in.  And you are trying to equate "unsigned empty merge commit" with
> "was a clean merge anyway, and we're not worried about any permutation
> of clean merges of signed code".
>
> Or maybe you mean something completely different by "validate".

No, you describe it perfectly :)

>
> Junio brushed over whether you could assume "unsigned empty merge
> commit" is equivalent to "was a clean merge", so I'll focus on that.
> You often can make such an assumption, but it's not valid in general.
>
> > A simple naive example of this would look something like this:
...
> > Or is this a faulty strategy?
>
> It's faulty, but it'd only rarely trip you up.
>
> First off, I would use --remerge-diff over --cc.  --remerge-diff was
> designed to show whether the user made changes relative to what a
> current automatic remerge of the parents would give (so it shows
> whether and how they resolved conflicts and if and what other changes
> they added in).  --cc comes close when you only want to know if the
> merge was clean, but still isn't quite the same.  One example I can
> think of is that if there is a modify/delete conflict that the user
> resolves in favor of keeping the file, then the merge obviously wasn't
> clean.  But $(git show --pretty=3Dformat: --cc $i) will come back empty
> (leading you to think the merge was clean) while $(git show
> --pretty=3Dformat: --remerge-diff $i) will show there was a
> modify/delete conflict.

OK, I was not aware of --remerge-diff (we're currently on git 2.35), but fr=
om
your description it seems to be much preferable. --cc makes it even easier =
to
sneak in old commits cleanly than expected.

> Second, even with remerge-diff, it is only checking whether a merge with
> today's merge algorithm and config settings would be clean.  Changing
> diff.algorithm could in rare cases affect whether commits can be merged
> cleanly -- and the default in the past was "myers" whereas nowadays for m=
erge
> specifically it is "histogram".  Also, there have been changes to both of
> these algorithms in the past (one notable example being the introduction =
of
> diff.indentHeuristic and later turning it on by default), and there may b=
e
> more such changes in the future.  Similarly, merge.directoryRenames was
> essentially "false" before it was introduced, then was "true" for a while=
,
> then defaulted to "conflict".  Someone could have made a merge with an ol=
d
> version of git that used either "false" or "true" for merge.directoryRena=
mes
> and have it be clean, but when you go to remerge the same commits today y=
ou
> get a conflict due to that variable defaulting to "conflict".  Further, t=
he
> person running this script may have various `diff` or `merge` config sett=
ings
> globally that differ from those used by whoever or whatever did the past
> merges.  And, you have to account for the fact that the merge might have =
been
> made with something other than git.  GitHub and GitLab used to use libgit=
2,
> which had an entirely different merge algorithm.  Gerrit uses jgit, which=
 has
> its own merge algorithm.  Realistically, there isn't that much difference
> between all these algorithms.  For nearly all merges, any of these merge
> algorithms with any of these options will give the exact same answer...bu=
t
> "nearly all" !=3D "all".  So, there is no guarantee.  And we can't and wo=
n't
> even guarantee it going forward even if you stick with Git and somehow en=
sure
> using the same config settings either, because we may make further change=
s to
> diff and merge algorithms in the future, which may affect the "clean
> remergeability" (or whatever you call it) of merges you make today.

Good points.

I think we could live with false conflicts. We can acknowledge false negati=
ves
with a signed tag for only this purpose, right when they occur. We could al=
so
try to control the local git version and its settings. False positives howe=
ver
are worse of course.

> All that said, the odds that
> you discover a particular merge in the wild where any of this matters
> to your usecase is probably small.  So you might get away with
> it...but if you try it, you should probably add some good comments to
> the code for whoever comes along and investigates a "bug" in the
> future, to let them know that false negatives and false positives are
> possible with your checks, but that you just assumed they would be
> rare enough that you decided to ignore them.
>
> Finally, just a couple preference questions: I'd have used [ -z
> "$diff" ] rather than [ ! "$diff" ], and a simple "exit 1" rather than
> "rc=3D1" to exit early, but maybe you really want all the output.  But
> if you do want the output, would it make more sense to have the  -z      =
                                                                           =
                                                             =20
> "$diff" before the git verify-commit "$i"?  Also, I'd be tempted to
> use "git log --format=3D'%h %G? %s' $RANGE" rather than call git
> verify-commit N times, and then post-process all the "N" cases, but
> what you have works too.

Yeah I wanted to show an as simple example as possible. The real version us=
e
explicit fifos, parallel xargs and shows an error for unsigned commits whil=
e
minimising the amount of calls to git verify commit, for performance reason=
s. It
just wouldn't have been a suitable example ;) I appreciate the feedback tho=
ugh,
thank you!

So for a smart enough attacker and a large enough commit history, depending=
 on
the nature of commits and certain time windows, they may be able to introdu=
ce
previously signed commits that both go undetected and cause damage. This
validation strategy is also brittle, since it depends on the internals of t=
he
git implementation and the chosen diff algorithm.

The proper way, and the only way to fully validate the repository would sti=
ll be
to require all merge requests to be signed.

We'll see, maybe this can serve as an interim, imperfect solution until we =
have
changed our developer workflow. It looks like introducing signed commits an=
d a
validation strategy (although somewhat brittle) to our current developer
workflow, would still be an improvement since it is both hopefully a bit tr=
icky
to reintroduce old signed commits and we currently have no way at all to re=
ally
authenticate the commits.

Thank you (and Junio) very much for the thorough responses, highly apprecia=
ted.
