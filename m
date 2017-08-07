Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AE3DF2047F
	for <e@80x24.org>; Mon,  7 Aug 2017 18:17:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbdHGSRM (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 14:17:12 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36728 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751834AbdHGSRL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 14:17:11 -0400
Received: by mail-pf0-f181.google.com with SMTP id c28so4527731pfe.3
        for <git@vger.kernel.org>; Mon, 07 Aug 2017 11:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QAL3kOO6UsXKKKRmKzHtSVVBLg2tpBxLo8l5oph7Smg=;
        b=I1Gk4AiU6RZRgML6HZ3jVI+Ua1uuMvD6GkFQPX400s6KFYYoFKNKl+ALMoPv74S1Tl
         rM9H7VKFpI2V0h2hT52u7KqGBi2Wq8S+gkC5iSQfBrhosTS5cgsncXc1c7Nc0SmPVZ0r
         akDZkqM00nt4LWT1Kxjf9ymVZqtM3IZKrKs0FTJNM6EGbBeDTQFv/PkZkIGbZ8qM96sT
         8whZ69mNvWzFdKu66FYKdE6JR2RJjUfa7iolYipJdibA7V8SNRj/aJ78SdOmQH9N+x8d
         xXN8iwbciakx8ZNJBJJdm2+u3rsUq6FV5DHw/eKE4Zwf+tgk69wb3zmMee0XUCAu6nfx
         urkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QAL3kOO6UsXKKKRmKzHtSVVBLg2tpBxLo8l5oph7Smg=;
        b=m+HxK1kaBwUhjWlnCTjcarj7TUZqiIscvpICN1eWFpyB7IbViwIn5OSgvcrWlimIo3
         J6wLZyQsYm8KnrCPvYVYyHeDJNXwCVLFMmG+TEGJzm9OkBSC+dIf6PZWQyfVZS79X0+j
         W35TM52rRaRtbAQwyXIqO9L5tDUstUbMIASiE01s71eiA+/P/ZhEYI2aYIUqJ2VK25Pt
         GfX8jIYs/93XaVW1V70xT4XEbOLe9t/33qw+q8Kw3Ip6npqwp8u6W2UadJDFC0DzMktY
         tOMWvlMBxB5wJDDpbAnKWXof+Q4BBoeZ0X3kF1AxiTUYwGb4h6KBJCP4o+SJtLuBXViE
         rrVw==
X-Gm-Message-State: AHYfb5jTDI9B6zOznSzznHZj9wqiYTggj7A2O87VffOz5rm88ks5p7sO
        WsiwDQAqFQdPFQoqhJ9fjQ==
X-Received: by 10.99.117.30 with SMTP id q30mr1362653pgc.437.1502129830851;
        Mon, 07 Aug 2017 11:17:10 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:a0fe:8dcf:c61c:f231])
        by smtp.gmail.com with ESMTPSA id i90sm17019604pfi.106.2017.08.07.11.17.10
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 07 Aug 2017 11:17:10 -0700 (PDT)
Date:   Mon, 7 Aug 2017 11:17:08 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     benpeart@microsoft.com, git@vger.kernel.org, bmwill@google.com,
        gitster@pobox.com
Subject: Re: [PATCH for NEXT v3 2/2] sub-process: refactor handshake to
 common function
Message-ID: <20170807111708.2d745df2@twelve2.svl.corp.google.com>
In-Reply-To: <2BEA5CEF-44C9-45DC-A462-579864790EDB@gmail.com>
References: <cover.1501092795.git.jonathantanmy@google.com>
        <20170724213810.29831-1-jonathantanmy@google.com>
        <cover.1501092795.git.jonathantanmy@google.com>
        <6327579311fdb941a11b6d452318777a3c42ee65.1501092795.git.jonathantanmy@google.com>
        <323E470B-994B-4AD8-9F30-588C2B97A845@gmail.com>
        <20170807102136.30b23023@twelve2.svl.corp.google.com>
        <2BEA5CEF-44C9-45DC-A462-579864790EDB@gmail.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 7 Aug 2017 19:51:04 +0200
Lars Schneider <larsxschneider@gmail.com> wrote:

> 
> > On 07 Aug 2017, at 19:21, Jonathan Tan <jonathantanmy@google.com> wrote:
> > 
> > On Sun, 6 Aug 2017 21:58:24 +0200
> > Lars Schneider <larsxschneider@gmail.com> wrote:
> > 
> >>> +	struct cmd2process *entry = (struct cmd2process *)subprocess;
> >>> +	return subprocess_handshake(subprocess, "git-filter", versions, NULL,
> >>> +				    capabilities,
> >>> +				    &entry->supported_capabilities);
> >> 
> >> Wouldn't it make sense to add `supported_capabilities` to `struct subprocess_entry` ?
> > 
> > The members of "struct subprocess_entry" are not supposed to be accessed
> > directly, according to the documentation. If we relaxed that, then we
> > could do this, but before that I think it's better to let the caller
> > handle it.
> 
> @Ben: You wrote that " Members should not be accessed directly.":
> https://github.com/git/git/commit/99605d62e8e7e568035dc953b24b79b3d52f0522#diff-c1655ad5d68943a3dc5bfae8c98466f2R22
> Can you give me a hint why?
> 
> @Jonathan: What do you mean by "it's better to let the caller handle it"

Let the caller provide their own place to store the capabilities, I
mean, instead of (say) using a field as you describe and an accessor
method.

I don't feel strongly about this, though.

> > It does, but so does chosen_version. This is meant to allow the caller
> > to pass NULL to this function.
> 
> Hm. I think every protocol should be versioned otherwise we could run
> into trouble in the long run.
> 
> TBH I wouldn't support NULL in that case in the first place. If you
> want to support it then I think we should document it.

Note that this NULL is for the chosen version as chosen by the server,
not the versions declared as supported by the client.

The protocol is versioned. Some users (e.g. the filter mechanism) of
this subprocess thing would want to pass NULL because they only support
one version and the subprocess thing already ensures that the server
report that it supports one of the versions sent.
