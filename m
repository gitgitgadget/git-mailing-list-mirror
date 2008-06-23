From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Re: Convert 'git blame' to parse_options()
Date: Mon, 23 Jun 2008 13:12:28 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0806231307070.2926@woody.linux-foundation.org>
References: <20080623082223.GA12130@artemis.madism.org> <alpine.DEB.1.00.0806231312130.6440@racer> <alpine.LFD.1.10.0806230912230.2926@woody.linux-foundation.org> <20080623164917.GA25474@sigill.intra.peff.net> <alpine.LFD.1.10.0806230953550.2926@woody.linux-foundation.org>
 <20080623171505.GB27265@sigill.intra.peff.net> <alpine.LFD.1.10.0806231027210.2926@woody.linux-foundation.org> <alpine.LFD.1.10.0806231114180.2926@woody.linux-foundation.org> <20080623183358.GA28941@sigill.intra.peff.net> <alpine.LFD.1.10.0806231137070.2926@woody.linux-foundation.org>
 <20080623195314.GA29569@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jun 23 22:14:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KAsQN-0002D2-FW
	for gcvg-git-2@gmane.org; Mon, 23 Jun 2008 22:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507AbYFWUND (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Jun 2008 16:13:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753062AbYFWUNB
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jun 2008 16:13:01 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:54951 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752798AbYFWUNA (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jun 2008 16:13:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NKCTpm002116
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 23 Jun 2008 13:12:30 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m5NKCSTU014014;
	Mon, 23 Jun 2008 13:12:28 -0700
In-Reply-To: <20080623195314.GA29569@sigill.intra.peff.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.845 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85916>



On Mon, 23 Jun 2008, Jeff King wrote:
> 
> I'm not so sure. I assumed that most of the callbacks would simply take
> a "struct rev_list". So you would end up in builtin-blame.c with:
> 
>   ...
>   OPT__REVISION(&my_rev_list),
>   ...
> 
> in your options table. And if setup_revisions takes options that affect
> things that _aren't_ in that struct, then they probably ought to be.

The world isn't like "it ought to be". It is like it is.

If you keep on dreaming about how things "ought to be", you'll never 
confront the things as they are. The fact is, turning the existing very 
simple argument parsers into using "parse_options()" is just _hard_.

Then you say that it all "ought to be" in those options already.

Sure. Do we have some invisible sky wizard to make it so? 

The thign is, parse_options() was introduced 8 months ago or so. Have you 
looked at the output of

	git grep 'str[n]*cmp.*"--'

lately? Yes, they probably all "ought to be" something or other, but as it 
is, the fact is that they are a damn pain to convert.

I tried to do just _one_ program. Trust me, I'm not going to even bother 
trying to do another unless parse_options() is made more palatable to do 
in small pieces. 

			Linus
