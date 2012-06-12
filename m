From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git bisect old/new
Date: Mon, 11 Jun 2012 22:43:42 -0700
Message-ID: <7v1ull5bld.fsf@alter.siamese.dyndns.org>
References: <1339466625-17461-1-git-send-email-Valentin.Duperray@ensimag.imag.fr>
 <CAP8UFD1mgKNQRZpuqYgyL__DGpoZ3cOGJC0amoqWT+1Bn_0iTg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Valentin Duperray <Valentin.Duperray@ensimag.imag.fr>,
	git@vger.kernel.org, Lucien Kong <Lucien.Kong@ensimag.imag.fr>,
	Franck Jonas <Franck.Jonas@ensimag.imag.fr>,
	Thomas Nguy <Thomas.Nguy@ensimag.imag.fr>,
	Huynh Khoi Nguyen Nguyen 
	<Huynh-Khoi-Nguyen.Nguyen@ensimag.imag.fr>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 12 07:43:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeJtO-0006QR-7c
	for gcvg-git-2@plane.gmane.org; Tue, 12 Jun 2012 07:43:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514Ab2FLFnq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Jun 2012 01:43:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43544 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751164Ab2FLFnp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2012 01:43:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EF27B54EB;
	Tue, 12 Jun 2012 01:43:44 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=us4nwFx0jEyLdjjGVIChEPzszrM=; b=SCbROQ
	N93ytldf7P1UrZVwdH0mJ21qljg+oSc7j6s0OBKwA5PhXIaOTO14vEJh7y70ZJNl
	bF4S6jzsMHj/dq1Uuw0mfRjsVVEmTGBogolBOAuPtiorYxCd11y/kcZGVkLYh6E/
	eiYcjjbC/0LgEzfx7e/o2M8dHuQkpCB+CLKn8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=W0zzuxeDWW5KGlYhppJCf5BKycWC5dIx
	iSB6j55+It4UnDSm+znl5hYLl3bgjFImBA9XN0FhgdPQNyD2T4dPzpiUlrVYXlFq
	sH7rInHf9hQiA1HIbv6318YI1CxodkagJ/3LxCx3RMgTcRdXtVcpKDmpcR+G8Ngt
	6rBqfuaS40U=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E4B5354EA;
	Tue, 12 Jun 2012 01:43:44 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3538654E9; Tue, 12 Jun 2012
 01:43:44 -0400 (EDT)
