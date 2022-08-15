Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E06C00140
	for <git@archiver.kernel.org>; Tue, 16 Aug 2022 00:04:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351580AbiHPAEd (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Aug 2022 20:04:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354631AbiHOX7V (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Aug 2022 19:59:21 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770BC15E68D
        for <git@vger.kernel.org>; Mon, 15 Aug 2022 13:21:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1660594854;
        bh=zLNQr3yo4a6fMhn3DsFzfDQZStp5rK6ZK+8E0OmW+Jw=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=ZlDva1499BUbw95fKj2oEhViVgFV4zxVplJJp6zZ1usws/uDtY4+s7X9jTXoVNKlx
         Z9WThAaeicBjk2ilv/IpAI/qXYL4Ueesq10tCEETVJxYLUr6Xwh6ZfMXPX28kfAiRf
         R6KiMsKBdQCBDXGZOQA5A2E5ACVELzggylViGHbQ=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.25.183.122] ([89.1.214.151]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N6KYb-1nHfgd1x8b-016byf; Mon, 15
 Aug 2022 22:20:54 +0200
Date:   Mon, 15 Aug 2022 22:20:52 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Junio C Hamano <gitster@pobox.com>
cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Subject: Re: [RFC/PATCH] sequencer: do not translate reflog messages
In-Reply-To: <xmqqy1vt9ora.fsf@gitster.g>
Message-ID: <92sr80s2-6311-p065-755s-61s28s543q6n@tzk.qr>
References: <b8ab40b2b0e3e5d762b414329ad2f4552f935d28.1660318162.git.git@grubix.eu> <333bbaa9-d484-7c20-90d6-e64edf8a8248@gmail.com> <xmqqy1vt9ora.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:E4VfUFkMz4brP2dtDzaAJhKqKrIsn++X4jIz1EkjLrsTWAATDkm
 KttJl89jIP6YN1Nw0QraAs5jls5NGoyNoOmoTiR4n1L2aEPjU3uJ4/x4TpJVQAjeRcNzGCv
 0zUqNOkG/ObZBGJ5dOfaU2GiMstoGWNCb4mbiS5u81ASPHnlMQB6OnXdn6mML41kzC83DTM
 3vafvzxlqJiV8a3rrOlYw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TVKld5LXB74=:CADjIAD/vbbzxHbLF7VJj9
 mdh3xBnbncJW2NNlcViDFnIu7Y2vN4Vk64CibeX+V9adTZpVZB6WPx0hHbDik+aNaBpqCr1iB
 BsBeeb4ngIYdf8VJ+awJzsieHLMJvLyKyaQyrXTS6Iecp85XloqSw9owgOo9Vq6aawgdXOn5/
 LhWLaQTYEiqp2gAvues5Feho0cm3/xMXwEyfolQpGqeEnLC9bsB6bZZrA11TBGbdww6hEMNse
 jf+EdEzb26uNQgwdTJ7/rbhVcTMixZ08Km0Wqu5lwjV38ZPhrt24eoUy3ecShWkBx2+q0otwA
 xa7D+p2Z8KKLd1YdKiuYGzuCxgdtsY69FZ5sIuQ2t9SccofunEAv+gBkI7PqmsCN9pvwa17Ka
 68QvmSfLMKM57llHQ7h8g7hFAmwvVTl4edAHfaXdJU3KhEqrudxc9lVcIWqhKNQabhp4FbynI
 HHZn4c/O6gntzOukLRRC9SD995Ea8AObElKdJvPuySV0aJnloQQ+ypFT2JfuX0j59BFZBfIV2
 pLebzxaYvhVbjAYnZKhpk16leg8sTTsaSMn75QWF4csoC3hCWRPiz8HKw3Kqyx+gFfW1AxjgI
 53ZAbxOMKhvdgL0Qhskm8qc9RmkxQr2cooeiQhn0o757y/LZK3JwEkMOP4cCi7ntngnjpol0F
 QXpQw/mowUwmbhXEEGYzr1yYN5VyiA2OG6bI0DBu+uOtCGzUe67as8mSzdaZDwb8l2+AofW+K
 6ySnOwcSHWnGUgdtV3TaRjwZqmdjCL2URWsKCAwerOXExlHxiG9zU7Os+g6OqPIifP5i7cjhC
 QwM8zTRcvu0jtUoSHsd/J9ctUGRy0UC+XyW393D2GffMZjkEKCBwBq+unNQvfDh7wOGTfJxwT
 6nOdT/i7iQ14l3VT4IPWqaeDWNQSgPxuunPdJ9U6fIR1WMk/V7ooJfWiUXAUzyl+R5oENCCXF
 wtULobi/8UUN4xacWCUalriS+LtqTgQlNuXBrqgr4TpyY0uODCA40HHeOj13dR1tZOtJdLkUE
 tEP15sblRPGFeIYjJ7ocJDecXE43Hz7D1GL+korF0vPKx3uqJ0emrI4HtDPwg2fIU73+/ObJW
 WXMtv8VmlHDAOxZyQRj6FtoF/OmiPo3GxA7YSA/FckOsT1s0D0oh9kwJw==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Fri, 12 Aug 2022, Junio C Hamano wrote:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> > Removing the N_() stops these strings from being extracted for
> > translation, but there are several callers left that are still using
> > _() to get the (now non-existent) translated string. I only had a
> > quick look but I think we should remove the _() from all the callers
> > of action_name().
>
> Thanks, that's all correct.

I am afraid that it is not.

In https://github.com/git/git/blob/v2.37.2/sequencer.c#L502-L503, for
example, we use the value returned by `action_name()` in a translated
message:

	error(_("your local changes would be overwritten by %s."),
		_(action_name(opts)));

Michael, I am afraid that we need more nuance here.

I do see that https://github.com/git/git/blob/v2.37.2/sequencer.c#L4316
calls `action_name()` without wrapping it in `_(...)`:

	setenv(GIT_REFLOG_ACTION, action_name(opts), 0);

This suggests to me that the proper solution will be to carefully vet
which `_(action_name())` calls should drop the `_(...)` and which ones
should not, and to leave the `N_(...)` parts alone.

The affected calls seem to fall into these categories:

- reflog (do _not_ translate the action name)

- parameter of `error_resolve_conflict()` (do _not_ translate the
  parameter)

- error messages talking about `git <command>` (do _not_ translate the
  action name)

- error messages talking about the operation (_do_ translate the action
  name)

My take on which lines need to be patched:

- https://github.com/git/git/blob/v2.37.2/sequencer.c#L500
- https://github.com/git/git/blob/v2.37.2/sequencer.c#L538
- https://github.com/git/git/blob/v2.37.2/sequencer.c#L2384
- https://github.com/git/git/blob/v2.37.2/sequencer.c#L2392
- https://github.com/git/git/blob/v2.37.2/sequencer.c#L3715

but not

- https://github.com/git/git/blob/v2.37.2/sequencer.c#L503
- https://github.com/git/git/blob/v2.37.2/sequencer.c#L689

Ciao,
Dscho
