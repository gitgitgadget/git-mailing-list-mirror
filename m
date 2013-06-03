From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH 1/6] prompt: don't scream continuation state
Date: Mon, 3 Jun 2013 15:17:27 +0530
Message-ID: <CALkWK0=LzUe0k7rWcrbiiTZNOOGg+=SsQB3u2F2ysjb5AJ=qZw@mail.gmail.com>
References: <1370181822-23450-1-git-send-email-artagnon@gmail.com>
 <1370181822-23450-2-git-send-email-artagnon@gmail.com> <87r4gjzi3d.fsf@linux-k42r.v.cablecom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>
To: Thomas Rast <trast@inf.ethz.ch>
X-From: git-owner@vger.kernel.org Mon Jun 03 11:48:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UjRN8-00072T-AI
	for gcvg-git-2@plane.gmane.org; Mon, 03 Jun 2013 11:48:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755566Ab3FCJsK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Jun 2013 05:48:10 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:65074 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751423Ab3FCJsI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Jun 2013 05:48:08 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so9963864iea.31
        for <git@vger.kernel.org>; Mon, 03 Jun 2013 02:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=QvbUGQtLlqqWBi1yqsdLVH8AE5qBCDSogSVywPZxEm0=;
        b=N+rMtIeENQ8GPYaLH2EYtkGlNPfD5ydZFgDZD8F4bOf91UmtyS8TcDtZXOu5CZIxrR
         LuTFszCGe4xKWWrYx2j9zn/IsZBVROQoS6QPCLPdimx8BPvLDexSHfejAqWsjyTskgQE
         oT54trZHxinVmYrI7vDfY9dcup4Wk22YYAaWHW4LgNASmzj5lZPr6eOJCAEC6E0V1l1l
         d1PHHkochU8aBiKWMRFauGFzQI4QRgeXEX7rZ+e6vg8HDsUai7ShmumkMsxM/rqbeNCq
         wLYq5B5OFqM2zI8aRO3SqG+KEd3w8tm9VnCo0S6jk5y07ew0u4PnqdKF2CbnTFc8LGTm
         xkyg==
X-Received: by 10.50.32.8 with SMTP id e8mr7496966igi.89.1370252888428; Mon,
 03 Jun 2013 02:48:08 -0700 (PDT)
Received: by 10.64.136.104 with HTTP; Mon, 3 Jun 2013 02:47:27 -0700 (PDT)
In-Reply-To: <87r4gjzi3d.fsf@linux-k42r.v.cablecom.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226209>

Thomas Rast wrote:
> Do you have other ways of distinguishing the branch and the state?
> Colors?  I'm a bit too lazy to check.  Perhaps it could be made to only
> use caps if not in colored mode?

Currently, no.   See git-prompt.sh:401, 403, 409; we don't have a
separate color for $r.  I didn't introduce a color in this series
because it would conflict with rr/zsh-color-prompt which is in pu: we
can introduce it after that graduates.  I was thinking yellow, since
that's not taken?

You really should use colors.  I don't think it's worth the extra
ugliness to scream in the no-color case.

As such, the prompt is a fine bikeshedding target.  I even introduced
GIT_PS1_SEPARATOR, because some people were unhappy with me stripping
one whitespace (yes, one).  If we go down the configurability road,
we'll either end up with a ton of environment variables, or be made to
write a generalized custom formatter which splices together tons of
arguments using color (super painful).  While I do agree that it is a
matter of taste, we have to make a few compromises for the sake of
sanity.
