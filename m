Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40BBFEB64D9
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 19:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjFOTFT (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 15:05:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjFOTFS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 15:05:18 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D301A268B
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 12:05:16 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 70EC55C00BB;
        Thu, 15 Jun 2023 15:05:14 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Thu, 15 Jun 2023 15:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1686855914; x=1686942314; bh=mJo5LURVFKR0rehvETsEg56Bz
        m0DHyj3mL0xe0Ex/lI=; b=JSnedkwa0OgVlsQuuikd5/5E9h7p3ygkjZ+V0dLZf
        lZsqXKqnI1SJo7OMNMuANfbdNqNRu4tV2PlDkBwAEJR0WLgKrmyPob/Saoo20JHm
        7Il5AwF8jCoC/RscuRufLGO7SbHrqKRT5VNuETAt6hSTr37yMgbylK3chg7As4M7
        bUGK7tS47NQWwzKVN46BL16e8zQu0WfEwu0WzsILdUSkj+3H8KitTVDZqkptEZ8S
        BaWPTj8jWDpRbEJqQ9cVg0X3b4FtpXGfikY9wi26cqTr0qEMkdGDOdGFXxaqEQ1g
        +oxh1ygqcM/t57OSF+JytsCaINeGWYcR8IcqREVFuVDqg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1686855914; x=1686942314; bh=mJo5LURVFKR0rehvETsEg56Bzm0DHyj3mL0
        xe0Ex/lI=; b=A5H6Bgj237/XwGy45KqzV18ml7Wfxzadd4tCojsgJhpLlnkczQs
        NDs8oIMSQpujm3mM55CgMnCFY+YxMMpad0dQt1rrXIoFhZxSv9S+Hrp3HDjSu4jz
        VS0L9R5Fx+bXuJlF2ZmpYEBrhDl0DXIDnLNbipTgDhTuOMtwCzNrbv0iURwScfgE
        NVvU+8+PQDNm236R3QcJmrVP7uw656cPYm/2a+ZF3+JOkvUqSJtyYGSGi1j1mQRw
        OSQoR9c8YTbGikyDLTdpBrlyAdbBbQcFZWCwZ5Hm79RVQwIvV0nHbBVql7kzWzkK
        Hhhzx0m2p3CtRU09+CL4IntcGTdnZK4C7aA==
X-ME-Sender: <xms:6mCLZMf0bDtdk6ALT27E4tFkPelnbnlrURi8k7dxBRjrbmmP2BYG7aM>
    <xme:6mCLZOMeubKg0-essWBGUiNyxE-67Ny-uvXI3XNrR3ewm2SYzE1CV-aEu01PCh-L7
    D969BB7e9ryzqwaTQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddguddvkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkjghffffhvfevufgtgf
    esthhqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrghk
    khdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgvrh
    hnpedvveehiedufeehffdvteeuveekhefhleeigfektdeifeduteeuheeufeetffefuden
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegtohguvg
    eskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:6mCLZNhwNrXnWj8yfas2mDzHuF8B2AUCrkhzKLJSEn3X9oOWUDm3Gg>
    <xmx:6mCLZB-Ik607bQM_vBPPE6Rt0iFhLZqL2QhiTUeW2ldln7D_0O4MyA>
    <xmx:6mCLZIuT9A4iMBWst9IkevIqlINSzMIEbDyYVSyhppQd_aS6WaPzYQ>
    <xmx:6mCLZO3Qn8tH91PLJlIH_GDebI8cvCT6pAOCLnHQnrEXwtvMQh3tCw>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 10CB115A008E; Thu, 15 Jun 2023 15:05:13 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-496-g8c46984af0-fm-20230615.001-g8c46984a
Mime-Version: 1.0
Message-Id: <42e4373e-b700-45a6-99cc-db2f8896d5b7@app.fastmail.com>
In-Reply-To: <PH7PR07MB9467452EBAFAB2C825295C0C8C5BA@PH7PR07MB9467.namprd07.prod.outlook.com>
References: <PH7PR07MB9467452EBAFAB2C825295C0C8C5BA@PH7PR07MB9467.namprd07.prod.outlook.com>
Date:   Thu, 15 Jun 2023 21:03:42 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "eric.frederich@siemens.com" <eric.frederich@siemens.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>, peff@peff.net
Subject: Re: Possible bug regarding trailers
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi

On Thu, Jun 15, 2023, at 19:46, eric.frederich@siemens.com wrote:
> I am able to produce a commit with a trailer which does not show up in:
>     `git log
> --format=3D"%(trailers:key=3Dold-scm-change-id,valueonly,separator=3D%=
x2c) %H
> %T" HEAD`
> But does show up in:
>     `git cat-file commit HEAD | git interpret-trailers --parse`

It seems that the `--- ` (note the space) is interpreted as marking the
start of the patch part (as in a patch file which contains a commit
message followed by a patch).

See `trailers.c:find_patch_start` (here on d7d8841f67 (Start the 2.42
cycle, 2023-06-13):

	for (s =3D str; *s; s =3D next_line(s)) {
		const char *v;

		if (skip_prefix(s, "---", &v) && isspace(*v))
			return s - str;
	}

I=E2=80=99m not good with C but it seems that this line will match:

    --- let's mess stuff up ---

Which instructs the code to put the trailer *before* this =E2=80=9Cpatch=
 part=E2=80=9D.

(Or at least: if I remove this if-block then your script seems to work
like you want it to.)

This seems to be in line with the documentation in `man git
interpret-trailers`:

> The group must either be at the end of the message or be the last
> non-whitespace lines before a line that starts with --- (followed
> by a space or the end of the line). Such three minus signs start
> the patch part of the message. See also --no-divider below.

Note =E2=80=9Cby a space or the end of the line=E2=80=9D.

This check used to be simpler: before it only checked for a line that
started with `---`, no matter what came after on that line. But that was
changed to match on `---` followed by `isspace(v*)` in c188668e38
(interpret-trailers: tighten check for "---" patch boundary,
2018-08-22). Reading the commit message it seems that the change was
conservative. Maybe it would have been more strict (like demanding only
lines like either `---\n` or `---\n `) if there weren=E2=80=99t concerns=
 about
how the behavior had been documented to match loosely up until that
point.

(+Cc the commit author)

--=20
Kristoffer Haugsbakk
