Return-Path: <SRS0=Fd5/=4D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A776C2BA83
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 14:01:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E009A2086A
	for <git@archiver.kernel.org>; Sat, 15 Feb 2020 14:01:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A4MP3zs9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgBOOA4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 Feb 2020 09:00:56 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:35898 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726090AbgBOOA4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 Feb 2020 09:00:56 -0500
Received: by mail-io1-f66.google.com with SMTP id d15so13729891iog.3
        for <git@vger.kernel.org>; Sat, 15 Feb 2020 06:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/wahPnF5Sf+PPsYFuAZjcYbxGbzGwpjc8YS7uf8cPI=;
        b=A4MP3zs9pXAodSAQnM8wVJ6LTw/2USoqAfb313PK5deS60u5cQZ9QHBQYhQEDycAQ2
         mkKwNREkGNoq/JJyzt9C+c8Eq0phNjLqA2aC1RMNWPYOVaslBtiTdO73/Qzcz7puwHnh
         nRPOtSruS3HsmBE/79g+LairsF+uT7WXVIpn+sdehpFjqgfZwuYSewJradNTCngEcFlq
         Hemn7If2w1GGjv2+Kg9DTGdwdpx8MIrAozRnQDyxk+cz8I3AcvQw8yDPEkTT/N/wlSfA
         qS976YT53rlw/hJrvgcW/2p38XZRN30b+qaA8FMyzrn8c+ppXnGfQGiZw8A8Dqs5wMdx
         OezQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/wahPnF5Sf+PPsYFuAZjcYbxGbzGwpjc8YS7uf8cPI=;
        b=fJpMYqCHXzUdaDWtnyYM7fui7IXP5OvRZek5FAljxso9N12HoU/lQTF4+2r559+6hx
         n5+toEBRLQsYmmbdoCibaM2M7DzE6u/iPEW+TECJUoepdSOgrNfZbE3PNium63hoVWpc
         aEw2VTU2KlqcvfL5CuhZVvgKIZWfiJAGuaTdGAaRsJM0OBdsJjl8enVjsqJcn2p2xbCe
         NYvLA4BecdyD3myQ9+9Hxaat4ehH0/5pslDip3wbvs2DrWnTwjHANv1CfiqTS1SWjPSr
         DAAsEm2kbLbZwCeDFR/eEW2yeUUqHjshP2D3n13iSgWtQ4MgGxI0aSd3pw3RIw6w8lWP
         G0Qw==
X-Gm-Message-State: APjAAAWMglMPWnPKx79jPeL2z1dKx5x3LdWoYGNsfrvQ1RLy0uCNkME8
        R9KIoynyi65zt1Z9KegZ6TLclzSg3cjfaItFyiwmT6gq0b8=
X-Google-Smtp-Source: APXvYqzU8WnhfXIgImJRfWxmp0/SPHaY2runV//S/sagZB9l+f1LJsJx1kI8ZyZhVyi8pbmSk/vLOjX0woCgSWFlbOk=
X-Received: by 2002:a6b:6007:: with SMTP id r7mr6418194iog.223.1581775254656;
 Sat, 15 Feb 2020 06:00:54 -0800 (PST)
MIME-Version: 1.0
References: <CAFFaXsyVy-fU5c7teDbVCTdUXFTK0GQ=Fse5wSi2vMifyZxS9A@mail.gmail.com>
 <xmqqk15rf21d.fsf@gitster-ct.c.googlers.com> <CAFFaXsz9LEdegzxL8MhS+VfTs-wmWu+CGDjxjB4Xgj8+7nSHNQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001171433180.46@tvgsbejvaqbjf.bet> <CAFFaXsyiLeNPCZ+Kn1x-+0pZf0FiPQR-k8qtooFrdG+VNfLq+g@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001202232460.46@tvgsbejvaqbjf.bet> <CAFFaXsxLd8duDPTE1H-zJiYnTVSB3pHCfBV+08Y4jLvCWR9kNw@mail.gmail.com>
 <nycvar.QRO.7.76.6.2001212144560.46@tvgsbejvaqbjf.bet> <xmqqmuaf70xx.fsf@gitster-ct.c.googlers.com>
 <CAFFaXsxeyxkPwAYSs=TEzd8fsa5r9KpJ7q8PX0ehNJ1Wpai4fA@mail.gmail.com> <nycvar.QRO.7.76.6.2002012229480.46@tvgsbejvaqbjf.bet>
