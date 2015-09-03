From: John Keeping <john@keeping.me.uk>
Subject: Re: [RFC PATCH] git-p4: add option to store files in Git LFS on
 import
Date: Thu, 3 Sep 2015 11:12:39 +0100
Message-ID: <20150903101239.GP30659@serenity.lan>
References: <1440764691-62254-1-git-send-email-larsxschneider@gmail.com>
 <CAE5ih7-TfLqwye8YpmZz90AVjYGQ8m0sF6GLKnG9pjvV8cTSjw@mail.gmail.com>
 <9951C805-DFBF-47AC-B215-B9C657D4A852@gmail.com>
 <CAE5ih7-w5ZjO=QUE45yBvwyqdqKCADczrLt7=4W8X6BR+cy4PA@mail.gmail.com>
 <1D65DD68-EE3F-4C87-9B5F-E436BA13704E@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Luke Diamand <luke@diamand.org>, Git Users <git@vger.kernel.org>
To: Lars Schneider <larsxschneider@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 03 12:13:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZXRVv-0006Tw-Ad
	for gcvg-git-2@plane.gmane.org; Thu, 03 Sep 2015 12:13:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753708AbbICKMy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Sep 2015 06:12:54 -0400
Received: from jackal.aluminati.org ([72.9.247.210]:59069 "EHLO
	jackal.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752416AbbICKMx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 3 Sep 2015 06:12:53 -0400
Received: from localhost (localhost [127.0.0.1])
	by jackal.aluminati.org (Postfix) with ESMTP id EBF3ACDA61C;
	Thu,  3 Sep 2015 11:12:52 +0100 (BST)
X-Quarantine-ID: <Z1oaoPblZwsH>
X-Virus-Scanned: Debian amavisd-new at serval.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1.5
X-Spam-Level: 
X-Spam-Status: No, score=-1.5 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, BAYES_05=-0.5] autolearn=no
Received: from jackal.aluminati.org ([127.0.0.1])
	by localhost (jackal.aluminati.org [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id Z1oaoPblZwsH; Thu,  3 Sep 2015 11:12:49 +0100 (BST)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by jackal.aluminati.org (Postfix) with ESMTPSA id B25C2CDA5EB;
	Thu,  3 Sep 2015 11:12:41 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <1D65DD68-EE3F-4C87-9B5F-E436BA13704E@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277196>

On Thu, Sep 03, 2015 at 11:40:20AM +0200, Lars Schneider wrote:
>=20
> On 30 Aug 2015, at 18:36, Luke Diamand <luke@diamand.org> wrote:
>=20
> > On 30 August 2015 at 11:18, Lars Schneider <larsxschneider@gmail.co=
m> wrote:
> >> Thanks for your feedback!
> >>=20
> >> I like the =E2=80=9Chandle big files=E2=80=9D plugin kind of idea.=
 However, I
> >> wonder if it makes sense to put more and more stuff into git-p4.py
> >> (>3000 LOC already). What do you think about splitting git-p4 into
> >> multiple files?
> >=20
> > I was wondering about that. I think for now, the simplicity of keep=
ing
> > everything in one file is worth the slight extra pain. I don't imag=
ine
> > that the big-file-handler code would be very large.
> OK.
>=20
> >=20
> >>=20
> >> Regarding Python 3:
> >> Would you drop Python 2 support or do you want to support Python
> >> 2/3 in parallel? I would prefer the former=E2=80=A6
> >=20
> > For quite some time we would need to support both; we can't just ha=
ve
> > a release of git that one day breaks git-p4 for people stuck on Pyt=
hon
> > 2. But it might not be that hard to support both (though converting
> > all those print statements could be quite tiresome).
> Agreed. However supporting both versions increases code complexity as
> well as testing effort. Would a compromise like the following work? W=
e
> fork =E2=80=9Cgit-p4.py=E2=80=9D to =E2=80=9Cgit-p4-python2.py=E2=80=9D=
 and just apply important bug
> fixes to that file. All new development happens on a Python 3 only
> git-p4.py.=20

Documentation/CodingGuidelines currently says:

 - As a minimum, we aim to be compatible with Python 2.6 and 2.7.

 - Where required libraries do not restrict us to Python 2, we try to
   also be compatible with Python 3.1 and later.

That was added in commit 9ef43dd (CodingGuidelines: add Python coding
guidelines, 2013-01-30), which gives the following rationale in the
commit message:

 - Advocating Python 3 support in all scripts is currently unrealistic
   because:

     - 'p4 -G' provides output in a format that is very hard to use wit=
h
       Python 3 (and its documentation claims Python 3 is unsupported).

Has that changed?

I also found a message describing why the output is hard to use with
Python 3:

 	http://permalink.gmane.org/gmane.comp.version-control.git/213316

If that problem can be solved, I don't think it would be difficult to
support 2.6+ and 3.x with a single file.
