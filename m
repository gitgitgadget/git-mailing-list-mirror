Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B8E31FBB0
	for <e@80x24.org>; Mon, 28 Nov 2016 21:49:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932183AbcK1Vs6 (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Nov 2016 16:48:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51088 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1754308AbcK1Vs5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Nov 2016 16:48:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E63B1545AB;
        Mon, 28 Nov 2016 16:48:50 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=RhnES+jIrXb5onR94uWUQaEIf94=; b=dE8FWn
        NfSWQgY85pSCuMVzPgl1LUAejYC2q0345fgOMthzMWnitsDfyomuqp8wUw2wrrik
        gln6Ex+87T/FZbhVjrWwlt039sSbT3t6LL6iLPQ4Zp99Q5gHKz4tugEupSDdq0kN
        pFjOYE2nZb+vEX7uVWXnfMXq5tYh9d34aWsBM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=tffU0yfzRALhqsJLjNIJ2fnxv7XMjk0b
        y9ed4NORyWGitdpx0UEaLiTP6/ITzK3SqQaFPSwz/ig7Yslko+j6QNZ7Ua56178E
        eg8o1bpkYKJ/VTmwMsRmtG24q86PklckwiTGoIO5crPzPymxj02c9pJExeu0sz8n
        B8WZ9ZQfpzM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id DDF26545AA;
        Mon, 28 Nov 2016 16:48:50 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54F43545A8;
        Mon, 28 Nov 2016 16:48:50 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Eric Wong <e@80x24.org>, git@vger.kernel.org
Subject: Re: RFC: Enable delayed responses to Git clean/smudge filter requests
References: <D10F7C47-14E8-465B-8B7A-A09A1B28A39F@gmail.com>
        <20161115010356.GA29602@starla>
        <5BC69AC1-5499-4F73-816A-D8786106D796@gmail.com>
        <xmqqvavotych.fsf@gitster.mtv.corp.google.com>
        <249EE7A4-F297-4537-92A9-0EF75A3B1AEE@gmail.com>
Date:   Mon, 28 Nov 2016 13:48:49 -0800
In-Reply-To: <249EE7A4-F297-4537-92A9-0EF75A3B1AEE@gmail.com> (Lars
        Schneider's message of "Thu, 24 Nov 2016 16:45:45 +0100")
Message-ID: <xmqqk2bni8ce.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 72A6D370-B5B4-11E6-8902-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Lars Schneider <larsxschneider@gmail.com> writes:

> What way do you think is better from a maintenance point of view?
> I prefer option 2 but I fear that these "special" values could confuse
> future readers of the code.

I recall getting confused by the redefinition of the meaning of
return value from the grep_directory() function when we started
threading the working-tree grep codepath at around 5b594f457a;
compared to that, as long as the "special" (and "normal") values are
made symbolic constants, I do not think it is too bad.
