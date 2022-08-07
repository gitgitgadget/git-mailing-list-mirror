Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86FC8C19F2D
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 00:44:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbiHGAo4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Aug 2022 20:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiHGAoy (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Aug 2022 20:44:54 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1D6264FA
        for <git@vger.kernel.org>; Sat,  6 Aug 2022 17:44:53 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z2so7569950edc.1
        for <git@vger.kernel.org>; Sat, 06 Aug 2022 17:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=rg3Pgq6PMN5EWR6hNT4yqE9u3MCxgFxuzujXI36EPrc=;
        b=T3eJLr+YBp+x1ASI+chA1TNkfWgEulSpCdrIE2HjrcBtD7xLXTYyz8vu993mi7i/ec
         hjOmg/kvuVJ5zx39fZ7Eoul2piy8dPTSYzr5e98a6TEuQeY3FZDXs1Ir52/aZmvt6IJW
         ESpgk1gQkMYaQDsdv0R/CGOL/r3PsHTuWdw5Z3ZkN5JBxTk4X4xXrT6htKYRWMfG19UC
         2XowoFZ4h+Mv2z4EVvtfw5XeQgb18BcBpE3MjG3c17rqoMCdJHGWM3VSCsTcUtto2CiA
         aalneHP3GIfcGeM43xxq8bglT3hUVNVqPZxr3W3YQ/R1DU8Alcpwpe9pqUN0QXQMgpJt
         0nEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=rg3Pgq6PMN5EWR6hNT4yqE9u3MCxgFxuzujXI36EPrc=;
        b=XNo5XlTNKKk3M/tc8DI21oVXjQpqMn/xodXBE3kN3JpUBrgddK2qQVxNYFrtMwCq31
         dv6aUWe1A7816/fPl80ZfCGotsGPXqLuHVrRym8X90ubeoZC/7RH1US3ad0soz8VTfaC
         h6RHYoCRD2VGXugAk4wJ3kV9oC8Z6CAiI9stbf3kNI5ru6WpSNzRuu0tMbqdjW+NTJON
         MwoS/XyO+7QFJKKnqJ1s7c8V6F5fd8AHbO7E6BlbdUFNdiPt2ZDQRVmuo/geKD6QfJRX
         /sSc6VXN/ZxmcNXbCGhFU+yQqvbQGBWeCwNE2hNw9DjpdXHj6w01G0uClETmqVm2CZmo
         8VhA==
X-Gm-Message-State: ACgBeo3I8VFI4mSRqj5Tw2FVDPkCWry1+BQT1pzRDy+0x8VIO3L61DWR
        E3uXEUAgVKCn0NvwTH1iaP3vxZWMjf6ZyRN0WTUB/Z0a0bU=
X-Google-Smtp-Source: AA6agR7agrCL29P0FYmYHkb7z3JG/xjoF3AVD95uYhDCvTpbwu3xtMNyWQ86JimAvDHt/4uDac0EPmbz9gog2zwxSU8=
X-Received: by 2002:a05:6402:329b:b0:43d:bd4b:2f08 with SMTP id
 f27-20020a056402329b00b0043dbd4b2f08mr12442136eda.244.1659833092165; Sat, 06
 Aug 2022 17:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220802214134.681300-1-felipe.contreras@gmail.com>
 <Yu6V4cIajhoMhB3t@zacax395.localdomain> <CAMP44s1uPFGYVJ7dzf1pFXENnUjTTwxHye2iT_HPNiMcmPjD9A@mail.gmail.com>
 <Yu6zEiknXKFMJUVn@zacax395.localdomain> <CAMP44s3-RG5k4ZkhAFG_9JtbxcyDhkUmeBh0jCH9+Xwyumyu9w@mail.gmail.com>
 <Yu7byRmn4VtSpyWd@zacax395.localdomain>
In-Reply-To: <Yu7byRmn4VtSpyWd@zacax395.localdomain>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Sat, 6 Aug 2022 19:44:41 -0500
Message-ID: <CAMP44s39TW2nq+H7VHhFmXGQwFPs1-ZDm1XRcoFRzYJL+9RSvA@mail.gmail.com>
Subject: Re: [PATCH 0/2] mergetools: vimdiff3: fix regression
To:     Fernando Ramos <greenfoo@u92.eu>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 6, 2022 at 4:23 PM Fernando Ramos <greenfoo@u92.eu> wrote:
>
> On 22/08/06 02:17PM, Felipe Contreras wrote:
> >
> > I don't know why anyone would want to do that, but the code interprets
> > that as the user wanting '1b', which is completely ignored.
> >
> > If we are not going to care about these cases, we can just remove all this code:
> >
> > ...
> >
>
> Ah! I see now. You are completely right: it wouldn't make sense for anyone to
> specify "layout=LOCAL" (or REMOTE or BASE), but if he did *it wouldn't work*
> (only works with "layout=MERGED").
>
> That should be fixed. I'll update the patch with a new version to generate this
> command string:
>
>      echo | silent 4b | set hidden | let tmp=bufnr('%') | silent bufdo diffthis | exe 'buffer '.tmp
>                                      ^^^^^^^^^^^^^^^^^^                           ^^^^^^^^^^^^^^^^^
>                                      NEW                                          NEW

That's not correct: `exe 'buffer '.tmp` would be executed in every
buffer. To split the commands you need to do the bufdo in a separate
execute command.

> Notes:
>
>   - This is "easier" than moving "silent 4b" to the end, due to the way the
>     code is structured.

Which is a clear hint that the code should be restructured.

>   - I agree that this is absurdly complex for what we want to achieve with
>     "vimdiff3" but let's put it this way: now everything can be achieved with
>     the "layout" configuration option, even "useless" things such as setting it
>     to "LOCAL".

Yes, but even that can be achieved in simpler ways (see the patch below).

> > I understand the need if you want a complex layout, like
> > "MERGED+LOCAL,BASE,REMOTE", that's very nice, but if you just want
> > "MERGED", most of the code does nothing,
>
> With the fix above that shouldn't be a problem anymore: even if someone
> specifies "LOCAL" it will work, in an absurd way, but it will work :)

