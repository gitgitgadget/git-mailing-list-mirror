From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv7 5/5] pathspec: allow querying for attributes
Date: Wed, 18 May 2016 15:31:45 -0700
Message-ID: <CAGZ79ka0Of6S3AGx24jrvso=AwMsxQOnWVFZA-XWy3590JbVgA@mail.gmail.com>
References: <20160518190222.28105-1-sbeller@google.com> <20160518190222.28105-6-sbeller@google.com>
 <xmqq7ferrvvd.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 00:31:53 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3A0N-0002ws-9j
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 00:31:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751284AbcERWbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 May 2016 18:31:47 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:36697 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbcERWbq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 18:31:46 -0400
Received: by mail-io0-f174.google.com with SMTP id i75so84633800ioa.3
        for <git@vger.kernel.org>; Wed, 18 May 2016 15:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=paRPrko8zRB+9F5qLyDdKMHPAPOGZyd24aaptDwUJBU=;
        b=pihlYq/Qpi4rbDkBObO61wySz2l0xLV5uCApWcEXBBBwoNbw7IABT5hTyz74MxyDeY
         XmR0q73RGdhwi7JIbI6Q5P3oRPebIW41EfVq6zk76y0S38jBp+hbjxkSs8RrrqutZBnO
         YOb8LBF8Crslt6NdgQg24rdQpKHV5JuuY2Vo2HeM8hXIGJjHWM4S+CoJ3ed0Hr6Xdjy1
         UqW7igVDTfKDKr/Q426WDSG9jtbn8uC/cSA23v55UNxifS1qF1KoSNYoqsQN1OHPG+bb
         QOp/3F6ZI6NVHQ6CXwlBflTWnUIdpf1D+4M7ms83g5yE/Nr+4LA99woU9ZJhCPlPuw5j
         endw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=paRPrko8zRB+9F5qLyDdKMHPAPOGZyd24aaptDwUJBU=;
        b=PvtiXUUmS4wfCkB4f7NBcSxXs3xeA9V6N28ogzTACBooMcNqsNr6/seba2spxC/g+Z
         wNwohh9vz1FMP0M0/m3Cqjxl8/R3TEWhvdAQGyA6p/Rw+dF0deeJavmL0m8WCg3rNMLv
         ESwujtkOxuG2bhJFcA7k1WIrCGp705WnmgSp1RRNfoGSCUsXJCvSs14dQLz7/1ajvftn
         vDpNZV1BFNeXS+kpTdekQTq3jL0tJCKU1+zgmM5oc/mdgO1ls8o6big/HizYgfHklN7R
         97awRYs50nY7G3Z2UnGJzVZv+Yt/2Bxu+q3/0jdcVZgc5hA3mVSBlMRdyzD1J2MGLkFg
         Df0A==
X-Gm-Message-State: AOPr4FW83oseYUjuWhMBh1Us2xSjyFBY40lMm7xC1qbDb7Cbx59d+KCGfrROTBn7uSJi5cyS3mNqQU0kOw1rWGTo
X-Received: by 10.107.53.204 with SMTP id k73mr7053368ioo.174.1463610705569;
 Wed, 18 May 2016 15:31:45 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 18 May 2016 15:31:45 -0700 (PDT)
In-Reply-To: <xmqq7ferrvvd.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295016>

On Wed, May 18, 2016 at 12:47 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> + - "`+`" the attribute must be set
>> + - "`-`" the attribute must be unset
>> + - "`~`" the attribute must be unspecified

Well the '-' is in line, at least.
So you're proposing empty string for set?

gitattributes documentation:
> Sometimes you would need to override an setting of an attribute for a
> path to Unspecified state. This can be done by listing the name of the
> attribute prefixed with an exclamation point !.

So the unspecified should be '!' to match Git consistency.

[I dislike the exclamation mark because of bash.
    git ls-files ":(attr:!text)"
    bash: !text: event not found
    git ls-files ":(attr:\!text)"
    fatal: attr spec '\!text': attrs must not start with '-' and be
composed of [-A-Za-z0-9_.].
    # we error out because of the \ in there
    git ls-files :\(attr:\!text\)
    ...
    # that actually works.
]

>
> I think using these three, not the way how .gitattributes specify
> them, is highly confusing to the users.

Ok I'll align those.

>
>> + - "`?`" the attribute must not be unspecified, i.e. set, unset or value matches
>
> The choice of '?' is OK, as there is no reason .gitattributes wants
> to say something fuzzy like "this is set or unset or has value".
> The last part "set, unset or value matches" does not make sense,
> though.  Did you mean "set, unset or set to value"?

Actually I meant "this is set or unset or has [any] value".

>
>> + - an empty "`[mode]`" matches if the attribute is set or has a value
>
> The same comment as +/-/~ above applies.

So consistency would ask for

 - an empty "`[mode]`" matches if the attribute is set
 - "`-`" the attribute must be unset
 - "`!`" the attribute must be unspecified
 - an empty "`[mode]`" combined with "`[=value]`" matches if the attribute has
   the given value.

and those are not yet codified, but for discussion then:

 - "`?`" the attribute must not be unspecified, i.e. set, unset or has any value
 - "`+`" the attribute must be set or has any value

>> +
>> +             match_mode = item->attr_match[i].match_mode;
>
> Mental note: there is a one-to-one correspondence between
> attr_check->check[] and attr_match[].

Right. I guess I should add a comment for that. Or better yet a test
with some weird pathspec making use of that

    git ls-files :(attr:labelA !labelB +labelA)

That way we would see if there will be confusion between the modes
and attr names in the future.

