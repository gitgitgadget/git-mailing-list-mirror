Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ABCAC636D4
	for <git@archiver.kernel.org>; Fri, 10 Feb 2023 16:59:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232902AbjBJQ67 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Feb 2023 11:58:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232915AbjBJQ6w (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Feb 2023 11:58:52 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB29D795E4
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 08:58:48 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id a8-20020a17090a6d8800b002336b48f653so4370706pjk.3
        for <git@vger.kernel.org>; Fri, 10 Feb 2023 08:58:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQc2+H91ybtTZ7ssIeEuMnufTRnosALrO/UydSHzabg=;
        b=H9rXRxrx5qzEBPFYurnnsWPsPgTiRsZRyrByYVl/dKTCQoIj/ANtgVZRn3jZpIe/Jp
         zpCVO7cUDd1kdQ8kzDfEOFsK8rDu5vvDMBb+Goe6dCi4Xsj24TKFa3nvwTMwVVl6avDn
         +7P/SQWCXTwCsb2DUU2P3eS85nQ/L4bXTnIl5CYrRgQNkGh9sa1P6F0YZqGDHjwhHRJS
         XRjNwOXAs3Edq+ivYofAAPWkDoZ9sc5iNh5J1ZWeR0pAwfS1bUOe5YxRRzGE1al0C60E
         z0l2dQnZy3qsbT6gX9V1MrreLfbd9Lffa/yKkGCoKdbstVw8eY89/TgWbrAzJPE2VIMB
         pCOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=sQc2+H91ybtTZ7ssIeEuMnufTRnosALrO/UydSHzabg=;
        b=t/TX6vD1THHlGUWeBOUHje+UZHUdSnSfCdMVtgIVgBCjBy9EETq1PHVhA3GotQd3gF
         U1A1ZWBhTIeq0by35vnPAMQcFGvxl7qxSRVIRMDuVpDc53T6l5eIGPtkf+P2fFzNFgkz
         ae0aZmRaZPt+4bVts0Oe1ZaKulJapjy1x3L5+mNZ7V5Tftrh+9fYBpwY9GGC78QF2Eme
         pJojY9oZMsX3Cvnu0YnYHtdfRfElUcii4Oh5S9IjNvGAaa4XdgwKlI2Xd+DyZbMp5Q5K
         IEuhsOWdi1GeIFNvZw45opmMfteEO0bSg804LxhQ6t3EefnlXhJMjWgz7uNM6yiHmLAE
         o5+Q==
X-Gm-Message-State: AO0yUKXu0ty1HW0Fe3jHZCx1fOKCV6XPXuNfxaoWyB62Cq0G1VfMmza+
        RY6R18FzBF6WZCgAzdE8xT+lTDlYmdc=
X-Google-Smtp-Source: AK7set8AmZx9s7LkHZstIcYLFUqF9OgLLfSrRDMnOmzoJr5xKmcQofFKYpajqav2BzTJ0MiRD3x30g==
X-Received: by 2002:a17:90b:3a8b:b0:230:9b7b:20fd with SMTP id om11-20020a17090b3a8b00b002309b7b20fdmr17364687pjb.5.1676048328208;
        Fri, 10 Feb 2023 08:58:48 -0800 (PST)
Received: from localhost (252.157.168.34.bc.googleusercontent.com. [34.168.157.252])
        by smtp.gmail.com with ESMTPSA id g7-20020a17090a290700b002262dd8a39bsm5364827pjd.49.2023.02.10.08.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 08:58:47 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Gwyneth Morgan <gwymor@tilde.club>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] signature-format.txt: Note SSH and X.509 signature
 delimiters
References: <20220120053223.221667-1-gwymor@tilde.club>
        <xmqq7daui4s8.fsf@gitster.g> <Y+XhPeh76D6/Uz6C@tilde.club>
Date:   Fri, 10 Feb 2023 08:58:47 -0800
In-Reply-To: <Y+XhPeh76D6/Uz6C@tilde.club> (Gwyneth Morgan's message of "Fri,
        10 Feb 2023 06:16:39 +0000")
Message-ID: <xmqqwn4pjw3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gwyneth Morgan <gwymor@tilde.club> writes:

> I believe the existing language is referring to the
> "-----BEGIN PGP MESSAGE-----" format GPG outputs in RFC 1991 mode,
> rather than the "-----BEGIN SIGNED MESSAGE-----" that X.509 uses.

The paragraph came from 76f9d8ba (Documentation/technical: describe
signature formats, 2016-06-17) that started the documentation, and
predates x509 support by two years (and ssh came even later), so
you're right.  It couldn't possibly have meant anything newer.

Thanks.

> OpenSSH's signature format documentation says:
>
>
> 	The Armored SSH signatures consist of a header, a base64
> 	encoded blob, and a footer.
>
> 	The header is the string "-----BEGIN SSH SIGNATURE-----"
> 	followed by a newline. The footer is the string
> 	"-----END SSH SIGNATURE-----" immediately after a newline.
>
> This is sufficiently similar to the nomenclature in RFC 4880 to call
> these "Armor Header Line and Tail Line" without any misunderstanding (or
> "footer line" if that's preferred). I did not find documentation on what
> X.509 calls these.

Sounds good.  Thanks for due dilligence; it would make sure our
nomenclature would not go out of line without a good reason.

