From: Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v2] t1700: make test pass with index-v4
Date: Fri, 20 Mar 2015 20:59:43 +0100
Message-ID: <20150320195943.GB6545@hank>
References: <xmqqtwxfee6a.fsf@gitster.dls.corp.google.com>
 <1426875630-17481-1-git-send-email-t.gummerer@gmail.com>
 <xmqqd243e9xe.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eSA8cGNsb3Vkc0BnbWFpbC5jb20+?=@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 21:00:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZ35F-0004hK-E0
	for gcvg-git-2@plane.gmane.org; Fri, 20 Mar 2015 20:59:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbbCTT7s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2015 15:59:48 -0400
Received: from mail-wi0-f176.google.com ([209.85.212.176]:37457 "EHLO
	mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751191AbbCTT7q (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Mar 2015 15:59:46 -0400
Received: by wixw10 with SMTP id w10so842261wix.0
        for <git@vger.kernel.org>; Fri, 20 Mar 2015 12:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=DQxCYxeAc7gdUJ4qHSqTIDYyVYihTmD2qZ9+aq56SY4=;
        b=nbsx6/md5cf5uwQlL0AmU63rszewCyVcfcyJnyAb83Bznof/cLzgbvdUsPP2vXwFO6
         vWLPS4mAJKn+apAzTKIiMUpBB4N0glgtP0FPweyfcv4czH7GX7OpWMmKBFn8g8Hz5bGP
         7rQFVbHI7t8qTX26Ce9xEn+kZMnvSfkZD3dxDNfZXKgMGi9lzv+BNazPP5HjgD6R5M4j
         e/kSouibrbobVcs4bz3ym3hgF2baCAHotHUHopLk4m6GieWNXiAPGy4P1LBAOFoslCRQ
         G6EnezVcYQ0luS/0SiHAk+v25HJshtEfnjZQM78JXYemqyA1ei4D0w8r22LteEWQMY4w
         PxXA==
X-Received: by 10.180.8.165 with SMTP id s5mr7892832wia.16.1426881585556;
        Fri, 20 Mar 2015 12:59:45 -0700 (PDT)
Received: from localhost (213-66-41-37-no99.tbcn.telia.com. [213.66.41.37])
        by mx.google.com with ESMTPSA id s5sm397445wia.1.2015.03.20.12.59.44
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 20 Mar 2015 12:59:44 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqd243e9xe.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265960>

On 03/20, Junio C Hamano wrote:
> Thomas Gummerer <t.gummerer@gmail.com> writes:
>
> > The different index versions have different sha-1 checksums.  Those
> > checksums are checked in t1700, which makes it fail when the test suite
> > is run with TEST_GIT_INDEX_VERSION=4.  Fix it.
> >
> > Signed-off-by: Thomas Gummerer <t.gummerer@gmail.com>
> > ---
> >> An updated patch to mention "when run with TEST_GIT_INDEX_VERSION=4"
> >> in the log message was what I was asking for ;-)
> >
> > Sorry I didn't catch that.  Here it is.
>
> Thanks.  Is this the only one that fails with v4?

Yes, with this patch the test suite passes with TEST_GIT_INDEX_VERSION
set.

I've now tried to set the GIT_TEST_SPLIT_INDEX environment variable
and run the tests, and quite a few seem to fail for both v3 and v4.
I'm looking into that now, but that seems to be unrelated to index v4,
and I'm not sure yet if I'm testing the right thing.

> >
> >
> >  t/t1700-split-index.sh | 15 ++++++++++++---
> >  1 file changed, 12 insertions(+), 3 deletions(-)
> >
> > diff --git a/t/t1700-split-index.sh b/t/t1700-split-index.sh
> > index 94fb473..92f7298 100755
> > --- a/t/t1700-split-index.sh
> > +++ b/t/t1700-split-index.sh
> > @@ -10,9 +10,18 @@ sane_unset GIT_TEST_SPLIT_INDEX
> >  test_expect_success 'enable split index' '
> >  	git update-index --split-index &&
> >  	test-dump-split-index .git/index >actual &&
> > +	indexversion=$(test-index-version <.git/index) &&
> > +	if test "$indexversion" = "4"
> > +	then
> > +		own=432ef4b63f32193984f339431fd50ca796493569
> > +		base=508851a7f0dfa8691e9f69c7f055865389012491
> > +	else
> > +		own=8299b0bcd1ac364e5f1d7768efb62fa2da79a339
> > +		base=39d890139ee5356c7ef572216cebcd27aa41f9df
> > +	fi &&
> >  	cat >expect <<EOF &&
> > -own 8299b0bcd1ac364e5f1d7768efb62fa2da79a339
> > -base 39d890139ee5356c7ef572216cebcd27aa41f9df
> > +own $own
> > +base $base
> >  replacements:
> >  deletions:
> >  EOF
> > @@ -30,7 +39,7 @@ EOF
> >
> >  	test-dump-split-index .git/index | sed "/^own/d" >actual &&
> >  	cat >expect <<EOF &&
> > -base 39d890139ee5356c7ef572216cebcd27aa41f9df
> > +base $base
> >  100644 e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 0	one
> >  replacements:
> >  deletions:

--
Thomas Gummerer
