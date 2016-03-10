From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 01/48] builtin/apply: avoid parameter shadowing
 'p_value' global
Date: Thu, 10 Mar 2016 11:45:01 +0100
Message-ID: <CAP8UFD0UYsaz6ZatZCXuxmCc-ge_Tu3mL16Bz25EUFGf9ma1Ow@mail.gmail.com>
References: <1457545756-20616-1-git-send-email-chriscool@tuxfamily.org>
	<1457545756-20616-2-git-send-email-chriscool@tuxfamily.org>
	<xmqqlh5rfd0t.fsf@gitster.mtv.corp.google.com>
	<CACsJy8Boz1XLv7yh5GsOQnQh1HF7RYoZ4rpQWWFc3PoTu=9m5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Jeff King <peff@peff.net>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Karsten Blees <karsten.blees@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 10 11:45:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ady5e-0005OC-Ge
	for gcvg-git-2@plane.gmane.org; Thu, 10 Mar 2016 11:45:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965571AbcCJKpG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Mar 2016 05:45:06 -0500
Received: from mail-lb0-f173.google.com ([209.85.217.173]:36559 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752555AbcCJKpD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Mar 2016 05:45:03 -0500
Received: by mail-lb0-f173.google.com with SMTP id x1so105910447lbj.3
        for <git@vger.kernel.org>; Thu, 10 Mar 2016 02:45:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=pJ04IjGlz/KfHIlFuLife+MyXsXfnE59k1BfoK1wk1Y=;
        b=Xki9XQwzuNQxLSehfqIU1Et4m3oodkY8xEzGxEIaHYQjr9pJTsVNgq+F5euzUbwPi2
         og1cRU9afDfe4luu7ZNePLICQ8TWOevhcPe2Ibc7GHmDfrdmYbuEdn8J12IkUwq2cK4r
         nJb13TgcVTswGzcE10vliQsWjkk32F3ppftIzzh7MY39SEUC87YHE6sBahEkKAm9aU7k
         QnVuruUfxLfXktj8EvnSmB/f4TktIxt771GKyw4NmIso0zKi0pnkwzpnxDY04WnMxvht
         VUDs4kt81vVcgsRNfu8wodUEUUbkbWAIeJcFTGc1SelnPXETo9U504UKGkayTjHBsmUS
         J/Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=pJ04IjGlz/KfHIlFuLife+MyXsXfnE59k1BfoK1wk1Y=;
        b=RrEPKsgJYY3ARLDu/rY/N5uwyVfB0bMc/QTgBYBnFkZdrrPpUOW8y9KeUL9Gu5Bc7e
         4+C+3hZ+Pj9F2qR42tcMVUbisveCj1C0R3L22w19pX5p6NwTmn8dOAmTAgCQJenPUp9G
         hNQULoDE3PQBvcAET3JXrushx587RZ1m5nmrXbPQBXsgxllQ6PXpZ2+DAAo8Vt40Txzj
         D3FeWd0rZqtS20A7VYDM/oz4Z2h69GThovfpaamu7MMW2rhzPObVjZk7HkMBVbIE4YPc
         SDRV6bqvvi7FFeIgtFwMX3k5z42Pe4sr5AuNW8hpYmCEVxirhvwThZqucEKHijD5Zdp/
         HDlw==
X-Gm-Message-State: AD7BkJKLTAQfJZk5hZhuydQEyktSYPSBLA4/clmo/oUJ6z+bRzWJc9zTv9Pa1cRBOrszuOW3ME0w8TPW7UKVqA==
X-Received: by 10.25.83.138 with SMTP id h132mr936691lfb.7.1457606701185; Thu,
 10 Mar 2016 02:45:01 -0800 (PST)
Received: by 10.25.137.130 with HTTP; Thu, 10 Mar 2016 02:45:01 -0800 (PST)
In-Reply-To: <CACsJy8Boz1XLv7yh5GsOQnQh1HF7RYoZ4rpQWWFc3PoTu=9m5w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288610>

On Thu, Mar 10, 2016 at 1:54 AM, Duy Nguyen <pclouds@gmail.com> wrote:
> On Thu, Mar 10, 2016 at 6:27 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Christian Couder <christian.couder@gmail.com> writes:
>>
>>> Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
>>> ---
>>>  builtin/apply.c | 24 ++++++++++++------------
>>>  1 file changed, 12 insertions(+), 12 deletions(-)
>>
>> To be honest, I have to say that I do not like this change from
>> readability's point of view.  Once the global p_value becomes a
>> field in a "apply state" structure, functions will get a pointer to
>> the struct as a parameter, reference to it would be spelled as
>> "astate->p_value", while a local variable or a parameter would be
>> "p_value" and there is no shadowing issue.
>
> We could revert these local var rename patches at the end of the
> conversion, I think.
>
>> Also, you wouldn't be able to catch a misconversion in this patch
>> only from the patch text, if the conversion is done this way, would
>> you?  The patch may change the parameter p_value to p_v, and change
>> two references to p_value also to p_v, but it may leave another
>> reference to p_value that originally referred to the parameter
>> as-is, making it refer to the global, which would be a new bug
>> introduced by this conversion patch, but that remaining reference
>> would not show up in the patch.
>
> Yeah, I wish we have a semantic parser that can help with this sort of
> refactoring (can sparse do that?). Once we get AST tree, it should be
> easy to identify variable scope. Without it, maybe we can still rely
> on the compiler by renaming _both_ global and local vars to something
> else. That forces us (both patch writer and reviewers) to catch and
> examine every reference.

I agree that the change in the patch is not very nice.
I can do one of the following:

1) do as Junio suggests, just discard this change and wait until
p_value is moved into apply_state for the problem to be solved; a
small downside of this is that if you compile with -Wshadow after each
change you will get some warnings until p_value is moved into
apply_state; I could move the patch to move p_value at the beginning
of the series but it is a bit involved and easier to review if it is
done towards the end,

2) revert these local var rename patches at the end of the conversion,
as Duy suggests

3) instead of renaming the local "p_value" variable, rename the global
"p_value" to maybe "state_p_value", so that when I move it into
apply_state I just need to s/state_p_value/state->p_value/.

I'd rather do 3) than 1) or 2) but I am also ok with 1) and 2).

Thanks,
Christian.
