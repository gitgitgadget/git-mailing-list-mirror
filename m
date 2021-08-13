Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0142DC4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 15:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CBEF260F91
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 15:35:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236839AbhHMPgY (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 11:36:24 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:38391 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236719AbhHMPgY (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Aug 2021 11:36:24 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id E80F85C012A;
        Fri, 13 Aug 2021 11:35:56 -0400 (EDT)
Received: from imap2 ([10.202.2.52])
  by compute2.internal (MEProxy); Fri, 13 Aug 2021 11:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spawned.biz; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type; s=fm3; bh=evX4C3SD7ooQVHOOuyIYXJB3Zlo3z+x
        +G2NJokIdJ8s=; b=gQKtFJpjonVY0IZ//3tpVfRNC7GdKFIAnsSCCTU8gMDmeA+
        4/pXZcyxxYYYAabjYd5vpwHSeplazekLcVtltVL6vKyrXWAjPsLvX779tPe33JO0
        IU/jE2kFb//E/sf5xA/Y3l7woKkFXeEK8ojwCOb1YmjLS60EmXRls7nOV580LhT+
        rPXPPyVkjWeiQNGqDxYn1lCYvSo9RpFHBuHYxtODKj1WtJNvnhHLev1TGIMYDtoF
        lwjuUr+w5Gb4wZTNI8kJkQZfjvHoTaQCNFcRAQvRRYApa0PSI5rPUbpvte0seT2e
        7cySx04TL5b3qRqoVb+NusW6b3xjsj7hP85yNOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=evX4C3
        SD7ooQVHOOuyIYXJB3Zlo3z+x+G2NJokIdJ8s=; b=TScfK7omhOYGxob+QlAn/b
        9cNCaz3OIn7gtGA3SljYSdWaODVt3rDESCx5q7ZYzXUhgEYM0UMn0TLDrmlPVkFy
        nYvPbJTXOAtF+5zqoBjDTd+06N1mwroPvK6AuqerC8BxPAK/7EZipDnAebWhHb5E
        IXghPfGMNflfYtxWzpZLZ9NQXwvBXPZaBwZbq2Mhzxzcj5OLY8XXRosZ2KFTWwNF
        LlH77bqJ2/w1sNgm3Vs1Iw/j/YHoK9oW0VCrj3VcYwAIRdTuKFUCjbgPSngB6Oy5
        NRFAIAFmm9aVZ5JGxQBJDaJtM/JJghmmTVkN9bEubBtR8omx8raxQlGfT3xIeVvg
        ==
X-ME-Sender: <xms:W5EWYVZUY4BBP_Uv9Qu2N1E_-0d7GiyhPJUVtR9LsQrz-MBSHLhlvQ>
    <xme:W5EWYcZIToMuuzjZPSvCuTAY9g-LLW70kMHoygHA_lgw7C-XPMs7bKVzIdWAt_ReP
    CzEXzQHyaQfs2KNkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddrkeehgdelvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvufgtsehttdertderredtnecuhfhrohhmpedflfhovghl
    ucfmlhhinhhghhgvugdfuceothhhvggpjhhksehsphgrfihnvggurdgsihiiqeenucggtf
    frrghtthgvrhhnpedtkefgudekudejieejgfehleekkefguddvuefgudelfeefffdtveeu
    ueehhfeifeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehthhgvpghjkhesshhprgifnhgvugdrsghiii
X-ME-Proxy: <xmx:W5EWYX84n_8L4JakyLEUQciPsRao1zjcXUKGN77jhXdAIsl6H3nh2w>
    <xmx:W5EWYTqUhF-emjE9GV8S-sHEBpc2SOQWfD0F2wFTHEl_0mP0aiWvYQ>
    <xmx:W5EWYQr9WvZLYrmicofBt8TX2xBA3U8utXcgKu73TfGWzUkCCdL_lQ>
    <xmx:XJEWYbVZ0e7A3vhijiNcC1S4mzSXs-VBQI3tdt_d-sYe_xjlCvXx5A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 6579FA038A7; Fri, 13 Aug 2021 11:35:55 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-554-g53a5f93b7d-fm-20210809.002-g53a5f93b
Mime-Version: 1.0
Message-Id: <1fc066c5-a085-4865-9eb9-853dfcbe33c2@www.fastmail.com>
In-Reply-To: <0151003c-d544-1fab-18e9-34eb84842555@gmail.com>
References: <pull.1014.v2.git.1628725421868.gitgitgadget@gmail.com>
 <pull.1014.v3.git.1628755346354.gitgitgadget@gmail.com>
 <e3a24819-9953-0245-7f64-472def4d180a@gmail.com>
 <0576a44a-c726-4550-ad29-52f09982de98@www.fastmail.com>
 <0151003c-d544-1fab-18e9-34eb84842555@gmail.com>
Date:   Fri, 13 Aug 2021 17:35:43 +0200
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



On Fri, Aug 13, 2021, at 15:06, Phillip Wood wrote:
> On 12/08/2021 11:01, Joel Klinghed wrote:
> > I looked at moving the condition to one place but as use_editor = 0
> > is only set for --fixup if there isn't a suboption specified I didn't want
> > to have to duplicate the check for a suboption when deciding if
> > use_editor should default to zero.
> 
> I don't think you need to duplicate the check for a suboption, can't you 
> just do this on top of master (i.e without you patch applied)?
> 
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 243c626307..67a84ff6e4 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1251,11 +1251,6 @@ static int parse_and_validate_options(int argc, 
> const char *argv[],
>          if (force_author && renew_authorship)
>                  die(_("Using both --reset-author and --author does not 
> make sense"));
> 
> -       if (logfile || have_option_m || use_message)
> -               use_editor = 0;
> -       if (0 <= edit_flag)
> -               use_editor = edit_flag;
> -
>          /* Sanity check options */
>          if (amend && !current_head)
>                  die(_("You have nothing to amend."));
> @@ -1344,6 +1339,11 @@ static int parse_and_validate_options(int argc, 
> const char *argv[],
>                  }
>          }
> 
> +       if (logfile || have_option_m || use_message)
> +               use_editor = 0;
> +       if (0 <= edit_flag)
> +               use_editor = edit_flag;
> +
>          cleanup_mode = get_cleanup_mode(cleanup_arg, use_editor);
> 
>          handle_untracked_files_arg(s);
> 
> I chose to move the other clause that sets use_editor as well so they 
> stay together.
> 

With the above change use_editor no longer defaults to 0 for --fixup as
it used to do.
My expected behavior (based on old versions):
git commit --fixup <hash>  /// No editor
git commit --fixup <hash> --edit  /// Editor
As far as I can see your change would display an editor in both cases.

An alternative would be:
+       if (logfile || have_option_m || use_message || fixup_message)
+               use_editor = 0;
+       if (0 <= edit_flag)
+               use_editor = edit_flag;

That would fix the above cases but in 
"commit: add amend suboption to --fixup to create amend! commit"
the implementation left
git commit --fixup amend:<hash>  // Editor
and I didn't want to change that. But if the default should be no editor
here as well then the above would be a better patch.

/JK
