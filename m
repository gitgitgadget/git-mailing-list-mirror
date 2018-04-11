Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4E01E1F424
	for <e@80x24.org>; Wed, 11 Apr 2018 09:57:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752172AbeDKJ5e (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Apr 2018 05:57:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34610 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751819AbeDKJ5d (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Apr 2018 05:57:33 -0400
Received: by mail-wm0-f66.google.com with SMTP id w2so24934662wmw.1
        for <git@vger.kernel.org>; Wed, 11 Apr 2018 02:57:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=O8CVurnkIwSJtABfHkA2PoSaU4h4RA/pKvkwPgjYb6c=;
        b=I3B/14Yy5slwL3PN39vEFc5OM5d+SNVCGLgh1zhVJ8sPRsgnHYrsej7na3bse9zd78
         MhjNLO1n8WT3crc/yY/SsNlvMlZj5ap5Tja6cavbaYpxIK9Wzp6MoxchtNttxcdqLbtH
         Jv9iveHPxa6XXI3lnSYWB0whmAxUoxLYQBzo9M/0BKTeiz0pyzNIf8gIaobRFr0qgKmi
         wsdxL2xPGDmP2AMv7jC0Saf6H1bfLkDU2vR8TJaQsDqYfJk6H2TFjNK0OgqUJUyV+ud0
         cw7agax7Q/GFJUsQ/Ahag0Kzy2c6mrTij5PiyZJrZ9V1P92YkxvysJTvszZBoOE98RJG
         ctKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=O8CVurnkIwSJtABfHkA2PoSaU4h4RA/pKvkwPgjYb6c=;
        b=qyGkHALtakRXd9bL8nHvv1bcBtVkNXANi7ifPv5dgSmm6X26BfhCky08LV1AgpobHN
         SLK8P7twQ9oA7MsbKc9vX1diplaJF/Ymq0nVhxJs4kbP4Y3WldJGVK42p0F3SiX0PgVJ
         UpCluxZt65G16UkC34L/1NsuzCoW/kNFkcZP0K1apipwlaxLqvBZYT4sOI6HYgoxe3fA
         kBNeZhXh1LuPvizaFFokfpFXpcIjqyt1cokfviOiQZyanhdWFng5+Ur2Xr0RmVdOt2Va
         UHVzj9O3xq1ZxVgrcoMGnHlwjXrDJsR9jNkNisjtiwX3YCWAHSfmCfDjgG+Zf34rOrfK
         nP1Q==
X-Gm-Message-State: ALQs6tDy+6xlUtFVxssH/DtoHZcFgiAoF20yL8Ytif0/CxifZEVb1rHS
        6RsWd/egOKjyZuu7n/t+LVs9oVpC
X-Google-Smtp-Source: AIpwx4+PdKyv0fiVnDZswlnWS2XGwpV1WrV4eHqsY9cYhPm/aMPpQnJ7UIo5w3VvsSmydF2mhPDY1g==
X-Received: by 10.28.113.197 with SMTP id d66mr2044027wmi.67.1523440651446;
        Wed, 11 Apr 2018 02:57:31 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j3sm3764834wmf.23.2018.04.11.02.57.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 11 Apr 2018 02:57:30 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>
Subject: Re: [Git] recursive merge on 'master' severely broken?
References: <xmqqmuya43cs.fsf@gitster-ct.c.googlers.com>
        <xmqqin8y3yf1.fsf@gitster-ct.c.googlers.com>
Date:   Wed, 11 Apr 2018 18:57:30 +0900
In-Reply-To: <xmqqin8y3yf1.fsf@gitster-ct.c.googlers.com> (Junio C. Hamano's
        message of "Wed, 11 Apr 2018 18:06:10 +0900")
Message-ID: <xmqqefjm3w1h.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Another interim report.
>
> I do not yet know which one of the ~30 individual commmits is the
> real culprit, ...

It bisects down to c5b761fb ("merge-recursive: ensure we write
updates for directory-renamed file", 2018-02-14); given that a part
of the symptom I saw was a few messages like these:

        ...
        CONFLICT (content): Merge conflict in upload-pack.c
        error: addinfo_cache failed for path 'sha1-name.c'
        error: addinfo_cache failed for path 'sha1-file.c'
        Auto-merging sequencer.c
        ...

and the patch does change code around the callsites to
add_cacheinfo(), it does look like a plausible culprit.

