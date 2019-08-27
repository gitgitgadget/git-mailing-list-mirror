Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E46D31F461
	for <e@80x24.org>; Tue, 27 Aug 2019 01:34:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728447AbfH0Bey (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 21:34:54 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:46727 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbfH0Bey (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 21:34:54 -0400
Received: by mail-io1-f67.google.com with SMTP id x4so42189358iog.13
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 18:34:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Kybd4rxnpTkMl+c1OWEak+R5opDH93SKFvsapAVYlY=;
        b=VSFk86VDqClz4O5FPoc/Ue4ddUK0yTDGAw+Gif84hoLDoS0/IEDJR5i73lgkqG8UrJ
         xQZE4+oDh1gSC1lcSLLjIIuEgyMrIrO2i8z1PUV9OyDzCoL0A7i5VYALIIWdzEi5j91r
         AdpX3PJVvIcQwfwI4KTZioMlTEJcMnUTW2m3zBYBA3M8zHIT8PNofulvsh2UNRpr0IWH
         X+H1Gj0QYPudJ1ItbBNWO+ulcwzjcI28Rd2d83pWH6z1bZ/2Hxg7JKa3n7ZB9QfUYzof
         qLxmjaKOwCJ0C8XEAkso0WLCxtMoOFdlR+OfBp/72lcSKaqCw0vm+e1SQoCScRW2VlUu
         Q03Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Kybd4rxnpTkMl+c1OWEak+R5opDH93SKFvsapAVYlY=;
        b=TSCXj0rvM03l0uZtboEG7VMVHIbUb8MRFdo3I+fD86AuR5Dig9vAtJu1lndW/DrQmZ
         YnnjPugcK2tISWPo4ck4Uvv374MMtPZv0Avvlpt4Ati0tAlp6NXh2sWK5BdIKx5AqlxV
         GutWOGlHK4guf2JAL24clUES5on4M0YM3s8sQxFSMXqKhLAywYPXFE5PXBMyBAUOX8LL
         Pghi4pKzz/A58URBIcV0IEHZ11Rr7JHUL7eo3S/TcWtw/O9yEQyQFSif/OKiDDb0rzQ0
         YcSwuEXj2gBUPX+k2GkObcTqxy8ih2UQFOkA6FpESqrQ5F/4Rm1DkQOIFX6pAr+xTKh2
         IMGQ==
X-Gm-Message-State: APjAAAWpY+w0hlnHRqT3U/xR1rEWN8KldkcWwDJCh3ooiYwOsS/It/Tt
        Z6GNpELw6rg4hMRUjbZzxK6DSK7DQ0vwHjZ5MjA=
X-Google-Smtp-Source: APXvYqyCoJhDhkVV/bpo84wAomBgolt1W+lKJCmsDPN6/4VSHo6f0dyPPZa4ja3R+iti5EkYih5YvYLMGXYCFQU4uoA=
X-Received: by 2002:a05:6602:2413:: with SMTP id s19mr4587853ioa.161.1566869693427;
 Mon, 26 Aug 2019 18:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20190825182223.76288-1-carenas@gmail.com> <20190825182223.76288-2-carenas@gmail.com>
 <xmqq36hnhi4n.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36hnhi4n.fsf@gitster-ct.c.googlers.com>
From:   Carlo Arenas <carenas@gmail.com>
Date:   Mon, 26 Aug 2019 18:34:42 -0700
Message-ID: <CAPUEspjnwbC8L+9Ni_PN5kzROh3cqxEQRrhZHG_dhiR-K25OJA@mail.gmail.com>
Subject: Re: [PATCH 1/2] grep: make sure NO_LIBPCRE1_JIT disable JIT in PCRE1
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, cbailey32@bloomberg.net, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 11:54 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Carlo Marcelo Arenas Bel=C3=B3n  <carenas@gmail.com> writes:
>
> > e87de7cab4 ("grep: un-break building with PCRE < 8.32", 2017-05-25)
> > added a restriction for JIT support that is no longer needed after
> > pcre_jit_exec() calls were removed.
>
> I was initially puzzled by this statement, until I realized that the
> removal of pcre_jit_exec() happens in the topic still in flight that
> this patch builds on top of, namely 685668fa ("grep: stop using a
> custom JIT stack with PCRE v1", 2019-07-26).

sorry about that, I thought I had mentioned it in the cover letter
(since the hash is likely to change and so is not fit for a commit
message) but it is not there either.

how could this be tracked more effectively?

> So the logic is that because we do no longer call pcre_jit_exec()
> that weren't available between 8.20 and 8.32, these slightly older
> versions can now do JIT just like the ones post 8.32?

exactly; but also because it is no longer using the JIT fast path
which skipped UTF-8 validation, will need a way to disable that or
risk a regression as I mentioned in [1]

was planning in proposing a fix for PCRE1 based on [2] but wasn't sure
if it could be part of this series, an independent one that is also
based on ab/pcre-jit-fixes, and like this one, is mostly a consequence
of 685668fa ("grep: stop using a custom JIT stack with PCRE v1",
2019-07-26) or something else, specially considering that =C3=86var
dismissed it as a non issue in his commit message.

Carlo

[1] https://public-inbox.org/git/CAPUEspj4BJLjXorUXMiZnFtNcmhym_2QL5GUqeaGa=
Coxk=3Dzjtw@mail.gmail.com/T/#m6acc8f68c398951457da469530bafa7e18811366
[2] https://public-inbox.org/git/20190721183115.14985-1-carenas@gmail.com/
