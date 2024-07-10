Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 212CB192B60
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 13:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720617145; cv=none; b=gNVGJA/0CRFGRme3Mn3DajM/l97cvkeHf6hdImVVh6yU4Xub6gAL1Txal+1SGRh9IYKwYY8Y+LMVugpE7XrA05qLNuGI5Nls1jUycw7STIebtdzOVkIPcDo8gx08Ddz4YakhB3g5G3JNdErGhNIVcY9uqQ3nhTEYFGlSg11ahzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720617145; c=relaxed/simple;
	bh=P4bLinzUTtx6FvFtT/rO5wzSUh6cD9ToLAgEXJE1Y2A=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=j+YUsfI0ye/o1gFCXgt7p97bxBFuPDRX0/yzmrfDZ2FZ86Q8fV1Z0w+e3yXUdLJTRpbK4iSUIJgkCVViR0F2QZyHdm7rNwZiMFIyBqz1u3RTdlkHbi+IH/KrrUKPvMMadWgaSzNdkmy9uA+rwyjOQJOEF2EZ33biKjG9ou6O0/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XK1H7xKb; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XK1H7xKb"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-25e0663de76so3031983fac.1
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 06:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720617143; x=1721221943; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Nrkcic1MdQhAthGZTQ06J0LMtQUiVpJG4N0tBmHRRKM=;
        b=XK1H7xKbD9tB82u+tbWCcYOqnMY68bPczWUmxQNlabWnIrOnguKO8NmYEGqdcwvItM
         V/onuf0DQF6ePmuseWCYV6fILvQYpqgZMLpnVoxaYlyLmGdCFLY+FC0oCXWX7IWk5f5m
         A03dBIkNGZoMR61UtE6JMY6g/11qS2is3b49g0Haq6DsfReaX1bqDSJL1JQono/Xpjgw
         qW+vBLopRZnouOHiNUXN6JFjKLondSpD0jQtfB6QehzRJ2TSwAYr5MKedxV3/SjoNEIB
         GX0L28s9nQMyVRnNjB9bRw1ERF66h42xqfMrQTZ0I1ThKJjN1YfalAgd4B93+1PywMic
         VvpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720617143; x=1721221943;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nrkcic1MdQhAthGZTQ06J0LMtQUiVpJG4N0tBmHRRKM=;
        b=nO7Yi4tH1Nbf9t9TU5r2dZBKwZL9+EsbEe74csXvqxNBvqLf30Z84LuZewu4gX+pZu
         0Ws9zmttW/YB3dulnuHFxJnXHB6nzX9ogCC9EDP3pKyoIrcflIjBHL+wwCYSN9G3WXsD
         5Mk9aQA4Lqpi4DtD4aAvgeUPhT3fwYGVAcFLeLj0hc0EpS3c30YIf+RSqqHsQKmT8ZXl
         0z2bVziBBQCby/1QEc+g3W34MYVRM1+cHCEaDVI/8MCh0sOON+J+Iimq+SxD7wkkLIP9
         c7ASgLnlPIAhEF1ADgNVdSjzHk2alePn+xx07ZGUkGeJQCLRL5ECP66qTsyRaIwkY+Vc
         bEgg==
X-Gm-Message-State: AOJu0YyB5nTIfxy2/rOLW6tTeTBFL3eGcm2RYnpVNkZO0mZwMq7/pa05
	L3ghvlgQQvbGrf1rCTSV6uhxj+gWI3xY2QNvfvFjZdtdoRoUBT1o0zRrF5YE+GJd0IfuEL08TML
	YUvXj6+7O1mxDnQFMxnUaM8eD74l+Egb/
