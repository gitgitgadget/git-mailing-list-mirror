Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40F1020401
	for <e@80x24.org>; Tue, 27 Jun 2017 17:35:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753078AbdF0RfS (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Jun 2017 13:35:18 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:36052 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752371AbdF0RfQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Jun 2017 13:35:16 -0400
Received: by mail-pf0-f171.google.com with SMTP id q86so19878296pfl.3
        for <git@vger.kernel.org>; Tue, 27 Jun 2017 10:35:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=L0B0R3QY3DXJA7JeSxJm3KiUy85SG/N5XbxkGbkYaTM=;
        b=cTydKvLR/wGanMPLxzy7S9EObIW63vQ6tbg44b6YaDn2ProU4JSfaqzf44YcYSXBkc
         2oUjASsMkh/+M/8kJCbAoPhp5amFH3+bJ3Du6SUAka5OP5HFTGvhjqCgQRqubP1yYP1E
         sdjrqoxrChhBGdXsFL/52Ruccfqi+gqBnUz8AiX5rNJazmNu2sgdmwBmQ5wnOjXv3DhC
         NZ6vxMplPpNrmrIQ8qg/Foxzu+rWCu+JQqnirLf/jUIkmAaGhbkSIXCjm9etYkCcOVeR
         rqIRYFfoqunYXmvL8LtDKVMFibOCv1Kg2NiQWpmv4MJYWGfwmoZA0++BhzMBZYKf9/Cq
         KIIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=L0B0R3QY3DXJA7JeSxJm3KiUy85SG/N5XbxkGbkYaTM=;
        b=b2UOXX4VHZj+XoVZO0R5UQISxazxhygz1sU4KKiGbLO8n/ErMQspESqbj/wPA4YmcC
         l1nYPuKprYcTisELlwu60mlpglw3r6njlEtK10GJDScSdg5+2/zL/roACXznm9K5aIeA
         dFixX8TobKnMr/1IkOxVR8QwWiTWOd2zT10h3ikD/P+CgWL8SnDtE4ucnKROY6k7jFf9
         tQVFV0jDgvLB9e09iUsmtuMA4UGDyTLOVRRAF1sYQdv7jtta0RPCC3cm86fIE2XD8LYY
         NUabdQ/6i9QKOJlkdwLw0/esqs9yFFlxBMhD8IM1IaVl3N3yd8ZyXUWb/8MqJHbHIH70
         BQsw==
X-Gm-Message-State: AKS2vOxKfh1HKzc5nPHtZGwrXHgaHGBv7W/smYDmYvnAo7kTuVU42kwS
        uF7gLIa3c8NQ2ES5YwMzFgVvBh831ViS
X-Received: by 10.98.69.76 with SMTP id s73mr6288536pfa.94.1498584915714; Tue,
 27 Jun 2017 10:35:15 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.183.170 with HTTP; Tue, 27 Jun 2017 10:35:15 -0700 (PDT)
In-Reply-To: <xmqqr2y531xv.fsf@gitster.mtv.corp.google.com>
References: <0d924a0671b642d2b8ba79af8d4fa0d7@rohde-schwarz.com> <xmqqr2y531xv.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 27 Jun 2017 10:35:15 -0700
Message-ID: <CAGZ79kZmV9Aufrsmf1iohhP5qHzA4AZ3DDv8sn1GMaCZ+SbV5Q@mail.gmail.com>
Subject: Re: Bug: submodules of submodules use absolute gitdir in .git file
 (instead of relative)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Robert Siemer <Robert.Siemer@rohde-schwarz.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 27, 2017 at 8:06 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Robert Siemer <Robert.Siemer@rohde-schwarz.com> writes:
>
>> Hello everyone,
>>
>> $ git submodule foreach cat .git
>>
>> ...shows that the gitdir registered in the .git file of submodules is relative. But if you run
>>
>> $ git submodule foreach --recursive cat .git
>>
>> ...shows that submodules of submodules (if you have any) have an absolute gitdir starting with a slash.
>>
>> 1) Can you confirm that behavior?
>
> Nobody can without knowing which version of Git you are using.  I
> suspect that we had discussed and addressed something related to
> nested submodule's "gitdir" pointer in not-so-distant past.

Yeah there was a period in time where we had this bug.
(Or is it a different bug?)
See 90c0011619 (submodule: use absolute path for computing
relative path connecting, 2016-12-08), which is included in 2.12.
