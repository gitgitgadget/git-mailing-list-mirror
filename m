Return-Path: <SRS0=iCZD=ZT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDF1C432C0
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 20:09:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0FF992084D
	for <git@archiver.kernel.org>; Wed, 27 Nov 2019 20:09:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+hL2O4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727377AbfK0UJQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 15:09:16 -0500
Received: from mail-wr1-f49.google.com ([209.85.221.49]:42921 "EHLO
        mail-wr1-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726984AbfK0UJP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 15:09:15 -0500
Received: by mail-wr1-f49.google.com with SMTP id a15so28220772wrf.9
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 12:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SxVqECCRPuXfYPEB5u9HB4S2YqDnPUNaSEmUWWB4ozc=;
        b=Q+hL2O4Wir8gGnH755xAdbEvv5rcVG0/fu3kE7UYDnEwefoGA/jbqm/sst0zwE+6ki
         04RJAFi8PIh39WtxcvazNUTiQxsFyG4N33uBrQr6YYZ4+SnnY8PMVKmmM2ouTWDmbEJp
         pCXILaPx4irKGku/QCJpd6DF7UhVf6kylc3SHJKNnOzAZcq7PHVFKChGsaotyPVzvUIo
         uR9R06M2RNeicGBroqa9tQAT/cu318vvv4Ndikl4OO1I+YH4VjDbi3tDHQf7+8EiDDY0
         aoCr4avovXybP0TlGhldk1els7NiqIP2Kj5KivFxpd4erS5PdO+orz3joBs2lWQpa8QB
         HhKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SxVqECCRPuXfYPEB5u9HB4S2YqDnPUNaSEmUWWB4ozc=;
        b=GPwOAmo8FB+PjPTs+df+SnX0vTYW3SzcKTz8UcmQjSq3S0h85sA5BMD2jfYDYcMvuQ
         CqXG5OwyPHBrLboMpiuXJEJ+QF0BiKtv1jfdFYbCPplc0LY1crJAbS4mTQTdWni501LP
         zwq5DdtBfGX7D8zyTCyyKzsghxR+CC+uD3BZTgKtCavjDtMBm8qR83gDaMmQwnHwAKIJ
         Dtydo75PBRmXoC2j1FVuJw3nHlSc5xSkJuwtyceWypLxqyTOGj5xob40x9rRfo+Bm9Ea
         +Zo0bgJQXNEonvr2+3O40i2VvHHMZTdbiipIl+xcoqtGmNk2Rl0DcG9drEUS1W4E6xp8
         NeTQ==
X-Gm-Message-State: APjAAAXEUdKBU6t2jaQQZRxabTJ+HjdpRES3sDnPe7S16feFqkJeCpw6
        h47WhvEpTv1ZKG6/IQyKq4o=
X-Google-Smtp-Source: APXvYqxNOH36pEo/Pr17KVCH0Ja0oakBDjSNuokRz5YV2h6/1KxDIf+mUFZNDxv0wXv3Yc+Y+mfTrw==
X-Received: by 2002:a5d:526f:: with SMTP id l15mr43506666wrc.169.1574885353932;
        Wed, 27 Nov 2019 12:09:13 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-110-106.w86-199.abo.wanadoo.fr. [86.199.33.106])
        by smtp.gmail.com with ESMTPSA id z26sm5976084wmk.33.2019.11.27.12.09.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Nov 2019 12:09:13 -0800 (PST)
Subject: Re: [PATCH v4 5/5] sequencer: directly call pick_commits() from
 complete_action()
From:   Alban Gruin <alban.gruin@gmail.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de,
        phillip.wood@dunelm.org.uk, gitster@pobox.com
References: <20191124174332.30887-6-alban.gruin@gmail.com>
 <20191126184103.146421-1-jonathantanmy@google.com>
 <aa162f9c-9ae8-9844-6829-7fc0d9c50f9c@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <2ee284b6-461e-dbba-2583-cffc38e95df2@gmail.com>
Date:   Wed, 27 Nov 2019 21:09:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <aa162f9c-9ae8-9844-6829-7fc0d9c50f9c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 27/11/2019 à 20:56, Alban Gruin a écrit :
> Near the end of complete_action(), the todo list is written to the disk.
>  The destination is obtained with rebase_path_todo().
> 
> read_populate_todo() will read a file and parse it.  In the case of
> `rebase -i', the location is obtained with rebase_path_todo(), and only
> `total_nr' will be modified to contain the number of commands done and todo.
> 
> In the case of a new rebase, the done list might not be empty after
> tajjimh skip_unnecessary_picks() from complete_action().

s/tajjimh/calling/

