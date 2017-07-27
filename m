Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DE0A20899
	for <e@80x24.org>; Thu, 27 Jul 2017 23:51:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751620AbdG0XvE (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jul 2017 19:51:04 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:32809 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751604AbdG0XvD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2017 19:51:03 -0400
Received: by mail-pf0-f171.google.com with SMTP id d67so21190756pfc.0
        for <git@vger.kernel.org>; Thu, 27 Jul 2017 16:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p/wkyirJCDqumVv79di7LZPbCz7aLpswOVEVmbdPwuo=;
        b=af+O570jewNTIycl18+Wag6RZaUhMXQnwyg9bE2u00YpkWi0xaPMUbRLww89h8pj0P
         nMSUii4E8fRF+/dKM4dCvN3y5gJ4gimjOfnshrf/uZ/XvPvbSikQt4jwiq4PeGAt/PkY
         TDYb/gGZeuJ2e7yFKAKYOSYdr3ogregW0QdkFisFDuM+DirRCaMx/JsdYndUloClkxKE
         KVcAQoLRz4gMGlVtBrzUA/xxm8ACl0YKPjyat1NspYp77CPVPDg25ZHOUmZbovTZ6V2M
         cik4vqZl0mLnMNEcfd9CbNQI+kyw/8LCE0sQlej30C3ff/ix7VBpQQUaZedIZDws/uIz
         DnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p/wkyirJCDqumVv79di7LZPbCz7aLpswOVEVmbdPwuo=;
        b=ZqifZS4UPEGrRHqD18zi1vpvWGkf/oouW8ZPgoBtZvEBI3Od6SgNCEaXsNaHPFBMsZ
         LZ4GsXFkvl1UMHeF0khXtIRnT2MXfbq6dOqiXFLF901wBCXbJKLZsjIYaU1q1ehzGdT8
         aoHJCa2ck5uLasXPX0O7wGLzUW/+YYzmylD8q5Xi120qTRhxIbpXM/uA0/UuZsXgQHZQ
         kKWqfkP4awgIsIy4v9GiVoI3TjCvzR7bYvrasT/eGxypL2MSqIOS16teKbvQn9YpFn81
         uHa1jY6bNZjEk3wlixL3CD1Ikwgl2DwSshkztdWzgbqz9TSIC/obrd/YWAsYsFXRmN6+
         EQUw==
X-Gm-Message-State: AIVw111ugd2yFB5+2K9/9N6eNUM3hwB0ZO+Em9eex3xZnFJ5V2JHkQ6N
        gDbfv3XiUWnnKz/7
X-Received: by 10.101.86.74 with SMTP id m10mr5592825pgs.79.1501199463033;
        Thu, 27 Jul 2017 16:51:03 -0700 (PDT)
Received: from twelve2.svl.corp.google.com ([2620:0:100e:422:6055:1975:96d0:9b69])
        by smtp.gmail.com with ESMTPSA id p24sm26334774pfk.128.2017.07.27.16.51.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 27 Jul 2017 16:51:02 -0700 (PDT)
Date:   Thu, 27 Jul 2017 16:50:58 -0700
From:   Jonathan Tan <jonathantanmy@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peartben@gmail.com, christian.couder@gmail.com
Subject: Re: [RFC PATCH 2/4] fsck: support refs pointing to lazy objects
Message-ID: <20170727165058.4eda505e@twelve2.svl.corp.google.com>
In-Reply-To: <xmqqvamdn1ss.fsf@gitster.mtv.corp.google.com>
References: <cover.1501111615.git.jonathantanmy@google.com>
        <cover.1501111615.git.jonathantanmy@google.com>
        <4c8bc7ab543d8d0d60719f65bd8a150c66123056.1501111615.git.jonathantanmy@google.com>
        <xmqqvamdn1ss.fsf@gitster.mtv.corp.google.com>
X-Mailer: Claws Mail 3.9.3 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 27 Jul 2017 11:59:47 -0700
Junio C Hamano <gitster@pobox.com> wrote:

> > @@ -438,6 +438,14 @@ static int fsck_handle_ref(const char *refname, const struct object_id *oid,
> >  
> >  	obj = parse_object(oid);
> >  	if (!obj) {
> > +		if (repository_format_lazy_object) {
> > +			/*
> > +			 * Increment default_refs anyway, because this is a
> > +			 * valid ref.
> > +			 */
> > +			default_refs++;
> > +			return 0;
> > +		}
> >  		error("%s: invalid sha1 pointer %s", refname, oid_to_hex(oid));
> >  		errors_found |= ERROR_REACHABLE;
> 
> At this point, do we know (or can we tell) if this is a missing
> object or a file exists as a loose object but is corrupt?  If we
> could, it would be nice to do this only for the former to avoid
> sweeping a real corruption that is unrelated to the lazy fetch under
> the rug.

Before all this is run, there is a check over all loose and packed
objects and I've verified that this check reports failure in
corrupt-object situations (see test below).

It is true that parse_object() cannot report the difference, but since
fsck has already verified non-corruptness, I don't think it needs to
know the difference at this point.

> > +test_expect_success 'fsck fails on lazy object pointed to by ref' '
> > +	rm -rf repo &&
> > +	test_create_repo repo &&
> > +	test_commit -C repo 1 &&
> > +
> > +	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
> > +
> > +	# Reference $A only from ref, and delete it
> > +	git -C repo branch mybranch "$A" &&
> > +	delete_object repo "$A" &&
> > +
> > +	test_must_fail git -C repo fsck
> > +'
> 
> And a new test that uses a helper different from delete_object
> (perhaps call it corrupt_object?) can be used to make sure that we
> complain in that case here.

I agree that object corruption can cause this specific part of the
production code to falsely work. But I think that this specific part of
the code can and should rely on object corruption being checked
elsewhere. (I usually don't like to assume that other components work
and will continue to work, but in this case, I think that fsck checking
for object corruption is very foundational and should be relied upon.)

But if we think that defense "in depth" is a good idea, I have no
problem adding such tests (like the one below).

---
delete_object () {
	rm $1/.git/objects/$(echo $2 | cut -c1-2)/$(echo $2 | cut -c3-40)
}

corrupt_object () {
	chmod a+w $1/.git/objects/$(echo $2 | cut -c1-2)/$(echo $2 | cut -c3-40) &&
	echo CORRUPT >$1/.git/objects/$(echo $2 | cut -c1-2)/$(echo $2 | cut -c3-40)
}

setup_object_in_reflog () {
	rm -rf repo &&
	test_create_repo repo &&
	test_commit -C repo 1 &&

	A=$(git -C repo commit-tree -m a HEAD^{tree}) &&
	B=$(git -C repo commit-tree -m b HEAD^{tree}) &&

	# Reference $A only from reflog
	git -C repo branch mybranch "$A" &&
	git -C repo branch -f mybranch "$B"
}

test_expect_success 'lazy object in reflog' '
	setup_object_in_reflog &&
	delete_object repo "$A" &&
	test_must_fail git -C repo fsck &&
	git -C repo config core.repositoryformatversion 1 &&
	git -C repo config extensions.lazyobject "arbitrary string" &&
	git -C repo fsck
'

test_expect_success 'corrupt loose object in reflog' '
	setup_object_in_reflog &&
	corrupt_object repo "$A" &&
	test_must_fail git -C repo fsck &&
	git -C repo config core.repositoryformatversion 1 &&
	git -C repo config extensions.lazyobject "arbitrary string" &&
	test_must_fail git -C repo fsck
'

test_expect_success 'missing packed object in reflog' '
	setup_object_in_reflog &&
	git -C repo repack -a &&
	delete_object repo "$A" &&
	chmod a+w repo/.git/objects/pack/*.pack &&
	echo CORRUPT >"$(echo repo/.git/objects/pack/*.pack)" &&
	test_must_fail git -C repo fsck &&
	git -C repo config core.repositoryformatversion 1 &&
	git -C repo config extensions.lazyobject "arbitrary string" &&
	test_must_fail git -C repo fsck
'
