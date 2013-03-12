From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [RFC/PATCH] Documentation/technical/api-fswatch.txt: start with outline
Date: Tue, 12 Mar 2013 10:50:15 +0100
Message-ID: <CABPQNSYT2DiMeMe+6ropa8O7YUzAVR_b4CD+75qw4fw6XAv+8w@mail.gmail.com>
References: <1362946623-23649-1-git-send-email-artagnon@gmail.com>
 <20130311170542.GB4167@sandbox-ub.fritz.box> <CALkWK0m+CS25=Z91y90z49g4GK+b7oFugiXoH0h0J6P-yQXRCQ@mail.gmail.com>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Heiko Voigt <hvoigt@hvoigt.net>, Git List <git@vger.kernel.org>,
	Duy Nguyen <pclouds@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Drew Northup <n1xim.email@gmail.com>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 12 10:51:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UFLrj-0005m9-Hi
	for gcvg-git-2@plane.gmane.org; Tue, 12 Mar 2013 10:51:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755210Ab3CLJu5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Mar 2013 05:50:57 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:64614 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932451Ab3CLJu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Mar 2013 05:50:56 -0400
Received: by mail-ie0-f172.google.com with SMTP id c10so6140849ieb.31
        for <git@vger.kernel.org>; Tue, 12 Mar 2013 02:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:reply-to:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=X9OwmxYT2r/IXvAS1E3C6N26Ub39Trj7+BOvY1YkG0Q=;
        b=J3NkxJLgS2TXDJevy4gRo3hywBTNXEYEpW81j0OP9jfxtSlDFE5ZMGgMxprOgeeY0+
         2PqDT1AXQT6kF1bO+wc+2Z++QI17wMwCKiSTAx8rhEabzDTYTwaAIxUbtP1SIeeJmEIN
         dIlQCMe7x544QbLWS34QMUGGO7aI+Upa5rvsipE9t1QR5kmG4F0dFBtKSAYmxGqoGOkI
         fvNAQSnkHqeJjqmX5JAmSgXumJWJztbK64lqqTr+ka9HiQXxyLGTbsYzZJb1j0yKz4cb
         /ILmZdcGZBxoduNhGWEikQToSEThCUkDkR9ilsis8sYSlhSffis06QN0OO5trm+EkBwg
         8vxQ==
X-Received: by 10.50.88.228 with SMTP id bj4mr10924242igb.85.1363081855574;
 Tue, 12 Mar 2013 02:50:55 -0700 (PDT)
Received: by 10.64.44.47 with HTTP; Tue, 12 Mar 2013 02:50:15 -0700 (PDT)
In-Reply-To: <CALkWK0m+CS25=Z91y90z49g4GK+b7oFugiXoH0h0J6P-yQXRCQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217940>

On Tue, Mar 12, 2013 at 10:43 AM, Ramkumar Ramachandra
<artagnon@gmail.com> wrote:
> Heiko Voigt wrote:
>> While talking about platform independence. How about Windows? AFAIK
>> there are no file based sockets. How about using shared memory, thats
>> available, instead? It would greatly reduce the needed porting effort.
>
> What about the git credential helper: it uses UNIX sockets, no?  How
> does git-credential-winstore [1] work?
>
> [1]: https://github.com/anurse/git-credential-winstore

First, we have a proper credential helper for Windows in
contrib/credential/wincred these days. As the one who wrote that, we
communicate using stdin/stdout. The credential-helper doesn't maintain
state in itself, the Windows Credential Manager does. I suspect
git-credential-winstore works the same way.

As for Windows support, AFAIK there is no support for Unix domain
sockets in Windows. But there is support for named pipes, which is
almost the same thing. What we have support for in compat/mingw.[ch]
is a different matter, but we can extend that if needed.
