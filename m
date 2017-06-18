Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10F2D1FA7B
	for <e@80x24.org>; Sun, 18 Jun 2017 11:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752128AbdFRLr4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 07:47:56 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36486 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751895AbdFRLrz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 07:47:55 -0400
Received: by mail-wr0-f196.google.com with SMTP id 77so10521935wrb.3
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 04:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Y4NzNkVLjdG+FE3DfTk+L/5bf18WFVwk7pc6WCvtOvE=;
        b=O/C6NWHhWhQp4o0qIy5guMd5sxJJtLFUgYEGt9ToSCC3UAKLqmzzuZvIKITOdhSWDs
         Bcl0p5kYVObwm0LpQtmBJEQlDJch5I0OR8ILMwJiIx8QByOHq7r5om7m9LBSvLd1Ke8H
         XHuiblSPAiGEx0y1FF/HIvenA1Y+4nksSLsk6wEpKZQKt864NkxkxCR++zY51r76HVqM
         IGtUcolHqSFi60zH0bLtTFm977N1YRdqSNtCLdm5miSC/v1AWpxubYMCFt0OPUYBqlsR
         8ju74jXpJTNztqgu7Az5xtD3/SXL5XJUbMAxI5iFVVtOJMgxPPAyf8bfRWwy0aZGyxf8
         MqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=Y4NzNkVLjdG+FE3DfTk+L/5bf18WFVwk7pc6WCvtOvE=;
        b=XK+o+j9tbltL3+uD2Cx5oz6zLEcdsUONsjs10ySacE10guK101jJ6idjr6V50CucLb
         P8dD+eWdnSWAi1XrmI5pov7n/ZFZ0Be56Rt32I0fbWSKlWP2wse+9u48wkc5u3irSYhF
         gH5oxb7M2lnPtMQgY6vIPCg2TLr4eoR4t6bgvh70x3nYSRNx1aJzafJBIgGNvpHRYhdg
         LybYddxL7aUql4d2dpWE+iPYFvNYSsqI7zc9inE6S5wJA8YNL+SI5Kk2PgiqGNlYHtXd
         h8C3HqGMjVYGfzYYHmRCi01UIv0V90DfOxwC0rQD3YFMeGiUEIgEaesNDU8CTYXO7zsX
         nUnw==
X-Gm-Message-State: AKS2vOwwqMyxwMy5dszWrqgGqnpP/DIbzG/PVcWr3VoGm5a+7IvEP6vQ
        /XvoWt19F5j/3w==
X-Received: by 10.223.165.76 with SMTP id j12mr12662092wrb.147.1497786473872;
        Sun, 18 Jun 2017 04:47:53 -0700 (PDT)
Received: from [10.32.248.164] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id m40sm11578555wrm.4.2017.06.18.04.47.51
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 18 Jun 2017 04:47:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH v5 4/5] convert: move multiple file filter error handling to separate function
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <be787e74-5f37-8429-9976-abdf8725737c@web.de>
Date:   Sun, 18 Jun 2017 13:47:49 +0200
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, peff@peff.net,
        e@80x24.org, ttaylorr@github.com, peartben@gmail.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <28D2B758-7E5D-4EEA-A33D-57871960D5E1@gmail.com>
References: <20170601082203.50397-1-larsxschneider@gmail.com> <20170601082203.50397-5-larsxschneider@gmail.com> <be787e74-5f37-8429-9976-abdf8725737c@web.de>
To:     =?utf-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 18 Jun 2017, at 09:20, Torsten B=C3=B6gershausen <tboegi@web.de> =
wrote:
>=20
>=20
> On 2017-06-01 10:22, Lars Schneider wrote:
>> This is useful for the subsequent patch 'convert: add =
"status=3Ddelayed" to
>> filter process protocol'.
>=20
> May be
> Collecting all filter error handling is useful for the subsequent =
patch
> 'convert: add "status=3Ddelayed" to filter process protocol'.

