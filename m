Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 718DDC433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 22:53:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57932610CF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 22:53:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241024AbhKIW4F (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 17:56:05 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50499 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S243533AbhKIWzm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 17:55:42 -0500
Received: from [192.168.9.206] (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1A9MqaFE009459
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 9 Nov 2021 17:52:37 -0500
Message-ID: <316e8579-d720-b40e-66fb-3280e8de1922@mit.edu>
Date:   Tue, 9 Nov 2021 14:52:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: [PATCH v4 1/4] fetch: Protect branches checked out in all
 worktrees
Content-Language: en-US
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Andreas Heiduk <andreas.heiduk@mathema.de>
References: <a25d105a-875b-fa6a-771a-37936779f067@mit.edu>
 <20211109030028.2196416-1-andersk@mit.edu>
 <nycvar.QRO.7.76.6.2111091706290.54@tvgsbejvaqbjf.bet>
From:   Anders Kaseorg <andersk@mit.edu>
In-Reply-To: <nycvar.QRO.7.76.6.2111091706290.54@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/9/21 08:09, Johannes Schindelin wrote:
>> +		    (wt = find_shared_symref("HEAD", ref_map->peer_ref->name)))
> 
> Do we need `&& !wt->is_bare` here, too?

Sure (in the “future-proofing” sense), will add.

>> +test_expect_success 'refuse fetch to current branch of worktree' '
>> +	test_when_finished "git worktree remove --force wt" &&
> 
> Do we also need `&& git branch -D wt` here?

Will add.

>> +	git fetch -u . HEAD:wt
> 
> Maybe even `test_path_exists wt/apple.t`, to verify that the worktree has
> been updated?

Not here; git fetch -u never updates working trees, not even the main 
working tree.  Is that a bug?  I don’t know, but if it is, it’s 
certainly a separate one.

Anders
