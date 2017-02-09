Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B82B31FCC7
	for <e@80x24.org>; Thu,  9 Feb 2017 17:12:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754082AbdBIRMZ (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Feb 2017 12:12:25 -0500
Received: from mail-io0-f174.google.com ([209.85.223.174]:35866 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753704AbdBIRMX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Feb 2017 12:12:23 -0500
Received: by mail-io0-f174.google.com with SMTP id j13so22040233iod.3
        for <git@vger.kernel.org>; Thu, 09 Feb 2017 09:12:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=UYknPmuN8+gI8Hd4Hb9x9m02CxB3ddB7ZN+zRZN4Htk=;
        b=BHdvpBqRzPbjthxWfZgvFWsZcggkCjSH97QHZ0wt560pYFnTrIDNGSqTyDZyVUlQeq
         oqFt0a9WAgAjG7SBy3Jo0QvofcOVOv4YXFajnPICiLescj/D5Q47tEv43jT7aMCZBGeu
         swXBpP82Hp/gc/zkI8cZ4m4eMfnGyz7JJ5JcVZ4Kh2zZhtBLKqIm/NFXjeesR467OR1O
         aM6X2PsKO/rzBRk5LN5uytYtNzrEippNF7c3BVk6sDEbSbe20EnIH+qeTFaQVxHX2Q9/
         PBpU1AzMyTVQNTngiXJx5F6I834t5M5AgKXNUMhgWaIyr+lQ+jn/4G/GnIWbcZOnc2z8
         6giw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=UYknPmuN8+gI8Hd4Hb9x9m02CxB3ddB7ZN+zRZN4Htk=;
        b=m4w01bnRCqQKm5ewjsStyB34dx1tTP5hIeoRxIqoojSCvyc2vO8ICiAXxMswZyo0cy
         9ZjujzqCmqGug7A2RQPt02+H0JI28Yb+EL/RCL6+13KH843RfUELtVIbSAL3h3cdHtZ1
         I4OTfucTR5wdaUi0SrPp47JpE7I6K8/z0M8d40i06US+ee1EIUaZSIEhlEhSOLHuYCRD
         it5dD8Y5GYTF8It3Y+vLaSdvQN68MoYozcdeA4+IrOlBE+wtM4zcwIIML63k+Uny1ElR
         WA4kGHReb4ZPKXHJz94Jva68SXcvVRcb7/Z99BjHTCKdNwc5zo62gOrOZXTvnu2bka7H
         h82w==
X-Gm-Message-State: AMke39nWsUaErPTBMIoVtSqLHwpv5MIqW5+l3En6kDrWVrQuYntoZWP0bqODci1Jf3kdMmMdgvhlDAF+x90qqN/w
X-Received: by 10.107.3.160 with SMTP id e32mr4223404ioi.52.1486659810496;
 Thu, 09 Feb 2017 09:03:30 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Thu, 9 Feb 2017 09:03:30 -0800 (PST)
In-Reply-To: <8958e7e26cc8bf11a76672eb8ea98bc9ba662fdc.1486629195.git.mhagger@alum.mit.edu>
References: <cover.1486629195.git.mhagger@alum.mit.edu> <8958e7e26cc8bf11a76672eb8ea98bc9ba662fdc.1486629195.git.mhagger@alum.mit.edu>
From:   Stefan Beller <sbeller@google.com>
Date:   Thu, 9 Feb 2017 09:03:30 -0800
Message-ID: <CAGZ79kYiXL5sNcLCjfmCHSL11u9sVi+Uv7hM93AX7yH3iO=7TA@mail.gmail.com>
Subject: Re: [PATCH 2/5] refs: push the submodule attribute down
To:     Michael Haggerty <mhagger@alum.mit.edu>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <novalis@novalis.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 9, 2017 at 5:26 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
> Push the submodule attribute down from ref_store to files_ref_store.
> This is another step towards loosening the 1:1 connection between
> ref_stores and submodules.
>
> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>

Looks good,
Stefan
