From: Daurnimator <quae@daurnimator.com>
Subject: Re: [PATCH v2] git-stash: Don't GPG sign when stashing changes
Date: Tue, 3 May 2016 09:56:44 +1000
Message-ID: <CAEnbY+cu9E8DYGcg8FoK37NGZXbhSKvzVwMpLUEspXRYpPUdaA@mail.gmail.com>
References: <00000150dddb0eeb-b77240fb-1b63-4676-ac4b-1220b8d011ca-000000@eu-west-1.amazonses.com>
	<01020154733c27e9-deaa7a20-1de6-416a-a7d4-3229854117eb-000000@eu-west-1.amazonses.com>
	<xmqqoa8oqg19.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Cameron Currie <me@cameroncurrie.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 01:56:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axNht-0000i0-6D
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 01:56:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbcEBX4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 May 2016 19:56:49 -0400
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34543 "EHLO
	mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932274AbcEBX4s (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 May 2016 19:56:48 -0400
Received: by mail-lf0-f65.google.com with SMTP id m101so343613lfi.1
        for <git@vger.kernel.org>; Mon, 02 May 2016 16:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=daurnimator.com; s=daurnimator;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=0r7NvFubidcU+kXzCURlulM9hFEsafFxjXhj8ZFd9zU=;
        b=a4WdxsFgW1vV9cYF+p3XF/cIpxWOtmdOOMHh8/wYAHd2pxp+SwLINQ8QOhJgYuCRVi
         A2/l9LagYeMlL2gtEr4iaJxBG+L3RMcyEamNbyL5z/Se5zrdogwUFoHWNe0Wc6N1JjJl
         HSJqPffMwcUe6nhIzVrdV68OKyPtwDwfC34ig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=0r7NvFubidcU+kXzCURlulM9hFEsafFxjXhj8ZFd9zU=;
        b=dBdO7/yD1e/Z8pwpY1NyQW6tvIN/jRKkDDkiI2YKICwDonREmwc76ACUpiREFYy/Ww
         kiAX+m4yizMj8Zd7Huy+EUYp87/TsVYayxsEBMRv4hXWAjjSrQyRFVmfC2g1YAEzr4bL
         EnOGG7KnMu8rKHsbON729S28cFj9ZlKiwBuwl4oyM0iIFzhp2rj2CCBmuCiNJIUU8mwL
         G0lnIq/e5qpPULB2WmU0iypGz62EMhuKpnYoL+aq8umwlX0oo2sW23rs9ITq+MzhrchA
         7cM9EP9kzcSle24MbG0ZrEYSk0yuXUCkkAzM+mxn/+ko+T9HFV6JgGsquleAyRW20cwh
         tgZw==
X-Gm-Message-State: AOPr4FX18jUUlbO7Kb2LXtfxDCNes0mTqvn/UmNNRW+wqd+wvVBHP7SXXyor2qCNmz7oPw==
X-Received: by 10.112.189.73 with SMTP id gg9mr13020604lbc.109.1462233406338;
        Mon, 02 May 2016 16:56:46 -0700 (PDT)
Received: from mail-lf0-f54.google.com (mail-lf0-f54.google.com. [209.85.215.54])
        by smtp.gmail.com with ESMTPSA id kl1sm93038lbc.35.2016.05.02.16.56.45
        for <git@vger.kernel.org>
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 02 May 2016 16:56:45 -0700 (PDT)
Received: by mail-lf0-f54.google.com with SMTP id m64so4073140lfd.1
        for <git@vger.kernel.org>; Mon, 02 May 2016 16:56:45 -0700 (PDT)
X-Received: by 10.25.15.228 with SMTP id 97mr17401833lfp.126.1462233404810;
 Mon, 02 May 2016 16:56:44 -0700 (PDT)
Received: by 10.25.141.10 with HTTP; Mon, 2 May 2016 16:56:44 -0700 (PDT)
In-Reply-To: <xmqqoa8oqg19.fsf@gitster.mtv.corp.google.com>
X-Gmail-Original-Message-ID: <CAEnbY+cu9E8DYGcg8FoK37NGZXbhSKvzVwMpLUEspXRYpPUdaA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293308>

On 3 May 2016 at 07:57, Junio C Hamano <gitster@pobox.com> wrote:
> I do not think this is particularly a good change.
>
> There are a few other in-tree users of "git commit-tree",
> e.g. quiltimport and filter-branch, and their users would be hurt
> the same way if they set commit.gpgsign in the configuration.

I agree quiltimport should not, but I think filter-branch possibly
should... at least for your *own* commits.
I often think of filter-branch as an "advanced" `git commit --amend`
