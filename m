Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD,T_DKIM_INVALID
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 742B12013A
	for <e@80x24.org>; Wed, 15 Feb 2017 23:38:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755472AbdBOXiQ (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Feb 2017 18:38:16 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34316 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753306AbdBOXhp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2017 18:37:45 -0500
Received: by mail-pg0-f67.google.com with SMTP id v184so147036pgv.1
        for <git@vger.kernel.org>; Wed, 15 Feb 2017 15:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=GU7W5CClVB84uNCVZEwYtNwnmOm9wK0P69QVE603pic=;
        b=EQpkMsRJKl3dMi1LPywIpc1wHDui/yBEqikHS87tcmTyTxTmc/PsWR6VECMzbTKs7j
         JgnJNkiijFX6rkUN8YBqAOGm1D6kF8DcSs0FFeBjT2Gx12ZxPTIrthYmTOiGnIHopxRQ
         ZB1yJCtGZjWOBrO+Y3KdvVAjWZJAC0fanfiAAnegAnistFLajfiA99l2amf6ebVp4+Lu
         BCVC64MwaaBgQFAfBb64Gfx1E8lxxf+90nM8FFVZXVFe3c6ucslyw5RERle0CxnRMIpB
         otyhtDRRitennbuznzAxgxXBzvf6ZC++6p4093l4pl3QXOw6gZN96PHkSnv/dOD10Bgb
         zToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=GU7W5CClVB84uNCVZEwYtNwnmOm9wK0P69QVE603pic=;
        b=Y3NhZ95ESu+CSPp61pQrCdsO0rj0/OGk6/gEAJwxqmcUD6Bcp5EUbH2XWHETeujGWw
         vFZydR0YyOcKdghUh6A9m/d6gDDAiySojPfmatr9GAhx8JEWSOhtea/zxDRmBk9Zwyw0
         KhkBH/qzkav8fiXAIQ2+P1Fw8xaWkNvqbyN2rw+HWqoQBYYRkYyfN0TB4iNexgLZHXWj
         ovzdLAv2AWJep/h4efM8ZgxLfXI7An0jy5muOCHVQLjhUjlWoP17wBNVOu2FqvOOdbu0
         t1Vrry3B/lyau6j2ZvaIHFdOhmu0NM+dZVXRBSWnImXQxDfa6lau6A0Br/zDjCaqJ/Ld
         Abjg==
X-Gm-Message-State: AMke39nYhsNHyMabP8KaMCatJ5aUh6+EkQtUUA/g0f37jypfcOJOUhC6hAQYz7jZTktDew==
X-Received: by 10.99.248.17 with SMTP id n17mr41546381pgh.17.1487201859576;
        Wed, 15 Feb 2017 15:37:39 -0800 (PST)
Received: from localhost ([2620:0:1000:8622:3551:31c7:1fe1:8b9b])
        by smtp.gmail.com with ESMTPSA id y184sm9433963pfg.86.2017.02.15.15.37.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 15 Feb 2017 15:37:38 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Stefan Beller <sbeller@google.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] submodule config does not apply to upper case submodules?
References: <20170215111704.78320-1-larsxschneider@gmail.com>
        <xmqqzihn2smp.fsf@gitster.mtv.corp.google.com>
        <f238248f-0df2-19a5-581d-95c8a61b4632@google.com>
        <xmqqy3x712if.fsf@gitster.mtv.corp.google.com>
        <xmqqtw7v123n.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kaKhjNPGRVJ6H=CMKQ1RKXmVvSPOMo4c3haNeS60aWQXA@mail.gmail.com>
Date:   Wed, 15 Feb 2017 15:37:37 -0800
In-Reply-To: <CAGZ79kaKhjNPGRVJ6H=CMKQ1RKXmVvSPOMo4c3haNeS60aWQXA@mail.gmail.com>
        (Stefan Beller's message of "Wed, 15 Feb 2017 15:28:34 -0800")
Message-ID: <xmqqh93v10vy.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> Yes; though I'd place it in strbuf.{c,h} as it is operating
> on the internals of the strbuf. (Do we make any promises outside of
> strbuf about the internals? I mean we use .buf all the time, so maybe
> I am overly cautious here)

I'd rather have it not use struct strbuf as an interface.  It only
needs to pass "char *" and its promise that it touches the string
in-place without changing the length need to be documented as a
comment before the function.

>>  config.c | 16 +++++++++++++++-
>>  1 file changed, 15 insertions(+), 1 deletion(-)
>>
>> diff --git a/config.c b/config.c
>> index c6b874a7bf..98bf8fee32 100644
>> --- a/config.c
>> +++ b/config.c
>> @@ -201,6 +201,20 @@ void git_config_push_parameter(const char *text)
>>         strbuf_release(&env);
>>  }
>>
>> +static void canonicalize_config_variable_name(struct strbuf *var)
>> +{
>> +       char *first_dot = strchr(var->buf, '.');
>> +       char *last_dot = strrchr(var->buf, '.');
>
> If first_dot != NULL, then last_dot !+ NULL as well.
> (either both are NULL or none of them),
> so we can loose one condition below.

I do not think it is worth it, though.

>> +       char *cp;
>> +
>> +       if (first_dot)
>> +               for (cp = var->buf; *cp && cp < first_dot; cp++)
>> +                       *cp = tolower(*cp);
>> +       if (last_dot)
>> +               for (cp = last_dot; *cp; cp++)
>> +                       *cp = tolower(*cp);

	if (first_dot) {
		scan up to first dot
		if (last_dot)
			scan from last dot to the end
	}

would be uglier.
