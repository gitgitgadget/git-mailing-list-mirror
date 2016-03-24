From: elena petrashen <elena.petrashen@gmail.com>
Subject: Re: [PATCH v2] branch -D: allow - as abbreviation of '@{-1}'
Date: Thu, 24 Mar 2016 16:00:04 +0300
Message-ID: <CAJPOeMdB+3fKa93cbcJRRA6CHg1C4reEZt_sVwv=2qCWfoHATw@mail.gmail.com>
References: <1458635056-26633-1-git-send-email-elena.petrashen@gmail.com> <xmqq1t72jvac.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	Matthieu.Moy@grenoble-inp.fr, sbeller@google.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 24 14:01:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aj4t1-0007Sn-Vb
	for gcvg-git-2@plane.gmane.org; Thu, 24 Mar 2016 14:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757568AbcCXNAt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Mar 2016 09:00:49 -0400
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35106 "EHLO
	mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757547AbcCXNAk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Mar 2016 09:00:40 -0400
Received: by mail-qk0-f195.google.com with SMTP id s5so1969177qkd.2
        for <git@vger.kernel.org>; Thu, 24 Mar 2016 06:00:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=GjKJz/RZ1cySOUlO2qE58O+EQ8ugwjdhmfZe611pHug=;
        b=od/MxPkv25TwA+CAx1qq0hUv/mg92rE/ZRVDdbzbLWYzNVr753lv93Zg6fql/0vdJf
         lG6aOih+Sy0Oto0PLiFY8WhDuCg7ptaCYIwNR4XxDb+8ZzFelSVm2dQ4zUilqh4nFSYS
         vf9+Sgo84DN2HgszDu2TMq0eWwjemMOY7nRBZOXj3iEF/GWX7CKfT8gemtMaYPGFYReY
         biu0rUGQsy0u938DEonjQjjXADkc4KL1AszAVf6MaPb+a8rQEbN9DcX2vMI4zSUPoNjB
         UjncfWgxcxLTvam74uGmeFZBKrgKxExvLj7iaxtba3SE49cq4R0+wDS0NAi88xN8d7ib
         twJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=GjKJz/RZ1cySOUlO2qE58O+EQ8ugwjdhmfZe611pHug=;
        b=ImHV7UMCBgtzA2zFutr5MPBoKh/SpMiGjQreX3mjol2LufopWEwCF0J8WH/TiuFK0C
         DRzPpi754D2H+dm2BMlMRL2Oq7Luk5OEn80EcT4sXOAxx0jXmUo7pFsmsLUfzh9GF+MR
         e9sGZOh9wmAPU9q1DvRyORHttq14rjv2eh5uGH9TAGz51oGmRYuiCLE623PnS2cB/bJ+
         J+lZJmY0VZ2qFNejsUUfeqO1rY6QNVsmoMBiGc8zLJKVRcBUEOAcwZQpz/wktjcRjOGH
         yZCPp8UIPFM++dy4lGjqfoUYWCbzSxA/q+PPKArCchReNR/LLzkjyuGFH8jfWlsLuHjr
         mw4g==
X-Gm-Message-State: AD7BkJIeHSLEFzjupMdVxIa4pgGR+J3PIhZcyOAizFs3GAIZMKf4h5oJw2+r2LA5ZDARWqXixWq7jILXLSYMIQ==
X-Received: by 10.55.73.6 with SMTP id w6mr10174495qka.82.1458824433678; Thu,
 24 Mar 2016 06:00:33 -0700 (PDT)
Received: by 10.233.223.4 with HTTP; Thu, 24 Mar 2016 06:00:04 -0700 (PDT)
In-Reply-To: <xmqq1t72jvac.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289744>

