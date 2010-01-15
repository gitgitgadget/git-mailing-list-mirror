From: Erik Faye-Lund <kusmabite@googlemail.com>
Subject: Re: [msysGit] [PATCH v2 02/14] mingw: implement syslog
Date: Sat, 16 Jan 2010 00:01:53 +0100
Message-ID: <40aa078e1001151501s462802ffua3aec600ed38f516@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <1263591033-4992-3-git-send-email-kusmabite@gmail.com>
	 <9d6091531001151457v4c446b61k40c93f7c6180683d@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org, j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>
To: Janos Laube <janos.dev@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 16 00:02:04 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVvB4-0000Ju-RS
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jan 2010 00:02:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758589Ab0AOXB6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jan 2010 18:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758584Ab0AOXB6
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 18:01:58 -0500
Received: from mail-ew0-f209.google.com ([209.85.219.209]:60311 "EHLO
	mail-ew0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758509Ab0AOXB5 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2010 18:01:57 -0500
Received: by ewy1 with SMTP id 1so666592ewy.28
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 15:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:reply-to:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=IV0hZTiaOfJH8dOw/5RHemIhDMvb2471ZZ1UWBsSp10=;
        b=eHVDjvSx41mgynfXwiFAjQ6L4VimgALju9BwRHWJ9Vm9qN9ZyBGBIrOsEQz5hlpm61
         E+NeglJUwCrizwbujCqpfSS9YvIfGsS8WCePk9IOfb4ibYeIpJ9lcFml3Jpb8FuRyiJL
         r7bMUJppsh18Cy9Yuwwie9Vr6OSW3tNahgClg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type:content-transfer-encoding;
        b=qteN+d0eKaee4qCZMMfGll3s5sedray+qpqlY/KX7ZmAK61OiPPpDTNNmT/Td/ocVj
         988aB3WNDfMJ3p9r7AiDaOPnwj1Hckmak+eOwx/GJAUf6ND/J4dbvtTksEHRldgplRSC
         +dTqqZBKc5Pu3opXpL4abbzr6S3GGu6Ij6Yfs=
Received: by 10.216.87.6 with SMTP id x6mr1038438wee.174.1263596513753; Fri, 
	15 Jan 2010 15:01:53 -0800 (PST)
In-Reply-To: <9d6091531001151457v4c446b61k40c93f7c6180683d@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137154>

On Fri, Jan 15, 2010 at 11:57 PM, Janos Laube <janos.dev@gmail.com> wro=
te:
>> +static HANDLE ms_eventlog;
>> +
>> +void openlog(const char *ident, int logopt, int facility)
>> +{
>> + =A0 =A0 =A0 if (ms_eventlog)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
>> + =A0 =A0 =A0 ms_eventlog =3D RegisterEventSourceA(NULL, ident);
>> +}
>
> maybe make ms_eventlog thread local?
> for example:
>
> static __thread HANDLE ms_eventlog;
>
> this would break compilation with msvc tho.
>
> janos
>

Since the code that use it isn't multi-threaded, I fail to see the
point. In fact even if it were, I'm not sure I see the big point...
especially since the "__thread"-keyword isn't used (AFAICT) at all in
the git source code so far.

--=20
Erik "kusma" Faye-Lund
