Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C27B9C4361B
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 01:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8BAD523BA7
	for <git@archiver.kernel.org>; Sat, 19 Dec 2020 01:01:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726371AbgLSBBT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Dec 2020 20:01:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726301AbgLSBBT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Dec 2020 20:01:19 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3A3CC0617B0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 17:00:38 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id b24so3719281otj.0
        for <git@vger.kernel.org>; Fri, 18 Dec 2020 17:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=kNYpc+cZQeGXqTgTr6DdhGNhJY/pff3ebC8ZqMFZpqc=;
        b=DwOISrI4OPUY5sJmpTUYyoULswIPzJofMW/4UD63sl8XdTqCpN34IrgKLYOoU/oash
         AUiWwzq1EL+XbL3HrWLaEWbmZZZgwA6GeGBC9O4Vx+myrgyeCR4L9Dn/8+4P74WpxB+L
         CP19ZQd12M3ip1S5NnTVPiDYCb3OOgVQsxFzfgk3eETUvN6EB8oyRg4HA0HN0i7h80ef
         MgUxCNAcDF5GVoaiDb7FiOTN6zl3bHsrZVvlBQkR3FVp/iCHq+eZq8aQG67ogbA29jCp
         ypmrf2ESZreyWKQdLX6ZT1bUVsJwD4dTf8RJKjozDGlLWD+HWSfsaMe2MshG0h8UxCSV
         mM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=kNYpc+cZQeGXqTgTr6DdhGNhJY/pff3ebC8ZqMFZpqc=;
        b=pjB69lHpWVsNPx4R79ELvNz1TaPxvcElieeBOmQJDziljzp2kSyJ+cFz1t/svckV7z
         E97/Xvj4ZNhEvMJc+NTTQeWQD0H6ZQsjOnh7dSU4MCeinTmW968qRRk1VJMRy46fn4fx
         tH9R5Br+T5xkdvqAkj6za4UU4q+OjYOngc9fblkt1xiYmJZ1Q2rpEG6TEA6ot9PUMWj8
         ZDFBCfSrvn5nbcUePNsd9+8PdoA/fA0DnBMuf9v8aVdOX4aj9yCxVr3iwSwOhBtfnmF5
         NzoOnz3iPxwUNn6BF/UBAwaYwTwHAMkYcuQjJf9cHaj05lOtaEGMnyB0AX6pYmFRQ5MW
         Ubfw==
X-Gm-Message-State: AOAM5313DvpmpjoFevWS7oe+CV1dLalmNNwhj2qerAB5w8B0YQ/Ebka2
        Ce1azsUfws4QZpQ/C/GOFWo=
X-Google-Smtp-Source: ABdhPJytmPGq+eaffMr0ZAtKw/dkHlA07DfYsi07z/wywjLylj1ZFrQ0OWYsV3NmeqNY8TXUciDi6A==
X-Received: by 2002:a05:6830:1257:: with SMTP id s23mr4751816otp.69.1608339638374;
        Fri, 18 Dec 2020 17:00:38 -0800 (PST)
Received: from localhost (189-209-26-110.static.axtel.net. [189.209.26.110])
        by smtp.gmail.com with ESMTPSA id c5sm2244752otl.53.2020.12.18.17.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Dec 2020 17:00:37 -0800 (PST)
Date:   Fri, 18 Dec 2020 19:00:36 -0600
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Elijah Newren <newren@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>
Message-ID: <5fdd50b444ea9_1d9522208a0@natae.notmuch>
In-Reply-To: <CABPp-BEZ6VqyTah7QCzkuUm-p7tA_6cnpGPWpgpQbHp_c3Wc5Q@mail.gmail.com>
References: <20201101193330.24775-1-sorganov@gmail.com>
 <20201216184929.3924-1-sorganov@gmail.com>
 <20201216184929.3924-24-sorganov@gmail.com>
 <CABPp-BEf2nbahjzR6aLLNy0YsHYcHqCozCe6veoZOH3LAM892g@mail.gmail.com>
 <87blercju2.fsf@osv.gnss.ru>
 <CABPp-BGPZiwjSzZw5PLwkctW7hnG2S6UGHmkTGCh1BqgXJ+vEQ@mail.gmail.com>
 <871rfm95b9.fsf@osv.gnss.ru>
 <CABPp-BEZ6VqyTah7QCzkuUm-p7tA_6cnpGPWpgpQbHp_c3Wc5Q@mail.gmail.com>
Subject: Re: [PATCH v2 23/33] diff-merges: fix style of functions definitions
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> Personally, I think that a really important point to keep in mind when
> submitting patch series is trying to figure out the easiest way to
> move the code from point A to point B, not the route you took to get
> from point A to point B.  This is especially true for longer patch
> series.  It's common after you've finished a series to discover there
> was an easier or cleaner route to follow that would have arrived at
> the same end-point.  It's not uncommon for me to spend a significant
> chunk of time rebasing and restructuring a patch series to try to
> highlight such a better path.  This includes not just style fixups,
> but different patch orderings, alternate ways to break up functions,
> using different data structures, etc.

Me as well.

It's extra work for one person, but everyone else benefits, including
that one person in the future (who usually forgets why he/she did things
in that particular way).

Cheers.

-- 
Felipe Contreras
