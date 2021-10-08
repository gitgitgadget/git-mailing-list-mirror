Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAD35C433F5
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 18:01:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C17F360296
	for <git@archiver.kernel.org>; Fri,  8 Oct 2021 18:01:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238085AbhJHSDY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Oct 2021 14:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231217AbhJHSDV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Oct 2021 14:03:21 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDCF5C061570
        for <git@vger.kernel.org>; Fri,  8 Oct 2021 11:01:25 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id k19so1223502qvm.13
        for <git@vger.kernel.org>; Fri, 08 Oct 2021 11:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Gt+kRfC4w6O2wRSIOA6+XhTQyzg4bo6pQRRBzmNCVQk=;
        b=Xa3kvJWL4LzirsWCGK8EGJntcDluBiUqNXlAGJl5MJ29vw8sLmmM5aBrJywzZnsm7o
         y4PaJcj1iW5oDuFRYkghcKNsKDwejXL1ZQl/yDBOrGu5wg5YXISrH3Z8SVrFshCp7P+s
         ZQdStpXfd+fXA8d4yAQq3ii43i6oia+N558n0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Gt+kRfC4w6O2wRSIOA6+XhTQyzg4bo6pQRRBzmNCVQk=;
        b=K8ygSyJ0rJ9i5COmyegUzI9y20eQUzmfTNgXq2Um/PeoGixKyt7WU8sjjogwjluzGy
         JBn7UnIR0l8dYqh+jI7irBPdlbQRcPDk+FveLdy+1pa628JnDpmHfJJ/zxEfQDZK9ZtA
         rtE6AxflJG5qsoUTCmI3BZFmyq+I/4Qy6AJjwoqmo4E7LCjv0oUqcSOa+7FhNLk/xBsU
         aXpA8/IUeXbKtVwSMNinbpAmkXd6rdAkQJcqnFxtX04W7cHuev4uo6Fey5KGO06tzr3Y
         aRKmTR8mQw/CABeu49oryjcwGb4w6vykdUFY4zovg6d1gzD2Le+yCLaGWDeAUaTsbva6
         tY8Q==
X-Gm-Message-State: AOAM53204x/CIbvWMyz8FIAmyFYhYtw+FIwfTb3b/M05uhPlatvZZ3kO
        d5vD2UMYlEFr9Vxh7GeSJhrw8wC+uzXZ6w==
X-Google-Smtp-Source: ABdhPJzIC7KgEbVtmBYazc8klvr0CW5mMKc5CNmK0hymJfNI0rSF5yIpj7QAsb9CHU1O6iHi50w3gg==
X-Received: by 2002:a05:6214:2a45:: with SMTP id jf5mr11120884qvb.25.1633716084923;
        Fri, 08 Oct 2021 11:01:24 -0700 (PDT)
Received: from meerkat.local (bras-base-mtrlpq5031w-grc-32-216-209-220-181.dsl.bell.ca. [216.209.220.181])
        by smtp.gmail.com with ESMTPSA id o23sm2662436qtl.74.2021.10.08.11.01.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 11:01:24 -0700 (PDT)
Date:   Fri, 8 Oct 2021 14:01:23 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Alan Mackenzie <acm@muc.de>
Cc:     git@vger.kernel.org
Subject: Re: How do I get the file contents from an arbitrary revision to
 stdout?
Message-ID: <20211008180123.ls62virahqthgpmb@meerkat.local>
References: <YWCFFcNeNVTYcELN@ACM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YWCFFcNeNVTYcELN@ACM>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 08, 2021 at 05:51:17PM +0000, Alan Mackenzie wrote:
> Hello, git.
> 
> I want to get a file's content from a particular revision onto stdout for
> backup purposes.  I can't see how to do this.  Help me, please!
> 
> Let's say the file is foo.c, and I want to get the version from the head
> revision of bar-branch.

git show bar-branch:foo.c

-K
