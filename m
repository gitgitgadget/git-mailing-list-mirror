Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D29B41FC96
	for <e@80x24.org>; Fri,  9 Dec 2016 19:31:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752748AbcLITbk (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Dec 2016 14:31:40 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:54957 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752684AbcLITbj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Dec 2016 14:31:39 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9D28756916;
        Fri,  9 Dec 2016 14:31:38 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=x2EHpnfs8YUva/5qSRRxt6d8Thw=; b=EMbZwu
        lh2Hzp9C3sOnTdmoX/gEK1zQHPqd2JGn4hWexv4oa5L7CKh5gTom3RIYq4d/OEoq
        noNKSCKVKkDU+hH76JLjUY3pM0wtJiHESvz+YkFxJAPmADr8xr79rz0IR61aHdYT
        RZ5BFk30JXsX5PoCbUxx3X0HKBZ8Xj61mikTc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=VRAvM/HrNYb8Ewjfh1R2crgIlTP9Msg0
        ZP+Z1uKgHc+04EwIHeh7CqF7C6MvLSXsxhAbXWft6rQ8i13KqVRpxxkPmX6slXBF
        q3SlJkFqHTAeak73764yFbK7cpo21fk1qZMNazf0HeP0FSBwd3xdvakujf62eco2
        u2W3xoHQ8vA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9247D56915;
        Fri,  9 Dec 2016 14:31:38 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EE2DA56914;
        Fri,  9 Dec 2016 14:31:37 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     David Turner <novalis@novalis.org>, git@vger.kernel.org
Subject: Re: [REGRESSION 2.10.2] problematic "empty auth" changes
References: <alpine.DEB.2.20.1612081538260.23160@virtualbox>
        <1481231552.20894.20.camel@frank>
        <alpine.DEB.2.20.1612091048540.23160@virtualbox>
Date:   Fri, 09 Dec 2016 11:31:36 -0800
In-Reply-To: <alpine.DEB.2.20.1612091048540.23160@virtualbox> (Johannes
        Schindelin's message of "Fri, 9 Dec 2016 16:58:31 +0100 (CET)")
Message-ID: <xmqqoa0krjaf.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1A51B75E-BE46-11E6-B8F0-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> It would be different, of course, if http.emptyAuth would *not* allow the
> user to type their credentials when accessing something like
> https://github.com/dscho/shhh-secret-repository, *only* trying the login
> credentials. But that is not the case, with http.emptyAuth=true, login
> credentials are attempted first, and when they fail, the user is still
> asked interactively for their credentials.
>
> All I can see is that this would be *an improvement*: corporate users
> trying to access a Git repository that requires their login credentials
> would now not even need to enter empty user name/password.

Yup, my thought process after seeing your first message to David
exactly mirrored the above two paragraphs.  It sounds like you two
have a good plan ;-)

Thanks.

> This alone would be already a good reason to change the default, IMHO.
>
> So here is my plan:
>
> - change the default of http.emptyAuth to true in the next Git for Windows
>   version
>
> - publish a prerelease for early adopters to test
>
> - contribute this patch here on the Git mailing list, in the hope that it
>   will make it into the next major version
>
> Ciao,
> Dscho
