Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E592080C1
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 14:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776867324; cv=none; b=gOFjVJod55XTZU+99M6KyjcaSdNs2VYW/+x8ilXcHXfp5u5f+ePHZMz40gs37KS7GsOdxoNfExMViGGYwpHKJpzO2gUlGq79IRL1hXztgDQqg88Qh8P5oAGljayUjD3iUEDQ4V0bF+4zkfFtx+w3NKLybDvFQWyZZosSDZlsbuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776867324; c=relaxed/simple;
	bh=VxXgpnasawaaEnepCVDtT9kazRMRRyHOLXKp3OmsFc4=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=FbmHbD3m3TdmeyAIsfFfauNflrG/saHk6tNAhC/+tEL2JTeHGG1n2Yl4Wclc3fBqreQhkUgCqm6UY8BkQ9GXrerPtg5hjyqhdVD2pys3w3f/urN5866uL+Ex+IiDniuclHqjBNPx93AuwN+VvQC/U9b33TtV3vmjdx8D6TU1My8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ky/u1N39; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ky/u1N39"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d75312379so4112863f8f.1
        for <git@vger.kernel.org>; Wed, 22 Apr 2026 07:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776867321; x=1777472121; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V0Tf9yczfzXJoDKDYeM16re2Vub5kns/p47ZAj6nCyE=;
        b=Ky/u1N39Goy3B5H9pwg772kaJW3CeDbaFdN//HHgIVFM4w7aEFlN7M3uV/9s047JaL
         6evz0mHNRdEdZ3slF3I2Z9Ex4IVL7AfNXsmcCilvfCm84Fznq3Oc+7tvRZAXq0EC1PPa
         3b9gKI1Ck/l7tNs1EAm6yxloteIoBTq4R6f2eH9hVKCv9muqSV3rrAuDmvLMXYbSP66B
         MnQe4ybKmoyECOXHmoHHc+I1Q4H9zfrKhR3xYSZs5WQnkELKxyabw+G66NUvpW2yPLs7
         5Qv1/SAEoBsZkL+BcSogG4cdKbnJvyErwWd1DRpjjOTtOCCi0RyJXJ6Y623TUtQgqN5d
         f0NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776867321; x=1777472121;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:reply-to:from:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V0Tf9yczfzXJoDKDYeM16re2Vub5kns/p47ZAj6nCyE=;
        b=ddFkVKYU7jjmINe3d+epPXnxUO1We5wtIAUPcBLivW/Btjn6Cqqm8pqBhqXQHpM9gd
         UVgB5TSbVihrP+Ums5C3t7JHU5Nue0Zo8uYtUKDLI1U4TF/Y0L1dkdD2O8UaIVAVM1o7
         01Vxjzn5luPRw1tzSXJnNccozCFsHo/1/vt/zhI9AParVxLzKOYaGTN3RNYvBwLrvBeU
         qKuZA/GU7B0ZkeL770X6jP6EZQv2/6jr+uEmc1lWTkHfQtju/E5agJtUmDQ2ig8ZxWxP
         lKzPgAo+Avy60Qbz1u5XW/v2i0zXsoLn8PQqU9/wcSA5wgYFXPvcw3ifPS/BW0h79f8S
         S/gg==
X-Gm-Message-State: AOJu0Yy+Mx5U/t0LRoO6WhI793cT0VMmQoURL1b881Hpb/og74AjNSGe
	j2vryZvx9W1HxSrRFV/Ln0kZ1XTazngYYk+ZsAt2JrFaA7UaD5tFtDUa
X-Gm-Gg: AeBDievgynycnN/c3dpsrmljUBgZeo0LWnjwyk5d5eQQBWQAKMoHg5lVrsGMkkHd9TK
	nuMDf8nmsCktAl8LFhY9uo+FXybezb2GLeGJ0QvjyLv8wyc5KOQ9RROBOpe8AvZcaWLDHNYPrtc
	U3EV093/jUA/1olDMeWW1drNkgrm5PZWBNMH1tm8GtAGO6U9UJ+hkL3OyGccjrSPgOjirk4nXd3
	6sEo45jdoCy2D36kuTKLLRKkutLfZ7sc3K3L5TZ9fLpQeBEReATp2we2B3aG4H/GfEd8TSzwF48
	N/V/YOPF4RiFzP6RGC6AQKe+26jBzs8GEJP4eOGvyOf2MUUD1TFrgiBbM0k2WU5IzCdoOK8P9pX
	HW4bkyB9z76FQPF0HICGDX1cA/DXIsCR/pjh1DGenlamAWEVzeu7vsCr+H9y7+82YL9OIXtC+E9
	aUStyQp/8zMcO70KKAhCknQpaxxWUkDp2cf8m9UvAIRBvcObnBWhw2c5aOWSI8OR/c4BqMBQK8o
	cBWbKBk1mIzTqXkuVm/jwCU
