From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH/RFC/GSoC 00/17] A barebones git-rebase in C
Date: Mon, 14 Mar 2016 10:32:47 -0700
Message-ID: <CAGZ79kZw+y6G_Y+ZkRLK6a4CG5qycM_MJFRQoQccyq596L56kw@mail.gmail.com>
References: <1457779597-6918-1-git-send-email-pyokagan@gmail.com>
	<CACsJy8BmiqFJ1tN6-uAWqXMUyvGRdWP2DVfgwE56Y1K9KHCsfQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Paul Tan <pyokagan@gmail.com>, Git List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	sam.halliday@gmail.com
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 14 18:33:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afWMd-0003XC-IZ
	for gcvg-git-2@plane.gmane.org; Mon, 14 Mar 2016 18:33:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752675AbcCNRcu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Mar 2016 13:32:50 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:35817 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752399AbcCNRct (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Mar 2016 13:32:49 -0400
Received: by mail-io0-f181.google.com with SMTP id g203so231242651iof.2
        for <git@vger.kernel.org>; Mon, 14 Mar 2016 10:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=is084hzGdc3nyl+d6h00SEjP+e3wqqOspmgf8/NxOQ8=;
        b=gmXyfz3lHhZs6cqq/y4Did7AdnLaNoWc9cL1pIw1rE0DZrpW3egz2EXa+tFn5zc7JR
         SVdmzyZ/Qxq9E/+p9IyEsD7Smxvmx+e4d1wMt+OupVbhCta0J7Gjj7ZFeWKuCh0mQeSq
         FYkQxWkY99Jtqk9J1H8ysAtPCmjmPDwWDf/c5PXGcPb6apdmjhdMdS7WzvdRgqxjh0xC
         Y5lgwiHUsvjOFKD6zreg6mtxnkw4hrmJPmIc0PRdwFJCQxQMSm+uiDywUTvLAOMv2BTY
         B76Cukz2e55pknDpul78yrRv2Y7lzt+GwsqXdehySeSCppyPV2j/W2uiA7Dxjs21Rh9b
         a2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=is084hzGdc3nyl+d6h00SEjP+e3wqqOspmgf8/NxOQ8=;
        b=VTXhSh98OgmEmRhfkouaYywJiA7j/xGins7J6TQ1caZUg6W84ZwoePt3x498Y8kw9h
         hGRNJmQhURICXNO77Qkju8dj7AtjBrfwtPEJSMns7uoFB4/fkLQaHv008fV38ZQqlUUl
         PRH1rT5PxVZq9oLnC1ZdHpPuoF5wMNdU5Zsa/31Ls7veKXmUw4G/JpiNKGmwzCYw+9Ts
         HNMNzyclOkqYfnlnsYgfzVQZpemOibEbw3z1tD3fQYKg76RnIJ5jf/GBpHWMLNXZU54L
         tqFS9ErBtMgPTUHenM96L9qYJig3BsFws4yZDuejZKMBDbCkWQOTPh/L7xf3+4DwCuFv
         k+bQ==
X-Gm-Message-State: AD7BkJLeY1Y2zP7r/rk5HkfOKo/SgbcImPx/TNNxd1RI6BBLHBN8rUi7ooStmwuNkVHMGDaVYgv7H06yzgYp+o5Y
X-Received: by 10.107.167.80 with SMTP id q77mr28909329ioe.110.1457976767290;
 Mon, 14 Mar 2016 10:32:47 -0700 (PDT)
Received: by 10.107.58.6 with HTTP; Mon, 14 Mar 2016 10:32:47 -0700 (PDT)
In-Reply-To: <CACsJy8BmiqFJ1tN6-uAWqXMUyvGRdWP2DVfgwE56Y1K9KHCsfQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288792>

On Mon, Mar 14, 2016 at 5:15 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Mar 12, 2016 at 5:46 PM, Paul Tan <pyokagan@gmail.com> wrote:
>> So, we have around a 1.4x-1.8x speedup for Linux users, and a 1.7x-13x speedup
>> for Windows users. The annoying long delay before the interactive editor is
>> launched on Windows is gotten rid of, which I'm very happy about :-)
>
> Nice numbers :-) Sorry I can't look at your patches yet. Just a very
> minor comment from diffstat..
>
>>  rebase-am.c                        | 110 +++++++++++
>>  rebase-am.h                        |  22 +++
>>  rebase-common.c                    | 220 ++++++++++++++++++++++
>>  rebase-common.h                    |  48 +++++
>>  rebase-interactive.c               | 375 +++++++++++++++++++++++++++++++++++++
>>  rebase-interactive.h               |  33 ++++
>>  rebase-merge.c                     | 256 +++++++++++++++++++++++++
>>  rebase-merge.h                     |  28 +++
>>  rebase-todo.c                      | 251 +++++++++++++++++++++++++
>>  rebase-todo.h                      |  55 ++++++
>
> topdir is already very crowded. Maybe you could move all these files
> to "rebase" subdir.

or builtin/ (or even builtin/rebase) ?

I thought the toplevel being crowded is by design such that it doesn't
feel like a java project where each file has 5 directories for itself.

I'll look at the series later today.

Stefan

> --
> Duy
