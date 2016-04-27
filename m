From: Jacob Smith <jaroslov@gmail.com>
Subject: Re: BUG on OSX `git p4 submit` can fail when the workspace root
 doesn't exist locally.
Date: Wed, 27 Apr 2016 13:06:53 -0500
Message-ID: <CAMsgv2W7mtJpFf6A4MZs-Sbvdof8EdOOP+uiGYudH8LUjNRo8g@mail.gmail.com>
References: <CAMsgv2UXPkxpocjKhoR7HbmubSBnhJPJ3hMq9Jsk2AD0DoCifA@mail.gmail.com>
	<CAGZ79kZ6rx4UpPmeGjC8TyHKbVd+Y6i1JyEdDzKuF_9rj4c_7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 20:06:59 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avTrX-00017l-9p
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 20:06:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753065AbcD0SGz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 14:06:55 -0400
Received: from mail-lf0-f47.google.com ([209.85.215.47]:34436 "EHLO
	mail-lf0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752797AbcD0SGz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 14:06:55 -0400
Received: by mail-lf0-f47.google.com with SMTP id j11so66483603lfb.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 11:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=ld1jbiO6J6hFc6P3cWu/6uPNS/q3ygsVqDlgKBZjXW0=;
        b=cMoD1CTPA8vp/Kh1Y1UCd8++nPHAfv+M5sVVC/k6NJfZpvxFERXHd1A6Q0Tx+Qulct
         7U33I86kyTq9TkuyMdZyLDzqmCF6QqaoYjM9W3FTrf14Ntv2Lpdhz2J/EghOmn7Mj9BB
         8sir8ApNYkuBCFGdrhpt8/vQhE7Sp6PNKCU5ZkAO5821MDauBDKS2z+RtYfdwvsHDImB
         +xl2vvGwUgYYcid+a25Id4mxrRAkR8fF1PXt5JNK8kbDexnK4qabSw/rUkZWfb5FJ0wh
         htWFYHfG6Lr1HilwdIqdfiNVPxLCxEvsuqg6EkV6ZE/rMsXqZ8a/y9Y3EzlBc5/Mro8+
         +ITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=ld1jbiO6J6hFc6P3cWu/6uPNS/q3ygsVqDlgKBZjXW0=;
        b=hjvRLhz0YP1T8N5DLG4Brrk5O5dATiqLScITeX9VCqbwUK0dYpuNZR5bSucRuexK0S
         7Bg6aB8kUIzxzCX4y3t4FkVzta6OIS0PXp6cDRwHGxT8xGBz4RhHpcMY4If8XOGsLs3k
         mib7JkWk15SPnkxddUBESd1DAvPrWbwSItAMn+OYXliE8azktbNYxQy94K8Ell1jg0EU
         eC0etyoRX+irqwjjuexWc8riEoQssJYS39KyX1VBtRLUMVQBWbBukmRbBHHnlVNEBqf9
         RskpZmuaFgTEwI3elPSEFpV5/PEAKGqnoDcjdlOtrlGxeFJGJ4iqF6YfjnPZLLzwywRA
         +8PA==
X-Gm-Message-State: AOPr4FXSnSdKdsgGk0GA8Uut6Jg9osetW6z5DP59HGf9Dl5f6F45krdbDv5TMIDFsgSfHK8c9BGpjc/pKldUSw==
X-Received: by 10.112.63.196 with SMTP id i4mr4208262lbs.93.1461780413205;
 Wed, 27 Apr 2016 11:06:53 -0700 (PDT)
Received: by 10.25.21.37 with HTTP; Wed, 27 Apr 2016 11:06:53 -0700 (PDT)
In-Reply-To: <CAGZ79kZ6rx4UpPmeGjC8TyHKbVd+Y6i1JyEdDzKuF_9rj4c_7g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292779>

I debugged the issue using the script here:
    https://github.com/git/git/blob/master/git-p4.py
I'm not sure how close to the main repo that is.

On Wed, Apr 27, 2016 at 11:28 AM, Stefan Beller <sbeller@google.com> wrote:
> On Wed, Apr 27, 2016 at 9:15 AM, Jacob Smith <jaroslov@gmail.com> wrote:
>> On OS X,
>
> Do you use the Git as provided from OS X? In that case you better report the bug
> to Apple, as their version of Git is slightly different (not close on
> upstream, by both
> having additional patches as well as not following the upstream closely IIUC).
