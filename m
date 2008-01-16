From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Wed, 16 Jan 2008 15:38:35 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801161522160.2806@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <m33asxn2gt.fsf@roke.D-201> <65026F2B-5CE8-4238-A9AB-D3545D336B41@sb.org> <200801162251.54219.jnareb@gmail.com> <1574A90A-8C45-46AD-9402-34AE6F582B3F@sb.org> <alpine.LFD.1.00.0801161424040.2806@woody.linux-foundation.org>
 <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jakub Narebski <jnareb@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Mark Junker <mjscod@web.de>, git@vger.kernel.org
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Thu Jan 17 00:39:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JFHqh-0003k2-Be
	for gcvg-git-2@gmane.org; Thu, 17 Jan 2008 00:39:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750993AbYAPXin convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Jan 2008 18:38:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750990AbYAPXin
	(ORCPT <rfc822;git-outgoing>); Wed, 16 Jan 2008 18:38:43 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:47000 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750931AbYAPXim (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 16 Jan 2008 18:38:42 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0GNca4R031154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 16 Jan 2008 15:38:37 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0GNcZ0V030611;
	Wed, 16 Jan 2008 15:38:35 -0800
In-Reply-To: <7652B11D-9B9F-45EA-9465-8294B701FE7C@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.716 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70775>



On Wed, 16 Jan 2008, Kevin Ballard wrote:
>=20
> There's a difference between "looks similar" as in "Polish" vs "polis=
h", and
> actually is the same string as in "Ma<UMLAUT MODIFIER>rchen" vs "M<A =
WITH
> UMLAUT>rchen". Capitalization has a valid semantic meaning, normaliza=
tion
> doesn't.=20

That simply isn't true.

Normalization actually has real semantic meaning. If it didn't, there=20
would never ever be a reason why you'd use the non-normalized form in t=
he=20
first place.

Others have argued the exact same thing for capitalization. "A" is the=20
same letter as "a". Except there is a distinction.

The same is true of "a<UMLAUT MODIFIER>" and "<a WITH UMLAUT>". Yes, it=
's=20
the same "chacter" in either case. Except when there is a distinction.

And there *are* cases where there are distinctions. Especially inside=20
computers. For one thing, you may not be talking about "characters on=20
screen", but you may be talking about "key sequences". And suddenly=20
"a<UMLAUT MODIFIER>" is a two-key sequence, and "<a WITH UMLAUT>" is a=20
single-key sequence, and THEY ARE DIFFERENT.

See?

"a" and "A" are the same letter. But sometimes case matters.

Multi-character UTF-8 sequences may be the same character. But sometime=
s=20
the sequence matters.

Same exact thing.

>	The only way to argue that normalization is wrong is by providing a
> good reason to preserve the exact byte sequence, and so far the only =
reason
> I've seen is to help git.

Git doesn't care. Just use the *same* sequence everywhere. Make sure=20
something doesn't change it. Because if something changes it, git will=20
track it.

> How do you figure? When I type "M=E4rchen", I'm typing a string, not =
a byte
> sequence. I have no control over the normalization of the characters.
> Therefore, depending on what program I'm typing the name in, I might =
use the
> same normalization as the filename, or I might miss. It's completely =
out of my
> control. This is why the filesystem has to step in and say "You compo=
sed that
> character differently, but I know you were trying to specify this fil=
e".

Pure and utter garbage.

What you are describing is an *input method* issue, not a filesystem=20
issue.

The fact that you think this has anything what-so-ever to do with=20
filesystems, I cannot understand.

Here's an example: I can type M=E4rchen two different ways on my keyboa=
rd: I=20
can press the '=E4' key (yes, I have one, I have a Swedish keyboard), o=
r I=20
could press the '=A8' key and the 'a' key.

See: I get '=E4' and '=E4' respectively.

And as I send this email off, those characters never *ever* got written=
 as=20
filenames to any filesystem. But they *did* get written as part of=20
text-files to the disk using "write()", yes.

And according to your *insane* logic, that write() call should have=20
converted them to the same representation, no?

Hell no! That conversion has absolutely nothing to do with the filesyst=
em.=20
It's done at a totally different layer that actually knows what it is=20
doing, and turned them both into \xc3\xa4 (and then, the email client=20
probably will turn this into Latin1, and send it out as a single-byte=20
'\xe4' character).

See? Putting the conversion in the filesystem IS INSANE. You wouldn't m=
ake=20
the filesystem convert the characters in the data stream (because it wo=
uld=20
cause strange data conversion issues) AND FOR EXACTLY THE SAME REASON i=
t=20
shouldn't do it for filenames either!

And your claim that "you have no control over the normalization of=20
characters" is simply insane. Of course you have. It's just not suppose=
d=20
to be at the filesystem level - whether it's a write() call or a creat(=
)=20
call!

			Linus
