From: Aaron Crane <git@aaroncrane.co.uk>
Subject: Re: cvs revision number -> git commit name?
Date: Tue, 26 Jan 2010 22:53:15 +0000
Message-ID: <bc341e101001261453u16124186i298a53ead0b4eee2@mail.gmail.com>
References: <hbf.20100126bda0@bombur.uio.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
X-From: git-owner@vger.kernel.org Tue Jan 26 23:53:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZuHx-0005ZK-0I
	for gcvg-git-2@lo.gmane.org; Tue, 26 Jan 2010 23:53:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752141Ab0AZWxe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 26 Jan 2010 17:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752064Ab0AZWxd
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Jan 2010 17:53:33 -0500
Received: from mail-fx0-f220.google.com ([209.85.220.220]:39881 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751938Ab0AZWxb convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 26 Jan 2010 17:53:31 -0500
Received: by fxm20 with SMTP id 20so967935fxm.21
        for <git@vger.kernel.org>; Tue, 26 Jan 2010 14:53:30 -0800 (PST)
Received: by 10.216.90.21 with SMTP id d21mr1399892wef.85.1264546410259; Tue, 
	26 Jan 2010 14:53:30 -0800 (PST)
X-Originating-IP: [87.194.157.167]
In-Reply-To: <hbf.20100126bda0@bombur.uio.no>
X-Google-Sender-Auth: 4aada404fd38cac3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138083>

Hallvard B Furuseth <h.b.furuseth@usit.uio.no> wrote:
> When moving from CVS to Git, what's a good way to help Git users
> find an old commit given the original CVS revision number? =A0Are
> there tools available to help?
>
> One could commit a table with a (file,revision)->commit mapping,
> I suppose something can generate it when importing from cvs?

That's what we decided to do on a recent CVS-to-Git conversion, though
like you, we also considered munging the log messages instead.  Our
jury's still out on whether it was the right decision; we haven't had
much cause to use the result yet.

One thing to be aware of (beyond the need to run grep to convert old
CVS revision numbers to Git commit IDs) is that there's a good chance
the mapping file will pollute the results of `git grep` for some
tasks.  (We've put the mapping file into our repo, where it's easy to
find.)  I'm considering gzipping the mapping file as a workaround;
that would mean our users will need to use zgrep (or equivalent) to
look up CVS revision numbers, which may or may not be a problem in
your situation.

I have an initial patch to git-cvsimport that adds a switch to
generate the mapping as it goes.  I'm currently trying to find time to
clean it up and submit it.

--=20
Aaron Crane ** http://aaroncrane.co.uk/
