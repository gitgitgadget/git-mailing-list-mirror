Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04538C433FE
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 05:19:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07D06124B
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 05:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234949AbhJPFVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 01:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbhJPFVw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 01:21:52 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A35AC061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 22:19:45 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q5so10475070pgr.7
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 22:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BHzP2Jckeldw6h4XkaR3SKxLCtNUeSi8Rni8F6ZweDs=;
        b=YKgFjmG+1Cb9F/nWvGMkfljewm2higEHUFW6iImRZP4gPqwgKdA0AddiqjBS/ZfUiK
         ApczLOJf5EWOf9PArpn2b3zR/RlhR5m9c8vGLPeqieoODt2SGL2ZGCeIXfM8FYQviOz9
         Ox6YJs6CAM1cK0Q7tgQ7jhD/rDPEofw8wk12KWA9iy6W4NgvZhMzr3SrKQ9KvWe6ibcI
         txU+rIFhQJ3fg3/1/Rm/gNJtkXTetlms3CeCM4JAYBqI8jm0WJMWAbQGEJ6jeRnwV96e
         qOrZ0zOutqScHLBaqUQ1APsRpvkSzmvBBN1iPItXqalsFCx2dGijVCPGXQQHvtSiLOEE
         hBlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BHzP2Jckeldw6h4XkaR3SKxLCtNUeSi8Rni8F6ZweDs=;
        b=Yitke/dyuhVyG5GyzPO83+cKZhuOf99WYcbRJd20+fJv6i73irlkNh8PiOceoQ+RA6
         DWeTudyun9sKs1fpSTA29ATF9EGSvDD9A7q+CDnuH4QK3etixqwP9UXaCJlHkICpQtjg
         17TtGDEJSCwSZ4wLO+ZzZtqMz1RNylyV4XaMkZ56Gq+obzpxBWj3MUEd1Ke8DiygG/Fl
         Sz3VfkL8QCRpqFuFUT2qZADLSZmoCdcSkhVlNLJ+hvsILuPFcCqwdgHVyLdgWMJnfJzE
         N4vV2MXs767LOJWxConGo02bbLQKQSt5yJ/qGDjhjr8DyII5R2ncPDyQX1K13DHj0jy4
         MEcw==
X-Gm-Message-State: AOAM532Aq4vE+fEeNDvuM8RfYS8rmbeKdhK/02Yza0uPv+vmyr5s+VWx
        PuILf1SSrQiWCDbiVB8/x68=
X-Google-Smtp-Source: ABdhPJyrAGqt8SkkbKhR19DCMcEvg5aUh9sZll5mDuMRJJANJXmCr+4EPnmC4CjjcpwNzShlIGa0Pg==
X-Received: by 2002:a63:9819:: with SMTP id q25mr12496076pgd.300.1634361584325;
        Fri, 15 Oct 2021 22:19:44 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-79.three.co.id. [180.214.233.79])
        by smtp.gmail.com with ESMTPSA id oa4sm6670251pjb.13.2021.10.15.22.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Oct 2021 22:19:43 -0700 (PDT)
Message-ID: <b28a55da-c74b-8061-108f-10f9df2c0d6f@gmail.com>
Date:   Sat, 16 Oct 2021 12:19:40 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2] archive: rewrite description for compression level
 option
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org, vagabon.xyz@gmail.com,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <20211015121336.46981-1-bagasdotme@gmail.com>
 <87h7die9jj.fsf@evledraar.gmail.com> <xmqq7dee8c5v.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <xmqq7dee8c5v.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/10/21 23.50, Junio C Hamano wrote:
> I do not think it is a good idea to remove the backend-specific
> option section like this patch does, as the next archiver may not
> even support `-<digit>`.  Even with the existing two backends, the
> description of it need to be different (cf. the other response I
> sent you last night on "--fast/--best"?).  Rather, the first thing
> to improve would be to _add_ a section for `tar` format, next to the
> `zip` format, I would think, as those who wants to write `tar` do
> not have to read `zip` specific options, and vice versa.
> 
> The new paragraph on `-#` in the patch may work as a replacement for
> existing explanation for `zip`-specific extra options, but it needs
> to drop the changes made to make it applicable to any format, like
> "depending on ... backend" and "(zip only)" if we want to take it.

In current situation, both zip and tar backend supports the compression 
level option, so it will end up duplicating description of the option 
for both backends (with slight differences).

-- 
An old man doll... just what I always wanted! - Clara
