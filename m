Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25B3FC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 15:48:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349616AbiAKPsU (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Jan 2022 10:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235534AbiAKPsU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Jan 2022 10:48:20 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BD0C06173F
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 07:48:20 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id f4so6409985ilr.9
        for <git@vger.kernel.org>; Tue, 11 Jan 2022 07:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=SIBhW+bWOdWYvT7NfR0GRdVewrF/1PORSCFj3WbV8Fs=;
        b=ax96Sd4BitkfLJONiRoHS5OPac54PPvW2KkXihQ77tr7eC0idP85WPwd57x3xnjp1V
         W/jHVkSakXHK0v/5YdqH+dGMj9ny+d41Q/TscGKGh96KYdN0WCLDJz7X/Y0Aqw4C1HFm
         ie5QhBs+7vBOr25hwYiRnA5+2qW84kpYD48XcT3DyqbyxjM5NNgPkM4k9Cu82zSqjsen
         IeKeN024hQEJ4NxLfnu76XDiZ8kmAci71nacbNg7CwXn7NNTqSfDWAETsbCrZbmslFVP
         6iwoOUAd9HjYWTp5GUzwL9u6Zj//IZLNHTh0zlI9hUc9tASkObcB8JQvbRgk9gwE6rdm
         t5Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=SIBhW+bWOdWYvT7NfR0GRdVewrF/1PORSCFj3WbV8Fs=;
        b=L4yz/uCKiqb3Xxz6hlnFOSTovInvNpCXhaSphHQTZXTdmeQKhPX9wFFbouCPxPp36X
         B9OFPmUvDmg//yfbZ9iiEdV4qcC7bf8u4kiohSrjrIBk13UKjSNiJhw2nsPv1rtlcuRG
         u8G2DDTkun+ea5/Ij3W29M+SU1M3uJ6Fa3N1WAw9keo3zt4vVtrxM69uAzGBJt16wZXO
         +6LAyHRumJ1vBhocqSjEozIg4ebjwn6cYd1S6FsZ9soxmTO/mS6oeVERscNenFVKSKkk
         JqZBCEjmOw7TfIj55QkjG2h4u1QyFiPiq4be8su5hxr2hXD9bOyiH7MwBmzhOQLmhWe6
         U9jw==
X-Gm-Message-State: AOAM532nPu0eEOquigif0II0XOXGCe5BGw2wyTaM3XQzj1DihBEPL4+P
        zGuLXJynCkIEdHv0tPFtksIPqA==
X-Google-Smtp-Source: ABdhPJzOw8CHN3CSNXwKY+DaFj7Ow/Y+U4eUz8eBhllKqpy04HUXvinqCWlqZtFUzYDYZMS2vsfOZw==
X-Received: by 2002:a92:ca48:: with SMTP id q8mr2552728ilo.177.1641916099440;
        Tue, 11 Jan 2022 07:48:19 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r8sm5837144ilb.19.2022.01.11.07.48.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jan 2022 07:48:19 -0800 (PST)
Date:   Tue, 11 Jan 2022 10:48:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>
Subject: Re: [PATCH 0/2] fixups for issues in next-merged ab/cat-file
Message-ID: <Yd2mwoHd6mNrh+06@nand.local>
References: <CANYiYbEYgSCx230S29zVhMKb8J8WQ1ScxVHn6fMvdhPOdjpBCg@mail.gmail.com>
 <cover-0.2-00000000000-20220110T220553Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.2-00000000000-20220110T220553Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 10, 2022 at 11:08:44PM +0100, Ævar Arnfjörð Bjarmason wrote:
> This series goes on top of ab/cat-file, which was merged to next in
> e145efa6059 (Merge branch 'ab/cat-file' into next, 2022-01-05).
>
> The first commit addresses an issue Jiang Xin raised in
> https://lore.kernel.org/git/CANYiYbEYgSCx230S29zVhMKb8J8WQ1ScxVHn6fMvdhPOdjpBCg@mail.gmail.com/
>
> The second fixes a typo of mine when referring to an option name that
> I spotted while preparing this.

Thanks; both of these small fixes look fine to me.

Just ACKing in case this topic happens to graduate to master even though
we are already past -rc0.

Taylor
