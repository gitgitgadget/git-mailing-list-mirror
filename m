Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DDEAC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 20:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240821AbiA0Uxf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 15:53:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240138AbiA0Uxf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 15:53:35 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E951EC061714
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 12:53:34 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id c192so2792805wma.4
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 12:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google;
        h=mime-version:content-transfer-encoding:date:message-id:to:cc
         :subject:from:references:in-reply-to;
        bh=KhOAx1L3naEHtpFkj4vNjtl/4nm+wrMJy++28n9pAoM=;
        b=XknSNijIomUJVoPnR7cSADiDGTsJ0PsfXF8R4iGTv3uy9FfaRFjOW5MFB/U0VVwjx4
         UKPu38cgOV1XDKx3xQUDe78idtBSd/LpTBI/KgP3w1aE3/RzLq03uV61dj6rBtIUrL9f
         /buoEi9zwLP4EKF/MXdahzHXY1gbpUeOyWRtjQxpFXKrU0qJkqwwjLgkQFK1fMc4604Y
         LoQN72rojUJt5VcimQL/a9SijBMDplJjr7a8Y+5EVR6FbG7EUX3nRPmVqPsHTXahTP+x
         +7v2s3iH1U8qL68ujNmcGhoiw710O4MyOtltQy384V9fE0DSHLF9AB7aHtTzEO8V84jP
         E+RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:content-transfer-encoding:date
         :message-id:to:cc:subject:from:references:in-reply-to;
        bh=KhOAx1L3naEHtpFkj4vNjtl/4nm+wrMJy++28n9pAoM=;
        b=5gOq8dJIf0AjoTbzWekPJc/QPW3XQbpiRu1Tnz/vJAmBd21rfsYdJtcWkiXym0XSrz
         zqnbXtFNWYMNh/yicOOVM4d0hzlYbYJmmyGNNpxGPNsWon5HfgB7PVG0wQkQdtOWbfZK
         VjId8aEk2gkwvjBEHVA4TGAYGyMJWSC5aS2WE3abz+5d4dODlzJSBEP17P5GouqztVik
         FWIMcCbxdRu86glUNzpy5ji5JF3OSgun+Zo1lthQKYCVRW+pSR4OLvYxxCKFt9rKYrBk
         v7JNokSsgvXX54e4elcTc4iNPYhKoUie6K4kAkwUZYL8xzOz92xj6niUIVeMuHI5OVdx
         dc+w==
X-Gm-Message-State: AOAM533iNL7sD7kvzDzoar2hzMimOZBXoP82jseW2NUc8xcfZqZGdGI3
        /IFhXgQKXj3qaRD3hlfkIzziKQ==
X-Google-Smtp-Source: ABdhPJzcrO4HMWAoPCLQmp/X0ASh56J9zMQKS42jJYwdUWqK5lLiXRaSoAEPWEWV5bD46sICda1ZWQ==
X-Received: by 2002:a1c:a302:: with SMTP id m2mr4786760wme.84.1643316813478;
        Thu, 27 Jan 2022 12:53:33 -0800 (PST)
Received: from localhost (2a01cb000f483e004bf57bbe4fddc0d6.ipv6.abo.wanadoo.fr. [2a01:cb00:f48:3e00:4bf5:7bbe:4fdd:c0d6])
        by smtp.gmail.com with ESMTPSA id a24sm282038wmm.31.2022.01.27.12.53.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 12:53:33 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 27 Jan 2022 21:53:32 +0100
Message-Id: <CHGR6XNP6TV7.15VGVNQUJM9J6@diabtop>
To:     "Junio C Hamano" <gitster@pobox.com>
Cc:     "Emily Shaffer" <emilyshaffer@google.com>, <git@vger.kernel.org>,
        "Nicolas Dichtel" <nicolas.dichtel@6wind.com>,
        "Patryk Obara" <patryk.obara@gmail.com>,
        "Jiang Xin" <zhiyou.jx@alibaba-inc.com>
Subject: Re: [PATCH v2] receive-pack: add option to interrupt pre-receive
 when client exits
From:   "Robin Jarry" <robin.jarry@6wind.com>
X-Mailer: aerc/0.7.1-30-g7edcc9f79409
References: <20220125095445.1796938-1-robin.jarry@6wind.com>
 <20220126214438.3066132-1-robin.jarry@6wind.com>
 <xmqqv8y54wxc.fsf@gitster.g> <CHGCP9P33XDQ.3FEWHU0PBMNU6@diabtop>
 <xmqqr18t2fxl.fsf@gitster.g>
In-Reply-To: <xmqqr18t2fxl.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano, Jan 27, 2022 at 19:26:
> Sorry, but I was (and am) questioning why we want to do more than
> "let it be killed by SIGPIPE, just like we used to do before
> ec7dbd14 (receive-pack: allow hooks to ignore its standard input
> stream, 2014-09-12) introduced the current behaviour", so the answer
> is still "why do we even need to complicate the thing with keepalive
> or anything we don't have, and we didn't have before ec7dbd14, in
> the code paths that are involved?"

My main goal is to abort a push if a user hits ctrl-c (or is
disconnected) before the objects have been moved to permanent storage.

(partially) reverting to previous behavior would only allow aborting
pushes *if* the pre-receive hook sends some output and this output
cannot be forwarded to the client. There is no guarantee that the hook
will send any output. Also, it would restore hard to track issue with
poorly written pre-receive hooks.

I wonder if it would be possible to not rely on the pre-receive hook
sending output and this output somehow not being forwarded to the
client.

Instead, explicitly check if the client is still connected and alive
after the pre-receive hook has exited but before completing the push
transaction. That was my intent with that (invalid by the way) keepalive
example.

I do not know git internals to say if it feasible without any protocol
breakage. My attempts work well for aborting pushes:

 Writing objects: 100% (3/3), 321 bytes | 321.00 KiB/s, done.
 Total 3 (delta 1), reused 1 (delta 0), pack-reused 0
 remote: pre-receive start^C
 <--- client has disconnected
      receive-pack fails to send the "keepalive" packet
      the temp objects are *not* migrated to permanent storage

But this always leads to errors on the client side when receive-pack
sends the "keepalive packet":

 Writing objects: 100% (3/3), 321 bytes | 321.00 KiB/s, done.
 Total 3 (delta 1), reused 1 (delta 0), pack-reused 0
 remote: pre-receive start
 remote: pre-receive end OK
 error: unexpected flush packet while reading remote unpack status
 error: invalid ref status from remote: unpack
 remote: post-receive start
 remote: post-receive end OK
 To git@host:repo.git
  ! [remote failure]    main -> main (remote failed to report status)
 error: failed to push some refs to 'git@host:repo.git'

Am I chasing rainbows or is that possible in the current state of the
git protocol? Maybe I need to send the keepalive packet in a sideband?
I have read the technical docs several times but I cannot understand how
everything works properly.

Thank you for your time.
