Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2335F1F859
	for <e@80x24.org>; Thu,  1 Sep 2016 04:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752452AbcIAEJ4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Sep 2016 00:09:56 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:54811 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752268AbcIAEJx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2016 00:09:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 248483B574;
        Thu,  1 Sep 2016 00:09:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=5SEZZ6QfAsY/dcs2f5mfvR+AWJY=; b=VaC4qU
        NcwGP956cW2scUQjELvHYrNSoJv8L4//iFFZhNxDXxq5cMaGRK70qpOut0kBhVOH
        gcSENokzdQzQGl2vd8eF8uEcaBhaViqxvy/87T2dl7KzgJm/zogSkKkiLHLJeVXs
        ZO3soL2kIm6Asdx5m0z8wp1qzqDGA7Y3OIUgM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FpCRnT+lH0B3RlpgN2K7AuNsFjYJAXRb
        Y2qzbeYhXYpZvw4V1WNzMfIHvbv65ZMDeVhxIYzpNFeGn4VVfFg3nO/STOiXmSxl
        K6HSJU6XtVY5vQrvIgg2bi6JW2ur5q+NWWnXzvmPUVME9qqLSutgV6WUDoTQ8ijp
        pu9kB6M3Y2M=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1B70C3B573;
        Thu,  1 Sep 2016 00:09:44 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8B5ED3B572;
        Thu,  1 Sep 2016 00:09:43 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Uma Srinivasan <usrinivasan@twitter.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Stefan Beller <sbeller@google.com>
Subject: Re: git submodules implementation question
References: <CAN5XQftQH8B+hWVh4JQgZwAp+rkbz51P5NZDc_+Tfm0EB1zkew@mail.gmail.com>
        <xmqqlgzf9wch.fsf@gitster.mtv.corp.google.com>
        <CAN5XQft6S+LG0mBgRFPrMZiOxHSfRhjLmQdeMdBeHKoWQSRUEA@mail.gmail.com>
        <CAPc5daVhY6WdHkXGLYea48uOw0-rTzLLZ=7mNo=VPebZ9AG4jQ@mail.gmail.com>
        <CAN5XQfty6Fshzf6kN7eXhFekU9+=VPwbzEPN1a92yVB=9nm0Vg@mail.gmail.com>
        <CAN5XQfsg_sJbyjfdc=-e85jiCQNUqagwgh6TVOXN+NskZ7KkVw@mail.gmail.com>
        <xmqqbn0b6ua8.fsf@gitster.mtv.corp.google.com>
        <CA+P7+xosGg955msq-gyKz_HyCZf7fPFQJdKZ3P8U3+poBBfuWA@mail.gmail.com>
        <CAN5XQfsv+BEYDWR6Xjs4mCtYDVR12a2UzB1-_H4A_xfjUUOe2g@mail.gmail.com>
        <CA+P7+xohfRsoV9VXgUrRaXPb9HvCc5gs4-KSWp38X_d_6EfkTA@mail.gmail.com>
        <CA+P7+xpGnsKzBPLVgPNSmZ7K00vY7-eJp7kSHWMRHM+cOsL_XQ@mail.gmail.com>
        <CAN5XQftCC+TUm2Jx4q3V9oFbXndtFx3H+daoB3TD3eWUs6s54A@mail.gmail.com>
        <xmqqzinu3zyw.fsf@gitster.mtv.corp.google.com>
        <CAN5XQfuoq6MV4e98RzUCG02KvZO6VZAbs1oxAzpdg5zswqpHGw@mail.gmail.com>
        <xmqq7faw3n5w.fsf@gitster.mtv.corp.google.com>
Date:   Wed, 31 Aug 2016 21:09:41 -0700
In-Reply-To: <xmqq7faw3n5w.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Wed, 31 Aug 2016 09:42:35 -0700")
Message-ID: <xmqqk2ewxnui.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E9775C82-6FF9-11E6-AFD8-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> I was wondering if we should unconditionally stuff GIT_DIR=<the
> repository location for the submodule> in the cp.env_array passed to
> the function prepare_submodule_repo_env().  As cp.dir will be set to
> the submodule's working tree, there is no need to set GIT_WORK_TREE
> and export it, I think, although it would not hurt.

After checking all callers of prepare_submodule_repo_env() and saw
that cp.dir is set to the top of working directory for the
submodule, I wonder if something as simple and stupid like the
attached patch is sufficient.  Our subprocess will go there, and
there should be a .git embedded directory or a .git file that points
into .git/modules/* in the superproject, and either way, it should
use .git directly underneath it.

 submodule.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/submodule.c b/submodule.c
index 1b5cdfb..e8258f0 100644
--- a/submodule.c
+++ b/submodule.c
@@ -1160,4 +1160,5 @@ void prepare_submodule_repo_env(struct argv_array *out)
 		if (strcmp(*var, CONFIG_DATA_ENVIRONMENT))
 			argv_array_push(out, *var);
 	}
+	argv_array_push(out, "GIT_DIR=.git");
 }

