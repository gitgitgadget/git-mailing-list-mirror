From: "Jason Pyeron" <jpyeron@pdinc.us>
Subject: RE: Tackling Git Limitations with Singular Large Line-seperated Plaintext files
Date: Fri, 27 Jun 2014 15:55:59 -0400
Organization: PD Inc
Message-ID: <57F015EB50E54211BF29FE1F6DE05CF4@black>
References: <CAJoVafc1LMxmvCiWci3N+AuAZBsABR3Wb3c6c3stw93OJZ7Scw@mail.gmail.com><CAJo=hJtJCy96SRYmOxEpEMoEVcaegv0SCG0_AH2u0=bSrHZi_A@mail.gmail.com><xmqqegya2qgu.fsf@gitster.dls.corp.google.com> <CA+55aFx6vFyZvpyQot_3Ym7wsCZ06abjNx_hEKkza-N856jMnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "'Shawn Pearce'" <spearce@spearce.org>,
	"'Jarrad Hope'" <me@jarradhope.com>, "'git'" <git@vger.kernel.org>
To: "'Linus Torvalds'" <torvalds@linux-foundation.org>,
	"'Junio C Hamano'" <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jun 27 21:55:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0cFL-00050e-P5
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 21:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbaF0Tzk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 15:55:40 -0400
Received: from mail.pdinc.us ([67.90.184.27]:42008 "EHLO mail.pdinc.us"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751065AbaF0Tzj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 15:55:39 -0400
Received: from black (nsa1.pdinc.us [67.90.184.2])
	(authenticated bits=0)
	by mail.pdinc.us (8.12.11.20060308/8.12.11) with ESMTP id s5RJtYK3004333;
	Fri, 27 Jun 2014 15:55:34 -0400
X-Mailer: Microsoft Office Outlook 11
Thread-Index: Ac+SP2+a6FpgK9LaSmyR/LQje+81IAAATI3w
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.4913
In-Reply-To: <CA+55aFx6vFyZvpyQot_3Ym7wsCZ06abjNx_hEKkza-N856jMnw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252577>

> -----Original Message-----
> From: Linus Torvalds
> Sent: Friday, June 27, 2014 15:39
> 
> On Fri, Jun 27, 2014 at 10:48 AM, Junio C Hamano 
> <gitster@pobox.com> wrote:
> >
> > Even though the original question mentioned "delta discovery", I
> > think what was being asked is not "delta" in the Git sense (which
> > your answer is about) but is "can we diff two long sequences of text
> > (that happens to consist of only 4-letter alphabet but that is a
> > irrelevant detail) without holding both in-core in their entirety?",
> > which is a more relevant question/desire from the application point
> > of view.
> 
> .. even there, there's another issue. With enough memory, the diff
> itself should be fairly reasonable to do, but we do not have any sane
> *format* for diffing those kinds of things.
> 
> The regular textual diff is line-based, and is not amenable to
> comparing two long lines. You'll just get a diff that says "the two
> really long lines are different".
> 
> The binary diff option should work, but it is a horrible output
> format, and not very helpful. It contains all the relevant data ("copy
> this chunk from here to here"), but it's then shown in a binary
> encoding that isn't really all that useful if you want to say "what
> are the differences between these two chromosomes".
> 
> I think it might be possible to just specify a special diff algorithm
> (git already supports that, obviously), and just introduce a new "use
> binary diffs with a textual representation" model.
> 
> But it also sounds like there might be some actual performance problem
> with these 1GB file delta-calculations. Which I wouldn't be surprised
> about at all.
> 
> Jarrad - is there any public data you could give as an example and for
> people to play with?

Until Jarrad replies see sample here:
http://www.genomatix.de/online_help/help/sequence_formats.html

The issue will be, if we talk about changes other than same length substitutions
(e.g. Down's Syndrome where it has an insertion of code) would require one code
per line for the diffs to work nicely.

-Jason

--
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
-                                                               -
- Jason Pyeron                      PD Inc. http://www.pdinc.us -
- Principal Consultant              10 West 24th Street #100    -
- +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
-                                                               -
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
This message is copyright PD Inc, subject to license 20080407P00.
