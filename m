Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 36A841F404
	for <e@80x24.org>; Mon,  5 Feb 2018 20:20:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751319AbeBEUU2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 15:20:28 -0500
Received: from mail-wr0-f195.google.com ([209.85.128.195]:39713 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750943AbeBEUU1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 15:20:27 -0500
Received: by mail-wr0-f195.google.com with SMTP id f6so29329670wra.6
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 12:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=3f75zXZ9N+J7yMOXuwkL0nB33RXgKCmYnjRS6qFy16s=;
        b=Kh7HshMQUuDjI+dukIbFH03/56focu/cHagoFw/TYa2eG5RzZa1rOhr6P7h2aNgh6z
         zK0FK6tzSmqdmJJjirCgOSsaqMGupTi2V19tiSX6SfQaYCLNJ5LajsPzWgr9CoCgdIFy
         xjJPE1dUl2f7xPoxr4GgKGC65xa0AW0vDVzANoY2mZ7HGhOS6/G3It7cmUM4Jn3x1O9l
         nQidaz55aqtbk7c0+U64GIUSqw4nocwwNukx3R5cJ0MCXo5mElMLN04GJz5BaorSHGkU
         L3M1AxM76o9RQyFl5mF/nFDJ45Nm3Njj+CapcHgk5XGwjScRHo6w9MMajPYJkKUSO8Cs
         AoZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=3f75zXZ9N+J7yMOXuwkL0nB33RXgKCmYnjRS6qFy16s=;
        b=SfTV6RbtGuO7KHzqY3oHqS4btI4Zc+sE92fuRThdZEtSC3iA5jAjKG0HKpkuOe8Swy
         fxY4bBdD+zYtmIky+lvsa8mt96a8NLQsOucDsS9/5byRxi9ur8sdDvCgBg77koEPl3rA
         a7eRtvalDpbeeENQwjdA9YBqf7w2tECEPSTbuxsVRgfylDTQl9/NEv/XElADwgPpzT3n
         Tf+SEFIeZ4W6BF9IPA22jYEhqWRekHmh3nnVy9FQGiwIHYaiZ3DXeWCeNXEMmPXWeiu0
         qc+cRQYX3bfj8aD/GaKD3XA0ySc5shFJxdj18fegCwWc5uGHQehiMZkV13e0umcwjb/A
         2+vA==
X-Gm-Message-State: APf1xPBYXgdEsPqRvvkK1UbpTP2gnClROsA6TbPnUK3SJtQMY7AybHFV
        xtidxTt3dCEhUQDaUJsMyRQ=
X-Google-Smtp-Source: AH8x226BzQqSqvzeTXGlgLqsQ0BeiWIh6Q0oe8fbVdCZr4DlTlyDFP7g5+Y/HsleCEpu/QzvENQjqQ==
X-Received: by 10.223.196.78 with SMTP id a14mr5500wrg.251.1517862025692;
        Mon, 05 Feb 2018 12:20:25 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id q15sm11508926wra.54.2018.02.05.12.20.24
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 12:20:25 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>, git@vger.kernel.org,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/3] worktree: teach "add" to check out existing branches
References: <20180121120208.12760-1-t.gummerer@gmail.com>
        <20180204221305.28300-1-t.gummerer@gmail.com>
        <20180204221305.28300-4-t.gummerer@gmail.com>
        <20180205021833.GB17847@duynguyen.dek-tpc.internal>
Date:   Mon, 05 Feb 2018 12:20:24 -0800
In-Reply-To: <20180205021833.GB17847@duynguyen.dek-tpc.internal> (Duy Nguyen's
        message of "Mon, 5 Feb 2018 09:18:33 +0700")
Message-ID: <xmqqh8qv9ojb.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> On Sun, Feb 04, 2018 at 10:13:05PM +0000, Thomas Gummerer wrote:
>> -	if (opts->new_branch)
>> +	if (opts->checkout_existing_branch)
>> +		fprintf(stderr, _(", checking out existing branch '%s'"),
>> +			refname);
>> +	else if (opts->new_branch)
>>  		fprintf(stderr, _(", creating new branch '%s'"), opts->new_branch);
>
> I wonder if "creating branch" and "checkout out branch" are enough.

Yeah, I think new/existing are redundant.  If these were shown at
the same time, then the extra adjectives would help differenciating
them visually, but they are never shown at the same time, so...
