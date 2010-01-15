From: Janos Laube <janos.dev@gmail.com>
Subject: Re: [msysGit] [PATCH v2 02/14] mingw: implement syslog
Date: Fri, 15 Jan 2010 23:57:07 +0100
Message-ID: <9d6091531001151457v4c446b61k40c93f7c6180683d@mail.gmail.com>
References: <1263591033-4992-1-git-send-email-kusmabite@gmail.com>
	 <1263591033-4992-3-git-send-email-kusmabite@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org, j6t@kdbg.org,
	Mike Pape <dotzenlabs@gmail.com>,
	Erik Faye-Lund <kusmabite@gmail.com>
To: Erik Faye-Lund <kusmabite@googlemail.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 23:57:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVv6Q-0006u8-0H
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 23:57:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758564Ab0AOW5K convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Jan 2010 17:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758509Ab0AOW5K
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Jan 2010 17:57:10 -0500
Received: from mail-bw0-f227.google.com ([209.85.218.227]:42298 "EHLO
	mail-bw0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932146Ab0AOW5J convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Jan 2010 17:57:09 -0500
Received: by bwz27 with SMTP id 27so1005931bwz.21
        for <git@vger.kernel.org>; Fri, 15 Jan 2010 14:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=nY0LtMp4LCccaCr8P9mGglokuFffRkAul2ZW+5IsJu0=;
        b=Qu9Fo1n9BD70Je2Q5TZJKSJ2b5AVefF+YI1Pdf01htT2/pocrkQK8gLJrSfPKuTjj8
         pkdFZyglUEpchworQgxfsgc1d64zk7+wNT4fZ7fSVAw69BSoduqR4PiqZOqoRbgxL2IH
         oJ8Z4htghGLRWWXHyY95bW60R01WlCGPSUmvE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Dauh1A8vABuZ8I7vKK/zxLLf/j1Yu8P1/KWdnFXhtScKIY42b87tf/KGvJu/BiOzpV
         /LzVt5vKgQlxXp1TvA0URDvJjC8jg7eMx35+T4VUYKMFmhUIZAa8vSjE05ntaLMNDloi
         Vv6jfAGd4wNNNtug4zuG1YKzxh9AUhVqDHEYo=
Received: by 10.204.6.5 with SMTP id 5mr1608532bkx.167.1263596227877; Fri, 15 
	Jan 2010 14:57:07 -0800 (PST)
In-Reply-To: <1263591033-4992-3-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137153>

> +static HANDLE ms_eventlog;
> +
> +void openlog(const char *ident, int logopt, int facility)
> +{
> + =C2=A0 =C2=A0 =C2=A0 if (ms_eventlog)
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return;
> + =C2=A0 =C2=A0 =C2=A0 ms_eventlog =3D RegisterEventSourceA(NULL, ide=
nt);
> +}

maybe make ms_eventlog thread local?
for example:

static __thread HANDLE ms_eventlog;

this would break compilation with msvc tho.

janos
