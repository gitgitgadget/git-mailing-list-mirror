Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 240A11F935
	for <e@80x24.org>; Wed, 21 Sep 2016 16:37:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936599AbcIUQhM (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Sep 2016 12:37:12 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:57258 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S936533AbcIUQhM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2016 12:37:12 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D33233E091;
        Wed, 21 Sep 2016 12:37:10 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=i455Bm5iTETY
        cRNmeGjtofAgBqs=; b=s+nF+5EnZUyG9TSE73ZOJ2ayvyy7OyGpAB7OcyM6Ol5U
        KXkyL/6XQaWpZggg+4ZLcp2aTSsPd9lMKgakALFziMWT0OrGoP61nr2I6vEUe/Jf
        mu9lnBMQF9n3ER77HIziqa4a+K/WmYiG4aRBg6E4Ee1FTP+9OdK/oBs3nr4GCQg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=ulJTCi
        qw1s/WeB6cmSa9632FuJLoZHbX6UiATumd75bpEtDn4IH/146WtqSxU5GHG2rvUL
        oKO9My5Xz1e6fqxL9U+Ng2z8H5z+eykAVCYxV4jJDjsQ21Uafd3uRAM76hUqglRT
        zCoDYb7aMWKMvBw7NN3iTo1dIYHz/zWI7Tir4=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id CB68C3E090;
        Wed, 21 Sep 2016 12:37:10 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 535123E08E;
        Wed, 21 Sep 2016 12:37:10 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>
Cc:     Bryan Turner <bturner@atlassian.com>,
        Steffen Nurpmeso <steffen@sdaoden.eu>,
        Git Users <git@vger.kernel.org>
Subject: Re: v2.9.3 and v2.10.0: `name-ref' HEAD gives wrong branch name
References: <20160920162309.l0neYMQ3l%steffen@sdaoden.eu>
        <CAGyf7-FR11Ludt3vNZX7Ek4n_JLSON5+Y9By83GvNgpg94TWcg@mail.gmail.com>
        <b1d35732-4b4c-e0c1-59da-44d3e3b28799@gmail.com>
Date:   Wed, 21 Sep 2016 09:37:08 -0700
In-Reply-To: <b1d35732-4b4c-e0c1-59da-44d3e3b28799@gmail.com> ("Jakub
        =?utf-8?Q?Nar=C4=99bski=22's?= message of "Wed, 21 Sep 2016 15:43:16
 +0200")
Message-ID: <xmqq8tulb45n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: A47C9068-8019-11E6-A635-EAAE7A1B28F4-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jakub Nar=C4=99bski <jnareb@gmail.com> writes:

>> Have you tried "git symbolic-ref HEAD"?
>>=20
>> $ git symbolic-ref HEAD
>> refs/heads/master
>>=20
>> If you don't want the fully-qualified ref, you can add --short:
>>=20
>> $ git symbolic-ref --short HEAD
>> master
>
> This does not work for detached HEAD, but perhaps you don't need
> to worry about this.

I am not sure what you mean by "does not work".  Asking what ref
HEAD points at to symbolic-ref will tell you it does not point at
anything by exiting with non-zero status and that can be relied
upon.

Asking "symbolic-ref HEAD" has been the way how "git branch" and
other commands find out what branch is currently checked out for
almost eternity ("git symbolic-ref" appeared in Git v0.99.8).

