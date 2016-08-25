Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2276020441
	for <e@80x24.org>; Thu, 25 Aug 2016 17:50:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755730AbcHYRu2 (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 Aug 2016 13:50:28 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:52598 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755722AbcHYRu1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Aug 2016 13:50:27 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1BCF635360;
        Thu, 25 Aug 2016 13:50:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=7Wy8aBmtTPFbyCVSfsgevLK/rZQ=; b=I4ZDdu
        9Zp8PSsrPd57YrJIl9vnCnv5mgN2M1xFZ3csNYfCaPM+g16Rh5mA6K1rK2xu2RwM
        cezlzyqffZq4Qy3CSfWrEoz7S2kcd8d8qNbBMZp7YGJ6sqHd45TLGOaJHeVHF953
        mKnf/sanJfvLpl1194aPwUxWztESnuRhOlkO0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=doJlRASozXt7OwDd3voh/Lg4Rke42R8o
        1aVGbJnUj7lMgqSeSMhquXV1YuFBngG5vG6G1cmqbeDE7zXFkBOi8CWdtsCg/S1O
        4pU/juouDPi09Kg0QW7BQy5UzinZ495HjVzAF4k5l7EbS0pqtaOZ/Y1dq01B1V8V
        O8QJzb465Ag=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0EF543535F;
        Thu, 25 Aug 2016 13:50:26 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 843C83535E;
        Thu, 25 Aug 2016 13:50:25 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ed Greenberg <edg@greenberg.org>
Cc:     git@vger.kernel.org
Subject: Re: git push origin BRANCHNAME question
References: <6c4fbb7d-6f67-b454-2b4b-9f5fbeffae9b@greenberg.org>
Date:   Thu, 25 Aug 2016 10:50:23 -0700
In-Reply-To: <6c4fbb7d-6f67-b454-2b4b-9f5fbeffae9b@greenberg.org> (Ed
        Greenberg's message of "Thu, 25 Aug 2016 09:16:50 -0400")
Message-ID: <xmqqr39cn3fk.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6714016C-6AEC-11E6-BA88-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ed Greenberg <edg@greenberg.org> writes:

> I think I understand this from the git-push man page, but I want to
> make sure:
>
> I have two branches, master and develop.
>
> If I am (accidentally) sitting on master, and issue 'git push origin
> develop', does this properly push develop to remote develop, or does
> it push master to remote develop (which seems to be bad, in the most
> common use case.)  ?

You can find it out yourself quite easily, I would think.

$ git init src
$ git init dst
$ cd src
$ git commit --allow-empty -m initial
$ git checkout -b develop
$ git commit --allow-empty -m second

$ git checkout master
$ git push ../dst develop
Counting objects: 3, done.
Delta compression using up to 6 threads.
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 226 bytes | 0 bytes/s, done.
Total 3 (delta 1), reused 0 (delta 0)
To ../dst
 * [new branch]      develop -> develop

