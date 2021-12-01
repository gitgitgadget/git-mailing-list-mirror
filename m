Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFA76C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 23:48:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353872AbhLAXvf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 18:51:35 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:47142 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1353828AbhLAXvc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 18:51:32 -0500
Received: from [192.168.9.206] (198-27-191-186.fiber.dynamic.sonic.net [198.27.191.186])
        (authenticated bits=0)
        (User authenticated as andersk@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1B1Nler7011000
        (version=TLSv1/SSLv3 cipher=AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 1 Dec 2021 18:47:41 -0500
Message-ID: <f8262c3b-2ca5-4920-1379-41ff29b37d9f@mit.edu>
Date:   Wed, 1 Dec 2021 15:47:40 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v7 4/8] worktree: simplify find_shared_symref() memory
 ownership model
Content-Language: en-US
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Andreas Heiduk <andreas.heiduk@mathema.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>
References: <20211201221547.1796213-1-andersk@mit.edu>
 <20211201221547.1796213-5-andersk@mit.edu>
 <CAPig+cSNP-RBmsWWfT690-shFUCZ3J0X+FBiNjCqg=AkoBMBqQ@mail.gmail.com>
From:   Anders Kaseorg <andersk@mit.edu>
In-Reply-To: <CAPig+cSNP-RBmsWWfT690-shFUCZ3J0X+FBiNjCqg=AkoBMBqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/1/21 15:10, Eric Sunshine wrote:
> As far as I can see, this code only cares whether find_shared_symref()
> returned a result; it doesn't actually consult the returned worktree
> at all, thus it semantically considers `worktree` as a boolean, not as
> a `struct worktree`.

No, the update_worktree(new_oid->hash, worktree) call uses it in a 
non-boolean way, so we do need to keep it around.

Anders
