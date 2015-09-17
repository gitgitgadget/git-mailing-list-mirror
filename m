From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 01/10] strbuf: Add strbuf_read_noblock
Date: Thu, 17 Sep 2015 10:53:06 -0700
Message-ID: <CAGZ79kYKD6e=JmeFgbqHRmDAb1W3jraBayWHjA=-D+SXzubULw@mail.gmail.com>
References: <1442453948-9885-1-git-send-email-sbeller@google.com>
	<1442453948-9885-2-git-send-email-sbeller@google.com>
	<xmqqtwqtja6j.fsf@gitster.mtv.corp.google.com>
	<20150917163012.GB25837@sigill.intra.peff.net>
	<xmqq6139j84n.fsf@gitster.mtv.corp.google.com>
	<20150917171308.GA28046@sigill.intra.peff.net>
	<CAGZ79kaZOyqwbf+BpG2oPBBt5zj3=q-abk+F-HdkZPL3GzTzsw@mail.gmail.com>
	<20150917173536.GA28987@sigill.intra.peff.net>
	<CAGZ79kYnZr3nb_5n-5J0vCMi7xb91y-OkrAEq8-uH2PvzmkSmA@mail.gmail.com>
	<20150917175008.GA29601@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Vitali Lovich <vlovich@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Sep 17 19:53:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcdN1-0005GY-Qo
	for gcvg-git-2@plane.gmane.org; Thu, 17 Sep 2015 19:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752210AbbIQRxL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Sep 2015 13:53:11 -0400
Received: from mail-yk0-f180.google.com ([209.85.160.180]:33207 "EHLO
	mail-yk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752010AbbIQRxH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Sep 2015 13:53:07 -0400
Received: by ykft14 with SMTP id t14so24417865ykf.0
        for <git@vger.kernel.org>; Thu, 17 Sep 2015 10:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=tu343qs8QgWiULUNPRIU2Y7xgeCIB9b867C6JHXCrRQ=;
        b=f8H/2ulZ8MDNDcw5Ns/8pbtI83qhZ/ap0iQIhqW+2BsiDn+Rz8wSyKmW56OKS88x+o
         yOhWNsPyE4MVwvSYhhBK3gTRg2OiJAr8o4Gh+AU+xZ/hhnzkS1yO2+tZTNy2E1JUR2g4
         zDhuhOGi4qQ9Hce9Sn/1+/z/SXp3RtlQk3zUq1cipOJBM+UwE3Gftl+pmSHJ6LnajzpS
         9Tohz0pWvQvgA+RaGX/agtYlm2hjaglwp5kgCWDR2lYwWBJvMSPMhlSRacw362FF/4Gf
         R7eQ7w836pezS+Z8zCm3y6JzDTW6mVDJ1UqobWhdVgAiUu8TXcp98IknJB8eniD2xXUA
         MMiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=tu343qs8QgWiULUNPRIU2Y7xgeCIB9b867C6JHXCrRQ=;
        b=LkEgScIZjNaXTU2vqVDczI9X+Vmmk2a5a8rXxxHywtIygYZUC7PoFLH66pB7zh0j2P
         JwaFRCuqnn8kQ0s7AsUBIxi07WewZQhoQvur7Hvi6/7+lp/6M8vw2S09QXk1f73Qc417
         4Slnruc+WqwqJXb9ZDj62w7v14zZChq3S84mJcIwn8hbCq5da3iB0ibi3nlbSDW3MPna
         fibnOLi62wE6PSjgS6SQwMx73r/5XV2nXYezp77a2YjpUBY9G8ZalGcb8sBLXW0DQxtw
         LWp1mG+fyLQEyDPeNDyiM5dpavQ7QxSUwUyQ6KidgKB1MxIbwIKQfWkgkbjASHgCMs+T
         KkuQ==
X-Gm-Message-State: ALoCoQmWjS4udFJPCL02RN2DFgtgXWcMuKkrO2oIkds1PfPDaDbAEk+b3CH/A1v2ul8DBgfEPXGS
X-Received: by 10.170.196.201 with SMTP id n192mr509766yke.16.1442512386799;
 Thu, 17 Sep 2015 10:53:06 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Thu, 17 Sep 2015 10:53:06 -0700 (PDT)
In-Reply-To: <20150917175008.GA29601@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278153>

On Thu, Sep 17, 2015 at 10:50 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Sep 17, 2015 at 10:45:40AM -0700, Stefan Beller wrote:
>
>> > You _can_ loop on read until you hit EAGAIN, but I think in general you
>> > shouldn't; if you get a lot of input on this fd, you'll starve all of
>> > the other descriptors you're polling.  You're better off to read a
>> > finite amount from each descriptor, and then check again who is ready to
>> > read.
>>
>> That's what I do with the current implementation. Except it's not as clear and
>> concise as I patched it into the strbuf_read.
>
> Is it? I thought the implementation you posted bumped the existing
> strbuf_read to strbuf_buf_internal, including the loop. So as long as we
> are not getting EAGAIN, it will keep reading forever.

You'll get EAGAIN pretty fast though, as all you do is reading as fast
as you can.

> Actually not quite
> true, as any read shorter than 8192 bytes will cause us to jump out of
> the loop, too, but if we assume that the caller is feeding us data
> faster than we can read it, we'll never exit strbuf_read_nonblock() and
> serve any of the other descriptors.

I see the difference now. That makes sense.

>
> -Peff
