Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 459F6C433F5
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 14:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244986AbiATOCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 09:02:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbiATOCR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 09:02:17 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B71C061574
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 06:02:16 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id z22so28970375edd.12
        for <git@vger.kernel.org>; Thu, 20 Jan 2022 06:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=V3x51abXtmSLWIvtdcWQWQ3+q8gDRItpyAxxnlSk8kE=;
        b=Hb0D68orYHSL0/cIc4pqxTVF37fdQD567N1l21uniu1IKwf236/O3zBX0LyZ/kBeXZ
         HFVJJd8sug9wpztBQ6laZh8EE3t/1S9fXwALFIy7XzBF+zW5dtMTsKIsNRwsfi7vaHHk
         UKYzJvlWiiHGU0hLG0BIM36C1koeQNIUjsYo9oRqgBApcgyR9BIt7NIYP3oXhjeJCZXg
         WItV3JhHdtAVgx/R3MLZTPiebPSPGXHL2duReAlKH+RhFjNb/onA+suWJ//+B49NzCan
         zUE5zi1V8ftKe8fltM2p71/e9/oPDJ4cmUSGhlk81qxtQroSwah0i1weRHbwnO0Mx16O
         KzbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=V3x51abXtmSLWIvtdcWQWQ3+q8gDRItpyAxxnlSk8kE=;
        b=50SV/JSdfz3kX02l7jwa63geKB8L3xfaXmyhD/lUoFInAivulzhJArZQ3u+x/ODz9K
         6to8dTTizhZuzHIoLdkYIaiJJ9eT58QtdKLaQyz6b+VPnkmZ5bZiN8Q/jGmrShEbeYyQ
         Bq1FQYJBa4tn26iJKBT8Z9GHSOIdmtmYeX7f5z+H6XzzN5ffZlhNVfAoRtxzU7pV2Cmu
         Uv7Jt1dx/b9EGzL+9HkQlcrfnBv+XxFkTfgF/3KUWK1LaBBk8MIbPhVQgVrHTOut2CCx
         UHdcM1nHFw8GH4RI7et89P+b+3zU18xguHuDsfljkPMxLARBTZFBXqnHvjp0WXu7o5Ke
         5/VA==
X-Gm-Message-State: AOAM5308iffm+99ahLypM7Kvp4M+iwCMk3ffiKuiX9xNhjo0eCgURwTZ
        ASnCLE7NUinxZxKLux/3+P5subFbWgIEug==
X-Google-Smtp-Source: ABdhPJy6B14GB4pHvJjfhFVqYt8ktIunwt46XMegrQfwkuNplH4ymJxkkyQOTWlUNOn7PZ6/58OIgQ==
X-Received: by 2002:a05:6402:4490:: with SMTP id er16mr35663471edb.203.1642687334560;
        Thu, 20 Jan 2022 06:02:14 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y23sm1343446edo.31.2022.01.20.06.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 06:02:13 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nAY0z-0021Xh-FS;
        Thu, 20 Jan 2022 15:02:13 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andreas Schwab <schwab@linux-m68k.org>
Cc:     Josh Steadmon <steadmon@google.com>, git@vger.kernel.org
Subject: Re: [PATCH] branch,checkout: fix --track usage strings
Date:   Thu, 20 Jan 2022 15:00:33 +0100
References: <220111.86a6g3yqf9.gmgdl@evledraar.gmail.com>
 <3de40324bea6a1dd9bca2654721471e3809e87d8.1642538935.git.steadmon@google.com>
 <220120.86zgnqli9v.gmgdl@evledraar.gmail.com> <877dauy512.fsf@igel.home>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <877dauy512.fsf@igel.home>
Message-ID: <220120.86r192ld3u.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 20 2022, Andreas Schwab wrote:

> On Jan 20 2022, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:
>
>> With that we'll now emit:
>>=20=20=20=20=20
>>     $ ./git add -h 2>&1|grep chmod
>>         --chmod[=3D](+|-)x      override the executable bit of the liste=
d files
>
> That looks like --chmod+x is valid, which isn't.

Indeed, it should be --chmod(=3D| )(+|-)x in that "else" case.

But I think the rest of what I pointed out still applies with that
amendmend. Thanks!
