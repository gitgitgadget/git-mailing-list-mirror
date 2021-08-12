Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD254C4338F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 10:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA3266109F
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 10:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236577AbhHLKB6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 06:01:58 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:37843 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235686AbhHLKB5 (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 12 Aug 2021 06:01:57 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id 149C532005BC;
        Thu, 12 Aug 2021 06:01:32 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute2.internal (MEProxy); Thu, 12 Aug 2021 06:01:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawned.biz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=iFryATMK1fowtYrTEDkZ2aVh4pX16d4
        S3VdMSpllyxs=; b=QmlGLb2r0mS3aZbLrPBCgAIMcMI8p6WLRk/4eoJIvr99Xsc
        RVjFrcpNMZdhCABEn0zY4i3GXYaFVE00YhVgdxeluhmC98yn+pyGvDM1/Vf3crcM
        11cza4yMMrhjeeeE4zf3iozVltg2dwd+qI0gNEMazLRCYVWpN3MSpCXfqZNvGrli
        vgA+DXHsFyopWO7bm6370KTdOI4iP4dxuOlygHsBzGimC0lxtgHrKqfEGmPL00JC
        sRFv70E0zWhv1rvK7BDrLEaSxCpOGCzJKFCYcROn1Yh86hZwVpbstEVys+Y2B+EV
        6DCWydzpNRKcNQsMhwDXDqBWoV4wxVRKCle90mA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=iFryAT
        MK1fowtYrTEDkZ2aVh4pX16d4S3VdMSpllyxs=; b=LEz67kM9P1i5QFPoEZNUsE
        JeAiwZRGWsQoxh21Zp9xstZxkyag1hohjoFlFmJEhj3FQ+izUXoGsbEmbJZ62M2Q
        1A7dSmolyNt1wRlag1oGSP3lZ2L0Oll3LXg028qV4w79fYHuj7VAoBF0k0J6oax4
        44AMJJbD808g7rknijjKc12oeWKosviz43krVy995SjFUe03lu37YmE2y6vrJRof
        Fp/4daXQ4YEB3gYXB1LkIVHXbarfK3cBc1Wrt3ORRKAInjLxFhLmknpnHxqcERMl
        rcqQ8AZnDmEhA7wIl2xuFlNeQkV4MxeYnm5mCkBrz+UzL+sGD4dpCgcSPfaib3GA
        ==
X-ME-Sender: <xms:evEUYeIQRQiZe4cfotFK17D1tumqX0bYhkUQRxkom8ZuAdvcgoJGKA>
    <xme:evEUYWJY4WaQO_bZ7BNBA8FkJ4hLrAhfhLtjEkaFV-WyHvWa-swJKUUSYziHFFmIE
    qtvJu3i7fq9uo3DLA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeefgddvudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedflfhovghl
    ucfmlhhinhhghhgvugdfuceothhhvggpjhhksehsphgrfihnvggurdgsihiiqeenucggtf
    frrghtthgvrhhnpedtkefgudekudejieejgfehleekkefguddvuefgudelfeefffdtveeu
    ueehhfeifeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthhgvpghjkhesshhprgifnhgvugdrsghiii
X-ME-Proxy: <xmx:evEUYesFE7EFUb1WZ25I1DwvCcJwyLwVAIXlTFliGnam7rK1qneMyA>
    <xmx:evEUYTYT8v_Ja4kCL5DE8CzUdD-qEwIIcx5tUzrbMjzbZ559jJiCyw>
    <xmx:evEUYVZ2YD3vj6Icjo0St__afv6-sH0x_zTNejL_kXoX_DRsbgdzTw>
    <xmx:e_EUYZEWxoToJzs-wQvttGZdCM7A5JhgUP6hCgKcZxELfTbifYp5yg>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6C2ADA038A7; Thu, 12 Aug 2021 06:01:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-554-g53a5f93b7d-fm-20210809.002-g53a5f93b
Mime-Version: 1.0
Message-Id: <0576a44a-c726-4550-ad29-52f09982de98@www.fastmail.com>
In-Reply-To: <e3a24819-9953-0245-7f64-472def4d180a@gmail.com>
References: <pull.1014.v2.git.1628725421868.gitgitgadget@gmail.com>
 <pull.1014.v3.git.1628755346354.gitgitgadget@gmail.com>
 <e3a24819-9953-0245-7f64-472def4d180a@gmail.com>
Date:   Thu, 12 Aug 2021 12:01:10 +0200
From:   "Joel Klinghed" <the_jk@spawned.biz>
To:     phillip.wood@dunelm.org.uk,
        "Joel Klinghed via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     "Jeff King" <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "Junio C Hamano" <gitster@pobox.com>
Subject: Re: [PATCH v3] commit: restore --edit when combined with --fixup
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On Thu, Aug 12, 2021, at 11:32, Phillip Wood wrote:
> Hi Joel
> 
> @@ -1170,7 +1206,7 @@ static int parse_and_validate_options(int argc, 
> const char *argv[],
>          if (force_author && renew_authorship)
>                  die(_("Using both --reset-author and --author does not 
> make sense"));
> 
> -       if (logfile || have_option_m || use_message || fixup_message)
> +       if (logfile || have_option_m || use_message)
>                  use_editor = 0;
>          if (0 <= edit_flag)
>                  use_editor = edit_flag;
> 
> I think it should have moved those last two context lines that set 
> `use_editor` to below the part that you are fixing. Then the `use_editor 
> = 0` line that you are changing continues to work as before. (As you see 
> there are quite a few legacy Yoda conditions in this file, nowadays we 
> avoid adding new ones). I'm not sure if it is worth re working this 
> patch to do that, but it does have the advantage of only testing 
> edit_flag once.

I looked at moving the condition to one place but as use_editor = 0
is only set for --fixup if there isn't a suboption specified I didn't want
to have to duplicate the check for a suboption when deciding if
use_editor should default to zero.
 
> > diff --git a/t/t7500-commit-template-squash-signoff.sh b/t/t7500-commit-template-squash-signoff.sh
> > index 7d02f79c0de..a48fe859235 100755
> > --- a/t/t7500-commit-template-squash-signoff.sh
> > +++ b/t/t7500-commit-template-squash-signoff.sh
> > @@ -281,6 +281,19 @@ test_expect_success 'commit --fixup -m"something" -m"extra"' '
> >   
> >   extra"
> >   '
> > +test_expect_success 'commit --fixup --edit' '
> > +	commit_for_rebase_autosquash_setup &&
> > +	write_script e-append <<-\EOF &&
> > +	sed -e "2a\\
> > +something\\
> > +extra" <"$1" >"$1-"
> > +	mv "$1-" "$1"
> > +	EOF
> 
> Again I'm not sure it is worth changing it now but for future reference 
> this is a rather complicated way of appending to the commit message. The 
> test file has an example using set_fake_editor() together with 
> FAKE_COMMIT_AMEND just below where you have added this test or you can 
> just have
> 
>      EDITOR="echo something extra >>" git commit --fixup=HEAD~1 --edit
> 
> Best Wishes
> 
> Phillip
> 

Yeah, especially getting sed in a POSIX and BSD compatible mode took some
doing. I wanted to have a similar output to the test above this one, with a line break 
between something and extra, and frankly, my shell-foo lacked for
getting either FAKE_COMMIT_AMEND or EDITOR="... >>" to include a newline.
But looking at it again, I realize that EDITOR="printf \"something\nextra\" >>" 
works just fine.

/JK
