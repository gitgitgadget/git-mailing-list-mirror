Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B321C54FD0
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:01:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43C4220728
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 17:01:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPGETAqF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726226AbgD0RBU (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 13:01:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726030AbgD0RBU (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Apr 2020 13:01:20 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0888EC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 10:01:20 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id i16so9830335ybq.9
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 10:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=2Fr8wptJt6bUlSXxGzvaWZTN80Z//a9ygLtc14qih4A=;
        b=kPGETAqFFLu+XZWjuMOuG2acaj/QTb1IsV2YiQs5d5t9wnq8o6hzGECPQZTJutJmWS
         anh93bjMKFWdCJrtMLu/5CATcknYY/a4ezVym/JGUu7rty/nYoxYeVfSabFtvLb9EAQW
         SxDH5dr6T5Hl3Cq/393Jwl4JjnHNHH9kFw8NTds/u8cY1sbFxaigfE5TxwegulfQzvOd
         ALS3ZUl2puLEGwW4fUn8ZI4NwS3KJc9/UrhWUm56s5ew+CO9VcMrCsQEnIjQ8pLWtOdC
         ynMWCec9zJnUhN7/RhAGyHEfli1JKe6UaCDYCOzguqNPx9ade1ZzHY3nrpH2LSnFa70i
         OgXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=2Fr8wptJt6bUlSXxGzvaWZTN80Z//a9ygLtc14qih4A=;
        b=XlT5eVB9nzf3ar7AocTrFBHTU1UDYwNvDRK+hXwTu5fg8PiX5ORYtQpOQfUIYUhDPH
         ks3yVDgLhZLxuSBsLzNhZq5/3eGAqTkGbDKGxNveVNwPDKqoWIF3PAFbyeLY5vv2j+sP
         jYebBqI/dOL0McCukpyjbOSDmKiUaPNaAGiw3K/0k/5drY3RtKuk9HwZZGDxRGSGPDRu
         MlekHSAN8vc+wGcaM2cXvemBlDn/CcxmiluAKdx6HOR1ypHuBMmUWFelU4MfJv1iILiZ
         YhuoTc63Mejc/xLVeKHEW34KqbuKjZt2jidZ/yJIY0CGKPvzolU/9d3y7UG9AfGorvtt
         TifQ==
X-Gm-Message-State: AGi0Pub6B9pnRHXE/RehHyslyenZSZcDBRJCNhvFSgSTi/F8FYopK+e5
        5L2PONXibQAGVz5lrjBweaiNsshtphb2VhZ/SKQ=
X-Google-Smtp-Source: APiQypJwLhT8XSjciuYCqFr/h3/SwoHKGrWVZIpTAjdi5FhwhuWoVHGbDeuKKECnSfiYGnWK8Xih8Ze+53cgVyiFRy4=
X-Received: by 2002:a25:6f86:: with SMTP id k128mr37840457ybc.520.1588006878907;
 Mon, 27 Apr 2020 10:01:18 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq3697cax0.fsf@gitster.c.googlers.com> <20200414123257.27449-4-worldhello.net@gmail.com>
 <xmqqo8rs7ntb.fsf@gitster.c.googlers.com> <CANYiYbE84Jj46m0ZTfAepc7t4v4KcqU9R99WGY9b7cdTXBfw_g@mail.gmail.com>
 <xmqqzhbc61jv.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqzhbc61jv.fsf@gitster.c.googlers.com>
From:   Jiang Xin <worldhello.net@gmail.com>
Date:   Tue, 28 Apr 2020 01:00:00 +0800
Message-ID: <CANYiYbGNTMpdvW7AGs-drOuwhzcR_CJnsCE9TjAWujZtb3cfEg@mail.gmail.com>
Subject: Re: [PATCH v12 3/7] receive-pack: add new proc-receive hook
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Cc:     Git List <git@vger.kernel.org>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2020=E5=B9=B44=E6=9C=8816=E6=97=
=A5=E5=91=A8=E5=9B=9B =E4=B8=8A=E5=8D=882:34=E5=86=99=E9=81=93=EF=BC=9A
>
> Jiang Xin <worldhello.net@gmail.com> writes:
>
> > Will correct it.
> >
> > What I am working on for reroll v13:
> >
> > * Add new commit "receive-pack: feed extended_status to post-receive=E2=
=80=9C
> >
> >    When commands are fed to the "post-receive" hook, `extended_status` =
will
> >    be parsed and the real old-oid, new-oid, reference name will feed to
> >    the "post-receive" hook.
> >
> > * Add test cases for "git push --porcelain".
> >
> >    I found some changes not covered by test.  So I decide add some
> >    test cases for "git push --porcelain".  I will split the test cases =
into
> >    multiple files inside "t5411/" like:
> >
> >        t5411/test-0000-normal-push.sh
> >        t5411/test-0001-normal-push--porcelain.sh
> >
> > * Other minor fixes.
>
> Thanks for a heads-up, but given that nobody seems to be reading
> your patches and commenting on them, you might want to slow down a
> bit.

For over a week, I have not received more comments on reroll v13 on
this topic ("jx/proc-receive-hook"). Therefore, I invite Peff and
Couder to review because I think it would be very interesting to add a
centralized workflow to Github and Gitlab.

 * [PATCH v13 3/8]:
https://public-inbox.org/git/20200418160334.15631-4-worldhello.net@gmail.co=
m/

This patch introduces a new hook "proc-receive" on the server side. It
won't break anything except GitHub's "spokes" architecture (I guess).
Because in Alibaba, we have such issue when we implement our own
"spokes" architecture.  In order to make this special push operation
(on a special ref such as "refs/for/master/topic") idempotently on
multiple replicas, we extended the protocol of "receive-pack" and let
"spokes" to send a request with a flag, which specifies one replica as
master replica to execute the "proc-receive" hook.

* [PATCH v13 4/8]:
https://public-inbox.org/git/20200418160334.15631-5-worldhello.net@gmail.co=
m/
* [PATCH v13 5/8]:
https://public-inbox.org/git/20200418160334.15631-6-worldhello.net@gmail.co=
m/

Patch 4/8 and patch 5/8 extends status report for both server and
client sides. The extension is backward compatible. When user push
like this:

    git push origin HEAD:refs/for/master/topic

Old version of git may report like:

    To <URL/of/upstream.git>
     * [new reference] HEAD -> refs/for/master/topic

But new version of git may report like:

    To <URL/of/upstream.git>
     + <OID-B>...<OID-A> HEAD -> refs/pull/123/head (forced update)


As for how to use this "proc-receive" hook to implement a centralized
git workflow, please refer to my blog as a reference:

* https://git-repo.info/en/2020/03/agit-flow-and-git-repo/

--
Jiang Xin
