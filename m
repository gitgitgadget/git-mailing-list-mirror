Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AA5C5202F2
	for <e@80x24.org>; Thu, 23 Nov 2017 15:19:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752923AbdKWPTD (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Nov 2017 10:19:03 -0500
Received: from mail-wm0-f53.google.com ([74.125.82.53]:38852 "EHLO
        mail-wm0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752611AbdKWPTC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Nov 2017 10:19:02 -0500
Received: by mail-wm0-f53.google.com with SMTP id 128so17229703wmo.3
        for <git@vger.kernel.org>; Thu, 23 Nov 2017 07:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:content-transfer-encoding:subject:date:message-id:cc:to
         :mime-version;
        bh=SSi8QJbVMF7yoTkqfgws3NnZi0l67iV2yLVQ9iq6dq8=;
        b=U9rg7hyOwyFu8ij7gJefj/wqdvbMTIxs0ZCoKuaH6cd9uEmW7WXAVVT3IuJSFZBpl7
         3DgSOWCE0+AsCcjpXkRqYxxniI6iDzYD3uyz80AW4vZS2FqEMUUaxZkiC7o03nR8a9PR
         760Kjm2IJ4zw4dscZ97HhufWtIYBxBG8qj8HJPkT4ljcC04Ca3XKMFxLucvyAu4rYC3Z
         k9vDU+Z0is9JYflV+U71tIRxGkhm3kjBoEobLqGiPUE225dwGih8Fa/mnRsqSlAoPszf
         KQx1tiFpMS3sM9M9N/0PO1X96smcLcAo6JCYzl4pri5UrSpzakogCqa5jl3QbwhL0jt8
         WhFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:subject:date
         :message-id:cc:to:mime-version;
        bh=SSi8QJbVMF7yoTkqfgws3NnZi0l67iV2yLVQ9iq6dq8=;
        b=PPqSmaSMjgDOD6embDi/7b0yisR3NBJZMfYt8ZkuxqoGbNacOHQApRZw5T0cHcZL24
         DL7U0nkgo050AAfWBmO7zJ5ZonCz0pjJiTXiIFvnzRl1YiEC79g3z5/XJ7jHg/gsBcD5
         IyPL3TPwScP33KUtMxnLpn/adOkDs4DFLSdOvOvjg4khr/wi1/qRF/huIalP8E1EUu2R
         LIW0eGkEjrkkE4wAw9hqI4XSH2e18YQxa6boGzka/hwYXdVeEsR21svr0+xwRpau5GbR
         8XnAELhRsyVq1oW8SsTuW5J1JW/xd3fAhunm9HOUBCrfMJABa/6ijanKf1Hvywh3czBK
         f7Cg==
X-Gm-Message-State: AJaThX6uBjw2ep9/q+oCyZzFoFzcwWs5F/Nq0vl3L3oFHWuNpl9di9Dv
        0zf12vA0cxcjclGFPmmpLE8Eentq
X-Google-Smtp-Source: AGs4zMYCgPXAtPZT0s8jRmZg21Z/kqN6w1ag0yZuua/xx5mYFWUXyX5UbOE45zViyXNEVDfcpbqnVQ==
X-Received: by 10.28.149.144 with SMTP id x138mr6973105wmd.49.1511450341357;
        Thu, 23 Nov 2017 07:19:01 -0800 (PST)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w21sm5138788wra.30.2017.11.23.07.19.00
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Nov 2017 07:19:00 -0800 (PST)
From:   Lars Schneider <larsxschneider@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Subject: RFC: Native clean/smudge filter for UTF-16 files
Date:   Thu, 23 Nov 2017 16:18:59 +0100
Message-Id: <BDB9B884-6D17-4BE3-A83C-F67E2AFA2B46@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Shawn Pearce <spearce@spearce.org>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jakub Narebski <jnareb@gmail.com>, Jeff King <peff@peff.net>
To:     Git List <git@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I am working with a team that owns a repository with lots of UTF-16 =
files.
Converting these files to UTF-8 is no good option as downstream =
applications
require the UTF-16 encoding. Keeping the files in UTF-16 is no good =
option
either as Git and Git related tools (e.g. GitHub) consider the files =
binary
and consequently do not render diffs.

The obvious solution is to setup a clean/smudge filter like this [1]:
    [filter "winutf16"]
        clean =3D iconv -f utf-16 -t utf-8
        smudge =3D iconv -f utf-8 -t utf-16

In general this works well but the "per-file" clean/smudge process =
invocation=20
can be slow for many files. I could apply the same trick that we used =
for Git
LFS and write a iconv that processes all files with a single invocation =
(see
"edcc85814c convert: add filter.<driver>.process option" [2]).=20

Alternatively, I could add a native attribute to Git that translates =
UTF-16=20
to UTF-8 and back. A conversion function is already available in =
"mingw.h" [3]
on Windows. Limiting this feature to Windows wouldn't be a problem from =
my
point of view as UTF-16 is only relevant on Windows anyways. The =
attribute=20
could look like this:

    *.txt        text encoding=3Dutf-16

There was a previous discussion on the topic and Jonathan already =
suggested
a "native" clean/smudge filter in 2010 [4]. Also the "encoding" =
attribute
is already present but, as far as I can tell, is only used by the git =
gui
for viewing [5].

Do you think a patch that converts UTF-16 files to UTF-8 via an =
attribute
"encoding=3Dutf-16" on Windows would have a chance to get accepted?

Thanks,
Lars

[1] https://github.com/msysgit/msysgit/issues/113#issue-13142846
[2] =
https://github.com/git/git/commit/edcc85814c87ebd7f3b1b7d3979fac3dfb84d308=

[3] =
https://github.com/git/git/blob/14c63a9dc093d6738454f6369a4f5663ca732cf7/c=
ompat/mingw.h#L501-L533
[4] https://public-inbox.org/git/20101022195331.GA12014@burratino/
[5] =
https://github.com/git/git/commit/1ffca60f0b0395e1e593e64d66e7ed3c47d8517e=
