From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 4/4] submodule: add more tests for recursive submodule behavior
Date: Thu, 24 Mar 2016 20:25:34 -0400
Message-ID: <CAPig+cS8NSDb=apvtLHQL-Ph=RB0CTashhZMnQ3DkcLfnzB9ww@mail.gmail.com>
References: <1458862468-12460-1-git-send-email-sbeller@google.com>
	<1458862468-12460-5-git-send-email-sbeller@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Jens Lehmann <Jens.Lehmann@web.de>,
	Jacob Keller <jacob.keller@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Fri Mar 25 01:25:43 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ajFZO-0000Ig-IZ
	for gcvg-git-2@plane.gmane.org; Fri, 25 Mar 2016 01:25:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752550AbcCYAZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 20:25:38 -0400
Received: from mail-vk0-f66.google.com ([209.85.213.66]:36339 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbcCYAZg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 20:25:36 -0400
Received: by mail-vk0-f66.google.com with SMTP id z68so6660373vkg.3
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 17:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=+GDhsv5TB1KEeqfv1C9Q9HG7/qe6ERnuEEzjQW28Tts=;
        b=PxYrpWmYZkBOaqpQcaG94aKp41X26emWhkKZDOeMFDmKR04rLY+vIWN+gz900MjEGf
         eJsJSjOMZc1AzxYO14SP+XKmO+lXsl/TK8yR8BH5mZ7dLGlKQANBqM+FSKErSMqCeal3
         0oI7ZII/cvOdpc9D5+MfaDG3HGxXfFIsQMcFcA9LM+xvMKyeJLzzswMYMoceLGE446Gb
         LCk59ikDnwarYPv/IvGEHxafoaYLPNWaPMjADxGP3FTRiCtb2+HKRe245lkktT4mnY01
         yQlgaqVpw7f9C9g+hmAch8fw7HTZdScMPZFN7XMSYbrH3NCVabqAI0VhJ4yPymWqxVcK
         xP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=+GDhsv5TB1KEeqfv1C9Q9HG7/qe6ERnuEEzjQW28Tts=;
        b=e+wFHtG8e/dLKQfuAOZc8IXWOo5oh//hU7GeiApLABc0u6ndqm/UX+GPxc1ZX2zFEY
         yGdTK4fDChvcm9BDA0ddcLH20ZnQOMtA689dWMx1EbOAZnEVWb3latVAp8qeu6M/tO6b
         n+tm1l+9yi4OelVV2jdqUMqixPCIVp228DIEy/QqaPUaOXZnqCNzZfkdR1Xo81uHyEOi
         Bgm36OTh57iBme4Ke5fAEtHY8Jmaf60DxaHS9KvWcozH/s2UZXphX01ZKZLhpb3PTLwR
         FVdLoc6kCfRLFVMHGCGTF7VcDVKZXQmeJrAGjKQqfezJtnZ2Nuc/psuHPHDT6dJw0RSv
         oxEQ==
X-Gm-Message-State: AD7BkJKBuI3nAEdy9IoMCuCa7cmGX8Y6WqUSLy7VoJItdp/m57kilFjvOrH0HVhZPszuEkyMgaC6DTWXtaNzKA==
X-Received: by 10.31.141.2 with SMTP id p2mr6185342vkd.37.1458865534798; Thu,
 24 Mar 2016 17:25:34 -0700 (PDT)
Received: by 10.31.62.203 with HTTP; Thu, 24 Mar 2016 17:25:34 -0700 (PDT)
In-Reply-To: <1458862468-12460-5-git-send-email-sbeller@google.com>
X-Google-Sender-Auth: 7cFlIG70nLwUf9qRqMCJgFd_Csw
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289834>

On Thu, Mar 24, 2016 at 7:34 PM, Stefan Beller <sbeller@google.com> wrote:
> This adds a test for "submodule update", wich calls "submodule update"

s/wich/which/

> from an untracked repository in the superproject. When doing creating

Grammo: "doing creating"

> the parent patch a similar test failed for "submodule sync", but
> all tests passed for "submodule update". It took me a long time
> to figure out this was a difference in test coverage instead of
> commands behaving differently. Let's improve the test coverage such
> to make it a better place.
>
> When trying to fix the issue in the parent patch I could get
> the test suite passing when removing the $@ argument from module_list
> in the sync command. This also indicates a low test coverage, so
> fix that.

These two paragraphs are almost entirely commentary, thus probably
belong below the "---" line. I'm having a difficult time trying to
decipher from this commit message what this patch is actually about.
Perhaps the commit message could do a better job explaining exactly
what shortcoming(s) it's addressing.

> Signed-off-by: Stefan Beller <sbeller@google.com>
> ---
> diff --git a/t/t7406-submodule-update.sh b/t/t7406-submodule-update.sh
> @@ -774,4 +774,16 @@ test_expect_success 'submodule update --recursive drops module name before recur
> +test_expect_success 'submodule update --recursive works from subdirectory' '
> +       (cd super2 &&
> +        (cd deeper/submodule/subsubmodule &&
> +         git checkout HEAD^
> +        ) &&

Maybe use -C and drop the sub-subshell:

    git -C deeper/submodule/subsubmodule checkout HEAD^

> +        mkdir untracked &&
> +        cd untracked &&
> +        git submodule update --recursive >actual &&
> +        test_i18ngrep "Submodule path .../deeper/submodule/subsubmodule.: checked out" actual
> +       )
> +'
