From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [RFC/PATCH] git-remote-mediawiki: reset private ref after
 non-dumb push
Date: Wed, 21 Aug 2013 14:48:17 -0500
Message-ID: <CAMP44s2u1edB3g9GK_kak3Nc-fe4TDBjFU_JqskBW+J0Q9BJrg@mail.gmail.com>
References: <1376400700-8863-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Wed Aug 21 21:48:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCEOF-0003nh-HJ
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 21:48:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752763Ab3HUTsT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 15:48:19 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:36116 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752672Ab3HUTsT (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 15:48:19 -0400
Received: by mail-la0-f46.google.com with SMTP id eh20so715522lab.19
        for <git@vger.kernel.org>; Wed, 21 Aug 2013 12:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=KapmAaN+kpiAhloo2NKSfYcNd1xD9yuXOFQM6nDmGug=;
        b=IeVOPJdcUHUbdQD7YyZ6Lv2p243AlwnN+JgbV5Od6ByplC6DFJQlHOy9rB+N2fhlcc
         sFp3ZwKV2tIXTJ+LOuvaKXobPm29scPUm5mUAC11vj+CEDvUOeq7jfozOa3tsAIqCDag
         N40WiykTAnFAKu0o01HCrxdRNJ0R+8N4hcXGMAzHSI0KHisKP0uKnDG6XQnm2/PIAudZ
         j19UTTs4E1CcJQ0W+SVpFdKg1A5vYJyxTZsaSMuC+w9UejGB5sWVVuFUl9IqXjX+F1SQ
         R9AMImLsmSmsLM50BR1vtyh6R/v54I9Ajz050WEntYFd1bhhyg+an+z8ok3OoNYlPBjp
         jhlA==
X-Received: by 10.112.143.3 with SMTP id sa3mr3598114lbb.12.1377114497610;
 Wed, 21 Aug 2013 12:48:17 -0700 (PDT)
Received: by 10.114.91.169 with HTTP; Wed, 21 Aug 2013 12:48:17 -0700 (PDT)
In-Reply-To: <1376400700-8863-1-git-send-email-Matthieu.Moy@imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232722>

On Tue, Aug 13, 2013 at 8:31 AM, Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
>
> Git-mediawiki's "dumb push" sends the local revisions to the remote wiki,
> but does not update the local metadata to reflect the push (hence, the
> next pull will have to re-import the exported revisions).
>
> The previous implementation was simply omitting the update to the private
> ref after a dumb push. This was broken by 664059fb62 (Felipe Contreras,
> Apr 17 2013, transport-helper: update remote helper namespace), which
> does an automatic update of the private ref (not just the
> remote-tracking) on push.
>
> This patch fixes git-remote-mediawiki to reset the private ref after the
> push is completed, cancelling the automatic update triggered by
> 664059fb62.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
> Felipe: Is this the right fix for git-remote-mediawiki? Any better idea?

Why not keep track of the revisions yourself? You can have file where
you store which was the last revision that was fetched.

-- 
Felipe Contreras
