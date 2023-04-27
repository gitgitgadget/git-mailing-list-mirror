Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B987EC77B61
	for <git@archiver.kernel.org>; Thu, 27 Apr 2023 23:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbjD0XUR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Apr 2023 19:20:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjD0XUQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Apr 2023 19:20:16 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7454E2728
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 16:20:14 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-640f1e4a983so3872748b3a.3
        for <git@vger.kernel.org>; Thu, 27 Apr 2023 16:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682637614; x=1685229614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wMNxWWR3Q3EsKmJ6ACbnDGk3Vvxx9RoSTQkZusglZyI=;
        b=1rq4vMG8H8QFtP5o6PbV7pe+lOl0BNzBnmGxBMG/N6TDe2OuoeULSlduUZ9HVBjXvy
         xU56P98t7WjE3bepJq6kCSs24b7S+iqShxOIcyy/Gu+3wnP++/njM2Qo8SklBC8KdB/X
         gOEAAVe0097TuVsY5+BEbnFdoxrN4orLSpUtPk3xzHThAC8oEo1L+HKZdn18id7aiFdJ
         /KyGfxX22WEirUuiaB5kn7uaFstlnzrzYQxS1I9ggyskapnTu12dS0ZM6yXNfmwtuYu/
         IK5XHaTLOkuU8uXSpkZF+7IPuZuLYx9spnQNngYqjzbmX4WIz26BVm9ujTgFiJXkVvMV
         vIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682637614; x=1685229614;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wMNxWWR3Q3EsKmJ6ACbnDGk3Vvxx9RoSTQkZusglZyI=;
        b=LpMxJPJRxMfbfUFN+L3Db7gROS1BevStG5bm6iA7EUi6j4y37z7PMP6gqxKaos2bJT
         KhGQCAn5pijulcJPSjFBVLIJXH2xZHH4+LGU8kUNo4rTt6iRerHXoA4rp/6jT3RZPltP
         pHKcWFgcvoUBo2wjiFPng3HPxmneJm2cRK6kZZJ5zYMxinTgZi1ITZGUiZxd+M0z8c9/
         oGHAtZJir6dimucUDxU+EwAGon7qR4rkdZ/ze+QhVhCEu0UayZsk29HQpGaHFyuMT+7i
         jfGGKpYsXCrvR1hyeAHfYdVsqV1rDFQCUeGCj+tvy41ZSHJ4EDKLm/EFGadc3MG6jAEV
         RcRQ==
X-Gm-Message-State: AC+VfDwV1iJMD/kMwCUkWaaPxj4ToatJV15JaP4SDqhbHUTgcjUph4Zd
        3uceAGju5PQiGw51YumeACzxr17sYVX06A==
X-Google-Smtp-Source: ACHHUZ5Eu2HxirIkiiaYi8NPPMHfVNmNf0FbyoxQVPB5Nzp4Zt6jYhr7JJOX+dUhUMQmBtSHbDAxYxmuUuNZbA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:3a07])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:2c6:b0:63d:257e:ee18 with SMTP
 id b6-20020a056a0002c600b0063d257eee18mr902774pft.6.1682637613929; Thu, 27
 Apr 2023 16:20:13 -0700 (PDT)
Date:   Thu, 27 Apr 2023 16:20:12 -0700
In-Reply-To: <ZEpVSrz-uUcfN_3_@ncase>
Mime-Version: 1.0
References: <cover.1681906948.git.ps@pks.im> <301138da039451519c6e60d6126e7756a54d346f.1681906949.git.ps@pks.im>
 <kl6lzg6umne9.fsf@chooglen-macbookpro.roam.corp.google.com> <ZEpVSrz-uUcfN_3_@ncase>
Message-ID: <kl6lfs8knc9f.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: [PATCH 8/8] fetch: introduce machine-parseable "porcelain" output format
From:   Glen Choo <chooglen@google.com>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Apr 26, 2023 at 12:52:46PM -0700, Glen Choo wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> 
>> > The output format is quite simple:
>> >
>> > ```
>> > <flag> <old-object-id> <new-object-id> <local-reference>\n
>> > ```
>> 
>> This format doesn't show the remote name or url that was fetched. That
>> seems okay when fetching with a single remote, but it seems necessary
>> with "--all". Perhaps you were planning to add that in a later series?
>> If so, I think it's okay to call the "porcelain" format experimental,
>> and forbid porcelain + --all until then.
>
> The reason is mostly that I didn't find an output format that I really
> liked here. We'd basically have to repeat the remote URL for every
> single reference: just repeating it once per remote doesn't fly because
> with `--parallel` the output could be intermingled. But doing that feels
> wasteful to me, so I bailed. I guess I'm also biased here because it
> just wouldn't be useful to myself.

Yeah, I couldn't think of a good way to output the remote URL either.

