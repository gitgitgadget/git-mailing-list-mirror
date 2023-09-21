Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB682E7D0A2
	for <git@archiver.kernel.org>; Thu, 21 Sep 2023 20:01:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231527AbjIUUBR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Sep 2023 16:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbjIUUAm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Sep 2023 16:00:42 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47535AE245
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 11:58:08 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c09673b006so10849745ad.1
        for <git@vger.kernel.org>; Thu, 21 Sep 2023 11:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695322687; x=1695927487; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7BlYXzXwfXH7TH2OeXPpQqBbuKBUFZWdur3uSR6Ksss=;
        b=G29JygHUlhdUpvEAumaDTXhW2HIJTMRo6WD2957z8r16S8UQ0xBfQ6UGneDQARGUpH
         IG+/BqyEx+dSAMKdGRQXsp6ivc+myxml6sBlc9YGvopzX0en7XtkfltEVXOaQFrUD8y4
         1D27Ngo7BDQSRb6QHN9sD8r25DlWpNWUJ3LdK0lnRaZrRdWx6YrbATBiToHv6/tRKucE
         syvKz9my52xLe5KhVKSQ5/QfnwpvapZiy/SPqJK++Q8RyTVzIuz95/+Zp2WKRdN2Gcbq
         ac/FLUoEYKJDptCkug2GU17NI8OL49gHqNdzFGS/zKyInlUPMJNklBo8nm8f7W5LOljf
         /YBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695322687; x=1695927487;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7BlYXzXwfXH7TH2OeXPpQqBbuKBUFZWdur3uSR6Ksss=;
        b=guRmj2fb/1ffj7jvPXdec6lzoIbXqqT9cC+mtNkNlrvYdSwJmj0gIS1DlHf/UkeP2Q
         kyaqeivZtkPHT87NaPm/EY+AWTBPQZXGGw3KzxaZSxhojux9iHg3XGufPQoXvmO6Tj4M
         8kW3ksZnIbWIyTpuV52xy+uQRoDCWAsC46KBsVzEvbo5de4IvJizUheOqJX4U+aAokyo
         vdjLWhvjO+OPcH8JkGeJc+BWMc1j5rDBNHYVJfzEeG3HByUmCahx4v+NwlSgoIU1fiCG
         /Qgd1I495wnlDhP+DA4y4rqprDV4ibGGnTFWoeqIQoaMP4nKNLQGLEGwwJ93aCwoxRpP
         ovyQ==
X-Gm-Message-State: AOJu0YyvEHja2aNLr4GiL/ZzI8X5gYosOCCyVrMEHLoBX/7vIHmmaYeF
        awfKaD1kYfRApLx/YksHSzM=
X-Google-Smtp-Source: AGHT+IFY+x/yn92PSkx329jpsMpJbGD3a7oDZSYg0UEMLrmJWo9Ab1FXM22pX7jeqPG7m/DMyo4/0Q==
X-Received: by 2002:a17:902:7443:b0:1c4:4462:f1bd with SMTP id e3-20020a170902744300b001c44462f1bdmr5688361plt.35.1695322687253;
        Thu, 21 Sep 2023 11:58:07 -0700 (PDT)
Received: from five231003 ([49.37.156.130])
        by smtp.gmail.com with ESMTPSA id n11-20020a170902d2cb00b001c1f4edfb9csm1868853plc.173.2023.09.21.11.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Sep 2023 11:58:06 -0700 (PDT)
Date:   Fri, 22 Sep 2023 00:27:46 +0530
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: Re: [PATCH 1/2] t/t6300: introduce test_bad_atom()
Message-ID: <ZQySKnKEirmhXN-U@five231003>
References: <20230920191654.6133-1-five231003@gmail.com>
 <20230920191654.6133-2-five231003@gmail.com>
 <xmqqy1h078tf.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqy1h078tf.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the late reply.

