From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v5] checkout: add --progress option
Date: Sun, 1 Nov 2015 14:13:05 -0500
Message-ID: <CAPig+cTE=vhFf-wf9qd4EMt8agi5SneQ3efKi1DCrArEsii5GA@mail.gmail.com>
References: <1446401039-13848-1-git-send-email-eantoranz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 01 20:13:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsy4X-00088B-2i
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 20:13:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752741AbbKATNJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 14:13:09 -0500
Received: from mail-vk0-f49.google.com ([209.85.213.49]:33533 "EHLO
	mail-vk0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752506AbbKATNH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 14:13:07 -0500
Received: by vkgy127 with SMTP id y127so74545556vkg.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 11:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4ygGEVj44eBbSqCb3aq7aOAY+0TijFkv8nRlnaxEk+4=;
        b=jwDZMkef0wyq2BLsdRTs3Qni0KugSTjocT77ehCJugYVxG0ERxyOA1ZaI+HATJtdTD
         KEfJWkcclvTH+5d46bscqOoQEKQoO14L8bGt+8YkHU6qENtl6XlpW30DkoeQDjCqNSDE
         t2bFiYI8ER6lWjkKPVujKhs0ldMw1w3luiMtWoU2iWbzMsm9TB0q+FKu7HsrSROBjJeH
         FyJCXIZ5lxYYqvEo96bd2pEViWC2Gjkml0R5h5juRJMPiB7R8XmiN+wJtqNn8wGj5cZQ
         ci2ulMiB4o9xyjyAc1sJnnif1u5W+s2qttg5UZLTHynQoYykJH6iWFf88VzzJRF1GeZL
         /7KQ==
X-Received: by 10.31.163.85 with SMTP id m82mr11172368vke.19.1446405185691;
 Sun, 01 Nov 2015 11:13:05 -0800 (PST)
Received: by 10.31.159.204 with HTTP; Sun, 1 Nov 2015 11:13:05 -0800 (PST)
In-Reply-To: <1446401039-13848-1-git-send-email-eantoranz@gmail.com>
X-Google-Sender-Auth: gy89VgSGwrCuxIzb7tra3Oqfkh0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280653>

On Sun, Nov 1, 2015 at 1:03 PM, Edmundo Carmona Antoranz
<eantoranz@gmail.com> wrote:
> Under normal circumstances, and like other git commands,
> git checkout will write progress info to stderr if
> attached to a terminal. This option allows progress
> to be forced even if not using a terminal. Also,
> progress can be skipped if using option --no-progress.
>
> Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
> ---
> +       /*
> +        * Final processing of show_progress
> +        * - User selected --progress: show progress
> +        * - user selected --no-progress: skip progress
> +        * - User didn't specify:
> +        *     (check rules in order till finding the first matching one)
> +        *     - user selected --quiet: skip progress
> +        *     - stderr is connected to a terminal: show progress
> +        *     - fallback: skip progress
> +        */
> +       if (opts.show_progress < 0) {
> +               /* user didn't specify --[no-]progress */
> +               if (opts.quiet)
> +                       opts.show_progress = 0;
> +               else
> +                       opts.show_progress = isatty(2);
> +       }

Style-wise this looks better.

I'll assume that you simply overlooked the remainder of my v4 review
comments, so I'll merely provide a reference to them[1] rather than
repeating myself. If that assumption is incorrect, please do have the
courtesy to state that you disagree with review comments and to
explain your position, otherwise reviewers will feel that their
efforts are wasted.

Thanks.

[1]: http://article.gmane.org/gmane.comp.version-control.git/280641
