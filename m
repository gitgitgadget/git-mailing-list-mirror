Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2D5CDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 22:19:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233784AbjJKWTx convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Wed, 11 Oct 2023 18:19:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbjJKWTw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 18:19:52 -0400
Received: from bird.elm.relay.mailchannels.net (bird.elm.relay.mailchannels.net [23.83.212.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E4B9E
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 15:19:50 -0700 (PDT)
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E78A52C24FB;
        Wed, 11 Oct 2023 22:19:49 +0000 (UTC)
Received: from cpanel-007-fra.hostingww.com (unknown [127.0.0.6])
        (Authenticated sender: instrampxe0y3a)
        by relay.mailchannels.net (Postfix) with ESMTPA id B8CD62C1709;
        Wed, 11 Oct 2023 22:19:47 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1697062788; a=rsa-sha256;
        cv=none;
        b=NhIqoUgLlkcPhJLfuDfaMcj/MnUfZlwFGHfgxOqQ0mzSlcSWC/mfvse+1IRqmU3Tx97Nkq
        r5vnQfNguVerh5VffOcBFKe+qc4Oi4jEZkSj7q1zvrP8Kp9EMLSxgjQPrOykYJDjQ32Dpj
        KYIgb0/Wit8Zdo8uY48x+/TAjomEU5tUTDSH8KavYa60Z7mPVTuZyIASOs0f9G4nx5F7tJ
        EM1EeCjeu4uARIbscOsmiVuGPswBoX4LRC5p5lKthCjFI0PEYMygKiIY/+ftsBo62S5yPw
        EOnPtqcwHV+Aby593LZcHj/4QIWfyP0sJJk1FoBHBy4oppSs8b2ZSigMElVxKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1697062788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GJSVrdb/lSyBFNO//H5x6GgbKgOvR4ZgBhGc+BesuQM=;
        b=LyN88MEPoD+KxFNNVzEM6XvOA7uwj8KaO0g7jMyxysEIh+eNzAnTUSrmWraQmzN9I77zbN
        HTW+sUUlSw5ricGo3CvIxMdLZx70uWNZHWwtCr2np6rlO2FB7+SPbNH0sp936ezrfxYkAO
        CqC8HnG9ZguqZU6Q6hnjaxgIM95TCYAww+D4lDt8qQu3971aLfnW/e6JjJw0r6+D6l7Ss5
        sxMaIkno54ZyL4VVl49H3hi72akdn0Ai2W77xfrZg07bmThf4Oj96QgMnCHqfphBFSGuSj
        Nd1kKJIHqwvQQBtwBT5GRBl5Kk3B3mzyMU/wvsp6FktzL51R5zhgzxSHXE/SuQ==
ARC-Authentication-Results: i=1;
        rspamd-7c449d4847-879xg;
        auth=pass smtp.auth=instrampxe0y3a smtp.mailfrom=calestyo@scientia.org
X-Sender-Id: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MC-Relay: Neutral
X-MC-Copy: stored-urls
X-MailChannels-SenderId: instrampxe0y3a|x-authuser|calestyo@scientia.org
X-MailChannels-Auth-Id: instrampxe0y3a
X-Little-Arch: 12842f947ae0eac2_1697062788386_756837895
X-MC-Loop-Signature: 1697062788386:305927922
X-MC-Ingress-Time: 1697062788386
Received: from cpanel-007-fra.hostingww.com (cpanel-007-fra.hostingww.com
 [3.69.87.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384)
        by 100.102.135.46 (trex/6.9.1);
        Wed, 11 Oct 2023 22:19:48 +0000
Received: from p5090f4db.dip0.t-ipconnect.de ([80.144.244.219]:34746 helo=heisenberg.fritz.box)
        by cpanel-007-fra.hostingww.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.96)
        (envelope-from <calestyo@scientia.org>)
        id 1qqhYN-0006QL-0G;
        Wed, 11 Oct 2023 22:19:46 +0000
Message-ID: <3a2c362c019338ca7408b7a3bc5715b535d15b8a.camel@scientia.org>
Subject: why does git set X in LESS env var?
From:   Christoph Anton Mitterer <calestyo@scientia.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Date:   Thu, 12 Oct 2023 00:19:40 +0200
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.50.0-1 
MIME-Version: 1.0
X-AuthUser: calestyo@scientia.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hey.


I recently stumbled over the problem that mouse wheel scrolling doesn't
work with (git-)delta[0], a problem[1][2], which apparently numerous
people had before me.

Numerous solutions were given in [1] and [2], for example using --mouse
as less option.
I noticed however, that this causes a somewhat different mouse
scrolling behaviour than my less usually gives me and dug a bit
further, noticing that the problem was that `X` was set in the `LESS`
env var for the less process, wrongly assuming[3] first that delta
would set it.

After delta's upstream noticed that this must be wrong, I looked
further and found that git set it since commit
0abc0260fa3419de649fcc1444e3d256a17ca6c7, which gives however no
indication why it was added.

A somewhat later commit, b3275838d969b7ecb91aae584226fccbeb046aca,
which removes `S` from being set, mentions:
> … The FRX flags actually make sense for Git (F and X because
> sometimes the output Git pipes to less is short, and R because Git
> pipes colored output).

But I still don't get from that why X would be needed?

My less manpage documents it as:
> -X or --no‐init
>     Disables sending the termcap initialization and deinitialization
>     strings to the terminal.  This is sometimes desirable if the
>     deinitialization string does something unnecessary, like clearing
>     the screen.

Is it to avoid clearing the screen?


Not sure whether git should really do something here... I mean it could
add --mouse per default, but then users who don't want that would need
to work around it (and there is no negative option for --mouse, it
seems).


Oh, I should add that scrolling without `X` and without `--mouse` sees
to only work on some terminals (e.g. VTE based ones, but not xterm).

Thanks,
Chris.


[0] https://github.com/dandavison/delta/
[1] https://github.com/dandavison/delta/issues/58
[2] https://github.com/dandavison/delta/issues/630
[3] https://github.com/dandavison/delta/issues/58#issuecomment-1756542986
