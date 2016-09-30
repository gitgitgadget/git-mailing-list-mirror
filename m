Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 14942207EC
	for <e@80x24.org>; Fri, 30 Sep 2016 05:51:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964779AbcI3Fvn (ORCPT <rfc822;e@80x24.org>);
        Fri, 30 Sep 2016 01:51:43 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:36014 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934368AbcI3Fvl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2016 01:51:41 -0400
Received: by mail-yw0-f194.google.com with SMTP id r132so144040ywg.3
        for <git@vger.kernel.org>; Thu, 29 Sep 2016 22:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7djhP8vmEVGkxC0v4M/LAUjY98noWFOBLtN8OaMTisc=;
        b=WaeobyMF1o4JeurGNnI8BXUIWyhM1GGoGqMMwlLLWZrS2sBDejwX1qIl6m5F6NY0AH
         H7Uzn5FI3+FcYlv0iqI/AIRXg57jpEhrrK7R6A2clDqbEb6Np+oXoNVuZLhbFR1J1PhU
         dGLfcaFdBsszZt9CqyE1PvAQq3uQpMqHpI2r6G+TCEQvkvDZSxtlvwACLhoVY5PiQIt3
         y5/01Zj+FwlfX5QGeDKNvJPbuXH9RVqRPPSqqU7ZN1wcnsw+YvOHrx/h8NZjG2MGYDC+
         GUCzVPG8cXVTDxIjptTc6Pg1zK/B6WLRTY1OU+uNOzf4lOEe18whjEwDPJor+1NtvhAy
         SpjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7djhP8vmEVGkxC0v4M/LAUjY98noWFOBLtN8OaMTisc=;
        b=DHFw3hAxvPj5aKQ9hGkPwg1fsQClcSQeohFpdqYOF1SOddWVWBH19HCf3TDjqWn+p0
         iyrB4ZLVMmIINgGNxAd/3nxY8pjEHtRig+pbMmWJwcewgwSbrkSHZf3GPz9/+8jrk1Pm
         acXhSmvMVQZ91dxHLA1p2QdiCmwXXNPx3xZoScldgL3aC/tPbvQg7gy/VlUzW1Q4r9oQ
         goW3xgc0IQzIfFAb0NK4CpkxJ+/YDaKz4oQ15E7N4LqlNifApckNw3EcZ7t3Tea0akpG
         mpHaeqfzN7LBKmrk73VfLd5B9sQoXuPz1zPqtwoTkQ7xmpz7SsDBwiIQeEz054CQ1C0S
         +Mkw==
X-Gm-Message-State: AA6/9RkybRTgMsXzowTEqOXBYcQI4lT8Rl0th6xfX+rFGViBpvxkvCbyvL8uWfYkfxxRlrTqZJjdX4VsQ6ov5g==
X-Received: by 10.129.76.6 with SMTP id z6mr3527214ywa.257.1475214701030; Thu,
 29 Sep 2016 22:51:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.37.96.195 with HTTP; Thu, 29 Sep 2016 22:51:20 -0700 (PDT)
In-Reply-To: <xmqqbmz6hbdk.fsf@gitster.mtv.corp.google.com>
References: <20160926115720.p2yb22lcq37gboon@sigill.intra.peff.net>
 <20160926120036.mqs435a36njeihq6@sigill.intra.peff.net> <2242637D-4C3B-4AF2-8BE4-823B3E1745D5@gmail.com>
 <20160929130322.562ng4t2ktk6qzok@sigill.intra.peff.net> <xmqqbmz6hbdk.fsf@gitster.mtv.corp.google.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Thu, 29 Sep 2016 22:51:20 -0700
Message-ID: <CA+P7+xr4ZNCCJkS0=yR-FNu+MrL60YX-+Wsz9L_5LCNhnY_d=A@mail.gmail.com>
Subject: Re: [PATCH 10/10] get_short_sha1: list ambiguous objects on error
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, "Kyle J. McKay" <mackyle@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 29, 2016 at 10:19 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Jeff King <peff@peff.net> writes:
>>   - "cat-file --batch-check" can show you the sha1 and type, but it
>>     won't abbreviate sha1s, and it won't show you commit/tag information
>>
>>   - "log --stdin --no-walk" will format the commit however you like, but
>>     skips the trees and blobs entirely, and the tag can only be seen via
>>     "%d"
>>
>>   - "for-each-ref" has flexible formatting, too, but wants to format
>>     refs, not objects (and doesn't read from stdin).
>
>     - "name-rev" is used to give "describe --contains", and can read
>       from its standard input, but has no format customization.
>       Another downside of it is that it only wants to see
>       committishes.
>

Some tool which reads standard input and can be formatted would be
nice. Extending name-rev with the same format options as for-each-ref
would be nice.

Thanks,
Jake
