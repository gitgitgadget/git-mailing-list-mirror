Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ED6D21F404
	for <e@80x24.org>; Mon,  5 Feb 2018 20:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751514AbeBEUnR (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 15:43:17 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33866 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750855AbeBEUnP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 15:43:15 -0500
Received: by mail-pg0-f65.google.com with SMTP id s73so5315869pgc.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 12:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=5OMiKwVbUYimIojQkRaQgPosBSo5n776BrBlj7op3Gw=;
        b=OeM9N2A+xZKzDota1Qg1fPo5K9gmEvpJtio6W1zZpN8aciepSsCY59jRLSHKOiTE5I
         YVmXycVJJUnFoPcFxVBzqM9QtG1UOIEcfPspmur1FxI8QRKlHO2K3a2gfzqu0WrQiTPH
         EyRQuWFzGKWWDDHulvN/cNSqbCJGs5g8ptfsERUskzXpyzEWynan2UJ/OAhDmj78oUCK
         IHnABuei5G/HmgHUgLJifCGIwkE/M6b+ZX3KmfhpXVIhcTBL3ENqoqe9J3yp0tHMONdI
         AGw6/ZAD1yX6p1oApvrCVD8g3JoIxpAZTLol9cLXdT9dPh+y+5AZX9CCoF4fd9PcNmYA
         QOoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=5OMiKwVbUYimIojQkRaQgPosBSo5n776BrBlj7op3Gw=;
        b=m2ZNPt386Z61EGMQlY75kJ3iSD5QZ/x10nJ2UOukQMUFPrmb/b4OuNHq9pLsMq6ZQy
         NE284KM3L29gar7G+VjslFnneqsWDmuoRI2xVTjsSQKWGMyj4VSuIhDvQtDx1Xf2ji2x
         MeM8uRQ5yG63q5o2kgEbzawgV1/65jBhEhWD2NGyhHeZPF1quWWU20e2taVjMW/TgeEA
         DIn5/07D+LLuBlwMzwTUstctgjlb3NNS820pX0Gip/TUA9/NEe0Hn0tDtCb9Y26CdVUs
         njyVS69mdxImaDBqWNwKgPwEcKhNcljCR5aYthlG5OXMdGxgzLcJFRb3FG+EMiR36RJk
         eRew==
X-Gm-Message-State: APf1xPDfOYTG3hFmLPcFaSb2wFvriE5q7C80KZlAzqvyueRcNmEZqBPm
        4aJWDYtqba66+gA/Dw/oQv4=
X-Google-Smtp-Source: AH8x227fSG3M/k6LbAKHVHQKLKPRFt6ZUzTlApkoy5i4tP3OkCGOIgIZzmyK5zg+TrXhgDSifu0sgQ==
X-Received: by 10.101.64.139 with SMTP id t11mr64049pgp.162.1517863395051;
        Mon, 05 Feb 2018 12:43:15 -0800 (PST)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id t69sm20791784pfa.180.2018.02.05.12.43.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 12:43:14 -0800 (PST)
Date:   Mon, 5 Feb 2018 12:43:12 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Salvatore Bonaccorso <carnil@debian.org>
Cc:     889680@bugs.debian.org, git@vger.kernel.org
Subject: Re: git: CVE-2018-1000021: client prints server sent ANSI escape
 codes to the terminal, allowing for unverified messages to potentially
 execute arbitrary commands
Message-ID: <20180205204312.GB104086@aiede.svl.corp.google.com>
References: <151785928011.30076.5964248840190566119.reportbug@eldamar.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <151785928011.30076.5964248840190566119.reportbug@eldamar.local>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

+cc: upstream
Hi,

Salvatore Bonaccorso wrote[1]:

> the following vulnerability was published for git.
>
> CVE-2018-1000021[0]:
> |client prints server sent ANSI escape codes to the terminal, allowing
> |for unverified messages to potentially execute arbitrary commands
>
> Creating this bug to track the issue in the BTS. Apparently the CVE
> was sssigned without notifying/discussing it with upstream, at least
> according to [1].
>
> If you fix the vulnerability please also make sure to include the
> CVE (Common Vulnerabilities & Exposures) id in your changelog entry.
>
> For further information see:
>
> [0] https://security-tracker.debian.org/tracker/CVE-2018-1000021
>     https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2018-1000021
> [1] https://bugzilla.novell.com/show_bug.cgi?id=1079389#c1

Thanks.  Upstream was notified about this and we dropped the ball on
passing it on to a more public forum.  Sorry about that.

I'd be interested in your advice on this.  There are cases where the
user may *want* ANSI escape codes to be passed through without change
and other cases where the user doesn't want that.  Commands like "git
diff" pass their output through a pager by default, which itself may
or may not sanitize the output.

In other words, there are multiple components at play:

 1. A terminal.  IMHO, it is completely inexcusable these days for a
    terminal to allow arbitrary code execution by writing output to
    it.  If bugs of that kind still exist, I think we should fix them
    (and perhaps even make it a requirement in Debian policy to make
    the expectations clear for new terminals).

    That said, for defense in depth, it can be useful to also guard
    against this kind of issue in other components.  In particular:

 2. A pager.  Are there clear guidelines for what it is safe and not
    safe for a pager to write to a terminal?

    "less -R" tries to only allow ANSI "color" escape sequences
    through but I wouldn't be surprised if there are some cases it
    misses.

 3. Output formats.  Some git commands are designed for scripting
    and do not have a sensible way to sanitize their output without
    breaking scripts.  Fortunately, in the case of "git diff", git
    has a notion of a "binary patch" where everything is sanitized,
    at the cost of the output being unreadable to a human (email-safe
    characters but not something that a human can read at a glance).
    So if we know what sequences to avoid writing to stdout, then we
    can treat files with those sequences as binary.

Pointers welcome.

Thanks,
Jonathan

[1] https://bugs.debian.org/889680
