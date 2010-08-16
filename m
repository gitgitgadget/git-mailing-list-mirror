From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Re: [PATCH v2] reset: Better warning message on git reset --mixed <paths>
Date: Mon, 16 Aug 2010 04:23:35 +0000
Message-ID: <AANLkTimHQ7c=F8y50Keq1eo5aC+D9fuaF7Eye5GJj1t-@mail.gmail.com>
References: <20100814210505.GA2372@burratino>
	<1281861800-424-1-git-send-email-avarab@gmail.com>
	<7vmxsndy5b.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Ralf Ebert <info@ralfebert.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 16 06:23:44 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OkrEd-0007NN-On
	for gcvg-git-2@lo.gmane.org; Mon, 16 Aug 2010 06:23:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751981Ab0HPEXh convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 16 Aug 2010 00:23:37 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53423 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751627Ab0HPEXg convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 16 Aug 2010 00:23:36 -0400
Received: by iwn7 with SMTP id 7so1267193iwn.19
        for <git@vger.kernel.org>; Sun, 15 Aug 2010 21:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=FiCkueraUNPcYJtOAYCBzT75I7qMXq2F2PyY1GsQCxQ=;
        b=M7NjEEjZ5aCLwOrxz65Av1Hi0KBEPThU/PJDRMczeQOqp7p3j+DGkQzoApImP46of/
         XRCiESNSD1/2RYCY0w0jm2CRLXWyY+22UqCUBPOY09BGcX7wEyHMYORCA9RazJbkw2GL
         7oaNsujUDG7r+I8qgM85ozKrWJN0T0xFxrU9M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=itPX7QNiiv+5Ln21Jagb0HgLFVJC+PQsK0lGlt+KzykIBujKBKy71S2ihpLva0Cxaq
         N/RwNvNIUbVPQmJm8oCXvIVqGXuVmyVeuHV0jLbUfkNxTtXT/R0RguWiU+oU7v3dnUoc
         C26ZUuGwrryjeMifaoKljyIgGn60HLb3DU3uo=
Received: by 10.231.130.99 with SMTP id r35mr4762108ibs.171.1281932615379;
 Sun, 15 Aug 2010 21:23:35 -0700 (PDT)
Received: by 10.231.186.226 with HTTP; Sun, 15 Aug 2010 21:23:35 -0700 (PDT)
In-Reply-To: <7vmxsndy5b.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153648>

On Mon, Aug 16, 2010 at 03:39, Junio C Hamano <gitster@pobox.com> wrote=
:
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason =C2=A0<avarab@gmail.com> write=
s:
>
>> When you call "git reset --mixed <paths>" git will complain that usi=
ng
>> mixed with paths is deprecated:
>>
>> =C2=A0 =C2=A0 warning: --mixed option is deprecated with paths.
>>
>> That doesn't tell the user why it's deprecated, or what he should us=
e
>> instead. Expand on the warning and tell the user to just omit --mixe=
d:
>>
>> =C2=A0 =C2=A0 warning: --mixed with paths is deprecated; use 'git re=
set -- <paths>' instead
>>
>> The exact wording of the warning was suggested by Jonathan Nieder.
>>
>> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.=
com>
>> ---
>>
>> On Sat, Aug 14, 2010 at 21:05, Jonathan Nieder <jrnieder@gmail.com> =
wrote:
>>> Maybe:
>>>
>>> =C2=A0warning: --mixed with paths is deprecated; use 'git reset -- =
<paths>' instead
>>
>> That's better, thanks. Here's an amended version, and with tests thi=
s
>> time.
>
> While the new message is an improvement, I do not think the added tes=
t
> that checks the exact wording is good.
>
> Think for 5 seconds what the expected code change would be to break t=
hat
> test. =C2=A0I can only think of two realistic cases. =C2=A0(1) Comman=
d line parsing
> is broken and "reset --mixed <pathspec>" does not go through the code=
path
> that produces this warning anymore; (2) we deem that we had the
> deprecation long enough and error out on this usage; or (3) Somebody =
comes
> up with an even better wording but the string in this test still expe=
cts
> suboptimal warning.
>
> When we change this to an error, that is a behaviour change (it will
> change the exit status as well), and it would be Ok to force the pers=
on
> who does such a change to update the test. =C2=A0But (3) shows that t=
his test
> is making it harder for people to improve the wording than necessary;
> isn't it sufficient to check if any warning is issued at all?

I thought we might test for deprecation warnings, since they're a step
above general warnings as they imply a deprecation cycle.

I'm just used to a codebase where every single warning message of that
sort is explicitly tested for, so I mostly did that out of habit.

> I personally do not think this deserves to consume a new test number,
> which is rather a scarce resource.

Just drop the test file from the patch, I don't think it's really
needed, and maybe drop the patch altogether. I don't know what we want
to do about this reset behavior in general.

>> diff --git a/t/t7112-reset-messages.sh b/t/t7112-reset-messages.sh
>> new file mode 100755
>> index 0000000..6f2669b
>> --- /dev/null
>> +++ b/t/t7112-reset-messages.sh
>> @@ -0,0 +1,33 @@
>> ...
>> +test_expect_success 'git reset --mixed <paths> warning' '
>> + =C2=A0 =C2=A0 # Not test_commit() due to "ambiguous argument [..] =
both revision
>> + =C2=A0 =C2=A0 # and filename"
>
> Huh?

I think I forgot that test_commit could take two args there.
