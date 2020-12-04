Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B802C433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 02:55:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D7E002251D
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 02:55:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgLDCzI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 21:55:08 -0500
Received: from mail-ed1-f54.google.com ([209.85.208.54]:35690 "EHLO
        mail-ed1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgLDCzG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 21:55:06 -0500
Received: by mail-ed1-f54.google.com with SMTP id u19so4339019edx.2
        for <git@vger.kernel.org>; Thu, 03 Dec 2020 18:54:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=r7zlVpshSHGJK/08vlGnyU0jw8m3cAr+K4kpEDV3FhM=;
        b=l7YcncmQO2FZHWmo53BFmzVg4opvJdy/EQCJYxbJKVg9AV6Vi3robA34RDF9QV31b3
         kcylWxivKYOy4OXXWXPeO7Cw9m86BzGva0pnmtqGOzPTaeCd1djRzAO0I/MMx6JOdG1M
         /M1ZtjHT2W+9vH2XOgbB5J/fqmkm2xhah/fB0b2oluNdxtT+8w9Tfe50NiWzD+2wGMCb
         G099vxRUDYnOeklNrwwbBdnJYbgqXl3wBKiH9IDy9eql0mcItaue3ZvGxT9WuyGDThyH
         iiT+AyYVsQSnIJOuhrqi63LovZw119niN+RN+jtq4Lc7ey6WY0t2KvbwhqunNCxGVXRS
         OVSQ==
X-Gm-Message-State: AOAM531Je57EFfUkXXnDCw62g5ILedpg++vHHuNG7a5H4T9bKh+ejZ1S
        p/mGDot6fuqjYkVnRDT3IpgKsnTAWxGTOLHxiTB+1zG+pgM=
X-Google-Smtp-Source: ABdhPJx/fLW0dB+nwEv6Kb0O3QQSJacYcuKZXENp0cxor9NP+pymL0oi3rXT6W9Kjh8/rO1vYPgZH7I0x4ZBHZZ0CLw=
X-Received: by 2002:a50:ab51:: with SMTP id t17mr5653683edc.89.1607050464624;
 Thu, 03 Dec 2020 18:54:24 -0800 (PST)
MIME-Version: 1.0
References: <147444de-7653-d067-596a-9448ae6b8cac@heath.cc>
In-Reply-To: <147444de-7653-d067-596a-9448ae6b8cac@heath.cc>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Thu, 3 Dec 2020 21:54:13 -0500
Message-ID: <CAPig+cT-Tf2ray+j9b45vz-qoiSZ4MkTyGVDr6PRJCXsvbx0=Q@mail.gmail.com>
Subject: Re: Bug: git log -L manpage claims regexes are supported, but they
 are not
To:     Daniel <daniel@heath.cc>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 3, 2020 at 9:50 PM Daniel <daniel@heath.cc> wrote:
>    $ git log -L ^/bootstrap-sass/,+2 Gemfile
> fatal: -L argument not 'start,end:file' or ':funcname:file':
> ^/bootstrap-sass/,+2
>
> $ git help log
>         -L <start>,<end>:<file>, -L :<funcname>:<file>

You're missing the colon between <end> and <file> in your example. It should be:

    $ git log -L ^/bootstrap-sass/,+2:Gemfile
