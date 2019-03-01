Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1EBD420248
	for <e@80x24.org>; Fri,  1 Mar 2019 21:56:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726814AbfCAV4g (ORCPT <rfc822;e@80x24.org>);
        Fri, 1 Mar 2019 16:56:36 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65333 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725905AbfCAV4g (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Mar 2019 16:56:36 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0DECD57EE3;
        Fri,  1 Mar 2019 16:56:31 -0500 (EST)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=PS+AJ2RpebE2A
        lCB+G/NRNX5WGs=; b=ScQkeEx5cDeoUd0x/iyaB3fWN9t6CT8xOxxygpIQqMpae
        86bz4Tyy/Gx6n1ND/NyGsh6MwRFCWjw3X+DmZc/uhWXEoBVBTfMfG6nn3eYFmXVF
        mmiZkV88KhjPtV4gxXYYrg4oPJ9qfctxgqEjzc0PDkYKnTxpouTffcjowrIcDM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; q=dns; s=sasl; b=lrDaMkd
        rBAXRGrQIGAcOaARjPJXXs2AH6MAkt51khIvv/BdBXCYxhbMSDJdZVJSlFG+qV3Q
        HqNSub70fKQpp+vnptMDpI5RwQer0K2mebx1mRCeTZZBS0X5R36sbo9Ola1zwpd8
        Fhsn7EoD3nMMXzN9B62zMPku31m9xkQtRNdc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0587B57EE2;
        Fri,  1 Mar 2019 16:56:31 -0500 (EST)
        (envelope-from tmz@pobox.com)
Received: from zaya.teonanacatl.net (unknown [71.173.194.225])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AF7D357EE0;
        Fri,  1 Mar 2019 16:56:27 -0500 (EST)
        (envelope-from tmz@pobox.com)
Date:   Fri, 1 Mar 2019 16:56:24 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>,
        Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] t9902: test multiple removals via completion.commands
Message-ID: <20190301215624.GC31362@zaya.teonanacatl.net>
References: <20190228230506.GA20625@sigill.intra.peff.net>
 <20190301173443.16429-3-tmz@pobox.com>
 <CAPig+cTQG+yLGs1Ur2awhLyrpSWj0QyrDpuxCnMNOqc2bBz3pQ@mail.gmail.com>
 <20190301205041.GM19739@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190301205041.GM19739@szeder.dev>
User-Agent: Mutt/1.11.1 (2018-12-01)
X-Pobox-Relay-ID: DD727344-3C6C-11E9-BE82-D01F9763A999-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

SZEDER G=E1bor wrote:
> On Fri, Mar 01, 2019 at 01:22:52PM -0500, Eric Sunshine wrote:
>> On Fri, Mar 1, 2019 at 12:35 PM Todd Zullinger <tmz@pobox.com> wrote:
>>> 6532f3740b ("completion: allow to customize the completable command
>>> list", 2018-05-20) added the completion.commands config variable.
>>> Multiple commands may be added or removed, separated by a space.
>>>
>>> Demonstrate the failure of multiple removals.
>>>
>>> Signed-off-by: Todd Zullinger <tmz@pobox.com>
>>> ---
>>> diff --git a/t/t9902-completion.sh b/t/t9902-completion.sh
>>> @@ -1483,6 +1483,14 @@ test_expect_success 'git --help completion' '
>>> +test_expect_failure 'completion.commands removes multiple commands' =
'
>>> +       echo cherry-pick >expected &&
>>> +       test_config_global completion.commands "-cherry -mergetool" &=
&
>>> +       git --list-cmds=3Dlist-mainporcelain,list-complete,config |
>>> +               grep ^cherry >actual &&
>>> +       test_cmp expected actual
>>> +'
>>=20
>> We normally avoid placing a Git command upstream of a pipe. Instead,
>> the Git command output would be redirected to a file and then the file
>> grep'd.
>=20
> Indeed.

Yes, that's a good point.  And one I should have known from
reading it here more than once.  Thanks to both of you.

>> However, in this case, you might consider simplifying the test
>> like this:
>>=20
>>     test_expect_failure 'completion.commands removes multiple commands=
' '
>>         test_config_global completion.commands "-cherry -mergetool" &&
>>         git --list-cmds=3Dlist-mainporcelain,list-complete,config >act=
ual &&
>>         grep cherry-pick actual
>=20
> This wouldn't check what we want.  The point is that the command
> 'cherry' is not listed, so it should be '! grep cherry$ actual'.

Heh, I had written a similar reply already, but then I got
side-tracked for a bit...

    I think the grep needs to be negated, e.g.:

        ! grep ^cherry$ actual

    Otherwise it succeeds without the fix, as cherry-pick is
    expected to be in the --list-cmds output.  (If we remove
    the 'expected' file, it might also make sense to rename
    'actual' to 'out' perhaps.)

> Furthermore, I think it would be prudent to check that 'mergetool' is
> not listed, either.

True.  With the simplified test, that's easy enough to add
and makes the test description more accurate and the test
more thorough.  I'll adjust it like so when I re-send:

    test_expect_failure 'completion.commands removes multiple commands' '
    	test_config completion.commands "-cherry -mergetool" &&
    	git --list-cmds=3Dlist-mainporcelain,list-complete,config >out &&
    	! grep -E "^(cherry|mergetool)$" out

(Using test_config depends on setup_git_directory_gently() in
list_cmds(), which Jeff suggested elsewhere in the thread.)

Thanks!

--=20
Todd