In-Reply-To: <nycvar.QRO.7.76.6.2002012229480.46@tvgsbejvaqbjf.bet>
From:   Nirmal Khedkar <nirmalhk7@gmail.com>
Date:   Sat, 15 Feb 2020 19:30:18 +0530
Message-ID: <CAFFaXsztYtNtWeEMgkjYcZ-0_bcywGo5zFV0vwg6UjtXCx1ocw@mail.gmail.com>
Subject: Re: Facing error in git-imap-send while compiling Git
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>, dev+git@drbeat.li
Cc:     git@vger.kernel.org, gitster@pobox.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi All!
Apologies for late reply, had examinations for past week.

On Sun, Feb 2, 2020 at 3:05 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Nirmal,
>
> On Fri, 31 Jan 2020, Nirmal Khedkar wrote:
>
> > I'll admit I'm quite perplexed with this OpenSSL problem that I'm
> > facing. Here's what I've done along with their results:
> > 1. eroen and Jack Bates' suggestions
> > (https://lore.kernel.org/git/66967e0e-8bd9-f4b6-d2d4-ccce9004f42e@nottheoilrig.com/)
> > 2. I've also implemented Johannes' suggestions, and I'm still facing
> > the same problem.
>
> Could you repeat the symptoms? I forgot the details since you posted your
> previous email.

Here's the latest errors:
---
    LINK git-imap-send
imap-send.o: In function `verify_hostname':
imap-send.c:261: undefined reference to `sk_num'
imap-send.c:263: undefined reference to `sk_value'
imap-send.c:269: undefined reference to `sk_pop_free'
imap-send.c:269: undefined reference to `sk_pop_free'
imap-send.o: In function `ssl_socket_connect':
imap-send.c:301: undefined reference to `SSL_load_error_strings'
imap-send.c:302: undefined reference to `SSLv23_method'
collect2: error: ld returned 1 exit status
Makefile:2454: recipe for target 'git-imap-send' failed
make: *** [git-imap-send] Error 1
---

I was kind-of hoping that when I switch from Linux 5.3 Edge to Linux
5.3 (Which came about a week ago), these issues would disappear, but
they still exist.

I've also tried Beat Bolli's suggestion, but I get *no output* when I
run "make V=1 imap-send.o". I dont understand why either.

My previous emails have already mentioned this: I seriously want to
apply to Git. Its a serious component to all my projects and pretty
sure for everyone else's too, and contributing to Git gives me the
_contributing-back-to-society_ vibes which I like :)

So I'd love if someone could break down to me (who's never worked with
OpenSSL) on what imap-send does (in words simpler than ones in
manpages). I think only if I understand OpenSSL better, will I be able
to fix this issue.

Thanks a lot!
Regards,
Nirmal Khedkar

--
Nirmal Khedkar
https://nirmalhk7.github.io
Github: www.github.com/nirmalhk7



