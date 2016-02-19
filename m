From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: Test failures with GNU grep 2.23
Date: Fri, 19 Feb 2016 12:27:32 -0500
Message-ID: <CAPig+cQ0v4edA58=W3YdGUSDc8MeDC3H3Y=-s26ND4=hXj2bpg@mail.gmail.com>
References: <20160207162540.GK29880@serenity.lan>
	<20160219115928.GA10204@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: John Keeping <john@keeping.me.uk>, Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 19 18:27:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aWoq9-0007du-MG
	for gcvg-git-2@plane.gmane.org; Fri, 19 Feb 2016 18:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1948510AbcBSR1d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Feb 2016 12:27:33 -0500
Received: from mail-vk0-f54.google.com ([209.85.213.54]:35107 "EHLO
	mail-vk0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424899AbcBSR1c (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2016 12:27:32 -0500
Received: by mail-vk0-f54.google.com with SMTP id e6so80347432vkh.2
        for <git@vger.kernel.org>; Fri, 19 Feb 2016 09:27:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=w3kQVKNhpCEgu7XJIojb1xPSAw6ec38abhnNWvQdIFg=;
        b=xavm7+mlGHFNnKG3z7twZEWgLlvOpRM0KfnD5gKcmioQPNxCpu2xIGCuDgKLsdQ/ce
         iHpnllu6Ijo4XkxY69T+Sk1a4wjnNh9NRIGKUL9JZZkAUiLoANGoFw4Xk5YDeQIP2i/r
         ZTPp1cIcVZWrx3BMxjeOcrpl2QioNsPENQcLvmnnhnFxtdpAlcPBijxGMuGR2fFCOBuq
         hJBo7+wSH+X2OTNxtjY7/MZ6mj4vthlu9nQOULKjcSvyeGL8TySu0i/xIDSkypx5vi5F
         IR+HMtOV9u8X+0MCu61lLvj5Il1qDrHklfqJQK2S56mwPpHxBN67ipTHMHfLZ65XL0bG
         HO2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=w3kQVKNhpCEgu7XJIojb1xPSAw6ec38abhnNWvQdIFg=;
        b=KceLWwO3y/jiYdfH7PZhJPyqheghnHclvBKDQ7b6DZ1kEw40TdYCbk1n29RNXIvK2v
         GvQUs+z7Vgnlxbzn7E8EVhBk0Hbvrd2boT/MIOL8JOc90tQdspDG274EfipUAxE7u9Rv
         rjPeLBp4EOMweaL6YD6paVSPt/pNhW15Qh34KPmaHOmsqhqNajowHfrudh/Tka3IADFc
         VOGod8osDtVi2fIWkH0tephao0t2Z3eywpbgreonMxXnbOfAkkJ5l71zQt0ucbtbwqYE
         YZsku0nVRSAd1dsXAutVaWX0aGOhkA6LX+c3OmRinyk6GP7A5PEt+mNHDRkVDAffqKYX
         QujA==
X-Gm-Message-State: AG10YOThLWDDrzcFisVP02cPBUNLlxb5IhN0bpioiBwL34OAWkNt4d1U5AmO4A1tjoyrPsgOhqetAPugKJsOyw==
X-Received: by 10.31.47.135 with SMTP id v129mr11924269vkv.115.1455902852095;
 Fri, 19 Feb 2016 09:27:32 -0800 (PST)
Received: by 10.31.62.203 with HTTP; Fri, 19 Feb 2016 09:27:32 -0800 (PST)
In-Reply-To: <20160219115928.GA10204@sigill.intra.peff.net>
X-Google-Sender-Auth: Nwsm5XHCIAy5V_CEsio7pVyBma8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286721>

On Fri, Feb 19, 2016 at 6:59 AM, Jeff King <peff@peff.net> wrote:
> On Sun, Feb 07, 2016 at 04:25:40PM +0000, John Keeping wrote:
>> The following patch fixes the tests for me, but I wonder if "-a" is
>> supported on all target platforms (it's not in POSIX, which specifies
>> that the "input files shall be text files") or whether we should do
>> something more comprehensive to provide sane_{e,f,}grep which guarantee
>> to treat input as text.
>>
>> I also tried setting POSIXLY_CORRECT but that doesn't affect the
>> text/binary decision.
>
> Yeah, I'd worry that "-a" is not portable. OTOH, BSD grep seems to have
> it, so between that and GNU, I think most systems are covered.

Mac OS X grep seems to support -a and tests in t8005 still pass with
-a added to the egrep invocations.

> We could
> do:
>
>   test_lazy_prereq GREP_A '
>         echo foo | grep -a foo
>   '
>
> and mark these tests with it. I'd also be happy to skip that step and
> just do it if and when somebody actually complains about a system
> without it (I wouldn't be surprised if most people on antique systems
> end up installing GNU grep anyway).
>
> Another option might be using "sed -ne '/^author/p'" or similar. But
> that may very well just be trading one portability problem for another.
>
> I also wondered whether we could get away without grepping at all here.
> But the blame output has a bunch of cruft we don't care about; I think
> the readability of the tests would suffer if we tried to match the whole
> thing in a test_cmp.
>
> -Peff
