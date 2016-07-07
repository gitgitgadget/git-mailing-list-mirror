Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E05E2070D
	for <e@80x24.org>; Thu,  7 Jul 2016 16:04:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751673AbcGGQEj (ORCPT <rfc822;e@80x24.org>);
	Thu, 7 Jul 2016 12:04:39 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:64571 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750859AbcGGQEh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Jul 2016 12:04:37 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 47B7A29F5B;
	Thu,  7 Jul 2016 12:04:36 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; s=sasl; bh=jfoKeJP8R4uKw23L3ueZ/hRgy
	kw=; b=Yr8T2ILtWb6thG8Rd4noD+sil+CXJoOLYQX/XiVw9RmMElOclMuknrKvp
	/QYzWqsyFdFpmdkY4U73gzUJRZGDsPAatV0GFMbCnfrDZmDopfQ0ln8FYIr6Bczi
	m0qMH5lXSh2WJ32qTst1RXqqxhjK56e/buaH4NvfYJK4jxMhvU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type
	:content-transfer-encoding; q=dns; s=sasl; b=hX4eil9ANGrTYDM/s+w
	Wst9pqK4swMTIWJCzf4favXKIl3rV0OltR/9aZ1ZpLBne8vx+G+Fucy+ViA7QXfM
	ifSYM+BDcFr8sdn6TrrGrUIZWeirbWyOVdlITyigMhDVyB0CX9LmH/CvZuvX1QuZ
	mYv/SwMhUrGcl7OfdE+12N40=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 3EFC329F5A;
	Thu,  7 Jul 2016 12:04:36 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B575429F59;
	Thu,  7 Jul 2016 12:04:35 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:	Mike Hommey <mh@glandium.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
Subject: Re: [PATCH] am: counteract gender bias
References: <d54f8f8b32ecc024eb3a58dd42ef9f855f8e2cb9.1467892022.git.johannes.schindelin@gmx.de>
	<20160707124943.GA22668@glandium.org> <577E580B.5090000@gmail.com>
Date:	Thu, 07 Jul 2016 09:04:33 -0700
Message-ID: <xmqq37nlqvse.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 800FC8EC-445C-11E6-89B0-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: 8BIT
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Jakub Narębski <jnareb@gmail.com> writes:

> Also, in all (?) other places we use "ours" and "theirs"; it looks like
> git-am was a strange exception with "ours" and "his" (also, it was/is
> inconsistent in using plural vs singular form).  Though perhaps it was
> created before the terminology solidified...

I also thought that "ours" vs "his" was strange mixture of plural
and singular when I first saw it, but it turns out there was no
mixture.

It originates at 47f0b6d5 (Fall back to three-way merge when
applying a patch., 2005-10-06), where the code used $his_tree and
$orig_tree, (there was no reference to "our" tree), both singular.
They were copied to "git am" introduced at d1c5f2a4 (Add git-am,
applymbox replacement., 2005-10-07) almost verbatim.

The use of "ours" & "theirs" is now established, and I agree with
you that the use of "his" that is contained to the fall_back_3way
helper function (cf. contrib/examples/git-am.sh) is an oddball.

We should just use "theirs" to be consistent from the beginning, as
you suggested.  There is no need to churn the codebase for political
correctness to first use "hers" that everybody knows will *not* be
the final form.
