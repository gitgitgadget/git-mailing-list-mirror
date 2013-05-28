From: Matthijs Kooijman <matthijs@stdin.nl>
Subject: Re: [PATCH] git clone depth of 0 not possible.
Date: Tue, 28 May 2013 18:34:17 +0200
Message-ID: <20130528163416.GK25742@login.drsnuggles.stderr.nl>
References: <1357581996-17505-1-git-send-email-stefanbeller@googlemail.com>
 <20130108062811.GA3131@elie.Belkin>
 <7vip78go6b.fsf@alter.siamese.dyndns.org>
 <CACsJy8D9+KHT=YfU0+rPCbs+AwxQOpfKzPChDhk8d-MMkRzZug@mail.gmail.com>
 <7vvcb8f6aw.fsf@alter.siamese.dyndns.org>
 <20130528091812.GG25742@login.drsnuggles.stderr.nl>
 <CAFzf2Xx2mMO5XJ8n1UsUMMpDvi+KMUt9DpRe80X4zpG=THxSPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 18:34:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhMrA-00054Z-1Y
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 18:34:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934762Ab3E1Qeg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 12:34:36 -0400
Received: from drsnuggles.stderr.nl ([94.142.244.14]:50054 "EHLO
	drsnuggles.stderr.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934692Ab3E1Qef (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 12:34:35 -0400
Received: from login.drsnuggles.stderr.nl ([10.42.0.9] ident=mail)
	by mail.drsnuggles.stderr.nl with smtp (Exim 4.69)
	(envelope-from <matthijs@stdin.nl>)
	id 1UhMqn-0003Da-QH; Tue, 28 May 2013 18:34:18 +0200
Received: (nullmailer pid 12367 invoked by uid 1000);
	Tue, 28 May 2013 16:34:17 -0000
Mail-Followup-To: Matthijs Kooijman <matthijs@stdin.nl>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Duy Nguyen <pclouds@gmail.com>,
	Stefan Beller <stefanbeller@googlemail.com>,
	schlotter@users.sourceforge.net, Ralf.Wildenhues@gmx.de,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <CAFzf2Xx2mMO5XJ8n1UsUMMpDvi+KMUt9DpRe80X4zpG=THxSPw@mail.gmail.com>
X-PGP-Fingerprint: 7F6A 9F44 2820 18E2 18DE  24AA CF49 D0E6 8A2F AFBC
X-PGP-Key: http://www.stderr.nl/static/files/gpg_pubkey.asc
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Spam-Score: -2.6 (--)
X-Spam-Report: Spamchecked on "mail.drsnuggles.stderr.nl"
	pts  rule name              description
	---- ---------------------- -------------------------------------------
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225660>

Hi Jonathan,

> > Did you consider how to implement this? Looking at the code, it seems
> > the "deepen" parameter in the wire protocol now means:
> >  - 0: Do not change anything about the shallowness (i.e., fetch
> >    everything from the shallow root to the tip).
> >  - > 0: Create new shallow commits at depth commits below the tip (so
> >    depth == 1 means tip and one below).
> >  - INFINITE_DEPTH (0x7fffffff): Remove all shallowness and fetch
> >    complete history.
> >
> > Given this, I'm not sure how one can express "fetch the tip and nothing
> > below that", since depth == 0 already has a different meaning.
> 
> If I remember correctly, what we discussed is just changing the
> protocol to "5 means a depth of 5".

The mail from Junio I replied to said:
> >> As long as we do not change the meaning of the "shallow" count
> >> going over the wire

Which seems to conflict with your suggestion. Or are the "shallow count"
and the "depth" different things?

> The client already trusts what the server provides.
In other words: we won't break existing clients if we suddenly send back
one less commit than before, since the client just sends over what it
wants and then assumes that whatever it gets back is really what it
wanted?

Gr.

Matthijs
