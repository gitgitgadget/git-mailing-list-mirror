Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4B0391F597
	for <e@80x24.org>; Thu,  2 Aug 2018 16:27:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726828AbeHBST1 (ORCPT <rfc822;e@80x24.org>);
        Thu, 2 Aug 2018 14:19:27 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41706 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726580AbeHBST1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Aug 2018 14:19:27 -0400
Received: by mail-wr1-f66.google.com with SMTP id j5-v6so2729316wrr.8
        for <git@vger.kernel.org>; Thu, 02 Aug 2018 09:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=8mi+bPMZvsf1nP/EYJemsIqtWtrUcHDNpUZ9EguC3SE=;
        b=XnE363GvUSX+u8sIAxglMFvAh20ISe1+vwlkQBXVXOpcpm6ZZfSuHyNFfsdhiqK8Po
         3paz22o9bBX52vSN0UNm45tFycVmMrlnu2qHC87fi1eJ5GVtgPAjNrzY2CmcSInPFkrv
         L9FzR+cakWzyHHtgl1BlfX9WDmUmdZVHVpZmw5dimb7E+YW9M0F07XtkbLyjyf6BI0kY
         fQbjV08I0jy4GRjKslTqOxd3vhpqIlcO8JVRShQQNW5x43RvokCmgx5PYuio6m70YYOZ
         WKfHB8AOtGhsbkiV1o/B19fxFHGd9+by6Q8bycCi4TKb4AoPHsjIPJF8S+Z88vpnl/cD
         zWgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=8mi+bPMZvsf1nP/EYJemsIqtWtrUcHDNpUZ9EguC3SE=;
        b=Qpl1OgxonzKrZASmNDhtGA8h4OoL9c8IAhjacBxzV3HqlrZmLd8yFN5j98LgVJIQ86
         xxtPT+oIRoQzHl6bYDReHPL09gfH1zF/4lGq1G3Ox6DAmfh5eL+r+pXKooje8CyGFAXp
         lulqkVlMsYnhkhclfUEMVzFS5IqjjbfD08TZphwLAR1tUPLtvgRXag6Ld/H4WOoVaD0g
         kmcSfXJmZP2hEJon3rDvW3jKg/BTiL5fk4brITv4RQ0bp7FUas9JavQZ9qKm/eHH0GYa
         1Qs/8DZ19+D8HqyVTb67Wg8m+01zyfhm06NfkyhxUAvBCbszJobaVMifJcrg9pCDNfms
         9lKg==
X-Gm-Message-State: AOUpUlGjJ7wzoapqjfs6mXHUqJIcE2jGegmnCUvULGkNjrpcBDqA2DFI
        wVfgVQbsB3Twhhe0xjiWnuM=
X-Google-Smtp-Source: AAOMgpdyTndQoNqtyTsmI2ZBxrz5Kn/e3vszkUEixTlUBZXr2p3FXC7swJxH097cQ75bZA6dVKIrzQ==
X-Received: by 2002:a5d:4007:: with SMTP id n7-v6mr124023wrp.258.1533227252947;
        Thu, 02 Aug 2018 09:27:32 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 31-v6sm3369120wra.26.2018.08.02.09.27.31
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 02 Aug 2018 09:27:31 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?Q?Pawe=C5=82?= Paruzel <pawelparuzel95@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH/RFC] clone: report duplicate entries on case-insensitive filesystems
References: <20180729092759.GA14484@sigill.intra.peff.net>
        <20180730152756.15012-1-pclouds@gmail.com>
        <CABPp-BG+nB+ifRbCdMpXnnxQ+rzhM8W-=sfQf8TYmXvuPy5WXg@mail.gmail.com>
        <xmqqo9enb4n9.fsf@gitster-ct.c.googlers.com>
        <20180731192931.GD3372@sigill.intra.peff.net>
        <xmqqva8v9nc1.fsf@gitster-ct.c.googlers.com>
        <20180731203746.GA9442@sigill.intra.peff.net>
        <xmqqin4v9l7u.fsf@gitster-ct.c.googlers.com>
        <xmqq1sbh7phx.fsf@gitster-ct.c.googlers.com>
        <CACsJy8DFX2=CaTomc33uuHQ-nBvgfutVbaQ2DxT_p8-hzj6PsA@mail.gmail.com>
Date:   Thu, 02 Aug 2018 09:27:31 -0700
In-Reply-To: <CACsJy8DFX2=CaTomc33uuHQ-nBvgfutVbaQ2DxT_p8-hzj6PsA@mail.gmail.com>
        (Duy Nguyen's message of "Thu, 2 Aug 2018 16:43:53 +0200")
Message-ID: <xmqqpnz03f9o.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

>> But even if inum is unreliable, we should be able to use other
>> clues, perhaps the same set of fields we use for cached stat
>> matching optimization we use for "diff" plumbing commands, to
>> implement the error report.  The more important part of the idea is
>> that we already need to notice that we need to remove a path that is
>> in the working tree while doing the checkout, so the alternative
>> approach won't incur any extra cost for normal cases where the
>> project being checked out does not have two files whose pathnames
>> are only different in case (or checking out such an offending
>> project to a case sensitive filesytem, of course).
>>
>> So I guess it still _is_ workable.  Any takers?
>
> OK so we're going back to the original way of checking that we check
> out the different files on the same place (because fs is icase) and
> try to collect all paths for reporting, yes? I can give it another go
> (but of course if anybody else steps up, I'd very gladly hand this
> over)

Detect and report, definitely yes; I am not sure about collect all
(personally I am OK if we stopped at reporting "I tried to check out
X but your project tree has something else that is turned to X by
your pathname-smashing filesystem" without making it a requirement
to report what the other one that conflict with X is.  Of course,
reporting the other side _is_ nicer and I'd be happier if we can do
so without too much ugly code, but I do not think it is a hard
requirement.

Thanks.
