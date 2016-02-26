From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v3 3/3] git: submodule honor -c credential.* from command line
Date: Fri, 26 Feb 2016 11:41:15 -0800
Message-ID: <CAGZ79kZnR3EsESCFdORq84awWnRZZ9A_+mcH_54ULZZJfD8xyQ@mail.gmail.com>
References: <1456514268-8241-1-git-send-email-jacob.e.keller@intel.com>
	<1456514268-8241-3-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	Mark Strapetz <marc.strapetz@syntevo.com>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Feb 26 20:41:23 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aZOGP-0002ag-4a
	for gcvg-git-2@plane.gmane.org; Fri, 26 Feb 2016 20:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423035AbcBZTlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Feb 2016 14:41:17 -0500
Received: from mail-ig0-f180.google.com ([209.85.213.180]:34179 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754904AbcBZTlQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Feb 2016 14:41:16 -0500
Received: by mail-ig0-f180.google.com with SMTP id g6so45794422igt.1
        for <git@vger.kernel.org>; Fri, 26 Feb 2016 11:41:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=H2Z8M2ibgLmo5jKMYtMi57//CsmoU3HQb2ReBwENSSU=;
        b=m0hHSQWvMo9N4PL95PN0vApJrLPyeMAhaD9YHbB9DyDwp13qO1vQjrN/Qcye7KdOy1
         v9p4gpms+YhW3LAhUMDb5C+5zVIq1I5Xu4lJjDZEeJNWK0lpncDgI8IntzIeECm2SA7X
         9lJTiNGhxdem5fJ24/zooZnVl2i9OxArho06Yl7pDeePp2ZZgwWLgRLUUdYBWsvgYuAI
         JiZlaDPV6WatEhNucV4MdJOnkefuA1ujd5RB8eebm26bB3guT892WVLQD4V/Lkx5uuXz
         ocUYidx/4vUjYqQRW3A5cgmN+vKgTJsbFuS9M8BrSsTfR4qLgjGTlzs2xD7GhRQ8oDrJ
         M90A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=H2Z8M2ibgLmo5jKMYtMi57//CsmoU3HQb2ReBwENSSU=;
        b=df11MZmbWPz2+bA9V9Og9vcsqhdnVDaRgpYPNOXOg80yD+fE062Gq72/BGvJUxoXwi
         8NELZXIOUIMzDVlpUO6+skU6gj16ea9Bfr2QmQ3Z3heMsCieUwhoN6SKaBUInb4tDer/
         8nDpPDG38NKbs+4STAbbJBMHQGTVk5F2Iwc7FWHB1zEK3LiVUOK1NkPo6J94pSG/pCQZ
         1HTPPKTgknE03wuteco2EmRJNWOW+XsdIdGBN089WENPcPj8oEbW9+oe+N6YaDAiZu98
         qmS2AZxMjbPPaSjpK5q3shNqwKpKtYIRYScxcT2ot3BuDhVQAnt0eLzee7pSXLsQpea8
         LZFw==
X-Gm-Message-State: AD7BkJI5Q9K9Ke60N9Vpbu+Ft+8inU+N31jlq0cmTUIZnUbIC1YVHHDJrf5+Yv4RFVES0K9kkYGynYmIYV2FRHMo
X-Received: by 10.50.3.42 with SMTP id 10mr4503025igz.85.1456515675152; Fri,
 26 Feb 2016 11:41:15 -0800 (PST)
Received: by 10.107.58.6 with HTTP; Fri, 26 Feb 2016 11:41:15 -0800 (PST)
In-Reply-To: <1456514268-8241-3-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287613>

On Fri, Feb 26, 2016 at 11:17 AM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Due to the way that the git-submodule code works, it clears all local
> git environment variables before entering submodules. This is normally
> a good thing since we want to clear settings such as GIT_WORKTREE and
> other variables which would affect the operation of submodule commands.
> However, GIT_CONFIG_PARAMETERS is special, and we actually do want to
> preserve these settings. However, we do not want to preserve all
> configuration as many things should be left specific to the parent
> project.
>
> Add a git submodule--helper function, sanitize-config, which shall be
> used to sanitize GIT_CONFIG_PARAMETERS, removing all key/value pairs
> except a small subset that are known to be safe and necessary.
>
> Replace all the calls to clear_local_git_env with a wrapped function
> that filters GIT_CONFIG_PARAMETERS using the new helper and then
> restores it to the filtered subset after clearing the rest of the
> environment.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
>
> Notes:
>     - v2
>     * Clarify which paramaters are left after the sanitization, and don't seem to
>       indicate it is our goal to extend the list.
>     * add a comment in the submodule_config_ok function indicating the same
>
>     - v3
>     * Remove extraneous comments
>     * add strbuf_release calls
>     * rename sanitize_local_git_env
>     * remove use of local
>     * add C equivalent of sanitize_config
>     * add a test for the credential passing
>
>     - v3
>     * use argc check instead of empty options check
>     * fix brain-melting quotes in t7412-submodule--helper.sh

In the future, would you mind to try interdiffs in a cover letter?

(I do git diff HEAD...$(previousSeries) with previousSerier either
local branch or rather what Junio picked up already. There is also tbdiff,
which should be better and easier than this work flow)


> +                */
> +               strbuf_addstr(&quoted, var);
> +               strbuf_addch(&quoted, '=');
> +               strbuf_addstr(&quoted, value);

This could be `strbuf_addf("%s=%s", var, value);` (?)
which then gets quoted below

> +                       git_config_from_parameters(sanitize_submodule_config,
> +                                                  &sanitized_config);
> +                       argv_array_pushf(out, "%s=%s", *var, sanitized_config.buf);

like here?

> -                       subsha1=$(clear_local_git_env; cd "$sm_path" &&
> +                       subsha1=$(sanitize_submodule_env; cd "$sm_path" &&
>                                 git rev-parse --verify HEAD) ||

While at it, we could discuss if we want to replace the pattern cd
<somewhere> && git-command
by `git -C <somewhere> <command>` eventually (not in this patch) ?
