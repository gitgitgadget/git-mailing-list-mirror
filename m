Return-Path: <SRS0=qItC=6C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 682BDC2BB1D
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 00:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D76E214D8
	for <git@archiver.kernel.org>; Sat, 18 Apr 2020 00:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UV1B3VDK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgDRAw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Apr 2020 20:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725856AbgDRAw4 (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Apr 2020 20:52:56 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527CAC061A0C
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 17:52:56 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id p25so1854726pfn.11
        for <git@vger.kernel.org>; Fri, 17 Apr 2020 17:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=/vdHwoPircQWLADluAA2YiWisJbLIOw7I3XM6Y4lxI4=;
        b=UV1B3VDKVPouV+DdH4ujaedqgwn66a7KcH4xOV9tuRCezR8eN/SVbwL6o9FOJrEM37
         t2XjBg7lXt4CYuybppv+d7a9UC9Clqi/bD74yYS63AwS0qjkAZyzKAgdWAMWvIKec3o1
         GlsgwvCuWfhNBvoYvDnCgFivPut9Ev4/JWTP/pda+W7AtqNqyDKiGLbjLJz+INXC/u/u
         nLeN9PxiVUK0ZPEQNuUOTTEqBHrmjktpv6tPA6kA22QoNMfiq9gie8uRcfWyUwL4QRFX
         o7kb+rOcpLWlYbsy4aXdtR4bnqXeZAeZsjZfw2AhIVqun3mvSTAKjss4TNLv69F+bEo8
         nSsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=/vdHwoPircQWLADluAA2YiWisJbLIOw7I3XM6Y4lxI4=;
        b=D0fg3HDiRzCOpSf8vwlOa7nwdV52WgtcJn+KanYX1k7ZVL3yUVvnWaCit9PJXogqXs
         cNXd+W23CfSYWqecqxmozWiP/RxM/ARNpgx8pM0rXX4fYe2RGieS1ZHHcDQOrPKd2NVi
         /bviCTHa7UYDYrivNfVfGle8InSDcAO10B/tHFCik6ylhqX2oLqRUxpMGAtjRFmqcT1M
         C36Hrez5JgJWsHIjHNjdDznugCZhtFJLOVmR4YUA+6IRg+4ajDTZ3K/4zKzDXvxwaTl/
         0b7YvfeDxEKO5IrVh6TmETciarAgtTSPRKGj78F3eGsD7SnZ+xySMULFmeTsL3UPHXH6
         6uQA==
X-Gm-Message-State: AGi0PuZFDaZik7HPWTyjkKWwyfhxp8pIa8TIKII3TiCohxJugntyXjog
        3ie1wh6PExZgUEmzc+55E3M=
X-Google-Smtp-Source: APiQypJ3C+CKygw3hxBBeAEaJUGetwIb5JVKsM9jsD+x9OtY6/dVhyJPqQ6ho8ghw4EShv/tQWGtVg==
X-Received: by 2002:a62:2947:: with SMTP id p68mr5775387pfp.282.1587171175687;
        Fri, 17 Apr 2020 17:52:55 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 17sm15439379pgg.76.2020.04.17.17.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2020 17:52:55 -0700 (PDT)
Date:   Fri, 17 Apr 2020 17:52:53 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Enji Cooper <yaneurabeya@gmail.com>
Cc:     git@vger.kernel.org, Barret Rhoden <brho@google.com>
Subject: Re: blame --ignore-rev - repo-level ignore file
Message-ID: <20200418005253.GB121175@google.com>
References: <B2997F0D-AEEE-4431-85B8-98831ACF85B6@gmail.com>
 <388B3B98-4929-4B4A-9167-3076CFDD0B5B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <388B3B98-4929-4B4A-9167-3076CFDD0B5B@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(+Barret)
Hi!

Enji Cooper wrote:

> Hi,

> Given the increased number of C/C++ and python projects that both
> use git and a tool like black (python formatting tool), or
> clang-format (C/C++ tool, primarily), I would like to seriously
> consider revisiting the topic "blame --ignore-rev - repo-level
> ignore file” topic that was originally started by Terry Davis here
> [1] (quoted above for historical reference with the reply provided
> by Barret Rhoden).
>
> Having a default configuration that can be used with git instead of
> forcing end-users to set custom configs per repo clone would make it
> considerably easier for end-users: one could clone a repo, reformat
> code with an automated tool in a series of known commits, add
> ignored revisions to the file when using git blame, then make
> additional changes building off the automated reformatters' changes.
>
> I will be more than happy to submit patches to make this possible; I
> just need some guidance in terms of what’s required when
> contributing changes, etc.

The first question would be what you expect the end-to-end workflow
to look like for users.  What commands would they run?  How would
they discover them?

As for the general contribution process:
https://www.kernel.org/pub/software/scm/git/docs/MyFirstContribution.html
is a good starting point.

Thanks and hope that helps,
Jonathan

> 1. https://marc.info/?l=git&m=156864623817929&q=mbox
