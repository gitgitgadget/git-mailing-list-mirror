Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81C031F405
	for <e@80x24.org>; Thu,  9 Aug 2018 18:40:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbeHIVGi (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 17:06:38 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:51140 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727129AbeHIVGi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 17:06:38 -0400
Received: by mail-wm0-f65.google.com with SMTP id s12-v6so1208578wmc.0
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 11:40:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=4SnHP3jeGOpXVqL/MXuXQfPmUeO6brBlDUgms3vvnLY=;
        b=b0TikGxNsInrmQWXAV0xUArnqpQM9wTsAt8vU+X/RFiMc3ComYgcEZq9jYA2O5AVCM
         QIoYyksy+lBoV2ZTsB1vNC2SbT99P0xd2kZvT7GNqrIQmmfeh5IAyPkZ/sKfDxZxhZaV
         HfIhnIAtaYWOnXYSZB31/bVhqjzpzIukcIUF3aGwSsYvOUm1Dv3akRRaFB5YliGCGO2m
         6g9OWvdp3WljtiLijGsrNyG4X663qWzM3O84dZREdt3yjlsHuvqe6icFUj94tZl2kZ5w
         HdB9iCmBzsPq/EA3wF8Q+UTWameG5Hy/JDYi+haFl/QkVmLmklHpeF8g7TevWTn+WvCf
         QusA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=4SnHP3jeGOpXVqL/MXuXQfPmUeO6brBlDUgms3vvnLY=;
        b=sPdR7VKHS0toyeyUnwZ6ZYVitV791pDrGIgsO6d32ODlZZzAelLfCPqKPn3/Locx6i
         hchAkwFV5s7v/jPxu1OEbKnFi2UkQ2LXEoiEASx2vlyR3HUKDZmWv34QwcIT8XeMkNam
         FWCWEHCAUKaj6MQ6GMWEJGnOSqZpRijk9KEtGnK1xCYsq9aDplX+ha52Mi6vIAHzWBry
         ZlOlgcxiYNEsnGNlaqEjHSk2m3toR1dkmLcl5eDmL8urEHST+FgC2QiwIs7qsowl/XQg
         WxSR5QAF6WUii0HDe6nFHxFjlqeWTC5Wgfq425i2LVqcWYnGff+y0xBbi7tSXapI2m7w
         PTxg==
X-Gm-Message-State: AOUpUlETgwJQtJXiEgPav1N97U25lBRZd9c/WqmhV9RpVVmZLn7Ik6su
        ukdjojwrPHqAoL9xhAxtX6w=
X-Google-Smtp-Source: AA+uWPxTtZOKCUDBYW5kevdyHfVXFxYstRLeWIKDrXESRZdegcR7QMUpb9vz2vIwlKPCz8WmlC5pKw==
X-Received: by 2002:a1c:9945:: with SMTP id b66-v6mr2279125wme.159.1533840029566;
        Thu, 09 Aug 2018 11:40:29 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id w185-v6sm12801523wmw.6.2018.08.09.11.40.28
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 09 Aug 2018 11:40:28 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Karel =?utf-8?B?S2/EjcOt?= <karel.koci@nic.cz>,
        Santiago Torres <santiago@nyu.edu>,
        Vojtech Myslivec <vojtech.myslivec@nic.cz>, git@vger.kernel.org
Subject: Re: [PATCH 1/1] verify-tag/verify-commit should exit unsuccessfully when signature is not trusted
References: <20180803133630.32oxubwttealvhxk@work-pc>
        <20180803154343.z3lgkudleood6lhs@LykOS.localdomain>
        <20180803160634.GA19944@sigill.intra.peff.net>
        <20180804084346.fhte5wusbfb5baem@cynerd-laptop>
        <20180808230456.GA21882@sigill.intra.peff.net>
        <20180808231226.GA34639@genre.crustytoothpaste.net>
        <xmqqzhxwcq2o.fsf@gitster-ct.c.googlers.com>
        <20180809014302.GB34639@genre.crustytoothpaste.net>
        <20180809143010.GD1439@sigill.intra.peff.net>
        <xmqqtvo3d0by.fsf@gitster-ct.c.googlers.com>
        <20180809171219.GF1439@sigill.intra.peff.net>
Date:   Thu, 09 Aug 2018 11:40:27 -0700
In-Reply-To: <20180809171219.GF1439@sigill.intra.peff.net> (Jeff King's
        message of "Thu, 9 Aug 2018 13:12:19 -0400")
Message-ID: <xmqqy3dfbcys.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> I guess leaving it serves as a sort of cross-check if gpg would return a
> zero exit code but indicate in the status result that the signature was
> not good. Sort of a belt-and-suspenders, I guess (which might not be
> that implausible if we think about somebody wrapping gpg with a sloppy
> bit of shell code that loses the exit code -- it's their fault, but it
> might be nice for us to err on the conservative side).

OK, this time a real log message.

-- >8 --
Subject: [PATCH] gpg-interface: propagate exit status from gpg back to the callers

When gpg-interface API unified support for signature verification
codepaths for signed tags and signed commits in mid 2015 at around
v2.6.0-rc0~114, we accidentally loosened the GPG signature
verification.

Before that change, signed commits were verified by looking for
"G"ood signature from GPG, while ignoring the exit status of "gpg
--verify" process, while signed tags were verified by simply passing
the exit status of "gpg --verify" through.  The unified code we
currently have ignores the exit status of "gpg --verify" and returns
successful verification when the signature matches an unexpired key
regardless of the trust placed on the key (i.e. in addition to "G"ood
ones, we accept "U"ntrusted ones).

Make these commands signal failure with their exit status when
underlying "gpg --verify" (or the custom command specified by
"gpg.program" configuration variable) does so.  This essentially
changes their behaviour in a backward incompatible way to reject
signatures that have been made with untrusted keys even if they
correctly verify, as that is how "gpg --verify" behaves.

Note that the code still overrides a zero exit status obtained from
"gpg" (or gpg.program) if the output does not say the signature is
good or computes correctly but made with untrusted keys, to catch
a poorly written wrapper around "gpg" the user may give us.

We could exclude "U"ntrusted support from this fallback code, but
that would be making two backward incompatible changes in a single
commit, so let's avoid that for now.  A follow-up change could do so
if desired.

Helped-by: Vojtech Myslivec <vojtech.myslivec@nic.cz>
Helped-by: brian m. carlson <sandals@crustytoothpaste.net>
Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 gpg-interface.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 0647bd6348..b5e64c55e2 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -81,12 +81,13 @@ int check_signature(const char *payload, size_t plen, const char *signature,
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
-- 
2.18.0-547-g1d89318c48

