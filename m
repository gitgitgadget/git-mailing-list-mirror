From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v4 11/12] ref-filter: introduce contents_atom_parser()
Date: Sun, 7 Feb 2016 10:28:11 +0530
Message-ID: <CAOLa=ZQksDyyiukDZVZFX6113nOr=V_yCaBswtm5xDrLe5vrig@mail.gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
 <1454262176-6594-12-git-send-email-Karthik.188@gmail.com> <CAPig+cQ+jsAdJSB6J_P8h+zDbiGpr4JGv=Vj1vEMSLdHERi0pw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Feb 07 05:59:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aSHRS-0000UP-UZ
	for gcvg-git-2@plane.gmane.org; Sun, 07 Feb 2016 05:59:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753211AbcBGE6n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 6 Feb 2016 23:58:43 -0500
Received: from mail-vk0-f65.google.com ([209.85.213.65]:34502 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752199AbcBGE6l (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Feb 2016 23:58:41 -0500
Received: by mail-vk0-f65.google.com with SMTP id e6so3646337vkh.1
        for <git@vger.kernel.org>; Sat, 06 Feb 2016 20:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Eba6pZ5bBi7E42kHnX8T7dCNmiBZELWysDxhzQ1xQuM=;
        b=k94bMuJ2b+U0iCwmbfqIHgUlYuwTPCDYlGURunChOoV8wGRe5gAJsL5onp2o70WbIJ
         jtcFbj1QcZzv74XTShgMOnUZQqZbTmA+0P7szr1qRY0MKjaWVTk/KvzlEcv5joe/pwJI
         7w4Bij0tHCUbFHesHx8TMMCsRnpN/VBnqKm3GJkdCwxr0YeEYxXpt3h2hzCQgtod8AGx
         1KghSsJKq4Ah3NbmEhZJIhxY63DOs/BLzGjbxQhaTxDOBWlTMisgZQqKXkJFInr2TT81
         hEiWb9qcbeI15Dy7G2NwLqw81meJeIb1x+Mo9mR6BY7hMS8jNLd5Yz7kyCp1UnKh7TMC
         OX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=Eba6pZ5bBi7E42kHnX8T7dCNmiBZELWysDxhzQ1xQuM=;
        b=TTciGYxWYZhCX2QO5dNdzggr+agn5AjQDwfgChsUKo+mKk2uoVlzQjBKrCGNnV0qYP
         LpQP6XKrBzCcJcIGVIct8WTDyntdyPffx1lpc07ABH4kXaNlrViHVIlBE0kvY/273Fu/
         A8pHuCyxsSFYj0fP6UZaIcwZlkhjDZY3Jfus0dw5D4C4bWOLu8PjBVGz9aCehTua+hrx
         Tvu3F75AEB8UKbLHENanwG3xRe/BOFbUU5Qw20gmqaF+fsyb0On1/nsI5yMQ62IgveF5
         gbBo5DlhlFmltYWr8FAodS/xmdlq6RAUB6cx7ltBX/0EjLjvERKod48ZOhJyNfLtKSkG
         NmdA==
X-Gm-Message-State: AG10YOQb2gN+OhbH9a4+JEetxQRGj/NtCrgePA1kNU/1VEcQbt27YvOPQtF5ILR3wbiAz00JfCN45eiskJJ3gQ==
X-Received: by 10.31.16.218 with SMTP id 87mr14187982vkq.106.1454821121130;
 Sat, 06 Feb 2016 20:58:41 -0800 (PST)
Received: by 10.103.82.133 with HTTP; Sat, 6 Feb 2016 20:58:11 -0800 (PST)
In-Reply-To: <CAPig+cQ+jsAdJSB6J_P8h+zDbiGpr4JGv=Vj1vEMSLdHERi0pw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285712>

On Fri, Feb 5, 2016 at 5:52 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Sun, Jan 31, 2016 at 12:42 PM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce contents_atom_parser() which will parse the '%(contents)'
>> atom and store information into the 'used_atom' structure based on the
>> modifiers used along with the atom. Also introduce body_atom_parser()
>> and subject_atom_parser() for parsing atoms '%(body)' and '%(subject)'
>> respectively.
>
> These latter two parsers are conceptually distinct from introduction
> of the %(contents) parser, thus could be done in a follow-on patch or
> two (though I don't care strongly enough to insist upon it).
>

I think they go together, considering they use the same contents structure in
used_atom, Introducing separate patches would leave us in a grey area where
%(contents:...) uses used_atom->contents whereas body and subject don't.
So I'd prefer them being together.

>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -66,6 +70,38 @@ static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
>> +static void body_atom_parser(struct used_atom *atom, const char *arg)
>> +{
>> +       if (arg)
>> +               die("%%(body) atom does not take arguments");
>
> None of the other error messages bothers saying "atom" literally
> following a %(foo). For consistency, this likely should say merely:
>
>     %(body) does not take arguments
>

Will change.

>> +       atom->u.contents.option = C_BODY_DEP;
>> +}
>> +
>> +static void subject_atom_parser(struct used_atom *atom, const char *arg)
>> +{
>> +       if (arg)
>> +               die("%%(subject) atom does not take arguments");
>
> Ditto.
>

Will change.

>> +       atom->u.contents.option = C_SUB;
>> +}
>> @@ -733,19 +763,15 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
>>
>>         for (i = 0; i < used_atom_cnt; i++) {
>>                 const char *name = used_atom[i].name;
>> +               struct used_atom *atom = &used_atom[i];
>
> Not a big deal, but if you re-order these two lines, then the second,
> which extracts name, could do so from the variable declared by the
> first:
>
>     struct used_atom *atom = &used_atom[i];
>     const char *name = atom->name;
>

Seems good, will incorporate.

>>                 struct atom_value *v = &val[i];
>> -               const char *valp = NULL;
>>                 if (!!deref != (*name == '*'))
>>                         continue;
>>                 if (deref)
>>                         name++;
>>                 if (strcmp(name, "subject") &&
>>                     strcmp(name, "body") &&
>> -                   strcmp(name, "contents") &&
>> -                   strcmp(name, "contents:subject") &&
>> -                   strcmp(name, "contents:body") &&
>> -                   strcmp(name, "contents:signature") &&
>> -                   !starts_with(name, "contents:lines="))
>> +                   !starts_with(name, "contents"))
>>                         continue;
>
> This changes behavior in that it will also now match
> "contentsanything", whereas the original was much more strict. Is that
> desirable? (Genuine question.)
>

Well, we wont have something like that come through because
parse_ref_filter_atom()
would throw an error for %(contentsanything), but if in the future
sometime if we
introduce an atom %(contentsfoo) this might end up being a problem.

-- 
Regards,
Karthik Nayak
