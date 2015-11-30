From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2] builtin/clone: support submodule groups
Date: Mon, 30 Nov 2015 11:31:27 -0800
Message-ID: <CAGZ79kbUktcGNw4C123dxGoUsi=W+h4vUPWmBm2rExipUOcXqA@mail.gmail.com>
References: <5656366D.4010508@web.de>
	<1448497884-2624-1-git-send-email-sbeller@google.com>
	<20151126045929.GA29107@tsaunders-iceball.corp.tor1.mozilla.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Eric Sunshine <ericsunshine@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Trevor Saunders <tbsaunde@tbsaunde.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Nov 30 20:31:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a3UAg-0007x8-6S
	for gcvg-git-2@plane.gmane.org; Mon, 30 Nov 2015 20:31:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752205AbbK3Tba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Nov 2015 14:31:30 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34627 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751237AbbK3Tb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Nov 2015 14:31:28 -0500
Received: by ykfs79 with SMTP id s79so198187948ykf.1
        for <git@vger.kernel.org>; Mon, 30 Nov 2015 11:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=E1vAJ8Qdk71UZzXXYbI9csEOkoCLj1TATAlfykUb4Ms=;
        b=RcHiLu+U5twqAc5y2J4lIfLXKym7wWxubf/GAYiKS/6zdLW207CEw1E11zuNreRmud
         k+1Y5gTODQiEdmU9lvViBKmgYqkcvSJZ49XdJhX0Z134Pv7+/LrAYqTNuUmcQjiMRFPP
         EZq8TLR9abBkX7wC8RCVrmF35zXVvVjsrTdQtwQ3BKrKPRE42KlWzHcy5oEuBjVOde/k
         DiGbeQV3CW0qvb3a1r5nSnfGc+FL3XwBgJNGs+mLXvWrGB+NXXNNJwDQa+l3cNHFSB5K
         CrdIUAwWNZM/DLOOsrnGraNJYQpYrwS2e3dCwxL5lvstmfL1cmKg+dwgcSBAuZKeNF4v
         sE9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=E1vAJ8Qdk71UZzXXYbI9csEOkoCLj1TATAlfykUb4Ms=;
        b=gYiBvQfvtxH1bhz+P2fsSfHAZ71jBj6iwzx9UC+fX8786A/vH+nwoOyFvmXRlm0cyN
         NeFhO0fnMW4lSq89KQT/p65dUs1wxOjo4KgJ2Jxl8IMWw7ZBonUsuDeUgw0TWexsKWAK
         TnQFtoPFPnjtY2BTAluI4/Eg6bbOjwBZ6dQ64FBb2Dt/zMN6e6jFkReTs/xXR+73FvFG
         wOvDEsm7A+TIWJc+lhn7oMtfm9qHSuMsfRbEiVlUzz8VMf4Q8iTYeKUmMS4oEbcZfbr0
         S479YJDSw/Kbe8o228QRlLVNQf/2Pg8wwUNS8CslJmAf+gZHy34L19N/3+kyLgHKWfjd
         b8PQ==
X-Gm-Message-State: ALoCoQlBrSbPe9QqF9iwhzQp2c/epWx2ixv30jiWJZyMwyZmX0cYuuf/bRpqUxibxMJr33BQ5eWz
X-Received: by 10.13.198.133 with SMTP id i127mr31385614ywd.252.1448911887973;
 Mon, 30 Nov 2015 11:31:27 -0800 (PST)
Received: by 10.37.215.16 with HTTP; Mon, 30 Nov 2015 11:31:27 -0800 (PST)
In-Reply-To: <20151126045929.GA29107@tsaunders-iceball.corp.tor1.mozilla.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281815>

+ cc Duy, Michael, who discussed the sparse checkout recently

On Wed, Nov 25, 2015 at 9:00 PM, Trevor Saunders <tbsaunde@tbsaunde.org> wrote:
> Seeing the recent sparse checkout discussion I realized it might be
> useful to have a similar sort of feature for sparse checkouts.  So say I
> had a mobile and desktop client in the same repo and wanted to be able to
> checkout the commoncode and one client without having to explicitly list
> all the paths I care about. It seems like UI wise you might want to use
> --group there too, or at least explaining the difference to users might
> be interesting, but maybe that's worrying way too much abouta possible
> future feature.

For reference what I was proposing (coverletter [RFC PATCH 0/5]
Submodule Groups):
-->8--
This is also available at
https://github.com/stefanbeller/git/tree/submodule-groups
It applies on top of the submodule-parallel-patch series I sent a few
minutes ago.

Consider having a real large software project in Git with each component
in a submodule (such as an operating system, Android, Debian, Fedora,
no toy OS such as https://github.com/gittup/gittup as that doesn't quite
demonstrate the scale of the problem).

If you have lots of submodules, you probably don't need all of them at once,
but you have functional units. Some submodules are absolutely required,
some are optional and only for very specific purposes.

This patch series adds meaning to a "groups" field in the .gitmodules file.

So you could have a .gitmodules file such as:

[submodule "gcc"]
        path = gcc
        url = git://...
        groups = default,devel
[submodule "linux"]
        path = linux
        url = git://...
        groups = default
[submodule "nethack"]
        path = nethack
        url = git://...
        groups = optional,games

and by this series you can work on an arbitrary subgroup of these
submodules such
using these commands:

    git clone --group default --group devel git://...
    # will clone the superproject and recursively
    # checkout any submodule being in at least one of the groups.

    git submodule add --group default --group devel git://... ..
    # will add a submodule, adding 2 submodule
    # groups to its entry in .gitmodule

    # as support for clone we want to have:
    git config submodule.groups default
    git submodule init --groups
    # will init all submodules from the default group

    # as support for clone we want to have:
    git config submodule.groups default
    git submodule update --groups
    # will update all submodules from the default group

Any feedback welcome, specially on the design level!
(Do we want to have it stored in the .gitmodules file? Do we want to have
the groups configured in .git/config as "submodule.groups", any other way
to make it future proof and extend the groups syntax?)
-->8--

I think the biggest advantage with the groups is to have it not depending on the
path. Consider your one repository containing both mobile and desktop code,
where you have a sparse checkout for mobile.

Now what happens if files are renamed, i.e. the leading directory?
As this change comes in from your dear coworker, who has no idea how
your .git/info/sparse-checkout looks like, it may happen that more files appear
in your worktree as your patterns did not cover the renamed case.
Or some file contents go missing as they are in one of the ignored paths.

This groups feature would solve that as the groups are not dependent on
the paths or the data itself. However the groups in this proposal are only
meant to be applied on a submodule level, not in a repository itself.

How would you do that?
I could imagine a file like .gitgroups (It should be part of the repository,
such that everybody talks about the same groups), with a similar syntax like
.gitattributes where some file patterns are assigned one or more groups.
And in either .git/config (as it is for the submodules here) or in a file
.git/info/groups (as the sparse checkouts do it in that directory)
you'd configure the groups you are interested in.

It would be cool to have the same mechanism for both sparse-group-checkout
and submodules, so I'd propose to use a config option in .git/config,
such as checkout-group which covers both submodules as well as the
pattern groups as specified by .gitgroups.

---
Beware, this is just a first shot spinning around some ideas.

Thanks,
Stefan
