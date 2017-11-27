Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5FE9820A40
	for <e@80x24.org>; Mon, 27 Nov 2017 01:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752269AbdK0BNl (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 20:13:41 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53138 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752214AbdK0BNk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 20:13:40 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id BD901AF496;
        Sun, 26 Nov 2017 20:13:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9g3s+1wylvd3L2cYme3wa3iw+Hk=; b=Cg1a81
        oE6NyfYZXJkNxkOVYaa4dn8MuEKEA5Fmgd7vNWNJq3xKL8iSsElRPW/0F4uZxIlw
        /7UCNce8IBU3ryj0Rh/gLyHOXHVDNVykRfmW/P195OYNZ/xrlY+qywONVaz6gALU
        RO4O7zCW4qAS+MA+mXEuPBV7dxXNUpdHpUhp8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=EBm4xbS8gSTcmJaar6tP+Xn1g+YtzR/j
        ufht3co5fnok67N+U4vjsmzti2Vf0PxSUgkWBFJHVv/XjUDMVDNuxfFYp8PooIJA
        sXCh8c+PDPYkk0ZwuG09bRgmeYwV74SEjB3G+65c412bdJ9yCV7rKM/pE7lNCpn6
        e+gC1Z1fVms=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B5315AF495;
        Sun, 26 Nov 2017 20:13:39 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 276D3AF494;
        Sun, 26 Nov 2017 20:13:39 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        git <git@vger.kernel.org>, Dominik Mahrer <teddy@teddy.ch>,
        git-packagers@googlegroups.com, Todd Zullinger <tmz@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH] Makefile: check that tcl/tk is installed
References: <20171120171517.6365-1-chriscool@tuxfamily.org>
        <20171120191931.okxejqyqayjvxpbc@aiede.mtv.corp.google.com>
        <CAP8UFD0d9zM9F3tLrTMiLdfoJQsOPELtmudVB6e83DiLPN5DEA@mail.gmail.com>
        <20171126191510.GA1501@sigill>
Date:   Mon, 27 Nov 2017 10:13:38 +0900
In-Reply-To: <20171126191510.GA1501@sigill> (Jeff King's message of "Sun, 26
        Nov 2017 14:15:10 -0500")
Message-ID: <xmqqy3msfrr1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 33575468-D310-11E7-985D-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> ...
> I think your patch does say "consider setting NO_TCLTK" in that case,
> which is an improvement. But it might be nicer still if it Just Worked
> (either because we don't do tcl/tk by default, or because we respect
> NO_GETTEXT in the gitk/git-gui Makefiles, or because our msgfmt can
> fallback further to not even using tclsh).
>
> So I'm not really against this patch, but IMHO it doesn't make the
> interesting case (you don't care about tcl and are just trying to build
> git for the first time) all that much better.

I was in agreement with that line of argument while the patch was
discussed, and I still think the above is true.

And if the primary thing we want to address with this patch is the
build breakage for those who do not have tclsh nor msgfmt, perhaps
it is a more direct fix to update this part in gitk/Makefile:

    ## po-file creation rules
    XGETTEXT   ?= xgettext
    ifdef NO_MSGFMT
            MSGFMT ?= $(TCL_PATH) po/po2msg.sh
    else
            MSGFMT ?= msgfmt
            ifneq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null 2>/dev/null; echo $$?),0)
                    MSGFMT := $(TCL_PATH) po/po2msg.sh
            endif
    endif

There is an identical copy-and-pasted copy of this in
git-gui/Makefile, and both of them silently assume that TCL_PATH
points at something usable when msgfmt is not available.

Perhaps the "else" part of the above should become a bit more
careful, something along the lines of...

    else
            MSGFMT ?= msgfmt
-           ifneq ($(shell $(MSGFMT) --tcl -l C -d . /dev/null 2>/dev/null; echo $$?),0)
-                   MSGFMT := $(TCL_PATH) po/po2msg.sh
-           endif
+           MSGFMT_DRYRUN = --tcl -l C -d . /dev/null 2>/dev/null
+            ifneq ($(shell $(MSGFMT) $(MSGFMT_DRYRUN); echo $$?),0)
+               ifneq ($(shell $(TCL_PATH) po/po2msg.sh $(MSGFMT_DRYRUN); echo $$?),0)
+                    MSGFMT := $(TCL_PATH) po/po2msg.sh
+               else
+                   $(error "no usable msgfmt to build gitk; set NO_TCLTK perhaps?")
+               endif
            endif
    endif


Another reason why I think the Makefiles in gitk and git-gui
projects are better targets for the fix is because they are designed
to be independent projects.  We should be able to do

	cd git-gui && make

in our tree, but an update to our top-level Makefile does not help
those people.
