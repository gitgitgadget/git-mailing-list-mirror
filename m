From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Mon, 12 Oct 2015 20:42:17 +0200
Message-ID: <CAHGBnuMU6d3rqW6sa=u+mE-95zRJZvopJVdLQAUi=-cc+xW86A@mail.gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
	<1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
	<561B69AE.8050403@gmail.com>
	<xmqq37xgnkh0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: larsxschneider@gmail.com, Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	tboegi@web.de, pw@padd.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 20:42:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zli3H-0001Do-3F
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 20:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbbJLSmV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 14:42:21 -0400
Received: from mail-ig0-f176.google.com ([209.85.213.176]:36899 "EHLO
	mail-ig0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751892AbbJLSmS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 14:42:18 -0400
Received: by igcpe7 with SMTP id pe7so86869529igc.0
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 11:42:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=IxAZf/4VC39Dd/c/dfppIxiIsmNcUTdYt1/Z6UrFF04=;
        b=VQGJ9zQ+Sfxw1kD1e5YcHRPGXwYFC/2rXODc697wwuen3zHvSqsX2jqjQBAYrPlzG5
         e+sDT0F7JjMdMgC7a0+jDQwP4C876lIcBXYIBGnXvknVWoFWhRfNPCvO3wGCI5g6db9w
         w2+b6Y30qSjVuuSV1rM/5fqtKIxJqdcDvPaQYiy97PmUwN3wp5MV1IpjilIuxtHrRC32
         +wns/Sqrn2iHc7t0nTZvRTwmcKCPkoE7yRiGgQ1HeZ9LlntAFBOKY2NPDxD+zyakMziu
         nC6orzWFiZaSZpDzsetSiKI8aavsHP0vB2F7QK9DmZbARbkie5jVcRBI/PXczPaN9EwH
         YUpQ==
X-Received: by 10.50.73.201 with SMTP id n9mr14678022igv.47.1444675337869;
 Mon, 12 Oct 2015 11:42:17 -0700 (PDT)
Received: by 10.107.138.213 with HTTP; Mon, 12 Oct 2015 11:42:17 -0700 (PDT)
In-Reply-To: <xmqq37xgnkh0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279393>

On Mon, Oct 12, 2015 at 6:02 PM, Junio C Hamano <gitster@pobox.com> wrote:

>> Semantically, it does not seem correct to me that configuarion goes to
>> the install step. As "make test" will build git anyway, I'd instead
>> propose to get rid of "install" and just say:
>>
>> before_script: make configure && ./configure
>>
>> script: make --quiet test
>
> Very good point.  Do we even need to do anything in the "install"
> target?  We aim to be able to testable without any installed Git,
> and not running "make install" at all, ever, would be one way to
> make sure that works.

Note that Travis' "install" step is about installing dependencies for
the application to build [1], not for installing the built application
(i.e. what "make install" does). In any case, I still think
configuring the application to built in this step is wrong.

> we are to start using automated tests, I wonder if we want to build
> (and optionally test) with various combinations of the customization
> options (e.g. NO_CURL, NO_OPENSSL, NO_MMAP, NO_IPV6, NO_PERL etc.)

I like that idea, but I think we should save that for a future
improvement to .travis.yml.

[1] http://docs.travis-ci.com/user/installing-dependencies/

-- 
Sebastian Schuberth