X-Received: by 2002:a05:6000:2611:b0:43d:799c:b2cb with SMTP id ffacd0b85a97d-43fe4091b08mr30417766f8f.24.1776867320988;
        Wed, 22 Apr 2026 07:15:20 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f? ([2a0a:ef40:7d8:fa01:60c8:18fb:2acc:d4f])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4cc0f31sm45847638f8f.12.2026.04.22.07.15.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Apr 2026 07:15:20 -0700 (PDT)
Message-ID: <7e44dfab-cd46-4907-b96c-58bada33b663@gmail.com>
Date: Wed, 22 Apr 2026 15:15:19 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Phillip Wood <phillip.wood123@gmail.com>
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 2/2] status: improve rebase todo list parsing
To: Elijah Newren <newren@gmail.com>,
 Phillip Wood <phillip.wood@dunelm.org.uk>
Cc: git@vger.kernel.org
References: <cover.1776697483.git.phillip.wood@dunelm.org.uk>
 <d20dc1f6550078883995ae963b91faaa00984c6e.1776697483.git.phillip.wood@dunelm.org.uk>
 <CABPp-BFziRXjuMKqf=RHgCwuCcujXSSrz0f+BS4pvE6EUbk-WQ@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CABPp-BFziRXjuMKqf=RHgCwuCcujXSSrz0f+BS4pvE6EUbk-WQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Elijah

Thanks for the review, all you suggestions look sensible to me, I'll 
send a re-roll.

Phillip

