Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6D9F120705
	for <e@80x24.org>; Thu,  7 Jul 2016 22:06:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752659AbcGGWGe (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 18:06:34 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:35677 "EHLO
	mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752246AbcGGWGc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jul 2016 18:06:32 -0400
Received: by mail-io0-f182.google.com with SMTP id f30so34126795ioj.2
        for <git@vger.kernel.org>; Thu, 07 Jul 2016 15:06:32 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QaYbljPpWbb5cN0EB8z/8k7sFKubSAIqsqOLaXjMhGk=;
        b=b2bGTSVlXc/6VcpyGAECfI4dtdPiZ5ppEXhrNghsPxpFVhCI/FeSePMUWDjTPt2PH2
         f4nmlNFzuoiceeQRUNy/UBR+wDHxVmzauMkG5AQdAXPmdjbJ3oLLodRMS+XkhiNfy+f2
         f8clDTZwZTSOgm/y12zAqG7eN90z/JRdpvcUhFv3FLEbkT+F9R6vEuv7z9vVIODMkn9L
         7XgDPldeYD8jd7Ih4PUYCD7YN5N1uAZo5RWlgmkBlQ/XMLZiNWUad+o4yFUnpG0+eqBE
         dBBZZU9T0Jr9rtnLK4cFAi9LHTzIHZbxjj1ajv/ZATVbGU6iIEdQkR4UfKZn71Bvxusa
         7+0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QaYbljPpWbb5cN0EB8z/8k7sFKubSAIqsqOLaXjMhGk=;
        b=CbE2fhWCBFj1u4vNBM1kkXueD0MSEWOiYtEi3SoAgdC0OQPcn4InwTp/X+aYx3FqpH
         DNaAspU9WEa/sh+XzlTsMgOnXbnb8vhmORYSgYZiCk2pz2dslipHtS0PdraGVBhcJBfK
         KYlR6h2ag8w56+U1AwD7DLiSZ6b1HO3w7VsLe2Ic/l6PHM+A9uJGAHNEBegElKQScy+C
         p/rohYLlhbPhzzsixVSvVt3KA7Rcl6kRdzALMSHG4dBxBq2TjiWxM5gnp34qAM8hX+E4
         eX0xm7sUnxj5mb20EAU5E+czt7Y2xADV0sjE2z11PB1Hh29FTviR+98spNrT09MsVvRL
         Lo/Q==
X-Gm-Message-State: ALyK8tLVbJr5xIBfpquPUU3GZ6WjutACbthKyaf2BtkWnhfiMYD6aDZ1LlyOjrL3oShNaNODu7axnHl7xGBmMQdu
X-Received: by 10.107.186.196 with SMTP id k187mr5450138iof.173.1467929191662;
 Thu, 07 Jul 2016 15:06:31 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.136.16 with HTTP; Thu, 7 Jul 2016 15:06:31 -0700 (PDT)
In-Reply-To: <20160707215638.GA27627@sigill.intra.peff.net>
References: <20160707011218.3690-1-sbeller@google.com> <20160707011218.3690-3-sbeller@google.com>
 <xmqqa8htp4kc.fsf@gitster.mtv.corp.google.com> <CAGZ79kbkv5P0wP2kKt9gzmZBe1DjLSB8JpZD66DT_Xd4NKqmKQ@mail.gmail.com>
 <20160707215638.GA27627@sigill.intra.peff.net>
From:	Stefan Beller <sbeller@google.com>
Date:	Thu, 7 Jul 2016 15:06:31 -0700
Message-ID: <CAGZ79kbrZuDEN58sdBUQEbLeJbqVo5wNzXRjqAouRGqP=mw01A@mail.gmail.com>
Subject: Re: [PATCH 2/4] receive-pack: implement advertising and receiving
 push options
To:	Jeff King <peff@peff.net>
Cc:	Junio C Hamano <gitster@pobox.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Wong <e@80x24.org>, Dan Wang <dwwang@google.com>,
	Dennis Kaarsemaker <dennis@kaarsemaker.net>
Content-Type: text/plain; charset=UTF-8
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Thu, Jul 7, 2016 at 2:56 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jul 07, 2016 at 02:41:37PM -0700, Stefan Beller wrote:
>
>> >> +     /* NEEDSWORK: expose the limitations to be configurable. */
>> >> +     int max_options = 32;
>> >> +
>> >> +     /*
>> >> +      * NEEDSWORK: expose the limitations to be configurable;
>> >> +      * Once the limit can be lifted, include a way for payloads
>> >> +      * larger than one pkt, e.g allow a payload of up to
>> >> +      * LARGE_PACKET_MAX - 1 only, and reserve the last byte
>> >> +      * to indicate whether the next pkt continues with this
>> >> +      * push option.
>> >> +      */
>> >> +     int max_size = 1024;
>> >
>> > Good NEEDSWORK comments; perhaps also hint that the configuration
>> > must not come from the repository level configuration file (i.e.
>> > Peff's "scoped configuration" from jk/upload-pack-hook topic)?
>>
>> Ok, I reviewed that series. It is unclear to me how the attack would
>> actually look like in that case.
>>
>> In 20b20a22f8f Jeff writes:
>> > Because we promise that
>> > upload-pack is safe to run in an untrusted repository, we
>> > cannot execute arbitrary code or commands found in the
>> > repository (neither in hooks/, nor in the config).
>>
>> I agree on this for all content that can be modified by the user
>> (e.g. files in the work tree such as .gitmodules), but the .git/config
>> file cannot be changed remotely. So I wonder how an attack would
>> look like for a hosting provider or anyone else?
>> We still rely on a sane system and trust /etc/gitconfig
>> so we do trust the host/admin but not the user?
>
> The problem is for hosting sites which serve repositories via git-daemon
> from untrusted users who have real shell accounts (e.g., you set up
> git-daemon to run as the "daemon" user serving repositories out of
> people's home directories; you don't want users to escalate their shell
> access into running arbitrary code as "daemon").

I think you would want to lock down the
hosting site as much as possible and not put untrusted users home
directories on there? So it is hard for me to imagine you'd go for such a setup
in practice.

>
> But I don't think that case applies here. That is about running
> upload-pack on an untrusted repository, but your changes here are part
> of receive-pack. In such a scenario, users should be pushing as
> themselves via ssh. And if they are not (e.g., the admin set up
> push-over-smart-http centrally), they are already screwed, as a
> malicious user could just set up a pre-receive hook.

I hear that as: "The pre-receive hook itself can do much more
damage than an oversized push option payload".

OK.

>
> IOW, we promise only that upload-pack is safe to run an untrusted repo,
> but not receive-pack.
>
> -Peff

Thanks,
Stefan