On Sun, Feb 2, 2020 at 3:05 AM Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:
>
> Hi Nirmal,
>
> On Fri, 31 Jan 2020, Nirmal Khedkar wrote:
>
> > I'll admit I'm quite perplexed with this OpenSSL problem that I'm
> > facing. Here's what I've done along with their results:
> > 1. eroen and Jack Bates' suggestions
> > (https://lore.kernel.org/git/66967e0e-8bd9-f4b6-d2d4-ccce9004f42e@nottheoilrig.com/)
> > 2. I've also implemented Johannes' suggestions, and I'm still facing
> > the same problem.
>
> Could you repeat the symptoms? I forgot the details since you posted your
> previous email.
>
> > Here's the final diff:
> > ---
> > diff --git a/imap-send.c b/imap-send.c
> > index 6c54d8c29d..3248bc2123 100644
> > --- a/imap-send.c
> > +++ b/imap-send.c
> > @@ -41,7 +41,9 @@ typedef void *SSL;
> >  /* We don't have curl, so continue to use the historical implementation */
> >  #define USE_CURL_DEFAULT 0
> >  #endif
> > -
> > +#ifndef SSL_library_init
> > +       #define SSL_library_init();
> > +#endif
> >  static int verbosity;
> >  static int use_curl = USE_CURL_DEFAULT;
> >
> > @@ -59,6 +61,13 @@ static struct option imap_send_options[] = {
> >  #define DRV_BOX_BAD     -2
> >  #define DRV_STORE_BAD   -3
> >
> > +
> > +#if OPENSSL_VERSION_NUMBER < 0x10100000L
> > +       #define OPENSSL_sk_num(x) sk_GENERAL_NAME_num(x)
> > +       #define OPENSSL_sk_value(x,y) sk_GENERAL_NAME_value((x),(y))
> > +       #define OPENSSL_sk_pop_free(x,y) sk_GENERAL_NAME_pop_free((x),(y))
> > +#endif
> > +
> >  __attribute__((format (printf, 1, 2)))
> >  static void imap_info(const char *, ...);
> >  __attribute__((format (printf, 1, 2)))
> > @@ -275,21 +284,30 @@ static int verify_hostname(X509 *cert, const
> > char *hostname)
> >
> >  static int ssl_socket_connect(struct imap_socket *sock, int
> > use_tls_only, int verify)
> >  {
> > -#if (OPENSSL_VERSION_NUMBER >= 0x10000000L)
> > -       const SSL_METHOD *meth;
> > -#else
> > -       SSL_METHOD *meth;
> > -#endif
> > -       SSL_CTX *ctx;
> > -       int ret;
> > -       X509 *cert;
> > -
> > -       SSL_library_init();
> > -       SSL_load_error_strings();
> > +       #if (OPENSSL_VERSION_NUMBER >= 0x10000000L)
> > +               const SSL_METHOD *meth;
> > +       #else
> > +               SSL_METHOD *meth;
> > +       #endif
> > +               SSL_CTX *ctx;
> > +               int ret;
> > +               X509 *cert;
> > +
> > +       #if OPENSSL_VERSION_NUMBER >= 0x10100000L ||
> > defined(LIBRESSL_VERSION_NUMBER)
> > +               OPENSSL_init_ssl(0, NULL);
> > +               meth = TLS_method();
> > +       #else
> > +               SSL_library_init();
> > +               SSL_load_error_strings();
> > +               meth = SSLv23_method();
> > +       #endif
> >
> > -       meth = SSLv23_method();
> >         if (!meth) {
> > -               ssl_socket_perror("SSLv23_method");
> > +       #if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
> > +                       ssl_socket_perror("TLS_method");
> > +       #else
> > +                       ssl_socket_perror("SSLv23_method");
> > +       #endif
> >                 return -1;
> >         }
> >
> >
> > ---
>
> That diff looks pretty okay to me.
>
> > Also, on a different note: I'm actually really interested in applying
> > to Git for GSoC, and I should be doing Git microprojects right now to
> > properly cement my chance of doing GSoC with Git. Many aspiring GSoC
> > applicants already been asking, enquiring and maybe even working about
> > Git microprojects, as evident from the mailing list.
>
> For the record, I am not even sure whether Git will participate in GSoC
> this year; I am not aware of any activity in that direction.
>
> Having said that, the purpose of a Git microproject is to get acquainted
> with the development process of Git (at least in my mind). It is not so
> much fixing some issue in Git, but more like learning how to interact with
> the Git mailing list, in particular how to communicate effectively with
> the developers/reviewers on this list.
>
> In that light, if I were a possible mentor (which I am not, at least not
> in this year's GSoC) I would not insist on a microproject. Or more like: I
> would accept your work on getting this vexing OpenSSL v1.1.1 issue sorted
> out as a microproject in its own right.
>
> > So while I'm not saying that I'm in deep trouble and all this OpenSSL
> > v1.1.1 issue fixing is completely useless (I'm learning quite a lot
> > along the way and able to understand the project structure), but
> > saying that I'm not worried about my GSoC prospects of working in this
> > organization would honestly be false :) . I love git, I would love
> > contributing to Git, but I'd love to do a GSoC Summer with Git much
> > more than the rest.
> >
> > Please let me know where am I going wrong. If there's any other system
> > packages that I can download so that I can focus on other Git issues
> > and this one simultaneously, please let me know. Here are my system
> > specifications (let me know if you need anything more specific):
> > ---
> > OS: Ubuntu 18.04
> > Linux Kernel: 5.3
> > OpenSSL Version: 1.1.1d
> > ---
> >
> > Apologies for the long email,
>
> This is not even close to being the longest email sent to this list, so
> don't worry!
>
> Ciao,
> Johannes
>
> > Thank You,
> > Nirmal Khedkar
> > (https://nirmalhk7.github.io)
> >
> >
> > On Thu, Jan 23, 2020 at 12:50 AM Junio C Hamano <gitster@pobox.com> wrote:
> > >
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > >
> > > >> From my limited knowledge of OpenSSL libraries, I think the error has
> > > >> more to do with 'SSL_library_init()' , which appears like a
> > > >> constructor to the OpenSSL library. I found these emails regarding
> > > >> "if" cases around this function. Please check out these patches:
> > > >> 1. Rosen Penev:
> > > >> https://lore.kernel.org/git/20181227023548.396-1-rosenp@gmail.com/
> > > >
> > > > I remember that one. And I agreed with Junio that the documentation
> > > > suggests that the call is _optional_, while the patch suggests that it
> > > > would be _incorrect_ instead.
> > > >
> > > > And looking at
> > > > https://www.openssl.org/docs/man1.1.1/man3/SSL_library_init.html suggests
> > > > to me that it is still supported.
> > > >
> > > > Having said that, if I look at the headers installed for `libssl-dev`
> > > > version `1.1.1-1ubuntu2.1~18.04.5` in my Ubuntu installation, I see that
> > > > `/usr/include/openssl/ssl.h` defines that symbol as:
> > > >
> > > >       #  define SSL_library_init() OPENSSL_init_ssl(0, NULL)
> > > >
> > > > but _only_:
> > > >
> > > >       # if OPENSSL_API_COMPAT < 0x10100000L
> > > >
> > > > So maybe that disagrees with the documentation that says that
> > > > SSL_library_init() is optional?
> > > >
> > > > The curious thing is that `OPENSSL_API_COMPAT` is not even defined
> > > > anywhere. So maybe it _is_ the right thing to also `#define
> > > > SSL_library_init() (void)` in the diff you listed above?
> > > >
> > > > _Maybe_ guarded within `#ifndef SSL_library_init ... #endif` guards?
> > > >
> > > >> 2. eroen: https://lore.kernel.org/git/20170112104219.563497-1-git-scm@occam.eroen.eu/
> > > >
> > > > That sounds like a good suggestion, too.
> > > >
> > > >> Are the fixes made in these patches relevant here. Please let me know
> > > >> if I'm going wrong.
> > > >
> > > > Yes, both threads are relevant, and if you can reconcile them into a patch
> > > > that makes Git compile with OpenSSL v1.1.1, I will try my best to review
> > > > them (Cc: me, just in case).
> > >
> > > I agree with the above reasoning and the suggestion given by Bates in
> > > https://lore.kernel.org/git/66967e0e-8bd9-f4b6-d2d4-ccce9004f42e@nottheoilrig.com/
> > > sounds like a reasonable one.
> > >
> > > Thanks for digging and double-checking these two previous efforts,
> > > and giving another round of thoughts on them.
> > >
> > >
> > >
> > >
> >