> So with that in mind, I'd like to continue ignoring this issue for now
> and just not report the remote that the ref came from. But I'd also
> argue that we don't have to restrict porcelain mode to single-remote
> fetches: it can still be useful to do multi-remote fetches even without
> the information where a certain reference update comes from. So any kind
> of restriction would feel artificial to me here.
>
> Furthermore, I'd argue that it is not necessary to label the format as
> experimental only because of this limitation. With the refactorings done
> in this and the preceding patch series it is easy to add a new format in
> case there indeed is somebody that would have a usecase for this. The
> "porcelain" format should stay stable, and if we decide that we want to
> also report the remote for each reference in a follow-up we can easily
> add a "porcelain-v2" or "porcelain-with-remote" format.

I agree that the current form is useful, but it seems quite likely that
users will want the remote name/url at some point. In the majority of
cases, the user can parse the remote name from the updated local ref and
if they want, they look up the url by asking "git config", but that
breaks down quite quickly if they have a custom refspec.

My suggestion to label it experimental was meant to give us the freedom
to change the "first version" in backwards-incompatible ways that we
otherwise couldn't. We could say "here's porcelain-v2, use this and
ignore porcelain-v1", but it would be even nicer if the user didn't need
to think about porcelain-v1. The idea is that we could call it
experimental, see what users need in the wild, then make changes without
having to create a new "porcelain-v2" mode.

(I realize in hindsight that calling it experimental sounds a bit
insulting. I thought your proposal was quite sensible, actually. i
apologize if it came across that way)

Perhaps part of the reason why you'd prefer not to make it experimental
is that users who might want this feature are too afraid of
backwards-incompatible changes. I think that's fair. A different way of
achieving the same flexibility would be to make the "porcelain" format
extensible (like git status --porcelain=v2). A future, multivalued
"--porcelain-options=show-remote-url,show-remote-ref" would cover
our bases.

I'm happy with either approach as long as we don't have to bikeshed
about the "perfect" porcelain output :)

>> > With these assumptions, the output format becomes unambiguously
>> > parseable. Furthermore, given that this output is designed to be
>> > consumed by scripts, the machine-readable data is printed to stdout
>> > instead of stderr like the human-readable output is. This is mostly done
>> > so that other data printed to stderr, like error messages or progress
>> > meters, don't interfere with the parseable data.
>> 
>> Sending the 'main output' to stdout makes sense to me, but this (and
>> possibly respecting -z) sounds like a different mode of operation, not
>> just a matter of formats. It seems different enough that I'd prefer not
>> to piggyback on "fetch.output" for this (even though this adds more
>> surface to the interface...).
>> 
>> We could add --porcelain and say that "fetch.output" is ignored if
>> --porcelain is also given. That also eliminates the need for
>> --output-format, I think.
>
> I was thinking about this initially, as well. But ultimately I decided
> against this especially because of your second paragraph: we'd now need
> to think about precedence of options and mutual exclusion, and that to
> me feels like an interface that is less obvious than a single knob that
> works as you'd expect.

My full thoughts on this are in

  https://lore.kernel.org/git/kl6lildhlz3i.fsf@chooglen-macbookpro.roam.corp.google.com

but the short version is that I'm not sure if I expect something as
innocuous-looking as --output-format would imply other, machine-friendly
things (like stdout instead of stderr), and using --porcelain might make
option precedence clearer in some situtations (like if -z is given).

>> > +test_expect_success 'fetch porcelain output with HEAD and --dry-run' '
>> > +	test_when_finished "rm -rf head" &&
>> > +	git clone . head &&
>> > +	COMMIT_ID=$(git rev-parse HEAD) &&
>> > +
>> > +	git -C head fetch --output-format=porcelain --dry-run origin HEAD >actual &&
>> > +	cat >expect <<-EOF &&
>> > +	* $ZERO_OID $COMMIT_ID FETCH_HEAD
>> > +	EOF
>> > +	test_cmp expect actual &&
>> > +
>> > +	git -C head fetch --output-format=porcelain --dry-run origin HEAD:foo >actual &&
>> > +	cat >expect <<-EOF &&
>> > +	* $ZERO_OID $COMMIT_ID refs/heads/foo
>> > +	EOF
>> > +	test_cmp expect actual
>> > +'
>> 
>> As mentioned upthread, I think this test isn't needed because
>> "porcelain" wouldn't run into the bug we are checking for anyway.
>
> The only reason that the other bug was able to survive for so long was
> that we didn't have test coverage there. So I think it makes sense to
> explicitly test this, too, also because it causes us to walk a different
> code path.
>
> Last but not least: this test uncovered a segfault I had in a previous
> version. So I'd rather keep it :)

Ah, okay, both are fair. In that case, it probably makes sense to drop
the "--dry-run".
