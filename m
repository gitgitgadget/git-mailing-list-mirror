Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEE31C433FE
	for <git@archiver.kernel.org>; Fri, 30 Sep 2022 20:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231149AbiI3UfA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Sep 2022 16:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232257AbiI3Ue5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Sep 2022 16:34:57 -0400
X-Greylist: delayed 444 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 30 Sep 2022 13:34:48 PDT
Received: from tilde.club (tilde.club [142.44.150.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9CDB7D2
        for <git@vger.kernel.org>; Fri, 30 Sep 2022 13:34:47 -0700 (PDT)
Received: from tilde.club (unknown [171.25.193.235])
        by tilde.club (Postfix) with ESMTPSA id 977B6220039E9;
        Fri, 30 Sep 2022 20:27:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 tilde.club 977B6220039E9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tilde.club; s=mail;
        t=1664569638; bh=gB2muBxWFg+iKDXRQSgbaGLPzTcCiliUCrUhBPS8yR8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vg5/cUPFictYKQ9CvHFaiDnDeEE4wU3Mo1xp+18P+wSkbw3jizEIDBAGgCaOOcQsY
         lNza85vJDeb3y3EPALFR5bGUXCzT7x+bzcig72PHDryhPDhpqJSivq0Dq+nxONUI6a
         kv/g/dYKjpioef7cv41ALQnpIjurv/qqUWU5360A=
Date:   Fri, 30 Sep 2022 20:26:41 +0000
From:   Gwyneth Morgan <gwymor@tilde.club>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC PATCH 2/2] docs: document a format for anonymous author and
 committer IDs
Message-ID: <YzdQwNCtwAYjhKWp@tilde.club>
References: <20220919145231.48245-1-sandals@crustytoothpaste.net>
 <20220919145231.48245-3-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220919145231.48245-3-sandals@crustytoothpaste.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In general, I like this proposal. It seems like a good way forward.

It should be made very clear to the user that a commit authored by a
key-derived ID does not imply the commit is signed by that key or
provide any security guarantees; anyone can put anything in that field,
same as it is now. I could see someone seeing a commit authored by
<47DEQpj8HBSa-_TImW-5JCeuQeRkm5NMpJWZG3hSuFU@_.sha256.ssh.id.git-scm.com>
and thinking that implies the commit was signed by
`47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU`.

On 2022-09-19 14:52:31+0000, brian m. carlson wrote:
> +Anonymous IDs
> +-------------
> +
> +Git will implement a new form of email address which is acceptable to existing
> +implementations but is not valid according to RFC 1123.  This takes the form of
> +an email address where the local-part contains the identifier and the domain
> +portion starts with `_.` and then a domain specifier which specifies an
> +authority and the meaning of the identifier.
> +
> +In such a case, Git will specify the username as a single U+2060 in UTF-8 (the
> +byte sequence 0xE2 0x81 0xA0), which is a zero width non-breaking space.  This
> +is compatible with existing implementations.

Could you add a note here explaining why that character was chosen for
the name field? It seems like it would be easier to work with a single
printable character like `?` or `X`, but maybe that doesn't matter here.
