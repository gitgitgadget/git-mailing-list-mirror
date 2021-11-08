Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1DBFC433F5
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 18:21:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9733E61503
	for <git@archiver.kernel.org>; Mon,  8 Nov 2021 18:21:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235383AbhKHSYN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 13:24:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235228AbhKHSYM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 13:24:12 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BB2C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 10:21:28 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id m9so4924763iop.0
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 10:21:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=qneAUFYE1OUBK999fVlgXLw4at5IvoW2FZHKXz+c1k8=;
        b=l7H6uWimT8k34vjpUIargOe8bSWN717achg0UVWG9eigt5anyapAw/4i6EcupNEbMY
         QHOgQprfQs/eSG07QUW17JioqkNczS+JsZ0AxJn//Fo4Rru342aLhIMF6dgcW3YZwdpG
         60oti0+Gy4wydlyK4bnh8/NlUuON4DQPk2JfyoEh3EJbXwZg9Jy7+Tv8S/5a0rUxNRIO
         aA7zU6GF7Q8+69vz4k7/6LUBO/sK9Xyi+9LiaOnwLtLY+ZCn+YiNRAENfs3Yf1ZICR9C
         t6xINvcM0DqLsT/IRbA58cBxAIoZ3yPR7OmFFO8WAZsTzDPIlujybylOG2tiq/w9E4CV
         ysWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=qneAUFYE1OUBK999fVlgXLw4at5IvoW2FZHKXz+c1k8=;
        b=lftz2kxJOIKdZtcPXW4TlPcvSU4FUj934c/wPTZL1L721HyyE4NyvEkV0n7V5SHzvg
         cq+OuO/OZy4bnQ+K0Zm8QjiQVNs+oc7F1Cj3bZ0Fp0pAqJIzE/ABiHMF2dsiQM4KHGa1
         xKOdkaFPw+J3NTT2AKmiHdiGqtnMHXo2YXSIZMyWLgfzoCMShh76J6YABm2jJqkbRVV6
         nym1ihlqD4QSUk9wJEhlaj10ZCgnNqoDyV3mL5wnKJprVI36w7+5zDlul+KgzcPKGKaP
         TGN66VM9C0Ib4yLSOoZqauHC3b8uqoL1hVxKrZ76UDL/+HD2KnpGDWAMOkGqbx58P/OU
         KPhw==
X-Gm-Message-State: AOAM531WjfOrmjxp2z/dJET+uZYhvzqt0TDKZbhmG83kllBVJeeIg4n1
        jKlUetryWEcReDaXKorKlAomzZhj6SjVPiLX
X-Google-Smtp-Source: ABdhPJwOY9Pn11gTCfHypiRMfWAtXIXZNOh1kxpimj0XldXwIV5avcJZN/gM1nbwDT06FQ0wOAn3QQ==
X-Received: by 2002:a05:6602:258f:: with SMTP id p15mr737067ioo.87.1636395687632;
        Mon, 08 Nov 2021 10:21:27 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id w11sm8683974ior.40.2021.11.08.10.21.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 10:21:27 -0800 (PST)
Date:   Mon, 8 Nov 2021 13:21:26 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Elijah Newren <newren@gmail.com>, git@vger.kernel.org
Subject: Re: [Summit topic] Server-side merge/rebase: needs and wants?
Message-ID: <YYlqpuzv+bmZaFzz@nand.local>
References: <nycvar.QRO.7.76.6.2110211129130.56@tvgsbejvaqbjf.bet>
 <nycvar.QRO.7.76.6.2110211147490.56@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <nycvar.QRO.7.76.6.2110211147490.56@tvgsbejvaqbjf.bet>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was discussing this with Elijah today in IRC. I thought that I sent
the following message to the list, but somehow dropped it from the CC
list, and only sent it to Elijah and Johannes.

Here it is in its entirety, this time copying the list.

n Thu, Oct 21, 2021 at 01:56:06PM +0200, Johannes Schindelin wrote:
>  5.  The challenge is not necessarily the technical challenges, but the UX for
>      server tools that live “above” the git executable.
>
>      1. What kind of output is needed? Machine-readable error messages?
>
>      2. What Git objects must be created: a tree? A commit?
>
>      3. How to handle, report, and store conflicts? Index is not typically
>         available on the server.

I looked a little bit more into what GitHub would need in order to make
the switch. For background, we currently perform merges and rebases
using libgit2 as the backend, for the obvious reason which is that in a
pre-ORT world we could not write an intermediate result without having
an index around.

(As a fun aside, we used to expand our bare copy of a repository into a
temporary working directory, perform the merge there, and then delete
the directory. We definitely don't do that anymore ;)).

It looks like our current libgit2 usage more-or-less returns an
(object_id, list<file>) tuple, where:

  - a non-NULL object_id is the result of a successful (i.e.,
    conflict-free) merge; specifically the oid of the resulting root
    tree

  - a NULL object_id and a non-empty list of files indicates that the
    merge could not be completed without manual conflict resolution, and
    the list of files indicates where the conflicts were

When we try to process a conflicted merge, we display the list of files
where conflicts were present in the web UI. We do have a UI to resolve
conflicts, but we populate the contents of that UI by telling libgit2 to
perform the same merge on *just that file*, and writing out the file
with its conflict markers as the result (and sending that result out to
a web editor).

So I think an ORT-powered server-side merge would have to be able to:

  - write out the contents of a merge (with a tree, not a commit), and
    indicate whether or not that merge was successful with an exit code

  - write out the list of files that had conflicts upon failure

Given my limited knowledge of the ORT implementation, it seems like
writing out the conflicts themselves would be pretty easy. But GitHub
probably wouldn't use it, or at least not immediately, since we rely
heavily on being able to recreate the conflicts file-by-file as they are
needed.

Anyway, I happened to be looking into all of this during the summit, but
never wrote any of it down. So I figured that this might be helpful in
case folks are interested in pursuing this further. If so, let me know
if there are any other questions about what GitHub might want on the
backend, and I'll try to answer as best I can.

Thanks,
Taylor
