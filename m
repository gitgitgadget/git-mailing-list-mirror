From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Git configure/make does not honor ARFLAGS
Date: Wed, 16 Sep 2015 15:45:16 -0400
Message-ID: <CAPig+cQ_y6GDn3TsFuP1dYpYPzpdDCbuqmjnY72hDs32HnfbsQ@mail.gmail.com>
References: <CAH8yC8kV77h8cRA9Qo_1FYe9sv0zgsE7yKxaX+OtpRfj9+7wog@mail.gmail.com>
	<20150913101727.GB26562@sigill.intra.peff.net>
	<CAPig+cQV-kaDDdBH+QZXsSjDHjP2CUYDXp3WKSBtgguVmLvofg@mail.gmail.com>
	<20150914043016.GA10167@sigill.intra.peff.net>
	<CAPc5daUBBPRxaaptTS9xyr+pJ6Fgt4XXi+MU=DSZeoQ6uHCHvg@mail.gmail.com>
	<20150914045953.GA11039@sigill.intra.peff.net>
	<CAPc5daXjnLduFOD5au+wV0AN6EXTUWTM6JQ66U+0DwzVhk3YcA@mail.gmail.com>
	<20150916193856.GA15738@flurp.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 21:45:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcIdw-0002eQ-1V
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 21:45:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752809AbbIPTpS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 15:45:18 -0400
Received: from mail-vk0-f47.google.com ([209.85.213.47]:35387 "EHLO
	mail-vk0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbbIPTpR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 15:45:17 -0400
Received: by vkao3 with SMTP id o3so96230166vka.2
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 12:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=SKeqBFtWCabGmubymXsKh3FL2YFmAmGdlbzuZw64WSc=;
        b=x8KxV90AVK6NGZNqOvlDPXY3vdGs/Oi3CEOihERKq9flhtYyPmkD+U7FuxVDGAD6DE
         MdXiaQGyB6qdrF6/dJqtsrE+fgt3nTHHYboyMjHlRBcoFfYvkqmFTJkC84hj1rGx6ruh
         KY8c0o3B0OPyxKvb8mRmBqdHzzrPZ/pkCxu3edczbpF5OM0l6HSIutDymhfa845OiPhJ
         fv0aZLaoz+cQI4XrCQNwffKt/YnX/ubmk9Q0v9zJjpdb+hMdDgNxVAu4NwYo0V/g91ai
         Vedg6mEPyWe0GhmpqMOVfkcA7DqUvjnVAJ3nK/1vSms9cXLgW0MWKLpmMK4FUQUZk+FP
         rylA==
X-Received: by 10.31.151.84 with SMTP id z81mr19291217vkd.14.1442432716856;
 Wed, 16 Sep 2015 12:45:16 -0700 (PDT)
Received: by 10.31.224.68 with HTTP; Wed, 16 Sep 2015 12:45:16 -0700 (PDT)
In-Reply-To: <20150916193856.GA15738@flurp.local>
X-Google-Sender-Auth: hags6kO10AyChcEGKmtPyY202H0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278055>

On Wed, Sep 16, 2015 at 3:38 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On the other hand, as far as I know, it's *always* safe to replace
> 'ar' with 'libtool' on this platform, so we could just do it
> unconditionally.
>
> --- 8< ---
>  ifeq ($(uname_S),Darwin)
> +       AR = libtool
> +       ARFLAGS = -static -o
> --- 8< ---
>
> I've tested this on modern Mac OS X, Yosemite 10.10.5 (x86_64), and
> ancient Snow Leopard 10.5.8 PowerPC (circa 2009), and it works fine
> in both cases, so perhaps that's the way to go.
>
> My one concern, however, would be people who've installed GNU libtool
> and have that in PATH before Apple's tools.

Although, perhaps specifying the full path to 'libtool' would be
sufficient so as not to worry about GNU libtool being picked up by
accident. Apple's command resides at /usr/bin/libtool on both modern
and ancient Mac OS X, so maybe that's all we need.
