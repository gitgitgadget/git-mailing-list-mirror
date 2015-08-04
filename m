From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v4] clone: simplify string handling in guess_dir_name()
Date: Tue, 4 Aug 2015 09:31:18 +0200
Message-ID: <CAHGBnuMXkqhFUhen9tPfEsfFAHhbqMeFUxvePS_6A-TtMfZpzg@mail.gmail.com>
References: <CAHGBnuNLoNsxPK4YQ+HnT_q8F-HrVC_y9pZwB4G88jCq0-wCPg@mail.gmail.com>
	<0000014e740f7a8a-2c988a36-633e-4b30-8024-cb4a1de1a8a2-000000@eu-west-1.amazonses.com>
	<20150804043401.4494.43725@typhoon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Lukas Fleischer <lfleischer@lfos.de>
X-From: git-owner@vger.kernel.org Tue Aug 04 09:31:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZMWh1-0001tA-Ob
	for gcvg-git-2@plane.gmane.org; Tue, 04 Aug 2015 09:31:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754876AbbHDHbT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Aug 2015 03:31:19 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:34690 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754635AbbHDHbS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Aug 2015 03:31:18 -0400
Received: by ioea135 with SMTP id a135so8730733ioe.1
        for <git@vger.kernel.org>; Tue, 04 Aug 2015 00:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XjcpILX862eAfjlB92o6NEiYfiKSQxfq4bsDcsFuSoE=;
        b=k0yEfmMFeszdIf+aP6rslUCFYyhjNBgGKrQLYWF8T9NbbO1u9ahilpWsI+7AUOH8C2
         srvVvRgd5F8B9J2puQNVtBWtt7w2+bLf6IkQBT2GKrC8Ey9RMMk+dbZaPMIsAc03TSMw
         Fz7ZqMluikkLMZyo/USlqHnCYXKBFRT0vCksaaLgvTjwN7KTYPXsB5rdNWS8g5DqfG8g
         e15t2PvDcpvYeXOyDA2f6WQd1iLxfSjEMcpXUaYaf7zRQEqUszr+oWqm8m3IQWAQaAXi
         1Id/K6V4Rj2omrhVTdq5fHs1e5MpHMvOS47td/q2n/+NmIMJHMRWpVj88aVCX6Ejk/T2
         EYGw==
X-Received: by 10.107.170.77 with SMTP id t74mr2227765ioe.107.1438673478278;
 Tue, 04 Aug 2015 00:31:18 -0700 (PDT)
Received: by 10.107.4.205 with HTTP; Tue, 4 Aug 2015 00:31:18 -0700 (PDT)
In-Reply-To: <20150804043401.4494.43725@typhoon>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275239>

On Tue, Aug 4, 2015 at 6:34 AM, Lukas Fleischer <lfleischer@lfos.de> wrote:

> I am currently on vacation and cannot bisect or debug this but I am
> pretty confident that this patch changes the behaviour of directory name
> guessing. With Git 2.4.6, cloning http://foo.bar/foo.git/ results in a
> directory named foo and with Git 2.5.0, the resulting directory is
> called foo.git.
>
> Note how the end variable is decreased when the repository name ends
> with a slash but that isn't taken into account when simply using
> strip_suffix() later...
>
> Is this intended?

I did not intend this change in behavior, and I can confirm that
reverting my patch restores the original behavior. Thanks for bringing
this to my attention, I'll work on a patch.

-- 
Sebastian Schuberth
