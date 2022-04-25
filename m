Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FBB5C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 07:03:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbiDYHGD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 03:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234687AbiDYHFv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 03:05:51 -0400
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F2621827
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 00:02:47 -0700 (PDT)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-e2fa360f6dso15140782fac.2
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 00:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vwe0Yz2lP+SvXxGZSQBc6I3N4N+RM+Ipetg+tV/j+SI=;
        b=E2aJjbw1HNP+4PwXJ2e6XA94zuJeXtrMHxtpQD2a9C2CIUfahpSoqyDXLqxpkywfso
         NpnlI0PbDW+6eqXM/Rp2bbw2lu4tHm7I+H+/1U51do3dKHBn187KwRd7FyMv07HRvbgn
         glk7EVrXyd2D9jzCZmaghZ+54XJKoZNRPr/A6BQN9mc7oQHq4O6OYCFGp4GdiRJyFwL+
         V/a/oOUklZ9Xsbkj6HulkdoBML+ZuPKU1C+kaK+j6oW0N/OBLRdNt4uT4QLfymTRIu65
         gs9xHXj+kbJapgQ8Yoo2EFM8HI3Ir8gHML4TgZSZo3MC6+uTcrvnevZS/9QlgmVmbKr0
         9oAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vwe0Yz2lP+SvXxGZSQBc6I3N4N+RM+Ipetg+tV/j+SI=;
        b=n8nzoJStVAWsRnD7B8sjCQKwFV/Rdj2GfInQZ0eLRRZXi4DfC4YfgwzmGrvmNQFrka
         OtEzokhp0MxuYDD+0+jPmGAcyWOIBeoNkMaAPje/ujq7UOLWO7+oTlfK+Q3k3yRQFxin
         YjUBg2d7JrazaqUJBNa1wrYu00+sRm+nSqODA4iIUSQXKLhRGZGwAT5qjd/ED0bFreS3
         BQQOkx0XsOErnxpljizQOoAgsMtR5ugrDpfv/loaVohNvgoNabk+hnKR1N6zcTkHgbd3
         qvQTYvnVQhOPkKmsos3XX8dNeWyUCDZ0darv7qfCq/zqDsJNHwHREMbjM0rAHodf4J1l
         nQfA==
X-Gm-Message-State: AOAM530huyVwm/KOb/+8OkliQPdFYz2s7aWAuzM05BrIOmRu8GmLybfp
        eMluVdnJZpKLdkZtwpX/7MI=
X-Google-Smtp-Source: ABdhPJxwuEr94XdvblBND5oSHBCVfGgn+2qYQ+bQCRiXNPwfrp6UVplams+HnEStQp49lPZN3/cZwA==
X-Received: by 2002:a05:6870:c0c1:b0:e6:8304:6527 with SMTP id e1-20020a056870c0c100b000e683046527mr7007785oad.232.1650870166915;
        Mon, 25 Apr 2022 00:02:46 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id e3-20020a9d6e03000000b0060553db58bbsm3517122otr.36.2022.04.25.00.02.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Apr 2022 00:02:46 -0700 (PDT)
Date:   Mon, 25 Apr 2022 00:02:45 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Guy Maurel <guy.j@maurel.de>, git@vger.kernel.org
Subject: Re: a problem with git describe
Message-ID: <20220425070245.ta6wibzkezlfwzxp@carlos-mbp.lan>
References: <4ef9287b-6260-9538-7c89-cffb611520ee@maurel.de>
 <3d762060-b817-0246-c4a2-8eb35096cb7f@iee.email>
 <xmqqczh73hns.fsf@gitster.g>
 <xmqqk0bf1i12.fsf@gitster.g>
 <20220425020108.5agdq6bdg6umrtbt@carlos-mbp.lan>
 <xmqqy1zty8dc.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy1zty8dc.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 24, 2022 at 11:39:27PM -0700, Junio C Hamano wrote:
> Carlo Marcelo Arenas Belón <carenas@gmail.com> writes:
> 
> > At that point, though you might as well excempt root from this check
> 
> But "root" or any higher-valued account is what needs this kind of
> protection the most, no?

correct, and I didn't meant to excempt root from the protection, but
from the check that requires that the config file ownership matches.

if the config file is owned by root, we already lost, regardless of what
uid git is running as.

FWIW the proposed change doesn't weaken the current protection, it just
allows a git process that is running as root (through sudo) to figure
out what real user was the terminal session running as, so it wouldn't
incorrectly triggeer an error.

> The protection is *not* about people
> knowingly accessing their own repository via "root",

nope, but the regression that was described by the original post is

Carlo
