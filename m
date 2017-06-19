Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 791291FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 17:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751018AbdFSRr1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 13:47:27 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34574 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750811AbdFSRr0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 13:47:26 -0400
Received: by mail-wr0-f195.google.com with SMTP id y25so12413987wrd.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 10:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=a0qr455w44yPlUo5wyGEnyLRl1xV6bhflMqM6/POwmM=;
        b=Cu4uA/avrPLGBgLseRpyinO/+nSVwQ/EYl8p2MvNvw/V3Y/2qKTt1y+mBJrqvQtv2/
         dTKhKY8jfg9cHr2tVRr1HgjwGl94zilHm6hgaNFV5WpsxxsGwMBZcaxp1LfezqeIGtjY
         s4Lm6YnLLSI0yvzJWxSsKKDo0mPV3dt4ZJhLxazMcTKBQ04pJ/2+tzz1tuOeAbU7Teay
         ENqVhsu8lIK++a2PdQFNDys+LMK+YYUJANqwcgQcvowB23wFz8SD9iWK8IjgHlT8CYzw
         JeAZaHeDVI0PJXNFvuvRXnBTJeMMzQxo9yP1llYVBooA4fbm4ioIVjQZ5kTkJ6orC3xV
         o2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=a0qr455w44yPlUo5wyGEnyLRl1xV6bhflMqM6/POwmM=;
        b=N4/vI9dmnUeUccBKhO/xiViFFA/nA5G7HJf1DtMYnOnt8LeVFIL8HuFkibUtFd1WRW
         j/QRjjtqxwj4THi89X1HmgfQExBUpkesDYAc8Ky6+1UZxqak/DHjJmzRLRDQpCO28Hp6
         t6F1Asm/MJSmT7l6/0vdr5apvJzvrJjLE8D+a1p2e9oq6/6Ou9tRDLjsEgHDluoGTi+7
         guc+OLptRbsQLd/BmeGyUOuuyHC75XLO8m+oEk0PYtig7C7RT1g0/PqlTeutqUTCeZL7
         Wh4G+b3KO/U2nZLqpmuwL3jjGnsu31gaZGmw6GzGkSob/nhzaw0FIjrgX/4Ll247NT6u
         sp5A==
X-Gm-Message-State: AKS2vOzq0UdDBzRGa4FQsJTD7ohf8zVKp1Gi+JtEdsLikHYgVJgemevH
        eroXtxMNFZ/Nrw==
X-Received: by 10.223.133.211 with SMTP id 19mr2872671wru.27.1497894444280;
        Mon, 19 Jun 2017 10:47:24 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id w79sm6250640wrc.33.2017.06.19.10.47.23
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 10:47:23 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 4/5] convert: move multiple file filter error handling to separate function
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <cedddaed-829d-9bde-3399-5b4e85dcbe57@web.de>
Date:   Mon, 19 Jun 2017 19:47:22 +0200
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, e@80x24.org, ttaylorr@github.com,
        peartben@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <AE3AB022-B7C8-4C13-AF8F-E561E9AA57D2@gmail.com>
References: <20170601082203.50397-1-larsxschneider@gmail.com> <20170601082203.50397-5-larsxschneider@gmail.com> <be787e74-5f37-8429-9976-abdf8725737c@web.de> <28D2B758-7E5D-4EEA-A33D-57871960D5E1@gmail.com> <cedddaed-829d-9bde-3399-5b4e85dcbe57@web.de>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 19 Jun 2017, at 19:18, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
> On 2017-06-18 13:47, Lars Schneider wrote:
>>=20
>>> On 18 Jun 2017, at 09:20, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>>>=20
>>>=20
>>> On 2017-06-01 10:22, Lars Schneider wrote:
>>>> This is useful for the subsequent patch 'convert: add =
"status=3Ddelayed" to
>>>> filter process protocol'.
>>>=20
>>> May be
>>> Collecting all filter error handling is useful for the subsequent =
patch
>>> 'convert: add "status=3Ddelayed" to filter process protocol'.
>>=20
>> I think I get your point. However, I feel "Collecting" is not the =
right word.
>>=20
>> How about:
>> "Refactoring filter error handling is useful..."?
>=20
> OK

OK, I'll change it in the next round.

