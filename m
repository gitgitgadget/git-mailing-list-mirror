Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 587BA1FAFB
	for <e@80x24.org>; Fri, 31 Mar 2017 17:19:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933304AbdCaRTI (ORCPT <rfc822;e@80x24.org>);
        Fri, 31 Mar 2017 13:19:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51684 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933153AbdCaRTH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Mar 2017 13:19:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B7F9B7B8C5;
        Fri, 31 Mar 2017 13:19:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GykgcfhEH6A9BVM4Ex7sgPc+koo=; b=rrlK3c
        34Ow5zBu2mFoYErCWYhKiVHW+8sTC4g9+KUUHFlsHB0XKZ8L2AWxI5lpfZMMIdUL
        bVg5imhcHKMAgkr0JL+zBQYslfFjznSrgcwQeVtDQPAV4EQu+9Dl564V6S+TvXqI
        n5BEQkr13tuLKIjZ6LcitjBuBLjfQjFNiBexo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=D3s8xFQaMBssvxi6utPUaMyTUv6ExPkk
        HgV/c5crgICr2Gj034S+sslXGh9vrSU1U/dyEAHOXy/D18JcmW9fPrGsZvitS8sa
        4Uy68jxHtIJ4InnQrytkTHTSTBsl3+FHSRxi7RCH+mMols45VTPZXf+nqDge4nFW
        4qwIeJe83i4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0A8F7B8C4;
        Fri, 31 Mar 2017 13:19:05 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 063887B8C3;
        Fri, 31 Mar 2017 13:19:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Peter van der Does <peter@avirtualhome.com>
Cc:     Pat Thoyts <patthoyts@users.sourceforge.net>, git@vger.kernel.org,
        dshrader@lanl.gov, dennis@kaarsemaker.net, git@jessiehernandez.com,
        kostix+git@007spb.ru
Subject: Re: [PATCH] git-gui: Error on systems with TK < 8.6.0
References: <c56892f3-602c-d684-5d07-a3ce3bab8189@avirtualhome.com>
Date:   Fri, 31 Mar 2017 10:19:03 -0700
In-Reply-To: <c56892f3-602c-d684-5d07-a3ce3bab8189@avirtualhome.com> (Peter
        van der Does's message of "Fri, 31 Mar 2017 08:54:23 -0400")
Message-ID: <xmqqlgrlz7nc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 244AD806-1636-11E7-B031-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Peter van der Does <peter@avirtualhome.com> writes:

> Using git-gui on systems that run a TK version below 8.6.0 results in a
> crash when checking for the current theme.
>
> Catch the error on those systems and use a different command to check
> for the current theme.
> ---

Needs sign-off.  Also if you can make the patch against the git-gui
project (the upstream project for this part of our tree, which has
this file at lib/themed.tcl, not at git-gui/lib/themed.tcl) and send
it to its maintainer (Cc'ed), it would be great.

Thanks.

>  git-gui/lib/themed.tcl | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/git-gui/lib/themed.tcl b/git-gui/lib/themed.tcl
> index 351a712c8..bb4e8f25e 100644
> --- a/git-gui/lib/themed.tcl
> +++ b/git-gui/lib/themed.tcl
> @@ -248,7 +248,11 @@ proc tspinbox {w args} {
>  proc ttext {w args} {
>  	global use_ttk
>  	if {$use_ttk} {
> -		switch -- [ttk::style theme use] {
> +		# Handle either current Tk or older versions of 8.5
> +		if {[catch {set theme [ttk::style theme use]}]} {
> +			set theme  $::ttk::currentTheme
> +		}
> +		switch -- $theme {
>  			"vista" - "xpnative" {
>  				lappend args -highlightthickness 0 -borderwidth 0
>  			}
