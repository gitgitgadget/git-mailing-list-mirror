From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git on MacOSX and files with decomposed utf-8 file names
Date: Mon, 21 Jan 2008 14:34:32 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0801211407130.2957@woody.linux-foundation.org>
References: <478E1FED.5010801@web.de> <alpine.LFD.1.00.0801170842280.14959@woody.linux-foundation.org> <478F99E7.1050503@web.de> <alpine.LFD.1.00.0801171017460.14959@woody.linux-foundation.org> <F666FFD2-9777-47EA-BEF4-C78906CA8901@simplicidade.org>
 <alpine.LFD.1.00.0801171100330.14959@woody.linux-foundation.org> <Pine.LNX.4.64.0801181114430.817@ds9.cixit.se> <alpine.LFD.1.00.0801180909000.2957@woody.linux-foundation.org> <Pine.LNX.4.64.0801211509490.17095! @ds9.cixit.se> <440E4426-BFB5-4836-93DF-05C99EF204E6@sb.org>
 <alpine.LFD.1.00.0801! 210934400.2957@woody.linux-foundation.org> <C6C0E6A1-053B-48CE-90B3-8FFB44061C3B@sb.org> <alpine.LFD.1.00.08! 01211129130.2957@woody.linux-foundation.org> <373E260A-6786-4932-956A-68706AA7C469@sb.org> <alpine.LFD.1.00.!
 0801211210270.2957@woody.linux-foundation.org> <7EB98659-4036-45DA-BD50-42CB23ED517A@sb.org> <alpine.LFD.1.0! 0.0801211323120.2957@woody.linux-foundation.org> <C373E12A-2AC4-4961-833A-7D51584143C9@sb.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Peter Karlsson <peter@softwolves.pp.se>,
	Mark Junker <mjscod@web.de>,
	Pedro Melo <melo@simplicidade.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Kevin Ballard <kevin@sb.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 23:36:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH5FD-00015T-Ix
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 23:35:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754082AbYAUWfO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 17:35:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752616AbYAUWfO
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 17:35:14 -0500
Received: from smtp2.linux-foundation.org ([207.189.120.14]:43408 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752158AbYAUWfM (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jan 2008 17:35:12 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LMYXpF031095
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 21 Jan 2008 14:34:34 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m0LMYWhj023374;
	Mon, 21 Jan 2008 14:34:32 -0800
In-Reply-To: <C373E12A-2AC4-4961-833A-7D51584143C9@sb.org>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-2.723 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71359>



On Mon, 21 Jan 2008, Kevin Ballard wrote:
> 
> I'm really surprised that, after all of this, you're still horribly
> misunderstanding my argument. I never said it was invisible. NEVER.

You said it was invisible when you treat things "as text". Here's the 
quote:

	.. when you treat filenames as text, it DOESN'T MATTER if the 
 	string gets normalized ..

Without ever apparently realizing that "as text" is part of the problem in 
itself. What is "text" to one person is gibberish to another.

In particular, the biggest reason to not normalize is that you don't know 
it's text or Unicode in the first place. Which is why git doesn't do it.

And no, even with filenames you don't know that they are "text". People 
encode stuff in them. And people don't always use UTF-8. 

Of course, you could ask everybody to create OS X-only programs that know 
that under OS X, you only have a subset of filenames. If so, you're 
complaining about the wrong tool. Especially when the whole point of the 
tool was to be distributed (not to mention coming from an environment that 
simply doesn't have the same silly limitations OS X has).

So here's a few clues:

 - "as text" isn't "as unicode": it may well be Latin1 or EUC-JP or
   something. Yes, it's still used. Git doesn't care, and very consciously 
   has avoided forcing character sets, even if the *default* (and notice 
   how it's overridable) commit message encoding may be utf-8.

 - In fact, even in unicode, the difference between "identical" and 
   "equivalent" strings exists, and even in the standard, unicode 
   strings are very much defined to be arbitrary codepoint sequences, not 
   normalized.

So even for the very specific case of unicode text, it's simply not true 
that "it doesn't matter if the string gets normalized". The unicode spec 
itself talks about cases where even canonical normalization makes a 
difference.

Search for this quote:

  "Not all processes are required to respect canonical equivalence. For 
   example:

    * A function that collects a set of the General_Category values 
      present in a string will and should produce a different value for 
      <angstrom sign, semicolon> than for <A, combining ring above, greek 
      question mark>, even though they are canonically equivalent.
    * A function that does a binary comparison of strings will also find 
      these two sequences different."

and notice that first case. Even things that are *very*much* aware of 
Unicode text do actually have cases where canonical equivalence doesn't 
mean crud.

		Linus