X-Google-Smtp-Source: AGHT+IFfZf7lKt3hm5tRahu0e4OrVRKNMLDAGxpDXCWYWTRSUu2hDSwFh6HvplkMREMjlPKeSA7n3B+LvEa93uTyI0k=
X-Received: by 2002:a05:6870:c6a1:b0:25e:97a:cd69 with SMTP id
 586e51a60fabf-25eaec3f148mr3552879fac.55.1720617142913; Wed, 10 Jul 2024
 06:12:22 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 10 Jul 2024 06:12:21 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq4j8yflrq.fsf@gitster.g>
References: <20240708140350.622986-1-karthik.188@gmail.com>
 <20240709144931.1146528-1-karthik.188@gmail.com> <xmqq4j8yflrq.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 10 Jul 2024 06:12:21 -0700
Message-ID: <CAOLa=ZQXZ6DyE3YjuVU48nQcj0xuW7uPoPvg2yqktk+S6gXwsg@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/push: call set_refspecs after validating remote
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, peff@peff.net
Content-Type: multipart/mixed; boundary="000000000000992b4d061ce46555"

--000000000000992b4d061ce46555
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Karthik Nayak <karthik.188@gmail.com> writes:
>
>> - Added more details to the commit message to clarify the issue at hand.
>
>> Since 9badf97c42 (remote: allow resetting url list, 2024-06-14), we
>> reset the remote URL if the provided URL is empty. When a user of
>> 'remotes_remote_get' tries to fetch a remote with an empty repo name,
>> the function initializes the remote via 'make_remote'. But the remote is
>> still not a valid remote, since the URL is empty, so it tries to add the
>> URL alias using 'add_url_alias'. This in-turn will call 'add_url', but
>> since the URL is empty we call 'strvec_clear' on the `remote->url`. Back
>> in 'remotes_remote_get', we again check if the remote is valid, which
>> fails, so we return 'NULL' for the 'struct remote *' value
>
> That's better, but it still talks only about the implementation and
> control flow description without mentioning what end-user action it
> breaks.  We see in the new test this:
>
>     $ git push "" main
>
> but is that something we even want to support?  Before 9badf97c
> (remote: allow resetting url list, 2024-06-14), the command would
> have failed with different way [*1*].
>
> Is it merely "this is a nonsense request and must fail, but we do
> not want to hit BUG in general"?  I think it is the latter, but
> leaving it unsaid is confusing.  How about starting it more like...
>
>     When an end-user runs "git push" with an empty string for the
>     remote repository name, e.g.
>
>         $ git push '' main
>
>     "git push" fails with a BUG().  This is because ...
>
> or something.
>

Thanks, I was focused on the technical aspect of it that I didn't really
spill out the user interaction, you're right, it should start this way.
I will modify accordingly.

