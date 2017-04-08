Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8803520970
	for <e@80x24.org>; Sat,  8 Apr 2017 14:54:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752226AbdDHOyB (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Apr 2017 10:54:01 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:32805 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751778AbdDHOx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Apr 2017 10:53:59 -0400
Received: by mail-io0-f171.google.com with SMTP id t68so30240876iof.0
        for <git@vger.kernel.org>; Sat, 08 Apr 2017 07:53:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=09nEU8hX4QOdE5B/w2rgrwO1o7CMG3cWMVn/pW+uTyQ=;
        b=ON9upnDVSYf/5FfPv1xNJ7HpzlpAlztC5Crlw96B8kaNPDrpYJy9gF1TFxdDbWJsqA
         t1E9IivVju4T2KhQthOi4lT+cyXFODlCSFNDfcMJMOMu/80uhA31hmuSL7h14jrGJ9Dz
         27WKGXs86SccxCPGXc0kHMl9YVGS6oKYNenz20AB+gy9aAsCyxV9VHnwZtdCsEjAY5yp
         IaGLNeHK1l6K47Wbv3FcdSGmxWUTRSRlUA4aJeVcEDZ6EqOG6kKvOjArKDYOttobT+Db
         Yrw80SDF/xXgHG36XA4fdnQSpFNCfQkpVOy/QmlwdrzedH4xVQuwbiuGrJWCXbD+CMXd
         fQWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=09nEU8hX4QOdE5B/w2rgrwO1o7CMG3cWMVn/pW+uTyQ=;
        b=lkk5bmp3quUoD+UPjSc83B0wBrt4sMh3UH8uo8ZLTaIXLWtTuI3vH31W8vo9WFbGcy
         EBehrzqFNhoTbrzie/H1gpXRaMRsXaD/D+x2cUyi+F4GVcgTCKcZlm5ANgfIORiRIEa8
         3mVhMy4g0H53inmmelNQBED8kCEoidIEkVyvSHIn7EJCHaBQHANL5jiLnClXFHRjD3mU
         sanxYIVCbUbWvufD9NIMGrK3py91OG2aYIj1S3kn+2y5d+a1H7mMTrnhmfNxZX3x4Gmy
         eof2c5ni8kBfgjCIeJsL1zAGf94SY5YcT9L5T0InkuQMY7E2bbSsAIsmx9DM4k3NWYpJ
         Ys8A==
X-Gm-Message-State: AFeK/H1a4MMYYjWX/v76jfarcadpSbj0TJFrjjP9YoO8n8tYHK99AqiYxJY8UAKtlLOJzL5uAYk+cVWoIGo1/Q==
X-Received: by 10.107.32.199 with SMTP id g190mr47898994iog.117.1491663239058;
 Sat, 08 Apr 2017 07:53:59 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.130.208 with HTTP; Sat, 8 Apr 2017 07:53:38 -0700 (PDT)
In-Reply-To: <20161001091245.jkju5rlytbcb2r52@sigill.intra.peff.net>
References: <20160930193533.ynbepaago6oycg5t@sigill.intra.peff.net>
 <20160930193630.vwq6n5hjbthrz6fj@sigill.intra.peff.net> <20161001091245.jkju5rlytbcb2r52@sigill.intra.peff.net>
From:   =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Date:   Sat, 8 Apr 2017 16:53:38 +0200
Message-ID: <CACBZZX7Rt4zLGk=iy_Z9+8M-xUexwYA060R-v0nvseY7g+zA0w@mail.gmail.com>
Subject: Re: [PATCH 4/6] receive-pack: quarantine objects until pre-receive accepts
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        David Turner <dturner@twosigma.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Oct 1, 2016 at 11:12 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Sep 30, 2016 at 03:36:30PM -0400, Jeff King wrote:
>
>> @@ -1639,6 +1666,18 @@ static const char *unpack(int err_fd, struct shallow_info *si)
>>               argv_array_push(&child.args, alt_shallow_file);
>>       }
>>
>> +     tmp_objdir = tmp_objdir_create();
>> +     if (!tmp_objdir)
>> +             return "unable to create temporary object directory";
>> +     child.env = tmp_objdir_env(tmp_objdir);
>
> One thing to note here: this new code kicks in all the time. My
> reasoning was that there's basically no time you _wouldn't_ want it to,
> and certainly that was the case for us when I wrote it. But I tried to
> think of user-visible changes. Here's what I came up with:
>
>   - we currently leave the tmp_pack_* for a failed push sitting around
>     (e.g., if the client hangs up halfway through, or index-pack rejects
>     the pack for some reason). But with this series, it would always be
>     cleaned up. That's a very good thing if you're running a git hosting
>     site. It might make things harder if you're debugging.
>
>     I don't think it's a good reason not to enable this by default, but
>     it _could_ be a reason to have a config switch to turn it off
>     temporarily (or just leave the "incoming-*" directory in place).
>
>   - the environment that pre-receive pack runs in has access to objects
>     that the rest of the repository doesn't. So if you were to do
>     something silly in your pre-receive like:
>
>       # reject the push, but log a copy of the objects
>       git update-ref refs/rejected/$(date +%s) $new_sha1
>       exit 1
>
>     Then your ref-update would succeed (you have $new_sha1), but the
>     objects would be deleted immediately afterwards. I find this a
>     somewhat questionable pattern, and I have no idea if anybody else
>     has thought of it. But it _does_ work today, and not with this
>     series.
>
> I don't think it would be too hard to put a config conditional around
> this tmp_objdir_create(). And then all of the tmp_objdir_env() calls
> would just return NULL, and effectively become noops.

Very late reply, but I have a question about this. Is there anything
you can do on the plumbing level to figure out which area an object is
in (of course that's not mutually exclusive).

The use-case for that is e.g. having a hook that rejects large
binaries, but has an exception for a binary that's been added in the
past, before your change there's no optimal way to find that out,
you'd need to go over the whole history and list all blobs that have
ever been added, with your change it would be trivial if something
could give me "this object is in the quarantine area", but AFAICT
there's no API that'll show me that.

Also, I think this whole thing could really do with some documentation
in githooks(5). E.g. what hooks does it apply for? The test is just
for pre-receive but the patch changes run_update_hook(), does it also
take effect for update? Ditto the caveat about update-ref.
