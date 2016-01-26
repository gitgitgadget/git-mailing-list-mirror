From: Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 13/15] ref-filter: introduce remote_ref_atom_parser()
Date: Tue, 26 Jan 2016 15:32:25 +0530
Message-ID: <CAOLa=ZQNqia7j8bESD47xAQVW3_7dX6Qw8swwLL3WtesN5BEBg@mail.gmail.com>
References: <1451980994-26865-1-git-send-email-Karthik.188@gmail.com>
 <1451980994-26865-14-git-send-email-Karthik.188@gmail.com> <CAPig+cTLxhrh3d0ouGLGq+ke8mzFKqCz0ABAECSA4vS+=epv9Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 11:03:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aO0Sl-0005ig-Id
	for gcvg-git-2@plane.gmane.org; Tue, 26 Jan 2016 11:03:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964959AbcAZKC7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Jan 2016 05:02:59 -0500
Received: from mail-vk0-f41.google.com ([209.85.213.41]:35441 "EHLO
	mail-vk0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964917AbcAZKCz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Jan 2016 05:02:55 -0500
Received: by mail-vk0-f41.google.com with SMTP id k1so88703001vkb.2
        for <git@vger.kernel.org>; Tue, 26 Jan 2016 02:02:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=URExlzw3MkFoyTBXdUXfejsVWJrGGi6BR+GtFmzMy0o=;
        b=FtUrQ1YK81SuPoELcuU/b6xTZsCWKdyoZ3eQUKpj5JlO/Csdvx2hx1nhtheLtLxIFu
         N67A1aDvwjUT+DwNUCCNcCyKWH0yi6px0VN/Tw/YmGv/XiyEc7t9aBdcgisEzD68s3gm
         VittcJrEyrXlltGbiciettNK0N0kV377I/Ugg/MZ5/VRPISoFB2Eb2p/+hVMs6k3oUxL
         I/SFR9x/wSk2mz2Au/Saa+O0jRfGn/YxnEPzFIopZEF2cLDLjIIArAQ3Ilh4PJjz5ruZ
         0wIBHookxy/9wzsPg5GoEO9/gP5Tj9+YIpdgk30e81fU11SpfLzOq1St40PuNPNDnjv5
         BGIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=URExlzw3MkFoyTBXdUXfejsVWJrGGi6BR+GtFmzMy0o=;
        b=E+lKcpx/r/cVIvknbgKWKUvqmzg6OVbzzWHOjqOFHkMX+OXAMGuTrghGVVRJX3S9YS
         dSt24RG375MKKu+TyisOUk+BFixpO7j1rhIxDSuhZI0f9FYaXwVorlYAt8oIa/pYC6Hu
         vsC1JY+TFCvDa5qCEQ+gDBCenOzhqiPnM2D8+Wv1TVh9oQbIGbNbH9xD0IQ/9Z2IqsM+
         83gfW5naUg2rW9EFYOrDD/hGDu7Jd2mk83q7jXiS3j59qOC0yFB7cd/aV79Fy1xhy4YR
         7sRBsyGPDO++YdK1IFYfpcYq0uSuQhmHlfm8+Iw+/ucII8Zw2f+8OAK+R7AY9Ne4SUzV
         KzjQ==
X-Gm-Message-State: AG10YOSLLu0dK9JLYmxluHI2XMutWEmyAZSlVfX+2WzbW+oy2nF1+rU7ycrFi8dCmgV/BjRRFMctxMFV3iKAWA==
X-Received: by 10.31.149.3 with SMTP id x3mr13913748vkd.46.1453802574777; Tue,
 26 Jan 2016 02:02:54 -0800 (PST)
Received: by 10.103.82.146 with HTTP; Tue, 26 Jan 2016 02:02:25 -0800 (PST)
In-Reply-To: <CAPig+cTLxhrh3d0ouGLGq+ke8mzFKqCz0ABAECSA4vS+=epv9Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284801>

On Tue, Jan 26, 2016 at 5:58 AM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On Tue, Jan 5, 2016 at 3:03 AM, Karthik Nayak <karthik.188@gmail.com> wrote:
>> Introduce remote_ref_atom_parser() which will parse the '%(upstream)'
>> and '%(push)' atoms and store information into the 'used_atom'
>> structure based on the modifiers used along with the corresponding
>> atom.
>>
>> Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
>> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
>> Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
>> ---
>> diff --git a/ref-filter.c b/ref-filter.c
>> @@ -841,6 +863,43 @@ static inline char *copy_advance(char *dst, const char *src)
>> +static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
>> +                                   struct branch *branch, const char **s)
>> +{
>> +       int num_ours, num_theirs;
>> +       if (atom->u.remote_ref == RR_SHORTEN)
>> +               *s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
>> +       else if (atom->u.remote_ref == RR_TRACK) {
>> +               if (stat_tracking_info(branch, &num_ours,
>> +                                      &num_theirs, NULL))
>> +                       return;
>> +
>> +               if (!num_ours && !num_theirs)
>> +                       *s = "";
>> +               else if (!num_ours)
>> +                       *s = xstrfmt("[behind %d]", num_theirs);
>> +               else if (!num_theirs)
>> +                       *s = xstrfmt("[ahead %d]", num_ours);
>> +               else
>> +                       *s = xstrfmt("[ahead %d, behind %d]",
>> +                                    num_ours, num_theirs);
>> +       } else if (atom->u.remote_ref == RR_TRACKSHORT) {
>> +               if (stat_tracking_info(branch, &num_ours,
>> +                                      &num_theirs, NULL))
>> +                       return;
>> +
>> +               if (!num_ours && !num_theirs)
>> +                       *s = "=";
>> +               else if (!num_ours)
>> +                       *s = "<";
>> +               else if (!num_theirs)
>> +                       *s = ">";
>> +               else
>> +                       *s = "<>";
>> +       } else if (atom->u.remote_ref == RR_NORMAL)
>> +               *s = refname;
>
> I think I mentioned this in a previous review: If the code falls past
> this final 'else if' for some reason (programmer error), then *s won't
> get assigned at all, which is probably undesirable. To protect against
> such a case, you might want either to add a final 'else':
>
>     else
>         die("BUG: ...");
>
> or just consider RR_NORMAL the catchall case, and turn the final 'else
> if' into a plain 'else':
>
>     else /* RR_NORMAL */
>         *s = refname;
>

The latter seems to make sense, will implement.

>> +}
>> @@ -894,6 +953,8 @@ static void populate_value(struct ref_array_item *ref)
>>                         refname = branch_get_upstream(branch, NULL);
>>                         if (!refname)
>>                                 continue;
>> +                       fill_remote_ref_details(atom, refname, branch, &v->s);
>> +                       continue;
>
> There are now two 'continue' statements very close together here. Have
> you considered this instead?
>
>     if (refname)
>         fill_remote_ref_details(...);
>     continue;
>
> It might make the code a bit more straightforward. (Genuine question;
> I don't feel too strongly about it.)

No, I didn't consider that, and I think it's a good change to implement.
Thanks. ( I don't see any problems with it)

>
>>                 } else if (starts_with(name, "push")) {
>>                         const char *branch_name;
>>                         if (!skip_prefix(ref->refname, "refs/heads/",
>> @@ -904,6 +965,8 @@ static void populate_value(struct ref_array_item *ref)
>>                         refname = branch_get_push(branch, NULL);
>>                         if (!refname)
>>                                 continue;
>> +                       fill_remote_ref_details(atom, refname, branch, &v->s);
>> +                       continue;
>
> Ditto.

Noted.

-- 
Regards,
Karthik Nayak
