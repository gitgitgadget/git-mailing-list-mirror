From: Paul Tan <pyokagan@gmail.com>
Subject: Re: [PATCH 00/14] Make git-pull a builtin
Date: Sat, 30 May 2015 16:00:42 +0800
Message-ID: <CACRoPnSCT58AYAvXuELX0eemdobPsHMkkJd3oLg8Sv_DxOf1CQ@mail.gmail.com>
References: <1431961571-20370-1-git-send-email-pyokagan@gmail.com>
	<xmqqh9r9bsji.fsf@gitster.dls.corp.google.com>
	<CACRoPnThv97e+f3ymuRCFB_u7_dbcOUcCtxUh6BmwDcUZMPjmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Stephen Robin <stephen.robin@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 30 10:00:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YybhR-00016K-AX
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 10:00:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757615AbbE3IAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 04:00:46 -0400
Received: from mail-la0-f41.google.com ([209.85.215.41]:36110 "EHLO
	mail-la0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbbE3IAn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 04:00:43 -0400
Received: by lagv1 with SMTP id v1so70498152lag.3
        for <git@vger.kernel.org>; Sat, 30 May 2015 01:00:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DKmau5evlFyvfEUg7E3mz0c6fIhsVYlriJxzgoGTzc8=;
        b=MPjl7EnEDlRirI9FCPifppvjKwjT+V1UFasz+ixJNq/Rg5EWeqdjQjxwqXOJFmU3Z+
         xKINwirz85hrsXoCsEbzTmQfhkdeHiYe//6OPTdVOhSHpEv0Vc4Oqk/fowgG7vRzsbjU
         vSxKvvMkktxlm90zPeKnmtDT8GQdnCNqry9aadLAcroOTQhNzJ1yRM8AY8qIc213sGbl
         5HRMH/y2smAzLNfBO+VwvIVLsnoYsIKmwGgRTSLZvsHr/P3g3bc5wnkj/ylLqUrmvqhz
         6uurMB84bg9TQhoWseyBmRXte80J3K4Qk/XL/QU35of27QVh6nBehL6aJ84XuiYwO4tu
         K2xw==
X-Received: by 10.112.171.101 with SMTP id at5mr2341784lbc.66.1432972842623;
 Sat, 30 May 2015 01:00:42 -0700 (PDT)
Received: by 10.112.74.133 with HTTP; Sat, 30 May 2015 01:00:42 -0700 (PDT)
In-Reply-To: <CACRoPnThv97e+f3ymuRCFB_u7_dbcOUcCtxUh6BmwDcUZMPjmA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270282>

On Sat, May 30, 2015 at 3:29 PM, Paul Tan <pyokagan@gmail.com> wrote:
> Hi,
> Okay, I'm trying this out in the next re-roll. I do agree that this
> patch series should not touch anything in t/ at all.
>
> One problem(?) is that putting builtins/pull.o in the BUILTIN_OBJS and
> leaving git-pull.sh in SCRIPT_SH in the Makefile will generate 2
> targets to ./git-pull (they will clobber each other). For GNU Make,
> the last defined target will win, so in this case it just happens that
> git-pull.sh will win because the build targets for the shell scripts
> are defined after the build targets for the builtins, so this works in
> our favor I guess.
>
> Regards,
> Paul

Just to add on, I just discovered that test-lib.sh unsets all GIT_*
environment variables "for repeatability", so the name
"GIT_USE_BUILTIN_PULL" cannot be used. I'm tempted to just add a
underscore just before the name ("_GIT_USE_BUILTIN_PULL") to work
around this, since it's just a temporary thing.

Thanks,
Paul
