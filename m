Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FB6190664
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 21:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719437010; cv=none; b=trhYUlpLtVJAgRMlQjoorFM9ztj2jA1FQcBJzAgLOT+JArkgn4mUbzOmAM2h34NTWBCwyqmP9l/wfsDq1dl7EcvymuhOY5gOBr8Edi/JlJZ4NMFk1x4JJ+Dex8po9g0Vmxe7ZNGeWmsrJqM0lDzyfbTjKUmSZrfE6EF++HCcmkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719437010; c=relaxed/simple;
	bh=7dwlKd+1fJexx3Ia4a+uEby+SszBOspzNh2S6lRmydc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YDNBdoQ83s5/OxMPNrHMpTfBHZWl2G73hu8qLdeLcPW72COEZYCMdzd6kAO4jaPXBb858xrwSZ0RGtXEneF8syXWP0uNecFdPxbu4yk12jKjHt99Rp2deH88PjwutMp45ycexLZJyeGMz0q329asxTPXO6FO9y3iVZUvZFKy4D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iC8stuFy; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iC8stuFy"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6f855b2499cso3872197a34.1
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 14:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719437008; x=1720041808; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=dRLKQ/JaIZAWAmqMaIvoGCZc2Gi+LYjFhmBrWndrpP8=;
        b=iC8stuFyFAudk6Qg+4Iit11bJjqCnmV+GW3yjlMBaAs/DBCqXEFcyjgO24UCuw0X9+
         TsghSDfDsIU9PTLp2c8aRLShTf5TKnB4Ktfvq+l49mfjndT75lbpA4gdzneqPsl/ilkz
         G2VEIA+y/V7BylWQVGchVYSI+Jej/yF9OWzrGLImqdjqbQBmQbuzvXV5/cws1l7j4Ckv
         umQZbe/k27KwTNTHAJTs1h+68HLSTStNbs/jW+Nw9/p6KTL538gs2gPrOYjEOJDh9+yo
         al0snqn7NYYVmqC0jGrJOCvNjusfXgbpZgNGQuv34Y80P/Z6sESVvEBXs9abDv594jv7
         hNig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719437008; x=1720041808;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRLKQ/JaIZAWAmqMaIvoGCZc2Gi+LYjFhmBrWndrpP8=;
        b=vqKeRLKz8Nlg+xlx2hkZ51hln1JJr/zOkx1dllgIi7KoC5nBI9+T8uMWMNDbnRTjV5
         ynFKdkZD++iR39fwgHDUc8J1WqgJyVlnoDmtLs8vT+8EbRlg0LJqDdZ1hZVXS5TRgx2A
         0D+Piei+cJJzacYrW6E2l4ydq8R6eFt5MuWbOzM31ivCQpans+XixATmwlB8edbEyW+1
         e+N3ZsKRHr09Cyvvo2/io8d6fWoYIKA7du1pW6X1TrdvtEscckxUmwT3LnAS5c1u6/Z7
         k1olo/zI27tO6Ry2klPV/7ytZR9sDBwiL7bnWN1LJOiWZAfUISZvag35kgklBgMc0joK
         UAEg==
X-Gm-Message-State: AOJu0Ywv54cC6rhXRFuadPrbyGz+U+2t70UOeCU66hEKaubX7TgRjw7p
	Kde79OUuTj+lSnoZi4P5hlLHRNbnjzH0zhzxui3KIk1nyJ8DjXO8uyN0+K5QGEbmS9v2ROUFnkP
	OUoVed+nQ9cxL6lFB1eYOJnMA5tg=
X-Google-Smtp-Source: AGHT+IGfthknfy/Um3HnJrYim48XcAVFszDkjmkhb5CIwtEXgfJ/mfnpr9OJM/lkivmMiHTMXIspt58Ug6D9nzD78EI=
X-Received: by 2002:a05:6870:55c9:b0:24c:a8e6:34e7 with SMTP id
 586e51a60fabf-25d06cd6cb8mr13288674fac.26.1719437008315; Wed, 26 Jun 2024
 14:23:28 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 26 Jun 2024 17:23:26 -0400
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <xmqq8qyrzgi5.fsf@gitster.g>
References: <xmqq34p1813n.fsf@gitster.g> <20240626065223.28154-1-abhijeet.nkt@gmail.com>
 <CAOLa=ZRz2KEGiBnX1YP6JG1nXXHLfw9A3dHKO3s_ViLhq+bWww@mail.gmail.com>
 <2e80306e-2474-4254-95eb-c2902a56ffdd@gmail.com> <xmqqikxv4t1v.fsf_-_@gitster.g>
 <xmqqcyo33cgu.fsf@gitster.g> <bbc223a3-2c82-4108-adf1-5e8518ff776e@gmail.com>
 <xmqqsewz1ua5.fsf@gitster.g> <f7d0abce-b389-45ae-992a-adbc7ec10d50@gmail.com> <xmqq8qyrzgi5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 26 Jun 2024 17:23:26 -0400
Message-ID: <CAOLa=ZR9qQNDRy_gRGxw-78=CkqbqV_6-AFtdJo7WEjQNqQyAw@mail.gmail.com>
Subject: Re: Re* [PATCH v5] describe: refresh the index when 'broken' flag is used
To: Junio C Hamano <gitster@pobox.com>, Abhijeet Sonar <abhijeet.nkt@gmail.com>
Cc: git@vger.kernel.org, Paul Millar <paul.millar@desy.de>, 
	Phillip Wood <phillip.wood123@gmail.com>, Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>
