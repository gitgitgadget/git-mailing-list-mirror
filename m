From: Stefan Beller <sbeller@google.com>
Subject: Re: When does git check for branch-X being uptodate with origin/branch-X?
Date: Mon, 21 Mar 2016 15:11:16 -0700
Message-ID: <CAGZ79kaUY86nUiG9urgDhVGZ5yc1=63nvJGufw7K8TAc3ytmdA@mail.gmail.com>
References: <CA+39Oz4izkhtxbUH8cQoD5-DLKAtv9KnC9OkG_ZhFw6Ysg0+gw@mail.gmail.com>
	<20160321202810.GD32071@sigill.intra.peff.net>
	<CA+39Oz4Atuv3N0QNj8o1SYgHzMUyES1QHUsWh-MdNiNr-xPM_w@mail.gmail.com>
	<20160321205043.GA436@sigill.intra.peff.net>
	<CA+39Oz51SaKAWsJ027fzhR3CRDfqmy1Dp7qcpx-k9-HrzGKcwg@mail.gmail.com>
	<CAGZ79kabn+pA4Fs2Y4E6Mwy-dKW6SZZ+LZK7_LjhqagcVc-xDg@mail.gmail.com>
	<xmqq1t73lciw.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Thomas Adam <thomas.adam22@gmail.com>, Jeff King <peff@peff.net>,
	git list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 23:11:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ai82k-0001NK-Er
	for gcvg-git-2@plane.gmane.org; Mon, 21 Mar 2016 23:11:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753497AbcCUWLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Mar 2016 18:11:18 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:35809 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751331AbcCUWLR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Mar 2016 18:11:17 -0400
Received: by mail-io0-f174.google.com with SMTP id o5so141677494iod.2
        for <git@vger.kernel.org>; Mon, 21 Mar 2016 15:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=SyIPUX5mwHRXzEymGF8oqWCQL8cZtqa5EJ1vueH273Q=;
        b=PwvPLwHWICxi8rxDsu0c8ak7sovHdsdiBkwLS35+MPVcTB3gpKdZj9Y0Z92OImxcJz
         w0rWMtwqZfImMkgWgVj+UkF/iRxMtH1slc7Y73WWZrBksE84yl5F8I7PnB/bLGqi8RX/
         AZBPNiqnYfMOP2IF+hTnvW2qGYFcdN4FXl2OFuOYyTL31GI2ZTkhJu9Wz3NYDJUUfeWq
         NE37NHxbWBP/D71IZ+kqk9Wn3y9OaETEPBUfeTUo6i6Bztp1xwvdJG6VN1Fv5/UaGK57
         xOzYMav6Hl3bmEgpQYwdElMIKWAMTZvAHr4Rs240YVRpZIuac4ISuKhi2LnvqS3Dm7+8
         fJ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=SyIPUX5mwHRXzEymGF8oqWCQL8cZtqa5EJ1vueH273Q=;
        b=RAhvcGG9gss50igt7dOZTDJmWcBCcHcRGTh295jJUlQL7CUfYKkvtVcR9yylVGyA6B
         ZP3yeN5U4gb2nOy1/eytaXCIYCA4dWym1Da3jTMYfFQjchRvEp8xKgKbtyzL5vcUVUv8
         e2Y0CCTBbiXb6IEBZVI+BIeYvYgh8yix0r0KxucI98rckN5QbZtCA68OzKeVDB2elvQe
         Al/fWMHe4KYupDhtP+6msnSdb3IXGbCwQfOJEIJG3u4mIDsPQSOnGSmQ30Z/4xgxayvv
         vGv69SGydKUV4VwM6p2FwN10WKnyI8LFXnZH/xP90+p7BvjWXI6lrLHj+yjv7CN/9s3u
         ezxA==
X-Gm-Message-State: AD7BkJIaA4LnOGHhMa06uT5LEwQqiiGHRoM8TxrETu7Zw4hr8Twu+ek62blrEo2gx+0RgQo1WDT4F6zqo4nJMVcw
X-Received: by 10.107.135.96 with SMTP id j93mr31023595iod.96.1458598276418;
 Mon, 21 Mar 2016 15:11:16 -0700 (PDT)
Received: by 10.107.132.101 with HTTP; Mon, 21 Mar 2016 15:11:16 -0700 (PDT)
In-Reply-To: <xmqq1t73lciw.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289470>

