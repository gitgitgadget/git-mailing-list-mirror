From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH v2 2/4] run_builtin(): save "-h" detection result for
 later use
Date: Fri, 22 Oct 2010 08:47:31 +0700
Message-ID: <AANLkTikngVJX-GYuu3xv=QnjQEXDcTL15T1n5h6EsPsE@mail.gmail.com>
References: <1287544320-8499-1-git-send-email-pclouds@gmail.com>
 <1287544320-8499-2-git-send-email-pclouds@gmail.com> <7vsjzzrw6d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Niedier <jrnieder@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 03:48:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P96jg-00076n-8m
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 03:48:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754030Ab0JVBry convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 21 Oct 2010 21:47:54 -0400
Received: from mail-wy0-f174.google.com ([74.125.82.174]:48608 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753250Ab0JVBrx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Oct 2010 21:47:53 -0400
Received: by wyf28 with SMTP id 28so271824wyf.19
        for <git@vger.kernel.org>; Thu, 21 Oct 2010 18:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=9w3klJiQBxOk0EsOFdrSqaRXnPGJOlk2viWm3j4LSPM=;
        b=upX+Lxqp2zVZYQvlaR7kCpTyBDrMoXXFDUimeT3kXcnwpgJPPEv0DXOYyhzQOyvNme
         O/UvrZJbpkRCPbH5+FxEtjQVEEywOMma6k4X17YpZ85l7cQrRgPypXRpHvfbJX7Zfx9V
         Jcyn6YhaxEb6JsiF7ezr/XMud24cRdr72AfbI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=XjXq+83S1HGoSgdRYpV1tmTpG1+7vTKrvCSG6MkpTjfN3jJ8gSr8GcBMiDPoqmWjcq
         tl9qldfaFr2QjS8tvArIWpmP7B4tpKCZwM0c1J+DPZylNvOkW5dbvYY2MqjH/c4V/8qy
         ibDIT0vWqb+ltJe9Unby5XcKy9m6PxsWrBBXs=
Received: by 10.227.128.197 with SMTP id l5mr1954854wbs.179.1287712072327;
 Thu, 21 Oct 2010 18:47:52 -0700 (PDT)
Received: by 10.216.171.207 with HTTP; Thu, 21 Oct 2010 18:47:31 -0700 (PDT)
In-Reply-To: <7vsjzzrw6d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159630>

2010/10/22 Junio C Hamano <gitster@pobox.com>:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com> writes:
>
>> When run_builtin() sees "-h" as the first argument, it assumes:
>>
>> =C2=A0- this is the call for help usage
>> =C2=A0- the real git command will only print help usage then exit
>>
>> So it skips all setup in this case. =C2=A0Unfortunately, some comman=
ds do
>> other things before calling parse_options(), which is often where th=
e
>> help usage is printed. =C2=A0Some of those things may try to access =
the
>> repository unnecessarily. If a repository is broken, the command may
>> die() before it prints help usage, not really helpful.
>
> What does die() message say in that case? =C2=A0If it says "your repo=
sitory is
> broken", that may be more useful than giving a help message. =C2=A0I =
dunno.

I should have written "if repository access is broken" (i.e. .git has
not been found, then somewhere access to .git is requested and .git is
set up automatically). But I'm chasing a ghost here. And the impact to
"-h" is probably nothing (how can accessing a wrong .git impacts a
static help string?). I'll take the series back. There are more
important things to work on than this.
--
Duy
