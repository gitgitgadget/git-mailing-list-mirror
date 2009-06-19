From: Giuseppe Bilotta <giuseppe.bilotta@gmail.com>
Subject: Re: [PATCHv2] gitweb: gravatar support
Date: Sat, 20 Jun 2009 00:43:46 +0200
Message-ID: <cb7bb73a0906191543l75722b35xa1af532f4d8e1b76@mail.gmail.com>
References: <1245435670-5688-1-git-send-email-giuseppe.bilotta@gmail.com>
	 <7v63esklxh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 00:45:08 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MHmpY-0000r4-3d
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 00:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752698AbZFSWnq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Jun 2009 18:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752609AbZFSWnq
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Jun 2009 18:43:46 -0400
Received: from mail-bw0-f213.google.com ([209.85.218.213]:42655 "EHLO
	mail-bw0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104AbZFSWnp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Jun 2009 18:43:45 -0400
Received: by bwz9 with SMTP id 9so2040575bwz.37
        for <git@vger.kernel.org>; Fri, 19 Jun 2009 15:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8fIpb5wJZDKQ/5jPzozUCaJlE8gJbDyeBfqBfr1bnIg=;
        b=NZbFVfY5XmjA80D7FooewbGt6OUf4+r8bT+TusEG5OQawUZPKxammpCENmWaKoEn5J
         ZDzvv/a2I9BmcNoyoIvSdwZHww+dgUSAzr4TbGqPoGcu+gR8+hyGpGTOQarRZ9QiXBAf
         VmEOpFyxXkPj+4MlgIy7XQfN0SYKsYCXH+Rlk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=CroMTuebXwFqrArgf1Vk0FC4qVjIypWnUZhTlS2/nnKTF5hY51BL+PSC2tKSdkbKX1
         864dSxwewc7Gol0cFWfZfkZaSw+TUzNncZTjN9YJc1+XVTTf9DtuX4dmXTwsz336gShr
         lYIp/0gUuTza83HijqVj+v6OUZEvhCWJhWHL4=
Received: by 10.204.115.139 with SMTP id i11mr3012865bkq.199.1245451426494; 
	Fri, 19 Jun 2009 15:43:46 -0700 (PDT)
In-Reply-To: <7v63esklxh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121919>

On Fri, Jun 19, 2009 at 10:28 PM, Junio C Hamano<gitster@pobox.com> wro=
te:
>
> I see these repeated patterns in your patch.
>
>> @@ -4145,7 +4179,7 @@ sub git_shortlog_body {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 my $author =3D chop_and_escape_str($co{'=
author_name'}, 10);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 # git_summary() used print "<td><i>$co{'=
age_string'}</i></td>\n" .
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 print "<td title=3D\"$co{'age_string_age=
'}\"><i>$co{'age_string_date'}</i></td>\n" .
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<td><i>" . $author . "</i></t=
d>\n" .
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<td>" . git_get_gravatar($co{=
'author_email'}, 16, 1) . "<i>" . $author . "</i></td>\n" .
>>...
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<td><i>" . $author . "</i></t=
d>\n" .
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<td>" . git_get_gravatar($co{=
'author_email'}, 16, 1) . "<i>" . $author . "</i></td>\n" .
>>...
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<td><i>" . $author . "</i></t=
d>\n" .
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<td>" . git_get_gravatar($co{=
'author_email'}, 16, 1) . "<i>" . $author . "</i></td>\n" .
>>...
>> - =A0 =A0 print "<tr><td>author</td><td>" . esc_html($co{'author'}) =
=2E "</td></tr>\n".
>> + =A0 =A0 print "<tr><td>author</td><td>" . esc_html($co{'author'}) =
=2E "</td>".
>> + =A0 =A0 =A0 =A0 =A0 "<td rowspan=3D\"2\">" .git_get_gravatar($co{'=
author_email'}) . "</td></tr>\n" .
>>...
>> - =A0 =A0 print "<tr><td>committer</td><td>" . esc_html($co{'committ=
er'}) . "</td></tr>\n";
>> + =A0 =A0 print "<tr><td>committer</td><td>" . esc_html($co{'committ=
er'}) . "</td>".
>> + =A0 =A0 =A0 =A0 =A0 "<td rowspan=3D\"2\">" .git_get_gravatar($co{'=
committer_email'}) . "</td></tr>\n";
>>...
>
> Doesn't it strike you as needing a bit more refactoring?

I was having the same thoughts while writing v2 of the patch, indeed.
However, I wasn't sure if it was appropriate to the refactoring in the
same patch. A couple of places could be changed to use the existing
git_print_authorship, others would need their own function, as you
point out.

> By the way, in the above example, I named the field 'smallicon', as u=
se of
> gravatar is merely an implementation detail. =A0It is plausible other=
 people
> may want to use picons instead.

I had to google for picons but yes, it makes sense.

> I do not know about the following hunk (why does it have the icon at =
the
> end, unlike the other ones?), but I think you got the idea.
>
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<i>" . esc_html($co{'author_n=
ame'}) . =A0" [$ad{'rfc2822'}]</i><br/>\n" .
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "</div>\n";
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<i>" . esc_html($co{'author_n=
ame'}) . =A0" [$ad{'rfc2822'}]</i>&nbsp;" .
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 git_get_gravatar($co{'author_e=
mail'}, 16) .
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "<br/>\n</div>\n";

I had the impression that in this case it made more aesthetical sense
to have the icon on the other side. I'm not exactly a good designer
though, so we might want to prefer consistency and keep it all the
same way. This section would probably use git_print_authorship or at
least share some code with that.

--=20
Giuseppe "Oblomov" Bilotta
