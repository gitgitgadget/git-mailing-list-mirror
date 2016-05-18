From: Vasco Almeida <vascomalmeida@sapo.pt>
Subject: Re: [PATCH 05/21] i18n: sequencer: mark entire sentences for
 translation
Date: Wed, 18 May 2016 21:02:07 +0000
Message-ID: <573CD84F.7000207@sapo.pt>
References: <1463585274-9027-1-git-send-email-vascomalmeida@sapo.pt>
 <1463585274-9027-6-git-send-email-vascomalmeida@sapo.pt>
 <CAPig+cQzsxMMv1XSdStFDs08C3qvb_Ttb4oVeN3T1si85v=f7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>,
	Jiang Xin <worldhello.net@gmail.com>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Wed May 18 23:02:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b38bg-0005Ba-B2
	for gcvg-git-2@plane.gmane.org; Wed, 18 May 2016 23:02:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932089AbcERVCM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 18 May 2016 17:02:12 -0400
Received: from relay4.ptmail.sapo.pt ([212.55.154.24]:51142 "EHLO sapo.pt"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753845AbcERVCL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 May 2016 17:02:11 -0400
Received: (qmail 11036 invoked from network); 18 May 2016 21:02:09 -0000
Received: (qmail 21615 invoked from network); 18 May 2016 21:02:08 -0000
Received: from unknown (HELO [192.168.1.66]) (vascomalmeida@sapo.pt@[85.246.157.91])
          (envelope-sender <vascomalmeida@sapo.pt>)
          by mta-auth02 (qmail-ptmail-1.0.0) with ESMTPA
          for <avarab@gmail.com>; 18 May 2016 21:02:08 -0000
X-PTMail-RemoteIP: 85.246.157.91
X-PTMail-AllowedSender-Action: 
X-PTMail-Service: default
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.7.0
In-Reply-To: <CAPig+cQzsxMMv1XSdStFDs08C3qvb_Ttb4oVeN3T1si85v=f7w@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295009>

=C3=80s 19:28 de 18-05-2016, Eric Sunshine escreveu:
> On Wed, May 18, 2016 at 11:27 AM, Vasco Almeida <vascomalmeida@sapo.p=
t> wrote:
>> Mark entire sentences of error message rather than assembling one us=
ing
>> placeholders (e.g. "Cannot %s during a %s"). That would facilitate
>> translation work.
>>
>> Signed-off-by: Vasco Almeida <vascomalmeida@sapo.pt>
>> ---
>> diff --git a/sequencer.c b/sequencer.c
>> @@ -697,9 +697,14 @@ static struct commit *parse_insn_line(char *bol=
, char *eol, struct replay_opts *
>>         if (action !=3D opts->action) {
>> -               const char *action_str;
>> -               action_str =3D action =3D=3D REPLAY_REVERT ? "revert=
" : "cherry-pick";
>> -               error(_("Cannot %s during a %s"), action_str, action=
_name(opts));
>> +               if (action =3D=3D REPLAY_REVERT)
>> +                     error((opts->action =3D=3D REPLAY_REVERT)
>> +                           ? _("Cannot revert during a another reve=
rt.")
>> +                           : _("Cannot revert during a cherry-pick.=
"));
>> +               else
>> +                     error((opts->action =3D=3D REPLAY_REVERT)
>> +                           ? _("Cannot cherry-pick during a revert.=
")
>> +                           : _("Cannot cherry-pick during another c=
herry-pick."));
>>                 return NULL;
>>         }
>=20
> Similar to my comment on patch 3/21, since the "actions" are literal
> git commands, it's not clear why this change is helpful. Perhaps the
> commit message needs to do a better job of persuading the reader?
>=20
I agree, I should have explained why this way. As I tried to explain on
patch 3/21, it concerns a) we can't assume what and how does the
translator translates into her language, so b) give translations freedo=
m
to choose.
