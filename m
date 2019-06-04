Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9EFB81F462
	for <e@80x24.org>; Tue,  4 Jun 2019 22:48:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726603AbfFDWsk (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Jun 2019 18:48:40 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:40851 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbfFDWsk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jun 2019 18:48:40 -0400
Received: by mail-vs1-f67.google.com with SMTP id c24so14596935vsp.7
        for <git@vger.kernel.org>; Tue, 04 Jun 2019 15:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6i02A60t1KX+rNXDRwFW/z6ctOOLGFauz16eRCO4hxk=;
        b=TxFb1Vb3vDtC5vFrR1QtkTuAFNjhX6b644mi8SdHUyqeMQZCTEhmh9d0j9sm8P0vyn
         bsC4z3M+1o4FM9tOroRMOqOiElgIOjlFmCu7m6fYSg1ItsJZmn9v8NCJslZ2ypc0uVKz
         SBsMAO2/JdrHFLvEys1GqcNciyq+mSt9ug0O0eVddzvPEAsxj2/atjw5wR5HjQl5sDIw
         dV0nSglN4ERmYaVXOE3YIk8yvemyvkuUsF0CnyBdORh15k1dBgn8hDNMUiqNyyem86Mb
         Q/fKvqFQw/Ov6lKKYXpDi/w1Kf6occ8PDdstkT3FF19KZhn/vnPT0u3n9eux6NjNc3fS
         vxFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6i02A60t1KX+rNXDRwFW/z6ctOOLGFauz16eRCO4hxk=;
        b=AXIF1NdECTrf+n0StL6QnFuvxLppGnVMXH0wkUsXGOY0itmwNGUQ7umQU0ysqM4WTK
         B0RtFbLQxtQn5OSZloXmD+KZP/ZotAyB4vzi7pK4sX8qZgDN0HMAE0suwwU2h9/7h57v
         tBkRaYABoK+uNcgtDdmH3GNAeUxgEDvWKKGJsPGTRbGaTkuEuws+qfNtt4HTWEDpfwDS
         A5YLWCxhj+cn0xbOSa88tHH5GZpWZLeqTrRMunQYLWeNkgyFvNLMjTyfRulk2+eaDXhC
         zMQDGEKK6LZLJRmtQpkzInQBVkcNb1r0waQyzA7rIwYa+goGeVJ4ZNC6GZ0i2flHV3rm
         xAxQ==
X-Gm-Message-State: APjAAAV1JgcDKOQV5dD+8Y9a9NhiVPA/JI+1FtVZwkCQXqFIUTiDsgmk
        7wPkAsUZYkRcS2SVxehAXaCVFnpT+BZn45MV6IQ=
X-Google-Smtp-Source: APXvYqwvnXd+6Ixxa6Dg6z1TzKQQNhtgYcJAyfwykrtlphZ+NDxQVT7unuguyhJNdw2M1BjdG1/T4WMTxU70sbRERBk=
X-Received: by 2002:a67:8081:: with SMTP id b123mr9913239vsd.117.1559688518774;
 Tue, 04 Jun 2019 15:48:38 -0700 (PDT)
MIME-Version: 1.0
References: <20190604072614.26885-1-newren@gmail.com> <20190604202750.3925-1-newren@gmail.com>
 <20190604210754.GT951@szeder.dev>
In-Reply-To: <20190604210754.GT951@szeder.dev>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 4 Jun 2019 15:48:26 -0700
Message-ID: <CABPp-BFjAfpzDtgN3m9YAgcS+97TUvfZPzpOo3s9Kpn8yuDQ1A@mail.gmail.com>
Subject: Re: [PATCH v2] merge-recursive: restore accidentally dropped setting
 of path
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>,
        ben.humphreys@atlassian.com,
        Ben Humphreys <behumphreys@atlassian.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 4, 2019 at 2:07 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wro=
te:
>
> On Tue, Jun 04, 2019 at 01:27:50PM -0700, Elijah Newren wrote:
> > Changes since v1:
> >   * Minor tweaks suggested by SZEDER
>
> > diff --git a/t/t6042-merge-rename-corner-cases.sh b/t/t6042-merge-renam=
e-corner-cases.sh
> > index 09dfa8bd92..3fe2cd91dc 100755
> > --- a/t/t6042-merge-rename-corner-cases.sh
> > +++ b/t/t6042-merge-rename-corner-cases.sh
> > @@ -411,6 +411,124 @@ test_expect_success 'disappearing dir in rename/d=
irectory conflict handled' '
> >       )
> >  '
> >
> > +# Test for basic rename/add-dest conflict, with rename needing content=
 merge:
