From: Lars Schneider <larsxschneider@gmail.com>
Subject: Re: [PATCH v3 1/3] submodule: add test to demonstrate that shallow recursive clones fail
Date: Sun, 20 Mar 2016 18:05:34 +0100
Message-ID: <0767AEDB-36D6-45BE-A1CC-944ECAFC00FB@gmail.com>
References: <1450653595-22676-1-git-send-email-larsxschneider@gmail.com> <1450653595-22676-2-git-send-email-larsxschneider@gmail.com> <CAGZ79kYzbmzK1UwvWheugkqG0FwhpGMU0_K_jyCKOnoKb5oTxQ@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 7.3 \(1878.6\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Jeff King <peff@peff.net>, Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Sun Mar 20 18:05:46 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahgnR-0004cM-Hy
	for gcvg-git-2@plane.gmane.org; Sun, 20 Mar 2016 18:05:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752487AbcCTRFk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Mar 2016 13:05:40 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35283 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751705AbcCTRFi convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 20 Mar 2016 13:05:38 -0400
Received: by mail-wm0-f67.google.com with SMTP id r129so4986411wmr.2
        for <git@vger.kernel.org>; Sun, 20 Mar 2016 10:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+98BzbhEnu0WQadJyofsAYBkyMxhxe6ZTXtrki8YMEE=;
        b=0LDG5Ve/QPdCVhGS6dBnn/G9SFtyhDCjUtR6pn54MLACtJSfCpH6xH+RQurHz+vM3f
         GfZBWyTPUmPnKxBinly1kizEua49nLmjMv2rezCjZ5NN9uo4Cb0xCaog6AUpQGEWFifK
         UJTCInQ7AfPCQ9nqJZ88NhGg/+54HD8aRLcyvJz3vSBoGGGcKywJe86p3W7FW90Mfhv/
         K7KtfztpBNS1qotGOv8Q/8IIfwdvCgUg/8dLE7DlwMc4/h/4RoXSeBcP95W4XdnIgVLq
         6Bb7EQRwSI0vTTJa5e7XdJXDT1WJXNuXs92hycyOST1f5pUE7eh/kh3o3cLMjLK/7Bg7
         1Iwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=+98BzbhEnu0WQadJyofsAYBkyMxhxe6ZTXtrki8YMEE=;
        b=j65M+Lk4p6TNjS3kXQhNxhaOijy0L4rls2cj6ebauviZtskhA0+OWC48suk6TnJAhZ
         CP2X2WfuQRiyDkCelJ4Z7dKdOIwxOxz2iFFGGs9DWKPn+jKg+Bd/Y8ZQjkmVITBXv0LS
         yVpZypIe6ULqyX5enXH4mBQrOnSWRUeYRl67RRCP3q4CFZajA41eUFdADOf6Vhaey4kp
         pAe4+x6lO+5THbEgx94kYCLJtitfZhsk3HjWsgymKDPghKSdTSX3orWI+Dvk/pEm6zrQ
         f4f5ekZhU+NgEhWHKvwG3kDXEE8xnmvUxtXWZcPLcHUa+LGHqfrcaNLeuyhu1ACgUQoS
         f1+A==
X-Gm-Message-State: AD7BkJJaH155nFgRi8xKHrmzrEzy4sgJH+U1M/MhIuUgZE4Ae2JaxxE6OSVucqo/1WwniQ==
X-Received: by 10.28.52.197 with SMTP id b188mr9925440wma.77.1458493537398;
        Sun, 20 Mar 2016 10:05:37 -0700 (PDT)
Received: from slxbook3.fritz.box (p5DDB416B.dip0.t-ipconnect.de. [93.219.65.107])
        by smtp.gmail.com with ESMTPSA id da6sm21467696wjb.24.2016.03.20.10.05.35
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 20 Mar 2016 10:05:36 -0700 (PDT)
In-Reply-To: <CAGZ79kYzbmzK1UwvWheugkqG0FwhpGMU0_K_jyCKOnoKb5oTxQ@mail.gmail.com>
X-Mailer: Apple Mail (2.1878.6)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289368>


On 15 Mar 2016, at 20:50, Stefan Beller <sbeller@google.com> wrote:

> On Sun, Dec 20, 2015 at 3:19 PM,  <larsxschneider@gmail.com> wrote:
>> From: Lars Schneider <larsxschneider@gmail.com>
>> 
>> "git clone --recursive --depth 1 --single-branch <url>" clones the
>> submodules successfully. However, it does not obey "--depth 1" for
>> submodule cloning.
> 
> I am about to resend "[RFC/PATCH] clone: add `--shallow-submodules` flag"
> which would need tests and I thought about this series as tests.
Sounds good, thanks!


> I assume patch 2 (fixing a broken && chain in tests) made it through,
> but patch 1 and 3 did not? I may pick up ideas from here as it will be
> slightly different tests I'd guess.
Unfortunately patch 2 ($gmane/282776) did not made it in (I just checked 
next 104e649). How should we proceed?

> 
> 
>> +test_expect_failure shallow-clone-recursive '
>> +       URL="file://$(pwd | sed "s/[[:space:]]/%20/g")/repo" &&
> 
> This would break if the test suite is in a path containing any other white space
> than U+0020 such as a tab? (Not that I am encouraging using such paths...)
True. I wonder if we really need to use the "file://" URL format here. Maybe
a relative would be easier?!


Thanks,
Lars