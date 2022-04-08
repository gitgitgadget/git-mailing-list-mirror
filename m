Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B76FC433F5
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 09:01:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiDHJDX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 05:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231171AbiDHJDR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 05:03:17 -0400
Received: from mail-oa1-x33.google.com (mail-oa1-x33.google.com [IPv6:2001:4860:4864:20::33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A710B31
        for <git@vger.kernel.org>; Fri,  8 Apr 2022 02:01:14 -0700 (PDT)
Received: by mail-oa1-x33.google.com with SMTP id 586e51a60fabf-df22f50e0cso9090537fac.3
        for <git@vger.kernel.org>; Fri, 08 Apr 2022 02:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=Qdu7My5+AZWIUvjk+bv7wPkOr5mrPDcnjZa4ljNh6/M=;
        b=kvGDjNP5vfCbWn8lkXaaBBxvHlABb2pIKYlVGrwK7jFY+05wZOnlgI38nBdWsflrog
         4RGhHjRgwP/MFZq35d6Tq2R23NnjzBms7Bp14y4KB1jeXTKKgku3gYj8T3wepv23jshn
         PBPk64LcCJ6GpiMFkA42ResecMshbiwR+1AzsDSadVlqUU5cRDwbMmZ7kxwN7OPfGD0L
         jcQIANIB2pa97D2Ozp5wD2UAgWyj8Fa8hgDrKrek0uqgbIq1XvAh4awPD7H3gM1VCxfu
         DpsZzVH+2AH/ZFSPLmjva1e96H8m34CE3bISQajTnlPOUw0DbxjJ6ADTI17IZaerr4Pf
         tKXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=Qdu7My5+AZWIUvjk+bv7wPkOr5mrPDcnjZa4ljNh6/M=;
        b=S05STHmCz0EuUtrhBJnXxq6mKUPp1mJUrtDCCz9dzrNkuVH7HIyQDWWEGKUtGctlss
         jjuvBRCrpKMCdJBAnl1fkVWIAwaFAzWRMJYnW1U87I33RkVngRsAKYaERcindmzPXUu8
         7lMzwx8sRoNcZTC1kqVTks4MuNMYkotJ3J2qBnKcxTosWwx5JIVNnHCv/pVlG35qifqI
         1gWtCGqWKsIWRZDmWMF5IsPAyCErt+PEGJ3tMYIy5B+74zZAF2V153NAeCjM8iIqIgcF
         fx6qKSC+8oTPM9LstJwEM9a/ruzdnBuZD9qOfso+XrRPMIyYEmbuRxJEWbEkjIAVFEWk
         JkRw==
X-Gm-Message-State: AOAM530i3PO0aVsfQalRfWknGczgTdD0Kzpi++UPuiOvD/jTC91Cfea7
        WBH89JVVjWqx3b5I1o/dBgUrp+VyC7P/jHoHAhpuL1Bq1Z2kdA==
X-Google-Smtp-Source: ABdhPJwXJsXygKq812lkpl81zRSWlpenUNakW0CwxEHUA9vbsqxlhggOtG5tuAIlXVvcgz3tXrw3rxV6L+V5Te2dQjc=
X-Received: by 2002:a05:6870:f697:b0:da:b3f:3268 with SMTP id
 el23-20020a056870f69700b000da0b3f3268mr8095312oab.280.1649408473247; Fri, 08
 Apr 2022 02:01:13 -0700 (PDT)
MIME-Version: 1.0
References: <CAJyCBOSAekywgzVSf1uGb8s+hY7a7A=0fC5kFhMVpiqS1KEw4w@mail.gmail.com>
 <Yk9dOoit/Ua69s7A@camp.crustytoothpaste.net>
In-Reply-To: <Yk9dOoit/Ua69s7A@camp.crustytoothpaste.net>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Date:   Fri, 8 Apr 2022 17:01:01 +0800
Message-ID: <CAJyCBOTwsGtkEFuPHosQ-v6xot051OCRWh1QdmqMk3gucuEnPQ@mail.gmail.com>
Subject: Re: How to get git-send-email use a proxy?
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 8, 2022 at 5:53 AM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2022-04-06 at 14:19:43, Shaoxuan Yuan wrote:
> > Greetings, Git community,
> >
> > I'm using git-send-email with Git 2.35.1 under system
> > 5.4.72-microsoft-standard-WSL2, x86_64 GNU/Linux.
> >
> > I am on a system-wide socks5 proxy. Although I set the global
> > .gitconfig to use the socks5 proxy trying to send emails, the
> > connection to the SMTP server seems does not go through the proxy at
> > all.
> >
> > Other git commands do go through the globally set .gitconfig proxy,
> > git-send-email seems to be an exception.
>
> I think you're referring to http.proxy.  That affects only HTTP, HTTPS,
> and FTP (if we even still support that).  All of those protocols are
> handled by libcurl, which includes native proxy support.  It doesn't
> affect other protocols like SSH or SMTP.
>
> > So I'm wondering if there needs to be a code change in
> > 'git-send-email.perl' to run the connection through a proxy, or I just
> > need to tune the setting to accomplish this?
>
> git send-email is written in Perl and doesn't use libcurl, so it doesn't
> have proxy support.  If there's a particular optional module we could
> dynamically load to provide proxy support, that's an option we could
> support if someone wanted to provide a patch.
>
> In the mean time, you could also try using some sort of tool, like
> socat, to bind a local port tunnelling over the proxy to the destination
> server and then use SMTP over that local port to connect.
> --
> brian m. carlson (he/him or they/them)
> Toronto, Ontario, CA

Thanks, it's pretty informative ;-)

-- 
Thanks & Regards,
Shaoxuan
