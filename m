From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Fixed compilation with Visual Studio by including poll.h
Date: Fri, 20 Apr 2012 14:51:58 -0700
Message-ID: <xmqqty0ekr5t.fsf@junio.mtv.corp.google.com>
References: <4F91C8FF.7070402@tu-clausthal.de>
	<20120420204722.GD13103@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sven Strickroth <sven.strickroth@tu-clausthal.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 20 23:52:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SLLkO-0005VA-1F
	for gcvg-git-2@plane.gmane.org; Fri, 20 Apr 2012 23:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682Ab2DTVwB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Apr 2012 17:52:01 -0400
Received: from mail-qc0-f202.google.com ([209.85.216.202]:61995 "EHLO
	mail-qc0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755574Ab2DTVv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Apr 2012 17:51:59 -0400
Received: by qcsp5 with SMTP id p5so1159005qcs.1
        for <git@vger.kernel.org>; Fri, 20 Apr 2012 14:51:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:x-gm-message-state;
        bh=f3vx3nunYrks7TX1WR7fOcC5daoEK/2gRxgjAf9/MQI=;
        b=Vny9pE/b30PSBPpN1dEkruPT67uW1ypbwAR0RwqCPTq7JjKA28iBnSmlFUzJPTCD/U
         Mmz0fM4hbKCSJWXvKPbAk/2ekI/UT/kfebCnYczdc+FS4GEUPUS3ub1ihQPfkiYK1V9p
         N1VNBhBU6Q8m8l76jK7KaN6UG5/zirKwqgjQ9ySFwOXlVdWX94axopekif2StcbudVI1
         KTrefBdfcCT7D8CbUEhk9DdOIMH4i9tkM9ol7xD0o1vcd5gM53MZ1omUD/994KdacXdS
         GVRkYqeUMSvdcoPj19vO0w2f/Wx1HmhB5D5AGsRy/Fwiy+nQQ7aamjX3jQuTliMDM9/W
         eM3Q==
Received: by 10.100.76.4 with SMTP id y4mr2782991ana.21.1334958719091;
        Fri, 20 Apr 2012 14:51:59 -0700 (PDT)
Received: by 10.100.76.4 with SMTP id y4mr2782976ana.21.1334958718970;
        Fri, 20 Apr 2012 14:51:58 -0700 (PDT)
Received: from wpzn3.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id d65si5308997yhn.3.2012.04.20.14.51.58
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 20 Apr 2012 14:51:58 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn3.hot.corp.google.com (Postfix) with ESMTP id D7FF71001D4;
	Fri, 20 Apr 2012 14:51:58 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 81E6EE120A; Fri, 20 Apr 2012 14:51:58 -0700 (PDT)
In-Reply-To: <20120420204722.GD13103@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 20 Apr 2012 13:47:23 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmeoHPurdmQqt9xgH1Zlim+t6+/b4Bj22ofpERHwwQjpFclU46jSzO5LjdogMTOBATUh2zUvdBfOfuOGhaeJYoBF+n2GpF/RNsMSi2jsimgYO00q0eoB83+RIqHUCWuOicoSMu4iKr4a/S6OOw9gHOVKbWab0vbzlg7Db29zsUV0kGsq5k=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196028>

Jeff King <peff@peff.net> writes:

> On Fri, Apr 20, 2012 at 10:37:19PM +0200, Sven Strickroth wrote:
>
>> upload-archive.c and upload-pack.c use pollfd struct and POLLIN constant
>> which are defined in poll.h. However, poll.h is not included.
>
> This should already be included by git-compat-util.h:

Thanks for a bit of sanity.

>   $ grep -C1 poll.h git-compat-util.h
>   #ifndef NO_SYS_POLL_H
>   #include <sys/poll.h>
>   #else
>   #include <poll.h>
>   #endif
>
> It looks like we will prefer sys/poll.h if it exists. The official XSI
> location is "poll.h", but I guess in practice they are equivalent on
> most systems if you have both (certainly on Linux, poll.h just includes
> sys/poll.h).

There actually is no preference between the two from _our_ side. It is
up to the builder to know and define necessary make variables.

> Does your environments have a sys/poll.h that exists isn't sufficient to
> use poll? Maybe we need to tweak git-compat-util to include both if they
> both exist.

Both?  I guess, but I suspect that on most sane systems one would
include the other if there are both provided (iow, just so that you can
complile sources written both for XSI and for systems in the field).
