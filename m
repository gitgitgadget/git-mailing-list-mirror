Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A808C433F5
	for <git@archiver.kernel.org>; Thu,  3 Feb 2022 17:43:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353023AbiBCRnF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Feb 2022 12:43:05 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33337 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353035AbiBCRnC (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 3 Feb 2022 12:43:02 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B8F6F5C011D;
        Thu,  3 Feb 2022 12:43:01 -0500 (EST)
Received: from imap46 ([10.202.2.96])
  by compute2.internal (MEProxy); Thu, 03 Feb 2022 12:43:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hurrell.net; h=
        cc:cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=+5reLBrBhvxA+Ug1stojAkd7Ez/1r7obpopKXk
        xQjV0=; b=jE3/HbLJv1JRMWzHDOHzTA9H9WWfMwYxnI7LYi2q/A+ZyMtxMV4pu7
        2/NYt2fClJwTj62H6BEYuGHXt4RYNAMnjbz/POnh6olO/+RsD8zMw0rG1smwxe8y
        zqX/QqXCzkfNZQc5lvhwltdloxgbNuV7yVh5GZeQY+q6PbvXFZPO7aB6zqt3Y8uK
        ZWetNT5amBj8hbemgnt6n0CSz/4QBn2oIUaQAywdgChJUWO3oPfWK1ORe/q2aqwK
        Ivo57ugON8JqC87XIPNoARO7p0HpRlRH5DkmVR29RvGNZiGYyGFPh7qTkQecOtKk
        SiRcQJj0Zb7//2J2sqbCjNhxZ2e1+YqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=+5reLBrBhvxA+Ug1s
        tojAkd7Ez/1r7obpopKXkxQjV0=; b=PqKA4v800/z9ffxRrHdlydZRfsGX4ZbGz
        VUrUvKLZVcSOfWv4HVl55qHEN4FJNMTtQ6QGuFFP7XZL+E4JCo/BkeCiXgAn6KYw
        vZBVnlfrukC83kruKm6j6el8Ny/yD29HmDBQ/AkmTyxRdqtXfPAzwbgkxC5o1bjW
        0QAbYNo5k/v3EG4oiCZx/CpG8NB8IUmSkaxAXdT56j+/pFvtpK7f2g4LI968TrrX
        gQqfP53HBISd9x7VGStX79D27O7NPLLbuXclVBWZS9dqbGWsRuVResQHt8pgH31m
        skefz7y5YelVYaY5bj0x1jFT4mNiRz7wLEUe/G73rGJ3+RCPtJ82w==
X-ME-Sender: <xms:JRT8YSYKzfLv_fAAtCEuQPY-tNc3qkA2ukXbvzCl-PnxzSLaiGXE9g>
    <xme:JRT8YVaSaS-QsObGCHARdltK8qvMWr-3HROLht9izfmI5x8W5nwXAyryxqMEXaO0m
    itNgO7alkXEXavu1A0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrgeejgddutdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
    ertderredtnecuhfhrohhmpedfifhrvghgucfjuhhrrhgvlhhlfdcuoehgrhgvgheshhhu
    rhhrvghllhdrnhgvtheqnecuggftrfgrthhtvghrnhepuedttdevtdejiedtgfefveevfe
    elkeetudeljedtjeeuhffhkeekveetfeevvdehnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomhepghhrvghgsehhuhhrrhgvlhhlrdhnvght
X-ME-Proxy: <xmx:JRT8Yc_qFHw8wt1XOk4Cn2x_1ZDxr1j4VqvQoEZEdBv8WfNwztiegQ>
    <xmx:JRT8YUpgld1MymFox1g_y86zwQ7WbpuqBt8kaFXjxh8K_6OsX0woAA>
    <xmx:JRT8Ydo_mLlj36Wk_VOzRcYjn0HjMGriqdzkRnk00uyOPT64OS5O1A>
    <xmx:JRT8YcTywKUDbwMDgggA-Qync5iBQTJlu457OTYn0GE8Y8UkCTtprw>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 857241EE0439; Thu,  3 Feb 2022 12:43:01 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-4586-g104bd556f9-fm-20220203.002-g104bd556
Mime-Version: 1.0
Message-Id: <606851c7-110d-486e-9e39-0a00444caad8@beta.fastmail.com>
In-Reply-To: <3f1972f3-c764-41e9-9853-8f1c303d4f6b@beta.fastmail.com>
References: <ee1dd453-e698-440a-911b-d14389e33715@beta.fastmail.com>
 <0b8222c2-7337-7e8f-33d1-7926462daac1@gmail.com>
 <3f1972f3-c764-41e9-9853-8f1c303d4f6b@beta.fastmail.com>
Date:   Thu, 03 Feb 2022 18:42:40 +0100
From:   "Greg Hurrell" <greg@hurrell.net>
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: git-checkout doesn't seem to respect config from include.path
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Minor correction to what I said here:

On Thu, Feb 3, 2022, at 6:39 PM, Greg Hurrell wrote:
> 
> That gave me the idea of moving the `include.path` setting higher up in
> the file, to see if `git checkout` would consult that value first, but
> it doesn't work; `git config merge.conflictStyle` shows the value from
> the file indicated in `include.path`

It only did that because I forgot to remove the original `include.path`
from the bottom of the config. Once I removed that, `git config` showed
the value from ~/.gitconfig. `git checkout` behaved the same either way.

Greg