I think I get your point. However, I feel "Collecting" is not the right =
word.

How about:
"Refactoring filter error handling is useful..."?


>>=20
>> Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
>> ---
>> convert.c | 47 ++++++++++++++++++++++++++---------------------
>> 1 file changed, 26 insertions(+), 21 deletions(-)
>>=20
>> diff --git a/convert.c b/convert.c
>> index f1e168bc30..a5e09bb0e8 100644
>> --- a/convert.c
>> +++ b/convert.c
>> @@ -565,6 +565,29 @@ static int start_multi_file_filter_fn(struct =
subprocess_entry *subprocess)
>> 	return err;
>> }
>>=20
>> +static void handle_filter_error(const struct strbuf *filter_status,
>> +				struct cmd2process *entry,
>> +				const unsigned int wanted_capability) {
>> +	if (!strcmp(filter_status->buf, "error")) {
>> +		/* The filter signaled a problem with the file. */
>> +	} else if (!strcmp(filter_status->buf, "abort") && =
wanted_capability) {
>> +		/*
>> +		 * The filter signaled a permanent problem. Don't try to =
filter
>> +		 * files with the same command for the lifetime of the =
current
>> +		 * Git process.
>> +		 */
>> +		 entry->supported_capabilities &=3D ~wanted_capability;
>> +	} else {
>> +		/*
>> +		 * Something went wrong with the protocol filter.
>> +		 * Force shutdown and restart if another blob requires =
filtering.
>> +		 */
>> +		error("external filter '%s' failed", =
entry->subprocess.cmd);
>> +		subprocess_stop(&subprocess_map, &entry->subprocess);
>> +		free(entry);
>> +	}
>> +}
>> +
>> static int apply_multi_file_filter(const char *path, const char *src, =
size_t len,
>> 				   int fd, struct strbuf *dst, const =
char *cmd,
>> 				   const unsigned int wanted_capability)
>> @@ -656,28 +679,10 @@ static int apply_multi_file_filter(const char =
*path, const char *src, size_t len
>> done:
>> 	sigchain_pop(SIGPIPE);
>>=20
>> -	if (err) {
>> -		if (!strcmp(filter_status.buf, "error")) {
>> -			/* The filter signaled a problem with the file. =
*/
>                Note1: Do we need a line with a single ";" here ?

The single ";" wouldn't hurt but I don't think it is helpful either.
I can't find anything in the coding guidelines about this...


>                Question: What should/will happen to the file ?
>                Will Git complain later ? Retry later ?

The file is not filtered and Git does not try, again.=20
That might be OK for certain filters:
If "filter.foo.required =3D false" then this would be OK.=20
If "filter.foo.required =3D true" then this would cause an error.


>> -		} else if (!strcmp(filter_status.buf, "abort")) {
>> -			/*
>> -			 * The filter signaled a permanent problem. =
Don't try to filter
>> -			 * files with the same command for the lifetime =
of the current
>> -			 * Git process.
>> -			 */
>> -			 entry->supported_capabilities &=3D =
~wanted_capability;
>                         Hm, could this be clarified somewhat ?
>                         Mapping "abort" to "permanent problem" makes =
sense as
>                         such, but the only action that is done is to =
reset
>                         a capablity.

I am not sure what you mean with "reset capability". We disable the =
capability here.
That means Git will not use the capability for the active session.


> 		/*
> 		 * The filter signaled a missing capabilty. Don't try to =
filter
> 		 * files with the same command for the lifetime of the =
current
> 		 * Git process.
> 		 */

I like the original version better because the capability is not =
"missing".
There is "a permanent problem" and the filter wants to signal Git to not =
use
this capability for the current session anymore.


>                 # And the there is a question why the answer is =
"abort" and not
>                 # "unsupported"

Because the filter supports the capability. There is just some kind of =
failure that=20
that causes the capability to not work as expected. Again, depending on =
the filter
"required" flag this is an error or not.


Thanks for the review,
Lars

