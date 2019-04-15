Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69C6A20374
	for <e@80x24.org>; Mon, 15 Apr 2019 02:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfDOCBm (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Apr 2019 22:01:42 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:40644 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfDOCBl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Apr 2019 22:01:41 -0400
Received: by mail-wr1-f65.google.com with SMTP id h4so19700074wre.7
        for <git@vger.kernel.org>; Sun, 14 Apr 2019 19:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=C2aAAqm1dS4QRivo3GYbT295Yu47El7wdaGacwjGMrA=;
        b=G8+/kspyL93t8tLsr1zLQZPvePVWbq7oXuSaTU9dOzzXT2Irn9l4G+ni8bBhirSLWg
         bjUIRXfqa6JOctnFq8NngLwCqnQp8M02muIiJD1lB8ZMFiYT3piMhuYOrLYlz5EeRxnd
         u6SmJYZTA4+3uT/10lcUV6/qKwPJo6hGH4xQGohdFwt2NXTkeKRWIcqGJEBQsXMNxMk8
         tsArCtvX60+da87gbvKGNanFTgpc2b2A9qyQFEZWZ21hA7kwosChj2WMf2zobKbfzIet
         ZmtquUhnsDxGulKyX+0HyMjFmN5fhim3bBg6OnAb7kUzH2SMXLstPuCjm8yBGGnvN7pi
         XkvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=C2aAAqm1dS4QRivo3GYbT295Yu47El7wdaGacwjGMrA=;
        b=CpmAXXW8KnqW8SF8h0qALyfCyv5l/HpFGctYq82lT8LbBMx2W27fagOeda8hpJRnDi
         zYzV/pjdQEI66kxg525F+SPsNRbE0tkqM/ChP9Ds6zbmy/0mKpKqKNS8gaKDVE7sIEw4
         AxbZJd7IgWVLEJTHTlyOiyrTABIqZro+onvQUZL/g5pgEl+dwFMRHaKoYaSXXNe1/eTj
         j/geHU2S4Vp+HhsIIk4t4EWU1V8xkARyS3arSpDJw3gFRAs9W5Zc7LwZNjPn9bCKOK3c
         ypbDzRrVy+AEk4K2hAgKG8lxwCkflRgIfkrrIkk+JOMbwhnexWH/llQksxPQ4i2WPmn1
         pwZw==
X-Gm-Message-State: APjAAAWsK81N5eQkbY9gH45jFq1aRP8htrAW0kFV9pkK0X06fyXZR/Y0
        rbF0SG+ttF+7ytZWR9+xeAE=
X-Google-Smtp-Source: APXvYqwUpyySA6aaGsnP2z5IdVUBpgukYWemoN0HshcXvIf3BWzAR2kilStaSbtPxBeG9YiEJpW0MA==
X-Received: by 2002:adf:fc0b:: with SMTP id i11mr8238462wrr.145.1555293698705;
        Sun, 14 Apr 2019 19:01:38 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id w11sm138400021wre.15.2019.04.14.19.01.36
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 14 Apr 2019 19:01:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Thomas Gummerer <t.gummerer@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: incorrect range-diff output?
References: <20190411111729.GB5620@ash>
        <20190411220532.GG32487@hank.intra.tgummerer.com>
        <xmqqo95bxo4p.fsf@gitster-ct.c.googlers.com>
        <20190414212056.GI32487@hank.intra.tgummerer.com>
Date:   Mon, 15 Apr 2019 11:01:36 +0900
In-Reply-To: <20190414212056.GI32487@hank.intra.tgummerer.com> (Thomas
        Gummerer's message of "Sun, 14 Apr 2019 22:20:56 +0100")
Message-ID: <xmqq36mkvxfj.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thomas Gummerer <t.gummerer@gmail.com> writes:

> I do feel like the filenames should probably have priority in the
> outer diffs hunk header lines though, as we can only add a limited
> amount of information there, and without the filename, the function
> name might be less useful (or it may be not useful at all, for things
> where we don't have proper funcnames, e.g. for documentation).

That's quite sensible.

Thanks.
