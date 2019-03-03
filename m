Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8AA7F20248
	for <e@80x24.org>; Sun,  3 Mar 2019 01:34:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727136AbfCCBeH (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Mar 2019 20:34:07 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56067 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726035AbfCCBeH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Mar 2019 20:34:07 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 26E56135397;
        Sat,  2 Mar 2019 20:34:03 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=/oSMiX2OInOvW
        6CPc1AYtDCKswI=; b=dl7GobO6sMdWL+u3UCqJcnMEoOGJyNpYe7JVQgAZISQCN
        zMCneeaiU+Gy9IrrLEIq9j/cjkn+u7sI59JYB/W6KhE7HFlCTz5vZLcla+fq5TJ6
        WkhWlRatOVHogrqHBvEuZvTBZdhXSybWgQ40Y0ElfymjN90tLqf28AwFYAcOeA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=DZ43bbC
        eUXv6wlh3ksvs3Od2IzzVsJicrx+FYpivyYHPAmovYt99nRbc/05EbalyslPbl/W
        5sjyHmifIT3n+pDRYWmAdJ4eS3MwSTZEaXT/wNew+Ij9r5KuXuIIUnCHyGYeslGg
        7yxNjHvTZMZxmbAPERBFgXWqcCDSrprBc0DI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1EDD6135396;
        Sat,  2 Mar 2019 20:34:03 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 99883135394;
        Sat,  2 Mar 2019 20:34:02 -0500 (EST)
Date:   Sat, 2 Mar 2019 20:34:00 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [BUG] completion.commands does not remove multiple commands
Message-ID: <20190303013400.GA19806@zaya.teonanacatl.net>
References: <20190228230506.GA20625@sigill.intra.peff.net>
 <20190301173443.16429-1-tmz@pobox.com>
 <20190301183017.GB30847@sigill.intra.peff.net>
 <20190301221551.GD31362@zaya.teonanacatl.net>
 <xmqqef7q6pm1.fsf@gitster-ct.c.googlers.com>
 <20190302024011.GF31362@zaya.teonanacatl.net>
 <20190302040704.GN19739@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190302040704.GN19739@szeder.dev>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: 6D08063A-3D54-11E9-A212-DF19F34BB12D-09356542!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=E1bor wrote:
[... lots of good history ...]

Thanks for an excellent summary!

> Note, however, that for completeness sake, if we choose to update
> list_cmds_by_config() to read the repo's config as well, then we
> should also update the completion script to run $(__git
> --list-cmds=3D...), note the two leading underscores, so in case of 'gi=
t
> -C over/there <TAB>' it would read 'completion.commands' from the right
> repository.

Thanks for pointing this out. I'll add that to my local
branch for the "respect local config" case.

At the moment, I think it only matters for calls where
config is in the --list-cmds list. But since the fix Jeff
suggested affects all --list-cmds calls, it seems prudent to
adjust the 3-4 other uses of --list-cmds in the completion
script.  Let me know if you see a reason not to do that.

Thanks again for such a nice summary,

--=20
Todd
