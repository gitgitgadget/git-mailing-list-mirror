From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 51/83] builtin/apply: make apply_patch() return -1 instead
 of die()ing
Date: Mon, 25 Apr 2016 21:20:11 -0400
Message-ID: <CAPig+cQTx3wyk0E-ZBaBYbjsXRqHPg1f6snZKGjWkrTq=fb6Vg@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-52-git-send-email-chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Tue Apr 26 03:20:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aurfn-0003r5-IU
	for gcvg-git-2@plane.gmane.org; Tue, 26 Apr 2016 03:20:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbcDZBUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 21:20:13 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:35842 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750843AbcDZBUM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 21:20:12 -0400
Received: by mail-ig0-f193.google.com with SMTP id c3so300680igl.3
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 18:20:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=m8fzNgG710PKj+G0Jbcrvw3YwgzgFj5VOYjsGKkXEbU=;
        b=chtWQupl1OauCxsZn6qWwExGJw9j1r1CNY9iVYRbAMQHG8dF4RhVCJ/JI/FFpK428x
         C9bH+3A8vzOkClYvcJE3yZhLMCV+cFDmMQTVKGdk8535eojEEIssMdFTc+5wQE2mfQEa
         I2Srs9D0bQA5BMP5SNL7R1MFgkR00jIKFZ3aRPzxV1uKfiUHitxrN4Kxv0J2fzeaZqbH
         trB/k9V4O9A8uRgDstAKhn+UQ5MSahNd06XPAI6xc2eNjU/gWDa5I+ezrBT4WMArTCma
         EiRXz4qAJIDhgAUX1S6LbyLStQfGgoyhDqPnOMNsbk4RRu6ARkSRusNqAyHC8ome4McY
         H49w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=m8fzNgG710PKj+G0Jbcrvw3YwgzgFj5VOYjsGKkXEbU=;
        b=BOzUrtghIeUL4NMzdG81+kgoFiNlcjNOq4EjAlzuvibpMEoqNg4ZlYOQR5Gd2mOQjb
         JrgABMFghU+LwU4XOauAHjOOlaBRYjTognglVmmugu9XtC2eAMvuJ8IjsNYfzHq5fwhm
         V+cXFWznittvxFR/2/mz1Bzkb9wlNkW3Ysj7YuvX2NDVZqYzDdiIwNgbQVYrz4PMTxz7
         VF5OC/KluyaHC1oEoVEIbMXnxd3Y7t6gb22ykwEU2sKlQof/uCE8OOX71PfS9m7BAtAO
         2YpnCsOIghiieY0KGM1QXt2aIea04WSWcS3NQc4HRx0lZuVgq5vBNG4djA0uMX9G453h
         EtrQ==
X-Gm-Message-State: AOPr4FXROKVQchyyCW0HGBsbLPNwsVs6pFI+rncV729U7H843DdiQfVddnPFoCvCPCNnIUCJBqgxU3LQPife9A==
X-Received: by 10.50.49.15 with SMTP id q15mr288607ign.73.1461633611623; Mon,
 25 Apr 2016 18:20:11 -0700 (PDT)
Received: by 10.79.139.4 with HTTP; Mon, 25 Apr 2016 18:20:11 -0700 (PDT)
In-Reply-To: <1461504863-15946-52-git-send-email-chriscool@tuxfamily.org>
X-Google-Sender-Auth: 3vAsOVjkrUlvs_TEWZd8cYW3mmw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292583>

On Sun, Apr 24, 2016 at 9:33 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> To libify `git apply` functionality we have to signal errors
> to the caller instead of die()ing.
>
> As a first step in this direction, let's make apply_patch() return
> -1 in case of errors instead of dying. For now its only caller
> apply_all_patches() will exit(1) when apply_patch() return -1.
>
> In a later patch, apply_all_patches() will return -1 too instead of
> exiting.
>
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
> diff --git a/builtin/apply.c b/builtin/apply.c
> @@ -4522,6 +4522,14 @@ static int write_out_results(struct apply_state *state, struct patch *list)
>  static int apply_patch(struct apply_state *state,
>                        int fd,
>                        const char *filename,
> @@ -4564,7 +4572,7 @@ static int apply_patch(struct apply_state *state,
>         }
>
>         if (!list && !skipped_patch)
> -               die(_("unrecognized input"));
> +               return error(_("unrecognized input"));
>
>         if (state->whitespace_error && (state->ws_error_action == die_on_ws_error))
>                 state->apply = 0;
> @@ -4575,19 +4583,17 @@ static int apply_patch(struct apply_state *state,
>                 hold_locked_index(state->lock_file, 1);
>         }
>
> -       if (state->check_index) {
> -               if (read_cache() < 0)
> -                       die(_("unable to read index file"));
> -       }
> +       if (state->check_index && read_cache() < 0)
> +               return error(_("unable to read index file"));
>
>         if ((state->check || state->apply) &&
>             check_patch_list(state, list) < 0 &&
>             !state->apply_with_reject)
> -               exit(1);
> +               return -1;
>
>         if (state->apply && write_out_results(state, list)) {
>                 if (state->apply_with_reject)
> -                       exit(1);
> +                       return -1;
>                 /* with --3way, we still need to write the index out */
>                 return 1;
>         }

Are these new 'returns' leaking 'list', 'buf', and 'fn_table' which
otherwise get released at the end of the function?
