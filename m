From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 65/83] builtin/apply: make gitdiff_verify_name() return -1
 on error
Date: Mon, 25 Apr 2016 20:36:56 +0700
Message-ID: <CACsJy8ATSuijr9beSuJ7X51hsmFVCs7TKEYd3puoLPMtVjKZ9g@mail.gmail.com>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org> <1461504863-15946-66-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 25 15:37:33 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aughg-00072O-Sa
	for gcvg-git-2@plane.gmane.org; Mon, 25 Apr 2016 15:37:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932646AbcDYNh2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Apr 2016 09:37:28 -0400
Received: from mail-lb0-f175.google.com ([209.85.217.175]:36289 "EHLO
	mail-lb0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932379AbcDYNh2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Apr 2016 09:37:28 -0400
Received: by mail-lb0-f175.google.com with SMTP id ys16so78095558lbb.3
        for <git@vger.kernel.org>; Mon, 25 Apr 2016 06:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=i1SaZ9+KJku/vnMApNjoqdoD3PuOvlNssu8yC8YBYu8=;
        b=YghQIRTFhbRFvSn2UtqBc9SpB9kERILosFLGExy5HQcxn+RSRGWdPO4uj7TOU1JwHL
         Yh/qjWIoEsrYfyybelzaMNuNr+XdlXMshWmerhhWyXUddY0bOmhcNeYx947uYTEQKRN+
         6TK2lVueP0oniUwfplUDXinzfM8z09nWhyh/hPCaJ2id9zoQDGl02stpQ8CvKCN1IUKN
         amQIeGGqnWuYHD+baVPnoq8ujpm4mm4J+s/YnZMx3gLbCqNnrYZI2DlDT3EP7fZo84AR
         63oDnfsychStxaIXwwfsQehNeZhkXvIL53uFlYnL/J7UbtYMfRLuSMkGzhgv5eFkRYYU
         SM+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=i1SaZ9+KJku/vnMApNjoqdoD3PuOvlNssu8yC8YBYu8=;
        b=RU9bqSNA48rh7xbUjZHmhMko6egXpx0U07dOzYKO9m2//USvD3/m9ifFsj1KpNW/r6
         sEMB/E7lzd+kKf/e+jC8JmlfY9zzpX1WzARyAL6gkXkD4yjqXcnhKcBPIxJLXFiYZZ35
         mpQlRhKafZRCLzS+/K+o0+TqN7ztQnfQx92wsbvw40whBWpesxTsBslusyxdDDXE9VOF
         OCGQ2UoJmOMUtMrBMHhbiNSQAUG2lbfgbxZseqLzpnv7fTbV6V6ybUzVeST8b7954Rr5
         vQNL7Gc/FDALp3huPfK9HMQJug1GnsFlPjQr5H4XNHgGT8JMFXEMG6VZq2dFaPsEZ6V/
         zi8g==
X-Gm-Message-State: AOPr4FVrU8vv148eaBFCYBFPc/QqYNeG51ZId/RfGlMYdJ2vxDjmV4LuzlpPy+DPL0/uGcnwTWqkEFZ4GcjltA==
X-Received: by 10.112.22.131 with SMTP id d3mr13990034lbf.145.1461591446429;
 Mon, 25 Apr 2016 06:37:26 -0700 (PDT)
Received: by 10.112.167.10 with HTTP; Mon, 25 Apr 2016 06:36:56 -0700 (PDT)
In-Reply-To: <1461504863-15946-66-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292477>

On Sun, Apr 24, 2016 at 8:34 PM, Christian Couder
<christian.couder@gmail.com> wrote:
> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
> ---
>  builtin/apply.c | 52 ++++++++++++++++++++++++++++++----------------------
>  1 file changed, 30 insertions(+), 22 deletions(-)
>
> diff --git a/builtin/apply.c b/builtin/apply.c
> index 6b8ba2a..268356b 100644
> --- a/builtin/apply.c
> +++ b/builtin/apply.c
> @@ -812,7 +812,7 @@ static int gitdiff_hdrend(struct apply_state *state,
>                           const char *line,
>                           struct patch *patch)
>  {
> -       return -1;
> +       return 1;
>  }

These are in a function group that will be called as p->fn() in
parse_git_header(). Is it possible to isolate them in a separate
patch? This patch can follow after, which covers only
gitdiff_verify_name() returning -1 and its call sites.

>  static int gitdiff_oldmode(struct apply_state *state,
> @@ -1016,7 +1018,7 @@ static int gitdiff_unrecognized(struct apply_state *state,
>                                 const char *line,
>                                 struct patch *patch)
>  {
> -       return -1;
> +       return 1;
>  }
>
>  /*
> @@ -1248,9 +1250,13 @@ static int parse_git_header(struct apply_state *state,
>                 for (i = 0; i < ARRAY_SIZE(optable); i++) {
>                         const struct opentry *p = optable + i;
>                         int oplen = strlen(p->str);
> +                       int res;
>                         if (len < oplen || memcmp(p->str, line, oplen))
>                                 continue;
> -                       if (p->fn(state, line + oplen, patch) < 0)
> +                       res = p->fn(state, line + oplen, patch);
> +                       if (res < 0)
> +                               return -1;
> +                       if (res > 0)
>                                 return offset;
>                         break;
>                 }
-- 
Duy
