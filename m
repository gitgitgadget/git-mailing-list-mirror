From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v1 1/4] git-gui: remove duplicate entries from
 .gitconfig's gui.recentrepo
Date: Mon, 14 Dec 2015 17:31:22 -0500
Message-ID: <CAPig+cQ8=WKwew5GNqyAPFuYJDgM+ae6rxaJQg=jhrxn61rNbQ@mail.gmail.com>
References: <3453668A49C94C2AA39911FC594AE151@PhilipOakley>
	<1450105743-2432-1-git-send-email-philipoakley@iee.org>
	<1450105743-2432-2-git-send-email-philipoakley@iee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Alexey Astakhov <asstv7@gmail.com>
To: Philip Oakley <philipoakley@iee.org>
X-From: git-owner@vger.kernel.org Mon Dec 14 23:31:34 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a8beW-00030e-Dc
	for gcvg-git-2@plane.gmane.org; Mon, 14 Dec 2015 23:31:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932724AbbLNWb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2015 17:31:28 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35389 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbbLNWbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2015 17:31:25 -0500
Received: by vkha189 with SMTP id a189so163823963vkh.2
        for <git@vger.kernel.org>; Mon, 14 Dec 2015 14:31:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=99dOo0BKNv0EZWB2iraRbpTl9FaQJRBdhLuMKh1IRYg=;
        b=I73x56wrr8B/nTOS1R4YzJnVoS6Mee9FWf2wXghZvIgznbvIIPDFMqgfgmnI+EnhE0
         dr1ILLPzxKQmDzoOZU2U6FsOM3HxvdItpyTuKiBRGBPwsUV9l0PgTfET9qg6ALyvrYLK
         BnVEGkMVtSL1JwU7B5eaJRR698XhasBQ3Bp2eC3EtlciHQjTTOyVImd3yfeeIp8EkTaO
         A6ZVNa0RXD8gd20dkeJIPcnZPFD+OyB4xbZWLW3maypnrgfhTXKwY3I62+M4BQhgR0DF
         GCrLZH0RxzsFUd2vLLZ0V2QW0gtEadZEjRd3iM1c8rHeAQKO9mof4N3i01TV/cx+h+1K
         SFWQ==
X-Received: by 10.31.56.18 with SMTP id f18mr23519002vka.19.1450132282533;
 Mon, 14 Dec 2015 14:31:22 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 14 Dec 2015 14:31:22 -0800 (PST)
In-Reply-To: <1450105743-2432-2-git-send-email-philipoakley@iee.org>
X-Google-Sender-Auth: jOGXDM_xQpqmFdbD3vBNmhFc9Bk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282430>

On Monday, December 14, 2015, Philip Oakley <philipoakley@iee.org> wrote:
> The git gui's recent repo list may become contaminated with duplicate
> entries. The git gui would barf when attempting to remove one entry.
> Remove them all - there is no option within 'git config' to selectively
> remove one of the entries.
>
> This issue was reported on the 'Git User' list
> (https://groups.google.com/forum/#!topic/git-users/msev4KsQGFc,
> Warning: gui.recentrepo has multiply values while executing).

s/multiply/multiple/

> On startup the gui checks that entries in the recentrepo list are still
> valid repos and deletes thoses that are not. If duplicate entries are

s/thoses/those/

> present the 'git config --unset' will barf and this prevents the gui

s/present the/present, then/

> from starting.
>
> Subsequent patches fix other parts of recentrepo logic used for syncing
> internal lists with the external .gitconfig.
>
> Reported-by: Alexey Astakhov <asstv7@gmail.com>
> Signed-off-by: Philip Oakley <philipoakley@iee.org>
> ---
> diff --git a/git-gui/lib/choose_repository.tcl b/git-gui/lib/choose_repository.tcl
> index 75d1da8..133ca0a 100644
> --- a/git-gui/lib/choose_repository.tcl
> +++ b/git-gui/lib/choose_repository.tcl
> @@ -247,7 +247,7 @@ proc _get_recentrepos {} {
>
>  proc _unset_recentrepo {p} {
>         regsub -all -- {([()\[\]{}\.^$+*?\\])} $p {\\\1} p
> -       git config --global --unset gui.recentrepo "^$p\$"
> +       git config --global --unset-all gui.recentrepo "^$p\$"
>         load_config 1
>  }
>
> --
> 2.5.2.windows.2
