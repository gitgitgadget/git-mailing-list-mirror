From: Stefan Beller <sbeller@google.com>
Subject: Re: [RFCv2 05/16] remote.h: Change get_remote_heads return to void
Date: Tue, 2 Jun 2015 14:25:03 -0700
Message-ID: <CAGZ79kbuwT_Wd099fys7Dz8y3ckC7pXk-qV4xe=1w4rXhMwRQg@mail.gmail.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
	<1433203338-27493-6-git-send-email-sbeller@google.com>
	<xmqqlhg124ji.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 02 23:25:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YztgL-0005wi-NZ
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 23:25:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751796AbbFBVZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jun 2015 17:25:06 -0400
Received: from mail-qk0-f171.google.com ([209.85.220.171]:33606 "EHLO
	mail-qk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751105AbbFBVZE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jun 2015 17:25:04 -0400
Received: by qkhg32 with SMTP id g32so108959162qkh.0
        for <git@vger.kernel.org>; Tue, 02 Jun 2015 14:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LibKQoGhbrGy7T5AxzREq+F8Q/YLOcLqe/Kw+XsuZUI=;
        b=ORGNXMnZGjQQKp6JRIH4tFOmDmtZ500plNHmIXwf1zcOpl9QSy7Y4oa93V849n2si2
         XVTrLDGjXiy/N8u9poul4on7YUWDG6hUEm4cb5R+s61BVRiSEb9ZK5A+H8mje0AFTnih
         MbGuFwo0NKvO38NBEY67KIU3RdgsTWBM44z4O+i6Ym+fkMs1ueYvzZlvtzEz6nxAf1Ij
         NbJ6LG2vDDL0NnABco2EJXRrNvNOZwzxe/f0ZnRCsoceEDlOjfIkCMi2TGhso+X2NxY9
         YJhH41opYKxqRPsHhsTChLe4lqMWVUyTVIo6WhTYErNVk6Nazz426sfnMC3kX5xtGUSh
         xLwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=LibKQoGhbrGy7T5AxzREq+F8Q/YLOcLqe/Kw+XsuZUI=;
        b=BEuXd9lcIJLwZpBR9niMnS3ymhmD5l4fxUm8O45Z8JmdfuYhAlACm0ArMYcNDyHi67
         C3fRUrERQnNQFwWInFiQP8H2TJHncgFm9M4WMArXcZD1ZrGVMidozS4EBjiVpT0picKJ
         MvdwN7MeC7SxGfSWTQ4ErJXAGlgSI+N5hb+XSJS14E2lSifcE8Dyxxilz9lxCbP50WZV
         m8HJxDY9C+ydytO4cVZErHoYc8gd4xqiE22WAQj9WjHWHn0MX65nCgWoir/4CeW4/Asb
         W+r4wsPjRsDXHmGFt1u0RJgtTiv9YTDZ03vvkaNj3mRxEI9Eb9Sj6wPUKtBa7ESBFsLc
         LG2A==
X-Gm-Message-State: ALoCoQkc29h/ZCgfUj++tncB8cYB7/52ydOI5KfP1dG94f3H8iV8TGVkHpjIKTi9vk/lpIMY488y
X-Received: by 10.140.19.48 with SMTP id 45mr8653456qgg.50.1433280303388; Tue,
 02 Jun 2015 14:25:03 -0700 (PDT)
Received: by 10.140.43.117 with HTTP; Tue, 2 Jun 2015 14:25:03 -0700 (PDT)
In-Reply-To: <xmqqlhg124ji.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270604>

On Tue, Jun 2, 2015 at 2:17 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> No function uses the return value of get_remote_heads, so we don't want
>> to confuse readers by it.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> This is somewhat a sad change, as the returned value is designed to
> be useful if caller wants to continue appending to the list.

But there are no callers since like 2005. ;)
(I did not exactly track it down, but even the last caller went away
rather fast)

>
> Does it really "confuse" readers enough that it hurts to have a
> return value?
>

Probably no.
But I think this is just carrying around cruft we could avoid?

>
> Now such a caller has to tangle the list (the variable it gave the
> function as the fourth argument) itself to find its tail.

So you're saying if someone in the future really wants to append
to that list, they don't find out to just return it again but rather
do an O(n) operation?
