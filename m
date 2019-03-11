Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C5CF720248
	for <e@80x24.org>; Mon, 11 Mar 2019 19:46:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbfCKTqh (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Mar 2019 15:46:37 -0400
Received: from mail-vs1-f54.google.com ([209.85.217.54]:42968 "EHLO
        mail-vs1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727008AbfCKTqf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Mar 2019 15:46:35 -0400
Received: by mail-vs1-f54.google.com with SMTP id c189so123681vsd.9
        for <git@vger.kernel.org>; Mon, 11 Mar 2019 12:46:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9g0REooAh+76B50uGD46ThcrIANuI+ihSx3lyxBRmT8=;
        b=VxbnHB7mVDHUD6a7IqWtQBA0jq56D70oIizQmgPr0R6EdjmGJsCTVlbmaNRWxVLPDe
         qFK9GVsNGRieX36nxIHm67snks3iYuuMGUaZnuk5fVoKKrvLkrmeOS2yNYb2t1/vSju5
         aDztHpNdPMhTloJED2ETv6eRMYAICzDg625PrIYtAlSylaTTAuIYf1DeCuAPB7zpLOXJ
         SGAm842ofvNWGEKWSymVF8TufmqABJkxlUGovy07hZ8WctGv1OAj0c8sHQ9JQozqwNDq
         6GOF7Zo9mHcSWCjhdUIuck3VQnHnwInj3F1BsEPa7QlbxT+4cvZ2v/gPxA0QqpOPnjUH
         ipOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9g0REooAh+76B50uGD46ThcrIANuI+ihSx3lyxBRmT8=;
        b=KWu4nm81rPnEOHvEgEql2wfNulVYXUFkFDOFwuUcPhaiF4vW5dD07kolPkfG6EgROu
         prNB+civ9qx7ipa1dRpnR1eyaWxYprFmiidn7zw1h5Kmb5yKua4s1PYINXIf35DGduRB
         rYrx6UZeZ8ti5OU8mEPAGmdgiBMjfONF3FAhgCbNxsf8IY/HIq86/fnjcsEq+aEwrOlU
         on4Bkrw7IfVHmyPA9XV3+rFfNjA3RntwwayLZXYshm9wvKGE3SnWzaauUyS4kWOS1x/L
         xUmLgwFz+g2ruv+aINB1GzYwi976tb1lXiqJNQrFL9wRlO/dVRNF8gXDnEZYBob+k1nB
         VhGw==
X-Gm-Message-State: APjAAAUDqxSvi329tjKcA1EmvRXAUl1urxbRjkD85zJZ4/expLZDkZt5
        lZLGSNFs/7TLaauvzoh2BGbiMTLhUOSKUc3krrM=
X-Google-Smtp-Source: APXvYqyj++J5Qv60x0SUlapvtJ0YnYoUnNKaepWosg24lkyMZ1IeM4YnonT+CPrt6ZU+L1KG3Z04kgJhEFuWmBeWch0=
X-Received: by 2002:a67:b145:: with SMTP id z5mr17439005vsl.53.1552333594181;
 Mon, 11 Mar 2019 12:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <DB6PR8303MB0069AA4D630BFDF0EC72C47BFD4D0@DB6PR8303MB0069.EURPRD83.prod.outlook.com>
 <CABPp-BF0PcdwpJR3NteCmQw0QhN3E0UAi22FvmjUc6SBr=UB_A@mail.gmail.com> <DB6PR8303MB006927B6267629467F783F58FD4D0@DB6PR8303MB0069.EURPRD83.prod.outlook.com>
In-Reply-To: <DB6PR8303MB006927B6267629467F783F58FD4D0@DB6PR8303MB0069.EURPRD83.prod.outlook.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 11 Mar 2019 12:46:22 -0700
Message-ID: <CABPp-BGs4E48bBQ0e94jxhoXv6t9nzwoNEEnb37tUBpTsi_mCw@mail.gmail.com>
Subject: Re: fast-import on existing branches
To:     Norbert Nemec <Norbert.Nemec@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Norbert,

On Fri, Mar 8, 2019 at 9:38 AM Norbert Nemec
<Norbert.Nemec@microsoft.com> wrote:
>
> Thanks, Elijah, I had indeed missed that block about the ^0 handling.
>
> I still don't get why this awkward workaround is required. Why isn't that=
 lookup done by default? Performance can't be the reason, since the same lo=
okup is done lateron anyway, just as correctness check. The way I read the =
documentation, providing no "from" should continue committing to a branch i=
n any case. I would never have seen the continuation of an incremental impo=
rt a "special case". There is a number of tools around that sync a git repo=
 from some other source and would regularly need to continue an existing br=
anch.
>
> Greetings,
> Norbert

If this "awkward workaround", as you put it, were removed it would
make it impossible to create a commit with no parent without using a
different branch name.  I really like being able to export, modify,
and re-import history, using something of the form:

   git fast-export --all | <edit the stream somehow> | git fast-import --fo=
rce

which would no longer work if fast-import automatically assumed a
parent for every from-less commit in the input based on the reference
name.  Personally, I'm more on the side of not understanding why
"from" isn't required whenever you want your commit to have a parent;
users can specify either a sha or a mark-id easily enough; I don't see
what it saves to allow omitting it, and it inevitably leads to other
confusion like yours.  But I'm well over a decade too late to advocate
for that.


Hope that helps,
Elijah
