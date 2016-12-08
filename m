Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D81251FC96
	for <e@80x24.org>; Thu,  8 Dec 2016 10:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751130AbcLHKwH (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Dec 2016 05:52:07 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:33049 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750729AbcLHKwG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Dec 2016 05:52:06 -0500
Received: by mail-io0-f196.google.com with SMTP id k5so147418ioi.0
        for <git@vger.kernel.org>; Thu, 08 Dec 2016 02:52:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=E5VhpdMBF2IOVmup59EtovvdWL6qmvQ8rG1UP1dbW8Y=;
        b=0szjeJ8eur2a7tWYQru1gjYzLKNUQ67Ed/uwPbQKwDRfYjTjomfezVwXO3NxUJjmw2
         wONJ+Mfis5Zbn2efTvz1nR3Cd9Kuwhdd+elqMTO+cjbTBXp9xYLHGDS3Q9f9IXgKGPPW
         siIO2RMQr8cgXzDMZ2smWZSBqXH2HjY3OiEPZlUdtB7vSJZ4k6paV/evSXAeBBYcoLAA
         eLWaMJfkxzuInwm9Em+FOmySzQUEtxtFfNmtePUzEYs9EhyU5WrFXmHVGYkD3IbgTEjY
         xyLad6NO4QgCksLlADqJdNh1NSnuT9Ec56erwU1lNPsmIkYn3v/Q5fLCTN3tSwfxmFVH
         3IlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=E5VhpdMBF2IOVmup59EtovvdWL6qmvQ8rG1UP1dbW8Y=;
        b=h21KEhVq52qExL3h4wVy2oT48OwWMCMP7F2SnMMvXakxH+sIvtSg32919KYTOMrRJE
         2hJfiD1ywt0HuXJVblYQ5pOzxldmOZBX5+Il6dmUyA24eTMmnklrbLnZsUgmBqIPEdRu
         rJHD90PLYO1FIxcIWGZXfy+RU5uMOBnyfVshK6VAsIbW05K8I00VuiQHIJkwn538Amte
         esu+yCkLsmgjiMaxj0OtN/1VoJC1r0elwLlzePYYJzV4QmtnGGxNEt8z/009JsBneO8P
         jlLwpr2KSrivf6z/XA5buW3b7NOlSVf7Ut3S6/5gISp6Xj1JqVPpKihprgYRUz5EMAPv
         WNwQ==
X-Gm-Message-State: AKaTC016GrYmuxwoAu00fSGNoyNo4qUlIy9OqrlaMsLYaPo/boV3rdA2m5t9c85IgpSFN0ydLL4Dx5rkOek2CA==
X-Received: by 10.107.59.9 with SMTP id i9mr64483275ioa.176.1481194325536;
 Thu, 08 Dec 2016 02:52:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Thu, 8 Dec 2016 02:51:35 -0800 (PST)
In-Reply-To: <CACsJy8ANNz6FsJ4_5MOhj2Qqd+wHHu5UpVOAobqEiHU2KM26eg@mail.gmail.com>
References: <20161208014623.7588-1-sbeller@google.com> <20161208014623.7588-6-sbeller@google.com>
 <CACsJy8ANNz6FsJ4_5MOhj2Qqd+wHHu5UpVOAobqEiHU2KM26eg@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 8 Dec 2016 17:51:35 +0700
Message-ID: <CACsJy8DMhC7Umnqf+-ViOBKn46Emtan4647=MDdLoYXVNB0=6A@mail.gmail.com>
Subject: Re: [PATCHv6 5/7] worktree: add function to check if worktrees are in use
To:     Stefan Beller <sbeller@google.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 8, 2016 at 5:40 PM, Duy Nguyen <pclouds@gmail.com> wrote:
> Alternatively, we could add a new flag to get_worktrees() to tell it
> to return all worktrees if there is a least one linked worktree, or
> return NULL if there's only main worktree. I'm not sure if this is
> clever or very stupid.

No, this may be better. Add a flag to say "returns linked worktrees
_only_". Which means when you're in a "normal" repo, get_worktrees()
with this flag returns NULL. When you're in a multiple-worktree repo,
it returns all linked worktrees (no main worktree). I think I might
have a use for this flag in addition to this uses_worktrees() here.
uses_worktrees() look quite simple with that flag

int uses_worktrees(void)
{
    struct worktree **worktrees = get_worktrees(WT_LINKED_ONLY);
    int retval = worktrees != NULL;
    free_worktrees(worktrees);
    return retval;
}
-- 
Duy
