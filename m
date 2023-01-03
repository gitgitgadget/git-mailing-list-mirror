Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B74B3C3DA7A
	for <git@archiver.kernel.org>; Tue,  3 Jan 2023 00:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjACA6G (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Jan 2023 19:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjACA6F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2023 19:58:05 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F2A0BC
        for <git@vger.kernel.org>; Mon,  2 Jan 2023 16:58:04 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d3so30994608plr.10
        for <git@vger.kernel.org>; Mon, 02 Jan 2023 16:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=VJ+SvwPrvRYSJFxLT8x/Bz3IM/PMGY0rojaumynLua4=;
        b=V2IzOBLdCoPuH7RdCgYP+Le14SG2MGKQ8GuhFnQg87Wag5PEqoDWHD/+DMGtrQkBDP
         KAfM03GMrBhE5FIp09IwksozrHOGwChmLJJyzXlitVuEXOODoUHO3Y7DL6Ov3tHFO6Mm
         YN3ern5q6+AsaSnpse3ilPzA4RQSeIy2fT2/GslR1F4K4et/p3tOy8WP1M2uApPXT6M8
         6ktih8R87NH/DI2jUfVXLm7+F3yZV1ZIApzKV5uX8kBTajNewKiEZfgw0ecU1lxhCTm4
         /6mzeeXYk6FtKJQLsFn+7FBB1loB6dhrg46wMv+CbC2aD8VyHOeiGHf4y460dCSamZXk
         xI+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:date:references:subject:cc:to
         :from:sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VJ+SvwPrvRYSJFxLT8x/Bz3IM/PMGY0rojaumynLua4=;
        b=OIvsnOE+DvoSvGa1GnuHlebeWBCahXnrmaH6tibAokvGLjKF/OOOEcbtifQPzIH8A6
         9gS4PoSdlo/KQdxRrlHYsJJQBcPxTGNK7DsLlQz82Bp3+y1KxmBxiZ3a3A4jAV3CsawR
         VXyvtMipfe/iNpl7LX8i6pdq/OmivHL68SJqJiGzcASCFLNFW++ODaDc1nc8peC/X9Iq
         4zG1l7p11dAp8EBu77+O0fUVJNqtH2/O3bDi8ZMOLAQXf6e5cZ7PVzh1KKyNJ1NzL31E
         /JHa+MnBxrz1bitawv3Nv5g11y0gVqR3pwcD74MNH5p0ubTjh3rpz8ALB9Y2uhln8etu
         TT+Q==
X-Gm-Message-State: AFqh2kos8BkvaJTwB0v0opRTk25zbOkx+NbwGFRRr0KZ7MOHOFN/qgl2
        dPgSeqTSRtgbXWjpwEy79uM=
X-Google-Smtp-Source: AMrXdXvOUxQ/qLDkSOSkoRcnBCrB1ifmVG4hgDD0xUuhwnq7PywG2/EGqN6579mVKk+B9RT2ytbqiw==
X-Received: by 2002:a05:6a20:670a:b0:a7:8b3e:1207 with SMTP id q10-20020a056a20670a00b000a78b3e1207mr62221776pzh.13.1672707483396;
        Mon, 02 Jan 2023 16:58:03 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id p17-20020a634f51000000b00485cbedd34bsm17456703pgl.89.2023.01.02.16.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 16:58:02 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     NSENGIYUMVA WILBERFORCE <nsengiyumvawilberforce@gmail.com>,
        nsengaw4c via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ref-filter: add new atom "signature" atom
References: <pull.1452.git.1672102523902.gitgitgadget@gmail.com>
        <xmqqo7rpvb83.fsf@gitster.g>
        <CA+PPyiGPRztaLsty5LqT-7GfjPusyt=7hi22z1aPdm-G8pZpuQ@mail.gmail.com>
        <CAP8UFD3i7C2c79V2ORxh-Q-rNuwKVqkMRX0VoXy3iugw=u5K+A@mail.gmail.com>
Date:   Tue, 03 Jan 2023 09:58:02 +0900
Message-ID: <xmqqv8lov3hh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> I am not sure I have understood this, which helper?
>
> I think Junio is talking about the following function:
>
> static enum signature_option parse_signature_option(const char *arg)
>
> he suggested above.

Correct.

> With this function the above code could be just something like:
>
> if (parse_signature_option(name) < 0)
>                     continue;

More or less so, but the first "if" in the helper I wrote in the
message above is broken.  It should be

         static enum signature_option parse_signature_option(const char *arg)
         {
                 if (!*arg)
                         return S_BARE;
                 else if (!strcmp(arg, "signer"))
                         return S_SIGNER;
                 ...
                 else
                         return -1;
         }

and then the code equivalent to the bunch of strcmp() would be

	if (skip_prefix(name, "signature", &name) &&
            (!*name || *name++ == ':') &&
            (0 <= parse_signature_option(name)))
		; /* we have "signature"-related atom */
	else
		continue; /* not a "signature" atom */

or something like that.