In-Reply-To: <CAP8UFD1mgKNQRZpuqYgyL__DGpoZ3cOGJC0amoqWT+1Bn_0iTg@mail.gmail.com>
 (Christian Couder's message of "Tue, 12 Jun 2012 07:25:07 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 92977B08-B451-11E1-95F1-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199764>

Christian Couder <christian.couder@gmail.com> writes:

Thanks for comments.

> If you used some design that was discussed on the mailing list or if
> there have been relevant discussions on the mailing list, it would be
> nice to have links to the email thread in the commit message.

Perhaps.

>> + git bisect new [<rev>]
>> + git bisect old [<rev>...]
>
> maybe:
>
> git bisect (bad|new) [<rev>]
> git bisect (good|old) [<rev>...]

Definitely.

>> @@ -104,6 +106,44 @@ For example, `git bisect reset HEAD` will leave you on the current
>>  bisection commit and avoid switching commits at all, while `git bisect
>>  reset bisect/bad` will check out the first bad revision.
>>
>> +Alternative research: bisect new and bisect old
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +
>> +If you are not looking for a regression but for a change of a given
>> +property, you can use:
>
> I would rather say:
> ...

Good.

>> @@ -403,9 +406,10 @@ struct commit_list *find_bisection(struct commit_list *list,
>>  static int register_ref(const char *refname, const unsigned char *sha1,
>>                        int flags, void *cb_data)
>>  {
>> -       if (!strcmp(refname, "bad")) {
>> +       if (!strcmp(refname, bisect_term_bad)) {
>>                current_bad_sha1 = sha1;
>> -       } else if (!prefixcmp(refname, "good-")) {
>> +       } else if (!prefixcmp(refname, "good-") ||
>> +                       !prefixcmp(refname, "old-")) {
>
> I don't like very much "good" and "old" to be hardcoded here.

Really?

>> @@ -731,18 +735,25 @@ static void handle_bad_merge_base(void)
>>        if (is_expected_rev(current_bad_sha1)) {
>>                char *bad_hex = sha1_to_hex(current_bad_sha1);
>>                char *good_hex = join_sha1_array_hex(&good_revs, ' ');
>> +               if (!strcmp(bisect_term_bad,"bad")) {
>> +                       fprintf(stderr, "The merge base %s is bad.\n"
>> +                               "This means the bug has been fixed "
>> +                               "between %s and [%s].\n",
>> +                               bad_hex, bad_hex, good_hex);
>> +               } else {
>> +                       fprintf(stderr, "The merge base %s is new.\n"
>> +                               "The property has changed "
>> +                               "between %s and [%s].\n",
>> +                               bad_hex, bad_hex, good_hex);
>> +               }
>
> I don't like very much "new" to be harcoded here too.

Why not?  It is not like we will be adding any more synonym pair
beyond good/bad, so... 

>>
>>  /*
>> - * "check_merge_bases" checks that merge bases are not "bad".
>> + * "check_merge_bases" checks that merge bases are not "bad" (resp. "new").
>>  *
>> - * - If one is "bad", it means the user assumed something wrong
>> + * - If one is "bad" (resp. "new"), it means the user assumed something wrong
>>  * and we must exit with a non 0 error code.
>> - * - If one is "good", that's good, we have nothing to do.
>> + * - If one is "good" (resp. "old"), that's good, we have nothing to do.
>>  * - If one is "skipped", we can't know but we should warn.
>>  * - If we don't know, we should check it out and ask the user to test.
>>  */
>
> I am not sure changing the comments is worth it...

I think it is probably a good idea to cast in stone that we support
two pairs, i.e. good/bad or old/new.  I would have said "or" instead
of "resp." above, though.

>> @@ -889,6 +901,30 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
>>  }
>>
>>  /*
>> + * The terms used for this bisect session are stocked in
>> + * BISECT_TERMS: it can be bad/good or new/old.
>
> I am not sure saying "it can be bad/good or new/old" adds anything.

It makes it clear that we are not allowing arbitrary pair of words
to substitute the good/bad pair, which is a plus.

>> +void read_bisect_terms(void)
>> +{
>> +       struct strbuf str = STRBUF_INIT;
>> +       const char *filename = git_path("BISECT_TERMS");
>> +       FILE *fp = fopen(filename, "r");
>> +
>> +       if (!fp)
>> +               die_errno("Could not open file '%s'", filename);
>
> This is not very compatible with older git versions.
> I know that it's kind of strange to upgrade git in the middle of a
> bisection but why not just use "bad"/"good" if there is no file?

Good thinking.

>> @@ -898,6 +934,8 @@ static void show_diff_tree(const char *prefix, struct commit *commit)
>>  */
>>  int bisect_next_all(const char *prefix, int no_checkout)
>>  {
>> +       read_bisect_terms();
>> +
>>        struct rev_info revs;
>>        struct commit_list *tried;
>>        int reaches = 0, all = 0, nr, steps;
>
> We put all declarations at the beginning of functions.

Good eyes.

>> @@ -22,7 +22,15 @@ git bisect replay <logfile>
>>  git bisect log
>>        show bisect log.
>>  git bisect run <cmd>...
>> -       use <cmd>... to automatically bisect.
>> +       use <cmd>... to automatically bisect
>
> Why this change?

To end a sentence with a full-stop?

> But anyway if possible I'd rather have:
>
> git bisect (bad|new) [<rev>]
> git bisect (good|old) [<rev>...]

Yes.

>> @@ -32,6 +40,8 @@ OPTIONS_SPEC=
>>
>>  _x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
>>  _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>> +NEW="bad"
>> +OLD="good"
>
> Why not BISECT_BAD_TERM/BISECT_GOOD_TERM instead of NEW/OLD?
> It should be consistent with bisect.c

It's kind of too long.  Isn't BISECT_GOOD vs BISECT_BAD good enough
(and if so make bisect.c consistent with it).

>> @@ -184,8 +210,8 @@ bisect_write() {
>>        rev="$2"
>>        nolog="$3"
>>        case "$state" in
>> -               bad)            tag="$state" ;;
>> -               good|skip)      tag="$state"-"$rev" ;;
>> +               bad|new)                tag="$state" ;;
>> +               good|skip|old)  tag="$state"-"$rev" ;;
>
> Why not "$BISECT_TERM_BAD" instead of "bad|new" and
> "$BISECT_TERM_GOOD|skip" instead of "good|skip|old"?

If the point is to make sure "git bisect good" will error out when
we are in new/old mode, I agree (and also the other case/esac in the
remainder of the patch that allows you feed bad and new mixed).

These case arms look indented in a funny way, but is it only because
of e-mail quoting, by the way?

>>                *)              die "$(eval_gettext "Bad bisect_write argument: \$state")" ;;
>>        esac
