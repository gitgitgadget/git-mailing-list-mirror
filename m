From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [RFC/PATCH 01/48] builtin/apply: avoid parameter shadowing
 'p_value' global
Date: Thu, 10 Mar 2016 07:54:47 +0700
Message-ID: <CACsJy8Boz1XLv7yh5GsOQnQh1HF7RYoZ4rpQWWFc3PoTu=9m5w@mail.gmail.com>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
 <1457545756-20616-2-git-send-email-chriscool@tuxfamily.org> <xmqqlh5rfd0t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Christian Couder <christian.couder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 01:55:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adost-0000x7-RS
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 01:55:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934544AbcCJAzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Mar 2016 19:55:20 -0500
Received: from mail-lb0-f179.google.com ([209.85.217.179]:35429 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934460AbcCJAzS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Mar 2016 19:55:18 -0500
Received: by mail-lb0-f179.google.com with SMTP id bc4so90138343lbc.2
        for <git@vger.kernel.org>; Wed, 09 Mar 2016 16:55:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4yIUPzuGk8xRLADLJKxHjS3F4TIUdo5ypxiJQcGM7WM=;
        b=MysgHkRZHfZ7wjqKbMrCra56Le/+MpAIgmqPoefajSEHemqjnHcVRJ+59XHBLuQ86p
         4oMDa4WtCRVGNMxLLE4spD/FkJikyNTVI/c86iupc8zD1aCHSAyo3bRZSmJFvetj2nE8
         crU1S/WhNcwAo6ky1tsYPweZCd7svxylxnr/6JO7NcGaMm6pngJcYTNbN1dUzu4cC/06
         vWWqWyjfkd8AWeVrLhjzDfxsOuNOHAnXLq/Na56x4XBJ6vtktTDfJL7xVa/XRjGU9o2V
         1lrGN1tgvmmqxhlJxIHzReO2ItPQoi71aatl9Ag+IQ80f2dAkAdbnIDijY9F+BwY8Hxc
         j82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4yIUPzuGk8xRLADLJKxHjS3F4TIUdo5ypxiJQcGM7WM=;
        b=UufTkOfPAFD+flu/CmnTFnZN/CLinkkJLiiqy3ndbHvC7aVtbpgNPVju6S4igdzo2Q
         MIeE1LY/RIpyLFYajdP3a3apZja8YjqOXqMmuM7d9FYOF3lfcrgG4aZlqI5jU09XC6Mf
         +k9fYzMNLI2zsIfrEyuqvJfWCjfWqExPP6HzPqh8j7RvDMtEaQI+HfadysanE37S6ta3
         T8BSEUWWhIkzKKwpXGr/HIWZKzSjqwCbIB+VCbatXpx3H/r41sxPI6u3FTXWDqhXb73f
         YL62lHS/p7Nv+3b2hzCWppWSTjw2CRC9gCjDYVruUDb8/h9523jc6TaH7BlhYyMek9v1
         xm/g==
X-Gm-Message-State: AD7BkJJsSNPbEYX5Dl5/jswbcw24SCyTv7/qnRgedlszINhVx3wFPnc5sFEy/G8ykQDPTvfUJcsrAAXzSAWhtA==
X-Received: by 10.112.140.129 with SMTP id rg1mr227309lbb.80.1457571316617;
 Wed, 09 Mar 2016 16:55:16 -0800 (PST)
Received: by 10.112.167.10 with HTTP; Wed, 9 Mar 2016 16:54:47 -0800 (PST)
In-Reply-To: <xmqqlh5rfd0t.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288592>

On Thu, Mar 10, 2016 at 6:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>> ---
>>  builtin/apply.c | 24 ++++++++++++------------
>>  1 file changed, 12 insertions(+), 12 deletions(-)
>
> To be honest, I have to say that I do not like this change from
> readability's point of view.  Once the global p_value becomes a
> field in a "apply state" structure, functions will get a pointer to
> the struct as a parameter, reference to it would be spelled as
> "astate->p_value", while a local variable or a parameter would be
> "p_value" and there is no shadowing issue.

We could revert these local var rename patches at the end of the
conversion, I think.

> Also, you wouldn't be able to catch a misconversion in this patch
> only from the patch text, if the conversion is done this way, would
> you?  The patch may change the parameter p_value to p_v, and change
> two references to p_value also to p_v, but it may leave another
> reference to p_value that originally referred to the parameter
> as-is, making it refer to the global, which would be a new bug
> introduced by this conversion patch, but that remaining reference
> would not show up in the patch.

Yeah, I wish we have a semantic parser that can help with this sort of
refactoring (can sparse do that?). Once we get AST tree, it should be
easy to identify variable scope. Without it, maybe we can still rely
on the compiler by renaming _both_ global and local vars to something
else. That forces us (both patch writer and reviewers) to catch and
examine every reference.
-- 
Duy
