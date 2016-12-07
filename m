Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F22921FBB0
	for <e@80x24.org>; Wed,  7 Dec 2016 10:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932090AbcLGKja (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 05:39:30 -0500
Received: from mail-io0-f194.google.com ([209.85.223.194]:33291 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752190AbcLGKj3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 05:39:29 -0500
Received: by mail-io0-f194.google.com with SMTP id j92so12831920ioi.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 02:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=o8nS+4frNPmYjRoMtofv5TGnZbEy2t9AJFTyAtrXG1M=;
        b=LrHL9MPFZopnbiLkwH6ZdPoK06Osf3ryzzNcm2i53erHb0u7Ur5aBcd23v1PD7BjTD
         gUqipidy7X8xU2choZQu5JSJ6tZThPOoPFNuK5VeeUXck4FL5sUsUeKwBoaO/sq8JQpN
         bz5n495SrwiDWsUO70MDEJKO+XY9nklgFaLBcalroYWrfodl4nN3p0TUn1Ut1CibFD5F
         hqEt+peIV6RFMFBwkK5kqexnjk4HmZiT47e5PzO+/+SOCm1WL4Hv2sjxOlWNafpLKp9s
         PXXQuYAWRYiw2GUIcUG/ymgfDc+QXpN50Gw9i1AQ4bbuhu6WcfJPF6x9d0Dd7a+wjfSY
         l4Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=o8nS+4frNPmYjRoMtofv5TGnZbEy2t9AJFTyAtrXG1M=;
        b=Jl9oGtViRWcbel+1DpRTTh+6oZYqVASDw5fnAH3s+M51wPUduvdy/W/ouC1cmEbgKx
         3eyocyqZh+9FMOPsB59YBVycQ3+BisjfcReg9qS6mJEtjQm9sJRHPjttO/iqCgQvGtSC
         /Z9cdIX2K8/vVoAwPsdb/D78q0+fX6RPuKXT5T8I3LYotmBwe0yrHEtAKIN6mrEBntVI
         r1Ukqu45sCh00Nzrx4i+52npiaZB7zx4df+WaZHdejdk7Saq4hbJuyBF/YLReyX16bID
         CHievPtPwMMM4fVrsRtKObyECK59YndOQTgpEasUsotd8bt9juO3F8zskVcc4F98l3yb
         aw1Q==
X-Gm-Message-State: AKaTC02kr1sIoZQiNgQAuXLe0p9ddRRdz0LgXnXmKTn9h8TVGtfG03O0wBilwPW01qAeay60GIkknJLQan3aIw==
X-Received: by 10.107.44.137 with SMTP id s131mr54999480ios.212.1481107163685;
 Wed, 07 Dec 2016 02:39:23 -0800 (PST)
MIME-Version: 1.0
Received: by 10.64.69.3 with HTTP; Wed, 7 Dec 2016 02:38:52 -0800 (PST)
In-Reply-To: <1481061106-117775-5-git-send-email-bmwill@google.com>
References: <1481061106-117775-1-git-send-email-bmwill@google.com> <1481061106-117775-5-git-send-email-bmwill@google.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Wed, 7 Dec 2016 17:38:52 +0700
Message-ID: <CACsJy8DELy5JsJmcyDtwT-O9qGa9+hR1UfcKWRY1cmCnTALixA@mail.gmail.com>
Subject: Re: [PATCH 04/17] ls-tree: convert show_recursive to use the pathspec
 struct interface
To:     Brandon Williams <bmwill@google.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 7, 2016 at 4:51 AM, Brandon Williams <bmwill@google.com> wrote:
> Convert 'show_recursive()' to use the pathspec struct interface from
> using the '_raw' entry in the pathspec struct.

Slightly off-topic (sorry, but you made me look at this code! :D),
could you update the magic_mask argument of parse_pathspec() in this
file to PATHSPEC_ALL_MAGIC & ~(PATHSPEC_FROMTOP | PATHSPEC_LITERAL)?
It makes sure all future magic will be caught as unsupported (and I
think Stefan is adding one, but understandably he did not find this
code).

I think it's in the spirit of renaming _raw to match too. By limiting
magic to fromtop and literal, we are sure match can only be path and
nothing else, which is good because this show_recursive can't handle
anything else either.

>
> Signed-off-by: Brandon Williams <bmwill@google.com>
> ---
>  builtin/ls-tree.c | 12 +++++-------
>  1 file changed, 5 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
> index 0e30d86..e0f4307 100644
> --- a/builtin/ls-tree.c
> +++ b/builtin/ls-tree.c
> @@ -31,21 +31,18 @@ static const  char * const ls_tree_usage[] = {
>
>  static int show_recursive(const char *base, int baselen, const char *pathname)
>  {
> -       const char **s;
> +       int i;
>
>         if (ls_options & LS_RECURSIVE)
>                 return 1;
>
> -       s = pathspec._raw;
> -       if (!s)
> +       if (!pathspec.nr)
>                 return 0;
>
> -       for (;;) {
> -               const char *spec = *s++;
> +       for (i = 0; i < pathspec.nr; i++) {
> +               const char *spec = pathspec.items[i].match;
>                 int len, speclen;
>
> -               if (!spec)
> -                       return 0;
>                 if (strncmp(base, spec, baselen))
>                         continue;
>                 len = strlen(pathname);
> @@ -59,6 +56,7 @@ static int show_recursive(const char *base, int baselen, const char *pathname)
>                         continue;
>                 return 1;
>         }
> +       return 0;
>  }
>
>  static int show_tree(const unsigned char *sha1, struct strbuf *base,
> --
> 2.8.0.rc3.226.g39d4020
>



-- 
Duy