On Wed, Sep 20, 2023 at 03:56:28PM -0700, Junio C Hamano wrote:
> Kousik Sanagavarapu <five231003@gmail.com> writes:
> 
> > Introduce a new function "test_bad_atom()", which is similar to
> > "test_atom()" but should be used to check whether the correct error
> > message is shown on stderr.
> >
> > Like "test_atom()", the new function takes three arguments. The three
> > arguments specify the ref, the format and the expected error message
> > respectively, with an optional fourth argument for tweaking
> > "test_expect_*" (which is by default "success").
> >
> > Mentored-by: Christian Couder <christian.couder@gmail.com>
> > Mentored-by: Hariom Verma <hariom18599@gmail.com>
> > Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> > ---
> >  t/t6300-for-each-ref.sh | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/t/t6300-for-each-ref.sh b/t/t6300-for-each-ref.sh
> > index 7b943fd34c..15b4622f57 100755
> > --- a/t/t6300-for-each-ref.sh
> > +++ b/t/t6300-for-each-ref.sh
> > @@ -267,6 +267,26 @@ test_expect_success 'arguments to %(objectname:short=) must be positive integers
> >  	test_must_fail git for-each-ref --format="%(objectname:short=foo)"
> >  '
> >  
> > +test_bad_atom() {
> 
> Style: have SP on both sides of "()".
> 
> [...]
>
> > +	printf '%s\n' "$3">expect
> 
> Style: need SP before (but not after) '>'.

I'll make these style changes, they slipped by.

> > +	test_expect_${4:-success} $PREREQ "err basic atom: $1 $2" "
> > +		test_must_fail git for-each-ref --format='%($2)' $ref 2>actual &&
> > +		test_cmp expect actual
> > +	"
> 
> It is error prone to have the executable part of test_expect_{success,failure}
> inside a pair of double quotes and have $variable interpolated
> _before_ even the arguments to test_expect_{success,failure} are
> formed.  It is much more preferrable to write
> 
> 	test_bad_atom () {
> 		ref=$1 format=$2
> 		printf '%s\n' "$3" >expect
> 		$test_do=test_expect_${4:-success}
> 
> 		$test_do $PREREQ "err basic atom: $ref $format" '
> 			test_must_fail git for-each-ref \
> 				--format="%($format)" "$ref" 2>error &&
> 			test_cmp expect error
> 		'
> 	}
> 
> This is primarily because you cannot control what is in "$2" to
> ensure the correctness of the test we see above locally (i.e. if
> your caller has a single-quote in "$2", the shell script you create
> for running test_expect_{success,failure} would be syntactically
> incorrect).  By enclosing the executable part inside a pair of
> single quotes, and having the $variables interpolated when that
> executable part is `eval`ed when test_expect_{success,failure} runs,
> you will avoid such problems, and those reading the above can locally
> know that you are aware of and correctly avoiding such problems.

I see.

> I guess three among four problems I just pointed out you blindly
> copied from test_atom.  But let's not spread badness (preliminary
> clean-up to existing badness would be welcome instead).

Yeah, I had copied it from test_atom. Although I didn't realize that it
was bad to implement test_bad_atom the way I did. Thanks for such a nice
explanation. So I guess we can include the test_atom cleanup in this
series?

> > +}
> > +
> > +test_bad_atom head 'authoremail:foo' \
> > +	'fatal: unrecognized %(authoremail) argument: foo'
> > +
> > +test_bad_atom tag 'taggeremail:localpart trim' \
> > +	'fatal: unrecognized %(taggeremail) argument:  trim'
> 
> It is strange to see double SP before 'trim' in this error message.
> Are we etching a code mistake in stone here?  Wouldn't the error
> message say "...argument: localpart trim" instead, perhaps?
> 
> >  test_date () {
> >  	f=$1 &&
> >  	committer_date=$2 &&

So I read the the other replies and it seems that it indeed hides a
breakage and yeah I hadn't tested PATCH 1/2 independently. I'll change
this too.

Thanks
