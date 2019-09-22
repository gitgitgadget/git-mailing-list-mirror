Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8D17B1F463
	for <e@80x24.org>; Sun, 22 Sep 2019 11:59:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728789AbfIVL7y (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Sep 2019 07:59:54 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:37637 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728182AbfIVL7y (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Sep 2019 07:59:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id l21so11056886lje.4
        for <git@vger.kernel.org>; Sun, 22 Sep 2019 04:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=3ZI00nUxzlruKdLhtj+VzuoSZZA3wTnhpNvQEgnSySU=;
        b=BaaJPnaZVSCDO3Y0GpcoQnz+b6yNwavskLC9Nvs5gwAnNWi8oonWk+kJDMsIrEcuWP
         lsy6Qfo5duCI9omKAsB9rwHLmzNKPDLqyNHrqlUuF2faFAGOtEoalgQtLipNaeZ5ke7I
         1Gqu5qDFOrsmSg8ZFGzVK9tEwYWYA5puc27KtBNwei5qIQ9DdPUqouO+eOLoFw5G1n1v
         HUh9zVZJcRS0b/MKbSqfBqtr30ZPC6X/HXoHl8ZT6v774HD5R3PV0nZ2MP13eeTTDOXM
         xpwRDDDzFHbaPU7FRJlhwVmrQj5pUvAsbkH1foCjDtO+z5SCM4qZh+rcyP/wYkDw0HU1
         1bdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3ZI00nUxzlruKdLhtj+VzuoSZZA3wTnhpNvQEgnSySU=;
        b=l3rD0nr7R6IerDELpRZ6uYiVnh0v19DSoq0bO1NebQvW/FhWtV+R9INVfIdR+B3bU9
         DqTcjn53Q3eHTPIabRbURwvJ+poT4g3d11VmN3eqhKuVYjDp/yUe/bE21ejBgH/AGxUg
         nintXLEzOan/O/6nyXJBnw8chk0dVZDc3kmSFbcLaYid3sFuHmeHnC7cFX4HWCMYyctd
         PDXN6kBB+f8CnIGOxGyy2oWk4gDZJYSH8lN/vrHsTnQa+0Oh8Rd0d6jDLEJTLsBYi3DO
         nfTZEWJ2gqTK4iuqE2RzMLcXpLrWXDWHkz2bkXwn6QAPzEcHsp9Ty+1MrrpPtq8mUXai
         EEWQ==
X-Gm-Message-State: APjAAAXRK8bCLyghYQrUPYxmOCbsPjXh7oht1D/9QHk8GzWHTM2zbuX2
        O+faGE+uXfuDtDDgWTwK0g7MtYHN
X-Google-Smtp-Source: APXvYqyi/lg6VeKbwsxZMPxxhGas47uug6F+ASytSih7iGiyY6ziy2PwuNqsBy+jgqri2wxGJbwZDg==
X-Received: by 2002:a2e:3902:: with SMTP id g2mr14798244lja.196.1569153591955;
        Sun, 22 Sep 2019 04:59:51 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id q24sm1622413ljj.6.2019.09.22.04.58.45
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2019 04:59:51 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Subject: [PATCH 3/4] asciidoctor-extensions.rb: handle "book" doctype in linkgit
Date:   Sun, 22 Sep 2019 13:57:58 +0200
Message-Id: <78d131f31b760addf5d22d4f95f04eda9aa45927.1569152396.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1569152396.git.martin.agren@gmail.com>
References: <cover.1569152396.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

user-manual.txt is the only file we process using the "book" doctype.
When we use AsciiDoc, user-manual.conf ensures that the linkgit macro
expands into something like

  <ulink url="git-foo.html">git-foo(1)</ulink>

in user-manual.xml, which we then process into a clickable link, both in
user-manual.html and user-manual.pdf. With Asciidoctor,
user-manual.conf is ignored (this is expected) and our
Asciidoctor-specific implementation of linkgit kicks in:

  <citerefentry>
    <refentrytitle>git-foo</refentrytitle><manvolnum>1</manvolnum>
  </citerefentry>

This eventually renders as "git-foo(1)", which is not bad, but it
doesn't turn into a link.

Teach our Asciidoctor-specific implementation of the linkgit macro that
if the doctype is "book", we should emit <ulink .../> just like we do
with AsciiDoc. While we're doing this, future-proof by supporting a
"prefix". The implementation in user-manual.conf doesn't support this,
and we don't need this for now because user-manual.txt is the only file
we process this way (and it's immediately in Documentation/).

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/asciidoctor-extensions.rb | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/Documentation/asciidoctor-extensions.rb b/Documentation/asciidoctor-extensions.rb
index 0089e0cfb8..70a0956663 100644
--- a/Documentation/asciidoctor-extensions.rb
+++ b/Documentation/asciidoctor-extensions.rb
@@ -9,8 +9,11 @@ module Git
       named :chrome
 
       def process(parent, target, attrs)
-        if parent.document.basebackend? 'html'
-          prefix = parent.document.attr('git-relative-html-prefix')
+        prefix = parent.document.attr('git-relative-html-prefix')
+        if parent.document.doctype == 'book'
+          "<ulink url=\"#{prefix}#{target}.html\">" \
+          "#{target}(#{attrs[1]})</ulink>"
+        elsif parent.document.basebackend? 'html'
           %(<a href="#{prefix}#{target}.html">#{target}(#{attrs[1]})</a>)
         elsif parent.document.basebackend? 'docbook'
           "<citerefentry>\n" \
-- 
2.23.0

