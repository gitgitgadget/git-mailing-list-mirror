Return-Path: <SRS0=gonI=3T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF89C35240
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 01:51:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8844F20716
	for <git@archiver.kernel.org>; Thu, 30 Jan 2020 01:51:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=atlassian-com.20150623.gappssmtp.com header.i=@atlassian-com.20150623.gappssmtp.com header.b="icigOKTN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727198AbgA3Bva (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jan 2020 20:51:30 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:35724 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727164AbgA3Bv3 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jan 2020 20:51:29 -0500
Received: by mail-il1-f195.google.com with SMTP id g12so1721403ild.2
        for <git@vger.kernel.org>; Wed, 29 Jan 2020 17:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=atlassian-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mSGTz2ejMY0/2hWMaWCB2v8QyYKXPCjE/qdqIgD4bZE=;
        b=icigOKTN0Rn2FDAy4VFoQw0y/Bmo1YKNgC3hDj1fWxn38ybhpBfbIJaqZTbao5tFQt
         yJJnHUHEQEEWPeNDdkcDs/rIFKypxh73CUYciFTHh0nd458T3K6gQyf4BWFQ5Qm6YEiW
         xd+bxwYm0T3G7vwgW2k52XH5Bs8BSIEdoDGofPogA7R1DPpBKcDOF2i5+XstE/oJmoO7
         HD23xBVuD/d97ZTGktolIcMyubJZdnqcOe+8FsNBIAqxuudtoagxRStdiMjhjLEeBOU4
         eRIbYgXhTbdYwVKznNhWFxRVy0tdLsT2QXgqCLdvnzAKL4w4ExDcx57GAxsubTjFDA1T
         ndAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mSGTz2ejMY0/2hWMaWCB2v8QyYKXPCjE/qdqIgD4bZE=;
        b=a9BgoZaw4H9vWt73Bo0Y0N4SKaTIWhGxhO7ATGRmeDbyu2J5rouH6oAGEMl/uTiWD2
         0nNk5j6fnFXtlI0Jamh62nkFW5QuYMjy/ay0MBYr2qdbDWgHP6/IQ1eNoqLpn5k57EQw
         LuC8HBK08FJQl4OVB5BJIyISsT9TK+5Hjz6m1p3Gx6myUdfGt7WRror2jAe9rqG+BC5m
         239FLaZic/DzV4aAW4+IW86XQLH0hDNmUZ5PAHtXOHve9GfXyHSXfaPn0Mo6wUZe+mI9
         6r89dcbCilS1KMC8H04Fo9pfxX+WriVg31Bw5aD3OIQfoyHhRh4L6/hxMGLpsi+tYyeI
         rGzA==
X-Gm-Message-State: APjAAAX+lu7vbSQ1YAAZXy9DLdmpUPo7O77I9Pp6Z+2fBUZud7y6A7mJ
        y49wP9JncqEbr3ZK+1DHPx+L1TOx8BeaPLNMPqdjdD/z
X-Google-Smtp-Source: APXvYqyUDq4zKxwcPEr9zQFYrrNMad/6XkYXiPbOikdavFIpHWFdoY30egv555JDSFa80MzWwyurCdWtbHPZB36jvPo=
X-Received: by 2002:a92:901:: with SMTP id y1mr2137571ilg.274.1580349089068;
 Wed, 29 Jan 2020 17:51:29 -0800 (PST)
MIME-Version: 1.0
References: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
In-Reply-To: <pull.698.git.git.1579555036314.gitgitgadget@gmail.com>
From:   Bryan Turner <bturner@atlassian.com>
Date:   Wed, 29 Jan 2020 17:51:18 -0800
Message-ID: <CAGyf7-FS8k4gXM-C+qhW8YNGKC57Gh-NY0hM0A08YoFDSETQzg@mail.gmail.com>
Subject: Re: [PATCH] git-p4: Add hook p4-pre-pedit-changelist
To:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Users <git@vger.kernel.org>, Ben Keene <seraphire@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 20, 2020 at 1:17 PM Ben Keene via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Ben Keene <seraphire@gmail.com>
>
> Add an additional hook to the git-p4 command to allow a hook to modify
> the text of the changelist prior to displaying the p4editor command.
>
> This hook will be called prior to checking for the flag
> "--prepare-p4-only".
>
> The hook is optional, if it does not exist, it will be skipped.
>
> The hook takes a single parameter, the filename of the temporary file
> that contains the P4 submit text.
>
> The hook should return a zero exit code on success or a non-zero exit
> code on failure.  If the hook returns a non-zero exit code, git-p4
> will revert the P4 edits by calling p4_revert(f) on each file that was
> flagged as edited and then it will return False so the calling method
> may continue as it does in existing failure cases.
>
> Signed-off-by: Ben Keene <seraphire@gmail.com>
> ---
>     git-p4: Add hook p4-pre-pedit-changelist
>
>     Our company's workflow requires that our P4 check-in messages have a
>     specific format. A helpful feature in the GIT-P4 program would be a hook
>     that occurs after the P4 change list is created but before it is
>     displayed in the editor that would allow an external program to possibly
>     edit the changelist text.
>
>     My suggestion for the hook name is p4-pre-edit-changelist.
>
>     It would take a single parameter, the full path of the temporary file.
>     If the hook returns a non-zero exit code, it would cancel the current P4
>     submit.
>
>     The hook should be optional.
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-698%2Fseraphire%2Fseraphire%2Fp4-hook-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-698/seraphire/seraphire/p4-hook-v1
> Pull-Request: https://github.com/git/git/pull/698
>
>  git-p4.py | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/git-p4.py b/git-p4.py
> index 40d9e7c594..1f8c7383df 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -2026,6 +2026,17 @@ def applyCommit(self, id):
>          tmpFile.write(submitTemplate)
>          tmpFile.close()
>
> +        # Run the pre-edit hook to allow programmatic update to the changelist
> +        hooks_path = gitConfig("core.hooksPath")
> +        if len(hooks_path) <= 0:
> +            hooks_path = os.path.join(os.environ.get("GIT_DIR", ".git"), "hooks")
> +
> +        hook_file = os.path.join(hooks_path, "p4-pre-edit-changelist")

The commit subject and the resulting email say "p4-pre-pedit", and I
see Junio is asking about "p4-pre-pedit", but the actual code, and the
scissors message, both say "p4-pre-edit". So which is it intended to
be? "edit", or "pedit"?

> +        if os.path.isfile(hook_file) and os.access(hook_file, os.X_OK) and subprocess.call([hook_file, fileName]) != 0:
> +            for f in editedFiles:
> +                p4_revert(f)
> +            return False
> +
>          if self.prepare_p4_only:
>              #
>              # Leave the p4 tree prepared, and the submit template around
>
> base-commit: 232378479ee6c66206d47a9be175e3a39682aea6
> --
> gitgitgadget
