Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CA69420209
	for <e@80x24.org>; Thu, 25 May 2017 02:55:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937733AbdEYCzG (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 May 2017 22:55:06 -0400
Received: from mail-pf0-f176.google.com ([209.85.192.176]:36521 "EHLO
        mail-pf0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932535AbdEYCzE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 May 2017 22:55:04 -0400
Received: by mail-pf0-f176.google.com with SMTP id m17so153309739pfg.3
        for <git@vger.kernel.org>; Wed, 24 May 2017 19:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=AFW/lgW7TRxwd0upGg15hGAeUb4g9pVucEjie7z0xQo=;
        b=co21KmfwQ4e0uI2RSlmTf0b20Fdssb6FsoA0FutUHh4pwbHWlBhiFOSlUUVG7hNsTK
         hmsrOkCMHCdJDpNzJSOaaw0tadM/Cwo8mRLEd8pZOf8s8NIESmg68sRtk07S2wPzeLep
         LF6AhHT2vb2grOlL9F0hPxMHvxuOLOE5430T6d8nfoXgwnRSgRVI1WomAOVouuy8ilIL
         8mABPzJTR/cmsKzWMxUknahCXXKTIDJy8KavhFC2ixCNoiuQVrAFaCePluiQp1rgy7dn
         NQCgnWebzyCa9bv9MWXeVtpHV5pWrV/X7qiNwaoQdK2Y71ck5PeTwdoHzy/ukNcPympD
         24qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=AFW/lgW7TRxwd0upGg15hGAeUb4g9pVucEjie7z0xQo=;
        b=VDboPjzY7r4EGyYBTyziwzB8iXe1ceY5fRA+Rf3825VF5gpQAbsoYfMmg4GWO4tYj8
         tIJ82ebJ1g5NdsP9Ye4O/ElDAw62dpr2k44YyVSH0Z/v7mZ4o6Ud6+A1jf7ZZ7yUfF64
         zJsYLCq7tURl26ppRDSLhbIO/ubNdzORIE8dGeqkrKNEhJC40HUgGOGqEU7XwC/sOQIk
         lm9cauWkBK89NMfaOnAl9b2eIgCs7PkMipqtfGeMuUFANFLk/jmodugQNI//VwTPbLG0
         k6CWx5ok+R1SV2rWGsY8wJRcxZTTJ9vYeAfxtFaBMEOKlyKMT788BgINhOjgBUiFFpMe
         3Q/w==
X-Gm-Message-State: AODbwcBIhAN1ojnTe8SXIPYUte992nVGlhT2sqX4iQBZh1qxKWfN0uHC
        xSmyIsiVU47QrA==
X-Received: by 10.84.176.131 with SMTP id v3mr47125726plb.138.1495680903580;
        Wed, 24 May 2017 19:55:03 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:bc81:1d63:7e7e:dfa1])
        by smtp.gmail.com with ESMTPSA id l16sm886512pgu.45.2017.05.24.19.55.02
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 24 May 2017 19:55:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     ch <cr@onlinehome.de>, git@vger.kernel.org
Subject: Re: Passing revs to git-bundle-create via stdin
References: <76491764-cd43-ef7f-fbfc-939a15f2fb77@onlinehome.de>
        <20170523164641.u3rd7bgc7ifvu2su@sigill.intra.peff.net>
        <xmqqwp97hvvi.fsf@gitster.mtv.corp.google.com>
Date:   Thu, 25 May 2017 11:55:02 +0900
In-Reply-To: <xmqqwp97hvvi.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 24 May 2017 10:44:01 +0900")
Message-ID: <xmqqefvdfxx5.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> I think what's happening is that git-bundle actually runs _two_
>> traversals using the command-line arguments. ...
>> ... It was just a way of confirming my
>> guess about the double-read.
>>
>> The real solutions I can think of are:
>>
>>   1. Teach git-bundle not to require the double-read. I'm not sure why
>>      it's written the way it is, but presumably it would be tricky to
>>      undo it (or we would have just written it the other way in the
>>      first place!)
>
> If I remember correctly, the reason why it does the double-read is
> because it wants to cope with things like "--since".  There is no
> explicit bottom of the DAG specified on the command line, and the
> first one (without "--objects") is done to find "prerequisites" that
> are written in the header.
>
> Then the packdata is generated, which does another traversal (this
> time with "--objects" option).
>
> So perhaps the right way to fix it is to keep the first traversal
> as-is, but update the second one (I think write-bundle-refs is the
> culprit) so that it does not use the user-supplied command line
> as-is; instead it should use the positive end of the history from
> the command line with the negative end set to these "prerequisites"
> commits.
>
> I said "command line" in the above, but read that as "end user
> input"; the list of rev-list command line arguments given from the
> standard input is exactly the same deal.

Actually, after thinking a bit more about this, I think the bundle
we currently generate may be a bit less efficient than ideal when
options like --since or --max-count are used.

Imagine a history of this shape (child grows on the right hand side):

 A---D-----E-----G---H
      \         /
       B---C---F

The labels on commits also denote their timestamps in relative
terms, i.e. A has the oldest timestamp, D, even though it is a
parent of B, has newer timestamp than B has, etc.

Now, imagine running "git log --since=$time H" with time set to the
timestamp commit D has.  We traversal from H, following parent chain,
and stop when we see a commit with timestamp older than $time.  So,
we'd enumerate H G F E D; C and A are "boundaries"---we looked at,
but we decided not to include in the result.

A bundle file format records "By using this bundle, you can advance
your history up to this commit", which can be seen by running "git
ls-remote" on the bundle file.  It also records "However, this
bundle does not record the entire history; you need to have the
complete history behind these commits".  These are called
"prerequisites", and can be checked with "git bundle verify".
And then of course it has an actual packfile (which is thin).

So putting all together,

	git bundle create mybundle --since=$time H

would record H as its head, and also C and A as prerequistes.

The "double reading of --stdin" we have been discussing is there
because we run two traversals; the first one is to find the
prerequisites (i.e. C and A in the above example).  The second one
uses the same rev-list arguments (i.e. "--since=$time H") to
generate pack, so it will include D.

As the recipient of a bundle is required to have complete history
behind both A and C, however, the packfile generated with the
current proceess is inefficient--it includes D but it does not need
to.

If we change the argument to rev-list used in the actual packfile
generation, and instead use the boundary we learned during the first
traversal (i.e. A and C in the above example) and the tip of the
history being recorded in the resulting bundle (i.e. H), then we'd
run "git log ^A ^C H", which would only walk "H G F E".

Which would be smaller (it no longer includes D), and the recipient
who has A and C can still apply.
