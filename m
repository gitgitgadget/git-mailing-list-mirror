Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27BBF1F516
	for <e@80x24.org>; Mon,  2 Jul 2018 21:23:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753087AbeGBVXP (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jul 2018 17:23:15 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:39737 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752769AbeGBVXO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jul 2018 17:23:14 -0400
Received: by mail-yw0-f194.google.com with SMTP id 81-v6so7170173ywb.6
        for <git@vger.kernel.org>; Mon, 02 Jul 2018 14:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/HjNNXdV03wMFKtSBd6YVACslvPnXW1xZQup54lXm9I=;
        b=fdOzJfvbc9GLY22hqswA6OxVdjyRpzY3nvmqqlv1qaWKxNXLno+qUvEvNSJ6BVm309
         AIWEyEqifq9E+TLqNXMj8N1XZK9h9i4azYOSvAVR+fzInS9RMDnmB5sjqcXsgKDO5zZ7
         fMXRL0QJ/9ZpMkv+idHJHWFRvteIRkma5KqO5+84K+YhgdAw5Q+5YDXBhSXCZwNtuhNT
         9WaKJIBrzJrGfJ8qcIj4IBAO8+een8GJgiRj3awBfXfMdhcCBQfrpU6+p4v3AZnzOk7N
         XhoXki4g8YKQzqAU7SPmiLexU4njcbiTQC8PtvLLaqhkij7Z0qEPN/vCKCxoX/8oErzS
         Jl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/HjNNXdV03wMFKtSBd6YVACslvPnXW1xZQup54lXm9I=;
        b=PzBw13L9Y9oOrQbsg+HgXotwegIjufwXGEtBVn93kInDKITKquWg7E2B7/MQCRFy23
         0roA1VWyefOVLaIoecGzj3/4k499FeZnJYfKrUFPcQD5zXPZEEdYMXiQqbpRr6hGGelV
         esOyGb8qHV2v4RalcV2CtjzEbFNlgIPFnJhRRwCCLciTrJdNqgjc5m7DE7WVF8rmNz3Z
         i84wtt9GGwPhvxlbeZ07WDj6FGv1dfQQKRWJxmcAGuaK8/jpsvbmbgrSXHE/0gnbPtjs
         YM4sGElsGRIxVAIn3lr6BDgyuP+CpL8Qtrc2rzMY4/HC1CSmjaQfzfMb6dc3Hmu0Qhip
         Aalw==
X-Gm-Message-State: APt69E24AGUvnMVNldwaZJZzGw3HFlQPgJuo8odLht5a20MKO7y+Gxhr
        swsmuaxldD3SHuEnkgyyUuLubKHNdgGrwLoGdv4m8g==
X-Google-Smtp-Source: AAOMgpfz0Psx0DF4psR1+98tIWcCUNJVj8+2HdhMmbjz9lEnukL8NDb2hZ1VoAVLcWAJfjJjGpLd9Tij5zXOJMcUSk4=
X-Received: by 2002:a0d:f442:: with SMTP id d63-v6mr13307719ywf.238.1530566593317;
 Mon, 02 Jul 2018 14:23:13 -0700 (PDT)
MIME-Version: 1.0
References: <20180628135932.225288-1-jamill@microsoft.com> <20180702193745.8940-1-jamill@microsoft.com>
 <20180702193745.8940-3-jamill@microsoft.com>
In-Reply-To: <20180702193745.8940-3-jamill@microsoft.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 2 Jul 2018 14:23:02 -0700
Message-ID: <CAGZ79kYDyGg8z5FiYNXWAr+wT3r6Qm2Y_hh=o7xEKRkonO8Jaw@mail.gmail.com>
Subject: Re: [PATCH v6 2/8] read-cache: teach make_cache_entry to take object_id
To:     Jameson Miller <jamill@microsoft.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>, Ben Peart <peartben@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 2, 2018 at 12:49 PM Jameson Miller <jamill@microsoft.com> wrote:
>
> Teach make_cache_entry function to take object_id instead of a SHA-1.

This repeats the subject line?

Sign off missing.
