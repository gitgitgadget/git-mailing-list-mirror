From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 01/15] string_list: add string_list_duplicate
Date: Wed, 27 Apr 2016 11:02:29 -0700
Message-ID: <CAGZ79kbWMN3YG5Jtz8i8Y9A3id8bX-YxSWp19+yGAdzMX_wKKA@mail.gmail.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-2-git-send-email-sbeller@google.com>
	<xmqqh9eoc7zc.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 20:02:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avTnH-00089Z-8V
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 20:02:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752956AbcD0SCb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 14:02:31 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:37569 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752579AbcD0SCa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 14:02:30 -0400
Received: by mail-ig0-f179.google.com with SMTP id s8so279778ign.0
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 11:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=dTKd8zA3dzldoZhLrE2y4OhfLa2cCpBNL7SW4bxZtZo=;
        b=X1EaZH1KleB9Yj5q+69nymEdpnVAM4THnUbPaeicP7BHw7wIu/Hs7GfLcOzeSOuzk0
         I7GauYhESrEeN0GIMJrqp4TEckndawInLMPpSg7zLrNgCJRtmxvj5S7OABezRxVKDA0Q
         zsNRYEncoY69+zT0sv2Gci5qvUJZXFoxdndhPuZ6Aip19z9RhhU29sNzQh8fhd/l55pz
         LIfbwjZDDVdSA40Lc/oaJ308bLk8DBVDuU9f9HNbqGrKw6KgK46fuVlbST0hnFuTIWjf
         5j6Ii8ROSmwqis2YDIjXX5oKTKKyxitvE2+kf7diBfo3yGeBebxM9YYTFVhSFQyeuzbS
         rTCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=dTKd8zA3dzldoZhLrE2y4OhfLa2cCpBNL7SW4bxZtZo=;
        b=aFbRNeJKcp1Ab0CZTmCF7sTn6zWSDjGnM+M7+//UVpGw5MOWRHt5m3usY05+Ilc1lB
         EnXY3p5uaKNmmUwksO0QMGco5xnln4cMzwN0g2cAzrctWkTEm/C+AzNzAtBtuX28sEEN
         EGpdY02yeN1ofQyRHcWSTwgJwyxNY5NLCO4aQPQ1QuHm/FTdjbhOdfXHUDMj9gv01U/A
         H3byQdDw8VGpxO+JqxdwWQjZYXKM4hTDIPZ55duGSwNK+vjhUFUEFmT5tN2iwC4PrKcD
         A3oLpCDQWucbuAFHpg2MJkR+Svbr7dT22KVN8pEBqv49jeUeM9qni6BivTsVmGR2BVyg
         TNyg==
X-Gm-Message-State: AOPr4FWVFpj1jPSVBwuYu2JqfujCDR5FuNe9Ui+J2g4QYuHCzhmJGCzKx4A5nMY2HcB1GOjrUJDooSX9UQEYxkqv
X-Received: by 10.50.102.207 with SMTP id fq15mr23403237igb.94.1461780149211;
 Wed, 27 Apr 2016 11:02:29 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Wed, 27 Apr 2016 11:02:29 -0700 (PDT)
In-Reply-To: <xmqqh9eoc7zc.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292778>

On Tue, Apr 26, 2016 at 3:37 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> The result of git_config_get_value_multi do not seem to be stable and
>> may get overwritten. Have an easy way to preserve the results of that
>> query.
>>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> This morning I reviewed a patch that adds something whose name ends
> with _copy(), and this may want to follow suit.

ok, in case we need this patch, I'll rename.

>
> Should strdup_strings() be a separate parameter, or should it follow
> what src->strdup_strings has?
>
> "Do not seem to be stable" does not build confidence in the code,
> making it sound as if the developer is basing his work on guess not
> analysis, and makes it hard to tell if this is a wrong workaround to
> a valid issue (e.g. it could be "making the result stable" is what
> we want in the longer term) or a valid solution to a problem that
> would be common across callers of that API.

When not duplicating git_config_get_value_multi("submodule.defaultGroup");
I run into

