Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEA051F403
	for <e@80x24.org>; Tue,  5 Jun 2018 10:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751502AbeFEK4Q (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Jun 2018 06:56:16 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:33295 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751386AbeFEK4P (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jun 2018 06:56:15 -0400
Received: by mail-ot0-f193.google.com with SMTP id h6-v6so2258066otj.0
        for <git@vger.kernel.org>; Tue, 05 Jun 2018 03:56:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Dkxq/OalWJaCj5/lXkzlLPuV6Q24zOaY4mXeLlQlqik=;
        b=FmdTPAeOacgZtw3r2ME0wQzD8tddCDL9AF6Y6s5uZ2Od6LyvFP63AHM8lUiycliwpQ
         3zoDu9O5CTp5L74+1DaRrIlBcb0R7O7lQAVePwg+sLNUCZ5MdG2b3mCxCVEzm/2NC/7q
         Ccv/OIxoXRzihWWsucMzbxUpEilxq8+VGsWvQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Dkxq/OalWJaCj5/lXkzlLPuV6Q24zOaY4mXeLlQlqik=;
        b=Np93PyVEhF1JhAxQ+H2JA17xB4eb4vwPssk0Y63012G2D2Z96tFJHlD1+mxbr89Nr4
         1zdxI/e6ck1swF6UIf3YucmY3GWvWGjaGdvSeBlxcqNx8r9+PLMOrM2egMlwEHD2Popg
         LdM4FzuK7bzXQL0WimMB7wQpPOTjpDxuy7WwDrn8j5CnNseuKhx1ULdrmSp1Q8HQIZAj
         6kmFp6ie6GE8g/cMJPsUahMhSaiVVdBmSHxq3VoQzGWyz3w+e7GAn/QR6Q82DGTGYUMA
         O2A8r10D4PqD0DYdWus5ZSZPuEyqwHcDWeFHCmtE7qH+5/Gmz2sKrjN0athWlyGaN7Wo
         pclA==
X-Gm-Message-State: ALKqPwd69avA/nvu0n2MHkTD4gL9hi9EF/KzsjWKxirRlfl2wnD92G/x
        XqujD+bVusYsNuu2pC1ya7+K/TJJEasSYMHVgf2VMw==
X-Google-Smtp-Source: ADUXVKI4RSY5RwqKAv53DzTTObnZISwrQQwoQjQtvRxmDkW54jPnl/+EXa4JixBT1ExItqG5+RCxMs1RRAd/n1RQMpI=
X-Received: by 2002:a9d:c41:: with SMTP id 59-v6mr16390188otr.255.1528196174500;
 Tue, 05 Jun 2018 03:56:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:2f8e:0:0:0:0:0 with HTTP; Tue, 5 Jun 2018 03:56:14 -0700 (PDT)
In-Reply-To: <CAPig+cQTTY8wc4d=4jV8GxHDOjF7xk1vjA62JS6s4Zr0uXiegg@mail.gmail.com>
References: <20180605091350.14476-1-luke@diamand.org> <20180605091350.14476-2-luke@diamand.org>
 <CAPig+cQTTY8wc4d=4jV8GxHDOjF7xk1vjA62JS6s4Zr0uXiegg@mail.gmail.com>
From:   Luke Diamand <luke@diamand.org>
Date:   Tue, 5 Jun 2018 11:56:14 +0100
Message-ID: <CAE5ih7-1StB8RNrobO+hpG2QOSdoscUNfVP9+muZV0_b+m+XSw@mail.gmail.com>
Subject: Re: [PATCHv1 1/3] git-p4: raise exceptions from p4CmdList based on
 error from p4 server
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Merland Romain <merlorom@yahoo.fr>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lex Spoon <lex@lexspoon.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5 June 2018 at 10:54, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jun 5, 2018 at 5:14 AM Luke Diamand <luke@diamand.org> wrote:
>> This change lays some groundwork for better handling of rowcount errors
>> from the server, where it fails to send us results because we requested
>> too many.
>>
>> It adds an option to p4CmdList() to return errors as a Python exception.
>>
>> The exceptions are derived from P4Exception (something went wrong),
>> P4ServerException (the server sent us an error code) and
>> P4RequestSizeException (we requested too many rows/results from the
>> server database).
>>
>> This makes makes the code that handles the errors a bit easier.
>>
>> The default behavior is unchanged; the new code is enabled with a flag.
>>
>> Signed-off-by: Luke Diamand <luke@diamand.org>
>> ---
>> diff --git a/git-p4.py b/git-p4.py
>> @@ -566,10 +566,30 @@ def isModeExec(mode):
>> +class P4ServerException(Exception):
>> +    """ Base class for exceptions where we get some kind of marshalled up result from the server """
>> +    def __init__(self, exit_code, p4_result):
>> +        super(P4ServerException, self).__init__(exit_code)
>> +        self.p4_result = p4_result
>> +        self.code = p4_result[0]['code']
>> +        self.data = p4_result[0]['data']
>
> The subsequent patches never seem to access any of these fields, so
> it's difficult to judge whether it's worthwhile having 'code' and
> 'data' bits split out like this.

These changes don't use it, but I thought that future changes might
need them, and perhaps when I put that code in I was thinking I might
need it myself.

>
>> @@ -616,9 +636,25 @@ def p4CmdList(cmd, stdin=None, stdin_mode='w+b', cb=None, skip_info=False):
>>      if exitCode != 0:
>> -        entry = {}
>> -        entry["p4ExitCode"] = exitCode
>> -        result.append(entry)
>> +        if errors_as_exceptions:
>> +            if len(result) > 0:
>> +                data = result[0].get('data')
>> +                if data:
>> +                    m = re.search('Too many rows scanned \(over (\d+)\)', data)
>> +                    if not m:
>> +                        m = re.search('Request too large \(over (\d+)\)', data)
>
> Does 'p4' localize these error messages?

That's a good question.

The marshalled-up error from Perforce looks like this:

     ([{'generic': 35, 'code': 'error', 'data': "Too many rows scanned
(over 40); see 'p4 help maxscanrows'.\n", 'severity': 3}])

It turns out that Perforce open-sourced the P4 client in 2014 (I only
recently found this out) so we can actually look at the code now!

    https://swarm.workshop.perforce.com/projects/perforce_software-p4

Clone it like this:

mkdir p4 &&
(cd p4 && git init && git config --add git-p4.branchList p4/2018-1:2018-1) &&
P4USER=guest P4PORT=workshop.perforce.com:1666 git p4 clone
--detect-branches --destination p4  //guest/perforce_software/p4@all

Here's the code:

    // ErrorId graveyard: retired/deprecated ErrorIds.

    ErrorId MsgDb::MaxResults              = { ErrorOf( ES_DB, 32,
E_FAILED, EV_ADMIN, 1 ), "Request too large (over %maxResults%); see
'p4 help maxresults'." } ;//NOTRANS
    ErrorId MsgDb::MaxScanRows             = { ErrorOf( ES_DB, 61,
E_FAILED, EV_ADMIN, 1 ), "Too many rows scanned (over %maxScanRows%);
see 'p4 help maxscanrows'." } ;//NOTRANS


I don't think there's actually a way to make it return any language
other than English though. There's a P4LANGUAGE environment variable,
but it just says "this is for system integrators":

https://www.perforce.com/perforce/r15.2/manuals/cmdref/P4LANGUAGE.html

So I think probably the language is always English.

Luke
