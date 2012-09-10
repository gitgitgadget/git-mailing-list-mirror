From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 1/4] Add a new function, string_list_split_in_place()
Date: Mon, 10 Sep 2012 06:45:54 +0200
Message-ID: <504D7082.9020903@alum.mit.edu>
References: <1347169990-9279-1-git-send-email-mhagger@alum.mit.edu> <1347169990-9279-2-git-send-email-mhagger@alum.mit.edu> <7voblfsfmd.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 06:46:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TAvsx-0007Zm-05
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 06:46:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577Ab2IJEqB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 00:46:01 -0400
Received: from ALUM-MAILSEC-SCANNER-3.MIT.EDU ([18.7.68.14]:59704 "EHLO
	alum-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751252Ab2IJEqA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Sep 2012 00:46:00 -0400
X-AuditID: 1207440e-b7f036d0000008b5-61-504d70879615
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-3.mit.edu (Symantec Messaging Gateway) with SMTP id AB.FB.02229.7807D405; Mon, 10 Sep 2012 00:45:59 -0400 (EDT)
Received: from [192.168.69.140] (p57A25B0C.dip.t-dialin.net [87.162.91.12])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id q8A4juT8011308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 10 Sep 2012 00:45:57 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120827 Thunderbird/15.0
In-Reply-To: <7voblfsfmd.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprIKsWRmVeSWpSXmKPExsUixO6iqNte4BtgsOoKm0XXlW4mi4beK8wO
	TB4XLyl7fN4kF8AUxW2TlFhSFpyZnqdvl8Cd8fvmcuaCh/EVJ3bsZ2tgfOTdxcjJISFgIvH1
	xS82CFtM4sK99UA2F4eQwGVGibVLnrNAOKeZJJ5ePc4OUsUroC1x69FTIJuDg0VAVeLKhkSQ
	MJuArsSinmYmEFtUIERixuXJzBDlghInZz5hAbFFBNQkJrYdYgFpZRYQl+j/BxYWFvCU2Nay
	EMwWEljKKPHmdRSIzSlgJrHq+V6wkcwCOhLv+h4wQ9jyEtvfzmGewCgwC8mGWUjKZiEpW8DI
	vIpRLjGnNFc3NzEzpzg1Wbc4OTEvL7VI11gvN7NELzWldBMjJEj5djC2r5c5xCjAwajEw9uk
	6xsgxJpYVlyZe4hRkoNJSZR3ejZQiC8pP6UyI7E4I76oNCe1+BCjBAezkggvfzxQjjclsbIq
	tSgfJiXNwaIkzqu2RN1PSCA9sSQ1OzW1ILUIJivDwaEkwfsyD6hRsCg1PbUiLTOnBCHNxMEJ
	MpxLSqQ4NS8ltSixtCQjHhSn8cXASAVJ8QDtlcsH2VtckJgLFIVoPcWoy3H344r7jEIsefl5
	qVLivD9BdgiAFGWU5sGtgKWkV4ziQB8L8z4DqeIBpjO4Sa+AljABLfH18AFZUpKIkJJqYBQy
	MK3szAx9G1Z9bgvDnX/dFuJ7jfKy5u4S1ngp+S2xQGBuz4dHkuqMB2Y7hleH6r1renBxyf/N
	x2awlz66Ehv6xtjhNbuRdmD0/DP/+0T8E5Y84IhTV/5cdql/fqGHGvNz9sh7AvcW 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205108>

On 09/09/2012 11:35 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
> 
>> Split a string into a string_list on a separator character.
>>
>> This is similar to the strbuf_split_*() functions except that it works
>> with the more powerful string_list interface.  If strdup_strings is
>> false, it reuses the memory from the input string (thereby needing no
>> string memory allocations, though of course allocations are still
>> needed for the string_list_items array).
>>
>> Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
>> ---
>>
>> In the tests, I use here documents to specify the expected output.  Is
>> this OK?  (It is certainly convenient.)
> 
> I offhand do not have an objection to that style, but it looked
> funny to see the helper test function "string_list_split_in_place"
> named without "test_" prefix.  Maybe it's just me.

I renamed the test function to "test_split_in_place".  (The
"string_list" part can be dispensed with in a test called
t0063-string-list.sh, I think.)

>> diff --git a/.gitignore b/.gitignore
>> index bb5c91e..0ca7df8 100644
>> --- a/.gitignore
>> +++ b/.gitignore
>> @@ -193,6 +193,7 @@
>>  /test-run-command
>>  /test-sha1
>>  /test-sigchain
>> +/test-string-list
>>  /test-subprocess
>>  /test-svn-fe
>>  /common-cmds.h
>> diff --git a/Documentation/technical/api-string-list.txt b/Documentation/technical/api-string-list.txt
>> index 5a0c14f..3b959a2 100644
>> --- a/Documentation/technical/api-string-list.txt
>> +++ b/Documentation/technical/api-string-list.txt
>> @@ -124,6 +124,18 @@ counterpart for sorted lists, which performs a binary search.
>>  	is set. The third parameter controls if the `util` pointer of the
>>  	items should be freed or not.
>>  
>> +`string_list_split_in_place`::
>> +
>> +	Split string into substrings on character delim and append the
>> +	substrings to a string_list.  The delimiter characters in
>> +	string are overwritten with NULs in the process.  If maxsplit
>> +	is a positive integer, then split at most maxsplit times.  If
> 
> So passing 0 is the natural way to say "pay attention to all the
> delimiters", which matches my intuition.

See below.

>> +	list.strdup_strings is not set, then the new string_list_items
>> +	point into string, which therefore must not be modified or
>> +	freed while the string_list is in use.  Return the number of
>> +	substrings appended to the list.
> 
> I am not sure about this strdup_strings business; it smells somewhat
> fishy from the API design point of view.
> 
> If you are not mucking with the input string and not splitting in
> place, it would not be possible to do this without strdup_strings,
> but if you are doing the in-place splitting, is there any reason for
> the caller to ask for strdup_strings?
>
> In such a case, the reason the caller cannot promise that the input
> string will not go away to the string_list (hence it has to ask to
> make a copy) is because it does not own the string in the first
> place, and in such a case, I would imagine it cannot allow the
> delimiters in the string to be overwritten with NULs.

On one level it is immaterial whether this is a sensible usage; the
caller *can* set strdup_strings on any string_list and pass that
string_list into the function.  In that case the function *has* to
strdup the strings because when strdup_strings is set, the string_list
functions are allowed to free() a string whenever they want.

But there are situations when this usage is also convenient; namely when
the lifetime of the string being split is shorter than the lifetime of
the string_list.  Consider something like

    struct string_list *split_file_into_words(FILE *f)
    {
        char buf[1024];
        struct string_list *list = new string list;
        list->strdup_strings = 1;
        while (not EOF) {
            read_line_into_buf();
            string_list_split_in_place(list, buf, ' ', -1);
        }
        return list;
    }

Consider also that the string_list passed to
string_list_split_in_place() might already have contents from elsewhere.
 Since a string_list has a single allocation policy covering all of its
entries, it might be more convenient for the caller to allow the split
strings to be copied than to change the allocation policy of the
pre-inserted strings.

> I would sort-of-kind-of understand a function "string_list_split"
> that bases its decision to do an in-place splitting or not on the
> strdup_strings flag in the string list that was passed in.  But it
> would make the use of the function a bit limited (e.g. you cannot
> sanely mix and match tokens from different kind of strings).

Here is my thinking:

I want to have a very low overhead way to use string_list, without a
memory allocation per string (so that people don't have an excuse to
avoid the API).  Thus the "in-place" option.

It would be easy (and have no run-time cost) to change the split
function to *not* modify the input string if strdup_strings is set on
the string_list.  But (1) I don't think it is a good idea for the
handling of the string argument to depend on an option buried in another
parameters, and (2) the string argument could not be declared "const",
so many situations when this variant were useful would require const to
be cast away.

So if/when such a need arises, I think it would be better to invent a
new string_list_split() variant that *never* overwrites its input string
(though this function could *only* work correctly if strdup_strings is set).

>> diff --git a/string-list.c b/string-list.c
>> index d9810ab..110449c 100644
>> --- a/string-list.c
>> +++ b/string-list.c
>> @@ -194,3 +194,26 @@ void unsorted_string_list_delete_item(struct string_list *list, int i, int free_
>>  	list->items[i] = list->items[list->nr-1];
>>  	list->nr--;
>>  }
>> +
>> +int string_list_split_in_place(struct string_list *list, char *string,
>> +			       int delim, int maxsplit)
>> +{
>> +	int count = 0;
>> +	char *p = string, *end;
> 
> Blank line here.

Thanks.

>> +	for (;;) {
>> +		count++;
>> +		if (maxsplit > 0 && count > maxsplit) {
>> +			string_list_append(list, p);
>> +			return count;
>> +		}
>> +		end = strchr(p, delim);
>> +		if (end) {
>> +			*end = '\0';
>> +			string_list_append(list, p);
>> +			p = end + 1;
>> +		} else {
>> +			string_list_append(list, p);
>> +			return count;
>> +		}
>> +	}
>> +}
>> diff --git a/string-list.h b/string-list.h
>> index 0684cb7..7e51d03 100644
>> --- a/string-list.h
>> +++ b/string-list.h
>> @@ -45,4 +45,23 @@ int unsorted_string_list_has_string(struct string_list *list, const char *string
>>  struct string_list_item *unsorted_string_list_lookup(struct string_list *list,
>>  						     const char *string);
>>  void unsorted_string_list_delete_item(struct string_list *list, int i, int free_util);
>> +
>> +/*
>> + * Split string into substrings on character delim and append the
>> + * substrings to list.  The delimiter characters in string are
>> + * overwritten with NULs in the process.  If maxsplit is a positive
>> + * integer, then split at most maxsplit times.  If list.strdup_strings
>> + * is not set, then the new string_list_items point into string, which
>> + * therefore must not be modified or freed while the string_list
>> + * is in use.  Return the number of substrings appended to list.
>> + *
>> + * Examples:
>> + *   string_list_split_in_place(l, "foo:bar:baz", ':', -1) -> ["foo", "bar", "baz"]
>> + *   string_list_split_in_place(l, "foo:bar:baz", ':', 1) -> ["foo", "bar:baz"]
>> + *   string_list_split_in_place(l, "foo:bar:", ':', -1) -> ["foo", "bar", ""]
> 
> I would find it more natural to see a sentinel value against
> "positive" to be 0, not -1.  "-1" gives an impression as if "-2"
> might do something different from "-1", but Zero is a lot more
> special.

You have raised a good point and I think there is a flaw in the API, but
I'm not sure I agree with you what the flaw is...

The "maxsplit" argument limits the number of times the string should be
split.  I.e., if maxsplit is set, then the output will have at most
(maxsplit + 1) strings.

When I used "-1" as the special value for "unlimited", I was
subconsciously thinking that "0" is an imaginable edge case; it could
mean "don't split string at all"; i.e., return the whole input as the
single string in the output string_list.  This would be a kindof silly
usage, but might perhaps remove the need to handle 0 specially at a
caller if "maxsplit" is derived from another source.

But of course my definition of string_list_split_in_place() *doesn't*
treat 0 this way.  I think *that* was my mistake.  So I propose to
change the meaning of maxsplit to

    If maxsplit is a non-negative integer, then split at most maxsplit
    times.

and to continue using -1 as the "special" value for unlimited splits.
Are you OK with that?

>> diff --git a/t/t0063-string-list.sh b/t/t0063-string-list.sh
>> new file mode 100755
>> index 0000000..0eede83
>> --- /dev/null
>> +++ b/t/t0063-string-list.sh
>> @@ -0,0 +1,63 @@
>> +#!/bin/sh
>> +#
>> +# Copyright (c) 2012 Michael Haggerty
>> +#
>> +
>> +test_description='Test string list functionality'
>> +
>> +. ./test-lib.sh
>> +
>> +string_list_split_in_place() {
> 
> SP before ()?

Thanks.

>> +	cat >split-expected &&
>> +	test_expect_success "split $1 $2 $3" "
> 
> "split '$1' at '$2', max $3", or something?

Good idea.

>> +		test-string-list split_in_place '$1' '$2' '$3' >split-actual &&
>> +		test_cmp split-expected split-actual
>> +	"
>> +}
> 
> What is it buying us to use "split-" before expected and actual to
> make things "unusual" from many other tests?

Nothing, I guess.  Changed.

>> +string_list_split_in_place "foo:bar:baz" ":" "-1" <<EOF
> 
> Likewise about "-1" (I think your test helper does not even require
> "-1" to be spelled out here).

Since we're testing the C API I think it's best that the tests be
explicit about the value to be passed to the function.

Therefore I guess I will change the test program to *require* the
maxsplit option, since testing is its only purpose.

>> +3
>> +[0]: "foo"
>> +[1]: "bar"
>> +[2]: "baz"
>> +EOF
>> +
>> +string_list_split_in_place "foo:bar:baz" ":" "0" <<EOF
>> +3
>> +[0]: "foo"
>> +[1]: "bar"
>> +[2]: "baz"
>> +EOF
>> +
>> +string_list_split_in_place "foo:bar:baz" ":" "1" <<EOF
>> +2
>> +[0]: "foo"
>> +[1]: "bar:baz"
>> +EOF
>> +
>> +string_list_split_in_place "foo:bar:baz" ":" "2" <<EOF
>> +3
>> +[0]: "foo"
>> +[1]: "bar"
>> +[2]: "baz"
>> +EOF
>> +
>> +string_list_split_in_place "foo:bar:" ":" "-1" <<EOF
>> +3
>> +[0]: "foo"
>> +[1]: "bar"
>> +[2]: ""
>> +EOF
>> +
>> +string_list_split_in_place "" ":" "-1" <<EOF
>> +1
>> +[0]: ""
>> +EOF
>> +
>> +string_list_split_in_place ":" ":" "-1" <<EOF
>> +2
>> +[0]: ""
>> +[1]: ""
>> +EOF
>> +
>> +test_done
>> diff --git a/test-string-list.c b/test-string-list.c
>> new file mode 100644
>> index 0000000..f08d3cc
>> --- /dev/null
>> +++ b/test-string-list.c
>> @@ -0,0 +1,25 @@
>> +#include "cache.h"
>> +#include "string-list.h"
>> +
>> +int main(int argc, char **argv)
>> +{
>> +	if ((argc == 4 || argc == 5) && !strcmp(argv[1], "split_in_place")) {
>> +		struct string_list list = STRING_LIST_INIT_NODUP;
>> +		int i;
>> +		char *s = xstrdup(argv[2]);
>> +		int delim = *argv[3];
>> +		int maxsplit = (argc == 5) ? atoi(argv[4]) : -1;
> 
> Likewise on "-1".
> 
>> +		i = string_list_split_in_place(&list, s, delim, maxsplit);
>> +		printf("%d\n", i);
>> +		for (i = 0; i < list.nr; i++)
>> +			printf("[%d]: \"%s\"\n", i, list.items[i].string);
>> +		string_list_clear(&list, 0);
>> +		free(s);
>> +		return 0;
>> +	}
>> +
>> +	fprintf(stderr, "%s: unknown function name: %s\n", argv[0],
>> +		argv[1] ? argv[1] : "(there was none)");
>> +	return 1;
>> +}

Thanks for your helpful feedback!  I will send a revised patch series as
soon as I can.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
