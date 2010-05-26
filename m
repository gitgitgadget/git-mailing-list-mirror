From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [PATCH 3/5] checkout --orphan: respect -l option always
Date: Wed, 26 May 2010 17:13:02 +0200
Message-ID: <AANLkTikKAkwHYj6OvfEJM1YE8w2TZL2oeMBrj28V3CwX@mail.gmail.com>
References: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com>
	 <1274488119-6989-4-git-send-email-erick.mattos@gmail.com>
	 <7vzkznqmir.fsf@alter.siamese.dyndns.org>
	 <AANLkTimT3sI3yuM8RZai-eWDk8Z5Rmc28RLGOx_i-RXa@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Erick Mattos <erick.mattos@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 26 17:13:26 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OHIIQ-0005GT-6X
	for gcvg-git-2@lo.gmane.org; Wed, 26 May 2010 17:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755524Ab0EZPNF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 May 2010 11:13:05 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:36383 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755396Ab0EZPNE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 May 2010 11:13:04 -0400
Received: by wwb13 with SMTP id 13so411947wwb.19
        for <git@vger.kernel.org>; Wed, 26 May 2010 08:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:reply-to
         :in-reply-to:references:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=L1QPLQSHCO3igRZ1UfROJUeurm/g3xHKJmRTQNHMhG8=;
        b=FHC1de4Kx4afLi1Cz3jfkDDL0wz5/8IEBy6awEuR5Nmu7biq0SSAHGzwG4uyWmLdVl
         VCrYU6M/cAFURqLHhkZA3Xqdg9zW5ai6Tz2zKyQsdziR+IOgu9U5knqPf2vlo6PBNKDB
         J7qoGy5FppPiulPVxT5k7KpQKErckTgzFg3c4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=QTRFIk6HhkzTAREJrr0bHshuhbY996LD1JuZLpo2zjqOMCINn018riZGgiFO5jY/HA
         6Mt5xqCQQstOI4R6k4zIelZXJEbyr5hZ8ni1cosX9B0VX7ZCOA++FXEUNVvMh8n0WiGX
         uymvpb6ruyr9HapiLGco4QSA24COXwlWSaO2I=
Received: by 10.216.86.140 with SMTP id w12mr5663101wee.95.1274886782596; Wed, 
	26 May 2010 08:13:02 -0700 (PDT)
Received: by 10.216.21.73 with HTTP; Wed, 26 May 2010 08:13:02 -0700 (PDT)
In-Reply-To: <AANLkTimT3sI3yuM8RZai-eWDk8Z5Rmc28RLGOx_i-RXa@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147804>

On Wed, May 26, 2010 at 4:52 PM, Erick Mattos <erick.mattos@gmail.com> =
wrote:
> Hi,
>
> 2010/5/26 Junio C Hamano <gitster@pobox.com>
>>
>> Erick Mattos <erick.mattos@gmail.com> writes:
>> > @@ -684,8 +709,8 @@ int cmd_checkout(int argc, const char **argv, =
const char *prefix)
>> > =A0 =A0 =A0 if (opts.new_orphan_branch) {
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (opts.new_branch)
>> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("--orphan and -b a=
re mutually exclusive");
>> > - =A0 =A0 =A0 =A0 =A0 =A0 if (opts.track > 0 || opts.new_branch_lo=
g)
>> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("--orphan cannot be =
used with -t or -l");
>> > + =A0 =A0 =A0 =A0 =A0 =A0 if (opts.track > 0)
>> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 die("--orphan should not=
 be used with -t");
>>
>> Why s/cannot/should not/? =A0Just being curious.
>
> I have typed that text, not changed the original so this is not a fix
> to your text.=A0 Anyway for me "should not" is more polite, like "you
> should not yell" meaning you really can not do it.=A0 Or "you should =
not
> disrespect the captain".

I don't think it makes sense to try and be polite when we're actually
refusing... "should not" implies that it possible but not recommended.
And in this case it's impossible, because we die()...

--=20
Erik "kusma" Faye-Lund
