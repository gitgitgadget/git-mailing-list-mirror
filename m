Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 088C1C433E0
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:32:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D213E20826
	for <git@archiver.kernel.org>; Mon, 18 May 2020 17:32:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="4ZUB1Vot";
	dkim=pass (1024-bit key) header.d=spkdev.net header.i=@spkdev.net header.b="OUHEiON4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728445AbgERRcV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 13:32:21 -0400
Received: from ns3309586.ip-5-135-160.eu ([5.135.160.121]:54046 "EHLO
        mail.spkdev.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727942AbgERRcV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 13:32:21 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        by mail.spkdev.net (Postfix) with ESMTP id 3973B405FC;
        Mon, 18 May 2020 17:32:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1589823139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ethDdenFwTFU2+TWTn4IkmyFrE+CG6MH40gb9xhN5E=;
        b=4ZUB1Vot2Z7cTapnE38vF5bPTzne5Fto2yqEX9RdIJd0nKTBBnojx9wRoXsKcHgH3y680T
        BjEQ1KA+BIf5IX+FiUT2PCctzanSNuB+o/TWKTBUJfiIFxxv8Dh+EiSlY1MdgmHgiy5bog
        v4AgNs2pMH7QVgnh9L5wRBvIrejEEXw=
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.spkdev.net (Postfix) with ESMTPSA id B373440158;
        Mon, 18 May 2020 17:32:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spkdev.net; s=default;
        t=1589823138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ethDdenFwTFU2+TWTn4IkmyFrE+CG6MH40gb9xhN5E=;
        b=OUHEiON4JCT0TUejLXvyHKaOjyd8cmh2N1Del2atdFlnZBXJUPxExQBJ0NO1rEWxSk6cNZ
        ScR5aA0JrXWK9JS5rGDdg58xL5UAmmko2LV9EZ4Lwla0rSVdqLsCiBFUWqp+hGobXHIPfJ
        DljcAfi9GDP2Lubg6LoTTrtSvfig4to=
Date:   Mon, 18 May 2020 19:32:18 +0200
From:   Laurent Arnoud <laurent@spkdev.net>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, phillip.wood@dunelm.org.uk,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Subject: Re: [PATCH v5] diff: add config option relative
Message-ID: <20200518173218.GD2110@spk-laptop>
References: <20200515155706.GA1165062@spk-laptop>
 <20200515233130.GC6362@camp.crustytoothpaste.net>
 <xmqq1rnk923o.fsf@gitster.c.googlers.com>
 <20200516173828.GB34961@spk-laptop>
 <92cb6302-09a8-6780-9398-890b1e766680@gmail.com>
 <20200516194033.GA2252@spk-laptop>
 <20200517021452.GA2114@danh.dev>
 <xmqqlflq7fyd.fsf@gitster.c.googlers.com>
 <20200518094021.GA2069@spk-laptop>
 <20200518135656.GB1980@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200518135656.GB1980@danh.dev>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Danh,

On Mon, May 18, 2020 at 08:56:56PM +0700, Đoàn Trần Công Danh wrote:
> Thanks for addressing my comment.
> 
> Sorry for detecting this late.
> Since I usually only look into end of mail-archive to see any
> interesting topic.
> 
> And sorry for this late email,
> I want to run full test before replying with this.
> 
> I've just seen this:
> https://lore.kernel.org/git/xmqq1rnk923o.fsf@gitster.c.googlers.com/
> 
> I've written some test and concluded that we'll need this fix-up
> to make sure git-format-patch(1) doesn't generate broken patch:

No worries this Junio is ok for this I've added a test instead in
t/t4014-format-patch.sh ensuring that format-patch respects the config
diff.relative on the v6 of the patch, let me know what you think

> Nitpick:
> 
> I don't think this option is too special to add a newline to separate
> it from the rest :)
> 
> Sorry about not seeing this earlier, I'm a very careless person.
> 
> Anyway, I think (just a matter of my _personal_ preference),
> it's better to move it up 21 lines, together with:
> 
> 	options->flags.rename_empty = 1;
> 

Applied in the v6

> > @@ -86,4 +87,80 @@ do
> >  	check_$type . dir/file2 --relative=sub
> >  done
> > 
> > +	diff --git a/$expect b/$expect
> > +	new file mode 100644
> > +	index 0000000..$short_blob_file2
> > +	--- /dev/null
> > +	+++ b/$expect
> > +	@@ -0,0 +1 @@
> > +	+other content
> > +	EOF
> > +	test_expect_success "config diff.relative $relative_opt -p $*" "
> > +		test_config -C $dir diff.relative $relative_opt &&
> > +		git -C '$dir' diff -p $* HEAD^ >actual &&
> > +		git -C '$dir' diff -p $* HEAD^ >/tmp/actual &&
> 
> Please this leftover from debugging.

Opps fixed and thanks again for the review

-- 
Laurent
