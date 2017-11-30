Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1069520C11
	for <e@80x24.org>; Thu, 30 Nov 2017 17:11:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753410AbdK3RLA (ORCPT <rfc822;e@80x24.org>);
        Thu, 30 Nov 2017 12:11:00 -0500
Received: from sub3.mail.dreamhost.com ([69.163.253.7]:56793 "EHLO
        homiemail-a11.g.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753105AbdK3RLA (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2017 12:11:00 -0500
X-Greylist: delayed 351 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Nov 2017 12:11:00 EST
Received: from homiemail-a11.g.dreamhost.com (localhost [127.0.0.1])
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTP id D6076314C071
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 09:10:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=novalis.org; h=message-id
        :subject:from:to:date:in-reply-to:references:content-type
        :mime-version:content-transfer-encoding; s=novalis.org; bh=X+bTQ
        eYr6PP0KYVV3wHcCLjB0/U=; b=F7HCTh5UW+TRvP8pIcgiH9S1fCot/UWHsfcFK
        n+zpDgj4Q+Yx3zWPNkP57S4Eup8fm0TlQNqurbsDnERoG11i8kJpFu38EzPHpD0x
        6KMgAOrPu8cXP3ZJPWLBVGl7NmLSlDUEOjicasbD/jAg1uvJ8AIU53J8Ap26efz6
        TNjEsQ=
Received: from corey (unknown [38.27.161.17])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: novalis@novalis.org)
        by homiemail-a11.g.dreamhost.com (Postfix) with ESMTPSA id 7CD38314C06D
        for <git@vger.kernel.org>; Thu, 30 Nov 2017 09:10:59 -0800 (PST)
Message-ID: <1512061858.9882.375.camel@novalis.org>
Subject: Re: git reset <tree-ish> <paths> of addition of a submodule?
From:   David Turner <novalis@novalis.org>
To:     git@vger.kernel.org
Date:   Thu, 30 Nov 2017 12:10:58 -0500
In-Reply-To: <1512061507.9882.374.camel@novalis.org>
References: <1512061507.9882.374.camel@novalis.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1 
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, 2017-11-30 at 12:05 -0500, David Turner wrote:
> git submodule add https://my-git-repo blort
> git commit -m 'add a submodule'
> git reset HEAD^ blort
>=20
> The reset deletes the gitlink, but does not delete the entry in
> .gitmodules.=C2=A0=C2=A0On one hand, this is exactly what the user aske=
d for --
> they wanted the path 'blort' to be changed in the index, and that's
> what they got.=C2=A0=C2=A0On the other hand, the behavior differs from =
git rm,
> and seems confusing: most folks don't want an entry in .gitmodules
> which doesn't correspond to a gitlink.=C2=A0=C2=A0
>=20
> If reset isn't the right thing for me to do when I want to say "oops"
> about adding a submodule, then what is?=C2=A0=C2=A0I could do:
> git reset HEAD^ blort .gitmodules
> but what if I added two submodules and only wanted to undo the
> addition
> of one?


Also, resetting the deletion of a submodule has an even worse issue --
you end up with a gitlink but no entry in .gitmodules.

