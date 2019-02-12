Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9CEEC1F453
	for <e@80x24.org>; Tue, 12 Feb 2019 02:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfBLC7W (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Feb 2019 21:59:22 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37123 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727137AbfBLC7W (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Feb 2019 21:59:22 -0500
Received: by mail-wr1-f65.google.com with SMTP id c8so1004269wrs.4
        for <git@vger.kernel.org>; Mon, 11 Feb 2019 18:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nfEqfq6gzo9sbWJgB5cMFa02DTS3jGlEz5D3TPnU26w=;
        b=ZalskmYl/K1rrq2Hfj43QhH8GYm/FKqhzKIOgWgIN8D8OtJGXL+/p1CmPAKtQBtFox
         j8VOcwIxqAir/nIhiF/KfCceOiWjfy5jsMXk7wCEDHanxHd9JpFmwWmjsBrys8QOj1Cg
         V4wAzg3JecLrPc6wMIQtJkt0nA47EcS8orHh2WrLIVi0/cBIFlKP/bdf5CZy1YLoamlZ
         +I9vVkN27jWTCwubimrOFul8QOI58M/oDzxeUrO6QM6+x3XlxC6CkTFxOxBVTmHayD8M
         JRmjaUuYu+J+3Fscn0A+uDS2vLgKEtiJOK4TTRhbFtC+o2WOxmqgHKjOJU7HKO/HFVyF
         j1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=nfEqfq6gzo9sbWJgB5cMFa02DTS3jGlEz5D3TPnU26w=;
        b=mswo65smCqSp+KE4Ubr1C5WUmDv1dZwiMR3vp4rHpGD1hzSxGIdJ3ghylFXkCeBGAw
         ANmy5Yw4FnR5sCcxvLNCyOoiGGgqKkHqex4QAngb+nqZiV2EcnfrYLltvyjnBmF/shmg
         7TIt4c8YwuiSyVWJfhggWH9gnp3mZqwGhzIx0yNvvWmF+SZaOUlCGNv19kk+Wy8OFPK0
         6AwIXYwFVIfz+83H/jJ81AbHuWDlTRdIxXdSl3uAMmHLUksrsdqNHtrSrBPjR/LTILmD
         dFQ6CO8BGYRDdm5jJOoQUYhsVZYUCLRSAXMH2PO81ehJb5enDd9sgQlh7nfmkCL9C9ap
         rhxQ==
X-Gm-Message-State: AHQUAuYQ7Db8B0S8z7QmVCgGlRaCzqBMgzxc2A0EuHIYkKVXFtW3Dcv5
        JKNsXwvNVmgpMK25pljV8dTTCnBe
X-Google-Smtp-Source: AHgI3IYope+Nf9LIaNvv6BSDotiA28rkH/9HEBI8FDC3DvDKQQ1f2cqHqPqSKAarrfIAVK/OQSRRhQ==
X-Received: by 2002:adf:eb48:: with SMTP id u8mr950561wrn.198.1549940359910;
        Mon, 11 Feb 2019 18:59:19 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id g10sm20383023wrq.81.2019.02.11.18.59.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Feb 2019 18:59:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     <git@vger.kernel.org>
Subject: Re: [Proposed Fix] daemon.c: not initializing revents
References: <000901d4c0b1$1ea15160$5be3f420$@nexbridge.com>
        <000a01d4c0b1$9ef9ea70$dcedbf50$@nexbridge.com>
        <xmqqsgwugi21.fsf@gitster-ct.c.googlers.com>
        <003501d4c253$05f16fd0$11d44f70$@nexbridge.com>
Date:   Mon, 11 Feb 2019 18:59:18 -0800
In-Reply-To: <003501d4c253$05f16fd0$11d44f70$@nexbridge.com> (Randall
        S. Becker's message of "Mon, 11 Feb 2019 16:44:48 -0500")
Message-ID: <xmqqd0nxg1a1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

>> In any case, no matter what POSIX says, if clearing .revents before
> calling
>> poll() helps on platforms in the real world, the patch is worth taking as
> a fix, I
>> would think.
>
> That's what my intent was - my explanations are suffering from a little
> work-induced sleep deprivation. Would you like this as a formal patch?

That depends ;-)

At this late in the cycle, I do not see much urgency for this patch
to be in the upcoming release (after all, this code survived real
world for quite a long time, so it's only minority platforms like
NonStop that haven't seen serious porting effort until recently that
would see improvement---and they have survived without reliably
working daemon for so long that they can wait for one more release).

Now, the knowledge that we will have long enough time before the
final version of the formal patch becomes necessary makes me wonder
what the best use of that time to polish the patch would be.  Ideally
we'd like to see "this definitely fixed (or 'worked around') such
and such breakages on platform X, Y and Z" instead of my "Well, we
could read POSIX that way, so there may be some platforms that would
require applications to do this, and an extra assignment here would
certainly not hurt", which was the hand-waving I just did.

I dunno.

