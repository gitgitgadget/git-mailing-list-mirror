From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 00/19] Introduce an internal API to interact with the fsck machinery
Date: Mon, 22 Jun 2015 11:02:21 -0700
Message-ID: <xmqqlhfbhb9u.fsf@gitster.dls.corp.google.com>
References: <cover.1434720655.git.johannes.schindelin@gmx.de>
	<cover.1434986506.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Jun 22 20:02:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z763F-00019D-Kj
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 20:02:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753921AbbFVSC3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 14:02:29 -0400
Received: from mail-ig0-f177.google.com ([209.85.213.177]:37696 "EHLO
	mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753573AbbFVSCZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 14:02:25 -0400
Received: by igblr2 with SMTP id lr2so58922501igb.0
        for <git@vger.kernel.org>; Mon, 22 Jun 2015 11:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=bj2ahAWdSWycytSLwctc5RCSkoL7PiFjl+2VT9iygSY=;
        b=xvOwipOFFOtol/jRxq0mH/MPl3bfyMkIA/UxZBS/xBSN4BOGM4FE1uq3MIRyQRFgec
         yxPYV/jyU6jweA9umX/oqvEDqJdbj0NYrB0v7lPIavJKPWNX72UNHAq5k8S9I+mkVqIK
         XabdlcS62UD3nZdBFXQ9tJlcDnigab2Sh8/OZq7n/phM5SpGv7seEsKQU9LClHnsCAUs
         GqtRkiKUrtt8ZnGHob1G3gAfa6Kqp88hWE370oFjW67etB4YEeQR1p6TXOWQnBF83rSr
         rub+by3IKQnQpgvRl8ZTKxNKP5EHCR8wJeHphDH7bZ9fRNKr/RFnFu9KeBJfnb9BsSIv
         s10Q==
X-Received: by 10.107.18.92 with SMTP id a89mr42066209ioj.14.1434996144248;
        Mon, 22 Jun 2015 11:02:24 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:b0be:ae3d:b206:8e25])
        by mx.google.com with ESMTPSA id s5sm7973231igh.6.2015.06.22.11.02.23
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 22 Jun 2015 11:02:23 -0700 (PDT)
In-Reply-To: <cover.1434986506.git.johannes.schindelin@gmx.de> (Johannes
	Schindelin's message of "Mon, 22 Jun 2015 17:24:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272400>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> Changes since v6:
> 
> - camelCased message IDs
>
> - multiple author checking now as suggested by Junio
>
> - renamed `--quick` to `--connectivity-only`, better commit message
>
> - `fsck.skipList` is now handled correctly (and not mistaken for a message
>   type setting)
>
> - `fsck.skipList` can handle user paths now
>
> - index-pack configures the walk function in a more logical place now
>
> - simplified code by avoiding working on partial strings (i.e. removed
>   `substrcmp()`). This saves 10 lines. To accomodate parsing config
>   variables directly, we now work on lowercased message IDs; unfortunately
>   this means that we cannot use them in append_msg_id() because that
>   function wants to append camelCased message IDs.
>
> Interdiff below diffstat.

Except for minor nits I sent separate messages, this round looks
very nicely done (I however admit that I haven't read the skiplist
parsing code carefully at all, expecting that you wouldn't screw up
with something simple like that ;-))

Thanks, will replace what is queued.  Let's start thinking about
moving it down to 'next' (meaning: we _could_ still accept a reroll,
but I think we are in a good shape and minor incremental refinements
would suffice), cooking it for the remainder of the cycle and having
it graduate to 'master' at the beginning of the next cycle.

Thanks.
