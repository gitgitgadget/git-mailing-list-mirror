Return-Path: <SRS0=90au=Z7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E40BC43603
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 21:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BF64205C9
	for <git@archiver.kernel.org>; Mon,  9 Dec 2019 21:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vbJDU/Pp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726562AbfLIVm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Dec 2019 16:42:28 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45454 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfLIVm2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Dec 2019 16:42:28 -0500
Received: by mail-oi1-f195.google.com with SMTP id v10so7781817oiv.12
        for <git@vger.kernel.org>; Mon, 09 Dec 2019 13:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dP57npe4gQu8ou+x5dhAPialjh7N6vKmkBDTMw2IIYE=;
        b=vbJDU/Pp5IHwZOrN2KBPa9NH7skfMC7bwOLOCzA3wWC3UAYKJ56HWaolpMkIBjwAo2
         v/FFpICFRkcR7eb1091LMRmcXGCSMH4T6/DekTYIIFJQPX1cLBangKFGdUkV/HiAnnKt
         ivNFqMCAZj96ih/b5V0gZKddxaKFXVhw7AnOAMQZW3MXv/tBLT18Hc+O7T40Kerjc6WU
         bYvFCWos6zBd6G3QIG5rmtR37LS7KX4PC9CasxkL2T4jS89uwflZkcA/3fiTOSt4t7vA
         GJu03iczyxfy1AENY14ksK5TW55dsj6JRyjzKMfIeksvSOtBi7x0MxwZsHmUMdDNuE4p
         uqLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dP57npe4gQu8ou+x5dhAPialjh7N6vKmkBDTMw2IIYE=;
        b=g8nye1sRrZKFM8l+vG4diZ2ehKtsiarDsy/eiQCtpgTTBHmcZ68XO01jS4JI/dWm6L
         zPRv/WsiA648Mdj444kRZVZ2DZMX+vp8t/Hc6Jw4dIwsH4qD4TF2Asxf52epoayMqzcb
         a+KEElFo7nvue7RAQ+K/Zm/xeHkwda/UIM0xcTpb55Zl2H75thbRrKdutCocbd7x8yXL
         x64IInVDz9otssKVW8HMcaNBPUyJpWiWVLXXt/V87Cxr3EGpM0O0nwreYbEBUIRrvbhM
         TDrkElshedLqPAt12XD5rFPFhXfaW2kVPSY17Vb2b1L3cwUZ7iJu7EUGmdE3NVQMDv6b
         m+bA==
X-Gm-Message-State: APjAAAUA2AhPwffgHP0BrtWC15x3y3xNZJkkOHAEapg8kDBztxUw6VGP
        azwLAlJkOlDlpJgqqK4VJ465/sDvxkYS4eDgq4s=
X-Google-Smtp-Source: APXvYqzJIKh7p3LNTuHJGN9ZvDTvnf1YGtqtVl/Gg0W8+gxnYweipx3vjBN/9tqB6LwdZV7Tfds/1xx5DF0JiKWj/B0=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr1184782oig.39.1575927747181;
 Mon, 09 Dec 2019 13:42:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1575896661.git.liu.denton@gmail.com>
In-Reply-To: <cover.1575896661.git.liu.denton@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 9 Dec 2019 13:42:16 -0800
Message-ID: <CABPp-BFstgQya9mKXdDVWkf=U_3RQqY=_+2MpZpw_u9ci+0mqA@mail.gmail.com>
Subject: Re: [PATCH 0/5] format-patch: improve handling of `format.notes`
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Beat Bolli <dev+git@drbeat.li>,
        Pavel Roskin <plroskin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 9, 2019 at 5:10 AM Denton Liu <liu.denton@gmail.com> wrote:
>
> In this email[1], Elijah pointed out that the handling of multiple
> `format.notes` configurations could be buggy. If we had
> `format.notes = <ref1>`, `format.notes = false` and
> `format.notes = <ref2>`, the behaviour is ambiguous. This series uses
> the way `--notes=<ref1> --no-notes --notes=<ref2>` is handled as a model
> and structures the handling of `format.notes` in a similar manner,
> allowing one `format.notes = false` to override previous configs.
>
> Also, in the same email, it was pointed out that git_config() should be
> called before repo_init_revisions(). In 13cdf78094 (format-patch: teach
> format.notes config option, 2019-05-16), the order was reversed. This
> series changes it back such that git_config() is called before
> repo_init_revisions().

Sweet, thanks for working on this.  I took a very cursory glance over
the patches and didn't spot anything egregiously wrong, though I'm
also not familiar with the notes machinery.  Mostly I'm just piping up
to thank you for tackling this so quickly.  :-)
