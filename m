Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 71C4E20248
	for <e@80x24.org>; Wed, 10 Apr 2019 03:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727201AbfDJDsn (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Apr 2019 23:48:43 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:38492 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726670AbfDJDsn (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Apr 2019 23:48:43 -0400
Received: by mail-wm1-f66.google.com with SMTP id w15so901730wmc.3
        for <git@vger.kernel.org>; Tue, 09 Apr 2019 20:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=7bLaFN/YwYAztRottgeLZNCSu4jWT/SQG1gNVNl/rnY=;
        b=lmHfMrVrypoEJftr6S/qNlp5XBLix4aH/wu/Fbvsd/gGGNbD6HNgD/8FvRoVypXKHU
         O/bTLDnp2ci+QfVT/FJ8GY/HAsftWn/t29B4pwoFdJee8f851ZkhW2Gl9+hHZWikQClN
         9hBXJ5Eq2FlQ0ZgNY/cNwATz69iDeO+OomSyZl4JGgdXr1UMX0ZX8NDhpfW0auFlp32e
         17RJQzB5iBdST7X61oVKPDz/qAMJlnMtVO3jIvdFhzGmfUmzYTC+8Rs46G9T+b775hy/
         2N/Mc8dYDISlt+4/+AycQXYgQJLh4+HDJ3dmH+n/XMowPx3p+WE0JwzpZKMQBFsNdhJ5
         LteA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=7bLaFN/YwYAztRottgeLZNCSu4jWT/SQG1gNVNl/rnY=;
        b=SLs1u0GYxKKtLuP0G2nu7wLz+OJ4iHcJN88O1Rw6R436+P8RP7Eov9oWfc8kT+vyrG
         SA4TK37NGtfPp+dQqp9cVKZldQwbi4oEPPlt11B1L9lESctXJ4NQZUla4Hmq6C2ls9Dr
         MJEV0hPXQ/W8hZISZ6XwsOopjP3CW3uP2FkLVwsHHx6LkWVHisK+3qpLOPNrHqtKeDZk
         nfyosH0/iDbysBxQc9kc01D65IWzXhgHek6xW16NlkI09nM03OcSknchEhJYG2gAJ0aj
         +tyNjri8ICjQwHrsq7wHB+WdJksKsd0mcO4LD/tzVNVj0qmLmPeDKzWkA0+EBbh4a6A6
         WRRQ==
X-Gm-Message-State: APjAAAXYoVS6lamm1vJXAvqQbt0w/wdSaCHvI0NjS4YqPkrI8wcQw8d9
        s+EAW+/woSUhO/OQ0wPgZiA=
X-Google-Smtp-Source: APXvYqyCnpbB9GvDrbUkRzdamSVvJvKH7DOiKruXEWF6yovH67LFyj5ReOBHW+0ZBAKKRKCYjghLfw==
X-Received: by 2002:a1c:f115:: with SMTP id p21mr999256wmh.93.1554868120464;
        Tue, 09 Apr 2019 20:48:40 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id b9sm1248271wmc.9.2019.04.09.20.48.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 09 Apr 2019 20:48:38 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Brian M Carlson <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/1] send-email: fix transferencoding config option
References: <20190409192733.10173-1-xypron.glpk@gmx.de>
        <20190409215856.GD92879@google.com>
Date:   Wed, 10 Apr 2019 12:48:38 +0900
In-Reply-To: <20190409215856.GD92879@google.com> (Jonathan Nieder's message of
        "Tue, 9 Apr 2019 14:58:56 -0700")
Message-ID: <xmqq8swi34h5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

> nit: I was confused when first reading this, since I read "the
> configuration $target_xfer_encoding" as a single phrase.  A comma
> after "configuration" might help.
> ...
> run-on sentence.  I'm having trouble parsing this part.

I had the same issue with the wording.  Without addressing other
parts of the suggestions in the thread (like describing the
motivating use case, and protecting this with the test), here is
what I have tentatively queued.

As all the $scalar variables that are referenced by %config_settings
etc. all potentially share this issue, I wonder if it makes sense to
have a validation at the very beginning of the read_config sub,
something along the lines of....

	sub read_config {
		my ($prefix) = @_;

		while (my ($k, $v) = each %config_bool_settings) {
                	if (defined $$v) {
				die "BUG: \%config_bool_settings{$k} is not undef\n";
			}
		}
		... similarly for %config_path_settings and %config_settings ...

		... then the original code ...
		foreach my $setting (keys %config_bool_settings) {
			...
	}

By the way, if we look more closely to the two callsites of
read_config(), however, we realize that Heinrich's patch is a wrong
solution to the problem.

What happens when "sendemail.<ident>.xferencoding" is not set, but
"sendemail.xferencoding" is, with the updated code?  The "ah, the
configuration file did not define the xfer-encoding, so let's set it
to auto" at the end of read_config is done still too early.  After
checking "sendemail.<ident>.*", the code added by the patch under
review assigns 'auto' to $target_xfer_encoding and this assignment
causes "sendemail.xferencoding" to be ignored, just like BMC's bug.

In other words, the patch is reproducing the same bug it is
attempting to fix; a quick-and-dirty and obvious band-aid is to move
the assignment of 'auto' further down, outside the read_config()
sub, after two calls to the sub is made by the caller, but singling
this single variable out is very unsatisfactory.

I wonder if we can follow the pattern used by the code to handle the
fallback for %config_bool_settings we can see immediately after
these two calls to read_config()?  That is, each of the element in
the %config_* hash is not merely a pointer to where the value is
stored, but also knows what the default fallback value should be,
and a loop _in the caller of_ read_config(), after it finishes
making calls to the read_config function, fills in the missing
default?

-- >8 --
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
Date: Tue, 9 Apr 2019 21:27:33 +0200
Subject: [PATCH] send-email: honor transferencoding config option again

Since e67a228cd8a ("send-email: automatically determine
transfer-encoding"), the value of sendmail.transferencoding in the
configuration file is ignored, because $target_xfer_encoding is
already defined read_config sub parses the configuration file.

Instead of initializing variable $target_xfer_encoding to 'auto' on
definition, we have to set it to the default value of 'auto' if is
undefined after parsing the configuration files.

Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-send-email.perl | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/git-send-email.perl b/git-send-email.perl
index f4c07908d2..db32cddbde 100755
--- a/git-send-email.perl
+++ b/git-send-email.perl
@@ -231,7 +231,7 @@ sub do_edit {
 my (@suppress_cc);
 my ($auto_8bit_encoding);
 my ($compose_encoding);
-my $target_xfer_encoding = 'auto';
+my ($target_xfer_encoding);
 
 my ($debug_net_smtp) = 0;		# Net::SMTP, see send_message()
 
@@ -434,6 +434,8 @@ sub read_config {
 			$smtp_encryption = 'ssl';
 		}
 	}
+
+	$target_xfer_encoding = 'auto' unless (defined $target_xfer_encoding);
 }
 
 # read configuration from [sendemail "$identity"], fall back on [sendemail]
-- 
2.21.0-313-ge35b8cb8e2