But the objective isn't to make "everything" work, the objective is to
make everything the user might reasonably want to work. If some
unreasonable use case can be supported with a minimal burden to
maintenance, sure, support that too.

"LOCAL" is not that: it's an unreasonable use case that requires a
bunch of extra code.

Either way, I think you are resisting too much a reshuffling of the
code when it's very clear the single window mode would benefit from
that since it doesn't need gen_cmd_aux() at all.

Here's a patch that shuffles the code around and makes it much easier
to read and maintain (plus it keeps and fixes the support for
unreasonable use cases like "LOCAL"):

(apologies in advance for gmail's possible wrapping)

--- a/mergetools/vimdiff
+++ b/mergetools/vimdiff
@@ -251,39 +251,34 @@ gen_cmd_aux () {
  return
  fi

+ # Shouldn't happen
+ echo "$CMD | echoerr 'BUG'"
+}

- # Step 4:
- #
- # If we reach this point, it means there are no separators and we just
- # need to print the command to display the specified buffer
-
- target=$(substring "$LAYOUT" "$start" "$(( end - start ))" | sed
's:[ @();|-]::g')
+get_buf () {
+ target=$(echo "$1" | sed 's:[ @();|-]::g')
+ buf="1"

  if test "$target" = "LOCAL"
  then
- CMD="$CMD | 1b"
+ buf="1"

  elif test "$target" = "BASE"
  then
- CMD="$CMD | 2b"
+ buf="2"

  elif test "$target" = "REMOTE"
  then
- CMD="$CMD | 3b"
+ buf="3"

  elif test "$target" = "MERGED"
  then
- CMD="$CMD | 4b"
-
- else
- CMD="$CMD | ERROR: >$target<"
+ buf="4"
  fi

- echo "$CMD"
- return
+ echo "$buf"
 }

-
 gen_cmd () {
  # This function returns (in global variable FINAL_CMD) the string that
  # you can use when invoking "vim" (as shown next) to obtain a given
@@ -315,6 +310,14 @@ gen_cmd () {

  LAYOUT=$1

+ # A single window is handled specially
+
+ if ! echo "$LAYOUT" | grep ",\|/" >/dev/null
+ then
+ buf=$(get_buf "$LAYOUT")
+ FINAL_CMD="-c \"set hidden | silent bufdo diffthis\" -c \"silent ${buf}b\""
+ return
+ fi

  # Search for a "@" in one of the files identifiers ("LOCAL", "BASE",
  # "REMOTE", "MERGED"). If not found, use "MERGE" as the default file
@@ -335,17 +338,7 @@ gen_cmd () {

  CMD=$(gen_cmd_aux "$LAYOUT")

-
- # Adjust the just obtained script depending on whether more than one
- # windows are visible or not
-
- if echo "$LAYOUT" | grep ",\|/" >/dev/null
- then
- CMD="$CMD | tabdo windo diffthis"
- else
- CMD="$CMD | bufdo diffthis"
- fi
-
+ CMD="$CMD | tabdo windo diffthis"

  # Add an extra "-c" option to move to the first tab (notice that we
  # can't simply append the command to the previous "-c" string as

-- 
Felipe Contreras
