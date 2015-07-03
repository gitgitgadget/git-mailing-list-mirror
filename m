From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 00/12] Improve git-am test coverage
Date: Fri, 3 Jul 2015 09:24:13 -0700
Message-ID: <CAGZ79kaisrdsguxrwMCr5TK9RQaGF-WgVE7d9_=s7GXELqYxXA@mail.gmail.com>
References: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Paul Tan <pyokagan@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 03 18:24:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZB3lE-0005Wv-Rr
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jul 2015 18:24:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755040AbbGCQYQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jul 2015 12:24:16 -0400
Received: from mail-yk0-f173.google.com ([209.85.160.173]:33747 "EHLO
	mail-yk0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932168AbbGCQYO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jul 2015 12:24:14 -0400
Received: by ykdv136 with SMTP id v136so99652970ykd.0
        for <git@vger.kernel.org>; Fri, 03 Jul 2015 09:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=TD0UTfiny8YZrKtq4ykGwiHcuni4UsN/1Xq7nInz37E=;
        b=NBSMs/mlmg5SPeoEqiq0QahTGdS8wXnZIk5wDs3kkPQTr5PXSrT6CMwgzAPl3Ra+hx
         bHZszg8TbVZh3LdpY8GZ5MC9gwzmTDAzaTwlgMCQgPXzCMUOK5ssKVu+znsXHzEb0hP7
         s5dLUSgFRTjZk0SbIFcHoHjEDSP8v0V1HI0IUMBTNiYniXAP0+dyB1DZzveAAm757gEt
         frba2qYlU6k+lITXbcqyeFxsohanUDQaNTLUacbU1sG3oCcHMI2jgnhx0JGXMgYWAFXT
         Qmeqc0bN5eJvk/8/5GEtUvdHvJpx0HvcMyJEErVPkgO3jzesbRA6m7fc/rC79X9CTdym
         Xy7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=TD0UTfiny8YZrKtq4ykGwiHcuni4UsN/1Xq7nInz37E=;
        b=M/TEZmIxSpHmRt/51MiCyg0gCfB0Xu9HoAg+PHyHFe3eZQXn6KddRPifGJ2Dhzp1Q6
         SjwJzYPI2kd6IWPr42h9WX8J+NDWE8F68ppcNZD1V0KIaqQmWvHEtWiVMksfe2rMVVK/
         W1K3vaR7EOkoezeuM0JhOrtzLAgUaE79AL0vAHH2HKJNzSnyP3pA0vrJmVo7oHKU78hn
         8GAWb22MkUjgZyEJomnPuBZ4mppoBVUnnPWdWGlNX0yzXoQGYsW6xDRC4CJ6YRtC0q7s
         c+XotccahpggQFrC9F0Mqrbubmgrz5WxGgybN6hmV2sTrYghsB+aDHDp225bbrXrRksk
         8dYg==
X-Gm-Message-State: ALoCoQnirM/TJcIlU2OCIRJSAPF1VxT4rGsIBQObni8s7xeFLFnTBgJix/wV8VveN2jQNSYAhv5p
X-Received: by 10.129.111.65 with SMTP id k62mr46524161ywc.88.1435940653756;
 Fri, 03 Jul 2015 09:24:13 -0700 (PDT)
Received: by 10.37.4.80 with HTTP; Fri, 3 Jul 2015 09:24:13 -0700 (PDT)
In-Reply-To: <1435861000-25278-1-git-send-email-pyokagan@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273295>

On Thu, Jul 2, 2015 at 11:16 AM, Paul Tan <pyokagan@gmail.com> wrote:
> Increase test coverage of git-am.sh to help prevent regressions that could arise
> from the rewrite of git-am.sh to C. This patch series, along with
> pt/am-foreign, improved test coverage as measured by kcov from 56.5%[1] to
> 67.3%[2].
>
> No tests for git-am's interactive mode, though, as test_terminal does not seem
> to attach a pseudo-tty to stdin(?), thus making git-am's "test -t 0" check fail.
>
> This is part of my GSoC project to rewrite git-am.sh to a C builtin[3].

The whole series looks good to me.

>
> [1] http://pyokagan.github.io/git/20150430132408-a75942b//kcov-merged/git-am.eb79278e.html
> [2] http://pyokagan.github.io/git/20150702173751-2fdae08//kcov-merged/git-am.eb79278e.html
> [3] https://gist.github.com/pyokagan/1b7b0d1f4dab6ba3cef1
>
>
> Paul Tan (12):
>   t4150: am.messageid really adds the message id
>   t4150: am fails if index is dirty
>   t4151: am --abort will keep dirty index intact
>   t4150: am refuses patches when paused
>   t4150: am --resolved fails if index has no changes
>   t4150: am --resolved fails if index has unmerged entries
>   t4150: am with applypatch-msg hook
>   t4150: am with pre-applypatch hook
>   t4150: am with post-applypatch hook
>   t4150: tests for am --[no-]scissors
>   t3418: non-interactive rebase --continue with rerere enabled
>   t3901: test git-am encoding conversion
>
>  t/t3418-rebase-continue.sh |  19 ++++
>  t/t3901-i18n-patch.sh      |  62 ++++++++++++
>  t/t4150-am.sh              | 228 +++++++++++++++++++++++++++++++++++++++++++++
>  t/t4151-am-abort.sh        |  15 +++
>  4 files changed, 324 insertions(+)
>
> --
> 2.5.0.rc1.81.gfe77482
>
