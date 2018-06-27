Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D17031F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935030AbeF0SG2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:06:28 -0400
Received: from mail-vk0-f74.google.com ([209.85.213.74]:33050 "EHLO
        mail-vk0-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934541AbeF0SG1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:06:27 -0400
Received: by mail-vk0-f74.google.com with SMTP id s185-v6so1106053vke.0
        for <git@vger.kernel.org>; Wed, 27 Jun 2018 11:06:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=VudqmtISJIcbzq+YqwTxOC78dszwZrUve9rvT/IVXmE=;
        b=bOwX1y9uHnSff2YLI1/z/6qQZVp5vCmUu+qiocU4nQcjG2nOiBjxhmIQ1EGcugah7V
         qqcWpZkX7fCNqpzloTGNcRokJZ00gh5joyr3PgIWLoWsIPrEdPBYvBNtpmK8D9hKAhPU
         qzNrGwZDYrjQ3rPm7D4ixnTfj9JPMQ1CTrO3dSCB51u7AEBI5aJLIkGJRFUwBJD4W4II
         0zPaU7o79OuJFsk0zOxntfvbVOMXYlalIplxnp7jcp43w3ChzZr73+JWjEQIx8s/PSAF
         AOLq51QnS17kr7d4tJD9STxbuglbAtuFoe2esIrFSJVWvX7BS2xX7cuOsGuaHlXWyGKe
         h/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=VudqmtISJIcbzq+YqwTxOC78dszwZrUve9rvT/IVXmE=;
        b=YUwXcjNZpeLGiWh7qhgNlR9w90csQLDRR544EwoWazVTi1QlcnPT392AAU/lv2SSf7
         z1o8589xLNRyWMkPDwXeAhqHJKSjvnBE93Taz3phbiFIF/wBhQ5bbuvLqUlI0dMHo7WW
         h4LV0yt+KfQH5hhkGRj40JjJeUnkVdchOwZ8JqyicjzhLyUbY5e0quGgEFFdLm2kBhvq
         XjkH2D6b1tOrJBydSe9J7r0GydacbRRjBIucYnj7y96ZR7IPRRUlCBRffWe6jZMel2mw
         j8ZxMhDrYJlJmFN6wvC0k4i4FD31KHR3cT1JNH5hZBK6/9wOHlzbJI1Zd9GO0723M5sk
         dZSw==
X-Gm-Message-State: APt69E21e9fHyW2yDgM5exVv0PzQ+n6Awry96RSYE1fldDjNB05t6TZ3
        SKuNV65PKb8Yz81RQs8NfPGcOSzmaMQy9CTs2txG
X-Google-Smtp-Source: AAOMgpclak2vNNfzX/X8SGpc+RaxgSXXePIHqGFMHxMV3PnJEksyAoMskmHzzPK1bTOtLQj/HqxnXrxzIU6Hk4KiIXei
MIME-Version: 1.0
X-Received: by 2002:ab0:3059:: with SMTP id x25-v6mr2879187ual.83.1530122786582;
 Wed, 27 Jun 2018 11:06:26 -0700 (PDT)
Date:   Wed, 27 Jun 2018 11:06:22 -0700
In-Reply-To: <xmqqsh59i6jx.fsf@gitster-ct.c.googlers.com>
Message-Id: <20180627180622.33736-1-jonathantanmy@google.com>
References: <xmqqsh59i6jx.fsf@gitster-ct.c.googlers.com>
X-Mailer: git-send-email 2.18.0.rc2.346.g013aa6912e-goog
Subject: Re: [PATCH v5 2/8] upload-pack: implement ref-in-want
From:   Jonathan Tan <jonathantanmy@google.com>
To:     gitster@pobox.com
Cc:     bmwill@google.com, git@vger.kernel.org, jonathantanmy@google.com,
        sbeller@google.com, jrnieder@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Brandon Williams <bmwill@google.com> writes:
> 
> > +    wanted-refs section
> > +	* This section is only included if the client has requested a
> > +	  ref using a 'want-ref' line and if a packfile section is also
> > +	  included in the response.
> > +
> > +	* Always begins with the section header "wanted-refs".
> > +
> > +	* The server will send a ref listing ("<oid> <refname>") for
> > +	  each reference requested using 'want-ref' lines.
> > +
> > +	* The server SHOULD NOT send any refs which were not requested
> > +	  using 'want-ref' lines and a client MUST ignore refs which
> > +	  weren't requested.
> 
> Just being curious, but the above feels the other way around.  Why
> are we being more lenient to writers of broken server than writers
> of broken clients?  The number of installations they need to take
> back and replace is certainly lower for the former, which means
> that, if exchanges of unsoliclited refs are unwanted, clients should
> notice and barf (or warn) if the server misbehaves, and the server
> should be forbidden from sending unsolicited refs, no?

I agree - if you were thinking of later relaxing this constraint to
allow the server to supply tag ref information during tag following,
writing "MUST NOT" here is still fine. (We can later change this to "if
'include-tag-ref' is sent, the server MAY send refs which were not
requested, otherwise, the server MUST NOT".)

Both Jonathan Nieder and I also suggested client enforcement [1] - I see
that in patch 8, in receive_wanted_refs(), unrecognized wanted-ref lines
are silently ignored. Maybe at least a warning would be good.

[1] https://public-inbox.org/git/20180625230310.210182-1-jonathantanmy@google.com/
