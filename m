From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] t7601: test for pull.ff=true overrides merge.ff=false
Date: Thu, 14 May 2015 09:45:19 -0700
Message-ID: <xmqqy4kr85wg.fsf@gitster.dls.corp.google.com>
References: <1431510740-9710-1-git-send-email-pyokagan@gmail.com>
	<1431510740-9710-2-git-send-email-pyokagan@gmail.com>
	<2a5e49ff1cc3a0275e09328a3ad07866@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Paul Tan <pyokagan@gmail.com>, git@vger.kernel.org,
	Stefan Beller <sbeller@google.com>,
	David Aguilar <davvid@gmail.com>
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 14 18:45:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YswGQ-0002YL-4P
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 18:45:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933826AbbENQpY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 12:45:24 -0400
Received: from mail-ig0-f181.google.com ([209.85.213.181]:37385 "EHLO
	mail-ig0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933617AbbENQpW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 12:45:22 -0400
Received: by igbsb11 with SMTP id sb11so77898579igb.0
        for <git@vger.kernel.org>; Thu, 14 May 2015 09:45:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=b4sBuY4PbBVye4+jT5TshSiq8HgBI9i+YTk1/MmJsNk=;
        b=gV6VuI1v1iCiDwMFeeZA5SPPKJ5IVzfHoZU+6upjnsDfBWZatNwKOXoKQyuQSDYZ6y
         INUhzpUxO7WL3ApboU5XaiswnXiZhKuxW4YNUXjajFeKbAdBIgUK9xwTKLbv8xbJVteI
         rVn0bGqYgJfXXKv5D24h2fHxC+ZyVKrcBaipADBXD11oxH/J7oHNfkO5O5EnsnKbilEi
         Lw5RXOkPLNpzA1ne4QqkqCY3kA4y9+iUgWxqwR2ZRPQaGOnRF4HTy1g1s/kP3GyecrJ+
         9IKC/HWuy8dTrhJxpfa4Kf+AT+9giVOc/lKS8cOnLpzVYUiZMeDO1fKlizPq9DAxWid9
         lVpw==
X-Received: by 10.50.30.69 with SMTP id q5mr7574219igh.11.1431621921221;
        Thu, 14 May 2015 09:45:21 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:74eb:19e4:cd06:a6b6])
        by mx.google.com with ESMTPSA id e6sm6180317igy.15.2015.05.14.09.45.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 14 May 2015 09:45:20 -0700 (PDT)
In-Reply-To: <2a5e49ff1cc3a0275e09328a3ad07866@www.dscho.org> (Johannes
	Schindelin's message of "Thu, 14 May 2015 15:06:18 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269042>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

>> +	verbose test "$(git rev-parse HEAD)" = "$(git rev-parse c1)"
> 
> Given that Junio objected to this "verbose test", maybe you want to remove the "verbose"? Or introduce a `test_assert_equal` of the form
>
> ```sh
> test_assert_equal () {
>     test "a$1" = "a$2" || {
>         echo "$1 != $2" >&2
>         false
>     }
> }
> ```
>
> Hmm. Now that I think about it, `test_eq` is probably a better name, still.

I do not think using "two strings" check for that one is very
useful.  You cannot tell where two 40-HEX came from.

And that is why I suggested "-i -v -x".

By the way, I cannot think of a reason why your CI cannot always run
the tests with GIT_TEST_OPTS="-v -x" exported.

> For the sake of having better reporting, say, in Continuous Integration (where re-running tests via `sh -x t????-*.sh -i -v` -- as Junio suggested -- is not an option), I agree that it would be good to report the non-matching strings.
>
> Ciao,
> Dscho
