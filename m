Return-Path: <SRS0=Q4JT=33=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C67AC2BA83
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 19:29:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C6B021775
	for <git@archiver.kernel.org>; Fri,  7 Feb 2020 19:29:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgBGT30 convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 7 Feb 2020 14:29:26 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:34447 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbgBGT30 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Feb 2020 14:29:26 -0500
Received: by mail-wm1-f68.google.com with SMTP id s144so3805023wme.1
        for <git@vger.kernel.org>; Fri, 07 Feb 2020 11:29:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zBXL/CBx2LmBAPB+amQRZDiln8ptxpzSQ85FWAIKa5Y=;
        b=W4iZ27h/JekLB+hQc88ZPFtfiB47arv+LvZIywH6f16piG0ImccPyjJbgOfG5WgJp+
         wfTj0byPKMdiMiMeYXNE8JtvX4TYH6xUwnmHQ9A4/NMuX77DewjG3wgq2wkuu0cwZ+5l
         cTTL6BvAoUcQQL7MS+2RBNCg2NK3O6cdzwXGEotgRAephHkDPVJUoLEGjdwy9JxRqMbL
         FmHyMuKQ0dvQMpVG3P3Ix8XdCcPwBxsAS+sY1EYmf9yxE94jzro9fu3ircA/K15+mLX2
         k7Bxr830BhUJFHF6XjX31o+KsiT48DRS4ynwt0Lifru0zNIlBqhNUVaEl1oZ1xWJAqlO
         k/3w==
X-Gm-Message-State: APjAAAWkDzO7yCL1QvkZfftbbNnrAe3Hm5lCrJsQtcOPpQwk7hqLq1WB
        7SxMIOpedLTdnWfgos8TOPtN4vt8udZPlwsB6MA=
X-Google-Smtp-Source: APXvYqxAz0qlZhlWERBmLK1AAuQbpbI0A2qTcfJ813ZzKsgVn/moz/HMT8liVGLGr5GAv2jViTuXmEAJ8GHoxEQByHs=
X-Received: by 2002:a1c:9dcb:: with SMTP id g194mr5700035wme.53.1581103762636;
 Fri, 07 Feb 2020 11:29:22 -0800 (PST)
MIME-Version: 1.0
References: <CAJ+F1CKW3NACgPdPbmAzYGVwR4iO3r+LCNq+g5st0gcz4X+fzA@mail.gmail.com>
 <CAPig+cRCMXjjPHc2O8fLmaSm9m-ZO3qR2BoZwG3s5dLHNbiFFQ@mail.gmail.com>
 <20200112121402.GH32750@szeder.dev> <CAPig+cRvYzm8Cb-AWqOeANRziWyjhWXT32QJ6TsA1==8Joa4zQ@mail.gmail.com>
 <20200124224113.GJ6837@szeder.dev> <CAJ+F1CL7RD2Rxaskk47f_UCQLP6yaM_woxTb1pag-ejqP9prBg@mail.gmail.com>
 <20200131155228.GF10482@szeder.dev> <CAJ+F1CLtDET6L-CGo=j0Yj0aPVSbec=57MPgaGrhr3L8dpCSSQ@mail.gmail.com>
 <20200131161630.GG10482@szeder.dev> <CAJ+F1CJaszsOMeuUmk5MKXpjkX1gHNuK6xyf_mmHtnToL2Y_7A@mail.gmail.com>
 <20200207100247.GA1111@szeder.dev> <CAJ+F1CJc4kEvxLr-wLXpvXOC8YRVf5xP1HuJh9-cYa6mGmbyXg@mail.gmail.com>
 <xmqq1rr6444s.fsf@gitster-ct.c.googlers.com> <CAJ+F1C+qGo=6QrRw2299Apr2+-CHNWQyzWjvWbXJN5KC+T63AQ@mail.gmail.com>
 <xmqqwo8y2ovu.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqwo8y2ovu.fsf@gitster-ct.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Fri, 7 Feb 2020 14:29:11 -0500
Message-ID: <CAPig+cTWxj+dRiYZEEbfUA7=NiEF3crTaYCVGPR2qG-VEV+Y0w@mail.gmail.com>
Subject: Re: [PATCH] branch: let '--edit-description' default to rebased
 branch during rebase
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 7, 2020 at 2:12 PM Junio C Hamano <gitster@pobox.com> wrote:
> Marc-André Lureau <marcandre.lureau@gmail.com> writes:
> > Then --edit-description during won't default to the branch you started
> > from the bisect. So we are back to my original proposal only, having
> > branch default during rebase. Eric, do you mind?

I don't feel strongly one way or the other.

> > > How about teaching "git branch --edit-description [HEAD]" notice
> > > when/if HEAD is detached and always error out, no matter what
> > > operation is in progress?
>
> What I meant by "no matter what is in progress" is not to special
> case "during rebase", either.

That would defeat the original purpose[1] of this submission, I think.
As I understand it, the idea all along was to make this operation work
during a rebase.

[1]: https://lore.kernel.org/git/20200110071929.119000-1-marcandre.lureau@redhat.com/
