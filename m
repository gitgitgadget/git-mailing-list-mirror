From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 3/8] merge-recursive: -Xindex-only to leave worktree unchanged
Date: Sun, 23 Feb 2014 04:07:40 -0500
Message-ID: <CAPig+cSWhbunMtQ8=sXqwR7Ps+c0DY2SqVKpu_draaieSJrEPA@mail.gmail.com>
References: <cover.1393059605.git.tr@thomasrast.ch>
	<2e56b258bca6cf83c322da4be85c42c7b54f6a3e.1393059605.git.tr@thomasrast.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Thomas Rast <trast@inf.ethz.ch>
To: Thomas Rast <tr@thomasrast.ch>
X-From: git-owner@vger.kernel.org Sun Feb 23 10:08:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHV2V-0005e4-US
	for gcvg-git-2@plane.gmane.org; Sun, 23 Feb 2014 10:08:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750884AbaBWJHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Feb 2014 04:07:45 -0500
Received: from mail-yk0-f170.google.com ([209.85.160.170]:41217 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750759AbaBWJHl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Feb 2014 04:07:41 -0500
Received: by mail-yk0-f170.google.com with SMTP id 9so11061375ykp.1
        for <git@vger.kernel.org>; Sun, 23 Feb 2014 01:07:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=pzprjDyW7fCNUCvL3MqdCV12eKvb0rU5e6pGAaj9Bdk=;
        b=kaq41OPinGSUN5djDx1G3XF+ozCtKz0pbNMt4ckfjhF/Bi0jnequL445OMEoWnPdRP
         Rfyh+kLQNaNpwCa8K6+KeecPHeoEbIAe/IK18wohUeqoK3UjT0F+njeSyZBU0+tddllW
         EQt6Pm1cGhPXRlia+N9MSSa2tnWR/QamcDm98Rd/I1mrXksKj5KKY9cjqaTi0K/0wBVo
         yNaK6xqF92t+BEfI2X2kdkL7n7sAA3xzwkS2L/BtC0QusRQ/6wQV1bOz0ayaAgbcY6ai
         SzK3w6xNCC1tukuXrnGVUUPNZKvBguZdldrSZ4/qYiIa2X2tyfYjMwyK5ZbNXpBrUB4D
         U1SQ==
X-Received: by 10.236.7.231 with SMTP id 67mr22770294yhp.30.1393146460532;
 Sun, 23 Feb 2014 01:07:40 -0800 (PST)
Received: by 10.170.180.195 with HTTP; Sun, 23 Feb 2014 01:07:40 -0800 (PST)
In-Reply-To: <2e56b258bca6cf83c322da4be85c42c7b54f6a3e.1393059605.git.tr@thomasrast.ch>
X-Google-Sender-Auth: Bd728lsCWqCId508z7_MLI2tELk
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242538>

On Sat, Feb 22, 2014 at 4:17 AM, Thomas Rast <tr@thomasrast.ch> wrote:
> Using the new no_worktree flag from the previous commit, we can teach
> merge-recursive to leave the worktree untouched.  Expose this with a
> new strategy option so that scripts can use it.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
> diff --git a/Documentation/merge-strategies.txt b/Documentation/merge-strategies.txt
> index fb6e593..2934e99 100644
> --- a/Documentation/merge-strategies.txt
> +++ b/Documentation/merge-strategies.txt
> @@ -92,6 +92,10 @@ subtree[=<path>];;
>         is prefixed (or stripped from the beginning) to make the shape of
>         two trees to match.
>
> +index-only;;

s/;;/::/

> +       Write the merge result only to the index; do not touch the
> +       worktree.
> +
>  octopus::
>         This resolves cases with more than two heads, but refuses to do
>         a complex merge that needs manual resolution.  It is
