From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [PATCH RFC] git-send-email --expand-aliases
Date: Tue, 24 Nov 2009 10:43:44 +0000
Message-ID: <b0943d9e0911240243m13730f0bw34f2f18cf41f9079@mail.gmail.com>
References: <20091123221628.GE26810@ldl.fc.hp.com>
	 <7v6390sqhz.fsf@alter.siamese.dyndns.org>
	 <20091124004554.GA27643@ldl.fc.hp.com>
	 <b8197bcb0911232312l251dfbc9va671388cfb7fe57b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Alex Chiang <achiang@hp.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Karl Wiberg <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 11:44:00 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCssK-0003rJ-0x
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 11:44:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932760AbZKXKnl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Nov 2009 05:43:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932757AbZKXKnk
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 05:43:40 -0500
Received: from mail-fx0-f213.google.com ([209.85.220.213]:47400 "EHLO
	mail-fx0-f213.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932741AbZKXKni convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 24 Nov 2009 05:43:38 -0500
Received: by fxm5 with SMTP id 5so5632046fxm.28
        for <git@vger.kernel.org>; Tue, 24 Nov 2009 02:43:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RPSZbymZF/pEjXtERouobMZx3oZN48XQRw9IwuJRue4=;
        b=j1K43ZQpKGp3ATzBnJU1Iuh1fxYnm8PrLFuW2c/vAT60/1GB7JbPXPVQB7FlJcva8E
         0LF3W/eho9qFgHTfFRnMMbQBrYXmz5GX4K6LfVTk71x5fe8Wcya5E9sAmB4TCEn5XI7p
         BPYJwfHRjVbDG29VaHQ81ELl09uOpV80YaEEA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=QTpsTCfb9DiYa6DShkhkwKiJitydwDadVW2VSVrY+X5BmRIe4PQITO+DRULVyJYzvk
         o0w73JbAEGeC2/6M5Wllb+cfjkOCpLii+Y4OV99P2GleQf8LQhl3wtg+Jo337BEGvy5t
         QeHM1w7MsP84lbhk2RidRcXs+nPStHUAgFKgA=
Received: by 10.223.110.39 with SMTP id l39mr910220fap.3.1259059424441; Tue, 
	24 Nov 2009 02:43:44 -0800 (PST)
In-Reply-To: <b8197bcb0911232312l251dfbc9va671388cfb7fe57b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133571>

2009/11/24 Karl Wiberg <kha@treskal.com>:
> On Tue, Nov 24, 2009 at 1:45 AM, Alex Chiang <achiang@hp.com> wrote:
>
>> * Junio C Hamano <gitster@pobox.com>:
>>
>> > If you are changing StGit to call git-send-email anyway, why not
>> > arrange stgit to call git-send-email to send the message out
>> > instead, instead of sending messages on its own?
>>
>> Yeah, I thought about that as I was poking around further in StGit
>> to figure out how it would be calling git-send-email. ;)
>>
>> > I imagine the internal implementation of stg mail would work
>> > something like:
>> >
>> > =A0 =A0 prepare messages to send out
>> > =A0 =A0 call git-send-email and have it send them
>> >
>> > What am I missing?
>>
>> My lack of familiarity with StGit internals. ;)
>>
>> Your suggestion is much better. I'll take a closer look at StGit and
>> see how feasible it is.
>>
>> Unless Catalin has strong objections?
>
> I think that sounds like a splendid idea. It would be interesting to
> see just how thin a wrapper around git send-email (and format-patch)
> stg mail could become, without sacrificing features anyone actually
> uses. The main complication could be stg mail's templates.
>
> Catalin, how wedded are you to those? ;-)

Historically, I think "stg mail" was implemented before git-send-email
existed. It was also a good way to check who's using stgit for sending
patches :-) (the message-id).

I use templates to send patches to the ARM Linux gatekeeper via a
patch management system which only accepts patches formatted in a
certain way (things improved a bit recently and the format was
relaxed). But I find myself mostly sending pull requests these days,
so that's not a critical feature for me.

If there are no other users of the stg mail templates, I'm happy to
let them go. Otherwise, we can replace the sendmail with
git-send-email in stgit.

It seems that git-format-patch and git-send-email have all the
features stgit has. We would need to keep some of the interactive
options like --edit-cover and --edit-patches since we use
git-format-patch and git-send-email in one go.

--=20
Catalin