>
>> +             if (!matched)
>> +                     return 0;
>
> So this ANDs together.  OK.

Sure, (it's clear to me, maybe I should document that as well),
because multiple pathspecs are OR.

    git ls-files :(attr:labelA) :(attr:labelB)

>
> Mental note after skiming the caller:
>
> The "value" here is like "VAR1=VAL1 VAR2 !VAR3" in a pathspec
> ":(attr:VAR1=VAL1 VAR2 !VAR3)path/to/limit", i.e. the source string
> to be compiled into a list of conditionals that will be evaluated by
> match_attr() in dir.c

Right.

>> +     string_list_split(&list, value, ' ', -1);
>> +     string_list_remove_empty_items(&list, 0);

Right.

>
> At this point, we got "VAR1=VAL1", "VAR2", "!VAR3" as elements in
> this list.

Right.

>
>> +     if (!item->attr_check)
>> +             item->attr_check = git_attr_check_alloc();
>
> Given more than one "attr" magic, e.g. ":(attr:A=a,attr:B)/path",
> the check may not be empty when we process the second one; we just
> extend it without losing the existing contents.

That is why I am not super happy with it though.

    ":(attr:A=a,attr:B)/path",
    ":(attr:A=a B)/path",

are the same for the user as well as in the internal data structures.
This "wastes" the white space as a possible convenient separator
character, e.g. for multiple values. On the other hand it will be easier
to type, specially for many attrs (read submodule groups).

>
>> +     ALLOC_GROW(item->attr_match, item->attr_match_nr + list.nr, item->attr_match_alloc);
>
> Likewise, we extend attr_match[] array.

>> +
>> +             val_len = strcspn(val, "=,)");
>
> I understand "=", but can "," and ")" appear here?

This was overly caution from some intermediate state, where the caller
handed in more than required.

    if (skip_prefix(copyfrom, "attr:", &body)) {
        char *pass = xmemdupz(body, len - strlen("attr:"));
        parse_pathspec_attr_match(item, pass);
        free(pass);
        continue;
    }

When given ":(attr:VAR1=VAL1 VAR2 !VAR3)path/to/limit"
this only passes in "VAR1=VAL1 VAR2 !VAR3".

I contemplated write the caller as

    if (skip_prefix(copyfrom, "attr:", &body)) {
        parse_pathspec_attr_match(item, body);
        continue;
    }

but that would include further characters, i.e. ',' or ')'.
(but not a lot more)

I wanted to pass in an uncounted string though, as
string_list_separate doesn't offer a variant for counted
strings.

>
>> +             if (val[val_len] == '=') {
>> +                     am->match_mode = MATCH_VALUE;
>> +                     am->value = xstrdup(&val[val_len + 1]);
>> +                     /*
>> +                      * NEEDSWORK:
>> +                      * Do we want to allow escaped commas to search
>> +                      * for comma separated values?
>> +                      */
>
> No, we don't ;-).

ok will drop comment, ...

>
>> +                     if (strchr(am->value, '\\'))
>> +                             die(_("attr spec values must not contain backslashes"));
>
> But this is a good escape hatch to reserve for our own use, until we
> decide what the quoting mechanism will be (or if it is necessary).

but keep the code here

>
>> +             } else
>> +                     am->value = NULL;
>> +
>> +             if (invalid_attr_name(val, val_len)) {
>> +                     am->match_mode = INVALID_ATTR;
>> +                     goto err;
>> +             }
>> +
>> +             am->attr = git_attr(xmemdupz(val, val_len));
>> +             git_attr_check_append(item->attr_check, am->attr);
>
> GOOD!

except for the memory leak of xmemdupz. git_attr makes another
internal copy with FLEX_ALLOC_MEM. That ill be fixed once we use
git_attr_counted though.



>
> I think val and val_len should be renamed to attr and attr_len (in
> the VARIABLE=VALUE context, these two identifiers are about parsing
> the variable side, not the value side).

ok

>
>> +     }
>> +
>> +     string_list_clear(&list, 0);
>> +     return;
>> +err:
>> +     die(_("attr spec '%s': attrs must not start with '-' and "
>> +           "be composed of [-A-Za-z0-9_.]."), value);
>
> What is "value" at this point?  If you failed to parse the second
> element in "VAR1=VAL1 FR*TZ=VAL2 !VAR3", I think you would want to
> say "'FR*TZ' is malformed".
>
> Existing users of the function seems to say this:
>
>                 if (invalid_attr_name(cp, len)) {
>                         fprintf(stderr,
>                                 "%.*s is not a valid attribute name: %s:%d\n",
>                                 len, cp, src, lineno);
>                         return NULL;
>                 }
>
> when parsing .gitattribute file.  The source file:line reference
> does not apply to this context, but it would be better to unify the
> message.  I do not mind spelling the rules out explicitly like you
> did, but I do not want to see it spread across many places (which
> forces us to update them when we have to change the rule later).
>
> Perhaps we want a helper function in attr.c side that takes the
> attribute name string (val, val_len in your code above, which I
> suggest to be renamed to attr, attr_len) and formats the error
> message into a strbuf, or something?

That's why you added the reporting function to attrs, I see.

>
> Makes me wonder what "pass" stands for.  From the look of xmemdupz(),
> given ":(attr:VAR1=VAL1 VAR2 !VAR3)path/to/limit" to parse, len
> points at ")" and xmemdupz() gives "VAR1=VAL1 VAR2 !VAR3" to it.

"what we _pass_ to the parse_pathspec_attr_match"... Maybe attr_body?

Thanks,
Stefan
