Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D27C3DA7A
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 01:15:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236451AbjACBPr (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Jan 2023 20:15:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232362AbjACBPp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2023 20:15:45 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D342B1B8
        for <git@vger.kernel.org>; Mon,  2 Jan 2023 17:15:41 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d4so19775368wrw.6
        for <git@vger.kernel.org>; Mon, 02 Jan 2023 17:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nzAmPIp7NBZdeJaA0QGQ1hwRQmss+KctWEa+laUXYDs=;
        b=ltWnuV0rUK37Gn+PFnGJk+5qSkKALFGbSUgT6HhxT/qD4PqaR1CoAznv5nffioeebh
         rOde6ZmYTPym7Xt71Ai3biKEaeOY70/QjLSHAh4mU1HlepQi8+7NE5osUFhKPt3qJSTV
         3yOjni/pNe4/AdS7X/RwDFPfOXJz+5tgO2Pewjpw7s1c4bBPaCYbBu/4+kjzeBzgUOsV
         LIbJL2QWx8c9Ebv5lpDAxFwscKgTQOKdp6dqcGoanhi4YmD6zNkvdcqkIYk8WgxkDXqF
         mWekZ+ncxJSc/iHMkdWEONmPRzxz2OKoexHcSyOhDc331h3eZXFw6+LwxXyAtxnMsl5I
         3vjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nzAmPIp7NBZdeJaA0QGQ1hwRQmss+KctWEa+laUXYDs=;
        b=eauKaJrf2tbZPV0ShXOQnECsfOgpnDILJBqE1wUZ8NTVDZLRbwQ4qOMTjKgWbDAIVi
         yGorYuQ9cKTlVZqzqQnggzPh2GxbgxLDSrJUVfIz4W8LemhtrrJArtuDapSsn9moikM3
         1Ni22iEuhQwtAggaDmwJuyet8MDZr7npdBSapl55OU6+bcwNB9duX87yEfWgdYgut46N
         +XKka/Qg4QJA1SYgNHBl+5rPiB5Q1sMjLQtx/gvwx7KN//r/e8dKPBTRHjKoqfGt0wqH
         PWCko6Z6crWmDjjIddd23IL/SAoiXyck5nXmFYHwvlP2LvKNOvKLtw6PsDAzZzPWmkw0
         ZKpA==
X-Gm-Message-State: AFqh2koUlAut9eHFO4z+vEgsrdZuIw/ET/hzJX50bE023HeZH9YLKE2+
        58Cf3DAmDM2G1I27szWaTI4=
X-Google-Smtp-Source: AMrXdXuZqqN+IooIamP0Sh/Z0pFDcBWpHnAvjf9bRUecGs9KgwXYhHxRZ1uHgLR6k8X+A8MPdG73/g==
X-Received: by 2002:adf:e7d2:0:b0:242:12cd:d73b with SMTP id e18-20020adfe7d2000000b0024212cdd73bmr25041679wrn.33.1672708540258;
        Mon, 02 Jan 2023 17:15:40 -0800 (PST)
Received: from [192.168.2.52] (94.red-88-14-213.dynamicip.rima-tde.net. [88.14.213.94])
        by smtp.gmail.com with ESMTPSA id j10-20020adff54a000000b002420d51e581sm30097844wrp.67.2023.01.02.17.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 17:15:39 -0800 (PST)
Subject: Re: [PATCH 1/2] branch: description for orphan branch errors
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>,
        Derrick Stolee <derrickstolee@github.com>
References: <ffd675e9-8a64-ae05-fc3b-36ae99092735@gmail.com>
 <dd86016b-3232-563b-940e-03bc36af917a@gmail.com> <xmqqy1qmhq8k.fsf@gitster.g>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <18ca1e65-3e26-8352-cabd-daebdd0cf7f2@gmail.com>
Date:   Tue, 3 Jan 2023 02:15:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqy1qmhq8k.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 01-ene-2023 12:45:47, Junio C Hamano wrote:
> Rubén Justo <rjusto@gmail.com> writes:
> 
> Isn't branch_checked_out() a fairly heavyweight operation when you
> have multiple worktrees?  The original went to the filesystem
> (i.e. check ref_exists()) only after seeing that a condition that
> can be computed using only in-core data holds (i.e. the branch names
> are the same or we are doing a copy), which is an optimum order to
> avoid doing unnecessary work in most common cases, but I am not sure
> if the order the checks are done in the updated code optimizes for
> the common case.  If branch_checked_out() is more expensive than a
> call to ref_exists() for a single brnch, that would change the
> equation.  Calling such a heavyweight operation twice would make it
> even more expensive but that is a perfectly fine thing to do in the
> error codepath, inside the block that is entered after we noticed an
> error condition.

I share your concern, I thought about it.

My thoughts evaluating the change were more or less:

 - presumably there should be many more references than worktrees, and
   more repositories with 0 or 1 workdirs than more, so, arbitrarily,
   calling ref_exists() last still sounds sensible

 - strcmp() to branch_checked_out() introduces little change in the
   logic

 - I like branch_checked_out(), it expresses better what we want there

 - branch_checked_out() considers refs, strcmp considers branch names
   (we have a corner case with @{-1} pointing to HEAD, that this
   resolves)

 - finally, perhaps branch_checked_out() has optimization possibilities.
   Maybe in the common case we can get close to the amount of work we
   are doing now.  Here we can alleviate a bit by removing the
   unconditional resolve_refdup(HEAD) we are doing at the beginning of
   cmd_branch().

In the end, it seems to me that we have some places where we are
considering HEAD and we may need to consider HEADs.

And again, I agree, the change has somewhat profound implications.

> 
> > +test_expect_success 'error descriptions on orphan or unborn-yet branch' '
> > +	cat >expect <<-EOF &&
> > +	error: No commit on branch '\''orphan-branch'\'' yet.
> > +	EOF
> > ...
> > +'
> > +
> > +test_expect_success 'fatal descriptions on orphan or unborn-yet branch' '
> > +	cat >expect <<-EOF &&
> > +	fatal: No commit on branch '\''orphan-branch'\'' yet.
> > +	EOF
> > ...
> > +'
> 
> Do we already cover existing "No branch named" case the same way in
> this test script, so that it is OK for these new tests to cover only
> the "not yet" cases?  I am asking because if we have existing
> coverage, before and after the change to the C code in this patch,
> some of the existing tests would change the behaviour (i.e. they
> would have said "No branch named X" when somebody else created an
> unborn branch in a separate worktree, but now they would say "No
> commit on branch X yet"), but I see no such change in the test.  If
> we lack existing coverage, we probably should --- otherwise we would
> not notice when somebody breaks the command to say "No commit on
> branch X yet" when it should say "No such branch X".
> 

I think we do, bcfc82bd (branch: description for non-existent branch
errors).  We have some pending changes to follow the CodingGuideLines in
this messages that maybe we can resume:

https://lore.kernel.org/git/eb3c689e-efeb-4468-a10f-dd32bc0ee37b@gmail.com/



Thank you for reading the change this way.
