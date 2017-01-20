Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1992D20756
	for <e@80x24.org>; Fri, 20 Jan 2017 17:33:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751676AbdATRdw (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jan 2017 12:33:52 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58734 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751328AbdATRdv (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jan 2017 12:33:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E81461668;
        Fri, 20 Jan 2017 12:33:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3RHbxMOTe+sf
        wVSfUhCQ0lnXfbo=; b=NGLil0WWHwZ7Hhh4F/puQ0LKe0zTSJknlO22CiveAkDi
        tmNw7KzYx2+2CHqQCxr5KULAEh1VN1xXKh4DB3HxZM6mrNDTY4K5lSIji7NUcw9p
        D00NSZ7ZkvJcf8GWurF0Hee2N+qFQGipVNTmTXjx0p44NqqtrgjMGySNATuMGNI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=TOKHn1
        WQznlKC6DPM0v593s7nGAIo4DAtsZTbzedF/1rB5/jzAqHrYDYeChCE2aZKwJGgM
        HMlekoRM/0SKXrN54+IpS3ZWpabNxoaDyloam77MS+dr9BU6rFUC97cC04VShtAL
        tRtEYZJ8MM+JIUe6Hzzaosye99SDdqRVvA/XU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8667D61666;
        Fri, 20 Jan 2017 12:33:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CE3B761665;
        Fri, 20 Jan 2017 12:33:49 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     "David J. Bakeman" <nakuru@comcast.net>,
        Jacob Keller <jacob.keller@gmail.com>,
        Git mailing list <git@vger.kernel.org>
Subject: Re: merge maintaining history
References: <58798686.5050401@comcast.net>
        <CA+P7+xoF8E55-XDnQT-GN1=hEwwq4pOsz7--P-SCy29C7ST3Hg@mail.gmail.com>
        <5880BB23.8030702@comcast.net>
        <xmqq37gezpz8.fsf@gitster.mtv.corp.google.com>
        <38ca43cb-2fc7-0448-352f-7d9413f815c5@gmail.com>
Date:   Fri, 20 Jan 2017 09:33:48 -0800
In-Reply-To: <38ca43cb-2fc7-0448-352f-7d9413f815c5@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Fri, 20 Jan 2017 12:37:37
 +0100")
Message-ID: <xmqqpojhy6tf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9AC52D2E-DF36-11E6-9028-FE3F13518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

> Then you would have the above history in repositories that fetched
> refs/replace/*, and the one below if replacement info is absent:
>
>    original A<-B<-C<-D<-E<-F<-----------M
>                 \                      /
>    first branch  b<-c<-d<-e           /
>                                      /
>    new repo               e*<-f->g->h
>
> But as Junio said it is highly unlikely that you are in this situation.

I do not think I said it is highly unlikely.  I just said that I
didn't read in what David wrote that he did some unusual things, so
I based my conclusion on that assumption.  People who bring problems
here sometimes forget to tell crucial details, and that missing
piece of information often changes how the situation should be
handled.
