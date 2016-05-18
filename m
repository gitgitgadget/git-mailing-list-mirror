From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH 03/21] i18n: advice: internationalize message for
 conflicts
Date: Wed, 18 May 2016 21:00:28 +0000
Message-ID: <573CD7EC.9060606@sapo.pt>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
 <1463585274-9027-4-git-send-email-vascomalmeida@sapo.pt>
 <CAPig+cTgQmJG5a8dNjkYcNPG_vEHycyi19sHkO_yO-EfFQzy5A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 18 23:01:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b38ab-0004SN-7E
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 23:01:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754181AbcERVBA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2016 17:01:00 -0400
Received: from relay3.ptmail.sapo.pt ([212.55.154.23]:47583 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753845AbcERVA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 17:00:58 -0400
Received: (qmail 30165 invoked from network); 18 May 2016 21:00:55 -0000
Received: (qmail 17102 invoked from network); 18 May 2016 21:00:55 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth01 (qmail-ptmail-1.0.0) with ESMTPA
          for <avarab@gmail.com>; 18 May 2016 21:00:52 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <CAPig+cTgQmJG5a8dNjkYcNPG_vEHycyi19sHkO_yO-EfFQzy5A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295007>

=C3=80s 19:24 de 18-05-2016, Eric Sunshine escreveu:
> On Wed, May 18, 2016 at 11:27 AM, Vasco Almeida <vascomalmeida@sapo.p=
t> wrote:
>> Mark message for translation telling the user she has conflicts to
>> resolve. Expose each particular use case, in order to enable transla=
ting
>> entire sentences which would facilitate translating into other
>> languages.
>>
>> Change "Pull" to lowercase to match other messages.
>>
>> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
>> ---
>> diff --git a/advice.c b/advice.c
>> @@ -79,7 +79,20 @@ int git_default_advice_config(const char *var, co=
nst char *value)
>>  int error_resolve_conflict(const char *me)
>>  {
>> -       error("%s is not possible because you have unmerged files.",=
 me);
>> +       if (!strcmp(me, "cherry-pick"))
>> +               error(_("cherry-pick is not possible because you hav=
e unmerged files."));
>> +       else if (!strcmp(me, "commit"))
>> +               error(_("commit is not possible because you have unm=
erged files."));
>> +       else if (!strcmp(me, "merge"))
>> +               error(_("merge is not possible because you have unme=
rged files."));
>> +       else if (!strcmp(me, "pull"))
>> +               error(_("pull is not possible because you have unmer=
ged files."));
>> +       else if (!strcmp(me, "revert"))
>> +               error(_("revert is not possible because you have unm=
erged files."));
>> +       else
>> +               error(_("%s is not possible because you have unmerge=
d files."),
>> +                       me);
>=20
> Despite the commit message, I still don't understand this change. 'me=
'
> is a literal git command which shouldn't be translated, so how is thi=
s
> helping?
>=20
I saw it as an operation that could be translated, not necessary a git
command - just happens to be so. Now that you mention, I can see this
patch doesn't had much value from that point of view.

On the other hand, I can translate the sentence, including the command
name. Something I couldn't before and I would likely do it to be
consistent with other translations I've done and also because, as a
user, I would like to read the entire sentence in my language.

I have few experience in i18n and l10n, but often I realize I'm making
assumptions about other languages that are not true. Some translations,
say Chinese or Bulgarian that have their own writing systems, might
translate that command word to something to their writing. Others might
agglutinate the command word with some suffix.
I can't say for sure because I don't know those languages, but it's
possible.

Maybe the first paragraph can give you a better understanding of the is=
sue:
http://www.gnu.org/software/gettext/manual/html_node/Names.html
