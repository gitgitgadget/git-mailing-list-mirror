Return-Path: <SRS0=O1OI=5H=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D6A4C1975A
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 23:21:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAFF22072D
	for <git@archiver.kernel.org>; Sun, 22 Mar 2020 23:21:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NqkUDuRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbgCVXVF (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 22 Mar 2020 19:21:05 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39584 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgCVXVF (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Mar 2020 19:21:05 -0400
Received: by mail-qk1-f196.google.com with SMTP id b62so4170068qkf.6
        for <git@vger.kernel.org>; Sun, 22 Mar 2020 16:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eQjb3U34l4dkTQebEbuVqYT1ssCvExCSRSxPdoLzpuc=;
        b=NqkUDuRXqqZRuYlcCOD6J0stLFmrHGrG+XbhnMVl3al6Va93+NxDcQH9P4b4e9gI1M
         PnitJ59rrlHlg2t9wKpqKLhXA01Lgyv+8fNCctxTJPw9zpy34+v1reTPQqZgzJS715uN
         6tYLCqsnEU+CNdUrLpOMbYKmtRsoQ1CDJmI0M5yxpogzrfrJUFg+q/ezcVkgJk5k3SWh
         A2Tt2WBkQUrVgDHynvbv5sAEYAIMwT+F2umsSj03mydxyLTrGz9cPnJF52M33prg4LGj
         rcNNWe1B1M/G+qD9FBNfpkBeMv2tojvbbVHgHXfO9q5+5765qYge4k4JIIrllHnngdwG
         bRyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=eQjb3U34l4dkTQebEbuVqYT1ssCvExCSRSxPdoLzpuc=;
        b=dMbexyWfp2yYc/CE4d9awOkJqaZ17bArjfPzL6BovXmRzpRNIjuo7ZKwsRDzKFrrCx
         8dU8vn4uZ5AKS4Ar28dgZSyUHzH/X/5H5i6uJW3kS5p0e8oz2Daub9z2qWiya7cngpaH
         cBRTxHg3hziPxbAeBLq9D7REJhPRuMiBWXpB6rooDGIQW2oLGgXt7OVtwT7SzsRTWcV+
         y9lLiwm5eqysmV8F0851oLzWHOZypYn49NSGIx9/AniMYunOsenVRBVT6T9W0xjVLLY+
         DZE/RoqCAKCGh1S/S7BM+OqEoHqzi3SLmHXtjrzFZAVP3TAuaBOfXJZsClVsaKegjUEW
         qCMg==
X-Gm-Message-State: ANhLgQ0g3iVE10GsLk5Pric2QYvFYDx/MUr7fscV+WupehvMuRnIkXff
        i61UrFRfvcuyyWzmB9FdUOM=
X-Google-Smtp-Source: ADFU+vs5IckwMMEpruSsmX7utdoLtJoIejJ7yeRuXGTDSGkWaQxd1GYFzTOHgrCkDYDrLnD0+7fJzg==
X-Received: by 2002:a37:687:: with SMTP id 129mr17833952qkg.321.1584919262600;
        Sun, 22 Mar 2020 16:21:02 -0700 (PDT)
Received: from [192.168.1.127] ([192.222.216.4])
        by smtp.gmail.com with ESMTPSA id v126sm9993332qkb.107.2020.03.22.16.21.01
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2020 16:21:02 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v3 4/5] doc: be more precise on (fetch|push).recurseSubmodules
From:   Philippe Blain <levraiphilippeblain@gmail.com>
In-Reply-To: <xmqq4kug804j.fsf@gitster.c.googlers.com>
Date:   Sun, 22 Mar 2020 19:21:00 -0400
Cc:     Damien Robert <damien.olivier.robert@gmail.com>,
        git <git@vger.kernel.org>,
        Damien Robert <damien.olivier.robert+git@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <818591DE-CD2C-4053-A9AB-49BFCEEBFA08@gmail.com>
References: <20200320213729.571924-1-damien.olivier.robert+git@gmail.com> <20200320213729.571924-5-damien.olivier.robert+git@gmail.com> <260F83FF-484B-438A-B70A-8348A5267877@gmail.com> <xmqq4kug804j.fsf@gitster.c.googlers.com>
To:     Junio C Hamano <gitster@pobox.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> Le 22 mars 2020 =C3=A0 19:01, Junio C Hamano <gitster@pobox.com> a =
=C3=A9crit :
>=20
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
>=20
>>> -	This option can be either set to a boolean value or to =
'on-demand'.
>>> +	This option can be set either to a boolean value or to =
'on-demand'.
>>> 	Setting it to a boolean changes the behavior of fetch and pull =
to
>>=20
>> I think in the context of patch 5 maybe it would be good to be
>> careful here, and state that this only affects the underlying
>> "fetch" in "pull", and not the whole pull ?
>=20
> Meaning that sub(sub)*modules are fetched but the merge is done only
> for the top-level superproject?  I guess it does not hurt to spell
> it out.  Good suggestion.

I simply meant that since this option is 'fetch.recurseSubmodules', it =
applies
to the fetching operation done by 'git pull' under the hood, and not to =
the
 "updating the working tree" operation that is also done by git pull if=20=

'--recurse-submodules' is passed to it.

Regarding nested submodules, both operations would recurse down the =
hierarchy:
the fetching fetches all (nested) populated submodules because of the =
call to=20
submodule.c::fetch_populated_submodules near the end of =
builtin/fetch.c::cmd_fetch=20
and the "updating the working tree", which is controlled=20
by the '--recurse-submodules' flag of 'git pull',  updates all active =
submodules =20
because it spawns 'git submodule update --recursive', (as per =
rebase_submodules
and update_submodules in builtin/pull.c).=
