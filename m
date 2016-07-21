Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 514DB203C2
	for <e@80x24.org>; Thu, 21 Jul 2016 14:54:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752981AbcGUOyo (ORCPT <rfc822;e@80x24.org>);
	Thu, 21 Jul 2016 10:54:44 -0400
Received: from mail-it0-f51.google.com ([209.85.214.51]:37226 "EHLO
	mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752531AbcGUOyk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jul 2016 10:54:40 -0400
Received: by mail-it0-f51.google.com with SMTP id f6so19965749ith.0
        for <git@vger.kernel.org>; Thu, 21 Jul 2016 07:54:40 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to;
        bh=+wsEd79nddcUffdDf06q9F2uZb8pHREEqNj5Qlbo6JI=;
        b=hfzC+d0Q2MY3c9weSM3ugwT/1wPAt4XkJ19WzGxEBQ9UQgTy6ILUfHgUWoDWlcVneZ
         jyr18hZGTB5vUPNQTWewdlPaHBCwPQuexGFX3v3HoYOCnUkFEmyOdSc4SS3sLu9408e0
         z/nbsAolOep+nakuGJz4HfREyIpDRGtJ3/vZeeavOF+wXhCsjkUtdnMBU2MIMsq7xu61
         i3Rs46Sh28cMKJuCLVIL0nJw+GUf9P3vA0LN6swagliv9jW1rbKjluvQbEeaNZ8wns5f
         GHdGHmikL3GY39aalB0Wn25r9NkphtmDA8JF3jojKKKVPAwQxmXozXm9qHP8pYuSEgQq
         sKmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=+wsEd79nddcUffdDf06q9F2uZb8pHREEqNj5Qlbo6JI=;
        b=BJFdGQk6eail7HQ+iSv2KZWtIRIKzbc2RC30b29BBsVZMJ2lE3qpMakqyhlKHyqyvk
         5LuqekzhryBIQO9FCMFC3mG3q+JyO4TlA3oNphYJmrdqZMGkt4mEeeeZBv05G0KWPM8T
         XcRXkYB/bia1b6wXLqFFu5IuksP0MYtUzF4YgHer6LfNPMoXbBIHpRsKGIqgqztrcERP
         R8eSjh2hx5368/B1ErgRTjQKYesR29C1JrK3UkoDF7zKE5+OP+bR1wrJ8zfvfhcMT1t2
         BqZAp0glLUjyUP4epH18xHmUHQypvrd0Emfmqu0GE4wkEx9VtokxL/UVJ5N8v+EXX9C6
         Reuw==
X-Gm-Message-State: ALyK8tK4sHC3JRVHMFz/VXhF2ivpf3G+YXi6hROHkDN46kkFWyeXMbcngUvAao5kE+Kcsju2MKG2vkiZbUEorA==
X-Received: by 10.36.98.8 with SMTP id d8mr15295298itc.39.1469112879915; Thu,
 21 Jul 2016 07:54:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.133.41 with HTTP; Thu, 21 Jul 2016 07:54:39 -0700 (PDT)
From:	Marcin Szarek <marcinshk@gmail.com>
Date:	Thu, 21 Jul 2016 16:54:39 +0200
Message-ID: <CAFLWV1WC5Kq5TW1WnwPpuJitHC05drHtzg989UWJ6-hMZ85q0Q@mail.gmail.com>
Subject: Git clone gets stuck - how to see the files being cloned at given moment?
To:	git@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Hi Everyone,

In one of the environments where I work, we experience a very strange
and so far unresolved problem: "git clone" operation gets stuck almost
always near 42% - 45%. For many days we have been unable to pinpoint
the root cause of the issue. Now we would like to see if the "clone"
gets stuck always on the same file.

The question is: is it possible to somehow enable Git verbosity
resulting in showing the names of files being cloned at the given
moment?

So far we have been trying "git clone --verbose" + the following
environmental variables:
GIT_TRACE=2 GIT_CURL_VERBOSE=2 GIT_TRACE_PERFORMANCE=2
GIT_TRACE_PACK_ACCESS=2 GIT_TRACE_PACKET=2 GIT_TRACE_PACKFILE=2
GIT_TRACE_SETUP=2 GIT_TRACE_SHALLOW=2

Unfortunately we don't see the files being cloned/downloaded. Is there
any way to see this information?

Thank you in advance for any hints, I really appreciate your help.

P.S.
The version of Git client on our hosts is 1.8.3.1, however we tried
other versions as well and the problem still occurs.

Best regards,

--
marcinshk
