From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [RFC PATCH 2/6] msvc: opendir: allocate enough memory
Date: Tue, 23 Nov 2010 18:46:45 +0100
Message-ID: <AANLkTi=jYXbaw5kKtbhr9rPYe+DYxrbF2NA76eQD_uz+@mail.gmail.com>
References: <1290533444-3404-1-git-send-email-kusmabite@gmail.com>
 <1290533444-3404-3-git-send-email-kusmabite@gmail.com> <20101123174215.GC12113@burratino>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org,
	gitster@pobox.com
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 23 18:47:15 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKwxV-0004aq-Jr
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 18:47:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756010Ab0KWRrI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Nov 2010 12:47:08 -0500
Received: from mail-pz0-f46.google.com ([209.85.210.46]:38225 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755981Ab0KWRrH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 Nov 2010 12:47:07 -0500
Received: by pzk6 with SMTP id 6so582911pzk.19
        for <git@vger.kernel.org>; Tue, 23 Nov 2010 09:47:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type:content-transfer-encoding;
        bh=BwTch7iVm8Wvt8NSN5B9De4OceG0yWbsWfs4tcZKZXk=;
        b=PH71RsrEwHJHDeEhCJGKTeBLhgTAonNFlo4ZvxwUUovbZorS++zy+EIpe+faSvOl+W
         LgTHNdNQV/UlO7TEpVpn4NwxUIknvW88WwcCSfKvjEuiPM5+rwwNq1+6HangAOGzzZbw
         5Z1TAxnabkVU7GngcDJRdypKIGzCpctVC5tTU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        b=xBTzVI8rLq37bfo0OVBEBkCgBkP6u2dQlCt+30ZHqKyXMc4zvMUTFvA98fimpkfp75
         q0UXqdYBfbpdPjXgcgaigdDgwBE7ExoqgVFrV5jtJK0gFNQUlLL9QRiDIyj7wTaVPzTM
         XWt9w7TgvWTNGpBY75oPi3hOivuV2nk/q+Xzk=
Received: by 10.223.71.198 with SMTP id i6mr6047542faj.140.1290534425576; Tue,
 23 Nov 2010 09:47:05 -0800 (PST)
Received: by 10.223.72.206 with HTTP; Tue, 23 Nov 2010 09:46:45 -0800 (PST)
In-Reply-To: <20101123174215.GC12113@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161996>

On Tue, Nov 23, 2010 at 6:42 PM, Jonathan Nieder <jrnieder@gmail.com> w=
rote:
> Erik Faye-Lund wrote:
>
>> --- a/compat/msvc.c
>> +++ b/compat/msvc.c
>> @@ -5,12 +5,11 @@
>>
>> =A0DIR *opendir(const char *name)
>> =A0{
>> - =A0 =A0 int len;
>> + =A0 =A0 int len =3D strlen(p->dd_name);
>> =A0 =A0 =A0 DIR *p;
>
> Does this work?
>

Whoops. It does work for me, but it shouldn't. I guess malloc is
over-allocating, and git is only using short paths.

Thanks for catching it.
