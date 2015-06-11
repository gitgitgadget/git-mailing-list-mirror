From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] clone: check if server supports shallow clones
Date: Thu, 11 Jun 2015 13:44:35 -0700
Message-ID: <xmqqzj46dlfw.fsf@gitster.dls.corp.google.com>
References: <1433961320-1366-1-git-send-email-adgar@google.com>
	<20150610190512.GB22800@peff.net>
	<CACsJy8CiwiWgf2CarNNN5NgN7QbRB8oxGMmxF+VX8T=ZV2M1ow@mail.gmail.com>
	<20150611143204.GA3343@peff.net>
	<CALkbG6+vRqKwmBjK9jwSph4iUUbqPjiuNdHEeT3nvFhFJ0VpEg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Duy Nguyen <pclouds@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Michael Edgar <adgar@google.com>
X-From: git-owner@vger.kernel.org Thu Jun 11 22:44:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z39LI-0008IR-Iy
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jun 2015 22:44:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755523AbbFKUok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jun 2015 16:44:40 -0400
Received: from mail-ig0-f196.google.com ([209.85.213.196]:33106 "EHLO
	mail-ig0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904AbbFKUoh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jun 2015 16:44:37 -0400
Received: by igdj8 with SMTP id j8so4672752igd.0
        for <git@vger.kernel.org>; Thu, 11 Jun 2015 13:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Cyat5OLzgSwxHOSsNisjhCLNsXmx7iIYhnY5dTD8hOY=;
        b=RF9SZcX/fmy8T9i2ztUxcDz+lvHQst1tQV8qkzj3L+uQ/zwuXAFCTNLbkWDchZqCsU
         fHSiIlz7mQNL/ZgkD0Qo/iHpL9pij9hno8rqJTTpoEksQZ6pCJJYYm+KzD71wh7dwOxk
         vHvcNFOX2YjpOG6gj43YObUWuxUGNe6NhTH4jQRo0ESWglE6ZxaysbeJoUgTA6P/Tw2u
         06Zw00XsLTT3Mtox4mnbuMcZ/89ygkWlIITFS5GIQe5wEnQszOdq2xlcvOVatVoxmFlb
         howJLiLuS6ldeE/16g5/L2MExqBrn5Fw4AjwHe974ieprKQFAxuQiLa3JCn1encHSzgS
         p3Mg==
X-Received: by 10.107.130.218 with SMTP id m87mr13530101ioi.62.1434055476780;
        Thu, 11 Jun 2015 13:44:36 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac40:153c:ed59:12ce])
        by mx.google.com with ESMTPSA id k74sm1109187iok.30.2015.06.11.13.44.35
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Jun 2015 13:44:35 -0700 (PDT)
In-Reply-To: <CALkbG6+vRqKwmBjK9jwSph4iUUbqPjiuNdHEeT3nvFhFJ0VpEg@mail.gmail.com>
	(Michael Edgar's message of "Thu, 11 Jun 2015 14:18:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271461>

Michael Edgar <adgar@google.com> writes:

> On Thu, Jun 11, 2015 at 10:32 AM, Jeff King <peff@peff.net> wrote:
>> On Thu, Jun 11, 2015 at 08:02:33PM +0700, Duy Nguyen wrote:
>>
>>> > I see that do_fetch_pack checks server_supports("shallow"). Is that
>>> > enough to cover all fetch cases? And if it is, why does it not cover the
>>> > matching clone cases?
>>>
>>> I think this replacement check would do
>>>
>>> if ((args->depth > 0 || is_repository_shallow()) && !server_supports("shallow"))
>>>         die("Server does not support shallow clients");
>>
>> Oh, indeed, there is the depth flag I was looking for. :)
>>
>> And from some rudimentary testing, I believe that:
>>
>>   git init
>>   git fetch --depth=1 ...
>>
>> is currently broken in the same way as clone (we are not shallow yet, so
>> it does not complain when the server does not support it). I think the
>> patch above fixes both that and the clone case.
>
> Shall I send that out as a revised patch for review? (This is my first
> stab at a Git
> patch)

Surely, and thanks.  Hopefully one or both of them will Ack it and
all there is left for me to do will be to pick it up ;-)
