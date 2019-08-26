Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EE13E1F461
	for <e@80x24.org>; Mon, 26 Aug 2019 14:30:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731765AbfHZOab (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Aug 2019 10:30:31 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63231 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727261AbfHZOab (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Aug 2019 10:30:31 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 41E40160025;
        Mon, 26 Aug 2019 10:30:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Zu8FfCL7RSl8+95NmVFbZPGEwWc=; b=bW+n5p
        vA38hVKOqjLptJWzE8wbBm+6DgrPQwPxe53tyAAFer48IONgJT+30GSIvy3za8Uh
        aKEH8Am0QBWFr84Rw1VtV9XkeCPZILQXnSxqUL4euyq/JcfZLp7pkcnCGOzE+J2K
        ONmXZ2GRWXV13TRJijdrLgzQ4awwbdx0j2vRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gK7pKogye0oIx11C35gqjeEMs6zdrA4Z
        SAUksSStnCPJAXQL+swNiyRPXzWLN0AoEuxedoL97R2ro2J09i/dQJh8Uxe+b6zY
        UjdrLZtIl3FcdgslGdpif7kxtfS9FkO3uGTQOAzWvKDg+OExrQeG5m1I1aHIbG7U
        9iYkqtx1CPU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 35F6C160024;
        Mon, 26 Aug 2019 10:30:29 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 8F47E160021;
        Mon, 26 Aug 2019 10:30:28 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Philip Oakley <philipoakley@iee.email>
Cc:     Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 13/13] format-patch: learn --infer-cover-subject option
References: <cover.1566258525.git.liu.denton@gmail.com>
        <cover.1566285151.git.liu.denton@gmail.com>
        <de599f7ca9b5fe7e298bba0bb8c5d05f2f5cf34f.1566285151.git.liu.denton@gmail.com>
        <xmqq8srms4ak.fsf@gitster-ct.c.googlers.com>
        <20190823181545.GA14048@archbookpro.localdomain>
        <d8a02cfd-2250-44ce-b559-dbec742b7cdf@iee.email>
        <xmqq1rxbmy8r.fsf@gitster-ct.c.googlers.com>
        <20190824080328.GA9726@archbookpro.localdomain>
        <1eccefe4-8002-4664-3bc2-8332fb7bd697@iee.email>
Date:   Mon, 26 Aug 2019 07:30:27 -0700
In-Reply-To: <1eccefe4-8002-4664-3bc2-8332fb7bd697@iee.email> (Philip Oakley's
        message of "Sat, 24 Aug 2019 14:59:01 +0100")
Message-ID: <xmqqa7bwkni4.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0D144C9E-C80E-11E9-A237-46F8B7964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Philip Oakley <philipoakley@iee.email> writes:

> I haven't looked at what happens on Windows (CRLF usage?) for
> multi-line descriptions. The common assumption is LF in repo, with
> attributes etc, but the branch description is a bit free format in
> terms of guidance ;-)

The same approach taken by the format-patch to use a commit-log
message to form the subject and the body should be applicable; as
long as the resulting cover letters are made the same way as the
normal patch e-mails, it is OK.  If both are broken wrt CRLF usage
or whatever, as long as they are broken in the same way, we can
correct both at the same time ;-)

