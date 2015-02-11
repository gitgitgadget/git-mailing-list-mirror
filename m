From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/8] lock_ref_sha1_basic(): do not set force_write for
 missing references
Date: Tue, 10 Feb 2015 16:07:26 -0800
Message-ID: <CAGZ79kbz93ne8KVkeZfj9muomfcoTh7BUEyEo5ZZpYNG4RSYZg@mail.gmail.com>
References: <1423473164-6011-1-git-send-email-mhagger@alum.mit.edu>
	<1423473164-6011-4-git-send-email-mhagger@alum.mit.edu>
	<CAGZ79kbrFpgF6_dLYdgT2D0JjWggu8edjV2sgXER5btpmyjDNw@mail.gmail.com>
	<20150211000520.GA30561@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 01:07:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YLKq3-0002Xo-Ui
	for gcvg-git-2@plane.gmane.org; Wed, 11 Feb 2015 01:07:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbbBKAH1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2015 19:07:27 -0500
Received: from mail-ie0-f173.google.com ([209.85.223.173]:39589 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750812AbbBKAH1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Feb 2015 19:07:27 -0500
Received: by iecvy18 with SMTP id vy18so351844iec.6
        for <git@vger.kernel.org>; Tue, 10 Feb 2015 16:07:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=vdYPS1wj67WebNemU7/bK1NlgqICIWKrKYW9y/Q1Xuw=;
        b=Pg613YUWoKqAPwYxgUXddKmnxYvjddf0KiWyIxhnxj6mhuDkyng22Nnork0xrFjV5R
         AiT7VmNt8LBCN9dT1k93nOvWOqs5N4pvB8E+WedHgNUiGqHVCXN4p50iFhdiJOo0lSOP
         Kn8mgqEynsgIXd50PZhPxBSbOGKxMNR1Fr97Xh0OOGgjfpQwIhO/+V0JA35aT8JTcxAi
         27acIVIrWvJS/29VOgdIZv6ITZvaEIxhXpn4C0epF7w47T/Gra95p0kyCKtbRKdbQLgC
         KwmOre+4ca5eHtnpb5rDuhj1fS51Da2bjoRYrOcEpUBC+4pDo29LDxpYhAOF+yLerCW3
         XcwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=vdYPS1wj67WebNemU7/bK1NlgqICIWKrKYW9y/Q1Xuw=;
        b=a7ZnMkTY5kMe/D/YFeppTbnOuItU3/TH+LCzXVdL0x28CGTILNSAut7a38hOSpjmHJ
         V/pEfY43zet/qwLpLn53O1lXX5+bA8fE6HD2RqyRtUCbNjcG8RCIU2RkChAGxo/MOHTw
         EizZnLSMRmbri+K8WlXdveOD6mzqO+3CalJi5SvCn9vIWpylvIqcKJMA/SAx+HlLDxrh
         dzO+6XZY34TNX3kfmCLFNFUCn7oavdnl/+LUX5BQ8uBQhZg1TRtOEMhXQnOupwXbIvN0
         985O8zkwaUQIy1kjaWU3P6j91ACzxmn6y07SJZNNeeM2XPvd3w8pSyfOwoGu+pztIY2k
         L+Wg==
X-Gm-Message-State: ALoCoQl9TjOWleC7bbWVE0C6xAW2x/D+cotSAj3e0AMi6dFpDgXcokX4m4NfokmhZzRQE/TrBA+5
X-Received: by 10.107.137.17 with SMTP id l17mr14988401iod.33.1423613246323;
 Tue, 10 Feb 2015 16:07:26 -0800 (PST)
Received: by 10.50.26.42 with HTTP; Tue, 10 Feb 2015 16:07:26 -0800 (PST)
In-Reply-To: <20150211000520.GA30561@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263664>

On Tue, Feb 10, 2015 at 4:05 PM, Jeff King <peff@peff.net> wrote:
> On Tue, Feb 10, 2015 at 03:24:47PM -0800, Stefan Beller wrote:
>
>> On Mon, Feb 9, 2015 at 1:12 AM, Michael Haggerty <mhagger@alum.mit.edu> wrote:
>> > If a reference is missing, its SHA-1 will be null_sha1, which can't
>> > possibly match a new value that ref_transaction_commit() is trying to
>> > update it to. So there is no need to set force_write in this scenario.
>> >
>>
>> This commit reverts half the lines of 5bdd8d4a3062a (2008-11, do not
>> force write of packed refs). And reading both commit messages, they
>> seem to contradict each other. (Both agree on  "If a reference is
>> missing, its SHA-1 will be null_sha1 as provided by resolve_ref", but
>> the conclusion seems to be different.)
>
> Most of the lines of 5bdd8d4a3062a that are being reverted here are
> caching the is_null_sha1() check in the "missing" variable. And that's
> a cleanup in this patch that is not strictly necessary ("missing" would
> only be used once, so it becomes noise).
>
> The interesting thing in the earlier commit was to use the null sha1 to
> cause a force-write, rather than lstat()ing the filesystem. And here we
> are saying the force-write is not necessary at all, no matter what
> storage scheme is used. So I don't think there is any contradiction
> between the two.
>
> Is this patch correct that the force-write is not necessary? I think so.
> The force-write flag comes from:
>
> commit 732232a123e1e61e38babb1c572722bb8a189ba3
> Author: Shawn Pearce <spearce@spearce.org>
> Date:   Fri May 19 03:29:05 2006 -0400
>
>     Force writing ref if it doesn't exist.
>
>     Normally we try to skip writing a ref if its value hasn't changed
>     but in the special case that the ref doesn't exist but the new
>     value is going to be 0{40} then force writing the ref anyway.
>
> but I am not sure that logic still holds (if it ever did). We do not ever write
> 0{40} into a ref value.
>
> -Peff

Makes sense.
