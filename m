From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 4/4] pathspec: record labels
Date: Thu, 12 May 2016 22:41:13 -0700
Message-ID: <CAGZ79kbaqw9UvYrCWcLtAXaiw5-aSev9gn858zz5Ju0MVfzepQ@mail.gmail.com>
References: <20160513001936.7623-1-sbeller@google.com>
	<20160513001936.7623-5-sbeller@google.com>
	<xmqqy47ea5ql.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 13 07:41:20 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b15qh-0005BD-Ji
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 07:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751565AbcEMFlP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 May 2016 01:41:15 -0400
Received: from mail-io0-f181.google.com ([209.85.223.181]:32851 "EHLO
	mail-io0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751073AbcEMFlO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 May 2016 01:41:14 -0400
Received: by mail-io0-f181.google.com with SMTP id f89so120258047ioi.0
        for <git@vger.kernel.org>; Thu, 12 May 2016 22:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc;
        bh=HqdHr/xtFfhW+H5Ttvz9q6sASIvqIbTVemfO9+YkaLk=;
        b=EY2BRN7A29M9VDoqJsbeV1vsx7/4BYwVI/X7+YKJF+qIH0q5o+cOHKlx7L3c79YjaH
         242XyNcJzbutYUQGvYz7LtVdpjBoopbiIFlbQzdldpRMCN7AHKaObzAWyJCUUUBmSC6t
         8OqCDgEZVYbot+S6LvJrKZ0MNKkecnTaTU6P9Hon9dixUFXRlvPVPhgnSi+X4MJ4xXVi
         Y/LRX6ELXV7JqGLoFs1kq12hlOYJ9DTbg2pqG0b/ZiQGxKiX+hc808xOYKSvGHXP8FIT
         IvOwKsF89OuwnIIjUAHir9o8WY4PgniwgDehAiX6miWM/sRMyMa6qhP7kqOUPavYN1l4
         NDRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=HqdHr/xtFfhW+H5Ttvz9q6sASIvqIbTVemfO9+YkaLk=;
        b=BtOViz17tWEToJwGIs37QIS3IVpvCC7e2Qm4ELQ0q+6w2L8t/2RB+CYBwUIzZMmam2
         lSJ/ctGNPoAEeIdMLhfkGcElCAfgmNNcplssEB9rJquE/r9Wgu/B4rfURiTjcqfbwIKW
         6U6crtM+M3ljOZJ+o7tpYOL/4eOqSrKOJKQKWS0gY6qaFdShN2kIKwfXU3eQ3C8lL2a2
         2aOzPQ7J18GKaWfhTxXCvn1s8sp/B3fcURwL+s2fb9OYYf/uJc+n0NN/CC8IVCC/3B6N
         PDMy0VQnayapmg7InrXg8K1Zstw16CR4d/EK/02LXKEAwevUPWhf6FG/ZkhOnHNZ6cfn
         1g1g==
X-Gm-Message-State: AOPr4FVeEenFNVUeOX42ThBMd8YyQFEPr78GTYAboWCqg0XLylAQRVeDs/DazAS6s/hUUnu18tRd79Q06ciE3JgA
X-Received: by 10.107.161.68 with SMTP id k65mr11699817ioe.110.1463118073517;
 Thu, 12 May 2016 22:41:13 -0700 (PDT)
Received: by 10.107.2.3 with HTTP; Thu, 12 May 2016 22:41:13 -0700 (PDT)
In-Reply-To: <xmqqy47ea5ql.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294504>

On Thu, May 12, 2016 at 10:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> +
>> +label:<white space separated list>;;
>> +     Labels can be assigned to pathspecs in the .gitattributes file.
>> +     By specifying a list of labels the pattern will match only
>> +     files which have all of the listed labels.
>>  +
>
> Attributes are given to paths, not pathspecs.  You specify which paths
> the entry applies to by matching the pattern (which is at the beginning
> of the line) against each path, and take the matching entries.
>
> In any case, what the first sentence tries to explain applies to
> each and every attribute .gitattributes file can define, and
> explaining it should be better left for the first sentence in the
> DESCRIPTION section.
>
> As to the second sentence, I would say "When specifying the paths to
> work on to various Git commands, the :(label=<label>,...)  magic
> pathspec can be used to select paths that have all the labels given
> by the 'label' attribute.", or something like that, to clarify where
> that "specifying" and "match" happens (they do not happen here, but
> happen when using magic pathspec).

Reminder for myself: add a test for

    ":(label=a) :(exclude,label=b)"

>
>> +void load_labels(const char *name, int namelen, struct string_list *list)
>
> This must be file scope static, no?

Yes. It seems like I forget these statics often. :(

>
>> +{
>> +     static struct git_attr *attr;
>> +     struct git_attr_check check;
>> +     char *path = xmemdupz(name, namelen);
>> +
>> +     if (!attr)
>> +             attr = git_attr("label");
>> +     check.attr = attr;
>> +
>> +     if (git_check_attr(path, 1, &check))
>> +             die("git_check_attr died");
>> +
>> +     if (ATTR_CUSTOM(check.value)) {
>> +             string_list_split(list, check.value, ',', -1);
>> +             string_list_sort(list);
>> +     }
>> +
>> +     free(path);
>> +}
>
> I am wondering where we should sanity check (and die, pointing out
> an error in .gitattributes file).  Is this function a good place to
> reject TRUE and FALSE?

Would it make sense to mark a file as

    "follows the labeling system, but has no label" (TRUE)
    "doesn't follow the labeling system at all" (FALSE)

This may be a useful addition later on to say

    "I want to talk only about labeled files, but not label 'a'"

I would think.


>
> By the way, ATTR_CUSTOM() is probably a bad name.  gitattributes.txt
> calls them Set, Unset, Set to a value and Unspecified, and this is
> trying to single out "Set to a value" case.  ATTR_STRING() may be
> more appropriate.

Ok.

>
>> @@ -263,6 +285,15 @@ static int match_pathspec_item(const struct pathspec_item *item, int prefix,
>>           strncmp(item->match, name - prefix, item->prefix))
>>               return 0;
>>
>> +     if (item->group) {
>> +             struct string_list has_labels = STRING_LIST_INIT_DUP;
>> +             struct string_list_item *si;
>> +             load_labels(name, namelen, &has_labels);
>> +             for_each_string_list_item(si, item->group)
>> +                     if (!string_list_has_string(&has_labels, si->string))
>> +                             return 0;
>> +     }
>> +
>
> Is this the right place, before we even check if the prefix already
> covered everything?
>
> We are looking at one element in the pathspec here.  If that element
> is known to be a "group", and the path has all the required labels,
> is it correct to fall through?
>
>     Ahh, you are making ":(label=...)makefile" to say "paths must
>     match the string 'makefile' in some way, and further the paths
>     must have all these labels?  Then falling through is correct.

This is how I understood your initial design idea.

    :(label=C_code)contrib/

gives all the retired C programs.

>     The placement before the "prefix covered" looks still a bit
>     strange, but understandable.
>
> Is this code leaking has_labels every time it is called?

It does.

>
> By the way, we should pick one between label and group and stick to
> it, no?  Perhaps call the new field "item->label"?

will do.

>
>>       /* If the match was just the prefix, we matched */
>>       if (!*match)
>>               return MATCHED_RECURSIVELY;
>> diff --git a/pathspec.c b/pathspec.c
>> index 4dff252..c227c25 100644
>> --- a/pathspec.c
>> +++ b/pathspec.c
>> @@ -94,6 +94,7 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
>>  {
>>       int i;
>>       const char *copyfrom = *copyfrom_;
>> +     const char *out;
>
> It probably is meant as "output", but it looks more like the "body" or
> the "contents" of the named magic to me.

ok.

>
>>       /* longhand */
>>       const char *nextat;
>>       for (copyfrom = elt + 2;
>> @@ -117,6 +118,20 @@ static void eat_long_magic(struct pathspec_item *item, const char *elt,
>>                       continue;
>>               }
>>
>> +             if (skip_prefix(copyfrom, "label:", &out)) {
>
> This is good, but can you fix the "prefix:" one we see a few lines
> above, too, using this to lose "copyfrom + 7" there?

I can do that. Though I did not want to clutter this patch with it.

I wonder that you focus on the details already, but not on the grand
design of things. "Is it actually a sane thing I am proposing here?"
Though you may be biased as the the high level idea came from
you. :)

One of the things I switched last minute and tried to address in the
cover letter is the semantics of ORing or ANDing the labels given
within one pathspec item.

Thanks,
Stefan
