Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0036F201C8
	for <e@80x24.org>; Thu, 16 Nov 2017 00:33:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932870AbdKPAdL (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Nov 2017 19:33:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51990 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S932594AbdKPAdK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Nov 2017 19:33:10 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9CB1B36A8;
        Wed, 15 Nov 2017 19:33:09 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=lMwBGflNIk9bOSrv0YxYkqZaTVE=; b=oNY87v
        UP05r7gdLJ9E/rouq1rhFSPvAD8pKCRnhv9DJUKzI029kr9Omh1bNroG77eiMyvg
        2VIMXcl9Ja2CYYzFXcdBt0JX7fyN7eWtxzMIWmLIRoNFuy8vQ96e/hD7Rs+A5Vde
        Puai1ABKjE52Z20rxUXLjcUN06jn+Bmk/cqBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Cxds2W4wxdua7Njn9YXCsYBMUZfLFzys
        ojW/UD7ikY5r6V5ippGwpiPjUQL2A3VT403p3FLic1SeBwPspe3vETIGKBQtKtkX
        Y7TBNu0js2zYfPugaQyraqKeB+quEBzgGUPibPtwLpHxT0DBZptGM/DObuD/Kb8Q
        NMjGH02QFsA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AFD3AB36A7;
        Wed, 15 Nov 2017 19:33:09 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 1C923B36A6;
        Wed, 15 Nov 2017 19:33:09 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        git <git@vger.kernel.org>
Subject: Re: [RFC] Indicate that Git waits for user input via editor
References: <274B4850-2EB7-4BFA-A42C-25A573254969@gmail.com>
        <xmqq8tf7yxzn.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kZbm8SGY4rXKZHV82E-HX9qbQ4iyCbMgJEBFQf4fj3u=Q@mail.gmail.com>
Date:   Thu, 16 Nov 2017 09:33:07 +0900
In-Reply-To: <CAGZ79kZbm8SGY4rXKZHV82E-HX9qbQ4iyCbMgJEBFQf4fj3u=Q@mail.gmail.com>
        (Stefan Beller's message of "Wed, 15 Nov 2017 16:06:25 -0800")
Message-ID: <xmqqpo8jxdto.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: B8578A2E-CA65-11E7-9D51-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

>> I wonder if we can do something like
>>
>>         git_spawn_editor()
>>         {
>>                 const char *EL = "\033[K"; /* Erase in Line */
>>
>>                 /* notice the lack of terminating LF */
>>                 fprintf(stderr, "Launching your editor...");
>
> "It takes quite some time to launch this special Git Editor"
>
> As Lars pointed out, the editor may be launched in the background,
> that the user would not know, but they might expect a thing to
> pop up as a modal dialog as is always with UIs.
>
> So despite it being technically wrong at this point in time,
> I would phrase it in past tense or in a way that indicates that the
> user needs to take action already.
>
> The "Launching..." sounds as if I need to wait for an event to occur.

Heh, I wasn't expecting phrasing nitpicks when I was trying to help
the thread by trying to come up with a way to avoid vertical space
wastage.
