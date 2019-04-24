Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C6DD21F453
	for <e@80x24.org>; Wed, 24 Apr 2019 04:56:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbfDXE4h (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 00:56:37 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65259 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfDXE4h (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 00:56:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 71687145DFC;
        Wed, 24 Apr 2019 00:56:35 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=vZMAUF2KBFDr3Nj/VbJx4MD7Hwk=; b=tO2PaX
        PyWZqLVUVowk7EWCFlzeKyxgRmO2qoPQAWiO5hVhmteIYdDb5DjqS19gbpErGoOs
        xRVDOLSx7Dblz7qn7voq8aGDNsSo69/hRGCEDlWIMlvm8+GnVBLYyqMsfJ1PVj+m
        7rTE7SFhp8CR804IQTV+bIaFruIrOUdROU60Y=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=bmzVKMb8YOqA8a9zIQj9DfB8PJHyE8ws
        DFDv5ZIknVk/6sOVYyTnUbQfQLbAMRoVEUgeSYtqDQuZFvZmtaFiMAG40GnrRJXU
        6eRPsE6P8lUuWJ7GwxN4IwZtir3EF/XEstwtSc8ENuWRyUBLUBookzYiR+ch0hQQ
        qbFRdyt7aYc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A390145DFB;
        Wed, 24 Apr 2019 00:56:35 -0400 (EDT)
Received: from pobox.com (unknown [34.76.255.141])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id D7C91145DFA;
        Wed, 24 Apr 2019 00:56:34 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v4 2/4] *.[ch]: remove extern from function declarations using sed
References: <cover.1555352526.git.liu.denton@gmail.com>
        <cover.1556062365.git.liu.denton@gmail.com>
        <0ebda4725297df64661bc6749b1a1c4c93cb76e0.1556062365.git.liu.denton@gmail.com>
Date:   Wed, 24 Apr 2019 13:56:33 +0900
In-Reply-To: <0ebda4725297df64661bc6749b1a1c4c93cb76e0.1556062365.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 23 Apr 2019 16:40:44 -0700")
Message-ID: <xmqq8sw02e7y.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 55C46DB6-664D-11E9-9BB0-1646B3964D18-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> There has been a push to remove extern from function declarations.
> Finish the job by removing all instances of "extern" for function
> declarations in headers using sed.
>
> This was done by running the following on my system with sed 4.2.2:
>
>     $ git ls-files \*.{c,h} | \
>         grep -v ^compat/ | \

Lose the backslash.  Your shell knows its own syntax sufficiently
well, and when you end a line with a pipe, it knows that you haven't
finished speaking to it and waits for you to give the command
downstream of the pipe, without being told that you haven't finished
with a backslash.