>>>>=20
>>>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>>>> ---
>>>> convert.c | 47 ++++++++++++++++++++++++++---------------------
>>>> 1 file changed, 26 insertions(+), 21 deletions(-)
>>>>=20
>>>> diff --git a/convert.c b/convert.c
>>>> index f1e168bc30..a5e09bb0e8 100644
>>>> --- a/convert.c
>>>> +++ b/convert.c
>>>> @@ -565,6 +565,29 @@ static int start_multi_file_filter_fn(struct =
subprocess_entry *subprocess)
>>>> 	return err;
>>>> }
>>>>=20
>>>> +static void handle_filter_error(const struct strbuf =
*filter_status,
>>>> +				struct cmd2process *entry,
>>>> +				const unsigned int wanted_capability) {
>>>> +	if (!strcmp(filter_status->buf, "error")) {
>>>> +		/* The filter signaled a problem with the file. */
>>>> +	} else if (!strcmp(filter_status->buf, "abort") && =
wanted_capability) {
>>>> +		/*
>>>> +		 * The filter signaled a permanent problem. Don't try to =
filter
>>>> +		 * files with the same command for the lifetime of the =
current
>>>> +		 * Git process.
>>>> +		 */
>>>> +		 entry->supported_capabilities &=3D ~wanted_capability;
>>>> +	} else {
>>>> +		/*
>>>> +		 * Something went wrong with the protocol filter.
>>>> +		 * Force shutdown and restart if another blob requires =
filtering.
>>>> +		 */
>>>> +		error("external filter '%s' failed", =
entry->subprocess.cmd);
>>>> +		subprocess_stop(&subprocess_map, &entry->subprocess);
>>>> +		free(entry);
>>>> +	}
>>>> +}
>>>> +
>>>> static int apply_multi_file_filter(const char *path, const char =
*src, size_t len,
>>>> 				   int fd, struct strbuf *dst, const =
char *cmd,
>>>> 				   const unsigned int wanted_capability)
>>>> @@ -656,28 +679,10 @@ static int apply_multi_file_filter(const char =
*path, const char *src, size_t len
>>>> done:
>>>> 	sigchain_pop(SIGPIPE);
>>>>=20
>>>> -	if (err) {
>>>> -		if (!strcmp(filter_status.buf, "error")) {
>>>> -			/* The filter signaled a problem with the file. =
*/
>>>               Note1: Do we need a line with a single ";" here ?
>>=20
>> The single ";" wouldn't hurt but I don't think it is helpful either.
>> I can't find anything in the coding guidelines about this...
>=20
> OK about that. I was thinking to remove the {}, and the we -need- the =
";"

True. However, I prefer the {} style here. Would that be OK with you?
Plus, this commit is not supposed to change code. I just want to move =
the
code to a different function.


>>>               Question: What should/will happen to the file ?
>>>               Will Git complain later ? Retry later ?
>>=20
>> The file is not filtered and Git does not try, again.=20
>> That might be OK for certain filters:
>> If "filter.foo.required =3D false" then this would be OK.=20
>> If "filter.foo.required =3D true" then this would cause an error.
>=20
> Does it make sense to add it as a comment ?
> I know, everything is documented otherwise, but when looking at the =
source
> code only, the context may be useful, it may be not.

I agree. I'll add a comment!

>>=20
>>>> -		} else if (!strcmp(filter_status.buf, "abort")) {
>>>> -			/*
>>>> -			 * The filter signaled a permanent problem. =
Don't try to filter
>>>> -			 * files with the same command for the lifetime =
of the current
>>>> -			 * Git process.
>>>> -			 */
>>>> -			 entry->supported_capabilities &=3D =
~wanted_capability;
>>>                        Hm, could this be clarified somewhat ?
>>>                        Mapping "abort" to "permanent problem" makes =
sense as
>>>                        such, but the only action that is done is to =
reset
>>>                        a capablity.
>>=20
>> I am not sure what you mean with "reset capability". We disable the =
capability here.
>> That means Git will not use the capability for the active session.
>=20
> Sorry, my wrong - reset is a bad word here.
> "Git will not use the capability for the active session" is perfect!

OK :)


>>> 		/*
>>> 		 * The filter signaled a missing capabilty. Don't try to =
filter
>>> 		 * files with the same command for the lifetime of the =
current
>>> 		 * Git process.
>>> 		 */
>>=20
>> I like the original version better because the capability is not =
"missing".
>> There is "a permanent problem" and the filter wants to signal Git to =
not use
>> this capability for the current session anymore.
>=20
> Git and the filter are in a negotiation phase to find out which side =
is able
> to do what.So I don't think there is a "problem" (in the sense that I =
understand
> it) at all.

No, at this point they are passed the negotiation phase. A problem =
actually
happened.


> And back to the "abort":
> I still think that the word feels to harsh...
> "abort" in my understanding smells too much "a program is terminated".
> If it is not too late, does it may sense to use something like "nack" =
?

Well, at this point it is too late because we don't retry.

Plus, I would prefer to not change code here as this commit is supposed
to just move existing code. Changing "abort" would change the protocol
that was released with Git 2.11.


>>=20
>>>                # And the there is a question why the answer is =
"abort" and not
>>>                # "unsupported"
>>=20
>> Because the filter supports the capability. There is just some kind =
of failure that=20
>> that causes the capability to not work as expected. Again, depending =
on the filter
>> "required" flag this is an error or not.
>>=20
>=20
> May be I misunderstood the whole sequence, and abort is the right =
thing.
> If yes, how about this ?
>=20
> 	} else if (!strcmp(filter_status->buf, "abort") && =
wanted_capability) {
> 		/*
> 		 * Don't try to filter files with this capability for =
lifetime
> 		 * of the current Git process.
> 		 */
> 		 entry->supported_capabilities &=3D ~wanted_capability;

How about this:

The filter signaled a problem. Don't try to filter files with this =
capability=20
for the lifetime of the current Git process.

?

Thanks,
Lars=
