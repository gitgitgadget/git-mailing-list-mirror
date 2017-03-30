Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8611820966
	for <e@80x24.org>; Thu, 30 Mar 2017 22:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753694AbdC3W4k (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Mar 2017 18:56:40 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65420 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750994AbdC3W4j (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Mar 2017 18:56:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8927B6FC5A;
        Thu, 30 Mar 2017 18:56:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=J65pNmIke6kLrcY412aEKTYhfUQ=; b=rvMKas
        YGOEmNSs9RAB0IN8A3Y0t/YAhIjXD1QMYESGRLVLXiBY3UyCqEuWKgv5daNghtUf
        GoWx0aqv8+r8h3AxAOGCySAofhT5oaBYyWFIXVnEckmZngwnZyyY9s6B/jln285e
        4QC+n3FgbWX0FMJPadUtLZbxfsiNVGYHzFo0o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SGd06bI56Y2/Fr/z1Ukuf+l3Z+1uuo1G
        QGdZnAWRKL4bwLNLvv43iJSwpO8DNOu5hIIoSAGYMCq4OqgFkNbiSTfpl+iM417q
        OwWab8o7dkokWS7ziqDmlhMImo3MgUA7O4mFccJqkYzxnEFWSva0i/KHs/9E5kbi
        O5qh0iGLjFM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 818736FC59;
        Thu, 30 Mar 2017 18:56:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E78986FC58;
        Thu, 30 Mar 2017 18:56:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: /bin/bash: /usr/ucb/install: No such file or directory
References: <CAH8yC8nAYKMe21Q+QvoTvR_WnNJyn2p8DYSkzKmn_dWaeGb+4g@mail.gmail.com>
Date:   Thu, 30 Mar 2017 15:56:35 -0700
In-Reply-To: <CAH8yC8nAYKMe21Q+QvoTvR_WnNJyn2p8DYSkzKmn_dWaeGb+4g@mail.gmail.com>
        (Jeffrey Walton's message of "Thu, 30 Mar 2017 18:37:58 -0400")
Message-ID: <xmqqshlu1iho.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 20EDB038-159C-11E7-9A8A-97B1B46B9B0B-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeffrey Walton <noloader@gmail.com> writes:

> I think this is the last of the issues for Git 2.12.2 on Solaris 11.3.
>
> It looks like 'install' is located in a few places, but not in
> '/usr/ucb'. I believe /usr/ucb is Solaris 9 or Solaris 10. I think the
> equivalent place to look on Solaris 11 is /usr/gnu (but I only have
> limited experience on Solaris).
>
> solaris:~$ find /usr -name install 2>/dev/null
> /usr/share/install
> /usr/dtrace/DTT/install
> /usr/sadm/install
> /usr/gnu/bin/install
> /usr/sbin/install
>
> solaris:~$ ls /usr/ucb
> /usr/ucb: No such file or directory
>
> Here's the default one based on default paths using Bash. I change the
> default shell, but not the default paths:
>
> solaris:~$ sudo su -
> Oracle Corporation      SunOS 5.11      11.3    September 2015
> solaris:~# which install
> /sbin/install

$ make INSTALL=/usr/gnu/install

perhaps?  Look into config.mak.uname; it probably needs an update to
SunOS section, as we seem to only have entries up to 5.9.
