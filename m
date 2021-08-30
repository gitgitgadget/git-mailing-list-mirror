Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA734C432BE
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:08:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ACE2560F3A
	for <git@archiver.kernel.org>; Mon, 30 Aug 2021 14:08:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236955AbhH3OJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Aug 2021 10:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236965AbhH3OJR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Aug 2021 10:09:17 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 489BFC061575
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:08:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id q17so21876044edv.2
        for <git@vger.kernel.org>; Mon, 30 Aug 2021 07:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=TENirvnUqZzAE55hVzJ33rEKqG7QRvsXurhYstB32Bk=;
        b=QsIGwCYriZUtVR2/2qnKlK9l4ha2T4gNW+qVBQb1Wx46tyPt1EiKIEUT0TfvEij0su
         FQmwD+dXV+4qvAJ6sIfK9kyRjJVaoYQRTOTDs2Q8Rix5TLXlhVNaDOdEsD59Z7RK8WFj
         hyYu3RO66YUHPnF2rPVVnU7NBlTogJOGrzjXG+yWf0slPIdKw+TJFVr7N+qp9tpdEt12
         3A7zfRpQK7FhGm1VwljF7FITNVl9KyIj/0SrpG1Plq+bTdvE5ewYk7+Jinaiq13fBkK5
         UdK97YAtdAQKJfmPXQY933HYgd4sokO8TIZvURsPWH5PT/mbvpYN5UO5MUbD32CnLnqz
         /eDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=TENirvnUqZzAE55hVzJ33rEKqG7QRvsXurhYstB32Bk=;
        b=RoHNlKd/0T9ZflIvl22yBRCWmKEyn3RMkCDB67QOHy/a1PA35VyN6/MMfaDUEwwmAy
         DrXnUA5LOI5pb9AytY/nMEYn0fj3yFihswmzBqWbF9ppbFIhM8wPcIfRj4qxKd/msh78
         2WU79Oj/d91gy4tgqthfdFHPZwzug63UOsKAZ0X/sfMYSpl+qWxBaZlB1243ox8k66ik
         rPXGemfQAz7A/pYdOb/vrMyUSXmaqDEYYQ2y8sPOI9OoageuVSeYlsqQl39qdX+okYyp
         cVR23V6qafXtjbd3YcDm9iOxOggaP9UFpzD0KhAgxEXz3rJZ9Kmkj0KsEJYX81vy3PVn
         8JZw==
X-Gm-Message-State: AOAM533n1Wa2NtBylmpaBVIYTSp9EPEgp4c6toNkwn8d0I+eG7jjF7kL
        4RTOGyXvOIhL+NIpykkipLE=
X-Google-Smtp-Source: ABdhPJyNArUBj8a78TMoWpD+CwM5O0GCnrmhmJw9I/XnaQtXL211Nu9A7LdHwfLBs7fpe5gcWfTxeQ==
X-Received: by 2002:a50:c043:: with SMTP id u3mr10989738edd.207.1630332501820;
        Mon, 30 Aug 2021 07:08:21 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id cf11sm7697920edb.65.2021.08.30.07.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Aug 2021 07:08:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: Re: [PATCH v4 27/28] reftable: fixup for new base topic 2/3
Date:   Mon, 30 Aug 2021 16:03:42 +0200
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com>
 <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
 <patch-v4-27.28-c4f9fb42d9e-20210823T120208Z-avarab@gmail.com>
 <CAFQ2z_MnJr58Cu970Be7SXE1jFkgOGThQ0Geq2+kNihJE3_BvQ@mail.gmail.com>
 <87r1ebxe2y.fsf@evledraar.gmail.com>
 <CAFQ2z_Pa1fG935rQBQPijE=YHatsHbsLd_f8dT7Zh-grdgwbjg@mail.gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <CAFQ2z_Pa1fG935rQBQPijE=YHatsHbsLd_f8dT7Zh-grdgwbjg@mail.gmail.com>
Message-ID: <87lf4jxbxn.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Aug 30 2021, Han-Wen Nienhuys wrote:

> On Mon, Aug 30, 2021 at 3:22 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:
>> But we will need at least the optimistic locking of code like
>> builtin/reflog.c wanting to do an expiry, and deciding whether to do
>> that expiry based on a given state of the ref/reflog. I.e. we don't
>> want:
>>
>>     1. Start reflog expiry
>>     2. Code in builtin/reflog.c looks up the OID
>>     3. Code in builtin/reflog.c decides whether expire the reflog
>>     4. Concurrent with #4, another writer updates the ref/reflog pair
>>     5. Code in builtin/reflog.c says "OK, expire it!"
>>     6. Reftable queues a delete/prune of the reflog per #5.
>>
>> This would be a sequente of updates to the ref/reflog, none of whom were
>> racy as far as the reftable semantics itself are concerneb, but where
>> we'd do the wrong thing because the writer thought we had A when we
>> really had B. So we need the equivalent of an "git update-ref" with the
>> "<oldvalue>".
>>
>> Is there a better way to do that in this case that I'm missing?
>
> I spent some more time looking at builtin/reflog.c, but I am still not
> 100% sure what the locking is used for.
>
> From a quick glance, the OID goes into tip_commit, and tip_commit goes
> into a reachable list (?). The reachable list is then for something,
> but I can't really tell what.
>
> In your example with 1.-6., it's still not clear to me what the
> undesired behavior is precisely. If the reflog is pruned in #6, is the
> worry that the update in #4 is pruned immediately after being
> effected?

Yes, I think so. But I'm not sure. I skimmed the code quickly today, and
when I wrote the referenced series didn't focus much on the nitty-gritty
of the builtin/reflog.c behavior other than assuring myself that I was
doing the exact same thing as before as far as its logic was concerned.

I.e. it always locked at a given OID. Before my in-flight "reflog
expire: don't lock reflogs using previously seen OI" it might not lock
but get this error:

    error: cannot lock ref '<refname>': ref '<refname>' is at <OID-A> but e=
xpected <OID-B>

But at least it wouldn't do anything, but the current code does require
the passed-in OID. See the code that needs "unreachable_expire_kind" and
"tip_commit".

Perhaps that whole thing can also be refactored somehow. If I change the
"commit =3D lookup_commit(the_repository, oid);" in
"reflog_expiry_prepare()" to just "commit =3D NULL" all tests pass, but
that might just be missing test coverage in the face of same race...
