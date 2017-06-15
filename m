Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7C73220401
	for <e@80x24.org>; Thu, 15 Jun 2017 19:17:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751546AbdFOTRS (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Jun 2017 15:17:18 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:33817 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750803AbdFOTRR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2017 15:17:17 -0400
Received: by mail-pf0-f179.google.com with SMTP id s66so11617299pfs.1
        for <git@vger.kernel.org>; Thu, 15 Jun 2017 12:17:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KP0s4pO+A+BOKcWsg2pnRvMFnvPjwbdGXhL/+OEQyN0=;
        b=WlKyW3D4fS4paa8Zn3amdONe7ZhebY97jqo9rs7cVVw7p11PpMJXVsfEaEgDEEdqc1
         NwzJHydwad6h68ePkDinuaP096rUEycbDC7S5usgvX3l7cH4IE1+TEMCQaxO34K5trfW
         mDTfxWlyjHhe0wJVABVpIVRufmAjx4OmmV1fUGBs5yBOC0+CIapyEi2agYBKgujF/gYG
         /Cw2F/MCIP6AT/TgOMuIznbSqMdK0nn4BJH8Q6xSQvLmcJl/Vs4MdXZKSFQfJqG2Pxze
         UIPxCQK0E9g292JBKCbz07Ce2zowtqtl51IVEdhRJEaDrOVIECD/xmg1EFifCaKZqhAf
         kJrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KP0s4pO+A+BOKcWsg2pnRvMFnvPjwbdGXhL/+OEQyN0=;
        b=ZCVdPoHrjd/rGVIxDZHTBQIJUSuGbmJXiM3Yu2DLmRcDjQAPPVVHKNe7CdIIof286L
         2HiYEZMM7D6N1HomSHFi6CtI4SyJPhhIztFFJFvIChMNPETPmEVzE9/N240N+/nJyj/6
         EYC1rgIZBOTMFRhdxTC/Zrb3zQsUrCGav8Vdg8pbz883uYG1y/MnwdhcXdJGCeaU78vn
         xYoTPdCqWmGDaa3rZ/0uXUzQ58fiaQnadCBisMn3KlPF28FzX7EfDaXfKyuJhwTHsmY0
         IVXuD0aS4uA5vI4x1zDbj5/iQHyVQvyynQq1Wop+/x/XWrCl/1JNhElRiPLy1kpBOMC1
         P/Vw==
X-Gm-Message-State: AKS2vOxqzkW9lhlcMzRN+z1RvDyrsP0rMDI5W8I89WyODfJ167f45RAR
        W7dKEH+NDaJKuw==
X-Received: by 10.99.104.199 with SMTP id d190mr7012344pgc.185.1497554236881;
        Thu, 15 Jun 2017 12:17:16 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:88c8:4433:c52b:12d7])
        by smtp.gmail.com with ESMTPSA id u78sm74799pfd.109.2017.06.15.12.17.15
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 15 Jun 2017 12:17:16 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Scott Baker <scott@perturb.org>
Subject: Re: [PATCH] diff-highlight: split code into module
References: <20170615163055.b63hcivjogafkerq@sigill.intra.peff.net>
        <xmqqpoe512rc.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 15 Jun 2017 12:17:15 -0700
In-Reply-To: <xmqqpoe512rc.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Thu, 15 Jun 2017 12:15:19 -0700")
Message-ID: <xmqqlgot12o4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>>  contrib/diff-highlight/.gitignore                  |  2 ++
>>  .../{diff-highlight => DiffHighlight.pm}           | 40 +++++++++++++---------
>>  contrib/diff-highlight/Makefile                    | 21 ++++++++++--
>>  contrib/diff-highlight/README                      | 30 ++++++++++++++++
>>  contrib/diff-highlight/diff-highlight.perl         |  8 +++++
>>  5 files changed, 82 insertions(+), 19 deletions(-)
>>  create mode 100644 contrib/diff-highlight/.gitignore
>>  rename contrib/diff-highlight/{diff-highlight => DiffHighlight.pm} (91%)
>>  mode change 100755 => 100644
>>  create mode 100644 contrib/diff-highlight/diff-highlight.perl
>
> Do you want +x bit for the last one?  I could throw that bit in
> while queuing if you want.

Ah, I do not think you want it, as this is not something to be
executed as-is (it is a source file, which diff-highlight that is
executable is made out of).

