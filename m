From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [bug] assertion in 2.8.4 triggering on old-ish worktree
Date: Thu, 16 Jun 2016 17:02:02 +1200
Message-ID: <CAFOYHZArnE6vJ0U1zJAxytCBJJU5M-VtHbct6Qq4VPfw7-T-2A@mail.gmail.com>
References: <CAFOYHZDw-P0ST8WKoSVxBpbFCiACZpgiDPMfw5MRtFTMosO0rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: GIT <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jun 16 07:02:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bDPRS-0003Mv-IF
	for gcvg-git-2@plane.gmane.org; Thu, 16 Jun 2016 07:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbcFPFCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jun 2016 01:02:07 -0400
Received: from mail-io0-f176.google.com ([209.85.223.176]:35512 "EHLO
	mail-io0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750984AbcFPFCE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jun 2016 01:02:04 -0400
Received: by mail-io0-f176.google.com with SMTP id f30so31833846ioj.2
        for <git@vger.kernel.org>; Wed, 15 Jun 2016 22:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to;
        bh=omI+LCWEFXfNv5yMYGE9LgEns79DayBGVNiRSwUbCv0=;
        b=F717MtB/6uv9/m6kHiqRuOj0lcd5f8ZSz5XmDdx31GddmQi+Xk0aV09vMfpWoCKfdL
         g5Maii/XRTUhFqZyt3uwbcGOOhWYe3uw95FPLkpz9GrAYhHUy4sEpTz8ZaaOCEB1XpU+
         tI9v7B1HLKjJUAmqmmtNRLpOIdJ7p8ZCyF6GWOjyegHoSfKnIR6Tg/FVN8AHpLiGoH0v
         vFL6nLJ6c8sH48q2Gy7THjKEVhj4R//bC10Qcbke2lMvoXmdCkOH2+S7Qh1prisuef6m
         4f6LuTY0F6Kxne/JnYYrs9mbG1Rrzj67tXsQ0qqvRFRbZ/BwUAtqWeFHDkzVrY2mzzsY
         uaiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to;
        bh=omI+LCWEFXfNv5yMYGE9LgEns79DayBGVNiRSwUbCv0=;
        b=LQS3SIRxctBmnHixGbDc3yx/Sfg5jfhnnr/Y6YlK4C36RRGHFTGluCxXHScu9BHU9n
         MdoB6C9RH9zVPy2RoXMLliH29mMFYtEOdIgcl6fXbuqDFAsYZ6+/zp2YqCnlgEBKLfzm
         zgT/s8T/YiGMzB5xfHFzUWEKipGA6V1nyl608I6tl8oNXSqktnZsnNpXmAuFsclgp0IY
         ZBjqSiDZ2aDsJcei4WEunvBu4+AubSBC+Du90uS+uuBBpF0KXMT6c2ozP/yXL+GCI/LL
         wAqxieUDKLqbO0TFNUVM/uJqtQnZ9mkOjGKsn1YIpsae6A7hZbdF3YA3Gn16pFP+4kF5
         9rjg==
X-Gm-Message-State: ALyK8tLdFbWwBczzZP1TvHIVNSzSTxJcWxRvyqoTX/iFxTGxrmG7niSiGUUqU0nSATJWHuYdtMBEiCWAQIweFA==
X-Received: by 10.107.135.137 with SMTP id r9mr4865700ioi.133.1466053323198;
 Wed, 15 Jun 2016 22:02:03 -0700 (PDT)
Received: by 10.79.86.134 with HTTP; Wed, 15 Jun 2016 22:02:02 -0700 (PDT)
In-Reply-To: <CAFOYHZDw-P0ST8WKoSVxBpbFCiACZpgiDPMfw5MRtFTMosO0rg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297414>

On Thu, Jun 16, 2016 at 4:59 PM, Chris Packham <judge.packham@gmail.com> wrote:
> Hi All,
>
> I have the git-sh-prompt configured in my .bashrc today I visited an
> old worktree that I haven't really touched in a few years (sorry can't
> remember the git version I was using back then). I received the
> following output when changing to the directory
>
> git: pathspec.c:317: prefix_pathspec: Assertion `item->nowildcard_len
> <= item->len && item->prefix <= item->len' failed.
>
> I assume it's one of the git invocations in git-sh-prompt that's
> hitting the assertion. Any thoughts on what might be triggering it?
> Any debug I can gather?

A bit more info. The directory in question is a uninitialised
submodule. It doesn't trigger in the root of the parent project.
