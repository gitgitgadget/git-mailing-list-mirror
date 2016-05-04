From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 06/14] remote.h: add get_remote_capabilities, request_capabilities
Date: Wed, 4 May 2016 09:44:20 -0700
Message-ID: <CAGZ79kbi+g2EnZosyYpAMfj8rFFV45vtgyeEJR3Fe8LG+zut7Q@mail.gmail.com>
References: <1461972887-22100-1-git-send-email-sbeller@google.com>
	<1461972887-22100-7-git-send-email-sbeller@google.com>
	<1462215463.4123.70.camel@twopensource.com>
	<20160503053337.GA17986@sigill.intra.peff.net>
	<1462310486.4123.81.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed May 04 18:44:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axzuV-0001NX-5U
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 18:44:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754093AbcEDQoX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 12:44:23 -0400
Received: from mail-ig0-f170.google.com ([209.85.213.170]:33967 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753621AbcEDQoW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 12:44:22 -0400
Received: by mail-ig0-f170.google.com with SMTP id u5so26538342igk.1
        for <git@vger.kernel.org>; Wed, 04 May 2016 09:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=cgV5SREl3M8vC9qqhrkEoyi2YtJd/Cm0PulxKkPZ9sY=;
        b=ouiF3QEgJNl1kc9pRqxoAzA6Qx8iWOO9AJl8AyLcAX7xQHxlcXg8WUgX/bw4wDWfXF
         pgTbuCiLo36RxIM5VgDWPC/KhN6Oirc5hpZd0C75Q72i4irqT/JVxTfMRqrtkxIroh7W
         qxDwvMNXLIDocYdup2UKuqG2AxYzDALCVJDcYDJFKcOLqQpCIEqqOXnpFBCQvCqADOMo
         awiVzyUrJl8zw3V75Q/qkLzScY7HUNVMiuVtnAVbTEqnAaokGVVeGRUwm1jQXSVNatB5
         Be3cQgBT/W3CN7X74FJ1+wUriRpgVNeCusMrr7qUCo7raovI4s55xfSmx4uig0wcveNy
         nOkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=cgV5SREl3M8vC9qqhrkEoyi2YtJd/Cm0PulxKkPZ9sY=;
        b=QfnF8wJTVDaQZCc9inDkQfCX9mUtckrhKcchvlo8I6rSixVyyfMLFXQhnqGuCEem9/
         +/JIeKDej1aYWZ0n1FLyyBqs9IRc0hd2aoZLL0xggkFSrXUjLOl5M/o2IatzoRpHkWgJ
         d/BU8FX/47Cj4gx8ZDQJVt+AnzHXGdNOXzU3bzlhOqKotcG0q6BHlYoGSqdmIQ1OG1Ct
         q7gvsJG7c/4fsZOjJpY1rFExwhBi/hu+GqZJ23bwAv5Zr/ZrpXrVouAyeuvVtnF1CN2J
         sMDnFh8h8n14b2RI9flRDdKl4Oi6jUnEmV6HPvRtRjehojPdSK1M2i5x6AFfj6sJYHJ5
         Dm1w==
X-Gm-Message-State: AOPr4FUj+a2Ui+W08JJ+oPC94VkODJommsdAXIyer2ZzMdf4u98dU2hAcOW7m4GOHoTUAFv2wO5cZAFVHGjaYnS0
X-Received: by 10.50.30.228 with SMTP id v4mr12273440igh.85.1462380260333;
 Wed, 04 May 2016 09:44:20 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 4 May 2016 09:44:20 -0700 (PDT)
In-Reply-To: <1462310486.4123.81.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293553>

On Tue, May 3, 2016 at 2:21 PM, David Turner <dturner@twopensource.com> wrote:
> On Tue, 2016-05-03 at 01:33 -0400, Jeff King wrote:
>> On Mon, May 02, 2016 at 02:57:43PM -0400, David Turner wrote:
>>
>> > On Fri, 2016-04-29 at 16:34 -0700, Stefan Beller wrote:
>> >
>> > > +const char *known_capabilities[] = {
>> > > + "multi_ack",
>> > > + "thin-pack",
>> > > + "side-band",
>> > > + "side-band-64k",
>> > > + "ofs-delta",
>> > > + "shallow",
>> > > + "no-progress",
>> > > + "include-tag",
>> > > + "multi_ack_detailed",
>> > > + "allow-tip-sha1-in-want",
>> > > + "allow-reachable-sha1-in-want",
>> > > + "no-done",
>> > > +};
>> >
>> > I wonder if it is possible to not repeat the list from upload
>> > -pack.c?
>> > It seems unfortunate to have to add the same string in two places
>> > whenever you add a capability.
>>
>> I think that in general, we'd stop adding capabilities to v1. If you
>> have a client which speaks the new capability, then it should also be
>> speaking the new protocol. That's not strictly true if other non
>> -git.git
>> implementations want to learn capability X but not protocol v2, but I
>> think in practice it's not an unreasonable world view.
>>
>> I guess there may be a grey area for a while, though, where even
>> v2-capable clients don't end up speaking it, because they don't yet
>> know
>> that a particular server can handle it. So any capabilities added in
>> that grey area may want to go to both v1 and v2.
>
> OK, but then there should be one list per protocol version rather than
> two copies of the same list.
>

I thought this is by design as upload-pack is a different program, i.e. it
could be developed out of sync with the client, adding/removing
capabilities there but not in fetch-pack. That doesn't make sense though.

We could introduce known_capabilities_v1 and _v2 respectively in shared
header files, though.
