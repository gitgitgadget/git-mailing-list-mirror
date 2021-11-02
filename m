Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57931C433EF
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 13:13:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DC6460C41
	for <git@archiver.kernel.org>; Tue,  2 Nov 2021 13:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbhKBNQb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Nov 2021 09:16:31 -0400
Received: from mout.gmx.net ([212.227.15.19]:58263 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229530AbhKBNQa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Nov 2021 09:16:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1635858821;
        bh=LF6puf4VjhJrGxCkR3dzVCcpjQsCeUf06vJ9MJpc3xg=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=g47+KYa5egstxQSmPrqtHixW77JV0qcW3BqfiRn8KO6R0lfpQ+lmqh9WT9dEtPAK7
         fnuRv9ATtKJy/TREwtOqkt6sAqU1PlxbB2EKzy2o8vMITZvABbMtLUycMkp6AGQhqm
         46GhUhZhu4yAJofsw0MqidM2U6JZvpibHG1DIp4w=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.9.46] ([62.202.180.250]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M2wL0-1mlBvd0vk4-003Nw2; Tue, 02
 Nov 2021 14:13:41 +0100
Subject: Re: Git not commiting anything if file created and "git add"ed in
 pre-commit hook is the only file in the staging area
To:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailinglist <git@vger.kernel.org>
References: <0165d68f-79a7-d8b7-1bba-89a1449e87a7@gmx.net>
 <YXnNvyi62j5gcxQV@camp.crustytoothpaste.net>
 <dd79e443-3bb9-8b83-746b-7db7c4997ee3@gmx.net>
 <c5507ba6-6e31-b143-9791-0bcff54acb64@gmx.net>
 <4c88e2ae-e42f-491a-2b97-aa1f92c392d5@kdbg.org> <xmqqlf2adx3e.fsf@gitster.g>
From:   Peter Hunkeler <phunsoft@gmx.net>
Message-ID: <a7bdab08-70a5-5dcb-1740-190983ac0848@gmx.net>
Date:   Tue, 2 Nov 2021 14:13:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqlf2adx3e.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: de-CH
X-Provags-ID: V03:K1:bSeOFm8bF0cq0EWIgNQiro1uGw5kuf9b764v26BUIpwMe9nRVnB
 7xTAJAMNq0wDjezhJXlpM8NuiurM8fqWlaNU+vPYTdblpwbsjr2FQey+4LzwjTj/SAA4tWM
 q6bcw+kaoxOgGEzeMAladfmPtJ/G+Zb84zeSOCWKNx91Wlo4KI7Sgwmn88BI8MY2BIqLfGW
 YMBE/J+/PR9fOUUQF6GDQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:bno3zkp8a9g=:xv8eFm7ZtjdubKEBJ6obkL
 Kf5toiWZzsavvGrdFKplaxoTNA4NyG3HgHgUBYLQ3P94sF/cOKTAUdM2d0yD/cI7DVpTgNvhJ
 hnv/izleBnH42UF1aoPW47a+qwxgB6hKElIrbsAx1a/NDzicjJ90mgx2RZnJkbldZn5kup6vJ
 4fQ/akNzose4/Y8fEiYUZTlhAjvDF+7I2aS+drBNSv88AJQV8J8jzig2qvYv3KxkSR4h/FI4C
 Lp7DdAitXgXRE2B+TzT+wo8NsnWZ2eGjy8Bcx3Jb58Rf8UamYH6QT0A5No42YFZkLyBrj+8nO
 9nIYVHGNdYIl+GkTp1Mz9+urIKqcbjtYCrjvtfCN5ytGFojxVDDIAzCrELq9YLmhvfVjsEArQ
 +A2O0kfYLYzIDlLZrrVG7+EY9XXzdxLkz+Tyn1mp0NScBqLIzH70lXRC83ZYveFBgD+9Hriek
 K/EC3qSx6/8/PBsY7ScaUuYysLi0xUHC1jRU41oLyfyac3kLjeu9IVm6rvAwxKMTp1wtL19ze
 wu4vCIx+oonS+h2wfu4DojeHk2bzs60uhgUuQ/auWZ6+ksnv7zfJYRh7/zFR9H6mm1wPpa/sx
 gPwKHOSovUTCPxAG8YT5snECiwPfbuW2l56C6rCU17X9t8M6QmthpcIaTYncF4/X6fCboleyF
 BGOghgdUhug7gKtSAVTFb8lILJU2LCNh38kiybNojtvRg6iYGsajXKTFZx4HBryaEPO4T1DDR
 WPx7sbt7/dur2mN4bZw2zdMBL7KfsdGBhLonPzb+05+1a8lYdB9YVqPvN1vZ0M8t6NFu1d4PL
 gmOGz2LWmsJVbIqeK6WPJXO2zPkCfo4KdtDmHNa1ro8KoWeuNG1Kw5ejKQkApxT5wV+1W2+ra
 TfsGSxcMuqlo/naiHyCRAGsffmT5E1kSjbhWFs3Vu9VjX9B1iilorySffMaHl1mgqhS4IH71B
 UDby+kkh8I74TTMMPuJZCWgNz96LUqiLrr4B0+20cF5zFR7NflNstRRP4qhtNlmUlyapIGn/7
 PjeC2iBBcpPpSLTWHQVQpsOnVIeY/rNR+lWv02SjzkdqjX5QXLM9TdH/A8W9mUshIPB7+0NET
 vGi9ZlcuslwXrI=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 30.10.2021 um 23:25 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
>
>> Even though the documentation does not say explicitly that the commit
>> must not be changed, it is implicit in the stated intent (that the
>> commit is only checked). Depending on that some particular behavior
>> works for you sometimes is then your own business, and when it breaks
>> you get to keep both parts.
> The above matches my _intention_ for the pre-commit hook when I
> added it in 2005, but there were enough people who wanted to abuse
> the interface that it no longer exactly matches the reality.=C2=A0 It ha=
s
> been made usable to inspect the changes (which is the original
> purpose of the hook) and in addition, apply mechanical fixes on top,
> before making the commit.
>
> The story so far, however, is that the scenario that started this
> thread is not even that, if I understand it correctly.=C2=A0 The questio=
n
> is: what should happen when *nothing* is different between the HEAD
> and the index, the user types "$ git commit" (no pathspec, no
> nothing, commit the index as-is, no --allow-empty option), and the
> pre-commit mucks with the index to "fix" the content in the index.
>
> Because we check if there is anything to commit before we invoke the
> pre-commit hook and then reject an empty commit based on that, we
> successfully reject the attempt to commit.=C2=A0 This is in line even
> with the modern intention, as the mucking done by the hook cannot be
> "fixes" based on the observation of the changes made to the index by
> the user (e.g. "The user tries to add changes, with whitespace
> breakages, and then pre-commit hook notices.=C2=A0 Instead of rejecting,
> it fixes the whitespace issues for the user" is the justifying use
> case behind the looser than the original "check only, no touching"
> definition).=C2=A0 So ...
>
>> In conclusion, the pre-commit hook behaves as designed and nothing has
>> to be changed.
> ... in conclusion, pre-commit is *not* a place to make such a change
> that may be created by a script even when there is no human
> initiated change, and "git commit" is behaving as designed.
>
> But there are two things that are not solved yet.
>
> =C2=A0 * It is *not* the ultimate goal of the OP to "use" pre-commit
> =C2=A0=C2=A0=C2=A0 hook.=C2=A0 The goal of OP is to find a workflow ingr=
edient where
> =C2=A0=C2=A0=C2=A0 changes other than human initiated ones are committed=
 at the same
> =C2=A0=C2=A0=C2=A0 time human user tries to commit changes created by hu=
man.=C2=A0 So if
> =C2=A0=C2=A0=C2=A0 pre-commit is the wrong tool to use for that purpose,=
 what is it?
>
> =C2=A0=C2=A0=C2=A0 I suspect that there is no built-in way to do this, a=
nd I am not
> =C2=A0=C2=A0=C2=A0 sure if it is a good idea to add such a feature to th=
e tool---as
> =C2=A0=C2=A0=C2=A0 some have already noted in the discussion, it may enc=
ourage a bad
> =C2=A0=C2=A0=C2=A0 workflow to include such non-human-created artifacts =
to human
> =C2=A0=C2=A0=C2=A0 initiated commit.=C2=A0 I don't know.
Being the OP of this thread, I have learnt that a) my case of
incorporating database changes very atypical to git, and b) automating
the inclusion of such changes *at commit time* is not the best option.
In my case, it is easy to run this very pre-commit script manually
before the commit. I don't see any benefit of adding whatever "tool" to
support this special case.
> =C2=A0 * If we do not consider changes made by pre-commit hook to count =
as
> =C2=A0=C2=A0=C2=A0 "without --allow-empty, an empty commit is rejected" =
logic, why
> =C2=A0=C2=A0=C2=A0 do we even call the hook in the first place in such a=
 case?=C2=A0 I
> =C2=A0=C2=A0=C2=A0 think there is a room for improvement on our side---p=
erhaps we
> =C2=A0=C2=A0=C2=A0 can make "git commit" fail much earlier in such a cas=
e without
> =C2=A0=C2=A0=C2=A0 calling the pre-commit hook.
This would make the bevahiour to be consistent, without officialy
supporting or rejecting=C2=A0 "git xyz" from withing the hook. Hopefully n=
ot
too complex to implement.

Thanks
Peter