> > +#   Commit O: a
> > +#   Commit A: rename a->b, modifying b too
> > +#   Commit B: modify a, add different b
> > +
> > +test_expect_success 'setup rename-with-content-merge vs. add' '
> > +     test_create_repo rename-with-content-merge-and-add &&
> > +     (
> > +             cd rename-with-content-merge-and-add &&
> > +
> > +             test_seq 1 5 >a &&
> > +             git add a &&
> > +             git commit -m O &&
> > +             git tag O &&
> > +
> > +             git checkout -b A O &&
> > +             git mv a b &&
> > +             test_seq 0 5 >b &&
> > +             git add b &&
> > +             git commit -m A &&
> > +
> > +             git checkout -b B O &&
> > +             echo 6 >>a &&
> > +             echo hello world >b &&
> > +             git add a b &&
> > +             git commit -m B
> > +     )
> > +'
> > +
> > +test_expect_success 'handle rename-with-content-merge vs. add' '
> > +     (
> > +             cd rename-with-content-merge-and-add &&
> > +
> > +             git checkout A^0 &&
> > +
> > +             test_must_fail git merge -s recursive B^0 >out &&
> > +             test_i18ngrep "CONFLICT (rename/add)" out &&
> > +
> > +             git ls-files -s >out &&
> > +             test_line_count =3D 2 out &&
> > +             git ls-files -u >out &&
> > +             test_line_count =3D 2 out &&
> > +             # Also, make sure both unmerged entries are for "b"
> > +             git ls-files -u b >out &&
> > +             test_line_count =3D 2 out &&
> > +             git ls-files -o >out &&
> > +             test_line_count =3D 1 out &&
> > +
> > +             test_path_is_missing a &&
> > +             test_path_is_file b &&
> > +
> > +             test_seq 0 6 >tmp &&
> > +             git hash-object tmp >expect &&
> > +             git rev-parse B:b >>expect &&
> > +             git rev-parse >actual  \
> > +                     :2:b    :3:b   &&
> > +             test_cmp expect actual &&
> > +
> > +             # Test that the two-way merge in b is as expected
> > +             git cat-file -p :2:b >>ours &&
> > +             git cat-file -p :3:b >>theirs &&
> > +             >empty &&
> > +             test_must_fail git merge-file \
> > +                     -L "HEAD" \
> > +                     -L "" \
> > +                     -L "B^0" \
> > +                     ours empty theirs &&
> > +             test_cmp ours b
>
> This one is OK.
>
> > +     )
> > +'
> > +
> > +test_expect_success 'handle rename-with-content-merge vs. add, merge o=
ther way' '
> > +     (
> > +             cd rename-with-content-merge-and-add &&
> > +
> > +             git reset --hard &&
> > +             git clean -fdx &&
> > +
> > +             git checkout B^0 &&
> > +
> > +             test_must_fail git merge -s recursive A^0 >out &&
> > +             test_i18ngrep "CONFLICT (rename/add)" out &&
> > +
> > +             git ls-files -s >out &&
> > +             test_line_count =3D 2 out &&
> > +             git ls-files -u >out &&
> > +             test_line_count =3D 2 out &&
> > +             # Also, make sure both unmerged entries are for "b"
> > +             git ls-files -u b >out &&
> > +             test_line_count =3D 2 out &&
> > +             git ls-files -o >out &&
> > +             test_line_count =3D 1 out &&
> > +
> > +             test_path_is_missing a &&
> > +             test_path_is_file b &&
> > +
> > +             test_seq 0 6 >tmp &&
> > +             git rev-parse B:b >expect &&
> > +             git hash-object tmp >>expect &&
> > +             git rev-parse >actual  \
> > +                     :2:b    :3:b   &&
> > +             test_cmp expect actual &&
> > +
> > +             # Test that the two-way merge in b is as expected
> > +             git cat-file -p :2:b >>ours &&
> > +             git cat-file -p :3:b >>theirs &&
> > +             >empty &&
> > +             test_must_fail git merge-file \
> > +                     -L "HEAD" \
> > +                     -L "" \
> > +                     -L "A^0" \
> > +                     ours empty theirs &&
> > +             git hash-object b >actual &&
> > +             git hash-object ours >expect &&
> > +             test_cmp ours b
>
> Here, however, you only changed what test_cmp looks at, but still kept
> the two 'git hash-object' invocations, and their output will never be
> looked at.

Whoops, indeed.

Junio: it looks like you've already deleted the two lines in your pu
pushout with your 'SQUASH???' commit at the tip of
en/merge-directory-renames-fix; that's the exact same change I would
make.  Would you like me to resend this patch with the two lines
removed, or do you just want to squash in your commit that does the
same?

Thanks,
Elijah
