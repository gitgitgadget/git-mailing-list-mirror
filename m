Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC63020756
	for <e@80x24.org>; Fri, 20 Jan 2017 19:53:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753222AbdATTxE (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 14:53:04 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:35322 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753172AbdATTxD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 14:53:03 -0500
Received: by mail-it0-f44.google.com with SMTP id 203so27277808ith.0
        for <git@vger.kernel.org>; Fri, 20 Jan 2017 11:53:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=56s48TYWa4wQBAUE3h5WoATufbZB8+RoQysObmsCDpw=;
        b=AJtmd3UGau3sfOPn12noyb2Ri50g2oyi0VpzYd+/bggsOy7SPFgnu70eqYPQBdSPyp
         XBaDklo6Z7B47+8DQ4ROa3bg/07iQy2FrELbcw9grbNxIjZ95ps92zBDpzIlvvOwZW+u
         G9VcgWtdyh8uRHJTIjqaCT5t0hx8AGLfTxv+avbA6JTkXFR6JnNn0lv57sDIDSakd9BF
         5huv6mPmrNd6FxxuppE+LYYjatEU+i1Qi+J4xB+UzjhJQj8G+xpYzaeTc4s/16LdNLbM
         mm//fbFGVjDYrRJvCUMRpzKlwNtoTKkUOAmCGK7mJsSqEXUXXFP1qIaXggOA3cZ89ez+
         ahXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=56s48TYWa4wQBAUE3h5WoATufbZB8+RoQysObmsCDpw=;
        b=tvtq+DcE1KFZ9wggzGITRhKHZW8yi6TNRS1mPbiTAMzjvTiVmnNvuoV08fapok5LdT
         qi7c12nWKise0VR4uYC+VQBMh22/OMc/fDToGO2SUY00KHgx+iZPF5SlSW+4uGnEOKrE
         UXp1AX25QWgmRs6y31PWSGuQlTMlc3qKWGId/V5K0MWRIsknjBsn0ExLtbSpy4LIgFxh
         ab5FTOezFIii6cUX5NXVsCwBLit3mJPlEFxbD20vl1U42BACii7Dz7Ha1Pu0a4xnsW/V
         DQLxuh2OvejOKYBk/4+31/zJX8t6oO8OsQCRp6ZoDXRzcnsEjdhSiobZ2kys15UQLUVk
         Z/cg==
X-Gm-Message-State: AIkVDXKTiUn13NUYOgTaQpW9GVKHmwPIj5PUNdhvXM8XOxIdLEDKsONqWLwG1tXC5AOph+czwohtq8WIiyWvJeM1
X-Received: by 10.36.169.12 with SMTP id r12mr5150575ite.69.1484941982196;
 Fri, 20 Jan 2017 11:53:02 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.39.19 with HTTP; Fri, 20 Jan 2017 11:53:01 -0800 (PST)
In-Reply-To: <20170120194224.vikzovupwqx53x2c@sigill.intra.peff.net>
References: <20170119193023.26837-1-sbeller@google.com> <20170120191728.l3ne5tt5pwbmafjh@sigill.intra.peff.net>
 <CAGZ79kaJQefSDkV-LKxRCTtSepsNsX7U+AZqy3Z_YCd1xsmTxQ@mail.gmail.com> <20170120194224.vikzovupwqx53x2c@sigill.intra.peff.net>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 20 Jan 2017 11:53:01 -0800
Message-ID: <CAGZ79kYKY=hDVjUx7AkeWZ=3V8Fy2hqQMFPZcoxT4NvXTFgG=Q@mail.gmail.com>
Subject: Re: [RFC/PATCH] Disallow commands from within unpopulated submodules.
To:     Jeff King <peff@peff.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 20, 2017 at 11:42 AM, Jeff King <peff@peff.net> wrote:
> On Fri, Jan 20, 2017 at 11:33:45AM -0800, Stefan Beller wrote:
>
>> > I'd rather see it in the commands themselves. Especially given the
>> > "ideal" in your status example, which requires command-specific
>> > knowledge.
>>
>> So you rather want to go bottom up, i.e. add it to each command individually
>> for which it makes sense, instead of rather first having a catch-it-all like
>> this and then we can have a flag similar to RUN_SETUP, e.g.
>> ALLOW_IN_UNPOP_SUBMODULE, which allows commands to
>> take over the responsibility to act responsibly in this case?
>
> Yes. I know it's "less safe" in the sense that commands have to make an
> effort to detect the situation, but I feel like only they'll know what
> the sensible behavior is. And they can also do the check at a time when
> they would be reading the index anyway.
>
>> status may be the first command for going that route; I wonder if we'd
>> want to add this feature unconditionally or only in the porcelain case.
>> (In plumbing you're supposed to know what you're doing... so there is
>> no need as well as our promise to not change it)
>
> Yeah. The reason that it would be so painful to load the index
> for every rev-parse is not just that it probably doesn't otherwise need
> the index, but that scripts may make a _ton_ of rev-parse (or other
> plumbing) calls.
>
> One alternative would be to make the check cheaper. Could we reliably
> tell from the submodule.foo.* block in the config that path "foo" is a
> submodule? I think that would work after "submodule init" but not right
> after "git clone". So the index really is the source of truth there.

Well we can check if there is a .gitmodules file that has a
submodule.*.path equal to the last part of $CWD, no need to look
at the git config.

And that would also work right after git clone (in an
unpopulated/uninitialized submodule as I call it).

And in my current understanding of submodules the check in
.gitmodules ought to be enough, too.

>
> I guess there could be an index extension "these are the gitlinks I
> contain" and in theory we could read just that extension. I dunno.
>
> -Peff
