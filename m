From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 21/23] worktree: add: make -b/-B default to HEAD when <branch> is omitted
Date: Mon, 06 Jul 2015 12:14:54 -0700
Message-ID: <xmqqtwthyu6p.fsf@gitster.dls.corp.google.com>
References: <1435969052-540-1-git-send-email-sunshine@sunshineco.com>
	<1435969052-540-22-git-send-email-sunshine@sunshineco.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	Mark Levedahl <mlevedahl@gmail.com>,
	Mikael Magnusson <mikachu@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Jul 06 21:15:02 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCBr4-0001Oy-0c
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jul 2015 21:15:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754162AbbGFTO6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jul 2015 15:14:58 -0400
Received: from mail-ie0-f181.google.com ([209.85.223.181]:33719 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752130AbbGFTO4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jul 2015 15:14:56 -0400
Received: by ieqy10 with SMTP id y10so120261005ieq.0
        for <git@vger.kernel.org>; Mon, 06 Jul 2015 12:14:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=lTdijE+fNF5L5DCS5TKQWHYjfYOvFyl9ejAVCpU7ZVc=;
        b=XNMel24hMteL85R6X2cVZM6pzTuZW6TjlDUbVfQfKfFvqYHbcf4EWmBX3Hlyfr+3eq
         +8jzz5OVAPVy6gKkqv2L2LhLtquL9VUjZBBg5A7Es0YU+G6bxVdU7JWwNTKXo3m9lAI4
         wvG08HFZ/ONvnyIfazQyA+uRotwBLArZqjrznbu3hq/cNnbK65JqLzKakje7iAYuQu6Z
         pQbS0zL8Q8lhlAZPNeJq35QCD0gs1SwaginXJWKABUwtJM1KlpojfwcDzxgP0ATGmJdw
         s/l2MN4pxSA6yVcC+gjKwqTKxNrxeKWHfKVwSahoOKz7d2yorOXQxs6ujow02B9hsMu/
         lEMA==
X-Received: by 10.43.24.134 with SMTP id re6mr36287713icb.74.1436210095864;
        Mon, 06 Jul 2015 12:14:55 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ad70:2147:d1ba:ffd8])
        by mx.google.com with ESMTPSA id j3sm10242031igx.21.2015.07.06.12.14.55
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 06 Jul 2015 12:14:55 -0700 (PDT)
In-Reply-To: <1435969052-540-22-git-send-email-sunshine@sunshineco.com> (Eric
	Sunshine's message of "Fri, 3 Jul 2015 20:17:30 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273449>

Eric Sunshine <sunshine@sunshineco.com> writes:

> As a convenience, like "git branch" and "git checkout -b", make
> "git worktree add -b <newbranch> <path> <branch>" default to HEAD when
> <branch> is omitted.
>
> Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
> ---
>  Documentation/git-worktree.txt | 1 +
>  builtin/worktree.c             | 6 ++++--
>  t/t2025-worktree-add.sh        | 7 +++++++
>  3 files changed, 12 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-worktree.txt b/Documentation/git-worktree.txt
> index f6c3747..5ca11f6 100644
> --- a/Documentation/git-worktree.txt
> +++ b/Documentation/git-worktree.txt
> @@ -69,6 +69,7 @@ OPTIONS
>  -B <new-branch>::
>  	With `add`, create a new branch named `<new-branch>` starting at
>  	`<branch>`, and check out `<new-branch>` into the new worktree.
> +	If `<branch>` is omitted, it defaults to HEAD.

What would be the SYNOPSIS change to adjust for this, I wonder.

'git worktree add' [-f] [--detach] [-b <new-branch>] <path> [<branch>]

or something?  Can I omit <branch> without giving -b <new-branch>?
