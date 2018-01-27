Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0EEA51F404
	for <e@80x24.org>; Sat, 27 Jan 2018 13:08:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeA0NI3 (ORCPT <rfc822;e@80x24.org>);
        Sat, 27 Jan 2018 08:08:29 -0500
Received: from forward100p.mail.yandex.net ([77.88.28.100]:51126 "EHLO
        forward100p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751882AbeA0NI2 (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 27 Jan 2018 08:08:28 -0500
Received: from mxback10g.mail.yandex.net (mxback10g.mail.yandex.net [IPv6:2a02:6b8:0:1472:2741:0:8b7:171])
        by forward100p.mail.yandex.net (Yandex) with ESMTP id 3CFE2510225A;
        Sat, 27 Jan 2018 16:08:26 +0300 (MSK)
Received: from localhost (localhost [::1])
        by mxback10g.mail.yandex.net (nwsmtp/Yandex) with ESMTP id 7YdXt6eJVS-8PpiexCM;
        Sat, 27 Jan 2018 16:08:25 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail; t=1517058505;
        bh=M9Ydbl9miuzObbIJuk2m/aXemPP8Pug5Lul/aY3usn8=;
        h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date;
        b=Up8vgHSAPv+OpzO5RfvKh0/7iABviDqcoZz0xTrpYYSs4yJ4Nd3pWmX8fDR1Giisg
         tmZRzzWQczBk5HaMUd+ZqTxjrINPbLYKpbOJrBpbNQDji64o7b6kmT66VZCVQw9gQ/
         Jh4f4A600xDPA3W02Ro6whbVJzT930AfnUG5XB1k=
Authentication-Results: mxback10g.mail.yandex.net; dkim=pass header.i=@yandex.ru
Received: by web15o.yandex.ru with HTTP;
        Sat, 27 Jan 2018 16:08:25 +0300
From:   KES <kes-kes@yandex.ru>
Envelope-From: kes-kes@yandex.com
To:     Jacob Keller <jacob.keller@gmail.com>,
        Stefan Beller <sbeller@google.com>
Cc:     git <git@vger.kernel.org>
In-Reply-To: <446801516908691@web22j.yandex.ru>
References: <14657461479715884@web21h.yandex.ru> <CA+P7+xrKfqOb-3FhKxXdnF6g9PktNWNzY+ZnHJS=yuVo1YdXzg@mail.gmail.com>
         <CAGZ79kZbGPneUXVEqJYhQAn+dfYve7qCjhO7QFaV1JBs3HD1aA@mail.gmail.com> <CA+P7+xqMUPLC-aKW-fiS629_Owat8sCa5vp_bOwQTO8LP4hCzw@mail.gmail.com> <12531516812201@web36o.yandex.ru> <446801516908691@web22j.yandex.ru>
Subject: Re: Feature request: Improve diff algorithm
MIME-Version: 1.0
Message-Id: <1408921517058505@web15o.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date:   Sat, 27 Jan 2018 15:08:25 +0200
Content-Transfer-Encoding: 7bit
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

One yet more:

@@ -43,22 +44,25 @@ sub tariff_title {
 1;
 
 __DATA__
-@@ control/tariff.css
-* {
-    margin: 0;
-    padding: 0;
-    border: 0;
-    -webkit-box-sizing: border-box;
-    box-sizing: border-box; }
-html {
-    background-color: #121212;
-    color: white;
-    font-family: 'Roboto', 'Arial',  sans-serif;
-    font-size: 16px; }
-a {
-    cursor: pointer; }
 
 
+@@ control/tariff_about_old.html.ep
+<div class="option__about">
+  <div class="option__info">
+    <div class="option__icon"><img src="<%= $icon %>"></div>
+    <h3 class="option__name"><%= $title %></h3>
+  </div>
+  <div class="option__duration">
+    <p><%== $option1 %><%= stash->{ comment1 }? "<span> (" .stash->{ comment1 }.")</span>": '' %></
+    <div class="switch option__switch">
+      <input class="switch__toggle" type="checkbox" checked id="<%= $id %>">
+      <label for="<%= $id %>"></label>
+    </div>
+    <p><%== $option2 %><%= stash->{ comment2 }? "<span> (" .stash->{ comment2 }.")</span>": '' %></
+  </div>
+</div>
+
+@@ control/tariff.css
 /*  BASE BUTTON FOR TARIFF CARD  */
 .button {
   display: -webkit-box;

But it would be better if `@@ control/tariff.css` were untouched:

@@ -43,22 +44,25 @@ sub tariff_title {
 1;
 
 __DATA__
+
+
+@@ control/tariff_about_old.html.ep
+<div class="option__about">
+  <div class="option__info">
+    <div class="option__icon"><img src="<%= $icon %>"></div>
+    <h3 class="option__name"><%= $title %></h3>
+  </div>
+  <div class="option__duration">
+    <p><%== $option1 %><%= stash->{ comment1 }? "<span> (" .stash->{ comment1 }.")</span>": '' %></
+    <div class="switch option__switch">
+      <input class="switch__toggle" type="checkbox" checked id="<%= $id %>">
+      <label for="<%= $id %>"></label>
+    </div>
+    <p><%== $option2 %><%= stash->{ comment2 }? "<span> (" .stash->{ comment2 }.")</span>": '' %></
+  </div>
+</div>
+
 @@ control/tariff.css
-* {
-    margin: 0;
-    padding: 0;
-    border: 0;
-    -webkit-box-sizing: border-box;
-    box-sizing: border-box; }
-html {
-    background-color: #121212;
-    color: white;
-    font-family: 'Roboto', 'Arial',  sans-serif;
-    font-size: 16px; }
-a {
-    cursor: pointer; }
-
-
 /*  BASE BUTTON FOR TARIFF CARD  */
 .button {
   display: -webkit-box;

