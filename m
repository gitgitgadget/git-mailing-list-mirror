From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 18/83] builtin/apply: move 'numstat' global into 'struct apply_state'
Date: Mon, 25 Apr 2016 14:40:15 -0700
Message-ID: <CAGZ79kaCqfwgwngcqG5W0fe=SNOsp7nqtvWw=-xhZ60FBPpg+w@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
	<1461504863-15946-19-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 23:40:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auoEz-0000Tm-48
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 23:40:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbcDYVkS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 17:40:18 -0400
Received: from mail-io0-f177.google.com ([209.85.223.177]:36602 "EHLO
	mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965041AbcDYVkR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 17:40:17 -0400
Received: by mail-io0-f177.google.com with SMTP id u185so198525841iod.3
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 14:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=FXIOjg461Qk5TEV45LEFiIzSwElC7lMIi4tibme3IrA=;
        b=UEyuajHYUHDRdYBLpSatgEJt1oL4G9FTzI6JvyQGHSJjyM1YaWwTtrNlIBU+urheQU
         be+k9R3JuQ4VEMTC25hfekzqxP3g3UPk5FawMVSk+LDiWA1JhrGtannAAOL98AyQlSb1
         svVGSuBt48ODawrcomTHCEulx2InptZvTLLCZXe2QWyJBSjPMwuiyei9EKlGnOdSj7OT
         C7e9xZ1a+gbW5/9Etxl0ANDHAksMZxoxq8eW/7rzoMPAJiY38nq6MQUkctPAodld44mZ
         vt1Bw/jS2+bCLGFjrNlRuqpKYaogjr8K2IFSeIVErVJfajE+r6tQ6c5o6Redc2BfjU37
         x4Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=FXIOjg461Qk5TEV45LEFiIzSwElC7lMIi4tibme3IrA=;
        b=AiRysiS6zyiYUtBYXJ8Hm8SiiC/ICOS8onjzM+wI74SJSO7L40z3OM1taQhq4hZ+2e
         YqvqWtR78+S50eEczH38t8/X2h0AS128/mXfDw+3++aDva0jq8glZBGZMNmVMRrZ+yJb
         aLQ0sCI+v+NPsr9mQbWQATUs8j3H/6jgnjjC9pdqb9bKPvPMCqJ4/zCjkTsU48WjEz3+
         CAHm15XbOLUbyh+yttprOfE3KuDncFBOi3FQmhdafXHhgbcU0UMV12mcA3KtqBozC+xc
         hRm+9qzZhtaZXYleXROZIqVfW5QNytuqCUkBUuLhVfJoFGUXdwYV5qeLDPezWKHFIvVw
         a/4A==
X-Gm-Message-State: AOPr4FXSuUH5x2HabNJRUMybwcohQiX+rH8yeOfYN8L1v8wBZ7WxHJ1SdPI/7UEs0Z+xdg1cpLn7DYpsd4i3/HwS
X-Received: by 10.107.53.200 with SMTP id k69mr33163730ioo.174.1461620415864;
 Mon, 25 Apr 2016 14:40:15 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Mon, 25 Apr 2016 14:40:15 -0700 (PDT)
In-Reply-To: <1461504863-15946-19-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292569>

On Sun, Apr 24, 2016 at 6:33 AM, Christian Couder
<christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index d90948a..16d78f9 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -36,6 +36,9 @@ struct apply_state {
>         /* --stat does just a diffstat, and doesn't actually apply */
>         int diffstat;
>
> +       /* --numstat does numeric diffstat, and doesn't actually apply */
> +       int numstat;
> +
>         /*
>          *  --check turns on checking that the working tree matches the
>          *    files that are being modified, but doesn't apply the patch
> @@ -51,14 +54,12 @@ struct apply_state {
>  };
>
>  /*
> - *  --numstat does numeric diffstat, and doesn't actually apply
>   *  --index-info shows the old and new index info for paths if available.
>   */
>  static int newfd = -1;
>
>  static int state_p_value = 1;
>  static int p_value_known;
> -static int numstat;
>  static int summary;
>  static int apply = 1;
>  static int no_add;
> @@ -4500,7 +4501,7 @@ static int apply_patch(struct apply_state *state,
>         if (state->diffstat)
>                 stat_patch_list(list);
>
> -       if (numstat)
> +       if (state->numstat)
>                 numstat_patch_list(list);
>
>         if (summary)
> @@ -4598,7 +4599,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>                         N_("instead of applying the patch, output diffstat for the input")),
>                 OPT_NOOP_NOARG(0, "allow-binary-replacement"),
>                 OPT_NOOP_NOARG(0, "binary"),
> -               OPT_BOOL(0, "numstat", &numstat,
> +               OPT_BOOL(0, "numstat", &state.numstat,
>                         N_("show number of added and deleted lines in decimal notation")),
>                 OPT_BOOL(0, "summary", &summary,
>                         N_("instead of applying the patch, output a summary for the input")),
> @@ -4675,7 +4676,7 @@ int cmd_apply(int argc, const char **argv, const char *prefix_)
>         }
>         if (state.apply_with_reject)
>                 apply = state.apply_verbosely = 1;
> -       if (!force_apply && (state.diffstat || numstat || summary || state.check || fake_ancestor))
> +       if (!force_apply && (state.diffstat || state.numstat || summary || state.check || fake_ancestor))

Mental note: This patch is just doing a mechanical conversion, so it
is fine to check for many "state.FOOs" here.

However later we may want to move this out to a static oneliner like:

    static int really_apply(state *s) {
      return s->diffstat || s->numstat || ...;
    }

(with a better name obviously)


>                 apply = 0;
>         if (state.check_index && is_not_gitdir)
>                 die(_("--index outside a repository"));
> --
> 2.8.1.300.g5fed0c0
>
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
