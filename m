From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] am: let command-line options override saved options
Date: Tue, 28 Jul 2015 09:48:05 -0700
Message-ID: <xmqqio94fcu2.fsf@gitster.dls.corp.google.com>
References: <xmqqr3nxmopp.fsf@gitster.dls.corp.google.com>
	<20150724180921.GA17730@peff.net>
	<CACRoPnR=DSETucY78Xo0RNxHKkqDnTCYFvHsSzWAG7X7z3_DKQ@mail.gmail.com>
	<xmqq8ua1k7fc.fsf@gitster.dls.corp.google.com>
	<20150728164311.GA1948@yoshi.chippynet.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	Remi Lespinet <remi.lespinet@ensimag.grenoble-inp.fr>,
	Git List <git@vger.kernel.org>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 28 18:48:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZK834-0002Nn-3e
	for gcvg-git-2@plane.gmane.org; Tue, 28 Jul 2015 18:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbbG1QsJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Jul 2015 12:48:09 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34778 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564AbbG1QsI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Jul 2015 12:48:08 -0400
Received: by pacan13 with SMTP id an13so73941997pac.1
        for <git@vger.kernel.org>; Tue, 28 Jul 2015 09:48:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lStlt2BGMQRiZlfLsalcEiR73/w1zubJWmG390SFmpo=;
        b=EHT/WJmIjS/0ac3vE+Z9Zt0l4ua8f4uoQfuiPtvduwHd6AOsxFyUkh+gizMH4petuX
         nk6FmpmCEKTt5LzPyTaIhrQPWawR8JgztbW5VVkWVsuqhbaX9nVUHe5MMknLswjI6qYL
         b+SBIgaXgp6ZI1UGE6rN9d6812Hv4ZbwEZCK+DbUgOaChHiM5m2XBiVZzCEbv2EfvIiS
         M8aZV+WFxKASb9Rr6LZZJlbJOdisxoI8WFBfZklUzqdSknNzXvhLNLwHK0VrTdXnwJmM
         DX4Ljcqg+aeDxaE2MetvjIQ5dKrTeXPKinL1MPNV8SW6hMW0v5N9zHyX2LYSNttQoiBJ
         zUCw==
X-Received: by 10.66.63.71 with SMTP id e7mr81261564pas.57.1438102087792;
        Tue, 28 Jul 2015 09:48:07 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e592:68fd:3f1d:35f9])
        by smtp.gmail.com with ESMTPSA id c5sm36115067pds.87.2015.07.28.09.48.06
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 Jul 2015 09:48:07 -0700 (PDT)
In-Reply-To: <20150728164311.GA1948@yoshi.chippynet.com> (Paul Tan's message
	of "Wed, 29 Jul 2015 00:43:11 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274790>

Paul Tan <pyokagan@gmail.com> writes:

> When resuming, git-am ignores command-line options. For instance, when a
> patch fails to apply with "git am patch", subsequently running "git am
> --3way patch" would not cause git-am to fall back on attempting a

The second one goes without any file argument, i.e. "git am -3".

> threeway merge. This occurs because by default the --3way option is
> saved as "false", and the saved am options are loaded after the
> command-line options are parsed, thus overwriting the command-line
> options when resuming.
>
> Fix this by moving the am_load() function call before parse_options(),
> so that command-line options will override the saved am options.

Makes sense.
