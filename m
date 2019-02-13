Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5755A1F453
	for <e@80x24.org>; Wed, 13 Feb 2019 21:00:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731808AbfBMVAt (ORCPT <rfc822;e@80x24.org>);
        Wed, 13 Feb 2019 16:00:49 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:46769 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726189AbfBMVAt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Feb 2019 16:00:49 -0500
Received: by mail-wr1-f65.google.com with SMTP id l9so4073681wrt.13
        for <git@vger.kernel.org>; Wed, 13 Feb 2019 13:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EFbNo916GoKRoO3r9LsZthjsBEGSjDK4zHVqWrOeWx4=;
        b=erYEhHB/2k7viOaIBAzoN2zc02oN3cS7VSZhrk1TRRPcXM6FVJ2wZF49zcshtOfIWx
         HuoRlAWm8gG2QBmQMJYTWu23s8k3pV3r67Uzx8PuO6592FhPFmwUq7No889ikW3evJv3
         MF70p+tXnfWO/H1uSjur72+GC9IGMGp3jBy3Fk2VwNXDKB2+96FPOfIKQSY9QUt9j+6F
         yipRKk6N12VV+FyGhF3nE3u9V1SMsojEcjQwJhwfaPxC2Hrkz6OYIuKieRgPAX197yEw
         tZWH37Pd+AA+LDMv/HSu2efuQI90MHJCewdtCcTvI0fkiOhym/kSXt34CjDRmhAOHkQ7
         2h2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EFbNo916GoKRoO3r9LsZthjsBEGSjDK4zHVqWrOeWx4=;
        b=Z7iWXYdSrkFuh0eMLHdg//Cx+IT6Psk2mU/sFwtVMaRUAVpZTxJHUm6HCYfxXdC1+E
         j9YNXQacEqkZyM6Vii+LD58fqtpQ/CGmKX1LbiS0SNefOLXckcGbkXB8MO5yxf9WClDy
         ocQHFJOqUtCl3ZoZM3vIwOEEqbZF3DPqQrJjE+4Ao3a5kfL2IpYJniMNWffFOB2h/B4+
         ZwCX7gNPupMXHGFyTHvAWpuPYBMtcfNnNjUhwp2x2Z81gS3qOgPuJ691ngEs9FXVvnQ4
         5NF2vMISPtk3r09HotDswN04AJKaTt1SDAFle15WHFiahFv05+nhTf6wUQ7AFD5QGeS+
         t0KA==
X-Gm-Message-State: AHQUAuY6WCEoixyyIW1xxaX564RDvaZSy0mP/aW6dG03nIfm2IIbJfIO
        nOEGa4+OlsYEVKJB0bAhHNw=
X-Google-Smtp-Source: AHgI3IYrpWURqvR1dgTFVrICArAvqdtG/GZurbvmCA5210VYGekeKmAn+sic+avhChHoK6OVLq1BeQ==
X-Received: by 2002:adf:f6ca:: with SMTP id y10mr82386wrp.148.1550091646995;
        Wed, 13 Feb 2019 13:00:46 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 65sm522722wrb.62.2019.02.13.13.00.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 13 Feb 2019 13:00:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     "'Eric Sunshine'" <sunshine@sunshineco.us>,
        "'Git List'" <git@vger.kernel.org>
Subject: Re: [Patch v1 2/3] t5318: replace use of /dev/zero with generate_zero_bytes
References: <20190209185930.5256-1-randall.s.becker@rogers.com>
        <20190209185930.5256-3-randall.s.becker@rogers.com>
        <CAPig+cTMoYMmnHVuay_4RGr_FN-HWC1tN4TPDsNM4vKCH3GzXw@mail.gmail.com>
        <xmqqh8d9diy8.fsf@gitster-ct.c.googlers.com>
        <xmqqh8d7d2ij.fsf@gitster-ct.c.googlers.com>
        <004701d4c3c8$8a018d20$9e04a760$@nexbridge.com>
Date:   Wed, 13 Feb 2019 13:00:45 -0800
In-Reply-To: <004701d4c3c8$8a018d20$9e04a760$@nexbridge.com> (Randall
        S. Becker's message of "Wed, 13 Feb 2019 13:18:31 -0500")
Message-ID: <xmqqr2cbbdz6.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Randall S. Becker" <rsbecker@nexbridge.com> writes:

> My second attempt was to create the generate_zero_bytes function to replace
> exactly what the second dd was doing but not user /dev/zero.

Yes, and I think the patch does that ;-)  It was just the original

    dd if=/dev/zero of=... bs=1 seek=$there count=$this_many

would have been impossible to rewrite with the new generate_zero_bytes
helper unless $there weren't seeking to the end of the file.

But the other dd before the one the patch rewrites truncates the
file to make that seek=$there seeking to the end of the file, so
simply appending output from genereate_zero_bytes is sufficient and
correct conversion.  I wanted to explain that for future readers who
may wonder if the patch is doing the exact conversion.

