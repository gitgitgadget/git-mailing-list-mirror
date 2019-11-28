Return-Path: <SRS0=/qQH=ZU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EB42C432C0
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 00:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10E772086A
	for <git@archiver.kernel.org>; Thu, 28 Nov 2019 00:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk2svPEo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727158AbfK1AQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Nov 2019 19:16:19 -0500
Received: from mail-pj1-f66.google.com ([209.85.216.66]:46578 "EHLO
        mail-pj1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727033AbfK1AQS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Nov 2019 19:16:18 -0500
Received: by mail-pj1-f66.google.com with SMTP id a16so10938082pjs.13
        for <git@vger.kernel.org>; Wed, 27 Nov 2019 16:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ZSE35RFEdqJ6o18TU0cw1KkkUS+AM0s97z4Rwr9Pb2c=;
        b=dk2svPEoRi6SBR7DAzMs+ULiPwQvlrq2DTLRjyHekxGgsppv4d4V8z7beGr1uuQR1r
         Ui01pW1ZByKpZDOAQntI6nWY9ockAonHfenX+dmtwqlT6VKJFTBtFz1L7qWxyI/lMKpM
         cnxwCzEqKtJ89rXOWJZTcwm0ngdbg6RnpGNw5JXfbNvzQn15BAIMol7Jv5U0Evw6xCJH
         xJuShWVdvSM0Pwmy/PO8KXzApi7LnNQsa2KoeIg05EPn/Uax+kneld/HZrEp7lpkYcwR
         unf+pjpdhr8Num/brg7RoL2Cbak9HeFViVCX4ojq+h/seySwss8BCUA0pIq34KJBZJuk
         X51w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ZSE35RFEdqJ6o18TU0cw1KkkUS+AM0s97z4Rwr9Pb2c=;
        b=BKfAVZjIw8Oa1J7f9EsSfZs7y7/CHj//Loqz78LYBvfi/BbfITLL9QpGriyGF2cr7/
         yGzmn+OFLFjj7uhtLDx84DUK9Ce+9P92Rmzw/g1TOAKtptnePkzHjNy3hlNzjx5h4lEO
         45dm+Cw+02SSOEgWfxHv7SntQhpJ4YnYQDot4aMiC+hJ1ogNY5jn9/N9+O6AyTLbC48Q
         e/P1VTDP5PYCTw6Dr83ILgRDIk3yWXostrIz2Kxn+T77Xjz2JaZqZUA/FlSI+QFUyTPQ
         fz/qPBUZ3t4JDLeIZ0pJxNOjgJ37X+MSQoVFAUrYSHRpI7HocOKLxWMhWXjUU4psbrA5
         gr3w==
X-Gm-Message-State: APjAAAUbOUhx9eamtYWvJm+UmasHqV+Lu6iYozkw/H3E/CTbzKbthjYV
        sC3a/nL03WWY5RfmE1/aUZ2jVBeY
X-Google-Smtp-Source: APXvYqzcZiBUWH3DL0ZDV8PVGt+l4gZW8ncsADUKgtVHWB0X4U0xRXPHevZUDYJEaMojkyq/2ACnxw==
X-Received: by 2002:a17:902:9687:: with SMTP id n7mr7011785plp.335.1574900177331;
        Wed, 27 Nov 2019 16:16:17 -0800 (PST)
Received: from generichostname ([204.14.239.138])
        by smtp.gmail.com with ESMTPSA id ay16sm7168294pjb.2.2019.11.27.16.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2019 16:16:16 -0800 (PST)
Date:   Wed, 27 Nov 2019 16:16:14 -0800
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Jeff King <peff@peff.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Eric Wong <e@80x24.org>
Subject: Re: [PATCH 2/2] RelNotes: replace Gmane with real Message-IDs
Message-ID: <20191128001614.GA36215@generichostname>
References: <20191127125231.GH22221@sigill.intra.peff.net>
 <cover.1574882812.git.liu.denton@gmail.com>
 <ebb2328a02dd96c740c5e9cf70abc03446dbf592.1574882812.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebb2328a02dd96c740c5e9cf70abc03446dbf592.1574882812.git.liu.denton@gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 27, 2019 at 11:28:57AM -0800, Denton Liu wrote:
> The only references to Gmane that remain are in RelNotes. Although these
> are definitely not in active use, they might be of historical interest
> for future readers so let's ensure that mail references are more robust.
> 
> Replace links to Gmane with links to LKML (which is our new preferred

In this and the last patch, I had a brainfart and I thought LKML and
lore.kernel.org were the same thing but obviously they're not.

> mailing list archive and has the Message-ID in the URL) and bare Gmane
> ID references with Message-IDs.
> 
> The Message-IDs were found by searching for "gmane:<id>" on
> https://public-inbox.org/git/ and taking the resulting message.
> 
> Signed-off-by: Denton Liu <liu.denton@gmail.com>
> ---
>  Documentation/RelNotes/1.6.2.txt | 2 +-
>  Documentation/RelNotes/1.6.3.txt | 2 +-
>  Documentation/RelNotes/1.6.4.txt | 2 +-
>  Documentation/RelNotes/1.6.5.txt | 2 +-
>  Documentation/RelNotes/1.6.6.txt | 2 +-
>  Documentation/RelNotes/1.8.4.txt | 2 +-
>  Documentation/RelNotes/2.5.0.txt | 3 ++-
>  Documentation/RelNotes/2.8.3.txt | 4 ++--
>  Documentation/RelNotes/2.9.0.txt | 2 +-
>  9 files changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/RelNotes/1.6.2.txt b/Documentation/RelNotes/1.6.2.txt
> index ad060f4f89..980adfb315 100644
> --- a/Documentation/RelNotes/1.6.2.txt
> +++ b/Documentation/RelNotes/1.6.2.txt
> @@ -11,7 +11,7 @@ push running this release will issue a big warning when the
>  configuration variable is missing.  Please refer to:
>  
>    http://git.or.cz/gitwiki/GitFaq#non-bare
> -  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
> +  https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
>  
>  for more details on the reason why this change is needed and the
>  transition plan.
> diff --git a/Documentation/RelNotes/1.6.3.txt b/Documentation/RelNotes/1.6.3.txt
> index 418c685cf8..4bcff945e0 100644
> --- a/Documentation/RelNotes/1.6.3.txt
> +++ b/Documentation/RelNotes/1.6.3.txt
> @@ -11,7 +11,7 @@ push running this release will issue a big warning when the
>  configuration variable is missing.  Please refer to:
>  
>    http://git.or.cz/gitwiki/GitFaq#non-bare
> -  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
> +  https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
>  
>  for more details on the reason why this change is needed and the
>  transition plan.
> diff --git a/Documentation/RelNotes/1.6.4.txt b/Documentation/RelNotes/1.6.4.txt
> index 7a904419f7..a2a34b43a7 100644
> --- a/Documentation/RelNotes/1.6.4.txt
> +++ b/Documentation/RelNotes/1.6.4.txt
> @@ -11,7 +11,7 @@ push running this release will issue a big warning when the
>  configuration variable is missing.  Please refer to:
>  
>    http://git.or.cz/gitwiki/GitFaq#non-bare
> -  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
> +  https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
>  
>  for more details on the reason why this change is needed and the
>  transition plan.
> diff --git a/Documentation/RelNotes/1.6.5.txt b/Documentation/RelNotes/1.6.5.txt
> index ee141c19ad..6c7f7da7eb 100644
> --- a/Documentation/RelNotes/1.6.5.txt
> +++ b/Documentation/RelNotes/1.6.5.txt
> @@ -22,7 +22,7 @@ push running this release will issue a big warning when the
>  configuration variable is missing.  Please refer to:
>  
>    http://git.or.cz/gitwiki/GitFaq#non-bare
> -  http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
> +  https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
>  
>  for more details on the reason why this change is needed and the
>  transition plan.
> diff --git a/Documentation/RelNotes/1.6.6.txt b/Documentation/RelNotes/1.6.6.txt
> index c50b59c495..3ed1e01433 100644
> --- a/Documentation/RelNotes/1.6.6.txt
> +++ b/Documentation/RelNotes/1.6.6.txt
> @@ -64,7 +64,7 @@ users will fare this time.
>     Please refer to:
>  
>     http://git.or.cz/gitwiki/GitFaq#non-bare
> -   http://thread.gmane.org/gmane.comp.version-control.git/107758/focus=108007
> +   https://lore.kernel.org/git/7vbptlsuyv.fsf@gitster.siamese.dyndns.org/
>  
>     for more details on the reason why this change is needed and the
>     transition process that already took place so far.
> diff --git a/Documentation/RelNotes/1.8.4.txt b/Documentation/RelNotes/1.8.4.txt
> index 02f681b710..255e185af6 100644
> --- a/Documentation/RelNotes/1.8.4.txt
> +++ b/Documentation/RelNotes/1.8.4.txt
> @@ -58,7 +58,7 @@ Foreign interfaces, subsystems and ports.
>     credential helper interface from Git.pm.
>  
>   * Update build for Cygwin 1.[57].  Torsten Bögershausen reports that
> -   this is fine with Cygwin 1.7 ($gmane/225824) so let's try moving it
> +   this is fine with Cygwin 1.7 (cf. <51A606A0.5060101@web.de>) so let's try moving it
>     ahead.
>  
>   * The credential helper to talk to keychain on OS X (in contrib/) has
> diff --git a/Documentation/RelNotes/2.5.0.txt b/Documentation/RelNotes/2.5.0.txt
> index 87044504c5..84723f912a 100644
> --- a/Documentation/RelNotes/2.5.0.txt
> +++ b/Documentation/RelNotes/2.5.0.txt
> @@ -172,7 +172,8 @@ Performance, Internal Implementation, Development Support etc.
>     incorrect patch text to "git apply".  Add tests to demonstrate
>     this.
>  
> -   I have a slight suspicion that this may be $gmane/87202 coming back
> +   I have a slight suspicion that this may be
> +   cf. <7vtzf77wjp.fsf@gitster.siamese.dyndns.org> coming back
>     and biting us (I seem to have said "let's run with this and see
>     what happens" back then).
>  
> diff --git a/Documentation/RelNotes/2.8.3.txt b/Documentation/RelNotes/2.8.3.txt
> index fedd9968e5..266c4781a8 100644
> --- a/Documentation/RelNotes/2.8.3.txt
> +++ b/Documentation/RelNotes/2.8.3.txt
> @@ -55,8 +55,8 @@ Fixes since v2.8.2
>     This is necessary to use Git on Windows shared directories, and is
>     already enabled for the MinGW and plain Windows builds.  It also
>     has been used in Cygwin packaged versions of Git for quite a while.
> -   See http://thread.gmane.org/gmane.comp.version-control.git/291853
> -   and http://thread.gmane.org/gmane.comp.version-control.git/275680.
> +   See https://lkml.org/git/20160419091055.GF2345@dinwoodie.org/
> +   and https://lkml.org/git/20150811100527.GW14466@dinwoodie.org/.

Brainfart continues here... Wrong URL.

>  
>   * "git replace -e" did not honour "core.editor" configuration.
>  
> diff --git a/Documentation/RelNotes/2.9.0.txt b/Documentation/RelNotes/2.9.0.txt
> index b61d36712f..d5f95b6641 100644
> --- a/Documentation/RelNotes/2.9.0.txt
> +++ b/Documentation/RelNotes/2.9.0.txt
> @@ -368,7 +368,7 @@ notes for details).
>     This is necessary to use Git on Windows shared directories, and is
>     already enabled for the MinGW and plain Windows builds.  It also
>     has been used in Cygwin packaged versions of Git for quite a while.
> -   See http://thread.gmane.org/gmane.comp.version-control.git/291853
> +   See https://lkml.org/git/20160419091055.GF2345@dinwoodie.org/

And here. If Peff's series gets picked up, I'll reroll mine as well.

>  
>   * "merge-octopus" strategy did not ensure that the index is clean
>     when merge begins.
> -- 
> 2.24.0.504.g3cd56eb17d
> 
