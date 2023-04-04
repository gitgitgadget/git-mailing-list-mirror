Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D079C761A6
	for <git@archiver.kernel.org>; Tue,  4 Apr 2023 09:47:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234009AbjDDJrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Apr 2023 05:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234198AbjDDJrC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Apr 2023 05:47:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1398130E6
        for <git@vger.kernel.org>; Tue,  4 Apr 2023 02:46:41 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id q102so29926523pjq.3
        for <git@vger.kernel.org>; Tue, 04 Apr 2023 02:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680601600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=3fg3kWa5Z5+ELBHczGfvmIFB2K7o2ZcD8Cg01o24ZY8=;
        b=bNdSH0kzbjRGO7bMxy9PbrEEeFi612+qdS0H7K3BWE2WP3mjn+ODaqBiy3G2icTxKN
         +id2i0tmzEbk9xljfIxjlKzeSZ7XcBo7LiWfY4HghlB8HkE+MDHle/Zv8wEX32c0me3W
         028K/WmctUQ/dbqOXOBaQnu6KTVtlEqsu0+ioqpeyZXYe1cR5I9yjNNLayhTbpCg6aat
         wXt8kYNyJt23zIA2fNyma73rIGV+cSaz9itSCddukb2Up4F2cLp1j0fEmeWCV+rnA70c
         IKJTzFfZ2Jzak4AaQ3z5JcgiBNySSd5jsaw8P95SsqKSrYm2VN3L7WcdO09kkEDoR/9p
         Gz9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680601600;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fg3kWa5Z5+ELBHczGfvmIFB2K7o2ZcD8Cg01o24ZY8=;
        b=5XXq0CAx6gSClWVrJfUh6OI13BFtVA+gdNRfb3V6fgH+5wXQaanl80iBurCKOB8VLF
         wRzySv1hMIAZte6JjaFiWejjtPClqvqx6CXU6L2IkpQLpebRcwR07UJvXK0PC7AIYSr8
         UHHxFxHT20gI56Eodzl/+IliHHEu2Az1vrqBB8hVU3w6SPqmMzjTnjA4pWH9Zy5U8cqJ
         O5Pcm/BJkFf3RGSY91S72bgYpXZBQgRXiPuOex2VK+glc1bckJHdAqQJDQ83WxnDKRzh
         dFB30ofUyKICehusoC+TFZzWt20yDFnRmCUXO8Io+0agnFXK+vM3gD1v6pE/VorPUIOj
         OkAw==
X-Gm-Message-State: AAQBX9dJckDlcK6SKV1s5rEfMmuXyKUe/NNywSx09uUkNxdQ/xl3BDhG
        AMqk/pTF0qGxfjKbJgwow2A=
X-Google-Smtp-Source: AKy350b5lAz020k6fCHJ8ZKFnlwtm8VP7i7MDU1RdGIJ1ygbMotl+aA+HfX4rRd/IxrPhvAoHdpOZA==
X-Received: by 2002:a17:902:e40c:b0:1a2:1c7:1c26 with SMTP id m12-20020a170902e40c00b001a201c71c26mr1964915ple.0.1680601600292;
        Tue, 04 Apr 2023 02:46:40 -0700 (PDT)
Received: from gmail.com ([172.56.185.138])
        by smtp.gmail.com with ESMTPSA id a19-20020a1709027d9300b0019e60c645b1sm7922751plm.305.2023.04.04.02.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 02:46:39 -0700 (PDT)
Date:   Tue, 4 Apr 2023 02:46:37 -0700
From:   David Aguilar <davvid@gmail.com>
To:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Tao Klerks <tao@klerks.biz>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4] mergetool: new config guiDefault supports
 auto-toggling gui by DISPLAY
Message-ID: <ZCvx/REMF69xkXJg@gmail.com>
References: <pull.1381.v3.git.1666076086910.gitgitgadget@gmail.com>
 <pull.1381.v4.git.1679153263217.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1381.v4.git.1679153263217.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 18, 2023 at 03:27:43PM +0000, Tao Klerks via GitGitGadget wrote:
> From: Tao Klerks <tao@klerks.biz>
> 
> When no merge.tool or diff.tool is configured or manually selected, the
> selection of a default tool is sensitive to the DISPLAY variable; in a
> GUI session a gui-specific tool will be proposed if found, and
> otherwise a terminal-based one. This "GUI-optimizing" behavior is
> important because a GUI can make a huge difference to a user's ability
> to understand and correctly complete a non-trivial conflicting merge.
> 
> Some time ago the merge.guitool and diff.guitool config options were
> introduced to enable users to configure both a GUI tool, and a non-GUI
> tool (with fallback if no GUI tool configured), in the same environment.
> 
> Unfortunately, the --gui argument introduced to support the selection of
> the guitool is still explicit. When using configured tools, there is no
> equivalent of the no-tool-configured "propose a GUI tool if we are in a GUI
> environment" behavior.

I'm not sure what problem this is solving. Please help me understand.
This commit seems to be talking about the behavior w.r.t. the DISPLAY
variable and also about automatically enabling `--gui` automatically.

Regarding `--gui`: Someone that configures `mergetool.guiDefault`
means that all of their invocations should be as-if they had written
`--gui` on the command-line.

So.. if you find that you always use `--gui` then why are
you not configuring `merge.tool` directly and instead configuring
`merge.guitool`?

The purpose of `--gui` is to provide an override for use by tools (such
as Git Cola) to execute an optional, 2nd merge tool separate from that
which the user might configure for command-line use.

This patch basically makes the `merge.tool` configuration useless, so I
don't understand why someone would want to configure this option rather
than just configuring `merge.tool` directly, leading to an overall
simpler and easier to understand system.

If we add this boolean then it becomes harder to understand.
I'm not sure it really provides any additional value to the user.

From my vantage point, the user is better off configuring `merge.tool`
directly rather than the tool becoming more complex.

That said, I probably don't understand and I'd be happy to be
enlightened.


> As proposed in <xmqqmtb8jsej.fsf@gitster.g>, introduce new configuration
> options, difftool.guiDefault and mergetool.guiDefault, supporting a special
> value "auto" which causes the corresponding tool or guitool to be selected
> depending on the presence of a non-empty DISPLAY value. Also support "true"
> to say "default to the guitool (unless --no-gui is passed on the
> commandline)", and "false" as the previous default behavior when these new
> configuration options are not specified.

The rationale here is slightly surprising to me as well.

Apparently the user cannot be bothered to configure `merge.tool`
(because we care about this DISPLAY behavior) yet the user is expected
to configure `merge.guiDefault` instead?

I think it'd be better to encourage users to go ahead and configure
`merge.tool`, but again, I'm probably missing context around why.


Small patch note below...


> diff --git a/git-difftool--helper.sh b/git-difftool--helper.sh
> index 992124cc67c..e4e820e6809 100755
> --- a/git-difftool--helper.sh
> +++ b/git-difftool--helper.sh
> @@ -75,6 +75,11 @@ then
>  		merge_tool="$GIT_DIFF_TOOL"
>  	else
>  		merge_tool="$(get_merge_tool)"
> +		subshell_exit_status=$?
> +		if test $subshell_exit_status -gt 1

Is exit status 1 special here?
Should this be "if test $subshell_exit_status != 0" instead?
-- 
David
