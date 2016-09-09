Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CF1521F6BF
	for <e@80x24.org>; Fri,  9 Sep 2016 16:42:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752295AbcIIQmj (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Sep 2016 12:42:39 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60198 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750938AbcIIQmj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Sep 2016 12:42:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 86CE139EA6;
        Fri,  9 Sep 2016 12:42:37 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kGbJSw7Hyqdi
        f8wJkHpdzSMpbcY=; b=rrZWyunBRw0ydc9SPoKJ3WbKnqXzZzdneaJgZx3gkQGT
        cce0l0oQEf0f4WR6Cdir5MLi5aftCk4BQmQzZ6+WfIg5XbAQ7JbACxxkpHtCvuzu
        DgisEFgPJGbnqWhK3XEjelul0AlwfJTAgXd4/ebFRJYC7PmySP4I5YjqX3iim44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=JZ/muO
        O8fr8fSgJOLSBs4r6n9pXUUpGk+oiyK7FshE2LdysfpCAWtdP39HdwI9NRmxKd/M
        e7H2yU+DDNsUsRHYtMc0fFhdGhW3pO1vLzA4cnI2G2y5Qas0PNA5chtEU2Egt7Di
        DmD/3F53BH+iYlFIgslPcfKksUIo47m+or2Vs=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7FC1F39EA5;
        Fri,  9 Sep 2016 12:42:37 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E15D439EA4;
        Fri,  9 Sep 2016 12:42:36 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergio =?utf-8?Q?Mart=C3=ADn?= Turiel <sergio.martin@accelya.com>
Cc:     git@vger.kernel.org
Subject: Re: Missing RPM spec file in tarball
References: <4c42a1f4-4f03-0fdf-8bd2-8a7f1f978073@accelya.com>
Date:   Fri, 09 Sep 2016 09:42:34 -0700
In-Reply-To: <4c42a1f4-4f03-0fdf-8bd2-8a7f1f978073@accelya.com> ("Sergio
        =?utf-8?Q?Mart=C3=ADn?= Turiel"'s message of "Fri, 9 Sep 2016 18:19:38
 +0200")
Message-ID: <xmqq37l9dnyd.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6A2FFAF6-76AC-11E6-ABE5-F7BB12518317-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergio Mart=C3=ADn Turiel <sergio.martin@accelya.com> writes:

>  I am trying to build RPM packages from tarball (release 2.9.3 and
> 2.10.0), and i do not find git.spec file, in previous releases i can
> found it (e.g. 2.8.3).
>
> O.S.: CentOS 7.2
> Command: rpmbuild -ta git-2.9.3.tar.gz
> Response: error: Failed to read spec file from git-2.9.3.tar.gz

Since ab214331 ("Makefile: stop pretending to support rpmbuild",
2016-04-04) that is used in Git 2.9 and later, i.e.

    Makefile: stop pretending to support rpmbuild
   =20
    Nobody in the active development community seems to watch breakages
    in the rpmbuild target.  As most major RPM based distros use their
    own specfile when packaging us, they aren't looking after us as
    their pristine upstream tree, either.  At this point, it is turning
    to be a disservice to the users to pretend that our tree natively
    supports "make rpmbuild" target when we do not properly maintain it.
   =20
    Signed-off-by: Junio C Hamano <gitster@pobox.com>

we no longer ship an outdated git.spec and git.spec.in files.  This
was done after finding out that nobody noticed that git.spec has
been left broken since around Git 2.8.0 (i.e. we stopped shipping
README without adjusting the reference to it from the git.spec
file).

