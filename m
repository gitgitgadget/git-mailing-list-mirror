Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0CEEC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 16:19:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239017AbhLQQTt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 11:19:49 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:49879 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235272AbhLQQTs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 17 Dec 2021 11:19:48 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id AF9725C01ED;
        Fri, 17 Dec 2021 11:19:47 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute3.internal (MEProxy); Fri, 17 Dec 2021 11:19:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm1; bh=Vcdl0
        AMgRh0H6NhsiqD5Z6D1fb8HEvqR3qYPPsk0GZY=; b=cVcI+V976YZ2FeE++RgD/
        W7nFLKr4lp8p2ZefBIy3XsVPQKloo1nYoDxGWAdK5V0GDi9uAWDNIaK6sRdRAAKI
        qsWW3cVEbX7lPAwnjqAhdY/jVB+KgfhF2MVRcrLbL5V1nUzRr+WSHpAueGXWt0Bc
        B6MBE9EQZEGDQwpPXEqUF1Rv1UsjY8R7pvutiSTYrzNRj1B72UNzs8kjb8Qz+9+w
        g+vOPbEBC46vL8WF2eos4l9xT4EQOSXK1SA9pTHRhlwEm1LCWTgLcJF9nr1MyxQr
        2VFYiM9MlYQWHIq1CKzHwEKrRbiogJZDdhjaBrtHV5QpXo6Adg6+zy3JYkALv1aP
        A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=Vcdl0AMgRh0H6NhsiqD5Z6D1fb8HEvqR3qYPPsk0G
        ZY=; b=Zfk2PB3tp+/9/G6aMn7chV6BqeogdVzc7xb7gAbm506fqe2sCz0VSya2e
        oqFGrvzBSoV/IjmvO9AHo52QAYOQPEZxYOGJMFLralVEm+wGcHkV8+GvMg+mu10m
        TDhr3X1+q4+OBR/bTtJSRjwFEN8Ze0BIQrZdB0yzaUuRe+q7tSLhhV4Mie+pqwKG
        aXSxfvvwP7XOiiYM8KbixWaCJBTrksoHBmI7e2Q6uRLVxW85dzuIYC6oQVeB0v2z
        4Hq5zrFCgqsh4VjK6jEvQj9/k5XAlI05A7J9eSYKtpnEb1+h0+DoB8xmRrd+wvJu
        Oseem6n9Vr3pCoG9kb/wtfYcqcX0Q==
X-ME-Sender: <xms:o7i8YaYKGcbMkudVJWjsiaW1EwUW6YdefdOzjWRTkl-F9Ni80fqrtA>
    <xme:o7i8YdbIOOU2tHCTlKQL90nJFfbZhi6aXsiQhe-Tmhglqpk0ejf-bLaAYLuEaiy-5
    N6F6VLzU-JAdXiacyI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrleeigdekkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdfirhgv
    ghcujfhurhhrvghllhdfuceoghhrvghgsehhuhhrrhgvlhhlrdhnvghtqeenucggtffrrg
    htthgvrhhnpeelhffftefhteeffeektdeiffeghefguedujeffffefveelveekueefvddv
    ffdtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgrhgvgheshhhurhhrvghllhdrnhgvth
X-ME-Proxy: <xmx:o7i8YU8fRk6HqZA7rpwhSqAuoTRiBQm-aFes5j4vzSQzehZo1JLHmA>
    <xmx:o7i8Ycq6s_dRc8jhkbcEX-aOj6oe2LaeqXseI16iQ3u0bZu1REYBzg>
    <xmx:o7i8YVrI04t5WJXEGqXTldMh5kLDPlUpRiDpHoES1HFiC7BQOYuVqg>
    <xmx:o7i8YXEAwTHuS5oC8eyLSuvO61y0AyyE8o4VqTRCwzOnavaB_5DkOg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 756241EE007B; Fri, 17 Dec 2021 11:19:47 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4524-g5e5d2efdba-fm-20211214.001-g5e5d2efd
Mime-Version: 1.0
Message-Id: <c1f8f248-5e27-4b99-b186-9c0830dd22b6@www.fastmail.com>
In-Reply-To: <20211217161718.15767-2-greg@hurrell.net>
References: <CAPig+cTfL3e28geHMG6aga-1zSSYSgXknQKO-62msn3LO=+iZA@mail.gmail.com>
 <20211217161718.15767-1-greg@hurrell.net>
 <20211217161718.15767-2-greg@hurrell.net>
Date:   Fri, 17 Dec 2021 17:19:25 +0100
From:   "Greg Hurrell" <greg@hurrell.net>
To:     "Git Mailing List" <git@vger.kernel.org>
Cc:     "Eric Sunshine" <sunshine@sunshineco.com>
Subject: Re: [PATCH v2] docs: add missing colon to Documentation/config/gpg.txt
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry about all the duplicate messages sent previously =E2=80=94 I
was dusting off `git send-email` for the first time in a long time
and thought they were dry runs, but evidently they were not.

=F0=9F=A4=A6

On Fri, Dec 17, 2021, at 5:17 PM, Greg Hurrell wrote:
> Add missing colon to ensure correct rendering of definition list
> item. Without the proper number of colons, it renders as just another
> top-level paragraph rather than a list item.
>=20
> Signed-off-by: Greg Hurrell <greg@hurrell.net>
> ---
> Documentation/config/gpg.txt | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/config/gpg.txt b/Documentation/config/gpg.t=
xt
> index 4f30c7dbdd..94eba373cc 100644
> --- a/Documentation/config/gpg.txt
> +++ b/Documentation/config/gpg.txt
> @@ -34,7 +34,7 @@ gpg.minTrustLevel::
> * `fully`
> * `ultimate`
> =20
> -gpg.ssh.defaultKeyCommand:
> +gpg.ssh.defaultKeyCommand::
> This command that will be run when user.signingkey is not set and a ssh
> signature is requested. On successful exit a valid ssh public key is
> expected in the first line of its output. To automatically use the fir=
st
> --=20
> 2.33.0
>=20
>=20
