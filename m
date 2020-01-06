Return-Path: <SRS0=yIgW=23=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35DF1C33C8C
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 19:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062BD2072E
	for <git@archiver.kernel.org>; Mon,  6 Jan 2020 19:20:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OrkQQ6Us"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbgAFTUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jan 2020 14:20:22 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:42178 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbgAFTUV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jan 2020 14:20:21 -0500
Received: by mail-pf1-f194.google.com with SMTP id 4so27376326pfz.9
        for <git@vger.kernel.org>; Mon, 06 Jan 2020 11:20:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HIzcQtKz3fX5Kdp0ZikneceCO6VsT/5CN+cqnDzqzKM=;
        b=OrkQQ6Us8NBwOrRq7mIMm1vFSZLp1YoWH1HBVdG4smN7SRd5HY3rVaDn/tEdMmGQYi
         C24Q/0KIdF0WLZqd56GGBz3p7mGZNJg96d+uUA1Gz9m29yB3sbdN02j+2XwYSnPPsmlM
         4xAxG8Rx3VLhuoKUvtnAlvukKTzUmAhW8wvsnhUV2VBJBiOQ7wAH85rH7cz0kiQk4Sxo
         2/RyiAl1CMYBviNN7QYYwmnGMR7btw20q2FGof5Y9vrkxk2oE1dWj/4U1kDPu96gUmrF
         vVusXnzwBVyEJqnGUJHOTj+Nqe5L1jdBZ54pOZzYBrXXqXcxIjIczE1y4mbop0OsJw0u
         ksgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HIzcQtKz3fX5Kdp0ZikneceCO6VsT/5CN+cqnDzqzKM=;
        b=ZfzEPPWMQ8oPFy1CxVThZvpa2E2oXCiVHFKE5hYvBVH86PTtYLw0IIrf0Wipj1l1IJ
         P50NI/nMxxXJRbAabHrdhV5vh4lr25+E8VRYW/oFrXq7PK8lnR4tZRODv1y98rV7iBW7
         /ZgozfNjlGZSiyfilpZctSR1/orw5zUdIp8924ND7qu90m/lCGBZE6eQ/dE9jcrLabox
         ZbQ/YW87ZfZpKpJaH89nf4hDb+vw5UwWrCMb6mxHFXnyUS2RF7VYd+d3QwSxfIHSn13J
         oyzIUqMC0B9a5Zmn7HdvaliJowlltcObPkXzCrPrgavg2eZ3bmlwIJiDx0qbwf8/AQz1
         qTMQ==
X-Gm-Message-State: APjAAAXCuutG9MuAFrbdfKcPaQRQoGaa6mHTESFtXKYux8O9Nlc92x/q
        SLzMZY84P7IsGkduFVytxhVcCV3zR78qwxOtk9NyKS8Gf+Y=
X-Google-Smtp-Source: APXvYqyxNrq1HLxOsKyuj6jvcQ+CDwede15KLPqlaHS9kGEvqahdu8s3Er/aXiOwQbUcEZ4Lhmiw3rkruar50Cs3fP8=
X-Received: by 2002:a63:5243:: with SMTP id s3mr108902867pgl.449.1578338421055;
 Mon, 06 Jan 2020 11:20:21 -0800 (PST)
MIME-Version: 1.0
References: <pull.511.git.1578326648.gitgitgadget@gmail.com> <xmqq7e24a3t0.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq7e24a3t0.fsf@gitster-ct.c.googlers.com>
From:   Mike Rappazzo <rappazzo@gmail.com>
Date:   Mon, 6 Jan 2020 14:20:09 -0500
Message-ID: <CANoM8SV=pT3sFrfnEqWc2xBn_c2rES0qSMsdptF0DgcxgYL94w@mail.gmail.com>
Subject: Re: [PATCH 0/1] sequencer: comment out the 'squash!' line
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Michael Rappazzo via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 6, 2020 at 12:34 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Michael Rappazzo via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > Since this change what the expected post-rebase commit comment would look
> > like, related test expectations are adjusted to reflect the the new
> > expectation. A new test is added for the new expectation.
>
> Doesn't that mean automated tools people may have written require
> similar adjustment to continue working correctly if this change is
> applied?
>
> Can you tell us more about your expected use case?  I am imagining
> that most people use the log messages from both/all commits being
> squashed when manually editing to perfect the final log message (as
> opposed to mechanically processing the concatenated message), so it
> shouldn't matter if the squash! title is untouched or commented out
> to them, and those (probably minority) who are mechanical processing
> will be hurt with this change, so I do not quite see the point of
> this patch.

This change isn't removing the subject line from the commit message
during the edit phase, it is only commenting it out.  With the subject being
commented out, it can minimize the effort to edit during the squash.

Furthermore, it can help to eliminate accidental inclusion in the final
message.  Ultimately, the accidental inclusion is my motivation for
submitting this.
