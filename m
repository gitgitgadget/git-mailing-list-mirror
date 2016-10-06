Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7BDEC207EC
	for <e@80x24.org>; Thu,  6 Oct 2016 17:00:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S942171AbcJFRAm (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Oct 2016 13:00:42 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:53389 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S964816AbcJFRAl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Oct 2016 13:00:41 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A838243AB2;
        Thu,  6 Oct 2016 12:59:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=s/NLGNgPNzUzCsZbwHatorT5MHI=; b=FlIZpw
        bt/aretjAWXVlnid6hGl6N8H8LllxVNYW8Uylcxel885+eR3YOM/+cVT7VNlpi44
        DFuztpV037qnCkVjYNZtltBk66n3fhosIgWjn9G9DKr+yZniOic7imXa4N9J0xw9
        VHSXxKkc5Z9DQTHCDoQ/sAjcEKdSslMdRlEfk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=iU+FMLpWK8Pwk0A5ISgszdXwBZI+RVY3
        b1z4LiIy1RLX2IDG+6Eue2zGIxxyjGrqUiRvSksHb6mzTmQGoySd9nfMadH8dxh2
        Z+Mn8waeSfeAIeYJwWR8Rh9jLtOvR22jAj2GgAC/hpPJ7WN1krcrsyysbl0V/2Ol
        XCX/EDPWJtg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8E1EF43AB1;
        Thu,  6 Oct 2016 12:59:00 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id EFFB743AB0;
        Thu,  6 Oct 2016 12:58:59 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josef Ridky <jridky@redhat.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: Feature Request: user defined suffix for temp files created by git-mergetool
References: <1329039097.128066.1475476591437.JavaMail.zimbra@redhat.com>
        <1499287628.1324571.1475653631366.JavaMail.zimbra@redhat.com>
        <e3306f5a-1fb3-bd66-48ac-72b75fc7681c@kdbg.org>
        <1214659824.1976049.1475738509473.JavaMail.zimbra@redhat.com>
Date:   Thu, 06 Oct 2016 09:58:57 -0700
In-Reply-To: <1214659824.1976049.1475738509473.JavaMail.zimbra@redhat.com>
        (Josef Ridky's message of "Thu, 6 Oct 2016 03:21:49 -0400 (EDT)")
Message-ID: <xmqqbmyxmn1q.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2D4A51BE-8BE6-11E6-8930-F99D12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josef Ridky <jridky@redhat.com> writes:

> I agree, that this patch is written as general as possible and can
> possibly bring more confusion than benefits.

I am not sure about that.  Other people would have similar but
different workflow needs where they compare local new one with local
old one that would be helped by renaming local to old and remote to
new (i.e. the other way around from your need).  If you just add a
toggle between local-remote vs new-old, that would be just an
additional code baggage that does not help people other than you.

I think J6t's "EDIT THIS" hits the center of the issue.  If users
are trained to know LOCAL is the one to be edited, would the current
UI work well enough for them thru your custom workflow tools?  If we
rename LOCAL to "EDIT THIS" and do nothing else, would such UI work
well for even untrained users thru your custom workflow tools?

