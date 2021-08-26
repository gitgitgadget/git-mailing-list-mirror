Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E2F3C4320E
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 18:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E18460FD8
	for <git@archiver.kernel.org>; Thu, 26 Aug 2021 18:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243328AbhHZST6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Aug 2021 14:19:58 -0400
Received: from mout.web.de ([212.227.15.3]:39731 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243330AbhHZST6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Aug 2021 14:19:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1630001947;
        bh=Ir6jNGEkzW84rENxxQ4T6nLFS3+HpRwrxJJbQAprHGA=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=U+QJwS2qC0hckcgN+6lVaZ7EKahFqzOJ7NBScRPaDWkRdlnuZEypHUD2losNpamCS
         WQuxRaVK1wakQHiSSv5ArXiIVt4itxIRgJwiAkWcLBJVLiPfwp+Fwhh9mQpLKPvHGC
         BdZWGdFljS1sFVuiXxnMefHHuN2FRd/O20V3j3sM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from Mini-von-Rene.fritz.box ([79.203.27.185]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1Md6xz-1mrYO82AUd-00aF8p; Thu, 26 Aug 2021 20:19:07 +0200
Subject: Re: [PATCH RESEND] branch: allow deleting dangling branches with
 --force
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>
References: <7894f736-4681-7656-e2d4-5945d2c71d31@web.de>
 <87eeahcd7f.fsf@evledraar.gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
Message-ID: <f53313bf-222d-bb0e-d91e-a0359ffdaeff@web.de>
Date:   Thu, 26 Aug 2021 20:19:06 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <87eeahcd7f.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0v514aGr1y5o9oGJPfAhyq8WEGtScz22nbcyeH+PByI61zLxCKq
 gvsZ5Yadu9O30e7TxzzKKg+re6d+zt2/QuM+qt9cv/VEg5ifXhhODOOZooP3V5QSmOF44ax
 zWLR0ipuwvW1awq8mnqQRYA9gxErpm89p1zTEqzoD1JCTdBvUftpMn/bx+HCo6ebYuUrPPJ
 RZdqWLcNzPb3jA8y0KB/w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TEiGbDTbpxY=:7BAL0xTgX4ySty9z8t23DY
 PY4dYDeYVEUyFdzBaCF8DbE+MribVN62zTCtrlLdn+kmsEMe5yg4z3IRxsZELfmQ8sMtyLgV8
 Oc0ydkY0IQM9AtbNvwubW0bQLe6yzaQpNH8/m8zg1+ri5ldCr40FxVWYYxg9DmH6WO5ZYD8yt
 3lGow+maq2dM+Go2qQsQSsH2WvlwJ3i4y0jCZD7WIdohRahZIR/W7jRkdLWbgZjSoJK5MWwMw
 cUdSdspWiLdOYE+oyjzJGzoPfdXbbvYi4ac85EO8bumgB4NcuZ6/+DGO8p0J3xZRye7o/+LJA
 bpBZ6ZY5rUDEaswNC8k776QOGOkM3TB9H3xtNIbgPcNWHlRae6obo33TYrBe8yqO5sagKgKR5
 IR9FeyrHb20H4ZaTYelcV9ij1DTA9Zi1Q7SVf7vp0vHhfHz+IPe8HgSXZgxqv3NrKtTDH0elm
 UnuwAqgh+1LPtTsGTIIXh29GWK6qducs3RwMBELUEWA7Eqw8Y7qfcarrPU2sJ81gHQnenCXfg
 JBU5k+56UGoSBaouoOJ43NEBWXtiTldDo4SdB2OfsksgskBNBlOj75YoS+56D4o4a8ck9IDXc
 MaBOkeXnDY+BlPVEvjg1Y+KiZG4HQ0GPrW4y7PHZjKRBqKDl5pJKR9m2mJOSadF8M8Qt4DNcY
 Qi3R2ba+2vHR0pWuGRs9tEf57Wpdi1ihNQZhA6G64tmYS6oVlOTZNzo5pZ3YKdiCMH2JygvIX
 ytdHSlWMHyHiCqrdUWqDUDT09Zm00rzR7K4itP/qDzlc1QnnPwmSfbPHjuyMN1L7WfbfIzfEx
 LFMa4o/N7wxG1xhnOWUS5EfmUB1ZyYWpPCi0eZ/4wBI2CBOJjlWSW9AH6E7jXoaQnbPSIZ1tI
 B36hovkT0MBifJ0+urmiX5cF2LOs1sCMyyqGW6wEu+OPk7iREgr3rkcW5QE1Y8sh8fzSfwoo7
 lJzslY7Q+bEGi//eLKRHQ63VQvqkzodADrpktWbNAal1P92VYrzswW9pPrM/oPKYArvkoJRDs
 QyTl2u/7yQkzkIYtBKZoxRwh9BmFPfH386Ok5CoZCpmtrf2CLrNSe7uflfrlKpeGRmPm6tu15
 Mkr9L9kXyaNZhcpgS+95xSghE3r5eOaQVEY
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 26.08.21 um 01:30 schrieb =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason:
>
> On Wed, Aug 25 2021, Ren=C3=A9 Scharfe wrote:
>
>> git branch only allows deleting branches that point to valid commits.
>> Skip that check if --force is given, as the caller is indicating with
>> it that they know what they are doing and accept the consequences.
>> This allows deleting dangling branches, which previously had to be
>> reset to a valid start-point using --force first.
>>
>> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
>> ---
>> Original submission:
>> http://public-inbox.org/git/52847a99-db7c-9634-b3b1-fd9b1342bc32@web.de=
/
>>
>>  Documentation/git-branch.txt | 3 ++-
>>  builtin/branch.c             | 2 +-
>>  t/t3200-branch.sh            | 7 +++++++
>>  3 files changed, 10 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.tx=
t
>> index 94dc9a54f2..5449767121 100644
>> --- a/Documentation/git-branch.txt
>> +++ b/Documentation/git-branch.txt
>> @@ -118,7 +118,8 @@ OPTIONS
>>  	Reset <branchname> to <startpoint>, even if <branchname> exists
>>  	already. Without `-f`, 'git branch' refuses to change an existing bra=
nch.
>>  	In combination with `-d` (or `--delete`), allow deleting the
>> -	branch irrespective of its merged status. In combination with
>> +	branch irrespective of its merged status, or whether it even
>> +	points to a valid commit. In combination with
>>  	`-m` (or `--move`), allow renaming the branch even if the new
>>  	branch name already exists, the same applies for `-c` (or `--copy`).
>>
>> diff --git a/builtin/branch.c b/builtin/branch.c
>> index b23b1d1752..03c7b7253a 100644
>> --- a/builtin/branch.c
>> +++ b/builtin/branch.c
>> @@ -168,7 +168,7 @@ static int check_branch_commit(const char *branchna=
me, const char *refname,
>>  			       int kinds, int force)
>>  {
>>  	struct commit *rev =3D lookup_commit_reference(the_repository, oid);
>> -	if (!rev) {
>> +	if (!force && !rev) {
>>  		error(_("Couldn't look up commit object for '%s'"), refname);
>>  		return -1;
>>  	}
>> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
>> index cc4b10236e..ec61a10c29 100755
>> --- a/t/t3200-branch.sh
>> +++ b/t/t3200-branch.sh
>> @@ -1272,6 +1272,13 @@ test_expect_success 'attempt to delete a branch =
merged to its base' '
>>  	test_must_fail git branch -d my10
>>  '
>>
>> +test_expect_success 'branch --delete --force removes dangling branch' =
'
>> +	test_when_finished "rm -f .git/refs/heads/dangling" &&
>> +	echo $ZERO_OID >.git/refs/heads/dangling &&
>> +	git branch --delete --force dangling &&
>> +	test_path_is_missing .git/refs/heads/dangling
>> +'
>
> Isn't a more meaningful test here to use a "real" SHA, instead of the
> $ZERO_OID? You can use $(test_oid deadbeef) to get one of those.
>
> That way we know that this this test & logic is really testing that we
> can delete a branch that's been racily GC'd away or whatever, and not
> one in the already-broken state of referring to the $ZERO_OID.

Right, git branch --delete could cheat by treating all-zero object IDs
specially, and the test would then not exercise the original scenario.

> Also: How does "git tag -d" handle this scenario if the same sort of
> data were added to .git/refs/tags/* ?

It deletes that tag, no --force needed.

Ren=C3=A9
