From: Sebastian Schuberth <sschuberth@gmail.com>
Subject: Re: [PATCH v3 1/3] Add Travis CI support
Date: Mon, 12 Oct 2015 21:48:44 +0200
Message-ID: <CAHGBnuNxZY9KEo43c31EEm-mzS3wmw-OLkmYa5jYmCJ64a655A@mail.gmail.com>
References: <1444586102-82557-1-git-send-email-larsxschneider@gmail.com>
	<1444586102-82557-2-git-send-email-larsxschneider@gmail.com>
	<561B69AE.8050403@gmail.com>
	<xmqq37xgnkh0.fsf@gitster.mtv.corp.google.com>
	<B85D5671-9F8C-452E-87B9-EB4DE3C85955@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	tboegi@web.de, pw@padd.com
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 21:48:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zlj5W-0007DN-Tq
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 21:48:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352AbbJLTsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 15:48:45 -0400
Received: from mail-ig0-f175.google.com ([209.85.213.175]:38247 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752032AbbJLTsp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 15:48:45 -0400
Received: by igkz10 with SMTP id z10so54281872igk.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 12:48:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wTAVaH+RWsEOh9Yy+X38X6unenlkH9kugrURU3ZPGeM=;
        b=hVy9IF1kZqmQVgZnN2aLrAGEg9TJZzrhuisAXTO7RyNYyo4n3a1DvZWYxFLrF+xxKC
         Q5L1eoHp20yV3bx398G3DCteTUJtZ/ooSqN90mbWIdx5FxompF3Xz0xC+DYNVw9KFe4c
         HxXm7mQV31ghf72g4zfbg9jOaUJaoT21/H4r8/dok3Y+3IwAFxiNLAvaNlktIVwo2MqS
         GDcCQPY46vl+b9ejY+u71yKf1pwO57PGKQkINMohQAYFDJ4eT2j9pRdure6FXtEwySB0
         0/A5bCxYipWsOt1FyXdYtf2bXLNMI9oIFxqsyPOhsbmhJfeGq6XBRjHyYirescAbUaTp
         HQ7w==
X-Received: by 10.50.27.5 with SMTP id p5mr14650707igg.66.1444679324447; Mon,
 12 Oct 2015 12:48:44 -0700 (PDT)
Received: by 10.107.138.213 with HTTP; Mon, 12 Oct 2015 12:48:44 -0700 (PDT)
In-Reply-To: <B85D5671-9F8C-452E-87B9-EB4DE3C85955@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279411>

On Mon, Oct 12, 2015 at 9:40 PM, Lars Schneider
<larsxschneider@gmail.com> wrote:

>> This is a slightly related tangent, but we saw a few build issues
>> reported recently on customized configurations like NO_PTHREAD.  If
>> we are to start using automated tests, I wonder if we want to build
>> (and optionally test) with various combinations of the customization
>> options (e.g. NO_CURL, NO_OPENSSL, NO_MMAP, NO_IPV6, NO_PERL etc.)
> This easy to do. However, the more we environment settings we define the longer the build runs. I created a test matrix that runs the following combinations:
> {Linux | OSX} * {gcc | clang} * {Default, NO_PTHREAD, NO_CURL, NO_OPENSSL, NO_MMAP, NO_IPV6, NO_PERL}
>
> These result in 28 (= 2*2*7) combinations. I created a build without the "Default" environment (=24 combination) here:
> https://travis-ci.org/larsxschneider/git/builds/84978673
>
> Should I add them them to the Travis CI patch?

I'd say it depends on how long such a matrix build would take in
average. Personally, I'd prefer to not wait more than, say, 30 minutes
for testing a PR. From your Travis build history it looks to me as if
we already exceed that limit many fold, so I'd prefer to not use
matrix builds unless we find ways to speed up the build in general,
for example by using ccache [1].

[1] http://docs.travis-ci.com/user/caching/#ccache-cache

-- 
Sebastian Schuberth
