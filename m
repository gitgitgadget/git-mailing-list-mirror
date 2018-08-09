Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4858D1F405
	for <e@80x24.org>; Thu,  9 Aug 2018 15:30:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732328AbeHIRzy (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 13:55:54 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:43806 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730803AbeHIRzy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 13:55:54 -0400
Received: by mail-wr1-f66.google.com with SMTP id b15-v6so5494352wrv.10
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 08:30:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GoZ/p7o9myeCVGhiX0tCiDC8sooY2XJkviC8MVZAvPY=;
        b=SN7JvzL0NiQl+dGpw46KIH7k2VWnx6XgqsTZ33X/0NcVC5t1yDizplc2BnlQQjbA/u
         t58RuPhW6Erdj0JH4n+BNqG+QBXo17Sz6uTUQzJnBGrG+lGf32gSbbO6GO5bQYf0sBmm
         Im+o8JZ1y4AdoVSCDrbuxIASKUM2oG4zCVh1mPdiP+g1/inua8k1PnJbbfpLbhwGW99Z
         WY71GznrDbFmnWOW3LX8TQQNAfUiTGKFUAa4qmzeL4L7CVlZer3bqt/lQpdMnRQ+cnYg
         n/FECdDK71W87zsIkwI2GKfA2OjS6Wbqdd5PsI+Ttkqvc2q7dEwaSgDOSF4opFRDjcRd
         IzRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GoZ/p7o9myeCVGhiX0tCiDC8sooY2XJkviC8MVZAvPY=;
        b=VBlhNvL7PsK5xd/N8ZMOGCQ25THLRVGJc0ECxlkRJvSO6b4qRfyW/p9jE5rKiurTXT
         KBn3YDxWEUgVkBeI3c9cZJEpfTrGY4YmqvitxYj6N1KHYTg6lH4sTqJ9UVOB02iTkX/7
         8ykGOJQIvw4qLkywWjwp5Hmp/QjShMFZ2SDa/rhdWwjUwsl+axDtoehVy7M8STnmO4yy
         s8sw/6wpaqHDx4D5zhGlv8AbzWG7XU+9ExjkgJ3Te6eQVX5MfMPxmCt7o2XY77/1wNtT
         zmB3CabT/oXz7lQQBfKrKxTUcO9Fgz2GwPviBN4fo0tOxt0sN7AzbYf3CgCjvk8qQ30o
         AvKA==
X-Gm-Message-State: AOUpUlFj5TEhWtBpD+CVsMtFolDSDvZR/2Wu15v43SkqWenIKEAr1IaE
        JyD9bxclBvlqFlbBpIoEENAi280x
X-Google-Smtp-Source: AA+uWPxHS9c99EQ4fTEjB0jMCZV/rGJ9P1ao+nTnY4lVg7aW3f15fHw+eKKHDxqJvRn1iVxcxxKt4g==
X-Received: by 2002:adf:d1cf:: with SMTP id m15-v6mr1917389wri.138.1533828627739;
        Thu, 09 Aug 2018 08:30:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id b10-v6sm5285341wrr.88.2018.08.09.08.30.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 08:30:25 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>,
        Santiago Torres <santiago@nyu.edu>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully when signature is not trusted
References: <20180801001942.GC45452@genre.crustytoothpaste.net>
        <20180801002546.du52zkxjupzcw2p6@LykOS.localdomain>
        <20180803133630.32oxubwttealvhxk@work-pc>
        <20180803154343.z3lgkudleood6lhs@LykOS.localdomain>
        <20180803160634.GA19944@sigill.intra.peff.net>
        <20180804084346.fhte5wusbfb5baem@cynerd-laptop>
        <20180808230456.GA21882@sigill.intra.peff.net>
        <20180808231226.GA34639@genre.crustytoothpaste.net>
        <xmqqzhxwcq2o.fsf@gitster-ct.c.googlers.com>
        <20180809014302.GB34639@genre.crustytoothpaste.net>
        <20180809143010.GD1439@sigill.intra.peff.net>
Date:   Thu, 09 Aug 2018 08:30:25 -0700
In-Reply-To: <20180809143010.GD1439@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 9 Aug 2018 10:30:10 -0400")
Message-ID: <xmqqtvo3d0by.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> There was a patch at the start of this thread, but it specifically
> checks for "sigc->result == U".  That's probably OK, since I think it
> restores the behavior in earlier versions of Git. But I wonder if we
> should simply be storing the fact that gpg exited non-zero and relaying
> that. That would fix this problem and truly make the rule "if gpg
> reported an error, we propagate that".

Yeah, I like that.  Something like this, perhaps?  Points to note:

 * status gets the return value from verify_signed_buffer(), which
   essentially is what wait_or_whine() gives us for the "gpg
   --verify" process.

 * Even if status says "failed", we still need to parse the output
   to set sigc->result.  We used to use sigc->result as the sole
   source of our return value, but now we turn 'status' into 'bad'
   (i.e. non-zero) after parsing and finding it is not mechanically
   good (which is the same criteria as we have always used before).
   An already bad status is left as bad.

 * And we return 'status'.

If we choose to blindly trust the exit status of "gpg --verify" and
not interpret the result ourselves, we can lose the "smudge status
to be bad if not G/U" bit, which I offhand do not think makes much
difference either way.  I just left it there because showing what
can be removed and saying it can be dropped is easier than showing
the result of removal and saying it can be added--simply because I
need to describe "it" if I go the latter route.

 gpg-interface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 09ddfbc267..2e0885c511 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -67,26 +67,27 @@ static void parse_gpg_output(struct signature_check *sigc)
 int check_signature(const char *payload, size_t plen, const char *signature,
 	size_t slen, struct signature_check *sigc)
 {
 	struct strbuf gpg_output = STRBUF_INIT;
 	struct strbuf gpg_status = STRBUF_INIT;
 	int status;
 
 	sigc->result = 'N';
 
 	status = verify_signed_buffer(payload, plen, signature, slen,
 				      &gpg_output, &gpg_status);
 	if (status && !gpg_output.len)
 		goto out;
 	sigc->payload = xmemdupz(payload, plen);
 	sigc->gpg_output = strbuf_detach(&gpg_output, NULL);
 	sigc->gpg_status = strbuf_detach(&gpg_status, NULL);
 	parse_gpg_output(sigc);
+	status |= sigc->result != 'G' && sigc->result != 'U';
 
  out:
 	strbuf_release(&gpg_status);
 	strbuf_release(&gpg_output);
 
-	return sigc->result != 'G' && sigc->result != 'U';
+	return !!status;
 }
 
 void print_signature_buffer(const struct signature_check *sigc, unsigned flags)