On Mon, Mar 21, 2016 at 2:57 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>>> "branch-X is uptodate with origin/branch-X (as of DD-MM-YY HH:MM:SS)"
>>
>> Actually I like that feature of recording the last known time we fetched,
>> I would have found that information useful in the past a few times. (unrelated
>> to this exact message, but if we were to make this change, we would
>> need to record
>> the time somewhere, and that's what I would have wanted)
>
> Like in reflog for refs/remotes/origin/branch-X?
>

Heh, exactly that. Though the git-reflog tool is missing the time
as it appears on the reflog file.

Just quoting from my reflog file

$ cat .git/logs/refs/remotes/origin/master
f3adf457e046f92f039353762a78dcb3afb2cb13
754884255bb580df159e58defa81cdd30b5c430c Stefan Beller
<sbeller@google.com> 1452529563 -0800 fetch --append origin:
fast-forward
754884255bb580df159e58defa81cdd30b5c430c
fc10eb5b87a75af2cb93a3932897572f2c544915 Stefan Beller
<sbeller@google.com> 1452709338 -0800 fetch --append origin:
fast-forward
fc10eb5b87a75af2cb93a3932897572f2c544915
3ee1e0fe11e2eb617170d0487fccfffc67f2b82b Stefan Beller
<sbeller@google.com> 1453411906 -0800 fetch --append origin:
fast-forward
3ee1e0fe11e2eb617170d0487fccfffc67f2b82b
e572fef9d459497de2bd719747d5625a27c9b41d Stefan Beller
<sbeller@google.com> 1453508448 -0800 fetch --append origin:
fast-forward
e572fef9d459497de2bd719747d5625a27c9b41d
d10e2cb9d0299a26f43d57dd5bdcf2b3f86a30b3 Stefan Beller
<sbeller@google.com> 1453939673 -0800 fetch --append origin:
fast-forward
d10e2cb9d0299a26f43d57dd5bdcf2b3f86a30b3
701fa7fe35768fd6e291b667566ac4b434f6e1c9 Stefan Beller
<sbeller@google.com> 1454364624 -0800 fetch --append origin:
fast-forward
701fa7fe35768fd6e291b667566ac4b434f6e1c9
07c314d22dc8b0a982e76e7498a3f4d384062491 Stefan Beller
<sbeller@google.com> 1454445124 -0800 fetch --append origin:
fast-forward
07c314d22dc8b0a982e76e7498a3f4d384062491
563e38491eaee6e02643a22c9503d4f774d6c5be Stefan Beller
<sbeller@google.com> 1454610734 -0800 fetch --append origin:
fast-forward
563e38491eaee6e02643a22c9503d4f774d6c5be
ff4ea6004fb48146330d663d64a71e7774f059f9 Stefan Beller
<sbeller@google.com> 1455040507 -0800 fetch --append origin:
fast-forward
ff4ea6004fb48146330d663d64a71e7774f059f9
494398473714dcbedb38b1ac79b531c7384b3bc4 Stefan Beller
<sbeller@google.com> 1455150849 -0800 rebase -i (start): checkout
origin/master: fast-forward
494398473714dcbedb38b1ac79b531c7384b3bc4
0233b800c838ddda41db318ee396320b3c21a560 Stefan Beller
<sbeller@google.com> 1455824915 -0800 fetch --append origin:
fast-forward
0233b800c838ddda41db318ee396320b3c21a560
70bd996071bf724a7b151c81a165e8837179d6d7 Stefan Beller
<sbeller@google.com> 1456250296 -0800 fetch --append origin:
fast-forward
70bd996071bf724a7b151c81a165e8837179d6d7
7c0da37d7b0e09c199788191b322bf45fd003e3c Stefan Beller
<sbeller@google.com> 1456337953 -0800 fetch --append origin:
fast-forward
7c0da37d7b0e09c199788191b322bf45fd003e3c
56f37fda511e1615dc6df86c68f3b841711a7828 Stefan Beller
<sbeller@google.com> 1456358750 -0800 fetch --append origin:
fast-forward
56f37fda511e1615dc6df86c68f3b841711a7828
f02fbc4f9433937ee0463d0342d6d7d97e1f6f1e Stefan Beller
<sbeller@google.com> 1456530630 -0800 fetch --append origin:
fast-forward
f02fbc4f9433937ee0463d0342d6d7d97e1f6f1e
d285ab0a41c5c04222cf356066d1df1e6096c5a7 Stefan Beller
<sbeller@google.com> 1457045695 -0800 fetch --append origin:
fast-forward
d285ab0a41c5c04222cf356066d1df1e6096c5a7
ab5d01a29eb7380ceab070f0807c2939849c44bc Stefan Beller
<sbeller@google.com> 1457133708 -0800 fetch --append origin:
fast-forward
ab5d01a29eb7380ceab070f0807c2939849c44bc
ed9067f705aa51819c7dfff7e4190dd267beaf5d Stefan Beller
<sbeller@google.com> 1457652712 -0800 fetch --append origin:
fast-forward
ed9067f705aa51819c7dfff7e4190dd267beaf5d
db6696f653b917509dac1ac13b922e12773a84ff Stefan Beller
<sbeller@google.com> 1458061695 -0700 fetch --append origin:
fast-forward
db6696f653b917509dac1ac13b922e12773a84ff
c2c5f6b1e479f2c38e0e01345350620944e3527f Stefan Beller
<sbeller@google.com> 1458083837 -0700 fetch --append origin:
fast-forward
c2c5f6b1e479f2c38e0e01345350620944e3527f
d9c691a759d62cef53a6cc11864a2ef4b0829244 Stefan Beller
<sbeller@google.com> 1458167761 -0700 fetch --append origin:
fast-forward
d9c691a759d62cef53a6cc11864a2ef4b0829244
44915db9358936fbad21221fed3abf86166696fd Stefan Beller
<sbeller@google.com> 1458255346 -0700 fetch --append origin:
fast-forward
44915db9358936fbad21221fed3abf86166696fd
b552ff8c67d1b1c60d7d1fcf25a0603a37649b4f Stefan Beller
<sbeller@google.com> 1458580955 -0700 fetch --append origin:
fast-forward

I do understand the "fetch --append origin fast-forward", (I assume
they are coming from regular fetches). But the "rebase -i (start):
checkout origin/master: fast-forward" seems to have recorded there in
error as I never rebased origin/master itself, but only other stuff on
top of origin/master.
Why would we have such an entry in there?

Thanks,
Stefan
