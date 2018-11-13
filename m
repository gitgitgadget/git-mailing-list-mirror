Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBA1E1F97E
	for <e@80x24.org>; Tue, 13 Nov 2018 01:45:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730721AbeKMLlj (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Nov 2018 06:41:39 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55650 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726111AbeKMLli (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Nov 2018 06:41:38 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7661911276F;
        Mon, 12 Nov 2018 20:45:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lz32Pmru2zIS
        sH0rX7HbA9W6Ce4=; b=c59tMNX/nmxYxRgOHPxxU6B2wL587zvKSlIR+4fhA1k8
        Z/wCzh3Uhy+mIe0imvkfWEs7KhAFxdieAXiPdjW/8A9JDkdSCLeTkss0cMMuE4qp
        lRy6voruYQ75ZBmWxDCj5klDJwVjQiRFnA8iavxiPDlMrjSMtFfq/1GV79H/iyI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ySTqc+
        B3XBz9IgPOxR/dKdvzQYZVxW8iumeLXClbxvEpCkjyIkYKvn2+DNUCtdoCJbl2Ou
        guFL47hYjE2Af9fQgHGQwkj9T/f6bFqras4/DREPxamzxoAJSmpiNJhK5hGVrIuV
        vTHv3C9w2dhzZQ5x6/ydkIzl9voCPH8ldv48c=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E08411276E;
        Mon, 12 Nov 2018 20:45:49 -0500 (EST)
Received: from pobox.com (unknown [104.155.68.112])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CF3F211276D;
        Mon, 12 Nov 2018 20:45:48 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Rafael =?utf-8?Q?Ascens=C3=A3o?= <rafa.almas@gmail.com>
Cc:     Jeff King <peff@peff.net>, nbelakovski@gmail.com, avarab@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] branch: Mark and colorize a branch differently if it is checked out in a linked worktree
References: <20180927204049.GA2628@rigel>
        <20181111235831.44824-1-nbelakovski@gmail.com>
        <20181111235831.44824-3-nbelakovski@gmail.com>
        <xmqqo9au1tsj.fsf@gitster-ct.c.googlers.com>
        <20181112121423.GA3956@sigill.intra.peff.net>
        <20181112180549.ojt3twhsfm5xkako@rigel>
Date:   Tue, 13 Nov 2018 10:45:47 +0900
In-Reply-To: <20181112180549.ojt3twhsfm5xkako@rigel> ("Rafael =?utf-8?Q?As?=
 =?utf-8?Q?cens=C3=A3o=22's?=
        message of "Mon, 12 Nov 2018 18:07:18 +0000")
Message-ID: <xmqq5zx1zr5g.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D87AED62-E6E5-11E8-8894-063AD72159A7-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Rafael Ascens=C3=A3o <rafa.almas@gmail.com> writes:

> But I can see where personal preference starts to play a role here, as
> the logical solution isn't good enough. Which makes the case for being
> able to configure a bit stronger.

Yeah, our preference over time has always been "do not add to our
default color palette to make the default output too colourful;
instead allow the user to specify their choice".  If this feature
can be added like that, that would be preferrable, and if cyan
(which usuallly is used to present "less interesting" piece of
information and in our default palette) works well enough, maybe we
should use that?
