Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958E9207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 01:12:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S948274AbdDUBMI (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 21:12:08 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54132 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S948238AbdDUBMH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 21:12:07 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 55F427EF6C;
        Thu, 20 Apr 2017 21:12:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=qUctDA+A78IuuoaSdNu4pyj9u4o=; b=XL2znc
        9ml0fu2lHTXbMMe1Y0eybargfuNJRnv8HkYlC6e3G5esHbRaOJB4oNjBy9Cn365m
        jAL7QggOQF79NvT5AOPxfMgRX2v1CyxFmWhtVOrKal5sUr9vPTHbcnW0jCHlj0YC
        ebug4EU8J33D6j3UKvaXFMS05LlHlrZg7t4mM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=vUGTCnHlu78tPReRoubFLo0NwdVaqsOX
        DhVSiuStU5ZMIeGl4JGwdPm6yz0hrPUPuT3gJrcWxISSLWbT/EBWr2pjQiyBENS8
        eigFOt/2ctkscb30yJ/AvlKtCE6+Z3WuEOzlMkCjIPD52FGoa2GVkgChqhDPDB9u
        9Rv0QbuEQz8=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4DDCA7EF6B;
        Thu, 20 Apr 2017 21:12:06 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B3B347EF6A;
        Thu, 20 Apr 2017 21:12:05 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Michael Haggerty <mhagger@alum.mit.edu>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] refs.h: rename submodule arguments to submodule_path
References: <20170412200037.18752-1-sbeller@google.com>
        <CAGZ79kYTqh=Qa+Pt1+MojrcYFr05HQgbPRcc=DvjCkUWsjP5Uw@mail.gmail.com>
Date:   Thu, 20 Apr 2017 18:12:04 -0700
In-Reply-To: <CAGZ79kYTqh=Qa+Pt1+MojrcYFr05HQgbPRcc=DvjCkUWsjP5Uw@mail.gmail.com>
        (Stefan Beller's message of "Thu, 20 Apr 2017 11:21:04 -0700")
Message-ID: <xmqqy3uu7ee3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 88BD6BF6-262F-11E7-8CAB-C260AE2156B6-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> + Junio

Just like Michael, I do not have strong enough opinion for or
against this patch to comment on it.

I do agree with you that it would be a good longer-term direction to
use "submodule" for a "struct submodule" (i.e. submodule object),
and call a string that names a submodule either "submodule_name" or
"submodule_path" depending on how it names one, for maintainability
of the code.  

However I am not convinced that this patch is an improvement.  Even
though parameter names in decls only serve documentation purpose and
it is even OK to only have type without name there, if we are going
to _have_ names, it would make sense to match them to the parameter
names actually used in the implementation.  

Updating these names used in refs.c would make a very noisy patch,
of course.  But I am not sure if it is a good middle ground to avoid
that and to update only refs.h.

