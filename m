Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C2FCB2013C
	for <e@80x24.org>; Wed, 15 Feb 2017 03:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751410AbdBODL2 (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Feb 2017 22:11:28 -0500
Received: from mail-ua0-f194.google.com ([209.85.217.194]:36409 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751328AbdBODL1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Feb 2017 22:11:27 -0500
Received: by mail-ua0-f194.google.com with SMTP id f2so12643181uaf.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2017 19:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Ov6QYirY9vhD9TNBpMjKsoiKn+9d2CrT5ICyZQk6i18=;
        b=B7ZAUgTc9atQujllVmxsKVMFrZ/ik2b4hPc4Wf1DOIWdYVtkddJBb98PmbQwLANdEF
         g17pyCHdnv33cZVW13ScngQ2Jj3F1HEDvV3aAo8ZTLeqhnq9hQyFxu0tiI12ek+XpBQV
         t5jKFxjR+EJlZmOWSv3Ey7dIDl0ujnWkudA9Pg7WpXMXHmEbij8ZWpi5eMXVihrHwgqV
         uS3mLEcZ2tn6HXVDK0HtTMhzTcYztifBPUFFme45HQrgVlY/GTi1Sj1hs9XfHsurmo4p
         AepInb6r7ks6cvIGNJcqZG0r7mzzf8bTmb5cOtaFU+xb0n07Vfqd2+UzStUdAR8DNxDY
         7LEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Ov6QYirY9vhD9TNBpMjKsoiKn+9d2CrT5ICyZQk6i18=;
        b=PhZcK98VMBPx4cskDgZk1CqLykY90Fvv5w9tzTYmCOtf1iZ06jFdXxqHi4G6cAy+dc
         bcfKaeo9IBRUHmCCFiuD0C1kpnP4Sc5/taqiDKHzXGbligdsQoYfxB9IKEcWEJ+W0slb
         5I808M7FP2GkIfGH35jKIyMXIvYBEXciHUUksvuqwPTIV3vwIPLJUdxiBWRoEm4fZ9aW
         H5upCXGEuzCgABolaHVescFj5vAsnNlf769tQTVBZ/yPq/KyMs43l3EQpwajUno/rOHt
         OxQRSO3ucZ5AD9MhC3UPKfnrr5OCiQDOQtBNsm3dsCAznYPUlF7IHd+pvbR99TwWCwcA
         MzWA==
X-Gm-Message-State: AMke39kdtJUYONW/F79on7+sJFI2P7TbXI0Whnqfp+wdCsrfcEWkscI7VdVzO4C5GYw2NbpksR+u8CmB53Vqcg==
X-Received: by 10.159.48.69 with SMTP id i5mr16839797uab.121.1487128286269;
 Tue, 14 Feb 2017 19:11:26 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.22.131 with HTTP; Tue, 14 Feb 2017 19:11:25 -0800 (PST)
In-Reply-To: <20170214212404.31469-2-cornelius.weig@tngtech.com>
References: <4f8a0aaa-4ce1-d4a6-d2e1-28aac7209c90@tngtech.com>
 <20170214212404.31469-1-cornelius.weig@tngtech.com> <20170214212404.31469-2-cornelius.weig@tngtech.com>
From:   =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Date:   Wed, 15 Feb 2017 04:11:25 +0100
Message-ID: <CAM0VKjkqdto83Qo8PVbxt-2r8prQguNbAtNELxj5AmJEgugC_Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] completion: checkout: complete paths when ref given
To:     Cornelius Weig <cornelius.weig@tngtech.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Richard Wagner <bitte.keine.werbung.einwerfen@googlemail.com>,
        j6t@kdbg.org
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 14, 2017 at 10:24 PM,  <cornelius.weig@tngtech.com> wrote:
> From: Cornelius Weig <cornelius.weig@tngtech.com>
>
> Git-checkout completes words starting with '--' as options and other
> words as refs. Even after specifying a ref, further words not starting
> with '--' are completed as refs, which is invalid for git-checkout.

Refs completion is never attempted for words after the disambiguating
double-dash.

Even when refs completion is attempted, if it is unsuccessful, i.e.
there is no ref that matches the current word to be completed, then
Bash falls back to standard filename completion.  No refs match
'./<TAB>'.

Furthermore, Bash performs filename completion on Alt-/ independently
from any completion function.

Granted, none of these will limit to only modified files...  But that
might be a good thing, see below.

> This commit ensures that after specifying a ref, further non-option
> words are completed as paths. Four cases are considered:
>
>  - If the word contains a ':', do not treat it as reference and use
>    regular revlist completion.
>  - If no ref is found on the command line, complete non-options as refs
>    as before.
>  - If the ref is HEAD or @, complete only with modified files because
>    checking out unmodified files is a noop.

Here you use "modified" in the 'ls-files --modified' sense, but that
doesn't include modifications already staged in the index, see below.

>    This case also applies if no ref is given, but '--' is present.
>  - If a ref other than HEAD or @ is found, offer only valid paths from
>    that revision.
>
> Note that one corner-case is not covered by the current implementation:
> if a refname contains a ':' and is followed by '--' the completion would
> not recognize the valid refname.

I'm not sure what you mean here.  Refnames can't contain ':'.

> Signed-off-by: Cornelius Weig <cornelius.weig@tngtech.com>
> ---
>  contrib/completion/git-completion.bash | 39 +++++++++++++++++++++++++++-------
>  1 file changed, 31 insertions(+), 8 deletions(-)
>
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index 4ab119d..df46f62 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -1068,7 +1068,7 @@ _git_bundle ()
>
>  _git_checkout ()
>  {
> -       __git_has_doubledash && return
> +       local i c=2 ref="" seen_double_dash=""
>
>         case "$cur" in
>         --conflict=*)
> @@ -1081,13 +1081,36 @@ _git_checkout ()
>                         "
>                 ;;
>         *)
> -               # check if --track, --no-track, or --no-guess was specified
> -               # if so, disable DWIM mode
> -               local flags="--track --no-track --no-guess" track=1
> -               if [ -n "$(__git_find_on_cmdline "$flags")" ]; then
> -                       track=''
> -               fi
> -               __gitcomp_nl "$(__git_refs '' $track)"
> +               while [ $c -lt $cword ]; do
> +                       i="${words[c]}"
> +                       case "$i" in
> +                       --) seen_double_dash=1 ;;
> +                       -*|?*:*) ;;
> +                       *) ref="$i"; break ;;

