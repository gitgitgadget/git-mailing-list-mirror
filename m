Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,URIBL_SBL,
	URIBL_SBL_A shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4192A1F461
	for <e@80x24.org>; Thu, 22 Aug 2019 19:32:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389273AbfHVTcL (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Aug 2019 15:32:11 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63311 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388609AbfHVTcL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Aug 2019 15:32:11 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 014666C258;
        Thu, 22 Aug 2019 15:32:09 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=4pmy/IC7eusS
        dbmONPbIsGjNuHM=; b=yOqoVXj8Dv2HvLifk4HfQdENU61Dx9idkFmzRhxOZABM
        9nJ1H7pRkYvEFAFwPGuwxr/Jax4qcBxHuC9omTg3zBl+RME5BnvE2EXKI3Gk5WkP
        ajdYh931IPjDtVQvvsK9L+wiepS1E1ncgaG4uugar63wOPOL8tagToHSvdsKnwM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=WYdenV
        MtO8JLXjtDcRRr6tTnLTT04eQ01uBUKqwlqfm6c4Tua5+7nPbaCQI6FSBFcl6ukN
        KVGx3CMr18pbaavncpdNqhCZW46mIcV+96CJVxh4FNIxA4IU05133RWrxyoL4ZXf
        D9UXVARK3NN/rez8X99mBKfyHIuR1d7zopEPE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EDC246C257;
        Thu, 22 Aug 2019 15:32:08 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 1F98E6C256;
        Thu, 22 Aug 2019 15:32:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     "Saravanan Shanmugham \(sarvi\)" <sarvi@cisco.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: First Git status takes 40+ minutes, when mounting fileystem/diskimage with 50G GIT repo + 900G of builds articles
References: <2303C0BB-C532-4560-8BCA-A05DAD97EB72@cisco.com>
        <b409d16f-c392-7f1f-79a0-e14e70148cad@kdbg.org>
Date:   Thu, 22 Aug 2019 12:32:03 -0700
In-Reply-To: <b409d16f-c392-7f1f-79a0-e14e70148cad@kdbg.org> (Johannes Sixt's
        message of "Thu, 22 Aug 2019 21:15:54 +0200")
Message-ID: <xmqq4l29ov2k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8666FF72-C513-11E9-A6EA-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Sixt <j6t@kdbg.org> writes:

> Am 22.08.19 um 20:02 schrieb Saravanan Shanmugham (sarvi):
>> We have a diskimage/fileysystem that has a 50G Git repository + 900G
>> of binary/build articles and untracked files. When we mount such a
>> diskimage, The verify first =E2=80=9Cgit status=E2=80=9D command can t=
ake as long
>> 40-50minutes. Subsequent =E2=80=9Cgit status=E2=80=9D finish in under =
5-10 seconds.>
>> If I had a diskimage of just the 50G source repository, and I mount
>> and do a =E2=80=9Cgit status=E2=80=9D takes around 15 seconds.
> Are you saying that you commonly mount and unmount the filesystem?
>
> Git tracks a device number in the index. Could it happen that it is
> different every time you mount the filesystem?

I read the above to mean that a diskimage file is treated as a
virtual block device on which a filesystem image exists, and it is
mounted via the lookback device mechanism.  In such a case, I do not
think stability of i-num would not be an issue (the filesystem image
would record them all).

> You may set "git config core.checkStat minimal" to avoid the problem.
> But it may come with its own problems (certain kinds of modifications
> would not be noticed, although these would be hard to trigger in practi=
ce).

Yeah.
