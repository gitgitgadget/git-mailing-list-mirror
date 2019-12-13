Return-Path: <SRS0=h4OP=2D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B81EAC80D5D
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBAF824784
	for <git@archiver.kernel.org>; Fri, 13 Dec 2019 20:41:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wGO1OZw9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728899AbfLMTqS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Dec 2019 14:46:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52291 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728863AbfLMTqS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Dec 2019 14:46:18 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 60DA419211;
        Fri, 13 Dec 2019 14:46:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YaSoUChJ80z/q+/r3ufTT0TWC+Q=; b=wGO1OZ
        w9fX3cta/sLfFMo2BmOkIKmb+Hzr3i3bn0J4JSc0JL5FsqyFtxY7FRWn7CSzf7Wu
        QOjegSBWOEkPrt/jAoO5bwqKR87mP6DizJWByP5T8vw8TsHXyj4EjCf6xSFwoTcN
        QTNYWaMABAxAuuqGbju8AqigWEng4kkiBAspo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gaNK5c//+nObiHTILd1PY8apHKKcigGQ
        aaXN+ea7Cp2z+HNU8HPmZ8vzPqeeA0ECjDvt4KyzwZUSp/fUnhbd4+g3j016uPx+
        nSUWEft5waB/of56+JJ18NTdi1Gr4PnDVQ+McfylvRztuUVBaTFBulQEkhDnyRIS
        4Ld77Ou5DKw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 5883D19210;
        Fri, 13 Dec 2019 14:46:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B7E6B1920F;
        Fri, 13 Dec 2019 14:46:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Ben Keene via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Ben Keene <seraphire@gmail.com>
Subject: Re: [PATCH v3 1/4] git-p4: yes/no prompts should sanitize user text
References: <pull.675.v2.git.git.1575991374.gitgitgadget@gmail.com>
        <pull.675.v3.git.git.1576179987.gitgitgadget@gmail.com>
        <fff93acf4430e2e7702ae1345f9899244a9867aa.1576179987.git.gitgitgadget@gmail.com>
        <20191213014537.GA13064@generichostname>
Date:   Fri, 13 Dec 2019 11:46:14 -0800
In-Reply-To: <20191213014537.GA13064@generichostname> (Denton Liu's message of
        "Thu, 12 Dec 2019 17:45:37 -0800")
Message-ID: <xmqqsgloj9fd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 397F1786-1DE1-11EA-9BAC-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

>> @@ -4170,3 +4175,4 @@ def main():
>>  
>>  if __name__ == '__main__':
>>      main()
>> +
>
> Spurious trailing line. Perhaps we could make GGG error out on
> whitespace errors before submissions are allowed?

I think you are asking the tool for too much support.  

It may help a lot more if we gave a Makefile target (or two) that
the contributors can run before going public.  Perhaps


	O=origin/master
	upstream-check::
		git log -p --check $(O)..

that can be used like so:

	$ make upstream-check
	$ make O=gitster/next upstream-check

That way, those who use format-patch+email without GGG or those who
push to a shared repository to be reviewed among the peer developers
before going public would benefit, not just GGG users.

Hmm?

