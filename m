Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0F78920A17
	for <e@80x24.org>; Thu, 19 Jan 2017 23:38:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752786AbdASXiC (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 18:38:02 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34799 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751662AbdASXh7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 18:37:59 -0500
Received: by mail-lf0-f68.google.com with SMTP id q89so6924482lfi.1
        for <git@vger.kernel.org>; Thu, 19 Jan 2017 15:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=it9yhSiBz6prcvQu9jy8QfuqHD5hARJ6C5QHfOYIGT8=;
        b=E/H+EOVKFw+xvEUd0nvB10+z8c3kWCNjQsSs10qDcYxAPZ7rSbyO3W1BrhEmpbabuR
         Zof7gzxnM1+Y9DtnYl9ZfEI3tRrwxO1sGe4Sx3kjvSKFfvSqr2BuQe+UKm8XoDH0e3RF
         I3IiyBZFhZ3F0Grk2chCXBehK+L8UVQVn2xwLOBbiW3QnoV4PFOOoy9xGXqeppPgIkwW
         gZQdPq7dtZh2jZ6oFkiSTswQIc7VpkOhV4JY1VDxwH1i8v/epXXXfQOjbqYr3G0ADfEi
         Qh60g6ci/Q22uEu6JEd+YgEgQjadgWd4sNPktCBTFVJhe0/xHsx3YkBs88A9eoDcy7GP
         5f3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=it9yhSiBz6prcvQu9jy8QfuqHD5hARJ6C5QHfOYIGT8=;
        b=mTshEB8UfaoOvlSdUizQVxZM/M+oI3CdAGjzsYiRAf2lSVgv6L6xzV8aFET/zrrP4h
         SqhLboPkzN2ezLWNwhzrnnElCHQqqx629YVKRAOKS9ugptCGVW9ld47yiXKxBHo5SEFq
         DqZTe2G8wVZ6ayiY5prPI+8A9g10PNOAEf82yJFbFOqp1kkCa8/aTwFVHrAfw/ndqjyP
         nxYxcJbLXj2xKWchM/m9MVd4nnPDHjU2Md5ngtLOcItBNuuImRjbT3aL67YZ7c6pLSS7
         +gQUABEhsqZfFFSpXA4DFZDA9CnX8KTSuEm1wz8q1IPNDmXuHM1fPm9HiZ1FUUZfZk4+
         Erwg==
X-Gm-Message-State: AIkVDXIFbcaOs2QjtVkRhPyS4w/Xe3X/yvEx9aoI7gxjuDhntmuVWT4fA/hFp57+iGFx9aBaoCcL8Qwdbzz60A==
X-Received: by 10.25.74.72 with SMTP id x69mr3781199lfa.66.1484869022042; Thu,
 19 Jan 2017 15:37:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.145.14 with HTTP; Thu, 19 Jan 2017 15:36:41 -0800 (PST)
In-Reply-To: <xmqqfukezrmh.fsf@gitster.mtv.corp.google.com>
References: <20170118230608.28030-1-jacob.e.keller@intel.com>
 <20170118230608.28030-3-jacob.e.keller@intel.com> <xmqqfukezrmh.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 19 Jan 2017 15:36:41 -0800
Message-ID: <CA+P7+xokEvYo4as5w0O5SbS6KE86fO=a7VnR_JroTOHebWSayw@mail.gmail.com>
Subject: Re: [PATCH v4 2/5] name-rev: extend --refs to accept multiple patterns
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 1:06 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Jacob Keller <jacob.e.keller@intel.com> writes:
>
>> From: Jacob Keller <jacob.keller@gmail.com>
>>
>> Teach git name-rev to take multiple --refs stored as a string list of
>> patterns. The list of patterns will be matched inclusively, and each ref
>> only needs to match one pattern to be included. A ref will only be
>> excluded if it does not match any of the given patterns. Additionally,
>> if any of the patterns would allow abbreviation, then we will abbreviate
>> the ref, even if another pattern is more strict and would not have
>> allowed abbreviation on its own.
>>
>> Add tests and documentation for this change. The tests expected output
>> is dynamically generated, but this is in order to avoid hard-coding
>> a commit object id in the test results (as the expected output is to
>> simply leave the commit object unnamed).
>
> Makes sense.
>
> I do not see anything that requires "... generated, but" there,
> though, as if it is a bad thing to do to prepare expected output
> dynamically.  I'd just reword "generated.  This is..." to make it
> neutral.

Makes sense. I was commenting this way since I was requested that
someone on the list preferred non-dynamic test expectations.

Thanks,
Jake
