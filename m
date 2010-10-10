From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH v3 05/14] mingw: use real pid
Date: Sun, 10 Oct 2010 22:52:10 +0200
Message-ID: <AANLkTinmpzo2-eyPrnx0u=tGBOcMBz03LuFUjZO87dG5@mail.gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
 <1286716854-5744-6-git-send-email-kusmabite@gmail.com> <4CB219D3.8000801@sunshineco.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org, msysgit@googlegroups.com, j6t@kdbg.org
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Oct 10 22:52:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P52sm-0007Ov-Jg
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 22:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641Ab0JJUwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 16:52:32 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:40890 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751498Ab0JJUwb (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 16:52:31 -0400
Received: by vws2 with SMTP id 2so574176vws.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 13:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:reply-to
         :in-reply-to:references:from:date:message-id:subject:to:cc
         :content-type;
        bh=eG2waWInjuTAPbR3D4Q7ENaDFjorA9jrwPyqUkz2tcE=;
        b=RmP+otCqr0Owr938qY+4917k+998mwmsiqpn8tSuOkFHDQ5dMb5OS1jdx9dkqIYkqn
         cTsQ6TafN15XjpIhT0N6eNzbkFANe3NNF+ugJwcwONRqbluFZGhQOs7K09cacyENsOru
         SPNuRD7yRas6i1mdhbXeAmyvfLa3p+ltvOxdY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        b=rS6oGXy79HvAShOncoTA2u4s7a31MLcIuZU4dA/IDONMdN1xLzbMARZDEkRoef5gBa
         vmGZBDnfOUNAk45PF2A2X+ezxKejCUb9vxHSrZ62ee76kAR0FLLWppgeOs99l60sjlTM
         mCWVaVGJwYfuVEACWgesiWEf/6yjtRdmKiADU=
Received: by 10.220.203.9 with SMTP id fg9mr1649642vcb.270.1286743950605; Sun,
 10 Oct 2010 13:52:30 -0700 (PDT)
Received: by 10.220.45.196 with HTTP; Sun, 10 Oct 2010 13:52:10 -0700 (PDT)
In-Reply-To: <4CB219D3.8000801@sunshineco.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158706>

On Sun, Oct 10, 2010 at 9:53 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
> On 10/10/2010 9:20 AM, Erik Faye-Lund wrote:
>>
>> The Windows port so far used process handles as PID. However,
>> this does not work consistently with getpid.
>
> Perhaps this could be elaborated a bit to explain the interaction with
> getpid() and how it is causing problems for daemon mode. For the casual
> reader, it is not immediately obvious what is failing or why this patch is
> needed.
>

Good point. How about something like this?

"The Windows port so far used process handles as PID. However, this is
not consistent with what getpid returns.

PIDs are system-global identifiers, but process handles are local to a
process. Using PIDs instead of process handles allows for instance a
user to kill a hung process with the Task Manager, something that
would have been impossible with process handles."
