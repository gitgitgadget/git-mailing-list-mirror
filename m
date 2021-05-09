Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A81C433ED
	for <git@archiver.kernel.org>; Sun,  9 May 2021 08:29:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97992613BB
	for <git@archiver.kernel.org>; Sun,  9 May 2021 08:29:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhEIIaX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 04:30:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbhEIIaW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 04:30:22 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FC11C061573
        for <git@vger.kernel.org>; Sun,  9 May 2021 01:29:20 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id b15so1502483plh.10
        for <git@vger.kernel.org>; Sun, 09 May 2021 01:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hloqix8jQrB493u2HxxdmxjFdo52RXj9RpZKSyABBwI=;
        b=OYEOYcJ9W0eUYUcAir8D4wK7IAUbaCI1abkakEKFOgMQf7gJpAWLIPEwa/VbKI3eQN
         1WSIrWQ+Pg63Y36KVqw3tetSP8BG2n4cDuqrOJjxY0l6iISvNQjKzFN+qCCFsxnZJiIB
         zM9WTEJ0RDqWym1SYFpDO07EStcEfc98TJLPWQWANwDBugdidTH3J5a5OVI2z+HQvBTG
         00xqviomPbMWtQjSc3n+ACPQ4Rn9o/hSRhWkOLSLvUQJiH4Rr3CliEU6DtdKicnl9y/X
         EomCXkAA9HzhsaP97xxhONHhWvYIWl98rZASuZgxCRy90pXplzDWSb5z3svbK3xr6kF6
         DDug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hloqix8jQrB493u2HxxdmxjFdo52RXj9RpZKSyABBwI=;
        b=nOyL48h8f60EHtR3++SKz4b+LmvSbpCBMJmQaXUy2S2lUizfKaE+qH56Ptqy9wXPgO
         NrfiUrerR/1GFG3tKF4gDoSNB9mKe4yHla2nFA7o0BW90dicXbgeDxZrnmUbPOkdzvUH
         ch5RnEyWSVSRkt/Gpwj2yqGguX9t13Y/duP6un/0bpNfQWuEiyxbkf2l4f4nHDHQIc0B
         /A0Q1H+0716Ap+JkWc+wXwqMaBGXCiRJPZisDVzIbcEYvhDLe4l2qYjVNWUbnCdfe/eQ
         USRFxsa/b6zAkGI8e2j2U1DFWiHrXCidNOv2MCTnZObtK2Ts6/6n3aMBuo3GlYOuZCLV
         hckg==
X-Gm-Message-State: AOAM530qIMXn1Ehh51iXkDnxp+XfB/+uVBHansoR/TEPholyuAYNEy5E
        9152JXBKamUwpvZvpyLJXSf5OKdOPk06/isVwU1vLD9eHuI=
X-Google-Smtp-Source: ABdhPJxk7GrOvzIhMskbHnXZExBH8+govdbRy+Vvmld2iIprgCNT9GrDGjmEU5pByePSvJsqMIHPspT/HPNHXL3bnDk=
X-Received: by 2002:a17:902:9a01:b029:ef:11d:4b77 with SMTP id
 v1-20020a1709029a01b02900ef011d4b77mr15167921plp.51.1620548959969; Sun, 09
 May 2021 01:29:19 -0700 (PDT)
MIME-Version: 1.0
References: <3461c7b0-594d-989e-3048-2fc6583084ad@gmail.com>
 <YJWiQH2nf0B14Zy7@camp.crustytoothpaste.net> <6095ceb984401_cfc7208b9@natae.notmuch>
In-Reply-To: <6095ceb984401_cfc7208b9@natae.notmuch>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Sun, 9 May 2021 10:29:08 +0200
Message-ID: <CAN0heSrbJQjzbwm3CiNh7UduKSYKogsHBh6RQszDuk2cGu=r=w@mail.gmail.com>
Subject: Re: [RFC suggestion] Generate manpage directly with Asciidoctor
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Git Users <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, 8 May 2021 at 01:40, Felipe Contreras
<felipe.contreras@gmail.com> wrote:
>
> brian m. carlson wrote:
> > On 2021-05-07 at 06:06:31, Bagas Sanjaya wrote:
> > > So completely migrating to Asciidoctor can eliminate xmlto requirement
> > > for generating manpage.
> > >
> > > What do you think about above?
> >
> > I didn't do this because it makes things very complicated in the
> > Makefile and my goal was to minimize the needed changes and divergence.
> > I'm not opposed to someone else doing it, but I expect it will be a
> > bunch of work.
>
> I don't think it would be that complicated.
>
> This patch seems to do the trick here:

This looks similar to Todd's wip [1]. Here's something
whitespace-damaged on top that improves some things, but I'm sure
there's more to do. I think in order to work on this, it would need to
be a separate switch so that we can use asciidoctor both the old-school
and the new-school way for a while.

[1] https://lore.kernel.org/git/20190317194431.GY31362@pobox.com/

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 0cfa88a92b..9f73d2d033 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -192,7 +192,9 @@ ASCIIDOC_HTML = xhtml5
 ASCIIDOC_DOCBOOK = docbook5
 ASCIIDOC_EXTRA += -acompat-mode -atabsize=8
 ASCIIDOC_EXTRA += -I. -rasciidoctor-extensions
-ASCIIDOC_EXTRA += -alitdd='&\#x2d;&\#x2d;'
+ASCIIDOC_EXTRA += -alitdd='\--'
+ASCIIDOC_EXTRA += -aplus='+'
+ASCIIDOC_COMMON += -a mansource="Git $(GIT_VERSION)" -a manmanual="Git Manual"
 DBLATEX_COMMON =
 XMLTO_EXTRA += --skip-validation
 XMLTO_EXTRA += -x manpage.xsl
diff --git a/Documentation/asciidoctor-extensions.rb
b/Documentation/asciidoctor-extensions.rb
index d906a00803..fb74443241 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -10,11 +10,16 @@ module Git

       def process(parent, target, attrs)
         prefix = parent.document.attr('git-relative-html-prefix')
+        s = "#{target}(#{attrs[1]})"
         if parent.document.doctype == 'book'
           "<ulink url=\"#{prefix}#{target}.html\">" \
           "#{target}(#{attrs[1]})</ulink>"
+        elsif parent.document.basebackend? 'manpage'
+          # FIXME: boldness should respect NO_MAN_BOLD_LITERAL?
+          # -- should be doable using an attribute, similar
+          # to "prefix" above
+          create_inline(parent, :quoted, s, type: :strong).convert
         elsif parent.document.basebackend? 'html'
           %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
         elsif parent.document.basebackend? 'docbook'
           "<citerefentry>\n" \
             "<refentrytitle>#{target}</refentrytitle>" \
