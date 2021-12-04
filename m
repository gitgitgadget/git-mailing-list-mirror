Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28300C433F5
	for <git@archiver.kernel.org>; Sat,  4 Dec 2021 08:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384317AbhLDIfb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Dec 2021 03:35:31 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:35557 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1384278AbhLDIfa (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 4 Dec 2021 03:35:30 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 7506A3200F9F;
        Sat,  4 Dec 2021 03:32:04 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Sat, 04 Dec 2021 03:32:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:content-transfer-encoding:in-reply-to; s=fm1; bh=f
        AsClDoINsrqM85ZbkJvhU07ePtfgW9BJM0sur3Zrl8=; b=ixZAvyg+ZcXwokIqV
        uwe3udN4iJtymDgNiYKrutj+kz73MKTF29vMwOLAt2e/NOJ4O90CgU7c/IaGmD8/
        Mwy4VaG1bEoFqSlq3AVVZ8t3jWW0mCLUbx1WRXxSj+riJ/ysxKBhqgVbq9i54THl
        CoZNtUl3EwaF7sSCnKvP2lWCVfwbr8fn4aqOkhF/kwBkMhAo+jWQVuHmJRIZX0KI
        YNBWL7XHZBAgthEb+WZ6nycEGAySSjYljV1iqm4N5cboXxfL3wJ+FQgjfG6fLXjg
        3j3Ls5Tuf2T5vKh/ICOwW9GtJlHD+ySWvgsYk+NimZKx3vm4LmSLHjIoh6HSC9xz
        ao5+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=fAsClDoINsrqM85ZbkJvhU07ePtfgW9BJM0sur3Zr
        l8=; b=lV3jCFKjdvUFDpzlgbaVdUxqv0XN2dzB7u+4lpyCKiSPif6LYnQV1pmR+
        nAfR3ER7H8T7cFjlsJuxpvae8sqoHBjUi3ZoU+fuwgTX1OSAU4/WLfC4uKdqFEqu
        Q2sZshc2reYhmwIkT/hoxF/MFM4gVx2dcqj6dV4zxse+3wbW1oJNP5qgwp+WJzob
        XDWg6WDVyWliQwMeAd/XzgR2L0FM1fZZkY8Vf8UnB9TZD1qckbHoUU2gzK9GP++N
        Cu6+4vhSwjm5fv+cmUPVUnSxoUY3Jzm1NaYHNwCSnw1o48XpDGVf02gT+xZUzI5D
        /P2JrociVyKmwaAB482+fcPScT8PA==
X-ME-Sender: <xms:gyerYUsD2DiPWiqIFtxRN_FD4i3YRXJ_a35IHUMRX1ujzMaUkpifxw>
    <xme:gyerYRflCKIiWcp68eeADvrJvg6AZClrNKdXDpjomAY6SeVPVCVvGLb3rp7mKXLg1
    h8L6l55ZK8EgqkMZg>
X-ME-Received: <xmr:gyerYfyMMBa8_GEkMh3NSiiCzNNturdO-Q7ImLBhYA--Vd8UHDlA7BQZTm874CBZokt841Mb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrieekgdduvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggugfgjsehtke
    ertddttdejnecuhfhrohhmpefhvghrnhgrnhguohcutfgrmhhoshcuoehgrhgvvghnfhho
    ohesuhelvddrvghuqeenucggtffrrghtthgvrhhnpeehtdfffeevleekvdeihefggeeuge
    ehueevtefgfeffffdvkeekueehveeghfejheenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:gyerYXPbidZD23xty6Y3L8ZwVUXwijaWkT8O2YqmwmjbqWZgfaPREQ>
    <xmx:gyerYU-GI3jlJmWuatOf5p-bLri9VJ0gSR-UU_Xxv-7X8gaSAw67zg>
    <xmx:gyerYfXFheWrIzUw60Fqbzc97VVQiq5pUaw8dfWlYE3zk55HCJG35g>
    <xmx:gyerYUzRSGh9yPMRjS-6MxFiH5tc6RRadX7tgwcNZDv9Yvfvqy4PnQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Dec 2021 03:32:01 -0500 (EST)
Date:   Sat, 4 Dec 2021 09:31:58 +0100
From:   Fernando Ramos <greenfoo@u92.eu>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com,
        sunshine@sunshineco.com, seth@eseth.com,
        levraiphilippeblain@gmail.com, rogi@skylittlesystem.org
Subject: Re: [PATCH v3 2/3] vimdiff: add tool documentation
Message-ID: <YasnfjKqEmI+7rLG@zacax395.localdomain>
References: <20211130204333.174967-1-greenfoo@u92.eu>
 <20211130204333.174967-3-greenfoo@u92.eu>
 <211201.86ee6w9fq8.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211201.86ee6w9fq8.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/12/01 10:27PM, Ævar Arnfjörð Bjarmason wrote:
> 
> > +merge_cmd_help() {
> > +	case "$1" in
> > +	*)
> > +		echo "Run 'man git-mergetool--vimdiff' for details"
> > +		;;
> > +	esac
> > +
> > +	return 0
> > +}
> > +
> > +
> 
> Isn't the case/esac in those functions entirely redundant and they could
> just "echo"?

Yes, I originally left it here in case we wanted to print different messages for
different variants (vimdiff, vimdiff2, ...).

But now that the documentation has been placed into a single file, I don't see
a reason to keep this. I'll remove it. Thanks for noticing.
