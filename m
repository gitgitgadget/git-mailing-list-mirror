Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-7.0 required=5.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FBF02018A
	for <e@80x24.org>; Fri, 17 Jun 2016 16:43:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169AbcFQQnV (ORCPT <rfc822;e@80x24.org>);
	Fri, 17 Jun 2016 12:43:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63649 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S933024AbcFQQnS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jun 2016 12:43:18 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A3F4923FEC;
	Fri, 17 Jun 2016 12:43:17 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7FwGoWS8ZWXyZPItoQQAZ56SS28=; b=PXN1Ug
	pqyLrz2QMrUDHIaIPmAXZAVkjXP4FNbnVIRMhDWVGtbyzv6QRZETwuBQgu8rTm18
	PeRhLrRlO3EOSRCGpL/JpCWq3qKP7miXHfYEXsX2Z9rc9dnvoa2FdO8HcTX035b9
	tqZ0bAhKBdycsiZF1IUzq09I77lKbAT+K7zPM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Ku+seSISlFoWSm9OkwA3o7f8u0VraDWr
	5o6Y6Z5PiJ0dvNJ52qtalQnKPMYO/TpE7sPMIY73Q1uqQC28hdVNpM6LtlxLou+p
	cvcG2l8z9oRk68me6p7bRMUdfWV/aMs4OpIjNwx11eqqwA28bXq6ZMNmvIVA6oNw
	DTC9ZJzmu+M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 99B2423FEB;
	Fri, 17 Jun 2016 12:43:17 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2401723FE9;
	Fri, 17 Jun 2016 12:43:17 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Duy Nguyen <pclouds@gmail.com>
Cc:	git@vger.kernel.org, josef@kufner.cz
Subject: Re: [PATCH 0/2] Log pretty format alignment improvements
References: <20160616131838.14440-1-pclouds@gmail.com>
	<xmqqtwgt3s9z.fsf@gitster.mtv.corp.google.com>
	<20160617112707.GA29739@ash>
Date:	Fri, 17 Jun 2016 09:43:15 -0700
In-Reply-To: <20160617112707.GA29739@ash> (Duy Nguyen's message of "Fri, 17
	Jun 2016 18:27:07 +0700")
Message-ID: <xmqqwpln22cc.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9776AA62-34AA-11E6-BDB4-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Duy Nguyen <pclouds@gmail.com> writes:

> Ah ok. This command with this series (using %>(n))
>
> ~/w/git/git log --format='%>(50,trunc)%s' --graph -15 origin/pu
>
> and the system one at version 2.7.3 (using %>|(n))
>
> /usr/bin/git log --format='%>|(50,trunc)%s' --graph -15 origin/pu
>
> both produce the same output like this, checked with md5sum
>
> *   Merge branch 'js/am-3-merge-recursive-direct' in..
> |\  
> | *          am: make a direct call to merge_recursive
> | * merge_recursive_options: introduce the "gently" ..
> * |            Merge branch 'tb/complete-status' into pu
> |\ \  
> | * |                         completion: add git status
> | * |      completion: add __git_get_option_value helper
> | * | completion: factor out untracked file modes into..
> * | |    Merge branch 'mj/log-show-signature-conf' into pu
> |\ \ \  
> | * | |    log: "--no-show-signature" commmand-line option
> | * | | log: add "log.showsignature" configuration varia..
> * | | |              Merge branch 'nd/worktree-lock' into pu
> |\ \ \ \  
> | * | | |  worktree.c: find_worktree() search by path suffix
> | * | | |                     worktree: add "unlock" command
> | * | | |                       worktree: add "lock" command
> | * | | |               worktree.c: add is_worktree_locked()
>
> The output looks weird though, which makes me a bit hesitate to add it
> in the test suite...

It may become easier to see if you used %<(N) vs %<|(N) instead?
