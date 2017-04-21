Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54B03207BD
	for <e@80x24.org>; Fri, 21 Apr 2017 00:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034253AbdDUA4l (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 20:56:41 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52132 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1031383AbdDUA4k (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 20:56:40 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5AD607B2D9;
        Thu, 20 Apr 2017 20:56:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=LK02uU060GbxAjmh884C0ebZA+0=; b=IcVO8Z
        kXY/oL3rahlJ+inkHGarRwlZrGPrcLKbTgoUOLUPqVjx3sf2p0OKrkYbso2bqbCb
        xTruZjLy1cy8DfN9WX5t1W42CMQsa4sLTlOAFpMjaQKf9hKDeqxLw6QcOnQ9ptUY
        bueIOuq4Q43YxniyMpc2eXvhqjdn1RmvVp8L8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=pQtBcSN5C1gSv5mV6Xz4e5sqBKvgF9YA
        V3N7m6FFsAeILwgOp6kTIIPyZd4D34TMxC0dqrsIUiIn5D2EdJE3Xn2XaiCINWpt
        nGVLy/DAV109wIIpPjlk4Km4eTzUPJH1ziB/NaX6mUJcXpoM8gKsOYbVQhPRiqdr
        F/kQ/ONHbRM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 51C957B2D8;
        Thu, 20 Apr 2017 20:56:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7D70F7B2D6;
        Thu, 20 Apr 2017 20:56:38 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Brandon Williams <bmwill@google.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>, git@vger.kernel.org,
        peff@peff.net
Subject: Re: What's cooking in git.git (Apr 2017, #04; Wed, 19)
References: <xmqq4lxjabce.fsf@gitster.mtv.corp.google.com>
        <D61D47BD-9750-4FB6-892E-013504E03738@gmail.com>
        <alpine.DEB.2.20.1704201523390.3480@virtualbox>
        <20170420165622.GC142567@google.com>
        <20170420231836.GM142567@google.com>
Date:   Thu, 20 Apr 2017 17:56:37 -0700
In-Reply-To: <20170420231836.GM142567@google.com> (Brandon Williams's message
        of "Thu, 20 Apr 2017 16:18:36 -0700")
Message-ID: <xmqq37d28toa.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 601C0D76-262D-11E7-A58B-E680B56B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Brandon Williams <bmwill@google.com> writes:

> On 04/20, Brandon Williams wrote:
>> On 04/20, Johannes Schindelin wrote:
>> > Hi Lars & Junio,
>> > 
>> > On Thu, 20 Apr 2017, Lars Schneider wrote:
>> > 
>> > > > * bw/forking-and-threading (2017-04-19) 11 commits
>> > > > - run-command: block signals between fork and execve
>> > > > - run-command: add note about forking and threading
>> > > > - run-command: handle dup2 and close errors in child
>> > > > - run-command: eliminate calls to error handling functions in child
>> > > > - run-command: don't die in child when duping /dev/null
>> > > > - run-command: prepare child environment before forking
>> > > > - string-list: add string_list_remove function
>> > > > - run-command: use the async-signal-safe execv instead of execvp
>> > > > - run-command: prepare command before forking
>> > > > - t0061: run_command executes scripts without a #! line
>
> I just double checked what differences existed between what I have
> locally and what is queued at bw/forking-and-threading and it looks like
> the changes (adding the !MINGW) to just this one patch were missed,
> while the rest of them were picked up.  Just and fyi.

Thanks.  Queued with a warning in the log message.

