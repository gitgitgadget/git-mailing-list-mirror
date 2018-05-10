Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D2AF1F406
	for <e@80x24.org>; Thu, 10 May 2018 18:11:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966742AbeEJSLs (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 May 2018 14:11:48 -0400
Received: from mail-pl0-f54.google.com ([209.85.160.54]:34346 "EHLO
        mail-pl0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966673AbeEJSLr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 May 2018 14:11:47 -0400
Received: by mail-pl0-f54.google.com with SMTP id ay10-v6so1757855plb.1
        for <git@vger.kernel.org>; Thu, 10 May 2018 11:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:to
         :mime-version;
        bh=VBykJpxATwln07vO5TE1aQmFa6BHw8ZlSSBBUHWxuw4=;
        b=W5kXkZsrpQOpbo+KhwGd/rT99xhZ1wPpDqBr/CaU8XN/xvK+LU7m6OixpyZ3dVSwUt
         pWzLDEfpWbfSnI+wDPwmJ/ESP3GXalttKm+uC47H/l62kBQ28iyLp/uAAsZYnSwvX9mC
         LQDWDGAVAM8rz04xoHbW0qs5c4qUHucXECY1WnhuOVVSxWXH34r5aMJPtw+tzAbE6Bnx
         apXiV21kI9QpNRvQq+qxKQC3WznLJ+0nT8Y+7pELYUd20ppzjZWMO6B3fcs+ujeXtrrP
         pRPsm3kNe1OR5hAwR7bLgvUGTOUADKYphSrlECtcgl98TWQ/MDaNmuJYNZvF4oFw8XEJ
         5Lfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:to:mime-version;
        bh=VBykJpxATwln07vO5TE1aQmFa6BHw8ZlSSBBUHWxuw4=;
        b=UzwYPnsW2npIyAYvZJQWyrhIafrNHe8OqIeEg5AmS8svbeQV9NGc07XKoFuQgDR1X5
         69vXtpIWev1Qp5Gfosz7P5HvUG5tqYszoV89xqW958Zij3yxwUIWcCQvf9gJAmdeiY0U
         Ti5JvXLo2A+jB3RDGBBDLfYvC2wHVa0IAxQFB8oknL/bpP7NfI8a92RioGEJ0BzfaP4R
         R4IWc8O5GFG40tc4Qa0iM9ES0a9k/72QrrC80cGXym90hGWM5lSR39Nv2HyJx7G92hUQ
         Vyhr/cdMBSHHqE92uqJpNTYs0LaaU0X4+o0ZIV5BXLW57cAvL/7y0RPXtNWefKNxff1l
         yteQ==
X-Gm-Message-State: ALKqPwf/VZiueYUR/T55Be+L3P1AdA4lQGRJIXl2WWuqOdxMRE6ltMAl
        VpvQXqqyRnEgpRdtJgC3kgailQ==
X-Google-Smtp-Source: AB8JxZrW6EPQedUiDUBIFsOiGIfZhhqKm3hfaezYB8dK9qkej/4rLyWOwmvTggfI4R3A/aJs6hEE0g==
X-Received: by 2002:a17:902:4303:: with SMTP id i3-v6mr2355370pld.394.1525975906936;
        Thu, 10 May 2018 11:11:46 -0700 (PDT)
Received: from [192.168.198.163] (S0106586d8f70b109.vn.shawcable.net. [50.68.127.238])
        by smtp.gmail.com with ESMTPSA id u75-v6sm3178076pfd.92.2018.05.10.11.11.45
        for <git@vger.kernel.org>
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 May 2018 11:11:46 -0700 (PDT)
From:   Ken Cunningham <ken.cunningham.webuse@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: bug: SHA1 calculation on PPC machines when built with gcc older than 4.6
Date:   Thu, 10 May 2018 11:11:44 -0700
Message-Id: <418E3D80-FE0F-436B-B9D1-475E49C4D75D@gmail.com>
To:     git@vger.kernel.org
Mime-Version: 1.0 (Apple Message framework v1085)
X-Mailer: Apple Mail (2.1085)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some vintage Apple PPC machines build a non-funtional version of git as =
of git 13.1 when using the stock gcc compilers that are installed with =
the OS; the SHA1 calculations are faulty. This can be repaired with a =
simple patch (attached).


Stock vintage Apple PPC machines come with gcc-4.0 or gcc-4.2. On MacOS =
10.4 and earlier, or when not using Apple Common Crypto on 10.5, git =
uses the SHA1 calculation code from here =
<https://github.com/cr-marcstevens/sha1collisiondetection>. The code in =
<https://github.com/cr-marcstevens/sha1collisiondetection/blob/master/lib/=
sha1.c> tries to detect all systems that are BIG_ENDIAN, but the above =
noted systems fall through because they fail the tests.

It appears that the primary test:

#if defined(__BYTE_ORDER__) && defined(__ORDER_BIG_ENDIAN__)

only works as of gcc-4.6 and newer, so the code is built as =
LITTLE_ENDIAN on PPC with older gcc versions.


Issue report:

<https://github.com/cr-marcstevens/sha1collisiondetection/issues/40>


MacPorts bug report:

<https://trac.macports.org/ticket/54602>


The included patch to git fixes the issue on our testing.

Thanks for git!

Ken Cunningham




=3D=3D=3D=3D=3D

diff --git a/sha1dc/sha1.c b/sha1dc/sha1.c
index 25eded1..5faf5a5 100644
--- a/sha1dc/sha1.c
+++ b/sha1dc/sha1.c
@@ -92,6 +92,10 @@
  */
 #define SHA1DC_BIGENDIAN
=20
+#elif (defined(__APPLE__) && defined(__BIG_ENDIAN__) && =
!defined(SHA1DC_BIGENDIAN))
+/* older gcc compilers which are the default  on Apple PPC do not =
define __BYTE_ORDER__ */
+#define SHA1DC_BIGENDIAN
+
 /* Not under GCC-alike or glibc or *BSD or newlib or <processor =
whitelist> */
 #elif defined(SHA1DC_ON_INTEL_LIKE_PROCESSOR)
 /*

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


