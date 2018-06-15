Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F02BD1F403
	for <e@80x24.org>; Fri, 15 Jun 2018 22:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756705AbeFOWDS (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Jun 2018 18:03:18 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:33043 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756665AbeFOWDR (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jun 2018 18:03:17 -0400
Received: by mail-ot0-f195.google.com with SMTP id h6-v6so12611092otj.0
        for <git@vger.kernel.org>; Fri, 15 Jun 2018 15:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=l4V/oHx91wCKzTis0eChcOlUcCD6KWiLGemVosweTzA=;
        b=Iq9DENiMlPyXayd5FchA7hDFVUHIEnc25OQY2vgQ9veE/vzJA1RgOSlkdv3jMd7CO4
         zmri2J8IAf8z1mrivn+AgoV7W18TFcHznDuC4w9IpSLGhaGxhm115nDqlpzH7h60FD/Y
         f9amCRR5IcMPweZ9bobBHMFffp65ITLzQmI3A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=l4V/oHx91wCKzTis0eChcOlUcCD6KWiLGemVosweTzA=;
        b=jC0D5HN3IiC190/tvqTOS9jtc5hD+gWrzvaars6BsCo1kml83lIGxo9YAKEjzS8J9a
         8SmP2zXr8Fz4+sbxrUn7gqo9jHDIqDpa4fQYxiHJkNJzb1CgSPVsIhLL5Tq2hdfvy2cC
         H3RryD2EhmmIFUtIivSyv8gkfXPASxwmPZGeaOZLvfb24FbvhrkotEw/IZjAq2ncSfUQ
         F3fUiv1dhzX5Ecfed75RVinnpLCDxTzsCBl1P5qx++d2aL99tUDC3tmWUIn8B5WgNyLk
         d7etHlBLD5lRcOQCPYJm1AJONdhp2Xtnc8UgBTGU+Kc0LPDwW90s6i+Fd+vo2wAskE1U
         afgw==
X-Gm-Message-State: APt69E0FbSfgrff20KXhHAMxJ9gi9skHxoBP3avm78U3T/MaBhSoakIh
        6e/VJcuO5LQ1xV2ykN5yoM9IPznbvoSjzr7qivzdPg==
X-Google-Smtp-Source: ADUXVKLIIVg7CVIWFJ5UV0ZLs0Gt7xHla5AxefTlTbiEyBSJJSWuJ9CVkVNbx5C/oINleC4qgVfnUn0jrGjuL6p0QAM=
X-Received: by 2002:a9d:3898:: with SMTP id p24-v6mr2274287otc.267.1529100196339;
 Fri, 15 Jun 2018 15:03:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2f8e:0:0:0:0:0 with HTTP; Fri, 15 Jun 2018 15:03:15
 -0700 (PDT)
In-Reply-To: <20180515100129.1454-1-luke@diamand.org>
References: <20180515100129.1454-1-luke@diamand.org>
From:   Luke Diamand <luke@diamand.org>
Date:   Fri, 15 Jun 2018 23:03:15 +0100
Message-ID: <CAE5ih7_u+XrBCeozTORmQXFhBt_Gsh392E0n+yt8_PTz0A9Dxg@mail.gmail.com>
Subject: Re: [PATCHv3 0/1] git-p4 unshelve
To:     Git Users <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Merland Romain <merlorom@yahoo.fr>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Luke Diamand <luke@diamand.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15 May 2018 at 11:01, Luke Diamand <luke@diamand.org> wrote:
> This is a git-p4 unshelve command which detects when extra
> changes are going to be included, and refuses to unhshelve.
>
> As in my earlier unshelve change, this uses git fast-import
> to do the actual delta generation, but now checks to see
> if the files unshelved are based on the same revisions that
> fast-import will be using, using the revision numbers in
> the "p4 describe -S" command output. If they're different,
> it refuses to unshelve.
>
> That makes it safe to use, rather than potentially generating
> deltas that contain bits from other changes.

Having been using this, when it works it's great, and it's nice that
it errors out rather than creating a garbled patch. But it would be
really useful if it could somehow automatically build some kind of
diff-base for fast-import to use.

Doing so is probably not that hard given that it already knows the
versions that it wants for the error reports, but it's not completely
trivial either. I think you'd need to get the list of base revisions
you want, then hijack the P4Sync class to generate a commit via
fast-import, then feed that to the next stage as the base commit. I
think it would make sense to see if anyone other than me actually
cares!

Luke
