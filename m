From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 67/83] builtin/apply: make build_fake_ancestor() return -1
 on error
Date: Mon, 2 May 2016 03:32:06 -0400
Message-ID: <CAPig+cSMLCg49O3tf=g2qDi-TUz-xsdW-ac_Eze9g=XsCKSSJA@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-68-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 02 09:32:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ax8L6-00057l-Cs
	for gcvg-git-2@plane.gmane.org; Mon, 02 May 2016 09:32:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753235AbcEBHcK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 03:32:10 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:33406 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752445AbcEBHcH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 03:32:07 -0400
Received: by mail-ig0-f196.google.com with SMTP id rc4so8492673igc.0
        for <git@vger.kernel.org>; Mon, 02 May 2016 00:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=oACbgrxRjSpYGgYvEitQ/hbFhQW4b1pAYb1NzOjon30=;
        b=ejXJKnTps6j7aN28OyuUhOUrYgDC4xnjePQVTKkyiWfbqwndPFAJoHE6Hb5GuqqYAI
         lfHOFIT51cNEr0Nbh5E0vqPWNDJxJ9PIu5pUh8PMzOjWz6D9gGEi43OVonJI5IgW4n7a
         2/o/x51GYpPRZJvMkH5WoL8BpBtizAekPlqB79xB3RcGwbyrwMdh3pG5imlkeugpOcgA
         VnzUj6BTt7D9u+C+jjei4oadWQWRbb69zjrP1OYtGZqAV7Mtd0tQ7Sl5C7O6znNe+Ica
         DReOjZV/Uvj2LzUyewXEvtqFLj6mj9zLXx+LCPOHC+e2iPmq2LGHNVUIRInVFNFPe7At
         +VBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=oACbgrxRjSpYGgYvEitQ/hbFhQW4b1pAYb1NzOjon30=;
        b=Osm2KxXp6KuvcY3EJi58DRZgtq6kf0xB1Zbbw3Do+pKT6RcqRZ7LVwy3sLFuIVwk47
         S2fD134/2vmAHEcBJDMVtgrLxOtz8x7bIrZ8l3oVWeHuEv326/lAEJYdP5GoFX5DqjK4
         qwm39z+Il3Zlp/RZ1R/0KuKB7t9Eaz70y5oJaIWmIu0nzy9lL5OqUpdOV1J296h8sPwP
         sxaDCFaavyikacsswJmxhXS02BVVAlHno6FgtgHd0qrc0yVedT1YvvDg2cna2zpvcJq5
         IxHtG+u9NV53cwlQ9hp7U2qRCVeiOnAqQWhODPtLuOo31oDbvWjRrMY+QxC8NXef3wDA
         UgLQ==
X-Gm-Message-State: AOPr4FV9GlrLWQ0K4Z2XTR+H7DehptWhu6f4P4s1iK0noavlYNssCfMUewa3GMIcGHz33UlWFCgyxdskgJ15zg==
X-Received: by 10.50.49.15 with SMTP id q15mr17672960ign.73.1462174326624;
 Mon, 02 May 2016 00:32:06 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 2 May 2016 00:32:06 -0700 (PDT)
In-Reply-To: <1461504863-15946-68-git-send-email-chriscool@tuxfamily.org>
X-Google-Sender-Auth: rnjJm-G9Dy6Hm9XKomoQbUlS9TE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293226>

On Sun, Apr 24, 2016 at 9:34 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/builtin/apply.c b/builtin/apply.c
> @@ -3913,31 +3913,34 @@ static void build_fake_ancestor(struct patch *list, const char *filename)
>                 ce = make_cache_entry(patch->old_mode, sha1, name, 0, 0);
>                 if (!ce)
> -                       die(_("make_cache_entry failed for path '%s'"), name);
> +                       return error(_("make_cache_entry failed for path '%s'"),
> +                                    name);
>                 if (add_index_entry(&result, ce, ADD_CACHE_OK_TO_ADD))
> -                       die ("Could not add %s to temporary index", name);
> +                       return error("Could not add %s to temporary index",
> +                                    name);

What happens to 'ce' here? Does it leak?

>         }
>
>         hold_lock_file_for_update(&lock, filename, LOCK_DIE_ON_ERROR);
>         if (write_locked_index(&result, &lock, COMMIT_LOCK))
> -               die ("Could not write temporary index to %s", filename);
> +               return error("Could not write temporary index to %s", filename);

What happens with 'result'? Does it need to be discarded?

>         discard_index(&result);
> +       return 0;
>  }
>
>  static void stat_patch_list(struct apply_state *state, struct patch *patch)
> @@ -4470,8 +4473,9 @@ static int apply_patch(struct apply_state *state,
>                 return 1;
>         }
>
> -       if (state->fake_ancestor)
> -               build_fake_ancestor(list, state->fake_ancestor);
> +       if (state->fake_ancestor &&
> +           build_fake_ancestor(list, state->fake_ancestor))
> +               return -1;

Same comment as earlier patches: Leaking 'list', 'buf', 'fn_table'.

>         if (state->diffstat)
>                 stat_patch_list(state, list);
