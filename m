Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E93B1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 01:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727475AbfAOBnv (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Jan 2019 20:43:51 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:34200 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfAOBnv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jan 2019 20:43:51 -0500
Received: by mail-pl1-f195.google.com with SMTP id w4so504626plz.1
        for <git@vger.kernel.org>; Mon, 14 Jan 2019 17:43:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CpnEpdQ1q8UZx3wG9hcNpMCnRVd97WMqe5AakNwIr6s=;
        b=uIOIKVmbTkdkpQ9GF4QylhkHJYFbDD5IjBoLzi9hZAru82SPR4pXiEO5Oz82qw8HOU
         srOfs8a6pBfXT/7h+ZAxiHJ2CvDVvnPfsFfV5+yzdP/MZglOXFJzAlj913wGpDWhK8U0
         ppW7u3FPJFsbBO5smMBefEkKjEmOY1VY2DDrLfZg2IpCnfHZTh/wW7JvAwcvsSqmp6AP
         k0W2uOCvg1I6Ortw/qG4nV5Q/XjNxj6K1L8B/Kd/WAcGq2Y/eo4cMgWmVpNqxVCLPig1
         enXec6sAAwI8vRkJmAOa8KG/Mq9jN6Miz/Ou7+v3pAYL7lZw07NgKBQswULaEmmpwUAs
         Se/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=CpnEpdQ1q8UZx3wG9hcNpMCnRVd97WMqe5AakNwIr6s=;
        b=QZggibj/75kZSeEskXsBYkJ7jLa3Dp8QEicf0c/O0b3fVg9dvX4yrNKwVToAFj3RJ5
         DsQU9lvNoGoIHg85nD5BZlWPRRyjukqD8YwEDjCXKC6OzrFRxo3gTZ/oGtXtKXglf+Tg
         cMqhO4Fzrz5xThNpAjGP/aC7z+lPdQ/GgJOCUAw4LhGu6tQFsXk2NgEC3I7bTYS83j4F
         h6OHYzEbfXREiTAeAIl6qKszInz2r5Yi0KX5q08dR2aOboGHRAnDhAznlwc8Vn7hXkew
         yKG5qmSEW9yz093BmHHI/SOpgFL1iudFhxA9QNpTRnNdwYIrDXbv9kpi88jpzoz4zOkX
         8uSw==
X-Gm-Message-State: AJcUukeEHVNwR34rqlsdKiepfXhdW4byMebQ9Os9zsM/2HY0liwa4l5I
        EpRQlOaAdEZ6r7weeQCBFK4=
X-Google-Smtp-Source: ALg8bN4IBmVMBkABWXQN7oXCSKIuL0rmrSPmOhn8uaEA79ZTMeOG4/ysXw+IRK2MhXTcJ5vT6EIibQ==
X-Received: by 2002:a17:902:108a:: with SMTP id c10mr1481965pla.131.1547516630780;
        Mon, 14 Jan 2019 17:43:50 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id f64sm3413953pfh.0.2019.01.14.17.43.49
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 14 Jan 2019 17:43:50 -0800 (PST)
Date:   Mon, 14 Jan 2019 17:43:48 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Josh Steadmon <steadmon@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Masaya Suzuki <masayasuzuki@google.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: [PATCH v2 0/2] Accept error packets in any context
Message-ID: <20190115014348.GM162110@google.com>
References: <reply-to=20181127045301.103807-1-masayasuzuki@google.com>
 <20181229211915.161686-1-masayasuzuki@google.com>
 <xmqqef9tfikg.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqef9tfikg.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Junio C Hamano wrote:
> Masaya Suzuki <masayasuzuki@google.com> writes:

>> This makes it possible for servers to send an error message back to clients in
>> an arbitrary situation.

Yay!  Yes, this should simplify server implementations and user support.

[...]
> In short, are you shooting js/smart-http-detect-remote-error topic
> down and replacing it with this one?
>
> As that topic is not yet in 'next', I am perfectly fine doing that.
> I just want to make sure that is what you meant, as my reading of
> [4] was a bit fuzzy.

Josh, looking at that branch, I see:

 remote-curl: die on server-side errors

	Includes a test illustrating error handling in the ref
	advertisement.  Should that be revived as a standalone patch,
	without the remote-curl.c change?

 remote-curl: tighten "version 2" check for smart-http

	A bug fix.  We had an analogous bug in the .googlesource.com
	servers and it was problematic when experimenting with
	protocol changes using placeholder version numbers YYYYmmdd
	(since that starts with a "2").

 remote-curl: refactor smart-http discovery

	A nice cleanup.

Thanks,
Jonathan
