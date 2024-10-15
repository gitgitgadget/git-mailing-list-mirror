Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0421D9A5F
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 12:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728995865; cv=none; b=Y37J1O4kVe4bis2Ecfd2peeTykIKRbWqF3SeuVlqdVykzbHugtUr8nl8o2dchfh98F3F45IqezXMRanf7CbrjHELnnQ7qpUiC09Y+HBVd16qgBBpnqX5jxzD9+w4noE2Xpm7S6zOLsTXLBMqL32q/kffelcKlFvuRQP/TprJ7ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728995865; c=relaxed/simple;
	bh=ZnNYGa83Kt9X/+G1lBxXv3WSEWDh/D+ppLTgcpIy28M=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IEE4tGu+72AUL560XKZSmjzS98ONrDiIg1ZTvlbYALDXNsJk7Urf2jzVDZX7lidthCe9eQoi32CpYvzN03P95lI7F/IW8rFwpCDW7cHADhj+uSPhOPoeTRMT4dvTWztrIUpp+LFsCrU1Qz4JGxQV5gI8kASzW14td8pA+oVRnXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xkh6Gquh; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xkh6Gquh"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-50d85d7db19so117270e0c.2
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 05:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728995862; x=1729600662; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZP1qKztcsTUCCQOG2fLmW3oUp1umAUt18uSrgJVzILU=;
        b=Xkh6GquhSbgSPoJdP+Dd9L571BcYVjx69dI6uJvJOxVETS79Ug+X+uqVbwxCIG2dFB
         VZYcNiIYJDcxvueN5QDd67uyLkYdK371EkeawgHYT8GfY9eGNAfIaVi6X82iUgSaUdfn
         chSrgwgnrfnJD3XIiLvZ1lwKa7eByetqZMJBXF+AYC872rmSg8VZbO9pvQ+plyYpQ2sf
         jLF390zEaJFsReI2VEcUuPU4Th48x6GjEscWoUf59LMmvdmhLXuO+pi7sX9S53/vn2D/
         nHJJmiIPJ1RtNJCTndohpqHD/eQ7XoJjjDslBc9tRlBeFb0RYXsbWKBVmUgeECT+YxE3
         eVXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728995862; x=1729600662;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZP1qKztcsTUCCQOG2fLmW3oUp1umAUt18uSrgJVzILU=;
        b=ouqYnFAXNUg3hgniQNL5PBVZzkYLD4SU1skWkY938ThmuNtM90O7E7Q3VattYVXCfy
         jyprPTBNN2x5MbbIWl4s0JVqjxb9YEAL1oMnKe9rdqQgv65fS3irNtqYTInSqdCnXhzZ
         s3aTeaKgsP6WzTTx44l1kCP6ITs436iqeO2ngRjL/oU8K3tReoHRKxfZC1r88FCgiVND
         2I6g1vBsm1hkFk/LO/Qy/twWmwCAKtg9WA9qhqDLLnqvWzBqAVWJztl2uAGSwAEJ80+m
         O6AeaKNYr/bgWDuQyIutHbWS/TjRhiPSeYllSKh4m+4L0316J5p16g/EpCaYT4s7lv5w
         66bg==
X-Gm-Message-State: AOJu0YwtoKVRucTpwC+macHuy6wj40vIKI/2NgFmO0oql7LFQLIZK6Ac
	AEfb/7z56m2Sg3+e4aJBDYdPqGfOwYBoz9zmphQ1ZOrxDlbyEBvsA+coTpA81nLzq2e/355IUpJ
	UW1Kto/4gYz5ObS2DDh2mAhXds50=
X-Google-Smtp-Source: AGHT+IEBsdxjf1kcYXvz7h0kCD0d7am+7Hvt/DXKE4pxTiEeGPygZ/ZffuzyE5R9kbhQXCybONCYqPkS9r20Rxbvdp8=
X-Received: by 2002:a05:6122:32c9:b0:50a:d1e3:82f7 with SMTP id
 71dfb90a1353d-50d381f1ed8mr7375019e0c.8.1728995862097; Tue, 15 Oct 2024
 05:37:42 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Oct 2024 05:37:41 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <CAO_smViSU5KohOqVXp2L_cM3G-jrOGQY=J=qf=-GbiGsOYd9TQ@mail.gmail.com>
References: <cover.1728697428.git.karthik.188@gmail.com> <74bbd2f9db1ddfd5210be8fde2db84f67acff27d.1728697428.git.karthik.188@gmail.com>
 <CAO_smViSU5KohOqVXp2L_cM3G-jrOGQY=J=qf=-GbiGsOYd9TQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Oct 2024 05:37:41 -0700
Message-ID: <CAOLa=ZT0qsG7cnnzwg7GDkBuTqZO_e+C5HwT5o9kWZ1Cto=0kg@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] clang-format: re-adjust line break penalties
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, toon@iotcl.com, 
	johannes.schindelin@gmx.de