On 22/04/2026 01:32, Elijah Newren wrote:
> On Mon, Apr 20, 2026 at 8:25 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> When there is rebase in progress "git status" displays the last couple
>> of completed and the next couple of pending commands from the todo
>> list. When it does this is tries to abbreviate the object ids of
> 
> is tries => it tries ?
> 
> [...]
>> @@ -1363,6 +1363,51 @@ static int split_commit_in_progress(struct wt_status *s)
>>          free(rebase_orig_head);
>>
>>          return split_in_progress;
>> +}
>> +
>> +static void abbrev_oid_in_line(struct repository *r,
>> +                              struct strbuf *line, char **pp)
>> +{
>> +       char *p = *pp;
>> +       char *end_of_object_name, saved;
>> +       const char *abbrev;
>> +       struct object_id oid;
>> +       bool have_oid;
> 
> I'll put "thinking out loud" text in square brackets below...
> 
>> +
>> +       p += strspn(p, " \t");
>> +       end_of_object_name = p + strcspn(p, " \t");
> 
> [Advances p after whitespace, marks the end of the object with the
> next whitespace after that.]
> 
>> +       /*
>> +        * The for "merge" and "reset" the object name may be a label or
> 
> The for => For ?
> 
>> +        * ref rather than a hex object id. Only abbreviate the object
>> +        * name if it is a hex object id.
>> +        */
>> +       for (const char *q = p; q < end_of_object_name; q++) {
>> +               if (!isxdigit(*q))
>> +                       goto out;
>> +       }
> 
> 
> 
>> +       saved = *end_of_object_name;
>> +       *end_of_object_name = '\0';
>> +       have_oid = !repo_get_oid(r, p, &oid);
>> +       *end_of_object_name = saved;
> 
> [Tries to resolve the token, doing NUL-termination and restore dance.]
> 
>> +       if (!have_oid)
>> +               goto out; /* object name was a label */
> 
> 
>> +       abbrev = repo_find_unique_abbrev(r, &oid, DEFAULT_ABBREV);
>> +       if (!starts_with(p, abbrev))
>> +               goto out; /* object name was a refname containing only xdigits */
> 
> [Ensures what we have is an oid rather than a branch name that can be
> resolved to an oid]
> 
>> +       p += strlen(abbrev);
>> +       strbuf_remove(line, p - line->buf, end_of_object_name - p);
>> +       end_of_object_name = p;
> 
> [Splice out a bunch of characters in the middle?]
> 
>> +out:
>> +       *pp = end_of_object_name;
>> +}
> 
> I had a hard time following the logic in the function and trying to
> figure out what it was doing.  I went line by line but had no mental
> model to follow.  When I got to the comment that is now above
> format_todo_line(), I suddenly understood, but without it, all the
> code was hard to follow.  Maybe a small comment at the beginning of
> the function along the lines of
> 
>   /*
>    * If the whitespace-delimited token starting at or just after *pp is a
>    * full hex object id that resolves uniquely, rewrite it in place to
>    * its default abbreviation, shrinking `line` accordingly. On return
>    * *pp points one past the (possibly abbreviated) token. Leaves both
>    * `line` and *pp-advanced-past-the-token unchanged in all other cases
>    * (non-hex token, unresolvable, or a refname that happens to consist
>    * only of hex digits).
>    */
> 
> ?  (Assuming I'm understanding correctly, of course.)
> 
>> +
>> +static void skip_dash_c(char **pp) {
> 
> Move the brace to the next line?
> 
>> +       char *p = *pp;
>> +
>> +       p += strspn(p, " \t");
>> +       /* The (void) cast is required to silence -Wunused_value */
> 
> -Wunused_value => -Wunused-value ?
> 
>> +       (void)(skip_prefix(p, "-C", &p) || skip_prefix(p, "-c", &p));
>> +       *pp = p;
>>   }
>>
>>   /*
>> @@ -1371,29 +1416,57 @@ static int split_commit_in_progress(struct wt_status *s)
>>    * into
>>    * "pick d6a2f03 some message"
>>    *
>> - * The function assumes that the line does not contain useless spaces
>> - * before or after the command.
>> + * Returns false on comment lines, true otherwise
>>    */
>> -static void abbrev_oid_in_line(struct repository *r, struct strbuf *line)
>> +static bool format_todo_line(struct repository *r, struct strbuf *line)
>>   {
>> -       struct string_list split = STRING_LIST_INIT_DUP;
>> -       struct object_id oid;
>> -
>> -       if (starts_with(line->buf, "exec ") ||
>> -           starts_with(line->buf, "x ") ||
>> -           starts_with(line->buf, "label ") ||
>> -           starts_with(line->buf, "l "))
>> -               return;
>> -
>> -       if ((2 <= string_list_split(&split, line->buf, " ", 2)) &&
>> -           !repo_get_oid(r, split.items[1].string, &oid)) {
>> -               strbuf_reset(line);
>> -               strbuf_addf(line, "%s ", split.items[0].string);
>> -               strbuf_add_unique_abbrev(line, &oid, DEFAULT_ABBREV);
>> -               for (size_t i = 2; i < split.nr; i++)
>> -                       strbuf_addf(line, " %s", split.items[i].string);
>> +       enum todo_command cmd;
>> +       char *p = line->buf;
>> +
>> +       if (!sequencer_parse_todo_command((const char**)&p, &cmd))
>> +               return true; /* keep invalid lines */
>> +
>> +       switch (cmd) {
>> +       case TODO_COMMENT:
>> +               return false;
>> +
>> +       case TODO_MERGE:
>> +               skip_dash_c(&p);
>> +               while (true) {
>> +                       p += strspn(p, " \t");
>> +                       if (!p[0] || (p[0] == '#' && (!p[1] || isspace(p[1]))))
>> +                               break;
>> +                       abbrev_oid_in_line(r, line, &p);
>> +               }
>> +               break;
>> +
>> +       case TODO_FIXUP:
>> +               skip_dash_c(&p);
>> +               /* fallthrough */
>> +       case TODO_DROP:
>> +       case TODO_EDIT:
>> +       case TODO_PICK:
>> +       case TODO_RESET:
>> +       case TODO_REVERT:
>> +       case TODO_REWORD:
>> +       case TODO_SQUASH:
>> +               abbrev_oid_in_line(r, line, &p);
>> +               break;
>> +
>> +       /*
>> +        * Avoid "default" and instead list all the other commands so
>> +        * that -Wswitch warns if a new command is added without handling
>> +        * it in this function.
>> +        */
> 
> Nice. :-)
> 
>> +       case TODO_BREAK:
>> +       case TODO_EXEC:
>> +       case TODO_LABEL:
>> +       case TODO_NOOP:
>> +       case TODO_UPDATE_REF:
>> +               break;
>>          }
>> -       string_list_clear(&split, 0);
>> +
>> +       return true;
>>   }
>>
>>   static int read_rebase_todolist(struct repository *r, const char *fname, struct string_list *lines)
>> @@ -1411,13 +1484,9 @@ static int read_rebase_todolist(struct repository *r, const char *fname, struct
>>                            repo_git_path_replace(r, &buf, "%s", fname));
>>          }
>>          while (!strbuf_getline_lf(&buf, f)) {
>> -               if (starts_with(buf.buf, comment_line_str))
>> -                       continue;
>>                  strbuf_trim(&buf);
>> -               if (!buf.len)
>> -                       continue;
>> -               abbrev_oid_in_line(r, &buf);
>> -               string_list_append(lines, buf.buf);
>> +               if (format_todo_line(r, &buf))
>> +                       string_list_append(lines, buf.buf);
>>          }
>>          fclose(f);
>>
>> --
>> 2.54.0.rc1.174.gd833f386ac5.dirty
> 
> Other than the minor comments above, this looks like a nice cleanup.

