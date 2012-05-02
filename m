From: David Barr <davidbarr@google.com>
Subject: Re: [PATCH 0/9] Prefix-compress on-disk index entries
Date: Wed, 2 May 2012 14:26:15 +1000
Message-ID: <CAFfmPPOPWkUcuWRFYGk9LHCAJAbvNYK=Xk+pvSa8fbffpRDppQ@mail.gmail.com>
References: <1333493596-14202-1-git-send-email-gitster@pobox.com>
	<CACsJy8A+cJtzKdqJSWbmjT1LgP10LB69-NHfOv8S6BusGcMeFw@mail.gmail.com>
	<7vpqbn8hgr.fsf@alter.siamese.dyndns.org>
	<CAFfmPPNHkK3SB8cGjfJiVoQoSg2OLL8B5--mwH8HShhJ1WGy2g@mail.gmail.com>
	<CACsJy8DZ4t0f_mdDJTUZvz_pBPrPTsEBxHEkYREowWm6D1ikkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 02 06:26:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPR9T-0003uL-Kt
	for gcvg-git-2@plane.gmane.org; Wed, 02 May 2012 06:26:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751098Ab2EBE0S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 May 2012 00:26:18 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60084 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750822Ab2EBE0R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 May 2012 00:26:17 -0400
Received: by yenl12 with SMTP id l12so233643yen.19
        for <git@vger.kernel.org>; Tue, 01 May 2012 21:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record;
        bh=MAQmO5247ozXRousP8ZlUMi6s/B0Skg4aiHG3RoVqJU=;
        b=Tp3K+LXH1aPbWdj6X36rLpzZtPSKTbA44pO/lyybQL5J+Fd1KWQyu+ID3Z+iRWD8Iu
         ZRsVphuXoQrp8LUqDZu2HfaN24DCNGUE4MRBfxgHKNRFve9RbakwAn2td0Kyh/XSI37J
         EaukIjrzmEX3IhrgtF5uFEJ+vbCC83AiW+Ko+sJ0hhanBZFlDMyGTFbIpW3kXuwKURoT
         Edu48pr0Mr6CEgqH074MPnfaz4A5b2Hfdsv8Ucqr26zQQ+Dq8MhMQD1t1V2rd1uEQdyL
         xIZQ8q4BRnxu9rOO64bqkKe4PtA/mFgsJxydIFPoSupMtd4QgV+GSEhS4NpZTfKFpCfa
         UUoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:x-system-of-record:x-gm-message-state;
        bh=MAQmO5247ozXRousP8ZlUMi6s/B0Skg4aiHG3RoVqJU=;
        b=mX3C7oKpwenrJ0Po5Hb9D90fRmvW10pgrWEqIaz+2PRqPZpN6+HfKNfg8bGElNVGkx
         pPDhdG/EAQVpcFTP6tYcGqOfwt9+5RBgjt/YWbyioY2J9TTymqP1DXBc1zsK9KzFFfP+
         KwVFKZGlpifGvvQfbo1upG0dJWpIuWYBtaltLWi0DFoXiPFWRCjBZYI8wK/Afp3TItie
         54e7pMEgSuo4eQoZeCHSpOkv08vIjFQyuDEAFSj/O8AGVGJRNcwmNa89033oxXFJR1kr
         EeaN6RozLpLWF0pAy/3MG59/Ymu0A1MgT/BnoMxbYqIhiBwg7fpSsAitScYmvJ7E5PMl
         AESg==
Received: by 10.236.73.99 with SMTP id u63mr29151419yhd.102.1335932775666;
        Tue, 01 May 2012 21:26:15 -0700 (PDT)
Received: by 10.236.73.99 with SMTP id u63mr29151408yhd.102.1335932775563;
 Tue, 01 May 2012 21:26:15 -0700 (PDT)
Received: by 10.101.83.5 with HTTP; Tue, 1 May 2012 21:26:15 -0700 (PDT)
In-Reply-To: <CACsJy8DZ4t0f_mdDJTUZvz_pBPrPTsEBxHEkYREowWm6D1ikkw@mail.gmail.com>
X-System-Of-Record: true
X-Gm-Message-State: ALoCoQm0d+pnVEO+voREoHtah4icLFHeH5892TJe8XA6er4lKsxE8Ed1FJuWmj5k+pApAxPVoZRSUMG3r+/AwgBvdbYlCFV8VZDo85xMXG+vXpU8e95KVbUjb0JAAGf+mFxZZoVtCBIA900t76H9o4HCkpcGqvIf+w==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196783>

On Wed, May 2, 2012 at 11:58 AM, Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On Fri, Apr 6, 2012 at 3:41 PM, David Barr <davidbarr@google.com> wrote:
>> On Thu, Apr 5, 2012 at 4:44 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>>>
>>>> On Wed, Apr 4, 2012 at 5:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
>>>> ...
>>>> I wonder what causes user time drop from .29s to .13s here. I think
>>>> the main patch should increase computation, even only slightly, not
>>>> less.
>>>
>>> The main patch reduced the amount of the data needs to be sent to the
>>> machinery to checksum and write to disk by about 45%, saving both I/O
>>> and computation.
>>
>> I hacked together a quick patch to try predictive coding the other
>> fields of the index. I got a further 34% improvement in size over
>> this series. Patches to come. I just used the previous cache entry as
>> the predictor and reused varint.h together with zigzag encoding[1].
>>
>> That's a total improvement in size over v2 of 62%.
>
> Have you posted (and I missed) the patches? I'm interested in seeing
> what changes you made.

I haven't posted anything - my proof of concept was write-only and slow.

I added a prelude with a bitmask that describes which fields differ
with the previous entry.

For each differing field, I encoded something like:
diff := this - prev;
zigzag := (diff << 1) ^ (diff >> 31)
raw := zigzag - 1 /* zero impossible because of mask */
write_varint(raw)

I also experimented with using unique sha1 prefixes but it was slow
and probably introduces race conditions.

>> [1] https://developers.google.com/protocol-buffers/docs/encoding#types
--
David Barr
