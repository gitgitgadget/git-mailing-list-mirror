Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97CDBC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 14:10:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348945AbiHSOKG (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 10:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348475AbiHSOKE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 10:10:04 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B18E1151
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 07:10:03 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h5so4515119wru.7
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 07:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:from:to:cc;
        bh=omoKpjZlOOrnBK6LrR2bQtvPmlxdLjG6WnCaxAQxIMY=;
        b=QRoGaSra4GwuPvYGD5wjo7N8Gnd4WJLt7ngIc3JWIIqycC3giUEi6ZaBtj4ZR0ncE5
         UmxCaqV3lub7pZSjEFXAJ9chUqeGMal2SxxiCaS7w8pTz9LWUw6BMWgBvnPBcLNRfD0q
         efId3acsoOrg8ogX0auCT0jYsjJORC17scDx/QtxeSZQsiYOSzcsVWpDxOoi4A/IQ8jD
         hAJ2QZlg3aErP6G2hvYgB5WI0PB6g6U5xwHoR04VRgfXCLve6IEjsUXx/oKSXui/MGe2
         WlfbZp8e9shn4fEhxLxp94QgAjIXtx+5vZqm9N8Xc+K1o7Vas2disYORulX/26BQjSDp
         X1aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:in-reply-to
         :user-agent:references:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc;
        bh=omoKpjZlOOrnBK6LrR2bQtvPmlxdLjG6WnCaxAQxIMY=;
        b=MDMicl7xPbhCaJT8+SGRQ90FlCCaKYIu9qVpxghCLnhNeEKa+MrUYfflH0UguqGlNp
         tyX1HiTC+uzpqa6VB/UdHkO6TbjfBm4+BYww8+jQdi1ifVpDaeEdnHhlxDtAtSXTv90+
         m5Xq6XfMuvbHG34mlaCeyKddcU1gDRaCKHpTtUrO+12rtSPgq6eFnCxInSvEW7SYYnzT
         d1vcipswBnPNVK2+7dx/i5lPQ/4p/7q0NoIKjdATDQztLAdz/8t81aDkzfKOfeXOzdV0
         FWplw6dDrVPGrN8fw286vpnY1sgzMlQ8E12y9LvPzHbchO9VFY0NX8UM08JsoD4F3Xpg
         XwWQ==
X-Gm-Message-State: ACgBeo2mRYXhd58lqaztutAKigB0sEprT7O5TjQ5e1PvqaYfFHcQO517
        Vfl3AKh9kV0mNvANXjbPHxPyc8PgNdM/tA==
X-Google-Smtp-Source: AA6agR4F+gqiE+w7Krmnn2YsCbd65hH0vhpjwGzdUpD+cA19MG33xtbmQMa0p5dmak9f5nKloowzsg==
X-Received: by 2002:a5d:5711:0:b0:225:2884:cc88 with SMTP id a17-20020a5d5711000000b002252884cc88mr4315788wrv.141.1660918201709;
        Fri, 19 Aug 2022 07:10:01 -0700 (PDT)
Received: from gmgdl ([213.220.124.15])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d4b46000000b002205a5de337sm4088829wrs.102.2022.08.19.07.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 07:10:00 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1oP2hD-000jWj-0J;
        Fri, 19 Aug 2022 16:09:59 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 0/11] annotating unused function parameters
Date:   Fri, 19 Aug 2022 15:58:19 +0200
References: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <Yv9gxqH6nK2KYnNj@coredump.intra.peff.net>
Message-ID: <220819.861qtc8gug.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Aug 19 2022, Jeff King wrote:

> I've been carrying a bunch of patches (for almost 4 years now!) that get
> the code base compiling cleanly with -Wunused-parameter. This is a
> useful warning in my opinion; it found real bugs[1] when applied to the
> whole code base. So it would be nice to be able to turn it on all the
> time and get the same protection going forward.
> [...]
> And of course the most important question is: do we like this direction
> overall. This mass-annotation is a one-time pain. Going forward, the
> only work would be requiring people to annotate new functions they add
> (which again, is mostly going to be callbacks). IMHO it's worth it. In
> addition to possibly finding errors, I think the annotations serve as an
> extra clue for people reading the code about what the author intended.

I've known you've had this out-of-tree for a while, and really like that
it's on the path to getting integrated.

But I have a hang-up about it, which is that I though __attribute__
(unused) didn't work like *that*.

What it means (and maybe only I find this counter-intuitive) is "trust
me, this is unused, but don't check!", furthermore it causes the
compiler to completely ignore the variable for the purposes of *all*
warnings, not just the unused one.

I may still be missing something, but I wonder if this squashed in
wouldn't be much better:
=09
	diff --git a/git-compat-util.h b/git-compat-util.h
	index a9690126bb0..e02e2fc3f6d 100644
	--- a/git-compat-util.h
	+++ b/git-compat-util.h
	@@ -190,9 +190,9 @@ struct strbuf;
	 #define _SGI_SOURCE 1
=09=20
	 #if defined(__GNUC__)
	-#define UNUSED(var) UNUSED_##var __attribute__((unused))
	+#define UNUSED(var) var __attribute__((deprecated ("not 'deprecated', but=
 expected not to be used!")))
	 #else
	-#define UNUSED(var) UNUSED_##var
	+#define UNUSED(var) var
	 #endif
=09=20
	 #if defined(WIN32) && !defined(__CYGWIN__) /* Both MinGW and MSVC */

I.e. it's a bit counter-intuitive to mark these as "deprecated", but you
can add a custom message (with both GCC and clang). Improvements to the
message welcome.

Now as in this series we stay silent if the variable is not used, but we
*don't* stay silent if an UNUSED(var) is actually used, that'll now be
an error:
=09
	xdiff/xdiffi.c: In function =E2=80=98xdl_call_hunk_func=E2=80=99:
	xdiff/xdiffi.c:981:9: error: =E2=80=98xe=E2=80=99 is deprecated: not 'depr=
ecated', but expected not to be used! [-Werror=3Ddeprecated-declarations]
	  981 |         fprintf(stderr, "%p", (void*)xe);
	      |         ^~~~~~~

This also means that you don't need to rename the variable just to avoid
"accidental" use, which also has the benefit of not tripping up the
variable typo detection.
