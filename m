From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [msysGit] [PATCH/RFC 03/11] mingw: implement syslog
Date: Fri, 27 Nov 2009 20:23:58 +0100
Message-ID: <200911272023.58262.j6t@kdbg.org>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com> <200911262223.22777.j6t@kdbg.org> <40aa078e0911270009u7569cfe5gb250092c8d2c0eac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 27 20:24:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NE6QW-0002JD-F0
	for gcvg-git-2@lo.gmane.org; Fri, 27 Nov 2009 20:24:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbZK0TYI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Nov 2009 14:24:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751283AbZK0TYH
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Nov 2009 14:24:07 -0500
Received: from [93.83.142.38] ([93.83.142.38]:63212 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751234AbZK0TYH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Nov 2009 14:24:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 7B95A19F610;
	Fri, 27 Nov 2009 20:23:58 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <40aa078e0911270009u7569cfe5gb250092c8d2c0eac@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133925>

On Freitag, 27. November 2009, Erik Faye-Lund wrote:
> On Thu, Nov 26, 2009 at 10:23 PM, Johannes Sixt <j6t@kdbg.org> wrote:
> > I would
> >
> > =A0 =A0 =A0 =A0const char* arg;
> > =A0 =A0 =A0 =A0if (strcmp(fmt, "%s"))
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0die("format string of syslog() not i=
mplemented")
> > =A0 =A0 =A0 =A0va_start(va, fmt);
> > =A0 =A0 =A0 =A0arg =3D va_arg(va, char*);
> > =A0 =A0 =A0 =A0va_end(va);
> >
> > because we have exactly one invocation of syslog(), which passes "%=
s" as
> > format string. Then strbuf_vaddf is not needed. Or even simpler: de=
clare
> > the function as
> >
> > void syslog(int priority, const char *fmt, const char*arg);
>
> After reading this again, I agree that this is the best solution. I'l=
l
> update for the next iteration.

Except that you shouldn't die like I proposed because here we are alrea=
dy in=20
the die_routine, no?

> > "Note that the string that you log cannot contain %n, where n is an
> > integer value (for example, %1) because the event viewer treats it =
as an
> > insertion string. ..."
> >
> > How are the chances that this condition applies to our use of the
> > function?
>
> Ugh, increasingly high since we're adding IPv6 support, I guess.
> Perhaps some form of escaping needs to be done?

I think so, but actually I have no clue.

-- Hannes
