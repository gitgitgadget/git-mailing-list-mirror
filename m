From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 30/67] ref-filter: drop sprintf and strcpy calls
Date: Wed, 16 Sep 2015 12:33:16 -0700
Message-ID: <xmqqpp1ip3b7.fsf@gitster.mtv.corp.google.com>
References: <20150915152125.GA27504@sigill.intra.peff.net>
	<20150915154813.GD29753@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Sep 16 21:33:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcISK-0005Wg-Jl
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 21:33:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbbIPTdU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 15:33:20 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33290 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751689AbbIPTdT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 15:33:19 -0400
Received: by pacex6 with SMTP id ex6so217798486pac.0
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 12:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=1Wb6WLb3kaqZofaD7xUjqg3zOE2m6j5MGjorjrY1k7w=;
        b=VAaWzWpcqWOF8tapOyf9jQDyHuMQUY+EIcus9npiORWJNNtVdf7jARlLRT5LPvKosG
         lOtJ/FHS1Gxq0ypykwglZAvO05JfI2VGEtvFLWdrd7caf0K2j0n/z1yNzr2jSrjfYsLT
         fa2YHBbpVVwdHvfxvEPxztol2SU63mBwg81v44oTPVZkgdVRPiMGF7kKzjRKUdcba9VS
         rkgaMYiWEW9IVEO2ZK4I5Iw7+MnAM+npdhYcZcWkeWAZZF/wC5g0+DFG5vCqAt8x5Nuh
         eJzeGo7wZqimgzsUWvmMOX7nag3/SUPPNITY/4oEpb7ulwRrep94tOz09KDnFjdnF5p5
         8eAQ==
X-Received: by 10.66.155.9 with SMTP id vs9mr62462551pab.63.1442431999333;
        Wed, 16 Sep 2015 12:33:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:150c:7d53:9693:493e])
        by smtp.gmail.com with ESMTPSA id bz4sm29349558pbd.6.2015.09.16.12.33.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Sep 2015 12:33:17 -0700 (PDT)
In-Reply-To: <20150915154813.GD29753@sigill.intra.peff.net> (Jeff King's
	message of "Tue, 15 Sep 2015 11:48:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278053>

Jeff King <peff@peff.net> writes:

> The ref-filter code comes from for-each-ref, and inherited a
> number of raw sprintf and strcpy calls. These are generally
> all safe, as we custom-size the buffers, or are formatting
> numbers into sufficiently large buffers. But we can make the
> resulting code even simpler and more obviously correct by
> using some of our helper functions.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  ref-filter.c | 70 +++++++++++++++++++-----------------------------------------
>  1 file changed, 22 insertions(+), 48 deletions(-)

The end result indeed is much easier to read.  Looks good.