Content-Type: multipart/mixed; boundary="0000000000002dd5c506248338ca"

--0000000000002dd5c506248338ca
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kyle Lippincott <spectral@google.com> writes:

> On Fri, Oct 11, 2024 at 6:50=E2=80=AFPM Karthik Nayak <karthik.188@gmail.=
com> wrote:
>>
>> In 42efde4c29 (clang-format: adjust line break penalties, 2017-09-29) we
>> adjusted the line break penalties to really fine tune what we care about
>> while doing line breaks. Modify some of those to be more inline with
>> what we care about in the Git project now.
>>
>> We need to understand that the values set to penalties in
>> '.clang-format' are relative to each other and do not hold any absolute
>> value. The penalty arguments take an 'Unsigned' value, so we have some
>> liberty over the values we can set.
>>
>> First, in that commit, we decided, that under no circumstances do we
>> want to exceed 80 characters. This seems a bit too strict. We do
>> overshoot this limit from time to time to prioritize readability.
>
> I think that attempting to get the weights right so as to avoid cases
> where there was an intentional affordance for readability is going to
> be essentially impossible. Areas where there's an intentional
> disregard for the clang-format-generated formatting should disable the
> formatter for that line/region, instead of trying to find a way to
> adjust the rules to produce something that's going to end up being
> context dependent.
>

To some extent I agree. But the issue is that clang-format is still not
enforced within the code base. So expecting users to add:
    // clang-format off
will not hold, at least for _now_.

So the next best thing we can do is to get the format rules as close as
we can to the current styling, so the actual errors thrown by the CI job
is something we can look at without containing too many false positives.

> Example: In ref-filter.c, there's 13 lines when initializing the
> `valid_atom` array that are >80 characters, and 20 lines that are >80
> columns (when using 8-space tabs). Line breaking in that block of code
> may be undesirable, so just disable clang-format there. I don't think
> there's a consistent set of penalties you could establish that would
> handle that well without mishandling some other section of code.

While true, we can quantify if it is better or not:

      =E2=9D=AF ci/run-style-check.sh @~50 | wc -l
      4718 (master)

      =E2=9D=AF ci/run-style-check.sh @~53 | wc -l
      4475 (with these patches)

And looking through the other changes, those look like violations which
should have been fixed.

> It's also not clear what the reason for the overshoot is in many cases.
> - difference between "80 characters" and "80 columns"?
>     - (1394 >80char lines in *.{h,c}, 4849 >80col lines in the same files=
)
> - intentional for readability?
> - refactorings pushed originally compliant lines out of compliance?
> - no one caught it and it was just added without any intentional decision=
?
>

I agree with your inference here, but I'm not sure there is a smooth way
to have this information. Either we go full in and say we enable the
formatting and every patch must conform to it, or we simply keep the
clang-format as a warning system. Currently we do neither. I'd say we
should be in a state to reach the latter and then we can gradually think
of how to move to the former.

>> So
>> let's reduce the value for 'PenaltyExcessCharacter' to 10. This means we
>> that we add a penalty of 10 for each character that exceeds the column
>> limit. By itself this is enough to restrict to column limit. Tuning
>> other penalties in relation to this is what is important.
>>
>> The penalty `PenaltyBreakAssignment` talks about the penalty for
>> breaking an assignment operator on to the next line. In our project, we
>> are okay with this, so giving a value of 5, which is below the value for
>> 'PenaltyExcessCharacter' ensures that in the end, even 1 character over
>> the column limit is not worth keeping an assignment on the same line.
>>
>> Similarly set the penalty for breaking before the first call parameter
>> 'PenaltyBreakBeforeFirstCallParameter' and the penalty for breaking
>> comments 'PenaltyBreakComment' and the penalty for breaking string
>> literals 'PenaltyBreakString' also to 5.
>>
>> Finally, we really care about not breaking the return type into its own
>> line and we really care about not breaking before an open parenthesis.
>> This avoids weird formatting like:
>>
>>    static const struct strbuf *
>>           a_really_really_large_function_name(struct strbuf resolved,
>>           const char *path, int flags)
>
> Is this how it'd be indented without the penalties, or would it do
> this, with the function name indented the same amount as the return
> type (which is, in C, probably going to be the 0th column most times):
>
> static const struct strbuf *
> a_really_really_large_function_name(struct strbuf resolved,
>         const char *path, int flags)
>

It will be indented, so not the 0th column.

>>
>> or
>>
>>    static const struct strbuf *a_really_really_large_function_name(
>>             struct strbuf resolved, const char *path, int flags)
>
> Personal opinion: I prefer this over the version that has a single
> argument on the first line. My preference for reading functions is:
>
> return_type func_name(arg1, arg2,
>                       arg3, arg4,
>                       arg5, arg6, ...);
>
> Or
>
> return_type func_name(
>         arg1, arg2, arg3, arg4,
>         arg5, arg6, ...);
>

