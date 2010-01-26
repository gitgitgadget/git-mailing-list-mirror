From: Tay Ray Chuan <rctay89@gmail.com>
Subject: Re: [PATCH] t5541-http-push: make grep expression check for one line 
	only
Date: Tue, 26 Jan 2010 09:33:24 +0800
Message-ID: <be6fef0d1001251733o57042a99q9f1f8b6e849187ee@mail.gmail.com>
References: <1264405343-2984-1-git-send-email-rctay89@gmail.com>
	 <7v7hr63wm7.fsf@alter.siamese.dyndns.org>
	 <7v1vhe3wdz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 26 02:33:31 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZaJ8-00037T-GP
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 02:33:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752166Ab0AZBd0 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 20:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751628Ab0AZBd0
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 20:33:26 -0500
Received: from mail-iw0-f173.google.com ([209.85.223.173]:41988 "EHLO
	mail-iw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450Ab0AZBdZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 20:33:25 -0500
Received: by iwn3 with SMTP id 3so1508856iwn.19
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 17:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=Cl46kJK53rQn1ESGed6kqVu0HQkqvHz8nusmlMXBftE=;
        b=q82Wk3rI9srYQz87TPzszqtrnbBB+RJ7YMt7dlIR39zP5jvVBMi1tFp4TlUEJ3OCUZ
         /+cti9bw1ufkJN/JbAAStDSiSvFjcNLEMPr2Sjpd/vHwL5IIxTKoLKXh6oIGcwQmi4pf
         VROKdJUxnt2S3WEzQNTjlc+llA4Jvp3R12YCo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=FFZbpZPxxpvMzcsnZ4o388JEaMwXj2gP9xT3Cc8NmBNAmg6Q5QpZanuW/XaflChEuH
         USMO1P8bqf5oeNQT4t7F6TddTBivRb9G1ftfsKPsdid0TzuOQ62WtfSWdBmKr05QIp1d
         bRNnzIsJsn2lFd8dztUbNCDNTA99Iia/mxwyM=
Received: by 10.231.150.74 with SMTP id x10mr1700242ibv.97.1264469604772; Mon, 
	25 Jan 2010 17:33:24 -0800 (PST)
In-Reply-To: <7v1vhe3wdz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138018>

Hi,

On Tue, Jan 26, 2010 at 1:52 AM, Junio C Hamano <gitster@pobox.com> wro=
te:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Tay Ray Chuan <rctay89@gmail.com> writes:
>>
>>> Simplify the grep expressions in the non-fast-forward tests to chec=
k
>>> only for the first line of the non-fast-forward warning - having th=
at
>>> line should be enough assurance that the full warning is printed.
>>>
>>> In the first place, grep can't deal with expressions for multiple
>>> lines.
>>
>> This shows that nobody has ever run this test since January 8th, not=
 even
>> the original author?
>>
>> Hmmm.
>
> Actually, if you grep with a pattern with multiple lines, it is equiv=
alent
> to giving each of these lines as a separate pattern from the command =
line.
> So it is understandable that the tests passed. =A0They were checking =
if
> these match, but it doesn't check (and grep is not designed to) if th=
e
> first pattern matched the first line, the second to second, etc.

that was why the tests passed then and passed now - I just happened to
run them, and I noticed grep reported success, yet only matched 2 of
the 3 lines. Then I remembered recently there had been a rewording of
the fast-forward warning was reworded (c0eb604 "push: spell 'Note
about fast-forwards'")...

> So I'd say something like...
>
> =A0 =A0Don't feed multiple-line pattern to grep and expect them to ma=
tch with
> =A0 =A0lines in order.
>
> =A0 =A0Simplify the grep expressions in the non-fast-forward tests to=
 check
> =A0 =A0only for the first line of the non-fast-forward warning - havi=
ng that
> =A0 =A0line should be enough assurance that the full warning is print=
ed.
>
> =A0 =A0Signed-off-by: Tay Ray Chuan <rctay89@gmail.com>
>
> instead.

No problem.

--=20
Cheers,
Ray Chuan
