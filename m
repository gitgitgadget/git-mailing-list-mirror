From: elena petrashen <elena.petrashen@gmail.com>
Subject: Re: [PATCH v3][Outreachy] branch -D: allow - as abbreviation of @{-1}
Date: Wed, 6 Apr 2016 13:42:29 +0300
Message-ID: <CAJPOeMd9hJpVubRbSTsBGBHtFSi5-LsQOr=h=Gtu+7qZgq_Fbg@mail.gmail.com>
References: <1459416327-795-1-git-send-email-elena.petrashen@gmail.com> <xmqqmvpemot7.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, sunshine@sunshineco.com,
	matthieu.moy@grenoble-inp.fr
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Apr 06 12:43:09 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ankvT-0008Nl-32
	for gcvg-git-2@plane.gmane.org; Wed, 06 Apr 2016 12:43:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754246AbcDFKnA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Apr 2016 06:43:00 -0400
Received: from mail-qg0-f66.google.com ([209.85.192.66]:35917 "EHLO
	mail-qg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752391AbcDFKm7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Apr 2016 06:42:59 -0400
Received: by mail-qg0-f66.google.com with SMTP id f105so3831763qge.3
        for <git@vger.kernel.org>; Wed, 06 Apr 2016 03:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iCM6t1Hc9VZrI12SnJpXXHhDa26jmSPagRVx27HUjGg=;
        b=0G+h9C6GDK+f8KhVuWKAep5jak20wSNI3W+YYQeUKfV1WEHWSfDARUkoZDtOXueSTm
         yGHP3VeXffGSPED/wnYsBRvNLKpx+zqTUU0UWXIUc2TUTMmFhNavgN/D0DxFfGmsydYb
         Nfy6GEkAVlXFAMSxWBbr7aRikE/vXi3hc73H1O7Wtg4LC+uV6QsNSQZtlm2OwSDeQIWd
         JVLeOdwYGVWkxLaDLqyAuOpK82naelPfuibKDgHw8PshztLxbn1OZg2ExuJWdWgTanQv
         hxXpy+fd4bNNHlQI25TUG+HoS6OGvmzi1+mEKe7ZsgxN0rHe+Xh9xtSLjBb7AAHmBbng
         qLyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iCM6t1Hc9VZrI12SnJpXXHhDa26jmSPagRVx27HUjGg=;
        b=jc+2jwWynYGaOgnOaz5L6B744n9DYSYWclj/fAyvMlYxAldDoXDIhlWY3DsnF00/bR
         cHT1MtbYB3cLEbVFUS4Z7jVV7R0O8CW4yOiTKGCfgpFN/yvtMBrmlxDMtC+Ct1OmOZUv
         P4UnAbbhwlNaRGMPpsMzLIQTAvMhleg1tvCAzNLespwqyhkgIv2KhWzwY+seoAJW/dXb
         eiTNNw0HAx5n3GVvYXbv2QTjAa9Pgevr7oY/QJ0kBBG78bH2NahzzahWMCd3ZXwQWYyk
         2EB4sFH+AhZoR2wM5GwKuEsm2K68PfeYqlToyfzho9yQFcbWh3MWDBocSLtUTRndF+P1
         im4A==
X-Gm-Message-State: AD7BkJKlDzECXyTg+RL90muFXv72cWoAjmbvVFYN2f28T6u2qOGnEfi2AsIbJsurKffWykKjudfUiACIzDEx7Q==
X-Received: by 10.140.194.67 with SMTP id p64mr4602768qha.19.1459939378552;
 Wed, 06 Apr 2016 03:42:58 -0700 (PDT)
Received: by 10.233.223.4 with HTTP; Wed, 6 Apr 2016 03:42:29 -0700 (PDT)
In-Reply-To: <xmqqmvpemot7.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290837>

On Thu, Mar 31, 2016 at 10:26 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elena Petrashen <elena.petrashen@gmail.com> writes:
>
>> @@ -214,6 +221,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>>               const char *target;
>>               int flags = 0;
>>
>> +             expand_dash_shortcut (argv, i);
>> +             if(!strncmp(argv[i], "@{-", strlen("@{-")))
>> +                     at_shortcut = 1;
>>               strbuf_branchname(&bname, argv[i]);
>>               if (kinds == FILTER_REFS_BRANCHES && !strcmp(head, bname.buf)) {
>>                       error(_("Cannot delete the branch '%s' "
>> @@ -231,9 +241,12 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>>                                           | RESOLVE_REF_ALLOW_BAD_NAME,
>>                                           sha1, &flags);
>>               if (!target) {
>> -                     error(remote_branch
>> -                           ? _("remote-tracking branch '%s' not found.")
>> -                           : _("branch '%s' not found."), bname.buf);
>> +                     error((!strncmp(bname.buf, "@{-", strlen("@{-")))
>> +                             ? _("There is not enough branch switches to"
>> +                                     " delete '%s'.")
>> +                             : remote_branch
>> +                                     ? _("remote-tracking branch '%s' not found.")
>> +                                     : _("branch '%s' not found."), bname.buf);
>
> I was expecting that the check for "@{-" in bname.buf would be done
> immediately after strbuf_branchname(&bname, argv[i]) we see in the
> previous hunk (and an error message issued there), i.e. something
> like:
>
>         orig_arg = argv[i];
>         if (!strcmp(orig_arg, "-"))
>                 strbuf_branchname(&bname, "@{-1}");
>         else
>                 strbuf_branchname(&bname, argv[i]);
>         if (starts_with(bname.buf, "@{-")) {
>                 error("Not enough branch switches to delete %s", orig_arg);
>                 ... clean up and fail ...
>         }
>
> That would give you sensible error message for "branch -d -",
> "branch -d @{-1}" and "branch -d @{-4}" if you haven't visited
> different branches enough times.
>
> The hope was that the remainder of the code (including this error
> message) would not have to worry about this "not enough switches"
> error at all if done that way.

Thank you, and I apologize it takes me kind of long to figure it all right.
For me the reason I did the realisation the way it is it's to distinguish the
error messages in cases:
1. the branch @{-1} was deleted already
2. the "not enough switches case", there was no previous branch

as far as I understand in #1 we should recieve "branch foo was not found"
in #2 "not enough swiches to delete @{-1}". I believe if we check for "@{-"
immediately, there would be no opportunity to distinguish, and we will be
getting "not enough swithes" even if there was enough switches, it's just
that the branch was deleted?

>
>> @@ -262,6 +275,9 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>>                              (flags & REF_ISBROKEN) ? "broken"
>>                              : (flags & REF_ISSYMREF) ? target
>>                              : find_unique_abbrev(sha1, DEFAULT_ABBREV));
>> +                     if (at_shortcut && advice_delete_branch_via_at_ref)
>> +                            delete_branch_advice (bname.buf,
>> +                             find_unique_abbrev(sha1, DEFAULT_ABBREV));
>>               }
>
> The existing !quiet report already said "deleted branch" with the
> concrete branch name, not "@{-1}" or "-", taken from bname.buf at
> this point.
>
> If the advice on how to recover a deletion by mistake would help the
> user, wouldn't that apply equally to the case where the user made a
> typo in the original command line, i.e. "branch -d foo" when she
> meant to delete "branch -d fooo", as well?  If we drop the "at_shortcut"
> check from this if() statement, wouldn't the result be more helpful?
>
> Thanks

Wouldn't people most of the time have somewhat more different names
than foo/fooo/foooo? Anyways, I guess that should be reasonable. Will just
add advice for every branch deletion next time.

Thank you!
