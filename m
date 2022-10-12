Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9BEAC4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 16:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiJLQ4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 12:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiJLQ4t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 12:56:49 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D69FE752
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 09:56:47 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id j12-20020a63594c000000b004468ff8fc78so9595150pgm.10
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LGkMBLFYZoGxy35+PA6EYNmWGWQmISyDgaW7TcS5hgk=;
        b=rZdDy9PCjjEQcQ8K8hrdwAG3aCs9IG8Y6nYFYYinZmzcJd/KrHP/Er1HqeEP9gwE9K
         IpqwKhiHDpGJyzZGTEBr4KcTIhkSa9f3OO+Fx2qUIuD491moExP0aI0w+MGodhaYUYOL
         vhRaNF9lCmlDt/a8fpHn7/6A9O2FkqwGDuS9oxVhdgf1C3Qbukr84o222xytrtjSKlFP
         A2KnfwHJSUuQ50zN6m30vJDVbDVyNEPW3k7MHbDlIDa2be0MvpYTpXm4jxtq27iskcRG
         Eb5RovJHH+VJZDbhCI9TCYpkL9Q3FQgEynKJAFO1T7T67H4zdrDL2NZ33PPmQq30xiRo
         Payw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGkMBLFYZoGxy35+PA6EYNmWGWQmISyDgaW7TcS5hgk=;
        b=VqAPdJa8mAb1/gJEN4ylIyM2CIYu1nXnVYXCDef/ZDiXGEr29G6XCkL+fCN4JhVJ3S
         m8hxJF0e2kmmwQrIODE5HlVrExiM8iCOHvr217jb0blV64GG9i1aUsTG2EDWAZrHHP6T
         m5x/UFpnWZMF5C+CZzxe7DVXOkRoaKZ++SpURFnkLtC7bWqSWkOyfCHkXRcXBwyllkR6
         aADdVEfhN/nFp/P1t6AU4x8kN31a9uz9/+VUvJYwbuzE5ZxLngBjh5grkB82IWdEbsfs
         exqqQWNy49JdJV96tqKyXyR3C2rjkIbq3m1e78Lqn+QlyFTLNPPxDRPDPk/hVIba4VHo
         n+CQ==
X-Gm-Message-State: ACrzQf1PIidKCUQIkZHDY+mpgCatIWNI9b97m+pdpYoZWrNYmguHg0Rv
        1uLW722EsCqVVF4UPtGZwmyMwT9UIkgHMQ==
X-Google-Smtp-Source: AMsMyM7Pd5KWteomypgpX7w9QLdSRelS7jjNleVi0wT9cGqYYRVVkULBGfWDhwb5VUIWR4ENIpcBBDTe+EtTFQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:7290:b0:17f:d04b:bf57 with SMTP
 id d16-20020a170902729000b0017fd04bbf57mr29254549pll.147.1665593806983; Wed,
 12 Oct 2022 09:56:46 -0700 (PDT)
Date:   Wed, 12 Oct 2022 09:56:45 -0700
In-Reply-To: <20221011182119-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
References: <20221007060713-mutt-send-email-mst@kernel.org>
 <221007.86wn9bq458.gmgdl@evledraar.gmail.com> <20221007085334-mutt-send-email-mst@kernel.org>
 <kl6lpmf3wdk6.fsf@chooglen-macbookpro.roam.corp.google.com>
 <xmqq35bze3rr.fsf@gitster.g> <20221011182119-mutt-send-email-mst@kernel.org>
Message-ID: <kl6lfsft0ylu.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: sudmodule.<name>.recurse ignored
From:   Glen Choo <chooglen@google.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Michael S. Tsirkin" <mst@redhat.com> writes:

> Fundamentally the problem we encounter regularly is this:
> 	qemu is superproject, ui/keycodemapdb is subproject.
>
>
> 	I have a change on master setting the submodule commit:
>
> 	qemu$ git show master | grep +Sub
> 	+Subproject commit 7381b9bfadd31c4c9e9a10b5bb5032f9189d4352
>
> 	and check it out:
>
> 	qemu$ git submodule update --init ui/keycodemapdb
> 	Submodule 'ui/keycodemapdb' (https://gitlab.com/qemu-project/keycodemapdb.git) registered for path 'ui/keycodemapdb'
> 	Submodule path 'ui/keycodemapdb': checked out '7381b9bfadd31c4c9e9a10b5bb5032f9189d4352'
>
>
> 	In another branch I have a different commit:
>
> 	qemu$ git show sub-foo  | grep +Sub
> 	+Subproject commit 57ba70da5312170883a3d622cd2aa3fd0e2ec7ae
>
>
> 	Now I switch branches and nothing happens, the submodule
> 	is marked as dirty:
>
> 	qemu$ git checkout sub-foo
> 	M       ui/keycodemapdb
> 	Switched to branch 'sub-foo'
>
> 	qemu$ (cd ui/keycodemapdb && git show | head -1)
> 	commit 7381b9bfadd31c4c9e9a10b5bb5032f9189d4352
>
>
> it is now very easy to generate incorrect code:
> - git commit -a  will commit the change to submodule
> - any build will use a mix of super and subproject that
>   is completely untested
>
>
> As a result people are basically saying avoid using submodules
> but I am wondering whether git can be tweaked to do the
> right thing by default.
>

It sounds like you want submodule.recurse [1] :) With that enabled, your
"git checkout" should behave like "git checkout --recurse-submodules",
which should make ui/keycodemapdb check out the correct commit as long
as the submodule commit is present locally. If is is _not_ present
locally, you will have to run "git submodule update".

Unfortunately, you typically won't know whether the commit is present
before running the command. This is yet another of those things that are
painful with submodules.

[1] https://git-scm.com/docs/git-config#Documentation/git-config.txt-submodulerecurse

> I understand we can work around it by asking everyone to
> create a correct config, but can't we make it DTRT by default
> to reduce friction?

You might be interested in the proposed 'new' Submodule UX [2]; one of
the goals is to make manual submodule management via "git submodule"
unnecessary.

As a part of that, you should be able to set "submodule.recurse = true"
and have high confidence that all necessary submodules and submodule
commits are present. Work on that is still ongoing, but this situation
should have improved as of [3].

[2] https://lore.kernel.org/git/YHofmWcIAidkvJiD@google.com/
[3] https://lore.kernel.org/git/20220308001433.94995-1-chooglen@google.com/

>
>
> -- 
> MST
