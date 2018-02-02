Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BBDCA1F404
	for <e@80x24.org>; Fri,  2 Feb 2018 23:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752118AbeBBXgo (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 18:36:44 -0500
Received: from mail-yw0-f196.google.com ([209.85.161.196]:32926 "EHLO
        mail-yw0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752084AbeBBXgn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 18:36:43 -0500
Received: by mail-yw0-f196.google.com with SMTP id x24so14454688ywj.0
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 15:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=gGXPAv60DdZbUf930l2rnuJ/EAzlyoTZkQcclq7I3rI=;
        b=rv1xNIMu5hV0opFCZhZve+yJm5RlQB79yI1/74ceyjiF4Ci9JEr9O6Mxc7a0u++jjC
         ERSs5CZaB0WIYvXFLf+6k+lEfXNnVYRUJA46zPwEBf9zJlworJY/DkNI6IdUY/AYt1d6
         b6flv/ISCq1qwQBowbo4S+U1/viLQnTX3osXyskz7k5WaPS3jIQLSu5pEp893IUhmH2f
         ITZ5yyV6KuWC+Q+13tESn5byUM+J3hzBYN9pGgvGkqPndKF3JZMqlt6Wf4wxUR/Q54mH
         x3trdZxbCXMGlOaw+ZC9paXubtqtBL5l3Bjj0SyOQ59i7dGYqEwLGNf5uHEb50FgnDtQ
         Q2Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=gGXPAv60DdZbUf930l2rnuJ/EAzlyoTZkQcclq7I3rI=;
        b=maXdWDmBmW8xNQM/2NJr5vyHzK7+X4c8BmzTaqHChbB661zih5R0rmCrFnyPpKa8+m
         Hl9vaT8ND0eCUN4iYT6ydfHtkC4RpnMZic730qvBvyo7XuYmBJJM4qro2Ap7qzv+W57H
         HVDG1RFPq/2rX67xISPiH5MRjCS/UPSQyrnUycUTQhpAVxN5RfeX/jvNkfMnWg7Nx3Js
         ciQn3U6D4CCVdWYwZjZsfrdgf2J0P0wh++HmtE6v2NRadu6okWjO75px37CNjM7Rijg0
         SNFmiTK5jJvQj5RJVDTQ59263ZrSAaaCZL1yxY4x0aDx8xXSCAn8POImxcvP11z+Ulso
         LmCA==
X-Gm-Message-State: AKwxytd/qTAvFgMEdm1IN+kWdMZYEEXvyKMVnT/jlfeo2XbeX+9urp/e
        UDcDFRdM4gh73+XDM+yc6SRRsu8GaMZK+OnYCq8ouA==
X-Google-Smtp-Source: AH8x225ivzRJJEelqkUbdHrrUJ9w4gLaKwrNg2AsBkOo41YA/nwCaPeyVWwL+7UPTPEfdNBDHRxUcXIxP6Xvmm2fnoA=
X-Received: by 10.37.133.12 with SMTP id w12mr20063108ybk.213.1517614602337;
 Fri, 02 Feb 2018 15:36:42 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.207.9 with HTTP; Fri, 2 Feb 2018 15:36:41 -0800 (PST)
In-Reply-To: <20180130232533.25846-14-newren@gmail.com>
References: <20180130232533.25846-1-newren@gmail.com> <20180130232533.25846-14-newren@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 2 Feb 2018 15:36:41 -0800
Message-ID: <CAGZ79kYid-XUrXdGPDW+wy8-xMPAz7Dj016Urz-wpG3F=Ae=hA@mail.gmail.com>
Subject: Re: [PATCH v7 13/31] merge-recursive: introduce new functions to
 handle rename logic
To:     Elijah Newren <newren@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 3:25 PM, Elijah Newren <newren@gmail.com> wrote:
> The amount of logic in merge_trees() relative to renames was just a few
> lines, but split it out into new handle_renames() and cleanup_renames()
> functions to prepare for additional logic to be added to each.  No code or
> logic changes, just a new place to put stuff for when the rename detection
> gains additional checks.
>
> Note that process_renames() records pointers to various information (such
> as diff_filepairs) into rename_conflict_info structs.  Even though the
> rename string_lists are not directly used once handle_renames() completes,
> we should not immediately free the lists at the end of that function
> because they store the information referenced in the rename_conflict_info,
> which is used later in process_entry().  Thus the reason for a separate
> cleanup_renames().
>
> Signed-off-by: Elijah Newren <newren@gmail.com>

Reviewed-by: Stefan Beller <sbeller@google.com>
