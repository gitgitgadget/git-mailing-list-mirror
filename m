Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5988EC4338F
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 21:16:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3ADCB60E52
	for <git@archiver.kernel.org>; Fri,  6 Aug 2021 21:16:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236773AbhHFVQY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 6 Aug 2021 17:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbhHFVQW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Aug 2021 17:16:22 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81629C0613CF
        for <git@vger.kernel.org>; Fri,  6 Aug 2021 14:16:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id j18-20020a17090aeb12b029017737e6c349so13374684pjz.0
        for <git@vger.kernel.org>; Fri, 06 Aug 2021 14:16:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=rOIGEDOxGFvixFTmdApPOy7aQS0oWJBQTWyZRhAUIGE=;
        b=gYcXXHinoeB5kLhnUrM08c4kCekoSPzqr87GgzMJtSzTH8SvBa7sfHF6jofw2wx1vs
         4NA4+kxD/SMO/3YHiN9alJwlPygTwARBufzRjO6nRqsfRIk72YYYlDJF71+Bp1xhDqMo
         pjxrtsbXfC38lWUf1TK0PnmtwM0Q2UjtpkqhxCTdu9UhPxZljCyXuxQrJgMVc+1lU8yZ
         CWWuyaYqtkqwTTIVn4XV5HEWmvTOCb/z6GGl81B9NzD/4Hdqy2tjlBq35v1VtiTdyDYS
         D97zYveT4pI8VLa6lX/4/QU4WEIxAjMHxgBsUoi3FkDJaeBDRsDylhK5n8tPUZM/W2uy
         33Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=rOIGEDOxGFvixFTmdApPOy7aQS0oWJBQTWyZRhAUIGE=;
        b=AfNX8MClix3U0T9H1I0laKvnZ2/hMgWNvrFLaNeOU7E42x+OI0xNMsUoQGEFOa3dzw
         zIxlQ0+X81QCHhZip0O11ZRUevmQVZbNjtZZBk8cf4CXzOBclir/ttO0hXhCFwXfW49g
         p6UPauTRBNNymM+lIYZ3BSY8bk0njkCml8gGXhuIkHnMfE14h0jZJL8flt/p8mqMk3EO
         xu2+nwY6w3oi8R4FZEXmGQcTVHDG1Et0OgK2rW09mrxu/X7yhbj/3rHe7Pv+YgFICpy3
         poRuOsLxbT8FoRs9Wp6uLfUFcNQ+X/ywQcZM2dBEqG5Lv0dObn86DWyiaCMhuHPzshzO
         xUlA==
X-Gm-Message-State: AOAM530Gg9NFL85QBgozIFN7vpGxoJ0k3h4BmwC1YZdazUg6l7vIYwv1
        cmNuHEJmiQ/ByhEyKF4jV4cSEQ==
X-Google-Smtp-Source: ABdhPJyYOkSJ3ZThA3E7Wyv7/a+8de6cmXvuFq7h5WJWxZb2bdQ4U8EhN2yD3A6D6SzslzgN3oiCQw==
X-Received: by 2002:a17:90a:394c:: with SMTP id n12mr22472109pjf.45.1628284565763;
        Fri, 06 Aug 2021 14:16:05 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:19f7:4e2a:b277:e7cf])
        by smtp.gmail.com with ESMTPSA id y4sm10002202pjw.57.2021.08.06.14.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Aug 2021 14:16:04 -0700 (PDT)
Date:   Fri, 6 Aug 2021 14:15:58 -0700
From:   Josh Steadmon <steadmon@google.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v2 2/2] connect, protocol: log negotiated protocol version
Message-ID: <YQ2mjmwoRYO4jqaH@google.com>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>
References: <cover.1628115064.git.steadmon@google.com>
 <d138b2615c1af288627b9a2f8f7dd3d2fed184d7.1628115065.git.steadmon@google.com>
 <CAPig+cSqm5cUmAVG6f73oZ+mi9pBJrOg2va2a_Op4=wNFyHfZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPig+cSqm5cUmAVG6f73oZ+mi9pBJrOg2va2a_Op4=wNFyHfZQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021.08.04 18:28, Eric Sunshine wrote:
> On Wed, Aug 4, 2021 at 6:17 PM Josh Steadmon <steadmon@google.com> wrote:
> > It is useful for performance monitoring and debugging purposes to know
> > the wire protocol used for remote operations. This may differ from the
> > version set in local configuration due to differences in version and/or
> > configuration between the server and the client. Therefore, log the
> > negotiated wire protocol version via trace2, for both clients and
> > servers.
> >
> > Signed-off-by: Josh Steadmon <steadmon@google.com>
> > ---
> > diff --git a/t/t5705-session-id-in-capabilities.sh b/t/t5705-session-id-in-capabilities.sh
> > @@ -73,6 +74,17 @@ do
> > +       test_expect_success "client & server log negotiated version (v${PROTO})" '
> > +               test_when_finished "rm -rf local tr2-client-events tr2-server-events" &&
> > +               cp -r "$LOCAL_PRISTINE" local &&
> > +               GIT_TRACE2_EVENT="$(pwd)/tr2-client-events" \
> > +               git -c protocol.version=$PROTO -C local fetch \
> > +                       --upload-pack "GIT_TRACE2_EVENT=\"$(pwd)/tr2-server-events\" git-upload-pack" \
> > +                       origin &&
> > +               test "$(grep \"key\":\"negotiated-version\",\"value\":\"$PROTO\" tr2-client-events)" &&
> > +               test "$(grep \"key\":\"negotiated-version\",\"value\":\"$PROTO\" tr2-server-events)"
> > +       '
> >  done
> 
> What are these `test` commands actually testing? Did you mean `test
> -n`? Or, even better, just plain `grep` (not within a
> command-substitution)?

Yes, sorry about that, just plain grep is best here. This was due to a
quick copy & paste modification, I should have spent a bit more time
thinking about the test case.

Will be fixed in V3.
