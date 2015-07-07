From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 00/44] Make git-am a builtin
Date: Tue, 07 Jul 2015 11:52:23 -0700
Message-ID: <xmqqvbdv3imw.fsf@gitster.dls.corp.google.com>
References: <1436278862-2638-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 07 20:53:01 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZCXzI-0004Dw-PN
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jul 2015 20:53:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933537AbbGGSwh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jul 2015 14:52:37 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:35426 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933398AbbGGSw1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jul 2015 14:52:27 -0400
Received: by igcqs7 with SMTP id qs7so39578650igc.0
        for <git@vger.kernel.org>; Tue, 07 Jul 2015 11:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=HJN277yJ9K7uU/hLyJXIYkqXWC4AldTGzxpO5YIc5NI=;
        b=maqH3WrY1oN8ux8JgjOfvcgdHJfauRCSnKh6u6Y62moKxGWqo9f/hLsZljwhfql2p9
         FQCknjcFXfxHI3YhX1kAfUQLMeBCTkYvZVf6MzWils/EbwnUDyFeA/6k+VeJ2z44Frhb
         bkp5oVTn2dh7JeCCWHyLzZp7zKzGXFGBQFe2PLTece7Yw3SDOsHWfKOv38dGXkoOWXOP
         SIGGb0/2qZ1+Ki55PSDctknlfM/5j7Gn8EAHGFT/8x+znJ4wDrMZKwWqrdLd4YhKR+bl
         B1BL0dG/5gC1awV92m4BLNlrM51J0KrU/MM0LD1U8rDCccaF8yxxVfUTfo5gNx9/tKey
         FwQQ==
X-Received: by 10.107.164.196 with SMTP id d65mr9539771ioj.3.1436295146380;
        Tue, 07 Jul 2015 11:52:26 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:7d74:6f43:1e30:fb1d])
        by smtp.gmail.com with ESMTPSA id q187sm53215ioe.37.2015.07.07.11.52.24
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 07 Jul 2015 11:52:25 -0700 (PDT)
In-Reply-To: <1436278862-2638-1-git-send-email-pyokagan@gmail.com> (Paul Tan's
	message of "Tue, 7 Jul 2015 22:20:18 +0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273593>

Paul Tan <pyokagan@gmail.com> writes:

> This patch series depends on pt/pull-builtin.
>
> This is a re-roll of [v4]. Thanks Torsten, Stefan, Junio for the reviews last
> round. Interdiff below.
>
> Previous versions:
>
> [WIP v1] http://thread.gmane.org/gmane.comp.version-control.git/270048
> [WIP v2] http://thread.gmane.org/gmane.comp.version-control.git/271381
> [WIP v3] http://thread.gmane.org/gmane.comp.version-control.git/271967
> [v4] http://thread.gmane.org/gmane.comp.version-control.git/272876
>
> git-am is a commonly used command for applying a series of patches from a
> mailbox to the current branch. Currently, it is implemented by the shell script
> git-am.sh. However, compared to C, shell scripts have certain deficiencies:
> they need to spawn a lot of processes, introduce a lot of dependencies and
> cannot take advantage of git's internal caches.
>
> This patch series rewrites git-am.sh into optimized C builtin/am.c, and is
> part of my GSoC project to rewrite git-pull and git-am into C builtins[1].
>
> [1] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1

Is it really a rewrite into "optimized C", or just "C"?  I suspect
it is the latter.

This seems to apply cleanly to 'master' but fails to compile, as it
depends on some new stuff that are not even in 'next' yet, e.g.
argv_array_pushv() that is from pt/pull-builtin, and it does not
apply cleanly on top of that branch, either.

I'll see what's the cleanest way to queue this would be.  Perhaps
merge pt/builtin-pull on a copy of 'master' and then apply these, or
something like that.

Thanks.
