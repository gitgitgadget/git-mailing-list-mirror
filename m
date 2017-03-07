Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 305EF1FBEC
	for <e@80x24.org>; Tue,  7 Mar 2017 19:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756134AbdCGTp6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 Mar 2017 14:45:58 -0500
Received: from mail-io0-f177.google.com ([209.85.223.177]:33801 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755838AbdCGTp5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Mar 2017 14:45:57 -0500
Received: by mail-io0-f177.google.com with SMTP id g6so13010637ioj.1
        for <git@vger.kernel.org>; Tue, 07 Mar 2017 11:44:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=wDoHI1Ixe3+mcNocCeisU09oZM/QjufLXXayuANE0sc=;
        b=IKeLyQFbaNAgMpQrWL74MdXQRzBMo6RdcIXnKNLqVN6LsKPSriVDFAzCoXryhkVh41
         BUiuIePtUkn2WGT8/742CsbK/mWa1K0VfqvZGfEYUdN4RkyFk7FTt0WKwZg50ongdGuW
         oqmNtSkMOWPmvWNrK1KES+gtYZb9GpC8ZngWqBaPbol1JB+GZXR/39nkBYWQ+vbNcfYa
         9WegZTyy83bSErgHUrQNDdNTrvtol2kDRlQzBY7AXIdz8hSk9d7uDYvH/3SuXfMJ07l7
         vcvjQ18lW0gNW7OR0A+7p6FxEbTWY6pXya6CI1t/6uBANr6b2nYd/pOOYpjMRiIME+/A
         Rx9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=wDoHI1Ixe3+mcNocCeisU09oZM/QjufLXXayuANE0sc=;
        b=JCviZJuD+N89/d5WHO0uBq2OSiiF3WKaFerukGgZsaIcrlC/3gn9w1puEBW0h0E85x
         /e0qivM0BSXneDw8aS98nJP12l5QglmfglaAap/Fp8tYGPurSRL3Ok4L8PLvOY47Xalm
         Rc2rHz1tzJI0UNRc5f6Ee0CWb5KX5gA2c65ooi19MWGmYav8hJNRLJY9JY/cS6dZbOuA
         wWkMD4nrD0BB56cf0WKO147Uf+Hqbc9KxtamjLCkanZISN01DkGDUKtI2zoc0beU05za
         B9jVxVKfqP9mwlhOqRfs416Nf3lgPH3DDPoRVRtWSc2JgNk9OKwD/VrzU9URINhdDhS3
         FuhA==
X-Gm-Message-State: AMke39k4C0Ua8stkx/JE/+t/n7hvl3KGbteuqOBDXgWqmFQpwOupYvAGh9phH6Kj3gw4uqmJSekp/+6c2NC4wg==
X-Received: by 10.107.8.39 with SMTP id 39mr2375381ioi.189.1488914135440; Tue,
 07 Mar 2017 11:15:35 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.136.102 with HTTP; Tue, 7 Mar 2017 11:15:34 -0800 (PST)
In-Reply-To: <22719.680.730866.781688@chiark.greenend.org.uk>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <22719.680.730866.781688@chiark.greenend.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 7 Mar 2017 11:15:34 -0800
X-Google-Sender-Auth: F0EjWyPtG-JGRzEhdq_GM1N0H94
Message-ID: <CA+55aFyyi0vBBApf9grYQzF2PRZMjtCzkB4LzYvLpqQ-Z7QfJQ@mail.gmail.com>
Subject: Re: RFC: Another proposed hash function transition plan
To:     Ian Jackson <ijackson@chiark.greenend.org.uk>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, bmwill@google.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 7, 2017 at 10:57 AM, Ian Jackson
<ijackson@chiark.greenend.org.uk> wrote:
>
> Also I think you need to specify how abbreviated object names are
> interpreted.

One option might be to not use hex for the new hash, but base64 encoding.

That would make the full size ASCII hash encoding length roughly
similar (43 base64 characters rather than 40), which would offset some
of the new costs (longer filenames in the loose format, for example).

Also, since 256 isn't evenly divisible by 6, and because you'd want
some way to explictly disambiguate the new hashes, the rule *could* be
that the ASCII representation of a new hash is the base64 encoding of
the 258-bit value that has "10" prepended to it as padding.

That way the first character of the hash would be guaranteed to not be
a hex digit, because it would be in the range [g-v] (indexes 32..47).

Of course, the downside is that base64 encoded hashes can also end up
looking very much like real words, and now case would matter too.

The "use base64 with a "10" two-bit padding prepended" also means that
the natural loose format radix format would remain the first 2
characters of the hash, but due to the first character containing the
padding, it would be a fan-out of 2**10 rather than 2**12.

Of course, having written that, I now realize how it would cause
problems for the usual shit-for-brains case-insensitive filesystems.
So I guess base64 encoding doesn't work well for that reason.

                Linus
