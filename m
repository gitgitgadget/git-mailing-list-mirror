From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v7 03/12] revert/cherry-pick: add --quiet option
Date: Thu, 24 Apr 2014 18:48:55 -0400
Message-ID: <CALkWK0nETYdWpTYrNGE+au-b=jAXKy3FX6YOGo5s=v_UbnYtPA@mail.gmail.com>
References: <1398307491-21314-1-git-send-email-felipe.contreras@gmail.com> <1398307491-21314-4-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 25 00:49:56 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WdSSp-0004Cg-H1
	for gcvg-git-2@plane.gmane.org; Fri, 25 Apr 2014 00:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758248AbaDXWtr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Apr 2014 18:49:47 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:38157 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759101AbaDXWtg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Apr 2014 18:49:36 -0400
Received: by mail-ie0-f176.google.com with SMTP id rd18so2991572iec.7
        for <git@vger.kernel.org>; Thu, 24 Apr 2014 15:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=aapYyDDDGAIzaKcRKN3BJriJLDFpt4we2KiCV6/RJ4c=;
        b=r/RgOjRPQvZyLjx6YGSCtINPeOhmmq7e0ecM6fYbq3EYk5v3ETybnQVQySd9dK46bi
         TZoD8uy/v3EUzLJ/xiUy200812NXlpND8NPQxcNOiWepAkRGqr7MvhgZwswMWmMk3zqa
         hIqynjR0iaaz0wSVCU8SAnHKLsJTNLre6O+w3ndOo+6mSwV4cxd7OXlGU2A1dnZCBy4X
         HRimGNlHGe7yyiESdIupEH+hud2Lzv68rJ1wunc3p0E54cEkMj5fLLB5J1hFIiDYd0vq
         xrC/1EurXGYLNK1nte8ZaA53lqAGv2E03t63AYRNr7Yhzb79gMBCcFvoqkZRivULHSqA
         ec4g==
X-Received: by 10.50.43.170 with SMTP id x10mr1566199igl.36.1398379775167;
 Thu, 24 Apr 2014 15:49:35 -0700 (PDT)
Received: by 10.64.10.39 with HTTP; Thu, 24 Apr 2014 15:48:55 -0700 (PDT)
In-Reply-To: <1398307491-21314-4-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247018>

Felipe Contreras wrote:
> @@ -635,9 +637,10 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
>         }
>
>         if (opts->skip_empty && is_index_unchanged() == 1) {
> -               warning(_("skipping %s... %s"),
> -                       find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
> -                       msg.subject);
> +               if (!opts->quiet)
> +                       warning(_("skipping %s... %s"),
> +                               find_unique_abbrev(commit->object.sha1, DEFAULT_ABBREV),
> +                               msg.subject);

Personally, I don't see much value in inventing a new option for
suppressing one message.
