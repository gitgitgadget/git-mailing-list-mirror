From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv8 5/5] pathspec: allow querying for attributes
Date: Thu, 19 May 2016 13:42:19 -0700
Message-ID: <CAGZ79kaZ=0XdHEkocP-LpHT2+ybHd44KCbfONzYj77UTEPb0FA@mail.gmail.com>
References: <20160519010935.27856-1-sbeller@google.com> <20160519010935.27856-6-sbeller@google.com>
 <xmqqmvnlj2vf.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 22:42:32 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b3Um3-0008Aa-5v
	for gcvg-git-2@plane.gmane.org; Thu, 19 May 2016 22:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754805AbcESUmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2016 16:42:22 -0400
Received: from mail-ig0-f180.google.com ([209.85.213.180]:35240 "EHLO
	mail-ig0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754750AbcESUmV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2016 16:42:21 -0400
Received: by mail-ig0-f180.google.com with SMTP id bi2so123939742igb.0
        for <git@vger.kernel.org>; Thu, 19 May 2016 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=A1rqRXf3B7Es4ySRcap9qedP1UahmQT33wR265hJ3Sw=;
        b=RkNTBKESR0Z5Zc7ENYR1kaZOUlCRTIeJec8LGK7DG29Efgb8l4M3vfJgZdJJ34rLfI
         W/U9OnY33fTkg35/q48LJxyQR73kZq9zVAPdz4u66eZF/DxToR1rrdMycWwz+tbS2Kgk
         F8cKG03pA1ahb7oUm0998xQwJAZUdsbdWKoLwbsDNJvfJofIylv6oFrTTq7IXuaJ4P/U
         H2UzQfD0qB5ZvmzsiDMTLiLAtXUvgtngKC6ehJLClU+ZuOckn0DAkYw69/xB3IrpSQIs
         81CojJ4m2M8EeboLyQYQ0rn8sESEaAZVYpj+Kc2fEoWJdF70cbHVSea9mTVK+Jq2uFke
         IXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=A1rqRXf3B7Es4ySRcap9qedP1UahmQT33wR265hJ3Sw=;
        b=RBgSg2ZfPqV4B/Gc0jqoG93rscQ8DYBiyqpOS11IcGq8ufbMeoP2Ti60YRNkqQpJ8z
         mWPohqp2E9lQ2tcKKmk8GYgVVsVX2yGdaU+ZRRDkdYa45yEDEpvl3EifXXaEpsG97z2L
         dwSGk2Ppzizz7Jz7jNAvTML0dvoGaFLxNdgCziTQ5xK/kSuMbRgaMyHyC4qYy2acXu94
         LILvxQ+VXK8N7i1S//JKZF8XiE8uVQI0k0dfkbx90r/iKzYD8KCZByvrAfjBxsq4957f
         GFrrtQNH3M6/vDuNk4gbuxcWVJpgxAwaQX0VNLtOE/gK/IetvAAwC6PCb/Ok6ucGZ6zx
         3gNQ==
X-Gm-Message-State: AOPr4FV0Mwx+/VVyjbwJVW0SXcFIuO4CCTUUrS/pYKm6cKZqEVMxwK47ki86EfimHEDb3ZaalPPwLKJI55VaDzKu
X-Received: by 10.50.29.45 with SMTP id g13mr4623623igh.93.1463690540311; Thu,
 19 May 2016 13:42:20 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 19 May 2016 13:42:19 -0700 (PDT)
In-Reply-To: <xmqqmvnlj2vf.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295099>

On Thu, May 19, 2016 at 11:53 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> diff --git a/Documentation/glossary-content.txt b/Documentation/glossary-content.txt
>> index cafc284..aa9f220 100644
>> --- a/Documentation/glossary-content.txt
>> +++ b/Documentation/glossary-content.txt
>> @@ -384,6 +384,23 @@ full pathname may have special meaning:
>>  +
>>  Glob magic is incompatible with literal magic.
>>
>> +attr;;
>> +     Additionally to matching the pathspec, the path must have the
>> +     attribute as specified. The syntax for specifying the required
>> +     attributes is "`attr: [mode] <attribute name> [=value]`"
>> ++
>> +Attributes can have 4 states (Set, Unset, Set to a value, unspecified) and
>> +you can query each attribute for certain states. The "`[mode]`" is a special
>> +character to indicate which attribute states are looked for. The following
>> +modes are available:
>> +
>> + - an empty "`[mode]`" matches if the attribute is set
>> + - "`-`" the attribute must be unset
>> + - "`!`" the attribute must be unspecified
>> + - an empty "`[mode]`" combined with "`[=value]`" matches if the attribute has
>> +   the given value.
>> ++
>
> As an initial design, I find this much more agreeable than the
> previous rounds.  I however find the phrasing of the above harder
> than necessary to understand, for a few reasons.
>
>  * Mixed use of "X matches if ..." and "... must be Y" makes it
>    unclear if they are talking about different kind of things, or
>    the same kind of things in merely different ways.
>
>  * It does not make it clear "=value" is only meaningful when [mode]
>    is empty.
>
> Perhaps dropping the '[mode]' thing altogether and instead saying
>
>         After `attr:` comes a space separated list of "attribute
>         requirements", all of which must be met in order for the
>         path to be considered a match; this is in addition to the
>         usual non-magic pathspec pattern matching.
>
>         Each of the attribute requirements for the path takes one of
>         these forms:
>
>         - "`ATTR`" requires that the attribute `ATTR` must be set.
>
>         - "`-ATTR`" requires that the attribute `ATTR` must be unset.
>
>         - "`ATTR=VALUE`" requires that the attribute `ATTR` must be
>           set to the string `VALUE`.
>
>         - "`!ATTR`" requires that the attribute `ATTR` must be
>           unspecified.
>
> would make the resulting text easier to read?

That is way better!

>
>> +static int match_attrs(const char *name, int namelen,
>> +                    const struct pathspec_item *item)
>> +{
>> +     int i;
>> +
>> +     git_check_attr_counted(name, namelen, item->attr_check);
>> +     for (i = 0; i < item->attr_match_nr; i++) {
>> +             const char *value;
>> +             int matched;
>> +             enum attr_match_mode match_mode;
>> +
>> +             value = item->attr_check->check[i].value;
>> +             match_mode = item->attr_match[i].match_mode;
>> +
>> +             if (ATTR_TRUE(value))
>> +                     matched = match_mode == MATCH_SET;
>> +             else if (ATTR_FALSE(value))
>> +                     matched = match_mode == MATCH_UNSET;
>> +             else if (ATTR_UNSET(value))
>> +                     matched = match_mode == MATCH_UNSPECIFIED;
>
> readability nit:
>
>         matched = (match_mode == MATCH_WHATEVER);
>
> would be easier to view

ok.

>
>> +             else
>> +                     matched = (match_mode == MATCH_VALUE &&
>> +                                !strcmp(item->attr_match[i].value, value));
>
> and would match the last case above better.
>
>> +static void parse_pathspec_attr_match(struct pathspec_item *item, const char *value)
>> +{
>> +     struct string_list_item *si;
>> +     struct string_list list = STRING_LIST_INIT_DUP;
>> +
>> +
>> +     if (!value || !strlen(value))
>> +             die(_("attr spec must not be empty"));
>> +
>> +     string_list_split(&list, value, ' ', -1);
>> +     string_list_remove_empty_items(&list, 0);
>> +
>> +     if (!item->attr_check)
>> +             item->attr_check = git_attr_check_alloc();
>> +     else
>> +             die(_("Only one 'attr:' specification is allowed."));
>> +
>> +     ALLOC_GROW(item->attr_match, item->attr_match_nr + list.nr, item->attr_match_alloc);
>> +
>> +     for_each_string_list_item(si, &list) {
>> +             size_t attr_len;
>> +
>> +             int j = item->attr_match_nr++;
>> +             const char *attr = si->string;
>> +             struct attr_match *am = &item->attr_match[j];
>> +
>> +             if (attr[0] == '!')
>> +                     am->match_mode = MATCH_UNSPECIFIED;
>> +             else if (attr[0] == '-')
>> +                     am->match_mode = MATCH_UNSET;
>> +             else
>> +                     am->match_mode = MATCH_SET;
>> +
>> +             if (am->match_mode != MATCH_SET)
>> +                     /* skip first character */
>> +                     attr++;
>> +             attr_len = strcspn(attr, "=");
>> +             if (attr[attr_len] == '=') {
>> +                     am->match_mode = MATCH_VALUE;
>> +                     am->value = xstrdup(&attr[attr_len + 1]);
>> +                     if (strchr(am->value, '\\'))
>> +                             die(_("attr spec values must not contain backslashes"));
>> +             } else
>> +                     am->value = NULL;
>> +
>
> Let me try a variant to see if we can improve it (thinking aloud).
>
>         switch (*attr) {
>         case '!':
>                 am->match_mode = MATCH_UNSPECIFIED;
>                 attr++;
>                 break;
>         case '-':
>                 am->match_mode = MATCH_UNSET;
>                 attr++;
>                 break;
>         default:
>                 attr_len = strcspn(attr, "=");
>                 if (attr[attr_len] != '=')
>                         am->match_mode = MATCH_SET;
>                 else {
>                         am->match_mode = MATCH_VALUE;
>                         am->value = xstrdup(...);
>                 }
>                 break;
>         }
>
> Using switch/case does not save line counts at all but it may still
> make the result easier to follow.  More importantly, it would help
> you catch "!ATTR=VAR" as an "invalid attribute name 'ATTR=VAR' was
> requested" error by arranging the code to make sure that scanning
> for '=' would not happen in !/- case (in other words, while thiking
> aloud with an alternative way to write the same thing, I spotted a
> bug in the original ;-).

That makes sense.

>
>> +             if (!attr_name_valid(attr, attr_len)) {
>> +                     struct strbuf sb = STRBUF_INIT;
>> +                     am->match_mode = INVALID_ATTR;
>> +                     invalid_attr_name_message(&sb, attr, attr_len);
>> +                     die(_("invalid attribute in '%s': '%s'"), value, sb.buf);
>> +             }
>> +
>> +             am->attr = git_attr_counted(attr, attr_len);
>
> I'd do this the other order, i.e.
>
>         am->attr = git_attr_counted(...);
>         if (!am->attr) {
>                 ...
>                 die(...);
>         }
>
> It is wasteful to call attr_name_valid() yourself before seeing an
> error from git_attr_counted().
>
>> diff --git a/t/t6134-pathspec-with-labels.sh b/t/t6134-pathspec-with-labels.sh
>> new file mode 100755
>> index 0000000..c0d8cda
>> --- /dev/null
>> +++ b/t/t6134-pathspec-with-labels.sh
>> @@ -0,0 +1,166 @@
>> +#!/bin/sh
>> +
>> +test_description='test labels in pathspecs'
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'setup a tree' '
>> +     mkdir sub &&
>> +     for p in fileA fileB fileC fileAB fileAC fileBC fileNoLabel fileUnsetLabel fileSetLabel fileValue fileWrongLabel; do
>> +             : >$p &&
>> +             git add $p &&
>> +             : >sub/$p
>> +             git add sub/$p
>> +     done &&
>> +     git commit -m $p &&
>> +     git ls-files >actual &&
>> +     cat <<EOF >expect &&
>> +fileA
>> +fileAB
>> +fileAC
>> +fileB
>> +fileBC
>> +fileC
>> +fileNoLabel
>> +fileSetLabel
>> +fileUnsetLabel
>> +fileValue
>> +fileWrongLabel
>> +sub/fileA
>> +sub/fileAB
>> +sub/fileAC
>> +sub/fileB
>> +sub/fileBC
>> +sub/fileC
>> +sub/fileNoLabel
>> +sub/fileSetLabel
>> +sub/fileUnsetLabel
>> +sub/fileValue
>> +sub/fileWrongLabel
>> +EOF
>
>         cat <<-\EOF >expect &&
>         fileA
>         ...
>         EOF
>
> to indent the whole thing?

$ grep -r "cat" |grep "<<-"|wc -l
915
$ grep -r "cat" |grep "<<"|grep -v "<<-"| wc -l
1329

I was undecided what the prevailing style is, some did indent,
others did not.

Ok, will indent.

>> +sq="'"
>
> I do not think you use this $sq variable below, but I may have
> overlooked its use.
>

ok

>> +     git ls-files :\(attr:\!label\) >actual &&
>
> Why not the more normal-looking ":(attr:!label)"?  I do not think
> history substitution would trigger in an script.
>
> And no, "I may cut and paste into my interactive shell while
> debugging" is not a good reason to make the end-result (i.e. script)
> less readable.

ok