Program received signal SIGSEGV, Segmentation fault.
0x0000000000579097 in get_entry_index (list=0x876848, string=0x8721e0
"./submodule1", exact_match=0x7fffffffd6bc) at string-list.c:38
38 int compare = cmp(string, list->items[middle].string);
(gdb) bt
#0  0x0000000000579097 in get_entry_index (list=0x876848,
string=0x8721e0 "./submodule1", exact_match=0x7fffffffd6bc) at
string-list.c:38
#1  0x00000000005792d5 in string_list_has_string (list=0x876848,
string=0x8721e0 "./submodule1") at string-list.c:91
#2  0x000000000057e78c in submodule_in_group (group=0x876848,
sub=0x878510) at submodule-config.c:558
#3  0x0000000000497cf9 in module_init (argc=0, argv=0x7fffffffdb28,
prefix=0x0) at builtin/submodule--helper.c:441
#4  0x00000000004993f6 in cmd_submodule__helper (argc=2,
argv=0x7fffffffdb20, prefix=0x0) at builtin/submodule--helper.c:927
#5  0x000000000040582e in run_builtin (p=0x83c0c0 <commands+2400>,
argc=2, argv=0x7fffffffdb20) at git.c:353
#6  0x0000000000405a1d in handle_builtin (argc=2, argv=0x7fffffffdb20)
at git.c:540
#7  0x0000000000405b3f in run_argv (argcp=0x7fffffffd9fc,
argv=0x7fffffffda10) at git.c:594
#8  0x0000000000405d32 in main (argc=2, av=0x7fffffffdb18) at git.c:701
(gdb) print list->items[middle].string
Cannot access memory at address 0x746c006fd40bd151

So the string list seems to be corrupted here.
Someone stomping over our memory? How long is the result
of git_config_get_value_multi deemed to be stable and usable?

I did not find out myself how to properly answer these.
So it was symptom based programming (copying that stuff makes the
error go away).

This only happens in one code path, which is
        group = NULL;
        if (!pathspec.nr)
                group = //string_list_duplicate(
                        (struct string_list*)

git_config_get_value_multi("submodule.defaultGroup");//, 1);
        if (group) {
                gitmodules_config();
                for (i = 0; i < list.nr; i++) {
                        const struct submodule *sub =
                                submodule_from_path(null_sha1,
                                                    list.entries[i]->name);
                        if (submodule_in_group(group, sub))
                                init_submodule(list.entries[i]->name,
prefix, quiet);
                }
        }
        ... // group is not further used

Maybe gitmodules_config needs to be called before git_config_get_value_multi,
as it changes that?

I dunno, will debug more later.

Thanks,
Stefan




>
>>  string-list.c | 18 ++++++++++++++++++
>>  string-list.h |  2 ++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/string-list.c b/string-list.c
>> index 2a32a3f..f981c8a 100644
>> --- a/string-list.c
>> +++ b/string-list.c
>> @@ -7,6 +7,24 @@ void string_list_init(struct string_list *list, int strdup_strings)
>>       list->strdup_strings = strdup_strings;
>>  }
>>
>> +struct string_list *string_list_duplicate(const struct string_list *src,
>> +                                       int strdup_strings)
>> +{
>> +     struct string_list *list;
>> +     struct string_list_item *item;
>> +
>> +     if (!src)
>> +             return NULL;
>> +
>> +     list = xmalloc(sizeof(*list));
>> +     string_list_init(list, strdup_strings);
>> +     for_each_string_list_item(item, src)
>> +             string_list_append(list, item->string);
>> +
>> +     return list;
>> +}
>> +
>> +
>>  /* if there is no exact match, point to the index where the entry could be
>>   * inserted */
>>  static int get_entry_index(const struct string_list *list, const char *string,
>> diff --git a/string-list.h b/string-list.h
>> index d3809a1..1a5612f 100644
>> --- a/string-list.h
>> +++ b/string-list.h
>> @@ -19,6 +19,8 @@ struct string_list {
>>  #define STRING_LIST_INIT_DUP   { NULL, 0, 0, 1, NULL }
>>
>>  void string_list_init(struct string_list *list, int strdup_strings);
>> +struct string_list *string_list_duplicate(const struct string_list *src,
>> +                                       int strdup_strings);
>>
>>  void print_string_list(const struct string_list *p, const char *text);
>>  void string_list_clear(struct string_list *list, int free_util);
