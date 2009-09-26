From: Reece Dunn <msclrhd@googlemail.com>
Subject: Re: [PATCH] Remove various dead assignments and dead increments found 
	by the clang static analyzer
Date: Sat, 26 Sep 2009 22:03:27 +0100
Message-ID: <3f4fd2640909261403n78a7e45cm3d2cd48408b5ff52@mail.gmail.com>
References: <87ab0hepcn.fsf@master.homenet>
	 <alpine.DEB.1.00.0909261756510.4985@pacific.mpi-cbg.de>
	 <871vltefdj.fsf@master.homenet>
	 <fabb9a1e0909261134qd90dba1n9637fe4adc253fc1@mail.gmail.com>
	 <87ske9cya9.fsf@master.homenet>
	 <20090926204604.GA2960@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Giuseppe Scrivano <gscrivano@gnu.org>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Sep 26 23:03:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MreQZ-00009T-Er
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 23:03:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752696AbZIZVDY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 26 Sep 2009 17:03:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752661AbZIZVDY
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Sep 2009 17:03:24 -0400
Received: from mail-vw0-f203.google.com ([209.85.212.203]:45308 "EHLO
	mail-vw0-f203.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752630AbZIZVDX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 26 Sep 2009 17:03:23 -0400
Received: by vws41 with SMTP id 41so2189165vws.4
        for <git@vger.kernel.org>; Sat, 26 Sep 2009 14:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=AXz2MySWVjrq5pM1jcXUa4H+m1zGwKbz5Q/7U/P6bgA=;
        b=eC9O3AP/J5DFXCN+fIcKXwhOk2N/6kYQBjEJlBWM7DWUPT2HcpAHD23dwu/wQHPTv6
         M+xqcSJ6CoJExGMn/5ZuFkVeMRMYG26ZKXRj799bUETx+wtfaqKq0kLBEW507oqGSsTa
         ciPNX28gUmekdaYhRdfgki1iPqwvN4b54Odyg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=WKLwwPU83R5YLga/7t6yRBLQm1J3+KGhyJbQIOtJlMP8FQLJgQseO6q+Ree4gkvDuo
         IRwHLNSnNwKggqK2i6L2W9pBVXtAGOKPTezzjq57SwaEX0FNfPdqgsC7aYzyc96nsBgJ
         cubWMgUAYlTjir+DBNDvOEjPmht10Gp4rD/BA=
Received: by 10.220.111.195 with SMTP id t3mr2959252vcp.8.1253999007351; Sat, 
	26 Sep 2009 14:03:27 -0700 (PDT)
In-Reply-To: <20090926204604.GA2960@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129179>

2009/9/26 Jeff King <peff@peff.net>:
> On Sat, Sep 26, 2009 at 09:15:58PM +0200, Giuseppe Scrivano wrote:
>
>> Here is a cleaned patch. =A0I think these assignments can be removed
>> without any problem.
>
>> --- a/builtin-receive-pack.c
>> +++ b/builtin-receive-pack.c
>> @@ -368,7 +368,7 @@ static char update_post_hook[] =3D "hooks/post-u=
pdate";
>> =A0static void run_update_post_hook(struct command *cmd)
>> =A0{
>> =A0 =A0 =A0 struct command *cmd_p;
>> - =A0 =A0 int argc, status;
>> + =A0 =A0 int argc;
>> =A0 =A0 =A0 const char **argv;
>>
>> =A0 =A0 =A0 for (argc =3D 0, cmd_p =3D cmd; cmd_p; cmd_p =3D cmd_p->=
next) {
>> @@ -391,7 +391,7 @@ static void run_update_post_hook(struct command =
*cmd)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 argc++;
>> =A0 =A0 =A0 }
>> =A0 =A0 =A0 argv[argc] =3D NULL;
>> - =A0 =A0 status =3D run_command_v_opt(argv, RUN_COMMAND_NO_STDIN
>> + =A0 =A0 run_command_v_opt(argv, RUN_COMMAND_NO_STDIN
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | RUN_COMMAND_STDOUT_TO_=
STDERR);
>> =A0}
>
> Now this is one that I do think is sensible. The variable isn't used,=
 so
> don't even bother declaring it.

The status variable is removed in this patch.

But then shouldn't the status returned be checked and acted on? That
is, are failures from run_command_v_opt being reported to the user, or
otherwise reacted to?

In this case, IIUC, the status should be returned by the
run_update_post_hook function. I.e.:

-  static void run_update_post_hook(struct command *cmd)
+  static int run_update_post_hook(struct command *cmd)
  {
      struct command *cmd_p;
-     int argc, status;
+     int argc;
=2E..
-     status =3D run_command_v_opt(argv, RUN_COMMAND_NO_STDIN
+     return run_command_v_opt(argv, RUN_COMMAND_NO_STDIN
                      | RUN_COMMAND_STDOUT_TO_STDERR);
   }

Thus having the same effect (removing the status variable). Callers of
run_update_post_hook should be checked as well, as should other
run_command_* calls.

- Reece
