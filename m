Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 53FA3209FD
	for <e@80x24.org>; Tue,  6 Jun 2017 12:03:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751710AbdFFMDU (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Jun 2017 08:03:20 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33589 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751680AbdFFMDR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2017 08:03:17 -0400
Received: by mail-pg0-f65.google.com with SMTP id a70so4638845pge.0
        for <git@vger.kernel.org>; Tue, 06 Jun 2017 05:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=OvWZBhp/wVtuo4bDtivZMDAfecjI7OSBUra4Yu413cc=;
        b=hUIzIS0EkbKiTTGGuMREhOrSnYc9xQ/HBrRcVchopfjYIGcefxnH+Pz+iB1SIcr3Wx
         jjblhNfnEOhs402G7UsjBk5w1r0mPSUxQCKxOknniBgseb1TluXi/6L3oyp3NjzqqpxS
         OmsCQyGNmvEOZwffsPMll4ixmWjE+7TczeuYNC5FEKsUCTfqIV19/pYHlNR0nH28QRDF
         ctKWr8DZrKIBpS9opZHh4JUGQQEwFT0mY/PuT1JD7TLPZoVdJ0EK/VHxVBT15BxA6QJB
         +Danp14K1QsEqjUOVzYTDNG4l9bBDyv5jToQYFY68GsmKTxodPII/bUA+IokHkEI2Sz5
         QS3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=OvWZBhp/wVtuo4bDtivZMDAfecjI7OSBUra4Yu413cc=;
        b=a+g6QL/DY7Xb131IEdoDpBnD/Edc5aHl5xTLyhKcmfjyD6hZvkZxfVeSHJArwE2nWL
         QJRtLwe5lKwy3vwJdt1wnRdBioO/B+OAeZAugdQH+WjzQJYou0Pb1tobqtzPSIzoWxvn
         Y/UYgxefSVLpEPripg+AY40p5UFS4YEDHxRvEVlM6RjbSHws15J0OOwZY4Iep76CslCA
         YDgckHYrzFjjio9YjzPXw4mLwzDEWKg1lJEnDDlCd6Ig9H2pjx1EGFjFgFJX+G0xZ2r+
         8Ww8RDXNPiNE1YAB0t6lYKO6JpM4oelf8QtCZwYOm1nO03zTd8ZQk+DtN2YUfAVWQ7Je
         m/xg==
X-Gm-Message-State: AODbwcBbbdfNSifWebqExPkenX91ta6w2iIVF1O8q9UvxOuuRxxGZgEd
        UvqFBU+L1BxOJg==
X-Received: by 10.98.152.25 with SMTP id q25mr15124197pfd.143.1496750596536;
        Tue, 06 Jun 2017 05:03:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:411:1ad6:6716:25ff])
        by smtp.gmail.com with ESMTPSA id g70sm62438685pfc.47.2017.06.06.05.03.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 06 Jun 2017 05:03:15 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Sahil Dua <sahildua2305@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH/RFC v4 3/3] branch: add copy branch feature implementation
References: <0102015c79fcbda0-2779b4ff-54ad-46f4-bef0-14eeb58338d4-000000@eu-west-1.amazonses.com>
        <0102015c79fcbe99-7e18cee7-d82d-4ab2-9d6a-ad7376a5ac27-000000@eu-west-1.amazonses.com>
        <CALiud+=qoSSSg_p2MXZEaVTGMhFW_FtirDJ2-FnmNh+U0yf0Gw@mail.gmail.com>
        <xmqqlgp69ds9.fsf@gitster.mtv.corp.google.com>
        <CACBZZX5OS_cz_mo4rpd+=DGtyN4SfipGrOXwVHJisv3CywoFaw@mail.gmail.com>
Date:   Tue, 06 Jun 2017 21:03:14 +0900
In-Reply-To: <CACBZZX5OS_cz_mo4rpd+=DGtyN4SfipGrOXwVHJisv3CywoFaw@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 6 Jun
 2017 09:39:32
        +0200")
Message-ID: <xmqqink98gsd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

> On Tue, Jun 6, 2017 at 2:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
>> When somebody says "I want to rename my current branch to X", it is
>> clear that the person wants to end up being on a branch called X.
>>
>> To me, "I want to copy my current branch to Y" sounds more like "I
>> want to create another Y that looks just like the current branch,
>> but I want stay on my current branch".
>
> This would be more useful to me if the semantics were copy & checkout
> instead of just copy, since when I'd like to copy branches it's almost
> always because I'm on some topic branch and want to create & work on a
> new copy of that topic branch.
>
> It would also be consistent with "git branch -m" and easier to
> explain, i.e. "git branch -c just like -m except it doesn't delete the
> branch name/config you moved away from".

The way I would use this feature, I'd imagine, would be to stash
away the current state of the branch before I try to do something
potentially stupid, and then recover the original state by reverting
back, i.e.

    $ git branch -c master backup
    ... do silly things to the master branch ...
    ... ok, enough silliness. go back to sane state ...
    $ git branch -M backup master

Having said that, I think it is merely the matter of personal taste
and there is no single "right" definition.  I do not have a strong
feeling either way.

To play devil's advocate, I'd anticipate a criticism, if we take
your interpretation (which I do not _mind_, even though I do not
have strong feeling _for_ it), saying "I just told you to _copy_ it.
If I wanted to check it out, I'd do that myself. Why are you doing
more than I asked, stupid Git." 

I have to say upfront that against such a criticism, I won't defend
your position myself.
