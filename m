Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 250551F404
	for <e@80x24.org>; Thu,  4 Jan 2018 18:57:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752368AbeADS5G (ORCPT <rfc822;e@80x24.org>);
        Thu, 4 Jan 2018 13:57:06 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:61945 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750959AbeADS5F (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Jan 2018 13:57:05 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B776DCA81B;
        Thu,  4 Jan 2018 13:57:04 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ZV7el+DZ3NirFUtP5vCSOuSIO34=; b=VaNTpp
        UGtMnxKy3Pv+sVMEIhigGxl5N8ULgiSapslkj+x88SD8tUsJRuJJa+r5e2nNvKBY
        de6fJ70zCqQPaPUN8AER8nygB+RnBP+YTdo+IP7jxPuv0YtA/ph85/fF0T99ZQFW
        VLn9afCD04tG/NdVwoI39/7Y6JJjz0/t76TqM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SWjtsuapst9tsNGa+SbN551YCJr/7ESa
        VLLA5bIkIuvTnYhVtTLe9wjyIelogtZwFn98mFqzcizjpae9Cd6oTrKTVpA9fFV/
        7Coh+RMcq5mpeQTSxD0ymIi3ZQUxCNO3Gkf25CSIHbJRnht/9Sy1ZIBIvAPFEeA4
        8c6vave5hsA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id AA141CA81A;
        Thu,  4 Jan 2018 13:57:04 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 086DBCA80F;
        Thu,  4 Jan 2018 13:57:03 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Matwey V. Kornilov" <matwey.kornilov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Fwd: Unknown option for merge-recursive: -X'diff-algorithm=patience'
References: <9e4ffb63-59de-a020-fee8-6cefae3b3dda@gmail.com>
        <CAJs94Eakp6kaD=+imH2cZdB-=2NCBJNu0Rt=MmRtWiM60QGBSA@mail.gmail.com>
        <p2l6s0$eot$1@blaine.gmane.org>
Date:   Thu, 04 Jan 2018 10:57:02 -0800
In-Reply-To: <p2l6s0$eot$1@blaine.gmane.org> (Matwey V. Kornilov's message of
        "Thu, 4 Jan 2018 15:34:04 +0300")
Message-ID: <xmqqefn5fo5d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0DABCC78-F181-11E7-B8F7-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Matwey V. Kornilov" <matwey.kornilov@gmail.com> writes:

> It seems there is some issue with double escaping:
> ...
>> # git rebase --preserve-merges -s recursive -Xdiff-algorithm=patience
>> --onto abc-3.8 v3.8 abc-3.9
>> 
>> And then I see:
>> 
>> fatal: Unknown option for merge-recursive: -X'diff-algorithm=patience'

The string looks like a result of a shell script that quotes any
end-user controlled string before incorporating into a string to be
eval-ed, or something like that.  Is this a recent regression?  Does
a bit older version of Git, like 2.12 or older, behave differently?