I haven't tried it, but this would trigger on e.g. 'git checkout -b
new-feature <TAB>', wouldn't it?

> +                       esac
> +                       ((c++))
> +               done
> +
> +               case "$ref,$seen_double_dash,$cur" in
> +               ,,*:*)
> +                   __git_complete_revlist_file
> +                   ;;
> +               ,,*)
> +                       # check for --track, --no-track, or --no-guess
> +                       # if so, disable DWIM mode
> +                       local flags="--track --no-track --no-guess" track=1
> +                       if [ -n "$(__git_find_on_cmdline "$flags")" ]; then
> +                               track=''
> +                       fi
> +                       __gitcomp_nl "$(__git_refs '' $track)"
> +                       ;;
> +               ,1,*|@,*|HEAD,*)
> +                       __git_complete_index_file "--modified"

What about

  $ echo "unintentional change" >>tracked-file && git add -u
  $ git rm important-file
  $ git checkout HEAD <TAB>

?  It seems it will offer neither 'tracked-file' nor 'important-file',
but I think it should offer both.


We have __git_complete_index_file() for a while now, but only use it
for commands that accept only --options and filenames, e.g. 'add',
'clean', 'rm'.  This would be the first case when we would use it for
a command that accept both refs and filenames.  Perhaps similar corner
cases and the easy ways to trigger filename completion are why no one
thought it's worth it.

> +                       ;;
> +               *)
> +                       __git_complete_tree_file "$ref" "$cur"

Well, here you could go all-in, and say that this should complete only
files that are different from the version in $ref, because checking
out files that are still the same is a noop :)

> +                       ;;
> +               esac
>                 ;;
>         esac
>  }
> --
> 2.10.2
>
