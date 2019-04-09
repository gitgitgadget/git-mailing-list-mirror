Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C8F0220248
	for <e@80x24.org>; Tue,  9 Apr 2019 16:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726538AbfDIQqu (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 12:46:50 -0400
Received: from mail-wm1-f42.google.com ([209.85.128.42]:37342 "EHLO
        mail-wm1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726372AbfDIQqu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 12:46:50 -0400
Received: by mail-wm1-f42.google.com with SMTP id v14so4131428wmf.2
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 09:46:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=goLRYJdQeI03T5UaIQj9UrBsI0aZy37S82mtr7/4/l8=;
        b=SZ+r0nEakuwJjllg9f7rrobPqTgONXUL/MuY2JE9TqgOvs+YOh6/wgX9Tev03pNqOn
         TsOTPa/SQ23gVP1km0o51DPfUgU3FUHpMiAvkcx6uM31Fu9w+4iI2ou3aL1J2m4ffw6U
         ynXxa8D7p+tqh695X6TTH31crOR17A0SetFikNW+cLsencBBY7awOJgl/iyBeDIfwYuX
         omX91ePuUQmcJCM3HdOMpd2XEX9sB4A2FfWu9127g5x/mHamYt02xwYRp00B3DEWIrhe
         /rX73B71O5Bcw9ZU3+egzgGG5mZ3c0Ek6VM/0SUyI/Rf5b5l/MwsxU5CcQOiVKTVTUlU
         +nBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=goLRYJdQeI03T5UaIQj9UrBsI0aZy37S82mtr7/4/l8=;
        b=LF19CzaPMT9TfjB2ftxmeFHyAEGMFE9KbRzn/fcb6zHUi0Sk0DDy33X87ikvywdwb1
         bOFMGtCQfPWs8HGCFgg9CoHnxDFCbLp2mblVTjKzdOd/HK9WFcGp1He39s1k6k7KKKdk
         dpgzFXY31yqJxsom+W6iv60o+WuvhDEL7dP+Hz7Km1zEmSNbHEX+9M7meDoJ4o3Uvy5H
         c912P6TwtRF8dDke0DGbLxb5K0uUISfZr7f69SCjnbkKq61bwmq98SQY4vj+CmmXIeiA
         Wzbt+O8kbVoWGgiCWfqfCe90HLau0YzWdPFTwpGLHQlM+hK7ztk53Rul/kd9a1mzMwVl
         i+yw==
X-Gm-Message-State: APjAAAUqt0t7yb152+lSGcCRHUHkaDFiXO+B05Swmtua9WIfhRf9NZps
        kVJM+dhrZaGnj/wc2otxK0Y=
X-Google-Smtp-Source: APXvYqz0qtPKJF7+k9ou7UcZxBfW46sbnYr3qIcSd2M6UaaXrufgWaJbXNItEanG0e+YAuWosfj1rQ==
X-Received: by 2002:a1c:a9d4:: with SMTP id s203mr13209460wme.117.1554828408560;
        Tue, 09 Apr 2019 09:46:48 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id s12sm13135513wmj.42.2019.04.09.09.46.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 09:46:47 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Sven Strickroth <sven@cs-ware.de>, git@vger.kernel.org,
        peff@peff.net, johannes.schindelin@gmx.de
Subject: Re: [PATCH] Unbreak real_path on Windows for already absolute paths (with Visual Studio)
References: <6c7d4155-e554-dc9a-053e-f3a8c7cd4075@cs-ware.de>
        <0f629384-638f-bfb9-89da-ade335e364fd@web.de>
        <950ee9b8-786f-28cd-3e89-ad174fd857a4@cs-ware.de>
        <af640e82-ca1a-9c96-da47-62aaea1cc18e@web.de>
Date:   Wed, 10 Apr 2019 01:46:47 +0900
In-Reply-To: <af640e82-ca1a-9c96-da47-62aaea1cc18e@web.de> ("Torsten
        =?utf-8?Q?B=C3=B6gershausen=22's?= message of "Tue, 9 Apr 2019 18:19:38
 +0200")
Message-ID: <xmqqv9zn2kjs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

>> 1cadad6f6 removes mingw_offset_1st_component from mingw.c which is
>> included by msvc.c. Then the in git-compat.h the new file
>> "compat/win32/path-utils.h" is only included for __CYGWIN__ and
>> __MINGW32__, here _MSC_VER is missing -> that's the regression.
>>
>
> OK, good.
> If possible, I would like to see this kind of information
> in the commit message.
> Thanks for cleaning up my mess.

Thanks, both.  Should I wait for an update that fixes the proposed
log message?
