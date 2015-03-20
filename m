From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH 1/2] test-lib: allow using split index in the test suite
Date: Fri, 20 Mar 2015 23:12:39 +0100
Message-ID: <20150320221239.GC6545@hank>
References: <20150320195943.GB6545@hank>
 <1426887794-9655-1-git-send-email-t.gummerer@gmail.com>
 <1426887794-9655-2-git-send-email-t.gummerer@gmail.com>
 <xmqqvbhvcp14.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eSA8cGNsb3Vkc0BnbWFpbC5jb20+?=@vger.kernel.org,
	Jaime Soriano Pastor <jsorianopastor@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 23:12:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ59x-0000ir-5N
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 23:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751164AbbCTWMn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 18:12:43 -0400
Received: from mail-wg0-f41.google.com ([74.125.82.41]:33894 "EHLO
	mail-wg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751129AbbCTWMn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 18:12:43 -0400
Received: by wggv3 with SMTP id v3so100229076wgg.1
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 15:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=CPeZ080a9v8BYVxvy0sVz3pmXcMuj/EQHQo1jefQXyc=;
        b=Nq8Xxte8dLiu3w8i25LW2OtT2BB37oeZrKvU9kstu8DN7W8SgWHEdpYbWn9cmR7/RQ
         sB5voAlkcpt1z8A0TpB9RMGl0bju2cmeDSnxHx49d0zVelnGiy7HiXZZJ2qDJsXONcN1
         Y19GVkFaJQUUwJNvRqT1o4UvYwvZ2wnscvLGt3ul5/yy/+1c/xXUNIqqjK2r2FvT6GGu
         TS0AIbFSO8sd3ciGTIpjh/4thMbjR8eemD6WtllIns1TAci+9NBPyvpxaHrj+YhgD9ER
         PCzvjiURznujsdoSbBKPHS0r5LcKm+diePMSTy/ZgEyxyk1qiFATHevsOxD0dc0mR05g
         Nn5Q==
X-Received: by 10.194.179.41 with SMTP id dd9mr167380180wjc.72.1426889561848;
        Fri, 20 Mar 2015 15:12:41 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id p1sm682965wib.23.2015.03.20.15.12.40
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2015 15:12:41 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqvbhvcp14.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265973>

On 03/20, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
> > Allow adding a TEST_GIT_TEST_SPLIT_INDEX variable to config.mak to run
> > the test suite with split index enabled.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
>
> > ---
>
> Hmm, it is not wrong per-se, but would it be too much trouble to do
>
>     GIT_TEST_SPLIT_INDEX=YesPlease make test
>
> or is this doing something a lot more than that?

No that would work as well, I just thought of it as analogous to
TEST_GIT_INDEX_VERSION and it might be more convenient to set it once
and keep it in the config.mak for some people, to check that split
index doesn't break.  In any case I do not feel strongly about this.


> >  Makefile      | 6 ++++++
> >  t/test-lib.sh | 6 ++++++
> >  2 files changed, 12 insertions(+)
> >
> > diff --git a/Makefile b/Makefile
> > index 44f1dd1..55e558a 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -339,6 +339,9 @@ all::
> >  # with a different indexfile format version.  If it isn't set the index
> >  # file format used is index-v[23].
> >  #
> > +# Define TEST_GIT_TEST_SPLIT_INDEX to 1 to run the test suite with split
> > +# index enabled.
> > +#
> >  # Define GMTIME_UNRELIABLE_ERRORS if your gmtime() function does not
> >  # return NULL when it receives a bogus time_t.
> >  #
> > @@ -2129,6 +2132,9 @@ endif
> >  ifdef TEST_GIT_INDEX_VERSION
> >  	@echo TEST_GIT_INDEX_VERSION=\''$(subst ','\'',$(subst ','\'',$(TEST_GIT_INDEX_VERSION)))'\' >>$@
> >  endif
> > +ifdef TEST_GIT_TEST_SPLIT_INDEX
> > +	@echo TEST_GIT_TEST_SPLIT_INDEX=\''$(subst ','\'',$(subst ','\'',$(TEST_GIT_TEST_SPLIT_INDEX)))'\' >>$@
> > +endif
> >
> >  ### Detect Python interpreter path changes
> >  ifndef NO_PYTHON
> > diff --git a/t/test-lib.sh b/t/test-lib.sh
> > index c096778..477f253 100644
> > --- a/t/test-lib.sh
> > +++ b/t/test-lib.sh
> > @@ -119,6 +119,12 @@ then
> >  	export GIT_INDEX_VERSION
> >  fi
> >
> > +if test -n "${TEST_GIT_TEST_SPLIT_INDEX:+isset}"
> > +then
> > +	GIT_TEST_SPLIT_INDEX="$TEST_GIT_TEST_SPLIT_INDEX"
> > +	export GIT_TEST_SPLIT_INDEX
> > +fi
> > +
> >  # Add libc MALLOC and MALLOC_PERTURB test
> >  # only if we are not executing the test with valgrind
> >  if expr " $GIT_TEST_OPTS " : ".* --valgrind " >/dev/null ||

--
Thomas Gummerer
