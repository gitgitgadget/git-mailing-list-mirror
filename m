Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CFD7C433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 22:20:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238535AbiCIWVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 17:21:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238585AbiCIWVk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 17:21:40 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B55AD11984C
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 14:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1646864432;
        bh=r13HCYF7ovpbg78Wwwsvq0ScKdOoS70AQXU/i7xyv/g=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=BWcvbxrhy5eGp1XaSSxn9dJyg0aS+rTOb/PdDcZRw75ZDZlayoWkljQQRC/onQ1Ae
         hUiXG1/Lg1+U5CiSEaKxQHfi1fhDhgce3GrGWP/uq1WmOUXNVWSxSkBJu6ugpKt55H
         qXB6kqnUercjSbbHOORkCxuX7B9vKgQ94n/ITWrA=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.147.135] ([89.1.212.224]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mo6v3-1nv3xD2JlT-00pddT; Wed, 09
 Mar 2022 23:20:32 +0100
Date:   Wed, 9 Mar 2022 23:20:30 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Glen Choo <chooglen@google.com>
cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH] checkout, clone: die if tree cannot be parsed
In-Reply-To: <kl6lilswdu68.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-ID: <nycvar.QRO.7.76.6.2203092319060.357@tvgsbejvaqbjf.bet>
References: <20220302003613.15567-1-chooglen@google.com> <xmqq5yowolvs.fsf@gitster.g> <kl6lilswdu68.fsf@chooglen-macbookpro.roam.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:b3tOARFsDbZLZqmLLC7ZOnt4CHg3aEf6bm42N5pFD24hjRtRbSZ
 H5JPKAQFsKymNll+9X1GaggU9oZ2F0XBdoFH/IWaw7URyM2OQ1Ppbm9w0LFIUpr277V3XZo
 3rhVGauUymgRZPpev3s45guFbLqLQc6m71Ptz0xcLXL+SVcYRXEdYuV/dqcEYI7tyL1CwBa
 yTbne8wF9gfSmhneps0Pg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:pzkEDI9uMBM=:zQtAsgMQ/du4ga24xe2W5M
 wP685XaVqzXemUKWA/lohcgIea01uKYXgJaMLOUhJVl7L1Mk1AipNnX9qCcdw69Egph7zk7V0
 cI6vZyXx34BVUaeRgyKqAlTacnUM8loy6UjcNdqTDKuuNU66oZlt2OZrBE1hzqGTjUqDkovZx
 Uz6cWLOZX6erujP+9sQ/ebPKMu/j1bL0cY6smP3hA0aJXnzlFwtzUQI1d7QOltabeSPQjRZZt
 VWvwgrTQW7OvQ6cX/Bm2FiAWycmKo7qfWxw8Sc3d5uNCcqoz3e+dP4fXOb0M6y2+7zpoe8uoG
 51eu/zgCAe6gOsroVVUXiLvqdwT3nUpEXuQ9ekO8nGNbrummSxXPe3+A9wHdhOKoE+WylSc+d
 NbSIwUH5xYg+JQq5FHuD/5L0O1QrUGr6m7vn2r6QJnY1WF9YWcd5lEcjEbD6wN55Ltn6kv0iL
 jUwu7DBCwMAph9zXyj++4zoMy142h3MMJWApY27Xma57qjZ7hBa6HwxQvuWL/TQga55vok4Ih
 bycZ8dNdVpw3xMj1RKPzHwN0OoezPPnibZgSdexF9w6vDZ8S6IbaKET8tLxxOr2dldUytDyWd
 aCE6sViCKky1Yo2IPe6g2ig3WnSxZx88y3uLQZ9hMeW6GWxQIWrHL5guanGQSC6sM5O/d1U0n
 vViAbkIPEUZPsIDRmlSRBhDlHdo+YbxEp0LKTuIaET4Nwceqd6wumTGO33Ch2WWtPiqeKl7R5
 GOBJarcYlZXqr5x7MC8xxyA6d+z8x6LtzgEBltlVZGan7T/RbwMi7JQ8ZGbHJSQ7tcUPzM674
 9yWE/AsQu915SMlsfvnpMZxtmOGkpSJWXdTuufMWjDOniQqx6TAlQPdr4x1s5I9iyBF5vvzCS
 FlWaaMZViz50KNgsLZpOxDY8yC2Iy0hlr86k9aHkehd2yWrImoe0G6RfIGv6YH1rJ6MB8PlyR
 TM72ztgx1yQPYwvLDrQ+CyUcAKCF6J3wKUcPFijMDelqe0Jn2t2n7Z8djmngC4EOyfAgqPbKX
 TuZ7gHbHgsX64g/yfgQ9MQy29H9Iq0nh1dZglI1GFKQpD/RPPNFUJLWj8ehSwNHcKqqyeo+wv
 j7VrjUdsyuGCN8=
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Glen,

On Wed, 2 Mar 2022, Glen Choo wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
> >          but one random-looking hexadecimal string is almost
> > indistinguishable from another, and neither would be a very useful
> > message from the end user's point of view.  I am wondering if we can
> > use old_branch_info to formulate something easier to understand for
> > the user.  update_refs_for_switch() seems to compute old_desc as a
> > human readable name by using old_branch_info->name if available
> > before falling back to old_branch_info->commit object name, which
> > might be a source of inspiration.
>
> I think it's actually more helpful to have the oid instead of a
> human-readable description like old_branch_info->name.

The most helpful would be to have both. That way, it would at least be
potentially possible to figure out from a ref how to fetch a non-corrupt
version from elsewhere.

Ciao,
Dscho
