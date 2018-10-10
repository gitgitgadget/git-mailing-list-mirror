Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D39E1F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 10:22:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbeJJRoE (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 Oct 2018 13:44:04 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:34223 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726022AbeJJRoE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Oct 2018 13:44:04 -0400
Received: by mail-qt1-f194.google.com with SMTP id o17-v6so5003750qtr.1
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 03:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGr2NEGJpNWueN3aXa5SpikCxF/Am0GI422+IjYhXfk=;
        b=FRpgi59HRLoNI3e4WCgWlPttA3d8Wvrfb+75sioTR5UQc//hnT5qmiaLmSsDvxek5K
         nH6xkV02gwu9pzSleEe6BKPEL6TiIdhSNbBbU21FAeOLT7tsCvtRRW3UcpS4aBbsG0K4
         5IQ5vSnIhAzVS633dQrV68C1rMcHSarDPAZmPHzeVarGjZeYa0YI/XUCH+svX9CZph6H
         BZRh7AgzXjQZaAeRkIpSyeVYlHM6ugVtQl9nLt03XKmRSu8UwUllnShJdKw9/K0EeI+N
         qo5UCraZTmkQNkZWbQ6OMNfPyMORL5zco+fn72PdsXnKOHglV/lQAx112Wv8zDcCbWkO
         mN0g==
X-Gm-Message-State: ABuFfojzVl5X4VdoemTfVf1Lx5mB2HSnTsb/6SaXVUP3rKB7dIy6cDS0
        T7F5OI+GlgMk3mUSF95LezlnjbhBGl0pNaERvrA=
X-Google-Smtp-Source: ACcGV61xBUTwhPfUWnmm3tH8nXLcEfzn9NWXzAHMngieA4pohfa5gUePt4t8iDlwlBNdQTtNgks6kOBAGevsYf5jPVU=
X-Received: by 2002:a0c:b3d6:: with SMTP id b22-v6mr26427658qvf.203.1539166954308;
 Wed, 10 Oct 2018 03:22:34 -0700 (PDT)
MIME-Version: 1.0
References: <20180912101029.28052-1-phillip.wood@talktalk.net>
 <20180912101029.28052-3-phillip.wood@talktalk.net> <CAPig+cTGYWoW+YiW5tJVPZVie3zsG+pmQiV7k+es-=y9e4=RZw@mail.gmail.com>
 <28505444-0798-6fda-6d1b-b9dbc0007123@talktalk.net>
In-Reply-To: <28505444-0798-6fda-6d1b-b9dbc0007123@talktalk.net>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 10 Oct 2018 06:22:23 -0400
Message-ID: <CAPig+cQg2OGkdjug-hqYWmxVs4d701ytHoe3aKf9BU7bKU=HOg@mail.gmail.com>
Subject: Re: [PATCH 2/3] add read_author_script() to libgit
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 6:14 AM Phillip Wood <phillip.wood@talktalk.net> wrote:
> On 14/09/2018 00:49, Eric Sunshine wrote:
> > What if, instead of exit()ing directly, you drop the conditional and
> > instead return the value of read_author_script():
> >
> >     return read_author_script(...);
> >
> > and let the caller deal with the zero or non-zero return value as
> > usual? (True, you'd get two error messages upon failure rather than
> > just one, but that's not necessarily a bad thing.)
> >
> > A possibly valid response is that such a change is outside the scope
> > of this series since the original code shared this odd architecture of
> > sometimes returning 0, sometimes -1, and sometimes die()ing.
>
> My aim was to try and to keep the changes to a minimum as this patch
> isn't about changing the odd architecture of the original. I could add a
> follow up patch that cleans things up as you suggest.

The code already had that weird mix of return(s) and die(), hence the
state is no worse after this patch than before. So, a cleanup patch
later in the series, a follow up series, or doing nothing at all are
all reasonable approaches. I don't insist on it for this patch series.
Thanks.
