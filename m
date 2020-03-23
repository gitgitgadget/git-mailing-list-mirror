Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6756C4332B
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 09:42:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA678206F8
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 09:42:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kYw4pUKY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727742AbgCWJmp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 05:42:45 -0400
Received: from mail-oi1-f178.google.com ([209.85.167.178]:44632 "EHLO
        mail-oi1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727695AbgCWJmp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 05:42:45 -0400
Received: by mail-oi1-f178.google.com with SMTP id v134so5084291oie.11
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 02:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tqLpkm4x1v/NxZf9/qi6/kX7CBh3c8/GAxW9xeMCfts=;
        b=kYw4pUKYLs2VFkfwVygNMByFRYQkXXoYxabozqkwKfshbiU4r+0tRzbBMdQ7Vd9pRv
         JF+NQJ335DoO9juIoc7LpzCd1uJqQ0gnQACeZJJGWH8dpAnkDWaLiAyVHr5PqozFZRsV
         oq54T0taFwhIHrfpDPGyya0lXuQl07G48jOjn8/y+FYcGTCz8bfjd+Xsu6MNTrR3Hara
         5tkGVrBjl72Umxh4x6p0F07c96t6SPgYRaDA469amBh6BliDZ/HZgUu4TpNtZ8pTwW5l
         TGcsmUeljKYDNE8DPmjglADHCUq5b51cxa1ZSSOybfsipwZCiAoa18X1U0bNKlvaxtSl
         A/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tqLpkm4x1v/NxZf9/qi6/kX7CBh3c8/GAxW9xeMCfts=;
        b=qb7hvJFrFfOTY1Mesa3jwoxz2oWDZ3ZR+3wIRHReu5e392ca6jBNkxkYAB4c3Qxy1m
         apLAen5cQdC9DpS4VbTniNliz7mchBuS5oBLi7TgP05+TiRmP1XZhv55VqClVk7mEaJq
         9lRN9A8FlVuhQ41ey0UyjmzR3K+RzSlxsskOfLbW2UEi7iU7dai67+ty0a/1i8HbLSZ7
         JYg9WiQvVCDjVcFDL0NG3BliBtLOJ8lpuJ8R4K1IXGxGyTwSKAHtgkLwnNfSQ9JxwIcK
         SrnllQ4wI7rBD18TRWctzuNOMlDw1JXV6XV1xjeVc7/Wh77hem8xRVJSjuUOnJhI7czB
         Qi8g==
X-Gm-Message-State: ANhLgQ0aMWkn4VDD9eKlODAW7+j/MfUnSlZQf+MUL2z8Z0hzdQtXpWuW
        kn5oD6Kb3mzlEwaoPhrBiNzw9PKrKCEm+vTdVEw=
X-Google-Smtp-Source: ADFU+vtiX22rFJK8BVVf9lGtp8TJT/jHVnPPZaoK76TtrcAnee5qQfNA9rIpurKN/4NU4NgYkFz7jxhJzeJfWv8UBX0=
X-Received: by 2002:aca:55ce:: with SMTP id j197mr4670061oib.84.1584956564457;
 Mon, 23 Mar 2020 02:42:44 -0700 (PDT)
MIME-Version: 1.0
References: <CACuU+s80UPZnwQfd1rXBVyMaE0FmpYNgf+wPLjOo0M7kYNWx1g@mail.gmail.com>
In-Reply-To: <CACuU+s80UPZnwQfd1rXBVyMaE0FmpYNgf+wPLjOo0M7kYNWx1g@mail.gmail.com>
From:   Hariom verma <hariom18599@gmail.com>
Date:   Mon, 23 Mar 2020 15:12:33 +0530
Message-ID: <CA+CkUQ_85jb-QBVXioa7c0dufzgKtOmaym9K8KK5eRBvjcLK5Q@mail.gmail.com>
Subject: Re: [GSoC][RFC][Proposal v1] Unify ref-filter formats with other
 --pretty formats
To:     Harshit Jain <harshitjain1371999@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Harshit,

Apart from your name initial(i.e 'H') and project title, the proposal
itself gives the mild feeling of mine. Wait did I just said 'mild'?

Well, I'm --pretty amazed to know how closely we think. Taking a look
at someones work is always a good point to start. Don't just stop
here, you still got plenty of time to research more on pretty.* and
ref-filter.*
And you may find something more crucial that I wasn't able to find.

Regards,
Hariom

On Mon, Mar 23, 2020 at 12:57 PM Harshit Jain
<harshitjain1371999@gmail.com> wrote:
>
> Greetings!
> I would like to request all of you to please review and give suggestions
> for my GSoC proposal. I have already submitted the draft on the GSoC
> official website and have mentioned the link here as well.
>
> Link: https://docs.google.com/document/d/1pNDKC-ZVTdo-B9xUtB1LuVkQXpYBsB5dEEtRbHuzWtE/edit?usp=sharing
>
> Thanks,
> Harshit Jain
