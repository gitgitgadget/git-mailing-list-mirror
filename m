Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A22D9C636CC
	for <git@archiver.kernel.org>; Sat,  4 Feb 2023 13:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbjBDNnm (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 08:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231355AbjBDNnh (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 08:43:37 -0500
Received: from mail-il1-x12e.google.com (mail-il1-x12e.google.com [IPv6:2607:f8b0:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81BE206BF
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 05:43:34 -0800 (PST)
Received: by mail-il1-x12e.google.com with SMTP id g16so3174497ilr.1
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 05:43:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RV8YnSNbQ28EtZAsR8JVuvTjseOwVuM38lhI3Hh/KuI=;
        b=jVkLOdLDtY3AVDVJkBHAYfAPdNuMS65AZiVvqqJctG1nxuN5DJiiTdSfosqWFkh5GE
         2yoifXzloG+sQwZ6Ef/E41JOnZ7Qq0MIVvuahy8czx6T/qBBZSae2kZP3mB32Fgt+TYF
         yyUD3pO15GQLrrYY8gx5PlPOGDlSVIadlv9TYRuht/smhwgRyjKxv10z6qVmsZAE9QHP
         zIKxEuw8pfrQBK8pE8yUpBOScorODWl3SpD/OdNNiGtTC0hm0uFCGvu44+6BKhkZ/Qtm
         kozMFq58h5ElyKefpbGqcMHEJvggpDz0M5gkIVsquMr59TLfbGHHUMZ7x5V2HTqzmOYO
         m5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RV8YnSNbQ28EtZAsR8JVuvTjseOwVuM38lhI3Hh/KuI=;
        b=BUoMgWtU1tSd651IHT72T7lRcc72/vwbX3/Zl1/j/Sb51b58btg/iKsiMlgKtDASh4
         SzPlpzBKNfF1VmHpyoeIEWyP9zUWCfxiSVxukvNcQgzEIChmB/zoA1hOjbN2Z+bMfrGL
         XNYFbRqjKnKq5Nf2NCunYZptyuwDM1Wa+Wbkdy9LwIq0DqEjAJSIEZfBUJ2SrpSNBX5w
         Q4RWbg8Axqas+OfBrQmapYWVs90Gm6Ubl2TlmqmYanOrVIx5l77+1dBwvKKLJcqL2ZRv
         40H4gEap63f++2UqNXxUO9y3JugIlt5BVF8Oztg8He7PsWtfNUky+hWaj3Kd/YYaVNyf
         rj2g==
X-Gm-Message-State: AO0yUKWLPltiOwgvj3HYG2Zr3EpkLnc7DpGznYNyTkqIBAm7ZzcgrdsD
        w/EqJMkUvdsgo4tlXn9vezc=
X-Google-Smtp-Source: AK7set9dGH7HMvAhRKHHEY9Uqia3pxtdQOomsXZu22aSEXwkWXuFlsZcFzGkCshxyK8nizNfWCvNbg==
X-Received: by 2002:a05:6e02:12ea:b0:310:ea0f:3229 with SMTP id l10-20020a056e0212ea00b00310ea0f3229mr10975967iln.18.1675518214204;
        Sat, 04 Feb 2023 05:43:34 -0800 (PST)
Received: from titov.fritz.box ([191.101.157.6])
        by smtp.gmail.com with ESMTPSA id q8-20020a027b08000000b003af4300d670sm1802449jac.27.2023.02.04.05.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 05:43:33 -0800 (PST)
From:   Andrei Rybak <rybak.a.v@gmail.com>
To:     Tassilo Horn <tsdh@gnu.org>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Paolo Bonzini <pbonzini@redhat.com>,
        Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH v2 0/3] userdiff: Java updates
Date:   Sat,  4 Feb 2023 14:43:26 +0100
Message-Id: <20230204134329.251451-1-rybak.a.v@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <877cwxvl3a.fsf@gnu.org>
References: <877cwxvl3a.fsf@gnu.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 04/02/2023 10:22, Tassilo Horn wrote:
> Thanks for including me being the last contributor to java userdiff.
> The patches look good from my POV and are safe-guarded with tests, so
> I'm all for it.

Thank you for review!

I've realized that I've been writing modifiers "abstract" and "sealed" in a
technically correct, but not the conventional order.  Here's a reroll with the
order of modifiers following the style of original authors of
https://openjdk.org/jeps/409.  It doesn't matter for the purposes of the test,
but it will be less annoying to any future readers :-)

Range diff since v1:

1:  c300745a58 = 1:  c300745a58 userdiff: support Java type parameters
2:  a0e622a0f8 = 2:  a0e622a0f8 userdiff: support Java record types
3:  a53fca4d49 ! 3:  b9c6a5dffd userdiff: support Java sealed classes
    @@ Commit message
     
      ## t/t4018/java-non-sealed (new) ##
     @@
    -+public sealed abstract class SealedClass {
    ++public abstract sealed class SealedClass {
     +    public static non-sealed class RIGHT extends SealedClass {
     +        static int ONE;
     +        static int TWO;
    @@ t/t4018/java-non-sealed (new)
     
      ## t/t4018/java-sealed (new) ##
     @@
    -+public sealed abstract class Sealed { // RIGHT
    ++public abstract sealed class Sealed { // RIGHT
     +    static int ONE;
     +    static int TWO;
     +    static int THREE;
    @@ t/t4018/java-sealed (new)
     
      ## t/t4018/java-sealed-permits (new) ##
     @@
    -+public sealed abstract class RIGHT permits PermittedA, PermittedB {
    ++public abstract sealed class RIGHT permits PermittedA, PermittedB {
     +    static int ONE;
     +    static int TWO;
     +    static int THREE;
    @@ t/t4018/java-sealed-permits (new)
     
      ## t/t4018/java-sealed-type-parameters (new) ##
     @@
    -+public sealed abstract class RIGHT<A, B> {
    ++public abstract sealed class RIGHT<A, B> {
     +    static int ONE;
     +    static int TWO;
     +    static int THREE;
    @@ t/t4018/java-sealed-type-parameters (new)
     
      ## t/t4018/java-sealed-type-parameters-implements-permits (new) ##
     @@
    -+public sealed abstract class RIGHT<A, B> implements List<A> permits PermittedA, PermittedB {
    ++public abstract sealed class RIGHT<A, B> implements List<A> permits PermittedA, PermittedB {
     +    static int ONE;
     +    static int TWO;
     +    static int THREE;
    @@ t/t4018/java-sealed-type-parameters-implements-permits (new)
     
      ## t/t4018/java-sealed-type-parameters-permits (new) ##
     @@
    -+public sealed abstract class RIGHT<A, B> permits PermittedA, PermittedB {
    ++public abstract sealed class RIGHT<A, B> permits PermittedA, PermittedB {
     +    static int ONE;
     +    static int TWO;
     +    static int THREE;


Andrei Rybak (3):
  userdiff: support Java type parameters
  userdiff: support Java record types
  userdiff: support Java sealed classes

 t/t4018/java-class-type-parameters                     | 6 ++++++
 t/t4018/java-class-type-parameters-implements          | 6 ++++++
 t/t4018/java-interface-type-parameters                 | 6 ++++++
 t/t4018/java-interface-type-parameters-extends         | 6 ++++++
 t/t4018/java-non-sealed                                | 8 ++++++++
 t/t4018/java-record                                    | 6 ++++++
 t/t4018/java-record-type-parameters                    | 6 ++++++
 t/t4018/java-sealed                                    | 7 +++++++
 t/t4018/java-sealed-permits                            | 6 ++++++
 t/t4018/java-sealed-type-parameters                    | 6 ++++++
 t/t4018/java-sealed-type-parameters-implements-permits | 6 ++++++
 t/t4018/java-sealed-type-parameters-permits            | 6 ++++++
 userdiff.c                                             | 2 +-
 13 files changed, 76 insertions(+), 1 deletion(-)
 create mode 100644 t/t4018/java-class-type-parameters
 create mode 100644 t/t4018/java-class-type-parameters-implements
 create mode 100644 t/t4018/java-interface-type-parameters
 create mode 100644 t/t4018/java-interface-type-parameters-extends
 create mode 100644 t/t4018/java-non-sealed
 create mode 100644 t/t4018/java-record
 create mode 100644 t/t4018/java-record-type-parameters
 create mode 100644 t/t4018/java-sealed
 create mode 100644 t/t4018/java-sealed-permits
 create mode 100644 t/t4018/java-sealed-type-parameters
 create mode 100644 t/t4018/java-sealed-type-parameters-implements-permits
 create mode 100644 t/t4018/java-sealed-type-parameters-permits

-- 
2.39.1

