From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [RFC/PATCH 6/8] config: add core.untrackedCache
Date: Fri, 4 Dec 2015 20:44:34 +0100
Message-ID: <CAP8UFD2dHGR-C8u4+sbNFt9EqcLDDHY_ydBjRvzMb2uWjmKEuA@mail.gmail.com>
References: <1449001899-18956-1-git-send-email-chriscool@tuxfamily.org>
	<1449001899-18956-7-git-send-email-chriscool@tuxfamily.org>
	<565E99F9.2020906@web.de>
	<CACBZZX5eQuaYumFcuW6PO_FCrAd3Vqq8gPyg5JeZ4Kk+0YBGRQ@mail.gmail.com>
	<5661D340.2010305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
	Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jeff King <peff@peff.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	David Turner <dturner@twopensource.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <chriscool@tuxfamily.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Dec 04 20:44:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a4wHZ-00064x-0C
	for gcvg-git-2@plane.gmane.org; Fri, 04 Dec 2015 20:44:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753447AbbLDToh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 4 Dec 2015 14:44:37 -0500
Received: from mail-lf0-f50.google.com ([209.85.215.50]:36752 "EHLO
	mail-lf0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753300AbbLDTog convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Dec 2015 14:44:36 -0500
Received: by lfs39 with SMTP id 39so115579883lfs.3
        for <git@vger.kernel.org>; Fri, 04 Dec 2015 11:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=CzPSXWzCddtko5T6aH0YME5uH1nGmfV/XFg0/tiCAZc=;
        b=n2+fB+pBMBdcl08BhKXdVPByKO31Nekv6eqmUAyXPg04C65+ZFwBCtAdmRagga1yW9
         DHX1O3QFqQCbcA0n8VsYM4Sm99fSluLPxhFTjHcgkbbuAHB4W4cnqU2eBnWmNj9BynRG
         pXiMTAWHqGzWbDyIKmGpVikgQi2CgkTgoWBABx01gcJexkEFKsFxQuZPI+Zk+oJz5vTQ
         j5Z5M9v2ZMXe0xlFQIh6gQRMD9OM4DwHs2vfpGJigLR6XbzD/OeGYRyrTAQWEcVuETZJ
         xyZyqFgqhqV/TIMEr2eyg5ey/9c0TvhaSxsWQ5XU+zOPnIu7iYZyv/06lmOnmw2Q25UT
         Tq3w==
X-Received: by 10.25.42.208 with SMTP id q199mr9082341lfq.67.1449258274786;
 Fri, 04 Dec 2015 11:44:34 -0800 (PST)
Received: by 10.25.152.7 with HTTP; Fri, 4 Dec 2015 11:44:34 -0800 (PST)
In-Reply-To: <5661D340.2010305@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281997>

On Fri, Dec 4, 2015 at 6:54 PM, Torsten B=C3=B6gershausen <tboegi@web.d=
e> wrote:
>> Current state of affairs:
>>
>>  * Enable on a per-repo basis: git update-index --untracked-cache
>>  * Disable on a per-repo basis: git update-index --no-cache
>>  * Enable system-wide: N/A
>>  * Disable system-wide: N/A
>>
>> With this patch:
>>
>>  * Enable on a per-repo basis: git update-index --untracked-cache OR
>> "git config core.untrackedCache true"
>>  * Disable on a per-repo basis: git update-index --no-cache OR "git
>> config core.untrackedCache false"
>>  * Enable system-wide: git config --global core.untrackedCache true
>>  * Disable system-wide: git config --global core.untrackedCache fals=
e
>>  * Caveat: The core.untrackedCache config has precidence over "git u=
pdate-index"
>>
>> With the rest of the patches in this series:
>>
>>  * Enable system-wide & per-repo the same, just tweak
>> core.untrackedCache either for the local .git or --globally
>>  * If you want to test things either per-repo or globally just use
>> "git update-index --test-untracked-cache"
>>  * If you want something exactly like the old --untracked-cache do:
>> "git update-index --test-untracked-cache && git config
>> core.untrackedCache true"
>>
>> I think applying this whole series makes sense. Enabling this featur=
e
>> doesn't work like anything else in Git, usually you just tweak a
>> config option and thus can easily enable things either system-wide o=
r
>> per-repo (or any combination of the two), which makes both system
>> administration and local configuration easy.
>>
>> A much saner UI for the CLI tools if we're going to ship git with
>> tests for filesystem features is to separate the testing from the
>> enabling of those features.
>
> My spontanous feeling: squash 6-8 together and add this nice explanat=
ion
> to the commit message.

Ok, I will do that then.
