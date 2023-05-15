Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A0DC77B7D
	for <git@archiver.kernel.org>; Mon, 15 May 2023 17:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244336AbjEORcF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 May 2023 13:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244293AbjEORbc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 May 2023 13:31:32 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D55714E49
        for <git@vger.kernel.org>; Mon, 15 May 2023 10:28:16 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 8F6881F5A8B;
        Mon, 15 May 2023 13:27:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=Hsl3kilEAjGv
        KKCe4b4u6DlZGyjhgmltxmE/83HzDAU=; b=bU1OscB0cZMrGZa5D2PUyygILH14
        GMxwd/TJgwhil2xWf7op8FTscr8yxbNRhy2xUlE4Cfo75l+FoKT6CtXHefdJkF+G
        25z9PbgfEJax040NYLplU5rPoxDynyx8fN3WNf5qfoUbkl57N6ZJUb/PIA6qzKCb
        ZkhJJ5zvd/vu9Q4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 881A01F5A8A;
        Mon, 15 May 2023 13:27:49 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.203.137.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AF04F1F5A89;
        Mon, 15 May 2023 13:27:46 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Sean Allred via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Sean Allred <allred.sean@gmail.com>,
        Sean Allred <code@seanallred.com>
Subject: Re: [PATCH v3 1/6] show-ref doc: update for internal consistency
References: <pull.1471.v2.git.git.1679478573.gitgitgadget@gmail.com>
        <pull.1471.v3.git.git.1684152793.gitgitgadget@gmail.com>
        <fe442c2041b01985a4ecb0f2e9651231af2a439b.1684152793.git.gitgitgadget@gmail.com>
        <CAPig+cTSp3+RDbULeOXpfXwXw35tj3o-CTrpaeRPSB8remKk4A@mail.gmail.com>
Date:   Mon, 15 May 2023 10:27:45 -0700
In-Reply-To: <CAPig+cTSp3+RDbULeOXpfXwXw35tj3o-CTrpaeRPSB8remKk4A@mail.gmail.com>
        (Eric Sunshine's message of "Mon, 15 May 2023 12:58:46 -0400")
Message-ID: <xmqqilcta4j2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: CEDE13EE-F345-11ED-B858-C2DA088D43B2-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, May 15, 2023 at 8:13=E2=80=AFAM Sean Allred via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> - Use inline-code syntax for options where appropriate.
>> - Use code blocks to clarify output format.
>>
>> This patch also swaps out 'SHA-1' language for the implementation-
>> agnostic 'OID' term where appropriate in preparation for supporting
>> different hashing algorithms.
>>
>> Signed-off-by: Sean Allred <allred.sean@gmail.com>
>> ---
>> diff --git a/Documentation/git-show-ref.txt b/Documentation/git-show-r=
ef.txt
>> @@ -96,7 +96,13 @@ OPTIONS
>> -The output is in the format: '<SHA-1 ID>' '<space>' '<reference name>=
'.
>> +The output is in the format:
>> +
>> +------------
>> +<oid> SP <ref> LF
>> +------------
>>  $ git show-ref --head --dereference
>> @@ -110,7 +116,13 @@ $ git show-ref --head --dereference
>> -When using --hash (and not --dereference) the output format is: '<SHA=
-1 ID>'
>> +When using `--hash` (and not `--dereference`), the output is in the f=
ormat:
>> +
>> +------------
>> +<OID> LF
>> +------------
>>  $ git show-ref --heads --hash
>
> Is the difference in case ("<oid>" vs. "<OID>") intentional between
> these two examples?

I think it is an incomplete fix based on the suggestion I made for
the previous round,

 cf. https://lore.kernel.org/git/xmqqsfdwenn3.fsf@gitster.g/
