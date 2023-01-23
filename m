Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 457E3C05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 17:39:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232323AbjAWRjd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 12:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232041AbjAWRjc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 12:39:32 -0500
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D45279AA
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 09:39:31 -0800 (PST)
Received: by mail-pj1-x102a.google.com with SMTP id dw9so12328754pjb.5
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 09:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vefAl+CnLl2XxPZ6TWhOLNPQWV99kEw95Cn4dP5Ck2c=;
        b=Eg6azot6UsDwkxtp7kUVLfTmTa2POpjeeUMrS2jPxYV+JRx33FNVesgMUQOjgeW0pa
         OOUuh/wTDp+UaMmCnh6ZHcUDTizQJzaQmPDnJ40aP7r41e18i81MblwRdtn74XLU2nWH
         OGT7BEIf6YwK/hhr9e2YolA8xqi+oBppWJ9QSGERz3swWo3sGphxHGxKFkQFppsVNyO6
         jKnRLDAalqL3MZoa5f7kytOQo2yCh33iQSfHBzWF+l//axgIChrc468v7oHQ1vguDEhT
         JZzV6Xb6uMjPOszKVI9XPRZvPUptiIdN0xpPRPfcrvZvwa5+uMcbSV9dO5n6/khOHgow
         U/Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vefAl+CnLl2XxPZ6TWhOLNPQWV99kEw95Cn4dP5Ck2c=;
        b=2Wgl4ey88NALVcRx1vd6j4trLpt4HzaTkFnETMMI9IQDEu4Rktry9D3BIHHdczbuXd
         eAUpT7VlQo/doxH5f8T0DsQirYE7j25Fugwvb3qZWsdzTKn0ijOdvHowGoMmIXlSAcYH
         an0PTgdnmqEkmcPX4PTWN8xS8I9v7Pt6xy94I/EJ7T8UjsAdZ3uYnQNTRVLaUVz/+hBC
         2U9+oox4luuDXY0wjW0H1EvN0zgqTOWnc2ucrEhbbRkY4TsmYJiu7RXtf6w7eJqD3i4D
         OaTIBwA2WO8wnuonaKwnIVPvxX0fqxM+qBvbal1PTeQ5JEC9UQnRLhIs80ndYERa4XxH
         Ll/A==
X-Gm-Message-State: AFqh2ko7Q6aXF4rLPDLttWZzF//viFE/hL6vjKsn124Q6ndG1Rm1f0ei
        GMkMlcPbfjxDm7zZJ8ejTAXTeOY7Df4=
X-Google-Smtp-Source: AMrXdXurYWPS9zKUO2ykmQM3r5HDYRZ4G06ITbx9/Chp6PD75xoiC1uM/M3Dq5fcIaDl/rgtahq4dA==
X-Received: by 2002:a17:902:bd07:b0:192:8d17:78e0 with SMTP id p7-20020a170902bd0700b001928d1778e0mr25289029pls.42.1674495571145;
        Mon, 23 Jan 2023 09:39:31 -0800 (PST)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id d5-20020a170903230500b001754fa42065sm19367201plh.143.2023.01.23.09.39.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 09:39:30 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Andrei Rybak <rybak.a.v@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH v2] Documentation: render dash correctly
References: <20230122165628.1601062-1-rybak.a.v@gmail.com>
        <20230123090114.429844-1-rybak.a.v@gmail.com>
        <CAN0heSogz0cdhVJdiZhCc2_fcHzJggPjbS0wCAQkRh1uZMxLig@mail.gmail.com>
Date:   Mon, 23 Jan 2023 09:39:30 -0800
In-Reply-To: <CAN0heSogz0cdhVJdiZhCc2_fcHzJggPjbS0wCAQkRh1uZMxLig@mail.gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 23 Jan 2023 12:04:21
 +0100")
Message-ID: <xmqqzga9m9pp.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin Ågren <martin.agren@gmail.com> writes:

> On Mon, 23 Jan 2023 at 10:01, Andrei Rybak <rybak.a.v@gmail.com> wrote:
>
>>  highlighted with a `$` sign; if you are trying to recreate these
>> -example by hand, do not cut and paste them---they are there
>> +example by hand, do not cut and paste them--they are there
>>  primarily to highlight extra whitespace at the end of some lines.
>
> OK, so this is one of the new ones compared to v1. I can see the
> argument for adding some spaces around the "--" for consistency and to
> make this a bit easier to read in the resulting manpage (which can of
> course be very subjective), but then I can also see that kind of change
> being left out as orthogonal to this patch.
>
> This v2 patch looks good to me.

Thanks, both.  Will queue.
