From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH B v4 5/5] git config: don't allow --get-color* and 
	variable type
Date: Sun, 22 Feb 2009 19:12:07 +0200
Message-ID: <94a0d4530902220912r94e00d6ha7592bc397baa57c@mail.gmail.com>
References: <1235177369-2727-1-git-send-email-felipe.contreras@gmail.com>
	 <1235177369-2727-2-git-send-email-felipe.contreras@gmail.com>
	 <1235177369-2727-3-git-send-email-felipe.contreras@gmail.com>
	 <1235177369-2727-4-git-send-email-felipe.contreras@gmail.com>
	 <1235177369-2727-5-git-send-email-felipe.contreras@gmail.com>
	 <1235177369-2727-6-git-send-email-felipe.contreras@gmail.com>
	 <7vmyce2z9q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 22 18:13:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbHtc-0003CR-AS
	for gcvg-git-2@gmane.org; Sun, 22 Feb 2009 18:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751855AbZBVRMN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 22 Feb 2009 12:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbZBVRML
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Feb 2009 12:12:11 -0500
Received: from fg-out-1718.google.com ([72.14.220.154]:36913 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751204AbZBVRMK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Feb 2009 12:12:10 -0500
Received: by fg-out-1718.google.com with SMTP id 16so2538320fgg.17
        for <git@vger.kernel.org>; Sun, 22 Feb 2009 09:12:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=wgZI6ImM2ww9vQLCPgXibR9MwQJ70w35YxBklFS9kug=;
        b=lHWBWza52/VcQXNRDPlBxXhJpfdz0qvU5Jz4EVNwsuI6x4c2CkjVWbswo3uksgCF5y
         B3/FWZ+k2qXL31kK/46AnVwxSnk72tsiIKINGxV4eOtQwsfek8Fvg7dqQxrbJFhiq/ZS
         a4iU4sbau5idgjFcIHnzuL+KaRucdiX0UqJ78=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=dVJQs/rBrljKqNZK2vd+FG8PCwP/JH/WlT4oeb6Gkw5D8Jx/+0q2XyvzUcKqC3+39W
         9dgKxn3Mr0x50pih6mOgQKlMU+KE7qaz2sqIMl0RgV8/TXu59t8jkaq+hdnkx1KuDSE9
         iLAKC8fjPAjPpx6fMvzGN7BwFYfD/porp7ub4=
Received: by 10.86.53.11 with SMTP id b11mr2375801fga.23.1235322727805; Sun, 
	22 Feb 2009 09:12:07 -0800 (PST)
In-Reply-To: <7vmyce2z9q.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111022>

On Sun, Feb 22, 2009 at 6:48 PM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> Doing so would be incoherent since --get-color would pick a color sl=
ot
>> and ignore the variable type option (e.g. --bool), and the type woul=
d
>> require a variable name.
>>
>> Suggested by Junio C Hamano.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>> =C2=A0builtin-config.c | =C2=A0 =C2=A05 +++++
>> =C2=A01 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/builtin-config.c b/builtin-config.c
>> index 8045926..9930568 100644
>> --- a/builtin-config.c
>> +++ b/builtin-config.c
>> @@ -359,6 +359,11 @@ int cmd_config(int argc, const char **argv, con=
st char *unused_prefix)
>> =C2=A0 =C2=A0 =C2=A0 if (get_colorbool_slot)
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 actions |=3D ACTION_GET_COLORBOOL=
;
>>
>> + =C2=A0 =C2=A0 if ((get_color_slot || get_colorbool_slot) && types)=
 {
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 error("--get-color and v=
ariable type are incoherent");
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 usage_with_options(built=
in_config_usage, builtin_config_options);
>> + =C2=A0 =C2=A0 }
>> +
>
> I do not think I suggested anything like this, so I'd decline to take
> credit for this patch.
>
> Strictly speaking, "--bool --get-colorbool diff.color 1" shouldn't er=
ror
> out, don't you think? =C2=A0And it certainly shouldn't say "--get-col=
or".

Huh? I misinterpreted:
I see "git config --bool --get-color diff.color.whitespace" is still
allowed, which you might want to tighten further.

I don't really understand the --get-color* options, so please drop the =
patch.

--=20
=46elipe Contreras