I'm mostly basing my changes on the current state of the 'clang-format'
and our code base. I'm happy to change it if everyone agrees on this :)

> or, in some cases, putting every argument on their own line (typically
> when the majority of the arguments are already on their own line, not
> having one "hiding" somewhere is preferable, but at this point if
> that's not what my formatter does, I don't fight it).
>
> For functions that accept an obvious first parameter, such as
> `strbuf_add`, maybe having the first parameter on the first line is
> acceptable/desirable, since it's "obvious" what it is/does. But for
> many functions that's not the case, and needing to read the end of the
> first line, potentially beyond the 80th column, feels weird.
>
>>
>> to instead have something more readable like:
>>
>>    static const struct strbuf *a_really_really_large_function_name(struc=
t strbuf resolved,
>>           const char *path, int flags)
>>
>> This is done by bumping the values of 'PenaltyReturnTypeOnItsOwnLine'
>> and 'PenaltyBreakOpenParenthesis' to 300. This is so that we can allow a
>> few characters above the 80 column limit to make code more readable.
>
> A few examples, such as by formatting the code using the current rules
> (since much of the codebase does not currently comply), and then
> changing the penalties and seeing what changes, might be nice?
>

You mean apart from the example above?

>
>>
>> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
>> ---
>>  .clang-format | 13 +++++++------
>>  1 file changed, 7 insertions(+), 6 deletions(-)
>>
>> diff --git a/.clang-format b/.clang-format
>> index 41969eca4b..66a2360ae5 100644
>> --- a/.clang-format
>> +++ b/.clang-format
>> @@ -209,13 +209,14 @@ KeepEmptyLinesAtTheStartOfBlocks: false
>>
>>  # Penalties
>>  # This decides what order things should be done if a line is too long
>> -PenaltyBreakAssignment: 10
>> -PenaltyBreakBeforeFirstCallParameter: 30
>> -PenaltyBreakComment: 10
>> +PenaltyBreakAssignment: 5
>> +PenaltyBreakBeforeFirstCallParameter: 5
>> +PenaltyBreakComment: 5
>>  PenaltyBreakFirstLessLess: 0
>> -PenaltyBreakString: 10
>> -PenaltyExcessCharacter: 100
>> -PenaltyReturnTypeOnItsOwnLine: 60
>> +PenaltyBreakOpenParenthesis: 300
>
> How does this interact with PenaltyBreakBeforeFirstCallParameter? Does
> one override the other?
>

From my understanding PenaltyBreakOpenParenthesis seems to apply more
generally and is the more preferred value.

[1]: https://github.com/llvm/llvm-project/blob/a4367d2d136420f562f64e7731b9=
393fb609f3fc/clang/lib/Format/TokenAnnotator.cpp#L4322

>> +PenaltyBreakString: 5
>> +PenaltyExcessCharacter: 10
>> +PenaltyReturnTypeOnItsOwnLine: 300
>>
>>  # Don't sort #include's
>>  SortIncludes: false
>> --
>> 2.47.0
>>

--0000000000002dd5c506248338ca
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: fb3192772d12a7ee_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jT1loQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOXNaQy80MU9yVFRoRHFsV3JQcFU5UktKQndWZ21aagp1dXF1bkplNXVL
RFVGNWs4SjNyQWxKZnR6bTl5WlRBWVRnbVR1OUxDaFFWYVMyejFEbVVyK1FEVFV0K1lOelJ2Cmd4
QVFwRytidExkSTMzbXlPWmNsYS9HVC9jWW5uWmNrN05GU2ptVy9KZ0lZNkR6TkRGbXBtd3NwSGM2
NFA2aHkKQTNucmN3RFM3dmoxUXF2ZW0xQlR3YWNKWkZwcVJsamE3Z2pzNzNNeVgxUUpiZDZRTDFY
TnhrSjVkWnJkclhsQQpoNlNKcW0xeFExQkhDSTQ5N1RRZnFCYXJRVUlFSjVrVEhFZnhkQ0doYWNq
Ni9YRzdJZys2V1RFY3BIWE9FdmY1CkowRjJHSlBXTmN0QTZJVi81VzZTS016M1pxN1dibEZqQkg5
TmhQUzJEU0g3K2pOSzN6dkZ3c1Zqa2dWTmNJOFYKK0x0NFdxdFI0T0E3MjdQRVdTVEcrVTVSVVU3
YXh0Qkxua1JqWW1kbG9HKzhGTkNNWVF0RXN0djhLSzhoVGRNcAo2L3VKalBMbVlZMjBtNkwrQUxn
RlFDaFJhVXJEMkpGT3FSV0N0bHV5WlpGZFFEaDFtYVJUZmlKOEI0KzM4T1kyCjJTdWY3ZWg2MXlI
cFhaY014ZVhHZFo3ZUJaT0hTamkzSzc5NHdSTT0KPURvQmoKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000002dd5c506248338ca--
