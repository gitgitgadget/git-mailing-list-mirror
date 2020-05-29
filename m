Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C57C433DF
	for <git@archiver.kernel.org>; Fri, 29 May 2020 00:28:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDFBA207F9
	for <git@archiver.kernel.org>; Fri, 29 May 2020 00:28:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mlxH/h/Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728358AbgE2A2B (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 May 2020 20:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725775AbgE2A2A (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 May 2020 20:28:00 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C571C08C5C6
        for <git@vger.kernel.org>; Thu, 28 May 2020 17:28:00 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id fs4so339448pjb.5
        for <git@vger.kernel.org>; Thu, 28 May 2020 17:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qcNQ3bVIeQ5deedbNpZo77K+5SYKFfq4z2reyZlb/Js=;
        b=mlxH/h/QNMwu5Pn8OZbTKGJ64pgqdMUWdF9fv072tGqSOrnZ3bOkst+0VITiCoXvOo
         jraXmez3DnIMKEzvzQiWtlKsVqv1AbM0T1j3+bRos5o0DifcutijMJdTxdNSKiKPgOuo
         jqZ3pS/qdS9/QJLFIrKMtnEpxQjAS/4RlHEHVBEdu1D707zD9gbM+BwJ/AceGLGx4IxV
         lUohTlKvJu2GmCj9DARriFjnfDwBxxLrJkg19Wl39iLJX396UXxKx2pkcyGlN0364kw2
         nvb+olBkAo9GpYMpptKw74PyOPa3absjtm3FMsC6T790vTPSyR4E7XAoofVmtU/+e/ha
         A0kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qcNQ3bVIeQ5deedbNpZo77K+5SYKFfq4z2reyZlb/Js=;
        b=gZMA9rqcgG41y7iN/loFlT0Xf7+6ltOLMtEmaV5L50ySJSEdka4pCdUsE+tLQVWrQN
         yIyAhZ2aztcDs7/I+kIxxiDI3g8fBoaWKhOuKD1XzvXUTQzqdXAbGfGH88HiBN1gSexZ
         wvhTp0payXXKUNQY1JlQqbLIq/J83/cutRZUaapWDnSak1bsxtZmoQGw1p3I7c2gnxr/
         ARtfsRBfu9FyXD9Dx85nNM3WhTJhYkb/6/rPsdnivsQmYrE1B0IkdT91gxXC5VStD0PM
         J6XeHbzGzoDaHe2WcSI6TLZAgDpQswJTYPWm86nX8vMppE55AeSwzrJ/b2kw4O8/6Hbm
         lUBA==
X-Gm-Message-State: AOAM5303kXCTxxe6fNBC2F3qzMNWWBGg0G3uHR26rEk3Hcw8xm83v8vl
        yEQJ0pzJidPWNH7FdV57UZ8=
X-Google-Smtp-Source: ABdhPJz/PJUYhwMiUmLHfmHpwjZfXhHZFuBvM+kRsAWgUen/MV4HwrU98tZ2WW+JCGVL1nDAuWDZSA==
X-Received: by 2002:a17:90b:4010:: with SMTP id ie16mr6573944pjb.138.1590712079827;
        Thu, 28 May 2020 17:27:59 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id n205sm5843279pfd.50.2020.05.28.17.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 17:27:59 -0700 (PDT)
Date:   Thu, 28 May 2020 17:27:57 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [git-scm.com PATCH] community: advertise 'git-bugreport' tool
Message-ID: <20200529002757.GD114915@google.com>
References: <20200528231608.59507-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200528231608.59507-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:

> Starting with 2.27.0, 'git bugreport' can gather diagnostic info and
> drop the user into an editor with a template for a useful bugreport.
> Advertise this feature to users who want to report a bug in Git.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  app/views/community/index.html.erb       | 11 +++++++----

Modulo the link issue that Junio mentioned, LGTM.  I think the section
on the page you chose is a good place to mention the command.

> --- a/app/views/shared/ref/_debugging.html.erb
> +++ b/app/views/shared/ref/_debugging.html.erb
> @@ -2,5 +2,6 @@
>  <ul class='unstyled'>
>    <li><%= man('git-bisect') %></li>
>    <li><%= man('git-blame') %></li>
> +  <li><%= man('git-bugreport') %></li>
>    <li><%= man('git-grep') %></li>
>  </ul>

Where does this show up on the rendered page?  Is it
https://git-scm.com/book/en/v2/Appendix-C:-Git-Commands-Debugging?
Is there a way to preview how it renders?

That page appears to be about commands used to debug your own
codebase, so for everyone except us Git developers, it's the wrong
place to mention git bugreport. ;-)

Within the book, I think
https://git-scm.com/book/en/v2/Getting-Started-Getting-Help and the
corresponding
https://git-scm.com/book/en/v2/Appendix-C%3A-Git-Commands-Setup-and-Config
page might make sense.

Thanks,
Jonathan
