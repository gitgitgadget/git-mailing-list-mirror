Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B70EE1F403
	for <e@80x24.org>; Mon,  4 Jun 2018 10:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752437AbeFDKIo (ORCPT <rfc822;e@80x24.org>);
        Mon, 4 Jun 2018 06:08:44 -0400
Received: from smtp-out-4.talktalk.net ([62.24.135.68]:27271 "EHLO
        smtp-out-4.talktalk.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752143AbeFDKIn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Jun 2018 06:08:43 -0400
Received: from [192.168.2.201] ([92.28.141.91])
        by smtp.talktalk.net with SMTP
        id PmPnfZGKIoI6LPmPofsEwY; Mon, 04 Jun 2018 11:08:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=talktalk.net;
        s=cmr1711; t=1528106921;
        bh=ioMJ3AlUCN4xxKaWXgVnfGjK6fcCH1dYsl9Hga5EALw=;
        h=Reply-To:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=nLjmttx18rBs75sISa9owygynVG9FLquePnQwOihKttM9bDlxuPiMUYbYdipk/ur5
         y65dR3PG4OcXYP9TN0BGlkPCGGCp/dQTkCeeCSeF+fXhAnYpJSm9EHzbi96p0iVR2Y
         vJRbp1tgRGrPh00ftiUyUmcMRF00WK99wan64cC4=
X-Originating-IP: [92.28.141.91]
X-Spam: 0
X-OAuthority: v=2.3 cv=FOE1Odgs c=1 sm=1 tr=0 a=F7/ux0bycE+fyj5NxA3FBg==:117
 a=F7/ux0bycE+fyj5NxA3FBg==:17 a=IkcTkHD0fZMA:10 a=nN7BH9HXAAAA:8
 a=evINK-nbAAAA:8 a=_IEhM8lNAAAA:8 a=HCd7poqbI5i6ohfT7osA:9
 a=dTkfhCl5svkatJXc:21 a=XdoOyxRJFAoioNGu:21 a=QEXdDO2ut3YA:10
 a=t52e0w4QHkkA:10 a=RfR_gqz1fSpA9VikTjo0:22 a=WN5SZLvFwbRUu1hQBHWk:22
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] add -p: fix counting empty context lines in edited
 patches
To:     Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Martin Agren <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Oliver Joseph Ash <oliverjash@gmail.com>,
        Mahmoud Al-Qudsi <mqudsi@neosmart.net>,
        Jeff Felchner <jfelchner1@gmail.com>
References: <01010162c940b8bb-d8139971-3ee2-4cd6-bb19-35126d46753b-000000@us-west-2.amazonses.com>
 <20180601174644.13055-1-phillip.wood@talktalk.net>
 <CAPig+cSSj2ETXfk8FYUc+=tE6bfoRuqF5Ld4kOgE4+DDpfL+BA@mail.gmail.com>
From:   Phillip Wood <phillip.wood@talktalk.net>
Message-ID: <36f2d9e0-ba79-64d3-ffb5-d0772cafa153@talktalk.net>
Date:   Mon, 4 Jun 2018 11:08:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSSj2ETXfk8FYUc+=tE6bfoRuqF5Ld4kOgE4+DDpfL+BA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGjRfpfDPO0oAEBUIBdUG8qpnUE6WcusXgPURTHdlabn9VmcoYqysWR5mZVzdAJdk+ZOdXhjDqyQpGaNti1/N1Il4BQpnMkLFBj3QTtHYqyyQXFKMHjM
 icBJccxRyDRZYyYdRays2n2eKzD0AyumuwVpXORb4SkbM1LNgOD2K58VTJyGFxzcVcIcWvffHiZ15qEfV30rfQmDO+pA/Kn7ocUsZU9I3WBaIS8P8nMX7qOt
 ZND5y8rRb9GdH+HVZN428Ewg3oKc1QPb5AO4LrrFC8NniOMcIm211PdaW9hyXJvEJ8NQsav2XUywdwMWS96JGWvNCVkrP4Nr23jlzugmnUg8hqHX6BVVBeKO
 3hmAWQQez/a8dZ7Yw+S6+QAuMZnuIHZesaCiS9tBnCZss2anRob/P0NJAz7mOcYL48cJFV/t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/06/18 21:03, Eric Sunshine wrote:
> On Fri, Jun 1, 2018 at 1:46 PM, Phillip Wood <phillip.wood@talktalk.net> wrote:
>> recount_edited_hunk() introduced in commit 2b8ea7f3c7 ("add -p:
>> calculate offset delta for edited patches", 2018-03-05) required all
>> context lines to start with a space, empty lines are not counted. This
>> was intended to avoid any recounting problems if the user had
>> introduced empty lines at the end when editing the patch. However this
>> introduced a regression into 'git add -p' as it seems it is common for
>> editors to strip the trailing whitespace from empty context lines when
>> patches are edited thereby introducing empty lines that should be
>> counted. 'git apply' knows how to deal with such empty lines and POSIX
>> states that whether or not there is an space on an empty context line
>> is implementation defined [1].
>>
>> Fix the regression by counting lines consist solely of a newline as
> 
> s/consist/&ing/
> --or--
> s/consist/that &/

Thanks, I'd intended to say 'that consist'

>> well as lines starting with a space as context lines and add a test to
>> prevent future regressions.
>>
>> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>> ---
>>  git-add--interactive.perl  |  2 +-
>> diff --git a/git-add--interactive.perl b/git-add--interactive.perl
>> @@ -1047,7 +1047,7 @@ sub recount_edited_hunk {
>> -               } elsif ($mode eq ' ') {
>> +               } elsif ($mode eq ' ' or $_ eq "\n") {
> 
> Based upon a very cursory read of parts of git-add-interactive.perl,
> do I understand correctly that we don't have to worry about $_ ever
> being "\r\n" on Windows?
>

Good question, I think the short answer no. If my understanding of the
newline section of perlport [1] is correct then on Windows "\n" eq
"\012" and the io layer replaces "\015\012" with "\n" when reading in
'text' mode (which I think is the default if you don't specify one when
opening the file/process or with binmode()). As "\n" is only one
character it would perhaps be better to test '$mode' rather than '$_'
above - what do you think.

[1] http://perldoc.perl.org/perlport.html#Newlines

>> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
>> @@ -175,6 +175,49 @@ test_expect_success 'real edit works' '
>> +test_expect_success 'setup file' '
>> +       test_write_lines a "" b "" c >file &&
>> +       git add file &&
>> +       test_write_lines a "" d "" c >file
>> +'
>> +
>> +test_expect_success 'setup patch' '
>> +       SP=" " &&
>> +       NULL="" &&
>> +       cat >patch <<-EOF
>> +       [...]
>> +       EOF
>> +'
>> +
>> +test_expect_success 'setup expected' '
>> +       cat >expected <<-EOF
>> +       [...]
>> +       EOF
>> +'
>> +
>> +test_expect_success 'edit can strip spaces from empty context lines' '
>> +       test_write_lines e n q | git add -p 2>error &&
>> +       test_must_be_empty error &&
>> +       git diff >output &&
>> +       diff_cmp expected output
>> +'
> 
> I would have expected all the setup work to be contained directly in
> the sole test which needs it rather than spread over three tests (two
> of which are composed of a single command). Not a big deal, and not
> worth a re-roll.

Good point I was torn between that and matching the existing style in
that file seems to be to create a million ancillary tests to do the set-up.

Thanks

Phillip


