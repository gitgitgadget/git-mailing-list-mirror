From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 09/12] pretty: add %C(auto) for auto-coloring on the
 next placeholder
Date: Fri, 5 Apr 2013 13:21:42 +1100
Message-ID: <CACsJy8C0wb92QOhh=e27Cqd=e5yJYnQWYkYi4uPd+vPXGqVbdQ@mail.gmail.com>
References: <1363400683-14813-1-git-send-email-pclouds@gmail.com>
 <1364636112-15065-1-git-send-email-pclouds@gmail.com> <1364636112-15065-10-git-send-email-pclouds@gmail.com>
 <7vzjxihztj.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 05 04:22:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNwId-0006ad-H3
	for gcvg-git-2@plane.gmane.org; Fri, 05 Apr 2013 04:22:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423Ab3DECWN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Apr 2013 22:22:13 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:61222 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932414Ab3DECWN convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 4 Apr 2013 22:22:13 -0400
Received: by mail-ob0-f174.google.com with SMTP id wm15so666789obc.33
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 19:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=iqeSBNbJ/s4Ss2hSXZBcjW0Px+ycKkzx0bV+bwuYxDY=;
        b=PgJr3ST7m+zYtqjnpSY9WNEqEijHcIYXd4XVQO6zswz/uJO+UkkBEoEiSCUmXKAaJ6
         gCLD5MzW1Tb1H/msG0OOnnbvosrwJzXTyDHlC0hsH+rUb9rCCr3MX6ukTwI2lk0/IUoz
         KLgxAtmAvEHm4DmmZHUSI/G9nMVIrETKHz0izmt+C22Xk0YzRwJcfTjLuObOG/MZ18Vd
         obdEptk+gsLh3AAfP5C5kBPR1Fc7CNYtFSpnxO46wGcEphMTqWAo2tMJJLD5AHRwxYnL
         KIddgFlGfx7KUdw4rhOYh0ruEx+RZKPVXit3dmZ32CP2lr3EMOH4aUnTK10fTOFdLKlA
         OiXQ==
X-Received: by 10.182.19.168 with SMTP id g8mr6639774obe.21.1365128532621;
 Thu, 04 Apr 2013 19:22:12 -0700 (PDT)
Received: by 10.76.27.137 with HTTP; Thu, 4 Apr 2013 19:21:42 -0700 (PDT)
In-Reply-To: <7vzjxihztj.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220132>

On Tue, Apr 2, 2013 at 5:26 AM, Junio C Hamano <gitster@pobox.com> wrot=
e:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> This is not simply convenient over %C(auto,xxx). Some placeholders
>> (actually only one, %d) do multi coloring and we can't emit a multip=
le
>> colors with %C(auto,xxx).
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  Documentation/pretty-formats.txt |  3 ++-
>>  pretty.c                         | 15 +++++++++++++--
>>  2 files changed, 15 insertions(+), 3 deletions(-)
>>
>> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty=
-formats.txt
>> index 66345d1..8734224 100644
>> --- a/Documentation/pretty-formats.txt
>> +++ b/Documentation/pretty-formats.txt
>> @@ -154,7 +154,8 @@ The placeholders are:
>>    adding `auto,` at the beginning will emit color only when colors =
are
>>    enabled for log output (by `color.diff`, `color.ui`, or `--color`=
, and
>>    respecting the `auto` settings of the former if we are going to a
>> -  terminal)
>> +  terminal). `auto` alone (i.e. `%C(auto)`) will turn on auto color=
ing
>> +  on the following placeholder.
>>  - '%m': left, right or boundary mark
>>  - '%n': newline
>>  - '%%': a raw '%'
>
> I like this at the conceptual level.
>
> If you say "%C(auto)%C(red)Text%C(auto)%C(reset)", does it do the
> right thing when the output is not capable of color?

The above should have written "will turn on auto coloring on the
following _textual_ placeholder". I didn't intend %C(auto) to be
followed by %C(color) as it's already covered by %C(auto,red). But of
course we could make it work too.

> I am a bit worried if the placement of the "grab c->auto_color to
> decide if we paint for this round and reset it" is optimial and will
> stay optimal as we enhance format_commit_one() later.  Is there a
> reason why we do not do that at the beginning of the function,
> before "these are independent of the commit" comment?

No reason. Will move.

> Side note.  Should the new field called "auto_color_next" or
> something?

Yep, sounds better than my variable name.
--
Duy
