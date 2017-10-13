Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0779E20437
	for <e@80x24.org>; Fri, 13 Oct 2017 22:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752783AbdJMW4G (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 18:56:06 -0400
Received: from mail-pg0-f50.google.com ([74.125.83.50]:52265 "EHLO
        mail-pg0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752179AbdJMW4G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 18:56:06 -0400
Received: by mail-pg0-f50.google.com with SMTP id a192so858065pge.9
        for <git@vger.kernel.org>; Fri, 13 Oct 2017 15:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z0ldi75Qxmf/1U674LURmWF9VZ6DTkH36S4dXcu3wNM=;
        b=cefA9C+ALMPZUpL7GWqSjigAnV0oJwaurisjYWBJjcygWwldXQD0V2JSCbeoPLQCYf
         KPW6ffXprowlnSIbeaIP0Sk18HZuKlKj6PwahmOpu61PeGOs4cllaETH2RX5mQ2GFNiN
         7F2m60v4cuna7bDgre7BeaS5Vp2nIR/gWUjAKJxM2y0UWIP7HdgxIvW2itfs31RMfGzf
         FAGz/bhvgYEJAhtJSQ0G2CZfSD0rweXv+0wurAvYyp4wJg8imkzR2+pPaspSag4PmzeX
         FgqTwT5VD647rNNNHDX9PrRJUa+rQ8vZC6Xb/Wu6LloL9qnTGipR/rIyWy6Vrm3YhVkr
         +kSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z0ldi75Qxmf/1U674LURmWF9VZ6DTkH36S4dXcu3wNM=;
        b=J0xEQs+bme0H8x15zQuZKMCcvJFtVm4Cs/IlLlkWaCfcrhvnyAV7pDQdtArGqKFghz
         RMLTsgNJInMXx/HPlA1rN+x4SCX4msgSztpJcWXVVWa1coh3tgTypN4p7V9mV13kLYKl
         fHqGhncTeK0Uowbr5MvZi6plgfk9wWPilSBUX/Eg+ZISk2WobXLjvHwnMe4+xOUL13At
         NxYiJBMLR73dj6n9p5nqt+3ITHhzxCDKMxMZk2bDIPavq2Jx9hXv0v/MViVmmLg00NEe
         DXRshxI7JMdi6etsGSjAM9Iea0Wgxb4lvGitqtg0FxgKm7MhGXia00KaaYghmW2Et03b
         HUig==
X-Gm-Message-State: AMCzsaXGbjM3tYz3R7u7IH1OQTrYHcPbYjuf+H7BysO7F1rbiRItx3tD
        LFK1WqF7/Av/cHq5Ogt878n7Dg==
X-Google-Smtp-Source: AOwi7QA49tk974yGJ2i6tWdZLsYsdYrAeEw4q19R3O5HQJT6tViw7TWwmCBPHROfzylBnq7XjWyBKA==
X-Received: by 10.159.198.7 with SMTP id f7mr2718636plo.38.1507935365388;
        Fri, 13 Oct 2017 15:56:05 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:b031:5884:4d4f:f3a9])
        by smtp.gmail.com with ESMTPSA id 133sm4027632pfy.2.2017.10.13.15.56.04
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 13 Oct 2017 15:56:04 -0700 (PDT)
Date:   Fri, 13 Oct 2017 15:56:03 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, bturner@atlassian.com, git@jeffhostetler.com,
        gitster@pobox.com, jrnieder@gmail.com, peff@peff.net,
        sbeller@google.com
Subject: Re: [PATCH v3 07/10] connect: tell server that the client
 understands v1
Message-ID: <20171013225603.GE101395@google.com>
References: <20170926235627.79606-1-bmwill@google.com>
 <20171003201507.3589-1-bmwill@google.com>
 <20171003201507.3589-8-bmwill@google.com>
 <20171010113021.0a23506a5d1ebaf4e8ff1f9a@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171010113021.0a23506a5d1ebaf4e8ff1f9a@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10, Jonathan Tan wrote:
> On Tue,  3 Oct 2017 13:15:04 -0700
> Brandon Williams <bmwill@google.com> wrote:
> 
> > 2. ssh://, file://
> >    Set 'GIT_PROTOCOL' environment variable with the desired protocol
> >    version.  With the file:// transport, 'GIT_PROTOCOL' can be set
> >    explicitly in the locally running git-upload-pack or git-receive-pack
> >    processes.  With the ssh:// transport and OpenSSH compliant ssh
> >    programs, 'GIT_PROTOCOL' can be sent across ssh by using '-o
> >    SendEnv=GIT_PROTOCOL' and having the server whitelist this
> >    environment variable.
> 
> In your commit message, also mention what GIT_PROTOCOL contains
> (version=?). (From this commit message alone, I would have expected a
> lone integer, but that is not the case.)
> 
> Same comment for the commit message of PATCH v3 08/10.

I'll update the commit msgs.

-- 
Brandon Williams
