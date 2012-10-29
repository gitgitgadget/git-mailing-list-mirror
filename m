From: Phil Hord <phil.hord@gmail.com>
Subject: Re: [PATCH v2] git-submodule add: Add -r/--record option.
Date: Mon, 29 Oct 2012 18:21:08 -0400
Message-ID: <CABURp0otR2S1aOAWwnaFYFGRi_2cCBODbghck-BqUTw2B_ci3A@mail.gmail.com>
References: <20121025005307.GE801@odin.tremily.us> <508D9A12.6010104@web.de>
 <CAJo=hJt_A5FCCcvR=sZ5Ni+-ZGq+MjxqkONbh9k+A46xBH9jzA@mail.gmail.com>
 <20121028223431.GF26675@odin.tremily.us> <20121029053401.GB30186@sigill.intra.peff.net>
 <20121029104544.GA2424@odin.tremily.us> <20121029105855.GA15075@sigill.intra.peff.net>
 <20121029112945.GD2424@odin.tremily.us> <20121029114310.GA16046@sigill.intra.peff.net>
 <CABURp0pFLi+2A+9wi-ZamiRze2u6z+6oyoCsNpWOLq_cq2L1rQ@mail.gmail.com> <20121029213652.GC20513@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: "W. Trevor King" <wking@tremily.us>,
	Shawn Pearce <spearce@spearce.org>,
	Jens Lehmann <Jens.Lehmann@web.de>, Git <git@vger.kernel.org>,
	Nahor <nahor.j+gmane@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Oct 29 23:21:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSxiP-00025S-H5
	for gcvg-git-2@plane.gmane.org; Mon, 29 Oct 2012 23:21:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933652Ab2J2WVc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Oct 2012 18:21:32 -0400
Received: from mail-lb0-f174.google.com ([209.85.217.174]:33889 "EHLO
	mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933561Ab2J2WVa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Oct 2012 18:21:30 -0400
Received: by mail-lb0-f174.google.com with SMTP id n3so3442525lbo.19
        for <git@vger.kernel.org>; Mon, 29 Oct 2012 15:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=LgdyIhubuzjmyTUjuvEHpAJboOKh/ueA3vDt2vFK2Ow=;
        b=LVS9Zv5jdEg5j78zH6G/pLGgTgnVyCjFaDsQFMG9VvO5GF+rTPeZpwZHsWCvJiXCYi
         gnAAquFN+44+S4E4ETJzfBKku+Ot3z1HOh9Ba9gPt6qLaDur1h0g4g7cIqYgwOHuF1wE
         Ph0JkpQlBsCf6zSJTnToGfAeXlEiQKwwEHqrHI1pUOTqYgguOa3ovml7fvzPJFZEmsWW
         9wxpKamOtEF3EdknnDYv9hL8iGDDcX9gQxRnH9pI7yjs4ptVjubNQzMO5dQfheIUrjCs
         Sznlr60JNZeVJrJh0HzAJ+KNQpu/hdWI/DeQrEWhIzMNVbqPhHRtQzpRoxr2CJH+B0W7
         8P9Q==
Received: by 10.112.102.230 with SMTP id fr6mr12372081lbb.112.1351549289026;
 Mon, 29 Oct 2012 15:21:29 -0700 (PDT)
Received: by 10.114.26.166 with HTTP; Mon, 29 Oct 2012 15:21:08 -0700 (PDT)
In-Reply-To: <20121029213652.GC20513@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208650>

On Mon, Oct 29, 2012 at 5:36 PM, Jeff King <peff@peff.net> wrote:
> On Mon, Oct 29, 2012 at 01:38:28PM -0400, Phil Hord wrote:
>
>> > I am not sure it is sufficient as-is, though. It does not seem to ever
>> > clear variables, only set them, which means that values could leak
>> > across iterations of the loop,  [...] E.g., when
>> > the first submodule has submodule.*.foo set but the second one does not,
>> > you will still end up with $submodule_foo set when you process the
>> > second one.
>>
>> Good point.  That should not happen.
>>
>> > or down to recursive calls.
>>
>> Frankly, I consider that to be a feature.  However, I can see how it
>> would be considered inconsistent in many ways, so it's probably best
>> to squash it.  :-\
>
> I think it would depend on the semantics of the option. Some options
> would probably make sense to apply recursively, and some not.
>
> Maybe instead of blindly converting config into the environment, it
> should forward or clear specific known-meaning config.

Well, that's where we started.  I was aiming for the more generic
"never needs updating" direction.

P
