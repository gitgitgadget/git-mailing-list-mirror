Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED5EC07E9D
	for <git@archiver.kernel.org>; Mon, 26 Sep 2022 13:00:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbiIZNAu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Sep 2022 09:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233443AbiIZNAV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Sep 2022 09:00:21 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89A2E1B2631
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 04:33:38 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id f20so8564577edf.6
        for <git@vger.kernel.org>; Mon, 26 Sep 2022 04:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc:subject
         :date;
        bh=V9Jepz9mnGwheZmYvljBKOwDXFlys9pmLAaNACVzp8k=;
        b=n9zbDU6/oSsCoRkN1QrQObF1ndbc6Y3mAgAq+6uPAcdSsWifsIuYIAdkDB+hsZUtbY
         IDqynlz9KpH8kypkZmDQd+FCYDq1lUMbMuM5WRerPx7Bi00BJQzjrv31kPZCXpw8uxDZ
         NSSk3Hgpn7w0Iy4q96jv3d6sJloTPKyNKX1PqK0HhmZ6f7N1ufT1yHPwp2gpfA+y/IF4
         xEqja0wloD7sPAHsiOSX9rQS+/Xs3X6T/BJMnL9NMxvy7pcIEnE1mX2aBsA+7lFzEK86
         3wBjWxKdp3vwWvOzq2B4VCFUrbD6bhSVSi+fCA1pcEbeHzMvfbFEeV5zOioEp8//2iaV
         qXnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date;
        bh=V9Jepz9mnGwheZmYvljBKOwDXFlys9pmLAaNACVzp8k=;
        b=tZjlEyZygU8cATSOAhht2E6dGTIjgXdYYuuYBmkTyjbhqWTjapBQt7aeoWfrWDQfJ2
         TTdX2iAdFwfiPN82iWA6M31+ht4E19Zu25s750go8wIhOt1fiwAM04usl5taqrC5kuVM
         YCv3WowoBAYox2avTgFxmPA2kceErxkEjgOiXzwR4mXLfUidzZph7V6HkMk4ioCUxAmV
         1S9NB+ruONu8DwJx7K11QC3EGA3BCiG1IGX+Af61ITGMa0rlIs2Vc46LZdkHspWEMQer
         L2cAsmvRSBtb2iE+6oWNbZje30VWK2wgev4SOrmrfMRohuWCW0XkpJC/RjrWu14smrbL
         BZhg==
X-Gm-Message-State: ACrzQf3zoGCFZx1s6Mvzk2Wj4Ux4MX7LlOHTEEIBYgSTe92KWgoHLJ5c
        8iQhjakakwvE3HfmF8rLK9ez8ynW66I=
X-Google-Smtp-Source: AMsMyM6nO62pgzWn+SBMx2FICyIAWofrsRDfDpwCJ/EyG5e7IbpREm6hBok2PcyHN8uVf8LzlSrPbg==
X-Received: by 2002:aa7:cfd1:0:b0:451:de20:3392 with SMTP id r17-20020aa7cfd1000000b00451de203392mr21985325edy.16.1664191946927;
        Mon, 26 Sep 2022 04:32:26 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id d24-20020a056402001800b004511957d075sm11148572edu.80.2022.09.26.04.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 04:32:26 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1ocmLZ-0001wZ-0Z;
        Mon, 26 Sep 2022 13:32:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Victoria Dye <vdye@github.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        John Cai <johncai86@gmail.com>
Subject: Re: [PATCH 07/34] doc SYNOPSIS & -h: fix incorrect alternates syntax
Date:   Mon, 26 Sep 2022 13:28:49 +0200
References: <cover-00.34-00000000000-20220902T092734Z-avarab@gmail.com>
 <patch-07.34-a070c97f29b-20220902T092734Z-avarab@gmail.com>
 <b1c44436-92d1-067c-fb0a-be4049f3031b@github.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <b1c44436-92d1-067c-fb0a-be4049f3031b@github.com>
Message-ID: <220926.86pmfi1id2.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Sep 19 2022, Victoria Dye wrote:

> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>> Fix the incorrect "[-o | --option <argument>]" syntax, which should be
>> "[(-o | --option) <argument>]", we were previously claiming that only
>> the long option accepted the "<argument>", which isn't what we meant.
>>=20
>> Unlike a preceding commit where this was fixed for commands which had
>
> nit: if you're referring to patch 10 [1], it wouldn't be a "preceding"
> commit. Otherwise, I'm not sure which commit you're referring to?

Thanks, yes this is incorrect. It's due to rebasing/reordering this &
missing this mention.

> In any case, I'd personally prefer that this patch is combined with patch=
 10
> anyway, since both fix the same underlying issue (just in different place=
s).
> Neither patch is particularly large, and it would be nice to make (and
> review!) all of the "fix alternates syntax" changes at once.

Yes, it's the same issue, but I think I'll keep them split up (working
on a re-roll).

The reason is (as mentioned in the CL) to cleanly split up the
"consistency" changes from the rest.

I.e. in this one we need to change both *.c and *.txt versions, so it's
a "new" change, i.e. reviewers need to do more work to eyeball & review
a version that's never used that form in-tree.

Whereas the "consistency" commits are ones where we *only* change one of
*.c or *.txt, to make it consistent with the other existing and
corresponding form.

That still requires review to see which version should "win", but with
34/34 (where we test all of those at the end) doesn't require the
reviewer to consider whether the change is sensible at all (if it
doesn't make sense we already have that version in 1/2 places in-tree
already).
