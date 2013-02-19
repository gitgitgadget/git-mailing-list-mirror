From: Thomas Rast <trast@inf.ethz.ch>
Subject: Re: Google Summer of Code 2013 (GSoC13)
Date: Tue, 19 Feb 2013 17:39:44 +0100
Message-ID: <871uccs1f3.fsf@pctrast.inf.ethz.ch>
References: <87ehgd1qq2.fsf@pctrast.inf.ethz.ch>
	<20130218174239.GB22832@sigill.intra.peff.net>
	<CALkWK0nDEwgDwnVktmM8abv3ZgQmJCOm8LBe25UKR485PZMPfA@mail.gmail.com>
	<7vip5p9rtm.fsf@alter.siamese.dyndns.org>
	<CALkWK0=s4XX0mmUTAcNBHyqdrryhMYvhtrNZCFFccJJBUUVdUg@mail.gmail.com>
	<20130219072512.GI19757@elie.Belkin>
	<CALkWK0nnkfrHi-0=c-bXdBHaOeBsCdccZDJZX5LDs0dT=SsReg@mail.gmail.com>
	<874nh8vgoo.fsf@pctrast.inf.ethz.ch>
	<7vtxp86zcs.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>, Jeff King <peff@peff.net>,
	<git@vger.kernel.org>, Shawn Pearce <spearce@spearce.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	Paul Mackerras <paulus@samba.org>,
	Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	Thomas Gummerer <t.gummerer@gmail.com>,
	David Barr <b@rr-dav.id.au>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 17:40:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U7qEm-000490-A1
	for gcvg-git-2@plane.gmane.org; Tue, 19 Feb 2013 17:40:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932744Ab3BSQjs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2013 11:39:48 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:16809 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758438Ab3BSQjr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2013 11:39:47 -0500
Received: from CAS20.d.ethz.ch (172.31.51.110) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Tue, 19 Feb
 2013 17:39:42 +0100
Received: from pctrast.inf.ethz.ch.ethz.ch (129.132.153.233) by
 CAS20.d.ethz.ch (172.31.51.110) with Microsoft SMTP Server (TLS) id
 14.2.298.4; Tue, 19 Feb 2013 17:39:44 +0100
In-Reply-To: <7vtxp86zcs.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Tue, 19 Feb 2013 08:29:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216632>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <trast@inf.ethz.ch> writes:
>
>> In defense of Thomas, whose project was mentioned earlier as a prime
>> example of something that is "too big":
>>
>> He's in fact still working on the index-API angle, as part of a thesis
>> at university.
>
> That is probably a good indicator that it was too big for a summer
> student.  It also is good to hear that the topic is being looked at
> ;-).

Not really: the API angle was never part of the proposal.  The timeline
was [1 if you have access]:

  24/04 - 01/05: Document the new index format.
  02/05 - 11/05: Create a converter of the old index format to the new format.
  12/05 - 18/06: Parse the index from disk to the current in-memory format. The
  old index format shall still be readable.
  19/06 - 09/07: Implement the re-reading of a single record, if the crc32 doesn't
  match (Meaning the record has been changed under the reader).
  10/07 - 21/07:  Map the current internal structure to the new index format.
  22/07 - 31/07: Change the current in-memory structure to keep track of the
  changed files.
  01/08 - 13/08: Write the index to disk in both the old and the new format
  depending on the choice of the user and make sure only the changed parts are
  really written to disk in the new format.
  11/08 - 13/08: Test the new index and profile the gains compared to the old
  format.
  /* Development work will be a bit slower from 18/06 to 21/07 because at my
   * University there are exams in this period. I probably will only be able to
   * work half the hours. I'll be back up to full speed after that. */

I think this case is somewhat symptomatic for one possible cause of
dragged-out non-inclusions _after_ GSoC: there's a certain scope creep
caused by striving for the perfect, long-term maintainable code.

The solution IMHO is to _both_ recognize such possibilities for scope
creep, and cut down the proposals to a size where a student has a
reasonable chance of achieving the code quality required for inclusion.

(The latter option has been mentioned a few times, but I wanted to make
people aware that the scope creep is happening, too.)


Footnotes: 
[1]  http://www.google-melange.com/gsoc/proposal/review/google/gsoc2012/tgummerer/1

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
