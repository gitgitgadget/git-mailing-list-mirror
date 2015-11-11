From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH] http: fix some printf format warnings on 32-bit builds
Date: Wed, 11 Nov 2015 09:38:22 -0800
Message-ID: <CAGZ79kbOQk4S3T7b9Ay=NnXnVBhoNLxCKeE6wefhh5qC19+_yg@mail.gmail.com>
References: <56428A6A.5010406@ramsayjones.plus.com>
	<CAPig+cR+jXgw7+kUK9vrZxNbytwyK3gzgm1YPf_6s57_UxPaBA@mail.gmail.com>
	<CAGZ79kb1pDhcP+hN9+C0xK-VYKxfnhvj6a2Len6kOWgmv4+fmQ@mail.gmail.com>
	<5C9FC321-5B5E-47E6-9BCE-6CDAA41D6E54@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 18:38:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZwZLo-0005Zi-EN
	for gcvg-git-2@plane.gmane.org; Wed, 11 Nov 2015 18:38:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752323AbbKKRiY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2015 12:38:24 -0500
Received: from mail-yk0-f180.google.com ([209.85.160.180]:36675 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414AbbKKRiX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2015 12:38:23 -0500
Received: by ykdr82 with SMTP id r82so60516648ykd.3
        for <git@vger.kernel.org>; Wed, 11 Nov 2015 09:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=D/JY+xmwqWWwu2UuaftpTtkxguyOI4RIB668B220gpc=;
        b=cRyCN7mWIt5FdQ3vLRIk3SSQ8pKJDfXcIIU+PSgGDjXDENJpIEF5IIrWjmk31aR53X
         /R0wq5LVSTmnaYDcH6fdhlFrd0qF50NoDC1l44xgiku2NsFA8la11abRiUTuybEXm9jB
         42ekIPrdNP8Dj3pjqQzvzYWdMaLOplycq2FxiEHdrUxWL34rSuezERNezkn7JWKCEdmB
         i7aXYYyQeEfFwmjgeMcaEDPyXEvhVdEe+rrMB2Z0ootvQYkP9vkLavM4NaLWk4jLm4tV
         3wGmcISdMEMEi5w4DqKI/iMH/F+3f7LsbDuf1a5YYkR31ZnfptTH/xAbpzi8i697ftwk
         LTPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=D/JY+xmwqWWwu2UuaftpTtkxguyOI4RIB668B220gpc=;
        b=J2d5QdE/IAtSkDG6dYtE+TZE17EEJ4YcPxq10UTxxaiV0EoN76V/XYw3dIpWEazezD
         WYRnbMWQgNjOPlzM16Uw4MvJ8iaUjpUO3vQtylYl2SnkYJZBhO/2cKqeIbNTw8e253Xd
         69Lm4Z6Dm8beB/rbQC7luTpTALeB5nrSFAFU2uRzjdeqA/NxyAqNs3k1mK28g5hAG4L5
         20aLjVeUrU37pc/DVrtgugRoa/dsgkjbS4yobmFw11kRyVr7Jie0OxwEsxBt2k1Qbhxw
         WeO8vBrYF4vXnwI6KBk9S6/TCQEZYNjD/TE3dIMLwB2Gxd8TmAqgMEFhfC9CODvq4mjK
         oswg==
X-Gm-Message-State: ALoCoQm0mpfcQMLwbak2MxBZh9OeYVjwLtrDETJfRipH7NqSm3ju4lLoBpoMKda+YLG5LTxAHWqK
X-Received: by 10.129.75.131 with SMTP id y125mr12117076ywa.48.1447263502463;
 Wed, 11 Nov 2015 09:38:22 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Wed, 11 Nov 2015 09:38:22 -0800 (PST)
In-Reply-To: <5C9FC321-5B5E-47E6-9BCE-6CDAA41D6E54@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281171>

On Wed, Nov 11, 2015 at 12:02 AM, Lars Schneider
<larsxschneider@gmail.com> wrote:
>
> Unfortunately no. All their machines are 64-bit [1] and they have "no immediate plans to add this feature" [2].
> However, we could the following build configuration on a 64-bit machine:
>
> export CFLAGS="-m32"
> export LDFLAGS="-m32"
>
> I think then we could catch these kind of warnings. Do you see a downside with this approach?

I think that should do it.

Assuming their 64 bit means x86-64 architecture, we may want to prefer
-mx32, such that we can also test it?

>
> - Lars
>
> [1] http://docs.travis-ci.com/user/ci-environment/
> [2] https://github.com/travis-ci/travis-ci/issues/986
