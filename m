Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EEF6C433FE
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 10:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C8656320D
	for <git@archiver.kernel.org>; Mon, 15 Nov 2021 10:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbhKOKe0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 05:34:26 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:46247 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230419AbhKOKeT (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Nov 2021 05:34:19 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 77F9A5C019A;
        Mon, 15 Nov 2021 05:31:23 -0500 (EST)
Received: from imap48 ([10.202.2.98])
  by compute4.internal (MEProxy); Mon, 15 Nov 2021 05:31:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dbrgn.ch; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=zE5Eb7qQqHucLovUv5hE4lL5kMgLrbT
        7Zg5e9dy2Ang=; b=ufRJhgEvi50XmuNIOTtp98acqRdzAKMhI/OHzE7hQV2SKxl
        ExFsGF+eFFxfWkCKc3PHpSnQKk5ur7w3G1gsdOvB19D8u0yg6fmEeHv29xgQdJ3W
        Xf1Yg+FYQGhbecTfeg+uAMDqjjnACtIQSEdOmwZLauCtVkk46NHj2TfgSAp217qt
        qfVLcx6fQXwC8oK6j0SlXBMLb0mfzNmsW1AruCbyuKK3wx2JozjHUmbB/uBVw95s
        nKmVYPNtstx4yYjzLNwk3pqWUbtRhitpJhvocyh2trwjmYWNQMTZtaW+GQB6B4v8
        y4Bcf1/iImfbik4xHgM50H6HcfrcbDpNo6VuhuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=zE5Eb7
        qQqHucLovUv5hE4lL5kMgLrbT7Zg5e9dy2Ang=; b=NfBnk2g24nDdHTfsVAjrJw
        jTXAKQTpuIPTeMkky7UBzs2zdExIikfrFxhGVCQIRB1EgdqwEP9rHcYWpCzyormk
        Fa6i1XU8obN9BX4li8RmjnoQXPx18Me8o6QZwNNnoDM8JzgXKbMSAItS8d+cdGYv
        FMMcc9KpXp0B+Dq+QzrOunOvhNQSynLCdgWCEYtfwtRiuSf8n21gCzYhcGJUx8TW
        obP2HjZV711+/4vt+i0Nka7qj9U4wvlREttZNwZ4lJP9g5Cy2w5LA+4MfbKXo7XQ
        nGFoHXJxxiOPUSNmMZ3R5YVCR8YwoivGusBuDGIZOKBgE8HupSPcb9Q7dQSBDO8g
        ==
X-ME-Sender: <xms:-zaSYTLwEZ3w3EEO42t9xkqg_D7yd-YQnQA42GtzYeZ-OnnZGYjeqw>
    <xme:-zaSYXJNfhDm6K4By1kbzbWOT4vVXOTS9J6TC6Mh45kXI7RgSJiF6ZcISEsOnsyrU
    CHUOHxkjyG7PqYp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrvdelgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenog
    fuuhhsphgvtghtffhomhgrihhnucdlgeelmdenucfjughrpefofgggkfgjfhffhffvufgt
    sehttdertderredtnecuhfhrohhmpeffrghnihhlohcuoehmrghilhesuggsrhhgnhdrtg
    hhqeenucggtffrrghtthgvrhhnpeeiueduueeggeehueejteetleehgeektddtkeevfeeg
    ffejfedutdegffetuefhueenucffohhmrghinhepihhmghhurhdrtghomhenucevlhhush
    htvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmrghilhesuggsrhhg
    nhdrtghh
X-ME-Proxy: <xmx:-zaSYbu907fT3r3Vl6uC2Iz1Y9htfB6DKtziU86WCXLSjeGiRpA9gg>
    <xmx:-zaSYcY25dhbjThaZGJ2LwLMsQyA5bxNpJQcORJBWKityCIewkuYFw>
    <xmx:-zaSYab6mbdR5DVq1renLmJzR--zzyowJnmOcvGowHlSroe0g3xv1g>
    <xmx:-zaSYdwUhlKLSZe3BT2OBca7DExcA6x0zITGFwJN3qCgM_n1_PQucQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 2C51621E006E; Mon, 15 Nov 2021 05:31:23 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <9d264d41-7b24-40db-9c3e-28a8275db835@www.fastmail.com>
In-Reply-To: <20211115101945.scikeaptstuy64mi@fs>
References: <30999b1a-70b3-4489-b751-024c26bbbd11@www.fastmail.com>
 <20211115101945.scikeaptstuy64mi@fs>
Date:   Mon, 15 Nov 2021 11:31:00 +0100
From:   Danilo <mail@dbrgn.ch>
To:     "Fabian Stelzer" <fs@gigacodes.de>
Cc:     git@vger.kernel.org
Subject: Re: SSH Key Signatures: Feedback
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Fabian

> Unfortunately the flag
> themselves are often named --gpg-sign / commit.gpgSign which we can't
> change. We might add a new, more generically named flag & config as an
> alias to these in the future.

Aliases sound like a good idea, this would allow for a slow phase-out of the old flags.

> Regarding the error messages I quite agree with you and had similar
> feedback with our internal testers. These error messages (invalid format
> & unexpected internal error) originate from ssh-keygen. I already
> checked if we can improve these but its not easy since those come from
> quite deep within ssh library code :/. I'll see what i can do, but since
> this changes ssh-keygen behaviour I'm not sure how well received changes
> like this would be.

I see. However, maybe some common cases (like missing or empty files) could be detected by git before even invoking the ssh-keygen command?

> When you say `gpg.ssh.allowedSigners` is not set is the option not
> present? or is it empty? The code should actually trigger
> `error(_("gpg.ssh.allowedSignersFile needs to be configured and exist
> for ssh signature verification"));` in this case.

The option `gpg.ssh.allowedSigners` is not present at all. I just checked again, and noticed that the error message you mentioned *is* there, however it's not part of the red error block, so I overlooked it: https://i.imgur.com/LLvrrxO.png

All other errors are part of the red error block, and are thus much more obvious to see.

Cheers,
Danilo
