From: demerphq <demerphq@gmail.com>
Subject: Re: [PATCH] avoid exponential regex match for java and objc function 
	names
Date: Wed, 17 Jun 2009 18:00:37 +0200
Message-ID: <9b18b3110906170900g778b3c8aie627fb45a4967eb2@mail.gmail.com>
References: <20090617102332.GA32353@coredump.intra.peff.net>
	 <1245248766-14867-1-git-send-email-bonzini@gnu.org>
	 <9b18b3110906170846o5b3c3000r72506bf62765a044@mail.gmail.com>
	 <20090617155603.GA14545@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Paolo Bonzini <bonzini@gnu.org>, git@vger.kernel.org,
	gitster@pobox.com
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 17 18:01:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGxZN-00074R-M1
	for gcvg-git-2@gmane.org; Wed, 17 Jun 2009 18:01:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753920AbZFQQAg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 17 Jun 2009 12:00:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753245AbZFQQAg
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jun 2009 12:00:36 -0400
Received: from mail-gx0-f214.google.com ([209.85.217.214]:48431 "EHLO
	mail-gx0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753178AbZFQQAf convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Jun 2009 12:00:35 -0400
Received: by gxk10 with SMTP id 10so645033gxk.13
        for <git@vger.kernel.org>; Wed, 17 Jun 2009 09:00:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zH8UpMV4z02O9VvC+exriRPfGj0Bf10e5K1lAU41F3g=;
        b=Addp4Rl5/4GxZUkyosuDe1c5YS8ZCNHCvEcLn769xMTz3lNUo97ss9gBYWw6BFHbz+
         lu4r47A+9V4rI45lYmOH3W/LOg7EOH+C1DBrQ2mS4cCDXmy4tkmiO+vQrHxE38FZj4vY
         tY1z2zC3d+IVZHZkvmiT7Eb3HkdFR7i80+3JE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=DPSq5iH+hT3WSEoE7h21KC45MipAigARjpI8wzTbIS9uHpbzFRi0OeLCZ6f/u4dJd8
         u9SceFmApkRB3Q7CweMEhKjM0lpSRfGqs9aJBxhKagYvjXo9pubSvjVV1vVhJJTQuy26
         nuD9D8+FGXL6o4nTYXM6+LP8K4JyklEdxzkJQ=
Received: by 10.231.17.199 with SMTP id t7mr96454iba.46.1245254437076; Wed, 17 
	Jun 2009 09:00:37 -0700 (PDT)
In-Reply-To: <20090617155603.GA14545@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121755>

2009/6/17 Jeff King <peff@peff.net>:
> On Wed, Jun 17, 2009 at 05:46:54PM +0200, demerphq wrote:
>
>> Just =A0a note, but If the =A0Java regex library you are using suppo=
rts
>> the PCRE compatible (?>...) atomic matching construct (or their
>> equivalent *+ and ++) then these patterns can be significantly
>> improved beyond their current state.
>
> To clarify, this isn't a java regex library, but rather regexps used =
to
> match function names inside java language files when generating diffs=
=2E
> The regex library itself is the POSIX regex routines provided by libc=
=2E
>
> PCRE syntax is nice, but we don't want to require it for every build,
> and it's important to have the same syntax everywhere (so that, e.g.,
> your config from one build works on a different build).

Ah ok. Im not familiar with the finer points of the POSIX engine, but
PCRE and Perl's engine, and most similar engines are not true regular
expression engines and thus benefit *greatly* from atomic matching if
it is available.

Like the difference between heat-death performance (or stack
overflow), and running instantly.

Yves



--=20
perl -Mre=3Ddebug -e "/just|another|perl|hacker/"
