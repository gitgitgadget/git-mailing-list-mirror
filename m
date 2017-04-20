Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E80931FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 17:27:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941145AbdDTR1w (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 13:27:52 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34937 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941126AbdDTR1u (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 13:27:50 -0400
Received: by mail-qt0-f194.google.com with SMTP id o36so8466625qtb.2
        for <git@vger.kernel.org>; Thu, 20 Apr 2017 10:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=zjKRsP2XFQnjyqa4e2eNI0emVrpMMCuLWimBxqsukSQ=;
        b=kWH+7+fP67benXnfJEDnxKnD66dyu3BMKKB0WvD1p0vE7d42eVjK66Gd1Mqhp5qq+B
         VbnuLqKR2ZpKgWQC8q87nxbqHYPSUzOVRPpjNnim0EvlaoFEmWtjFXkWGdpC15JdKoRC
         n3C53ge4UuzvUe4M46P+OTuOeb7BVCbpTWGUzx67/IzTuAG9M2ajMi0slZUhEskTpdok
         8p7VbEoiVw3aOhKxKsrL3yqlOcxbmGwv9zn4Gj8pN3DoLNlGuRxcaOB5X4uTmdzwXFll
         fBDHC5HUQHjaaal/2DN0DZ+P23In/WRMivNaIYSsy2FdclSL9fC896iMmqddIAYWQYCq
         RgIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=zjKRsP2XFQnjyqa4e2eNI0emVrpMMCuLWimBxqsukSQ=;
        b=JUpK+vh3tUzIw2TzdY0dLtuR1DJC4VcJ3WsBcoh3DkOtyXn8LtmirhC+c2/B0HTYEb
         VedFZ5YlInA9IpAS39MlhkgFweaB/yZHdlDkejgOTfHZkKoiJQ/vevTvIvYJVP/mT87J
         95JtgtkLSkABewhUd1MYJmsNwN/70K/r+yolDANd1T3y2wstp6YnsRLys4Z+So71ZCxD
         RbHVK6OzxI+Cd7EV0yQFZqNZp+0+19qLVVbDc4+bFNPTwWrMrbnOwpFZIFUxmHbrS2Rl
         udPBtOHmJN62grNqfBt9Y+T0uiHNRZKAzbgR/oReSxE1pCbJ+dGdoVrq05YZkH563Kio
         D2AA==
X-Gm-Message-State: AN3rC/5bjeII8uY7esiNmClQWC3x1HEoLY9rt7X3XJRpeJzo2lN4BCmI
        rNhzAHltkAL/NQ==
X-Received: by 10.237.42.29 with SMTP id c29mr10016260qtd.113.1492709269644;
        Thu, 20 Apr 2017 10:27:49 -0700 (PDT)
Received: from [192.168.1.13] ([65.222.173.206])
        by smtp.gmail.com with ESMTPSA id p19sm4577102qtp.36.2017.04.20.10.27.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Apr 2017 10:27:48 -0700 (PDT)
Subject: Re: [PATCH v5 3/8] convert: Split start_multi_file_filter into two
 separate functions
To:     Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>
References: <20170407120354.17736-1-benpeart@microsoft.com>
 <20170407120354.17736-4-benpeart@microsoft.com>
 <20170411161617.fyu5pmzgplscoozz@sigill.intra.peff.net>
 <FD58071A-4DC7-4AB7-8B6B-56B71E715144@gmail.com>
 <20170411193709.w5tz3i3vg5mnnhfe@sigill.intra.peff.net>
 <629B2192-FD64-422E-9361-C182303582DC@gmail.com>
 <20170411200520.oivytvlzkdu7bfh5@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com, benpeart@microsoft.com,
        christian.couder@gmail.com
From:   Ben Peart <peartben@gmail.com>
Message-ID: <c8204d07-ce42-6153-61a6-1a612840d337@gmail.com>
Date:   Thu, 20 Apr 2017 13:27:44 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170411200520.oivytvlzkdu7bfh5@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/11/2017 4:05 PM, Jeff King wrote:
> On Tue, Apr 11, 2017 at 10:01:02PM +0200, Lars Schneider wrote:
>
>>> If you initialize errno to 0 right before a syscall, then yes, you can
>>> trust it without checking the return value of the syscall. I wouldn't
>>> trust it before calling more complicated functions, though. Not even
>>> xwrite(), which may see EINTR and keep going (which is OK for checking
>>> for EPIPE, but not checking generally for errno values).
>> Should we remove all the errno checks here as we don't have any direct
>> "write" etc syscalls anyways then?
> Yeah, you should be trusting the return value from the various
> sub-functions. Usually you'd check "errno == EPIPE" only when you saw an
> error return but you want to _ignore_ EPIPE. This is what
> filter_buffer_or_fd() is doing.
>
> But the code here is the opposite case. It definitely wants to treat
> EPIPE as an error. But that should be happening already because any
> EPIPE we get would come with an error-return from one of the
> packet_write() functions.
>
> So I would say that "err || errno == EPIPE" here can just become "err",
> and ditto in apply_multi_file_filter().
I'll update it this way in the next spin of the patch series.
> -Peff

