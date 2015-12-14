From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 4/4] git gui: allow for a long recentrepo list
Date: Mon, 14 Dec 2015 17:36:06 -0500
Message-ID: <CAPig+cSE41rHyq8hNcEL+qJaZrSwp0uc=Y6gPiRcj_T1EgQ4cg@mail.gmail.com>
References: <3453668A49C94C2AA39911FC594AE151@PhilipOakley>
	<1450105743-2432-1-git-send-email-philipoakley@iee.org>
	<1450105743-2432-5-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Alexey Astakhov <asstv7@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 23:36:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8bj5-0003vk-7Y
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 23:36:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932931AbbLNWgJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 17:36:09 -0500
Received: from mail-vk0-f45.google.com ([209.85.213.45]:34590 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932760AbbLNWgH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 17:36:07 -0500
Received: by vkgj66 with SMTP id j66so67615136vkg.1
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 14:36:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=4cXoOSMEXOXWwZX6ZQ8N683ONM++vtGGxZzyokRHB2M=;
        b=HUEZoVka0mJz6og9zTWT/WAM47KgKNEb/BLWC/0yy3qBKgR7PWE8QPhnw83PSfKWat
         g3288ovF/M6C4bBxHIrQ9qx7vpAxDAiowznM6R4F+RTCPS1oZPnfg+xaR7XCKt4gxsCa
         r9csiiug5gEcvw6ty8FhpM1guf0lEuKYqYuMnt092X0EER9ykygNz6RJxU5+IVEWWxyZ
         FEGU/CUw9OOHTZhm9QMNa+4Ye5PaEBLBsSParcrzknVKOgcWeKWxu08yFlUw0JR8OHiH
         7qemdK4uIMsvGJkWwiO3/1r7Ea1i6YgdN1OWFGmYXp5GNpdvFx4bVeCYp2+SzWLwowNY
         e5hQ==
X-Received: by 10.31.58.74 with SMTP id h71mr26726619vka.151.1450132566848;
 Mon, 14 Dec 2015 14:36:06 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 14 Dec 2015 14:36:06 -0800 (PST)
In-Reply-To: <1450105743-2432-5-git-send-email-philipoakley@iee.org>
X-Google-Sender-Auth: DGrORhCeqbMzGO6Xd42fhTe7iic
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282432>

On Mon, Dec 14, 2015 at 10:09 AM, Philip Oakley <philipoakley@iee.org> wrote:
> The gui.recentrepo list may be longer than the maxrecent setting.
> Allow extra space to show any extra entries.
>
> In an ideal world, the git gui would limit the number of entries
> to the maxrecent setting, however the recentrepo config list may
> have been extended outwith the gui, or the maxrecent setting changed

s/outwith/without/

> to a reduced value. Further, when testing the gui's recentrepo
> logic it is useful to show these extra, but valid, entries.
>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
> diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
> index ad7a888..a08ed4f 100644
> --- a/git-gui/lib/choose_repository.tcl
> +++ b/git-gui/lib/choose_repository.tcl
> @@ -153,7 +153,7 @@ constructor pick {} {
>                         -background [get_bg_color $w_body.recentlabel] \
>                         -wrap none \
>                         -width 50 \
> -                       -height $maxrecent
> +                       -height [expr {$maxrecent + 5}]
>                 $w_recentlist tag conf link \
>                         -foreground blue \
>                         -underline 1
> --
> 2.5.2.windows.2
