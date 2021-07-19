Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCEFC636C9
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 07:04:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F68611AC
	for <git@archiver.kernel.org>; Mon, 19 Jul 2021 07:04:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234710AbhGSHHW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Jul 2021 03:07:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234441AbhGSHHK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jul 2021 03:07:10 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13E01C061762
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 00:04:10 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cu14so10911086pjb.0
        for <git@vger.kernel.org>; Mon, 19 Jul 2021 00:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=05839pMl3uL4Om47sV2pKjd0RZXF+Sx3OvshA9BzMv4=;
        b=hiR4IwwT5lxmsB/aQXugDr4XdZGzHgbyplZTGYwZwtCav6hufKCVlz6CKkCf1iobZp
         fqAfU7YECbO/GE2Gf+S9rkR/cQ3rXahLVtxDOxS1IrnFaOx7q3igX17hrpJc63qtTsVn
         RrIYFMKjQ6I+uDtwk0JSWt/tZc9H8CgRhkHgoKhDtvasZTXRVFm3vXW+hjKlqqcr4Q74
         LPQoW9EcXDAYEj6GVH6P3DeHAwM24XSKZrOXlOrEr4X40eODInOrwoeST6HmI2GqA3gr
         Qw5BdDRmTV9ADgyKFd/rytmwuBgEYqKNWNvZaDKFmPirQi/O61nuEMms2L6ZCeVXRnAH
         OBPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=05839pMl3uL4Om47sV2pKjd0RZXF+Sx3OvshA9BzMv4=;
        b=RCz1uCoMkvOF3f/jLP9HgMEyWXRaa2AnlMJXAaWU8m/KjFcRduSarj9A+MltQqySxh
         2MUdforz2Hspd+FzQvXtzfpwl2uoHC7qztSUK5PcoBdoalUlc2MqeOraw8T2q4urWrBc
         7DmxYpd7YyBhWTiWW1aa+812mq7cNYVfAMmycsxwg31sN/OPCSzrbgQao0UMB+g0OYYf
         o7cq9cKWquyoP61b2S83OYkee8NyyIImUt0f+HneAp6Oc7zL4KuWqD4vIllgtx9RebmA
         oruve6meqtyE2UsDIB/ifYSFjQINSvY/QEqdaVAD/EqGctSOuCKlamKDdtOZZqPqPuZ3
         MqLA==
X-Gm-Message-State: AOAM530NROVWEK5xM7Qe0YPjA+LRSpf+MY2T3BKvfdTp237hznnHxDZO
        zc50xPt6S/rqC52HLVKUi9c=
X-Google-Smtp-Source: ABdhPJx5iw/mMcJf7MVfUo/yDfWBBmpeCI8QVMoBnXmfGbX109QJkDliEUDynMhXeG2sNlDeFcv03A==
X-Received: by 2002:a17:90a:a390:: with SMTP id x16mr11243396pjp.148.1626678249597;
        Mon, 19 Jul 2021 00:04:09 -0700 (PDT)
Received: from smtpclient.apple ([119.82.121.47])
        by smtp.gmail.com with ESMTPSA id 19sm2087106pgh.6.2021.07.19.00.04.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Jul 2021 00:04:09 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.100.0.2.22\))
Subject: =?utf-8?Q?Re=3A_=5BGSoC=5D_My_Git_Dev_Blog_=E2=80=93_Week_8?=
From:   Atharva Raykar <raykar.ath@gmail.com>
In-Reply-To: <623770cb-d692-f61f-180a-33145caea97a@gmail.com>
Date:   Mon, 19 Jul 2021 12:34:05 +0530
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C8229C5F-1F47-4D44-A6C0-B291AF9BF612@gmail.com>
References: <CD6968A1-179D-4B77-91C1-4EECB1B69951@gmail.com>
 <f5b12a75-bdaf-fe5c-ffc2-7b4c8cdfddd6@gmail.com>
 <D3F13902-A7DD-4186-8444-45FD9260CBC8@gmail.com>
 <623770cb-d692-f61f-180a-33145caea97a@gmail.com>
To:     Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
X-Mailer: Apple Mail (2.3654.100.0.2.22)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 18-Jul-2021, at 23:09, Kaartic Sivaraam <kaartic.sivaraam@gmail.com> =
wrote:
>=20
> Hi Atharva,
>=20
> On 13/07/21 2:16 pm, Atharva Raykar wrote:
>> I was seeing if it was possible to at least save another spawn for =
calling
>> init when '--init' is provided for an update. The current =
implementation
>> does not spawn a separate process for this, so I was hoping I don't =
add
>> more overhead in the conversion, but it's looking hard to avoid at =
the
>> moment.
>=20
> I'm having some difficulties understanding this. I tried to take a =
look
> at the existing code[2][3] in 'git-submodule.sh', I could only see =
that
> if '--init' is passed to update, it calls the 'cmd_update' shell =
function
> which in turn does invoke 'git submodule--helper init'. OTOH, if =
'--recursive'
> is passed 'cmd_update' itself is called recursively called after =
setting
> the 'prefix' and 'wt_prefix' shell variables.
>=20
> So, I'm not sure how you mean to say that a sub-process was not =
spawned
> when '--init' is passed. Could you clarify this a little?
>=20
>>> [1]: =
https://public-inbox.org/git/20180205235508.216277-1-sbeller@google.com/
>>>=20
>=20
> [2]: =
https://github.com/git/git/blob/abb21c7263616f01c5e950861a29279ab21cb02f/g=
it-submodule.sh#L530-L533
>=20
> [3]: =
https://github.com/git/git/blob/abb21c7263616f01c5e950861a29279ab21cb02f/g=
it-submodule.sh#L651-L673

My mistake. When I wrote that paragraph, I had considered the shell call
in my head to be "git submodule init" and not "git submodule--helper =
init".

In the former case, there would be an extra subprocess because
'submodule init' will in turn spawn 'submodule--helper init'. So in =
short,
there would have been no difference between the two versions had I gone
down that route.=
