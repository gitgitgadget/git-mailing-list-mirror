From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/2] remote-helpers: move tests out of contrib
Date: Mon, 21 Apr 2014 13:53:03 -0500
Message-ID: <5355690fbe8ad_32c4849310d1@nysa.notmuch>
References: <1398029971-1396-1-git-send-email-felipe.contreras@gmail.com>
 <1398029971-1396-3-git-send-email-felipe.contreras@gmail.com>
 <xmqq7g6ia5rr.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 21:03:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WcJV7-0004z9-RO
	for gcvg-git-2@plane.gmane.org; Mon, 21 Apr 2014 21:03:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754437AbaDUTD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Apr 2014 15:03:29 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]:43903 "EHLO
	mail-yh0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754432AbaDUTD0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Apr 2014 15:03:26 -0400
Received: by mail-yh0-f42.google.com with SMTP id v1so2031741yhn.15
        for <git@vger.kernel.org>; Mon, 21 Apr 2014 12:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=MaaBwBPUw6nfc4GryxqBzMD9bB7HbM15ZBEt0+QBMIw=;
        b=RijlIDtMlkv80Sig+H4/tqDOIN2ZlqfZwP0EqzblrpeGqR9dXrORUu1Zl1hiCBV3sV
         zqqXYEN+Zo8BoCg0oMrS3nbeDFED1nsh/RRPy0t7BkYCd0qtQf8au7zj50CCAzjbNfpy
         EOAC/WLUaoo77fueTOsLgRxiUDmP5BoBQqkcmTVpVesDHlbUrpglUUQGu99tf8BN3VfA
         uHEUuOTOewphLFNTLG6inxvCHIwtNuVVM4MGyJgY3pMw5w3BRwMBpA34uEEMzH85j7Qj
         VzPzKE9hT+RUsL9g8gP6C/9vCFzbug3tJPmqJbUmzvm0JKZYKqBtv9DjR+aRQ0ltfTsj
         GiVA==
X-Received: by 10.236.119.99 with SMTP id m63mr27279770yhh.65.1398107005909;
        Mon, 21 Apr 2014 12:03:25 -0700 (PDT)
Received: from localhost (189-211-224-40.static.axtel.net. [189.211.224.40])
        by mx.google.com with ESMTPSA id c24sm70964755yhc.2.2014.04.21.12.03.24
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Apr 2014 12:03:24 -0700 (PDT)
In-Reply-To: <xmqq7g6ia5rr.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246620>

