From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 6/6] tag.c: Change gpg_verify_tag argument to sha1
Date: Mon, 4 Apr 2016 23:46:27 -0400
Message-ID: <CAPig+cSkVtXezozamFohzRyvH46oO3ZFDBXzpV4fHtUUm3epVw@mail.gmail.com>
References: <1459808535-8895-1-git-send-email-santiago@nyu.edu>
	<1459808535-8895-7-git-send-email-santiago@nyu.edu>
	<CAPig+cQ4i86JpLFe0tqA-tjFj6Y3DvxDz3nFL8XAMVDBLwLUPg@mail.gmail.com>
	<20160405021028.GE12006@LykOS>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>
To: Santiago Torres <santiago@nyu.edu>
X-From: git-owner@vger.kernel.org Tue Apr 05 05:46:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anHwo-0001zb-82
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 05:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756728AbcDEDq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Apr 2016 23:46:29 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:36666 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754237AbcDEDq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Apr 2016 23:46:28 -0400
Received: by mail-ig0-f193.google.com with SMTP id kb1so518603igb.3
        for <git@vger.kernel.org>; Mon, 04 Apr 2016 20:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=VPAPEWeya2mtrpRZRoq/SWzM4U+XC78gFAQyC3L5lpE=;
        b=Xd6Sipmbf/jBkJoD50lQS1sHdYwCL+VBKzbMwU4MjolDLhrfYMrZrGrg41Eo1nQf2W
         +JpLfCxap9HlgEgTCYZGIptpk06Wj5UpGdmWYPBCNXe327XI4dWp+3Ohv0rH8FdNinjU
         xddi+vnVuZHKZtYjLC+qbQV5u7USQfcAeKwm1YVKKiGS40C1gZGfvm4wLq/0EPODC1Zu
         zi34GlrpZfyOl1Bs2cRSxyqscLTLGMqv7t5M4X+Unb1y9qVbDPZ0ekx53F6FKSeuuXxP
         K+86uWcmuQ0v0Xwvix0VBiELM1eyu4nPQA+yzRyYD8NKv5Ms6NDG/QOxUPjQ6imGEvpA
         uJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=VPAPEWeya2mtrpRZRoq/SWzM4U+XC78gFAQyC3L5lpE=;
        b=dUV2nW8mLNGWNqjHjmNnoMGixqJ1n/jO/4/CfusMjxJy3jDM5yCwxOKUcM858JdK4D
         LIgcRkbbfOGq93Y4MGxzMlqeMiH5fAp6lI35PfxB4vhlXewatKjzpv5OYpUdHHj06d7N
         qZ23Ptx+O2J5qx9YpUckO/2L/7/6bgQryTK4DnwQvxE1Tz5n7+EK9iXSD9PIXf89IXt8
         byqvMFmfwWrHFpoDBYnkuaTrKQFCVIk6yS2CkW/9po1+GF14cwtQd0lhfmgx9ywASeju
         PJ3OxoVLMU3yQbjdPtrZZpGiIMXaKhjYYoixMvyqdLMFmMCtluzKO1flrI/sTLYitOus
         Tl5w==
X-Gm-Message-State: AD7BkJJBfMLUZfzI7JsSh2ZXsfTB0qNiujTF1FX8ZbdtYKsD10/I1AqiDxm01vnlu4NJ8F7piDTHBQFYFKa6uQ==
X-Received: by 10.50.132.68 with SMTP id os4mr15065181igb.91.1459827987888;
 Mon, 04 Apr 2016 20:46:27 -0700 (PDT)
Received: by 10.79.12.139 with HTTP; Mon, 4 Apr 2016 20:46:27 -0700 (PDT)
In-Reply-To: <20160405021028.GE12006@LykOS>
X-Google-Sender-Auth: TfFEaOGZQSc4YDgPEvI_MeYRtGQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290757>

On Mon, Apr 4, 2016 at 10:10 PM, Santiago Torres <santiago@nyu.edu> wrote:
> On Mon, Apr 04, 2016 at 10:00:17PM -0400, Eric Sunshine wrote:
>> On Mon, Apr 4, 2016 at 6:22 PM,  <santiago@nyu.edu> wrote:
>> > -       return gpg_verify_tag(name, GPG_VERIFY_VERBOSE);
>> > +       return gpg_verify_tag(sha1, GPG_VERIFY_VERBOSE);
>>
>> So, by this point, 'name' has already been resolved to 'sha1', thus
>> this change avoids a second resolution of 'name' inside
>> gpg_verify_tag(). Therefore, this is really an optimization, right?
>> Perhaps the intent of the patch would be clearer if the commit message
>> sold it as such. For instance, the commit message might start off:
>>
>>     tag: avoid resolving tag name twice
>>
>> and then go on to say that by hefting tag name resolution out of
>> gpg_verify_tag(), the extra resolution can be avoided.
>
> Yep, this is actually true, but something I didn't consider. I think
> that, from what I could draw on [1] and [2], git tag -v is reserved to
> tags only (refs/tags iirc). This patch makes it so that this behavior is
> not lost. I'm not sure if it should be separate from 5/6 though.

Okay, so this is a fix for a regression introduced by the previous
patch. I agree that this is suboptimal. You can avoid this regression
issue altogether by merely re-ordering the patch series. For instance,
the series could be ordered like this:

1. SIGPIPE dance
2. add new t7030 test
3. improve variable name in verify_tag()
4. heft get_sha1() lookup out of verify_tag()
5. move code and publish gpg_verify_tag()
6. re-implement "git-tag -v" in terms of gpg_verify_tag()

Sell patch #4 as a libification preparation step, explaining as
justification that some future clients may already have the sha1 in
hand and would want to avoid duplicate resolution of the tag name.
