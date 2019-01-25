Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C09371F453
	for <e@80x24.org>; Fri, 25 Jan 2019 14:45:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726335AbfAYOpa (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 09:45:30 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42864 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbfAYOpa (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 09:45:30 -0500
Received: by mail-qt1-f195.google.com with SMTP id d19so10889758qtq.9
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 06:45:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p81Enpd2rKBLGRyE201O6Vfx3waJ/O///XIW2wueIRY=;
        b=riiVPqYxCiFBpIrrzLG2fW+DlF/Buv2kSgdCzMsQZlgRfO/38kG8g7eCCAWxwcK5wd
         V64LcnCg0nt03U4c5Vi8wIZzwKfBLUbt9F5qpa+Wj9U5zIwYDXLyluwo9NAfysFfVKTB
         UhNFNDOwAFP72/MUBGpeROsb8YTuMXPl9sABmkJ8FFGa8rQ5sCAxKCvZO6HP3Kfi1kE0
         Ab6XM6rOleN2bDZ/n9I6DqzDznsgpDoX7doq+95Z5+IbR6qU4WSnHb7ohmkd9uUbn13M
         moV+Z79rhY1HdPitxsWdwbxTuL6kcLYCNly/+2GQpDAkw2x7+oG/V73c2x9p7PFdVBhK
         khmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p81Enpd2rKBLGRyE201O6Vfx3waJ/O///XIW2wueIRY=;
        b=uVpnmisMi/ouMcxeZbpa2WAKzdiZFH1pntPBPRYNIAVLdaKwjc7ehGU6lJCrMX3TVr
         U2rtEAuQW5CYGtHQthWC7NUpQR69UMgMD1VYs6YaBjGN6HXEqU3WZkYbmTr2DJuK6JiD
         1x1u8JrmqaIhc/FNWV7RSRrs6a5Xk+mUoDMLQWxwKLyQcMaIea70t8/JF1Io3aNOM8wh
         DpGuKH0Y6c1GZYCNHOL14UGzC+8z5bbUq74KkMLcsL+kBw7z3gX0l8lWQVk6piMYFxtB
         tyvf8Xk0EV7O9wjSAGSTnLH8ouJ/mddbxbJmePHic+2HEbgBbr3/DY5t8l4DcYSaf6yM
         44aA==
X-Gm-Message-State: AJcUukc9lW8jNJEBy4phnWThH2xuBKfNbFx6GAsAGEOyhLsBp+dBw1AJ
        VZIUl+3l4DydNLxfSHqt51c=
X-Google-Smtp-Source: ALg8bN7ZmGcrDc2MsGvh+NEBatbHhuP4qyBxQtbPsddqV9+qRUQadSl3FeIkdX6Awa9Rx6dYypts6A==
X-Received: by 2002:aed:3b25:: with SMTP id p34mr11155005qte.310.1548427528967;
        Fri, 25 Jan 2019 06:45:28 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:7d0f:90cb:2b03:b6a2? ([2001:4898:8010:2:6643:90cb:2b03:b6a2])
        by smtp.gmail.com with ESMTPSA id c202sm67792825qkb.19.2019.01.25.06.45.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 25 Jan 2019 06:45:28 -0800 (PST)
Subject: Re: [PATCH] log,diff-tree: add --combined-with-paths options for
 merges with renames
To:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
References: <20190124164654.1923-1-newren@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e9dd9394-e34d-e948-9a9c-83338b672d65@gmail.com>
Date:   Fri, 25 Jan 2019 09:45:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190124164654.1923-1-newren@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/24/2019 11:46 AM, Elijah Newren wrote:
> As an alternative, I considered perhaps trying to sell it as a bugfix
> (how often do people use -M, -c, and --raw together and have renames
> in merge commits -- can I just change the format to include the old
> names), but was worried that since diff-tree is plumbing and that the
> format was documented to not include original filename(s), that I'd be
> breaking backward compatibility in an important way for someone and
> thus opted for a new flag to get the behavior I needed.

This is wise. Changing the format is likely to break at least one GUI
client or tool, especially because many depend on the installed version
of Git instead of shipping with one "blessed" client.

In addition, there may be whitespace in the filenames. It appears the
diff format separates the filenames with tab characters. Is it
possible to have tab character in a file name? That would make the output
ambiguous, but is no worse than our current output in a non-combined
diff.

I'll repeat Brian's request for tests. I trust the compiler and the
test suite more than I trust my ability to read code.

Thanks,
-Stolee

