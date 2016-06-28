Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-9.3 required=3.0 tests=AWL,BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42BD92018A
	for <e@80x24.org>; Tue, 28 Jun 2016 17:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752493AbcF1RUM (ORCPT <rfc822;e@80x24.org>);
	Tue, 28 Jun 2016 13:20:12 -0400
Received: from mail-it0-f45.google.com ([209.85.214.45]:37689 "EHLO
	mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752457AbcF1RUK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Jun 2016 13:20:10 -0400
Received: by mail-it0-f45.google.com with SMTP id f6so20685326ith.0
        for <git@vger.kernel.org>; Tue, 28 Jun 2016 10:20:10 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yihNFU+GOkYNqd3mRM+iN/LW8F5BvJhcHKwHGNz932s=;
        b=LU5FDVjU8O5mZLuYjKmsSLpGhEr6bXxBLIH6sHEaCzCikerQScYq3IOtjHFY+Ec30c
         1Jsj6BPG18Mztz6eKAi1ByKBrhQi3fizY7aG+LvMnacYYnt6jcTXqzqbpKHG6X81hSm7
         gA1PtauiYaiYQ9IxENFMYSKyWNbQG3zH9ForGYsp2BCg4vJYh+cPWvsUuXIt7GTw+5Bi
         u0tbsERGNl0oAWvFZjliCFIN6yC7Gsb1BOy5X1pf4rSX/MWgoznqakw9lxMNKsnRG07F
         x5caAbyhzi2fcOSosoTtdC0dU4dM5faCozAvKWwph9vOjMajhAyAEh9P6kOvUH+fRQJq
         TPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yihNFU+GOkYNqd3mRM+iN/LW8F5BvJhcHKwHGNz932s=;
        b=c/tvGdVd0pqb+jAoe+puyMN/Mau44UHQq6h8+8w/WF6h8rOWGeGTLBz/eqWMquG7mu
         41V+kGp3Pt1I5wI1AEAPsmYLNo69IzkOuTriyXxiTs9snWPvIzdhCZX3MLCLxpvxYaf4
         QPXMUJiLuNdCuaA5tODbo2B0+HVXz/ZTmdaTia684QWrbNG39w3rY1KDFuu2PvedtnOZ
         K4mVW2iGWbWpJURm/upVgxLj0E4+xaqT4M2fDbwa/Xr2NPY/JeXbP2J7rCeaS/nFRiJv
         hn5OCmO1kgleIuhBEQoyt1yxxI1IbY9xyOIGOE52rwnLkvVWV2WDMu9Ah1G1dyPZ932L
         cOPQ==
X-Gm-Message-State: ALyK8tJO2Mur/3Astz0HknxRalml0kjMAKcexlQWWQu4Bc5a8/PKn4jR8+cTT+fHYmfjW8TwffAl48KWTqXQcnBM
X-Received: by 10.36.69.4 with SMTP id y4mr15481827ita.49.1467134409506; Tue,
 28 Jun 2016 10:20:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Tue, 28 Jun 2016 10:20:09 -0700 (PDT)
In-Reply-To: <f572d4ee-c618-6501-a8e5-717feca3ed7c@gmx.net>
References: <f572d4ee-c618-6501-a8e5-717feca3ed7c@gmx.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Tue, 28 Jun 2016 10:20:09 -0700
Message-ID: <CAGZ79kZQTv=QuuSGeYBQ+J89xQwtMmEsq7rvyFOAfSZfM+0YLA@mail.gmail.com>
Subject: Re: Shallow submodule efficiency
To:	Martin von Gagern <Martin.vGagern@gmx.net>
Cc:	"git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Mon, Jun 27, 2016 at 10:39 PM, Martin von Gagern
<Martin.vGagern@gmx.net> wrote:
> Hi!
>
> I have the feeling that “git submodule update --depth 1” is less clever
> than it could be. Here is one example I observed with git 2.0.0:

2.9.0 (as "Direct fetching of " is not part of 2.0.0 IIRC) ?

>
>   git init foo
>   cd foo
>   git clone --single-branch \
>             -b v0.99 https://github.com/git/git.git git-scm
>   git submodule add https://github.com/git/git.git git-scm
>   git commit -m Submod
>   git clone --dissociate . ../bar
>   cd ../bar
>   git submodule update --init --depth 1 git-scm
>
> This will download quite a bit of history, then result in an error message:
>
>   error: no such remote ref a3eb250f996bf5e12376ec88622c4ccaabf20ea8
>   Fetched in submodule path 'git-scm', but it did not contain
>   a3eb250f996bf5e12376ec88622c4ccaabf20ea8. Direct fetching of that
>   commit failed.

Yeah there are a few things going on, which try to cover up an error
in design IMO.

* The depth is measured from the tip of a branch in the submodule,
   not from the sha1 that the superproject points to.
* Shallowness is treated separately in the superproject and submodules as they
  have a strong notion of being independent. It would be cool to have a thing
  `git clone --recurse-submodules --depth=15
--submodule-depth-as-reachable-from-superproject`
  which would obtain the submodules as shallow as possible, but it
includes all versions that
  the 15 commits in the superproject points to. (may be 1 up to 15
  different non-sequential versions)


>
> That seems so avoidable, since the commit in question is a tag, so it
> would be perfectly possible to fetch that specific commit from the
> server directly. Something like the following commands would do the trick:
>
>   git fetch $url $(git ls-remote $url | \
>                    awk /$sha1/'{print $2}' | sed 's/\^{}//')
>

* `git submodule update --init --depth 1` is using clone instead of fetch
  currently when the submodule doesn't exist yet. The clone is buried in
  the `submodule--helper update-clone` that is a mixture of listing
the submodules
  and cloning multiple submodules in parallel if possible. So I would
assume it is
  easier to teach git clone to behave correctly and then stop retrying
in git-submodule.sh
  if `just_cloned` is set in the `cmd_update()`.

> If the commit in question is NOT a ref, then whether asking for it by
> unlisted SHA1 is supported will probably depend on the server's
> uploadpack.allowReachableSHA1InWant setting. I guess this is a reason
> why fb43e31 made the fetch for a specific SHA1 a fallback after the
> fetch for the default branch. Nevertheless, in case of “--depth 1” I
> think it would make sense to abort early: if none of the listed refs
> matches the requested one, and asking by SHA1 isn't supported by the
> server, then there is no point in fetching anything, since we won't be
> able to satisfy the submodule requirement either way.

Makes sense! I think the easiest way forward to implement this will be:

* `git clone` learns a (maybe undocumented internal) option `--get-sha1`
  `--branch` looks similar to what we want, but doesn't quite fit as we do not
  know, whether we're on a tag or not. The submodule tells us just the
  recorded sha1, not the branch/tag. So maybe we'd end up calling it
  `--detach-at=<sha1>`, that will
  -> inspect the ls-remote for the sha1 being there
  -> if the sha1 is there (at least once) clone as if --branch <tag> was given
  -> if not found and the server advertised  allowReachableSHA1InWant,
try again inside the clone

* `submodule--helper update-clone` passes the  `--get-sha1` to the
clones of the submodules

* cmd_update() in git-submodule.sh will only checkout submodules and
not try again
  to fetch them if `just_cloned` is set as the cloning did the best it could.


>
> For the case of “--depth n” with n > 1, I was wondering whether it would
> make sense to prefer the branch listed in submodule.‹name›.branch over
> the default branch.

Makes sense to me.

>
> I think shallow submodules would be very useful to embed libraries into
> projects, without too much care for history (and without the download
> times getting it entails), but with efficient updates to affected files
> only in case of a change in library version. But not being able to get a
> specific tag as a shallow submodule is a major showstopper here, I think.

Thanks for taking your time to point this out and start this discussion!

Thanks,
Stefan

>
> Greetings,
>  Martin von Gagern
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