Junio C Hamano wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
> 
> > They should be tested by default.
> >
> > Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> > ---
> >  contrib/remote-helpers/Makefile                            | 14 --------------
> >  t/Makefile                                                 |  8 +++++++-
> >  .../remote-helpers/test-bzr.sh => t/remote-helpers/bzr.t   |  2 +-
> >  .../test-hg-bidi.sh => t/remote-helpers/hg-bidi.t          |  2 +-
> >  .../test-hg-hg-git.sh => t/remote-helpers/hg-hg-git.t      |  2 +-
> >  contrib/remote-helpers/test-hg.sh => t/remote-helpers/hg.t |  2 +-
> >  6 files changed, 11 insertions(+), 19 deletions(-)
> >  delete mode 100644 contrib/remote-helpers/Makefile
> >  rename contrib/remote-helpers/test-bzr.sh => t/remote-helpers/bzr.t (99%)
> >  rename contrib/remote-helpers/test-hg-bidi.sh => t/remote-helpers/hg-bidi.t (98%)
> >  rename contrib/remote-helpers/test-hg-hg-git.sh => t/remote-helpers/hg-hg-git.t (99%)
> >  rename contrib/remote-helpers/test-hg.sh => t/remote-helpers/hg.t (99%)
> >
> > diff --git a/contrib/remote-helpers/Makefile b/contrib/remote-helpers/Makefile
> > deleted file mode 100644
> > index 239161d..0000000
> > --- a/contrib/remote-helpers/Makefile
> > +++ /dev/null
> > @@ -1,14 +0,0 @@
> > -TESTS := $(wildcard test*.sh)
> > -
> > -export T := $(addprefix $(CURDIR)/,$(TESTS))
> > -export MAKE := $(MAKE) -e
> > -export PATH := $(CURDIR):$(PATH)
> > -export TEST_LINT := test-lint-executable test-lint-shell-syntax
> > -
> > -test:
> > -	$(MAKE) -C ../../t $@
> > -
> > -$(TESTS):
> > -	$(MAKE) -C ../../t $(CURDIR)/$@
> > -
> > -.PHONY: $(TESTS)
> > diff --git a/t/Makefile b/t/Makefile
> > index 8fd1a72..818f4ed 100644
> > --- a/t/Makefile
> > +++ b/t/Makefile
> > @@ -14,6 +14,7 @@ RM ?= rm -f
> >  PROVE ?= prove
> >  DEFAULT_TEST_TARGET ?= test
> >  TEST_LINT ?= test-lint-duplicates test-lint-executable
> > +export TEST_DIRECTORY = $(CURDIR)
> >  
> >  ifdef TEST_OUTPUT_DIRECTORY
> >  TEST_RESULTS_DIRECTORY = $(TEST_OUTPUT_DIRECTORY)/test-results
> > @@ -29,6 +30,9 @@ TEST_RESULTS_DIRECTORY_SQ = $(subst ','\'',$(TEST_RESULTS_DIRECTORY))
> >  T = $(sort $(wildcard t[0-9][0-9][0-9][0-9]-*.sh))
> >  TSVN = $(sort $(wildcard t91[0-9][0-9]-*.sh))
> >  TGITWEB = $(sort $(wildcard t95[0-9][0-9]-*.sh))
> > +TREMOTE = $(wildcard remote-helpers/*.t)
> 
> This step needs a bit more work, I am afraid, to at least have these
> three test scripts follow the same numbering scheme.  Especially given
> that there were recent discussions on allowing a range of tests to
> be run (or omitted) via notations like "5000,5020,9800-9812", not
> doing so now will make it harder to implement such an enhancement.

I don't see how such an enhancement would be beneficial to these remote
helpers. For starters there aren't any number rages left for them, which is the
reason why I created a new directory and handled them in a special way.

There might be other practical reasons to use this numbering scheme (although
I'm sure the scripts could be fixed to not assume those), so I'm OK with having
numbers _for now_, but the range namespace should be different from t/t*.sh; it
should start from 0, since this is a different directory. That would probably
require updating the scripts anyway, so I'm not sure what would be the benefit
of this numbering scheme.

> Also, I noticed that, unlike say t9801 that shows this:
> 
>     $ cd t && make T=t9801-*sh prove
>     rm -f -r 'test-results'
>     *** prove ***
>     t9801-git-p4-branch.sh .. skipped: skipping git p4 tests; no p4 or p4d
>     Files=1, Tests=0,  0 wallclock secs ( 0.03 usr  0.00 sys +  0.00 ...
>     Result: NOTESTS
> 
> these are unnecessarily noisy when refusing to run:
> 
>     $ cd t && make T=remote-helpers/bzr.t prove
>     *** prove ***
>     remote-helpers/bzr.t .. Traceback (most recent call last):
>       File "<string>", line 1, in <module>
>       File "/usr/local/buildtools/current/sitecustomize/sitecu...
>         return real_import(name, globals, locals, fromlist, level)
>     ImportError: No module named bzrlib
>     remote-helpers/bzr.t .. skipped: skipping remote-bzr tests; bzr not available
>     Files=1, Tests=0,  0 wallclock secs ( 0.03 usr  0.00 sys +  0.02 ...
> 
> Can we squelch these expected import error messages?

Sure:

if ! "$PYTHON_PATH" -c 'import bzrlib' > /dev/null 2>&1

-- 
Felipe Contreras
