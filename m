Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3629C77B7F
	for <git@archiver.kernel.org>; Thu, 11 May 2023 18:27:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238838AbjEKS1i (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 14:27:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238620AbjEKS1g (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 14:27:36 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 984E619BE
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:27:35 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1aaf7067647so62276545ad.0
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683829655; x=1686421655;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEQKUZCCYGIYiHTAIh1Gz3L2iktMVSG0r9F6rV1DXzs=;
        b=ZJQNB3U27PrYRxKEn1VE0rXy580r/c27otuU7iBVv8pKlY2ZsPSaJBkdSHiWC5/s5M
         xgxsoPdjbLfgt67SEq61UJquSlkhMwbhX/uNdA7oe42Or8/OGDoSzIdl1f7+WP51tK0o
         p6yLB/mqpZJIGt/5v7XK704A42XOhp8cPMugUjtGcaXrjrY4wyJk0LhN0NdnPnyQhr8W
         IMeoNpaBUpYPF0vZWdViUMZILV66ESMM7cbRms2htRAAKZyc459hN4Kui4+3rfdO3Y7H
         tKoofQ30fmeEAPYF0Q09A6R0I4hvCLoikHyyFGTRCKP/ibz67WRiGG/ds5CHddtnXcQx
         I45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683829655; x=1686421655;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qEQKUZCCYGIYiHTAIh1Gz3L2iktMVSG0r9F6rV1DXzs=;
        b=NLsjvWORzFMVJTUjC5WHKsNZyeXl2m4fSSHggp4RaBY8EUVz3GLSXodXIsbEb/CAKN
         N6Qgc3fumxqkVMmcx12WwGLpPrINnHxaJm1Bd4dGy4qpK7a8AB/0I2pegeG5SmBMaUDQ
         EsrQMVKeN9QrAi+OgmMJsB4oGi1IGqmz9PgMqiAdtVuNyLzVTJrkbVLwAGaA73TDbEK4
         RkLJh4n+N7CrHgW8rB7lCYTB7cZm+6M6kss5Ppw4XlSZlthzRuHmUxc91a6CRBgiPt3e
         2sPRUh0Ywa1vsLeOaqm2ydid6Ds1JNfDFM7LCyzOYyzNv03+FtlrAGBNnPC+4BBWgIJ2
         9gAw==
X-Gm-Message-State: AC+VfDxzF2zJIAYK+2NVRvWq32OIc0s3vcX7zrpFjStOjKIteeK19IMz
        cTALqqU+a6BejNOnf0D8Uyw=
X-Google-Smtp-Source: ACHHUZ4PNf6fUZrpxor3RRJHijKAW03Et4Q6GjoOBfmdcjI5dZaaoD62Qa3kbPTfwHBRu2AGWFXXWQ==
X-Received: by 2002:a17:902:b70c:b0:1a9:3b64:3747 with SMTP id d12-20020a170902b70c00b001a93b643747mr20863311pls.17.1683829654945;
        Thu, 11 May 2023 11:27:34 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id y5-20020a1709027c8500b001a98f844e60sm6214112pll.263.2023.05.11.11.27.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:27:34 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Matthieu Moy <matthieu.moy@univ-lyon1.fr>
Subject: Re: Can we clarify the purpose of `git diff -s`?
References: <645c5da0981c1_16961a29455@chronos.notmuch>
        <871qjn2i63.fsf@osv.gnss.ru> <xmqqwn1ewyzx.fsf@gitster.g>
        <87lehu219c.fsf@osv.gnss.ru>
Date:   Thu, 11 May 2023 11:27:34 -0700
In-Reply-To: <87lehu219c.fsf@osv.gnss.ru> (Sergey Organov's message of "Thu,
        11 May 2023 21:04:15 +0300")
Message-ID: <xmqq5y8ywwo9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> I wonder, why this intention of the author has not been opposed at that
> time is beyond my understanding, sorry! What exactly did it bring to
> make --no-patch a synonym for -s? Not only it's illogical, it's even not
> useful as being more lengthy.

Probably because we wanted to have a more descriptive synonym to
make it discoverable [*].  The release notes for v1.8.4 (where
"--no-patch" was added as a synonym for "-s") tells us this much.

 * "git show -s" was less discoverable than it should have been.  It
    now has a natural synonym "git show --no-patch".

In hindsight, "--silent" or "--squelch" might also have been viable
choices, but if you really care, you have to ask Matthieu why
"--no-patch" was chosen.  If I have to guess, it came from the
desire to phrase it as "--no-<something>", which some commands had
started to adopt as a convention to defeat "<something>" between
v1.7.0 and v1.8.4 (the latter is where "--no-patch" appeared), and
"--no-everything" is awkward to be used with "git show" as we still
want to see the commit message.

> Why somebody would use --no-patch instead of -s when she means -s?

Because "-s" does not have a longhand and not easily discoverable?
As I explained above, I thing that was the original motivation
behind wanting to have _some_ synonym.


[Footnote]

* In fact, I was surprised that somebody (I forgot who they were),
  who I have known to be a user of git for 10+ years, wrote
  "--no-patch" in an example in one of their recent messages,
  outside the context of, and I strongly suspect that it happened
  before, this "-s" vs "--no-patch" discussion.  I took it to be
  showing their preference of "--no-patch" over "-s", or their not
  knowing about "-s" even they are a long-time Git user.