On Tue, Mar 22, 2016 at 8:07 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elena Petrashen <elena.petrashen@gmail.com> writes:
>
>> +static int expand_dash_shortcut(const char **argv, int dash_position)
>> +{
>> +     if (!strcmp(argv[dash_position], "-")){
>> +             argv[dash_position] = "@{-1}";
>> +             return 1;
>> +     }
>> +     return 0;
>> +}
>>       int i;
>>       int ret = 0;
>> +     int dash_shortcut = 0;
>>       int remote_branch = 0;
>>       struct strbuf bname = STRBUF_INIT;
>>
>> @@ -213,7 +223,8 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>>       for (i = 0; i < argc; i++, strbuf_release(&bname)) {
>>               const char *target;
>>               int flags = 0;
>> -
>> +             if (expand_dash_shortcut (argv, i))
>> +                     dash_shortcut = 1;
>>               strbuf_branchname(&bname, argv[i]);
>
> I think this code special cases "-" too much.  Have you considered
> doing this without "dash_shortcut" variable?  With that variable,
> your code says "there is no previous" when the user says "-", but
> isn't that message also appropriate when she says "@{-1}" on the
> command line?  Furthermore, wouldn't the same apply to the case in
> which she said "@{-4}"?
>
> I suspect that you can check that condition immediately after
> calling expand-dash-shortcut and then strbuf-branchname, in other
> words, right here.  And if there is not enough branch switches, you
> can say something like "you gave me @{-4} but you haven't made that
> many branch switches" and continue the loop.
>
> I _think_ strbuf_branchname() leaves "@{-<N>}" when you do not have
> enough branch switches in the reflog, so perhaps
>
>         strbuf_branchname(&bname, (!strcmp(argv[i], "-") ? "@{-1}" : argv[i]));
>         if (starts_with(bname.buf, "@{-")) {
>                 ... say "you do not have enough branch switches" here.
>                 ... when adjusting the message to end-user input,
>                 ... you can look at argv[i] to notice that the original
>                 ... input was "-".
>                 error(...);
>                 continue;
>         }
>
> or something?
>
> That way, there is no change necessary below this line, i.e. from
> here...
>
>>               if (kinds == FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
>>                       error(_("Cannot delete the branch '%s' "
>> @@ -231,9 +242,12 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>>                                           | RESOLVE_REF_ALLOW_BAD_NAME,
>>                                           sha1, &flags);
>>               if (!target) {
>> -                     error(remote_branch
>> -                           ? _("remote-tracking branch '%s' not found.")
>> -                           : _("branch '%s' not found."), bname.buf);
>> +                     error(dash_shortcut
>> +                             ? _("There is no previous branch that could be"
>> +                                     " referred to at the moment.")
>> +                             : remote_branch
>> +                                     ? _("remote-tracking branch '%s' not found.")
>> +                                     : _("branch '%s' not found."), bname.buf);
>>                       ret = 1;
>>                       continue;
>>               }
>> @@ -262,6 +276,10 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>>                              (flags & REF_ISBROKEN) ? "broken"
>>                              : (flags & REF_ISSYMREF) ? target
>>                              : find_unique_abbrev(sha1, DEFAULT_ABBREV));

Right, thank you for the idea and the detailed explanation! I will try
to implement the "not enough switches" message for the v3 version
of the patch the, along with the necessary style corrections that
Matthieu pointed out above.

>
> ... to here.
>
>
>> +                     if (dash_shortcut == 1)
>> +                            printf( _("\nIf that happened by mistake, you may want to restore"
>> +                             " it with:\n\ngit branch %s %s\n"), bname.buf,
>> +                             find_unique_abbrev(sha1, DEFAULT_ABBREV));
>
> This change can be justified only if we believe that people who say
>
>     $ git branch -D -
>
> by mistake are much less clueful than those who say
>
>     $ git branch -D @{-1}
>     $ git branch -D a-misspelled-branch-name
>
> by mistake and need extra help recovering.  Is there an evidence to
> support such an assumption?

I'd think it's a little bit more likely to be the "I thought the
previous branch is "foo" but turns out it's "bar" which I didn't
mean to delete" case for -/@{-1}. case, then just misspelling.
The idea of the warning message was brought up because of
this I think? If we allow deleting via - or even @{-1}, which is
currently possible, it might make sense to additionally enable
the user to recover if she deleted the wrong branch instead of
the required one.

>
> I would actually understand it if this were more like
>
>         if (advice_mistaken_branch_deletion)
>                 printf(_("If you deleted the branch by mistake, you can..."));
>
> so that everybody who ran "git branch -D" on a (wrong) branch by
> mistake can get the extra help.

Would you think this is actually a welcome addition - a (suppressable)
warning for every type of deletion, regardless of whether the shortcuts
are used? There seems to be quite a lot of topics in google where people
are asking how to restore a branch they accidentally deleted. Or that
would be not really consistent with the other situations when people can
delete something (like reset a commit), and they are not immediately
told how can they remedy a situation if that was a mistake?
