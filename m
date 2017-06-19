Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62CEE1FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 15:48:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753545AbdFSPr6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 11:47:58 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33307 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750828AbdFSPr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 11:47:56 -0400
Received: by mail-pf0-f195.google.com with SMTP id w12so17749383pfk.0
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=AOvD+kbbMets2iqpM+bgXaBC9iCKBr/1FvR/q5XZVoo=;
        b=ccZzdjHZVbBNAryV5HAzYkLArO8nWK+NAcuddKUbqIlGGOzn/ac75QH6ukUZcnbbKh
         PBQtNk7he+gYFRG3iCplKvHYrkTGi3chBpID8eDpZfgQWCMrYa32GVehSmzD8l3oqPph
         Npbk00+7EBYqpi1+sJ0AX8d7AX3vecFjwK1QFGeNhFZ8xZ3p8MjfqRkX+KMj2X0GunKn
         KNc4wiif3lxGgd//cOUV1oPC6yZ3tL4PP57TSMMxgSe6GycA9UCdlcAfVXAnY1l2HFMW
         i42oLNo+5LzmUF6oyKEB2zoT2zvE585n3+xpkTcQqfYjCAeWf2dbZbrbNmCs6DPwiRpt
         jjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=AOvD+kbbMets2iqpM+bgXaBC9iCKBr/1FvR/q5XZVoo=;
        b=Bob7cB47DqMdCQaxEu3Ktfm+FH0ADh69Q2df0op+TgOJw6ILtWkdiKKSfHxv/HDmwo
         339X6DjZa5r20g6PkEyGWOdo7sOdF1pDwmygvv6MG4dy6vbtVVk2srCAPoUovo8q6kmu
         AIp8fteDGkR+Vq5ni7IEy9jE2RPnKcNg/3660YK8VzyAj2lacJs0Aa22+8u35Jbk0uMs
         v4UEOoZSeJNDddHh0h9+ACfpycYHMLNFrp6xn17QawMEzZ0ntDKSfsmOb3qTVXWAMTx/
         cF48ooslEnV5t77QLBOQLuBAbQGeUbGMGi7MO1M/ZUNxEKEuoCp5IPYLoH+9FsyK8PIh
         NMcw==
X-Gm-Message-State: AKS2vOyEPwqzMDbMEdyEuZdm+fPCUv69xYjFMdASSLrUX8SB46TiJEvt
        hBbouk4E52RMHw==
X-Received: by 10.98.205.194 with SMTP id o185mr25778251pfg.105.1497887275503;
        Mon, 19 Jun 2017 08:47:55 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:7466:3d2b:4ee9:fc7])
        by smtp.gmail.com with ESMTPSA id s7sm25209012pfd.86.2017.06.19.08.47.54
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 08:47:54 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net
Subject: Re: [PATCH/ALMOST FINAL] Contextually notify user about an initial commit
References: <1497771338.1689.4.camel@gmail.com>
        <20170618075301.6431-1-kaarticsivaraam91196@gmail.com>
        <87shix8zik.fsf@gmail.com>
        <20170619091050.kymih3f345kexaf7@sigill.intra.peff.net>
Date:   Mon, 19 Jun 2017 08:47:53 -0700
In-Reply-To: <20170619091050.kymih3f345kexaf7@sigill.intra.peff.net> (Jeff
        King's message of "Mon, 19 Jun 2017 05:10:51 -0400")
Message-ID: <xmqqshiwt1w6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sun, Jun 18, 2017 at 10:34:59AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> Why not simply "No commits yet", saying "on the branch" is needlessy
>> duplicating information in the context of the status output in which
>> this is printed, i.e. now you have:
>> 
>>     $ ~/g/git/git-status
>>     On branch master
>> 
>>     No commits yet on the branch
>> 
>>     nothing to commit (create/copy files and use "git add" to track)
>> 
>> But we can just more succinctly say:
>> 
>>     $ ~/g/git/git-status
>>     On branch master
>> 
>>     No commits yet
>> 
>>     nothing to commit (create/copy files and use "git add" to track)
>> 
>> Since we've already pointed out that the user is on a branch.
>
> I thought one of the points was to disambiguate the case of "no commits
> yet in the repository" and "no commits yet on the branch". If we don't
> care about making that distinction (or think that the mention of the
> branch is enough to make it clear), then succinct is fine. I don't have
> a strong opinion either way.

Neither do I.  As long as we always say "On branch X", the end
result would not make much difference with or without "on the
branch" at the end of this line, I would think.

Thanks.
