From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] t5304: use helper to report failure of "test foo = bar"
Date: Mon, 13 Oct 2014 14:33:48 -0700
Message-ID: <CAPc5daX7UBvxCw60VUW4rUkKYbD8Do+=Nczq=z=ykoykZA+ywQ@mail.gmail.com>
References: <20141010060636.GA15057@peff.net> <20141010061114.GB15277@peff.net>
 <20141013161022.GA20520@google.com> <20141013211524.GB15969@peff.net> <20141013213132.GA32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 13 23:34:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XdnFu-0004YK-Jg
	for gcvg-git-2@plane.gmane.org; Mon, 13 Oct 2014 23:34:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751949AbaJMVeL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Oct 2014 17:34:11 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:41522 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751195AbaJMVeK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Oct 2014 17:34:10 -0400
Received: by mail-la0-f47.google.com with SMTP id pv20so7318576lab.6
        for <git@vger.kernel.org>; Mon, 13 Oct 2014 14:34:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=euWyxiYA92+QXmEsMCacSKN8tOIsBz7ShvTRDMW6hI8=;
        b=LwfsU/Eax9RnkVHSjp/lPtRAt0myZmfoRZxe8hERoFWWq7zDif46KbT08dZi1hbhv6
         81dp/HP9CsLV7GCPy4qkPo5Yt/Af6x6i4GedN/Yz49wtsJ227wg3e0DSYAFFaio0P72q
         EeTiXDFkEL3Xa397smtktNK39nzpGu/hS1vkXREWRl92ipFrhAOC0l/6BJ9p7XIbkJnH
         MJap6opfr9V0qb81KB6BY0pR45rFzgnDPfRTAmNdDsm6dvBhKSe4bMGamXUew28mFT3R
         T9hsw0137FyZwOshziZTMNHITgPMB+bfPQDecFGOF2fSJmYOZRIBz/joCpVamrhaQrcw
         hdjw==
X-Received: by 10.112.140.74 with SMTP id re10mr1204393lbb.40.1413236048511;
 Mon, 13 Oct 2014 14:34:08 -0700 (PDT)
Received: by 10.112.209.35 with HTTP; Mon, 13 Oct 2014 14:33:48 -0700 (PDT)
In-Reply-To: <20141013213132.GA32245@google.com>
X-Google-Sender-Auth: w-FpqQeTf13T3tv22W3-9Fu4Wv4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 13, 2014 at 2:31 PM, Jonathan Nieder <jrnieder@gmail.com> wrote:
> Jeff King wrote:
>> On Mon, Oct 13, 2014 at 09:10:22AM -0700, Jonathan Nieder wrote:
>
>>> There's another downside to that construct: it loses the exit
>>> status from some_cmd.
>>
>> Yes, although I think in many cases it's not a big deal. For example,
>> here we lose the exit code of count-objects, but it also is very
>> unlikely to fail _and_ produce our expected output.
>
> It could segfault after producing the good output, but sure,
> count-objects code doesn't change very often.

"Doesn't change very often" is not the issue. Here we are not testing
if it can count correctly without crashing, which *is* the real reason
why it is perfectly fine to use $(git count-objects | sed ...) pattern here.

There of course should be a test for count-objects to make sure it
counts correctly without crashing.