> cmd_push() calls set_refspecs() on a repo (whose name is ""), which
> then calls remote.c:remote_get() on it, which calls
> remote.c:make_remote() to obtain a remote structure.
>
> But during this calling sequence especially down from remote_get(),
> there are inconsistent decisions made for an empty string as a name.
> It is not a NULL pointer, so it does not benefit from the default
> refspecs by calling get_default=remotes_remote_for_branch,
> valid_remote_nick() considers it is not a valid nick so we do not
> read remotes or branches configuration file, but we still think a
> name was given (even though it is an empty string) and try to do
> something useful by calling add_url_alias().
>
> It is a mess and whoever designed this should be shot [*2*] ;-).
>
> In any case, an obvious additional fix on top of your change might
> be to do something like this:
>
>         diff --git i/remote.c w/remote.c
>         index 5fa046c8f8..d7f9ba3571 100644
>         --- i/remote.c
>         +++ w/remote.c
>         @@ -682,7 +682,7 @@ remotes_remote_get_1(
>                 struct remote *ret;
>                 int name_given = 0;
>
>         -	if (name)
>         +	if (name && *name)
>                         name_given = 1;
>                 else
>                         name = get_default(remote_state, remote_state->current_branch,
>
> which would give us the default remote name, and we would not call
> add_url_alias() with a bogus empty string to nuke the list.
>

I'm a bit skeptical of making this change. Mostly from the user's
perspective.

With my patch currently:

    $ git push "" refs/heads/master
    fatal: bad repository ''

But with this added, we'd be doing

    $ git push "" refs/heads/master
    Everything up-to-date

This is because we actually obtained the default remote here. Isn't this
confusing from a user's perspective? I mean I agree that an empty repo
name is something we should support, but it also shouldn't be something
we simply ignore?

>> - Cleaned up 'set_refspecs' by now accepting a remote instead of trying
>>   to obtain one.
>
> The last one, which does make sense, is not mentioned in the
> proposed log message.  Lazy remote creation does not help the
> updated caller because it already has one.
>
>> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
>> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>> +
>>  TEST_PASSES_SANITIZE_LEAK=true
>>  . ./test-lib.sh
>>
>> @@ -38,6 +41,13 @@ test_expect_success 'detect missing sha1 expressions early' '
>>  	test_cmp expect rp-ran
>>  '
>>
>> +# We need to use an existing local_ref so that the remote is mapped to
>> +# it in 'builtin/push.c:set_refspecs()'.
>
> Hmph, it is OK to force 'main' like the above as a workaround, but
> wouldn't it be sufficient to do
>
>     $ git push "" HEAD:refs/heads/main
>
> or something to avoid having to know what our current branch is?
>
> Thanks.
>

So if we're simply testing my patch, this is definitely enough. But I
wanted to also keep in mind the state before this patch. Wherein the
only way the flow would be triggered is if we provide a local_ref,
providing ':' follows a different path in 'set_refspecs'.

>
>
> [Footnote }
>
>  *1* For example, before Peff's series, here is what I got:
>
>          $ git push "" HEAD:master
>          fatal: no path specified; see 'git help pull' for valid url syntax
>
>      It comes from transport_push() -> get_refs_via_connect() ->
>      parse_connect_url() code path.
>
>  *2* It probably is me writing in the original in shell script, so I
>      can safely say this without offending anybody.

--000000000000992b4d061ce46555
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 717d83980cec92f3_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hT2lMUVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mM3pYQy9zSEFqTEY0eUlMcDFtdkZUbnVzSWJEVTh3QgpSaDJ1Q3hodkQ0
dkxWd0Q1WUJ3clRtYmRqaCtKK0VYeU81a09nYlpmRTBMYXNUS25RTk1OeFBGdEpuVlZ5SVpCCitH
REsxQWxQY05tNVpYMGZYUGgvQ3huUnlVYWVVYWx2TE5Nb2N2cHZlbnNjaG84c1BDN2UxdUdHVGRW
aG91cTEKem11VTJwVTVSRzZKRTk0cnFyNVRpb2dMNVEySlBGZXgrMmVzcy95cGsyR3FDUkxPSEpY
dHR4NEFWZTRmMWhJZQpHKzJwRzVIRm9QN0RsdCs5M0d2aDJ2bWs4V2R4MFpTMWkxSmUzenBQWXpq
TjdMVElnQllOQWZiSTlhS3J5ZkpaClFOZlFVMUlPYW1JeHdBUFlpR3VueHpublgxZE42R3NjL1M4
UitMcWtIeXJwaTFKQnVicTAxdXdFUHg5UWtqeFoKWExVTmQzb29teXpraFkvaHVweFlqSGM4a1Rx
T1o0aWtkSHFnZ0V5anBpT2J2MkZRMGFFc1N0VXJjVVRJSDU4VQp3YmFvSzEySlIzV0pEOFl6UGFV
YVExTTl3WjJQSEVqOEl4UVlaRytZalNvcFhwc2E2cHp2NEhZUW1DYTNnRFh1Ck1DdGtnKzlKNlZq
TkpyZHB4N2xKay9ncnpWbXZRWmpMYjA4My9lZz0KPXdrY1kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000992b4d061ce46555--
