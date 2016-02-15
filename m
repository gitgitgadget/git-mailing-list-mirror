From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http: add option to try authentication without username
Date: Mon, 15 Feb 2016 16:46:43 -0500
Message-ID: <CAPig+cSphEu3iRJrkdBA+BRhi9HnopLJnKOHVuGhUqavtV1RXg@mail.gmail.com>
References: <CAHdYDCq+MiAJoCPFd3Qn9VjAzoii8QgTOOV7HXEV8OdzW-dgPQ@mail.gmail.com>
	<1455561886-42028-1-git-send-email-sandals@crustytoothpaste.net>
	<CAPig+cTr1eW1KLsZGpY98hUhJ2EHdPopz9C_gTztZRdNPBQTmQ@mail.gmail.com>
	<20160215202937.GA57185@vauxhall.crustytoothpaste.net>
	<20160215203451.GA29705@sigill.intra.peff.net>
	<20160215203659.GB57185@vauxhall.crustytoothpaste.net>
	<xmqqsi0tpsa5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Dmitry Vilkov <dmitry.a.vilkov@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 15 22:46:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVQyn-000580-9h
	for gcvg-git-2@plane.gmane.org; Mon, 15 Feb 2016 22:46:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752499AbcBOVqp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Feb 2016 16:46:45 -0500
Received: from mail-vk0-f53.google.com ([209.85.213.53]:33367 "EHLO
	mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751478AbcBOVqo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Feb 2016 16:46:44 -0500
Received: by mail-vk0-f53.google.com with SMTP id k196so118318027vka.0
        for <git@vger.kernel.org>; Mon, 15 Feb 2016 13:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=UgNQmu3wYO7GrkB+N0+U5YTFbLFKppzrgx7n0n/YGPg=;
        b=M/ki+nwxcXnwHyyDAsM8D75gEFcMFfICxZ3i9cZ0lyyS89L9AWJdd5b2eayNvdHT6G
         sMlasRRE5p2DdkXz86WgN4apzGXEkjvw/S1fnEAuG8EN/H1LrTtl+aegjwfLfx/x9O+r
         bibasoJHvNbkv6j35JOjo7efrLa8w0+Z2akiYJJxMiKlT4GDCDiWFmta+BJ+vDqvoTm2
         9S2842lBc4fByKcsF5OiEwbfCNkwMFs2QVpyyf2i1SFp4BqqLWfN5F6NfaR9/GxPBpQg
         DRbT/xXulx1ChFPRq8lkWDYd5OjaHj+s9zaLzriTfsvsm8Z1ldjlXyHaz1E3joSYzPUq
         ryyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=UgNQmu3wYO7GrkB+N0+U5YTFbLFKppzrgx7n0n/YGPg=;
        b=Thzxbnh92+y+asdWEGSX9hW1kMnOSX05BDThyZ6651UYO5RCWtWVbMswgsWhyd35Rf
         DrBqBr3cYQDIK/u3xuw3zTE0mf7bkIh4UCu/3n7ELJkzsZFV+iDzBmExY7Bcwimbnvmv
         GqUvi2bHN6bFDQ47bemCgTxto+FAGPsSY2Nkg5J75UGs7WhWVv6QIRc+QPS7Ks9/UE68
         vCdfcMERsXw3ghsU5K7Vm0K07QH9Hd/k5Z/6ktw7NOviYKYr2FEANyL7KODc+nK3a8Ua
         bz3uqze1MRcerVsUEdZ6F2fAnuH+m6W77d9z6jKSKmSEgC12HZR6OSDMIKTbmA1vb8Re
         Dxjw==
X-Gm-Message-State: AG10YORD0eWwN20z5bKwuuH/rze0u6Kf2xJ4KMOILcCED5uh9WAXqohIBD4lw8ZZyBqjFfUExwY15zdkRQJn8A==
X-Received: by 10.31.141.2 with SMTP id p2mr14966721vkd.37.1455572803445; Mon,
 15 Feb 2016 13:46:43 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Mon, 15 Feb 2016 13:46:43 -0800 (PST)
In-Reply-To: <xmqqsi0tpsa5.fsf@gitster.mtv.corp.google.com>
X-Google-Sender-Auth: cm5u4xwJnyBhVLepyMQc44dLjuc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286254>

On Mon, Feb 15, 2016 at 4:39 PM, Junio C Hamano <gitster@pobox.com> wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> On Mon, Feb 15, 2016 at 03:34:51PM -0500, Jeff King wrote:
>>> So I think this hack should remain purely at the curl level, and never
>>> touch the credential struct at all.
>>>
>>> Which is a shame, because I think Eric's suggestion is otherwise much
>>> more readable. :)
>>
>> Yes, I agree.  That would have been a much nicer and smaller change.
>
> Alright, reading all reviews and taking them into account, the
> original, when a Sign-off is added, would be acceptable, it seems.

One final question: Keeping in mind my lack of familiarity with this
particular use-case, would it be possible to infer the need to employ
this curl-specific workaround rather than making users tweak a config
setting? Or would that be a security risk or an otherwise stupid idea?