Content-Type: multipart/mixed; boundary="0000000000001844ca061bd1a0bb"

--0000000000001844ca061bd1a0bb
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:
>
>> On 26/06/24 23:05, Junio C Hamano wrote:
>>> Abhijeet Sonar <abhijeet.nkt@gmail.com> writes:
>>>
>>>> To me, this looks much better.  child_process_clear's name already
>>>> suggests that is sort of like a destructor, so it makes sense to
>>>> re-initialize everything here.  I even wonder why it was not that way to
>>>> begin with.  I suppose no callers are assuming that it only clears args
>>>> and env though?
>>>
>>> I guess that validating that supposition is a prerequisite to
>>> declare the change as "much better" and "makes sense".
>>
>> OK.  I found one: at the end of submodule.c:push_submodule()
>>
>> 	if (...) {
>> 		...some setup...
>> 		if (run_command(&cp))
>> 			return 0;
>> 		close(cp.out);
>> 	}
>
> This is curious.
>
>  * What is this thing trying to do?  When run_command() fails, it
>    wants to leave cp.out open, so that the caller this returns to
>    can write into it???  That cannot be the case, as cp itself is
>    internal.  So does this "close(cp.out)" really matter?
>

This is curious one indeed, we only need to close the file descriptor
when we set `cp.out = -1`, otherwise there is no need to close `cp.out`
since `start_command()` takes care of it internally. So the
`close(cp.out)` can really be removed here.

Wonder if this was copied over from other parts of the submodule code,
where we actually set `cp.out = -1`.

>
>  * Even though we are running child_process_clear() to release the
>    resources in run_command() we are not closing the file descriptor
>    cp.out in the child_process_clear() and force the caller to close
>    it instead.  An open file descriptor is a resource, and a file
>    descriptor opened but forgotten is considered a leak.  I wonder
>    if child_process_clear() should be closing the file descriptor,
>    at least the ones it opened or dup2()ed.
>

If you see the documentation for run_command.h::child_process, it states

    /*
     * Using .in, .out, .err:
     * - Specify 0 for no redirections. No new file descriptor is allocated.
     * (child inherits stdin, stdout, stderr from parent).
     * - Specify -1 to have a pipe allocated as follows:
     *     .in: returns the writable pipe end; parent writes to it,
     *          the readable pipe end becomes child's stdin
     *     .out, .err: returns the readable pipe end; parent reads from
     *          it, the writable pipe end becomes child's stdout/stderr
     *   The caller of start_command() must close the returned FDs
     *   after it has completed reading from/writing to it!
     * - Specify > 0 to set a channel to a particular FD as follows:
     *     .in: a readable FD, becomes child's stdin
     *     .out: a writable FD, becomes child's stdout/stderr
     *     .err: a writable FD, becomes child's stderr
     *   The specified FD is closed by start_command(), even in case
     *   of errors!
     */
    int in;
    int out;
    int err;

So this makes sense right? run_command() doesn't support the pipe
options, meaning clients have to call start_command() + finish_command()
manually. When clients do call start_command() with '-1' set to these
options, they are in charge of closing the created pipes.

> In any case, you found a case where child_process_clear() may not
> want to do the full re-initialization and at the same time it is not
> doing its job sufficiently well.  Let's decide, at least for now,
> not to do the reinitialization from child_process_clear(), then.
>
> Thanks.

--0000000000001844ca061bd1a0bb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: ee15f4e7a3cef074_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1aOGhzd1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMUxCQy85dE1CSXdZSFE3bWNMNkJOYVFsMG9Eby8zRwpjdVVLWVJDSy9h
WHJYZzRtbjEwM1N3dDJUZHNZbzh3VURIbU1xOUxZbmdGUVNsQ2IyLy9SVXRDRUxvK3hwZm9YCmRy
WStXT2dqam5senZnQktEZnl5a25KRjZiNUllS1BkRGRCalhZQjd2aENldjNxRTJieVA2T3ZERTAw
eUFuWEMKTzZFY2p0c1M2RUVUTW45ak5TaEw1Smt4VlpKVjVwNVpMaGEzc2dCSmVlN0dxY21MUVpH
emF1OGQzUUlHWmxKSApuL1FvZ1BWbEdXQkVGclpXN1Q4ZDZEVFAxNjdRMEpDTGd1M0tTTDRhbWRy
WENnRnRyaGtHYVJnU2pjOVZ4NmgzCnRKMFlmcDFOSUdjdENCdFdnSmYzUzlhZm9sL3VVdnVnQ0Uv
cU5OTmt1anB2Y0xUdDlXcWdtYnVlQ2xmd0YrcGsKYmpxa3hNczFVUWdma3ZQSHBVMmw5clpKZ0c4
UDUzRlZKOHdVcFFUMDlzclVKc3l6dkEycjJ4MEo5SjV5UFBERgp0UEtJRy9sR0E2NGEwUU1RbzBx
OER6R2F2ejg3K0Q1a09LZW5WcVk0L2VXZUlvc0pUaGVTS3Q5ekZoS0w3bndvCjhrSzZnaEJVdUFV
bzZJUE1HTHByeGZTc3l2OFNvaTUvNjM4T2dpaz0KPUJHTG8KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001844ca061bd1a0bb--
