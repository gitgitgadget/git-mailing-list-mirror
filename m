Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4D6E1F404
	for <e@80x24.org>; Fri,  9 Feb 2018 23:12:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753144AbeBIXMW (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Feb 2018 18:12:22 -0500
Received: from mail-wm0-f66.google.com ([74.125.82.66]:32805 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753114AbeBIXMW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Feb 2018 18:12:22 -0500
Received: by mail-wm0-f66.google.com with SMTP id x4so643076wmc.0
        for <git@vger.kernel.org>; Fri, 09 Feb 2018 15:12:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=KHF/h206nvY7IGctztP5abmEiwMZVDDtTOBHT6/T3I4=;
        b=YD0LQ8ILiL0BIggZO00Kp+ZgVTNYizUt4UKV+92FlZN/Ox8y8rIsmOETPw/9Hv80Bq
         d4rLsA/XLzw+D82WZ6gu+fCiIKCh5fdKzzyoSf8KCtqI5IcT87KFvXlr3vC4OkK/W9qq
         hJsFyYyiMVb/Bkfh0+NsPUaVwDipgacWAAHRSYcka+Att7VXPxRs2TB+8sVJYjNPyMht
         GjeLK0ZFxRH0skRK1PojRPE22D+wq4hohjH/CJVLtXXIUqM9sd6kG41ma16JNe97JooJ
         8D/Wp/5qDZbG1q0Cl4knXhYoiHr+53mcUaaFoodVAnHfT1HbRkzJQ+jjgPp/MWZI0Ujz
         m0Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=KHF/h206nvY7IGctztP5abmEiwMZVDDtTOBHT6/T3I4=;
        b=st60LA45ZRuqWIFIPIE9ksg2teBPwN6CCm1Jn779sClO1Yc2nKVHK2euM0ZyFjsiyk
         1tOoAuEtJpdbHGyK4G5J0kA1heO20vFA6tu9WJ+1MRz3DUA2nTL4pi7eesgSRjziNVjl
         LjyIuNTa/xio7TmFW56/zh+lKEooPOTU7VOoBVj5gnaj8a4TuVqd4kVx2wXCfkzVxtma
         Ojv//VSoAJJBOfnoam9PhT71vlAeQkwYAxQ8qUyvWVQlm7IH58XXHyXmVED8I4EDcUcJ
         R2t1v3UowuLTjPfe6oNqA5IjdG04F3v7xwsd7+ad/M0cvPN5ZG2uF6LaOSOKIU59xluk
         ldig==
X-Gm-Message-State: APf1xPCCZYb2t2xvrlzbl22SeV60kYlxV7HP0QgH8SnCGbsAEX1JikGv
        0dWCgkEqg1OkgxyrXY8wvZw=
X-Google-Smtp-Source: AH8x224S5UtFoOIaYdfMAJIHVGsJu/oiguXP56n240lBi7mMUmWj/NzmZgOvVty6uEyC0xwQsVCgDg==
X-Received: by 10.28.69.65 with SMTP id s62mr3352231wma.78.1518217940448;
        Fri, 09 Feb 2018 15:12:20 -0800 (PST)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id j132sm217939wmd.38.2018.02.09.15.12.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 09 Feb 2018 15:12:19 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 042/194] object-store: move alternates API to new alternates.h
References: <20180205235508.216277-1-sbeller@google.com>
        <20180205235735.216710-1-sbeller@google.com>
        <20180205235735.216710-22-sbeller@google.com>
        <20180206014457.GE7904@genre.crustytoothpaste.net>
Date:   Fri, 09 Feb 2018 15:12:18 -0800
In-Reply-To: <20180206014457.GE7904@genre.crustytoothpaste.net> (brian
        m. carlson's message of "Tue, 6 Feb 2018 01:44:57 +0000")
Message-ID: <xmqq4lmpvju5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> +#include "strbuf.h"
>> +#include "sha1-array.h"
>> +
>> +struct alternates {
>> +	struct alternate_object_database *list;
>> +	struct alternate_object_database **tail;
>> +};
>> +#define ALTERNATES_INIT { NULL, NULL }
>
> I was surprised to find that this patch not only moves the alternates
> API to a new location, but introduces this struct.  I certainly think
> the struct is a good idea, but it should probably go in a separate
> patch, or at least get a mention in the commit message.

Yeah, I tend to agree that splitting it into two patches may make
more sense, especially given that this is already close to 200 patch
series ;-)

