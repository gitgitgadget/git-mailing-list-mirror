Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F597C433EF
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 011AB60E8F
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 22:44:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231460AbhJ1Wqz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 18:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbhJ1Wqy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 18:46:54 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7A6BC061570
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 15:44:26 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h2so8602678ili.11
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 15:44:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=fJRMGniHaGNLdejZ3r1CakuDIWuC55hmiio4hhY7gs8=;
        b=QwTw68dQYtrGMTp2LnfTQcRS7iS5Zk78kO+wGHSg9mAKIATk5yGgHXiPKplUUME2KG
         eQ+v3ET84vOE20jFEfCCge/8GIi9PiF9A2whqYJ2IqKQ9J/v8+fAN+8qlqPIfGQSCHq4
         anIHjSyyVKZY9uw2DwmN7tdinNKqlzn+/Qy0eFvoegW/RIK1vyI+tMtxsspy2mf9XD3E
         XKJO+E0lbVw73EdpeyFGtKPNfSfJ44+miCR9MAhT0tMgJtAQzZWUvqRkktfIOVkQE0eB
         oNZn4xRsOCPExJ8Obt0ZaM0ATi9ryfcwBn+Lh2ICd05QhvF7CX3yNQMd4RSD5XvoeJeF
         XGDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fJRMGniHaGNLdejZ3r1CakuDIWuC55hmiio4hhY7gs8=;
        b=TG92McuTQHTQj1qi6gT8jXCgC1xXhkyXhcLpEPBrFMj/YSI57whOnC+hDXr8l5nsPJ
         ze/COzK2w/IrQa2+orOqnu3T3gNmD5l+W9l09iuCCSYHYxwqUNuHGz5MpN0HBtwhAMjD
         uikq5IwoZo/Loiiw6BdX9QNyf/4jhlJSQOhcErdfc/v0qdkAT0ME2TBotxd4Kv3ZTcba
         5KpGYOgnurz2RZ0s+qScwZapMjm1bgrvx1NiFILj7aE3Qe1LOsqXcmQ/4sQ+Q+IzUjgc
         z/sjOBHQidFjsIRAOdamcqOPc+d3/DQeTajZpu1ARaO+PRYacnKvPUFpYsukSYukiar2
         gnRQ==
X-Gm-Message-State: AOAM531dxZkXtdcN1zNJCZAt/zci78Sn/On6b6bPZROQVYk67rhFOEjo
        EtNlcynCqTrrVmCwS1nNsJtT4CnKBgvFcKMH03GFwg==
X-Google-Smtp-Source: ABdhPJwdEH4SsAPRUxFEcTyHytE0ihQolPdzN4fXicJDbZV4fW/InszjeWR/ECAzXZH2ubhibZ0EWS012I3a7keFwEc=
X-Received: by 2002:a05:6e02:168b:: with SMTP id f11mr5053640ila.260.1635461066167;
 Thu, 28 Oct 2021 15:44:26 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1052.v3.git.1634684260142.gitgitgadget@gmail.com>
 <pull.1052.v4.git.1635288599.gitgitgadget@gmail.com> <c7f0977cabd4ba7311b8045bc57e9e30198651fd.1635288599.git.gitgitgadget@gmail.com>
 <211028.86sfwlw10o.gmgdl@evledraar.gmail.com> <CAPig+cTKSp28oUvESCWLB+OLBjbUSt3vhz6n3eVmkfYf9arcrg@mail.gmail.com>
In-Reply-To: <CAPig+cTKSp28oUvESCWLB+OLBjbUSt3vhz6n3eVmkfYf9arcrg@mail.gmail.com>
From:   Ivan Frade <ifrade@google.com>
Date:   Thu, 28 Oct 2021 15:44:14 -0700
Message-ID: <CANQMx9VAgj8hLkd2+hqRHdD2+zNQ8T0jUTqpzmJE65Z2UtTnDQ@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] http-fetch: redact url on die() message
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Ivan Frade via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Oct 28, 2021 at 10:26 AM Eric Sunshine <sunshine@sunshineco.com> wr=
ote:
>
> On Thu, Oct 28, 2021 at 12:46 PM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
> <avarab@gmail.com> wrote:

>
> > nit: die() messages should start with lower-case (in CodingGuidelines),=
 and I think it's better to quote both, so:
> >
> >     die("unable to get pack '%s': '%s'", ...)
> >
> > Or maybe without the second '%s', as in 3e8084f1884 (http: check
> > CURLE_SSL_PINNEDPUBKEYNOTMATCH when emitting errors, 2021-09-24) (which
> > I authored, but just copy/pasted the convention in the surrounding
> > code)>
>
> Note that this is not a new die() call; it just got indented as-is by
> this patch, so the changes you suggest to the message string are
> potentially outside the scope of this patch. Possibilities: (1) make
> the changes in this patch but mention them in the commit message; (2)
> make the changes in a preparatory patch; (3) punt on the changes for
> now.

I went for option (1). It is a minimal change and we are moving that
line in this commit.

Ivan
