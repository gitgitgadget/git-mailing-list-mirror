Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 147461F51C
	for <e@80x24.org>; Mon, 21 May 2018 02:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752702AbeEUCDM (ORCPT <rfc822;e@80x24.org>);
        Sun, 20 May 2018 22:03:12 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51328 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752645AbeEUCDH (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 May 2018 22:03:07 -0400
Received: by mail-wm0-f65.google.com with SMTP id j4-v6so22729073wme.1
        for <git@vger.kernel.org>; Sun, 20 May 2018 19:03:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=PWxjjtCeS2ba1AFJIyDBw8sHCF3hX8+58FztIFUsIeY=;
        b=Jovzn7rylmKCILekacwigZ/yZ+S5Lt7T5rQadq2iH1mN1t5k2nCpzrpm8dh2LBGfK2
         7C2+OUmRb3/E2VdHtsDRUKo/cP+mxiGsZiCtTyvZWF2KsMGbpHNxUMOqhxdPtR1DnB+G
         TecVh0itWemcQk3lhHzV6NIlRIY4BVzIC6wKLpZTs5wRBzRyr8Zsubxz0JsR2kz43gZL
         fuyU9B7FRwKLYMuTaoexEsgigAK6ZR3unzmhx7KjNQG1J/1+LUe9aGmi/Jlu+9AI5bGI
         7tvmulpPPBFz6eOAbVazcUzDCAis4Nb2B9A4DYN4lH1B4KYa+2WrHAd/Sdpwxgn9UF+y
         U5Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=PWxjjtCeS2ba1AFJIyDBw8sHCF3hX8+58FztIFUsIeY=;
        b=qCiGHBkkOgCcStuoLKGHtArjPGTwJqgLAODgF9rhHoSAECIHdYReXV4sTZNqk7iV0c
         +NGytU/7AlSSeSytQRbVEX02xWJSE0TPWwKAY4TaQ107a68Sa5EbpEOMk2eTl4DhZZqj
         VxsoIBoGcIvGqcGwqVUjgNvHccaG42PXavEauNbPVBJlPlQfJtbdtC5RWLG1NUTS/RMV
         8MOtgEymNYC8u9LX2aNE+4Ifk+qTX+MLO2p05TZVWM3qa03eYhmSARhtc5NNCjpDGEZ0
         Sup9jcxsoVsxKlLJTNNPwEd4MQgVJl4naDVIVfc1rxOizqqJOMn51XA0kpHwBSNy4i7i
         t/2w==
X-Gm-Message-State: ALKqPwehCiU1pnGG/52uC7Jljd2cLm8VuKXes8EGolu8lwukUjHOC0Aq
        12DiAg+pm2J+QVBbtO9yhLk=
X-Google-Smtp-Source: AB8JxZoeW7fXfodqoFGL0KNelRRfkgnGJibs58Ec7cdiYv8gzs0P653E5XCe8vEay8gnyEZtDzVzig==
X-Received: by 2002:a1c:170f:: with SMTP id 15-v6mr9465309wmx.90.1526868186123;
        Sun, 20 May 2018 19:03:06 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id u89-v6sm17734410wma.4.2018.05.20.19.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 19:03:05 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     hIpPy <hippy2981@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: git apply does not honor diff.noprefix config setting
References: <CAM_JFCza0Az32RC-ytu_6PxG9JnteySPEDyKEeDzZAv9MdadAQ@mail.gmail.com>
Date:   Mon, 21 May 2018 11:03:05 +0900
In-Reply-To: <CAM_JFCza0Az32RC-ytu_6PxG9JnteySPEDyKEeDzZAv9MdadAQ@mail.gmail.com>
        (hIpPy's message of "Sat, 19 May 2018 16:18:42 -0700")
Message-ID: <xmqqefi53gva.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

hIpPy <hippy2981@gmail.com> writes:

> If I disable mnemonic prefix,
>
> $ git config --global diff.noprefix true
>
> and do a round-trip of format-patch and apply,

Setting diff.noprefix does not disable "mnemonic prefix".  It asks
"diff" family of commands to use no prefix, not even the normal,
non-mnemonic, prefix.

> $ git format-patch -1 @
> $ git apply <some-file.patch>
>
> git apply fails with,
>
> error: git diff header lacks filename information when removing 1
> leading pathname component (line 16)

Totally expected.

> Without 'diff.noprefix' config setting, git apply works. It seems git
> apply does not honor the diff.noprefix config setting.

Yes, and because "diff" and "format-patch" are for producers of, and
"apply" and "am" are for consumers of a patch, which are likely to
be different people, "apply" or "am" should never pay attention to
"diff.noprefix".

It is a different issue if we should have

 - format-patch.noprefix, which defaults to the same as
   diff.noprefix, but allows people to configure "format-patch"
   differently from "diff" and "show"

 - am.pvalue, which defaults to 1, but can be set to e.g. 0 to
   accept format-patch output from those who set
   format-patch.noprefix to true

I haven't thought things through, but offhand I do not see why we
shouldn't.  But I am reasonably firm on that diff.noprefix should
never affect anything on the "apply/am" side.




