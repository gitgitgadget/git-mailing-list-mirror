From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: [PATCH v6 17/19] fsck: Introduce `git fsck --quick`
Date: Sun, 21 Jun 2015 01:09:47 -0400
Message-ID: <000201d0abe0$7f3ccf20$7db66d60$@nexbridge.com>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>	<cover.1434720655.git.johannes.schindelin@gmx.de>	<5f1c4c16027b00ef80490d67bec5e948481153ec.1434720655.git.johannes.schindelin@gmx.de>	<xmqq1th77829.fsf@gitster.dls.corp.google.com>	<95e42f21de69ab5299c03ce6ad107037@www.dscho.org> <xmqqoakb5sk2.fsf@gitster.dls.corp.google.com> <558643CA.6000303@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <peff@peff.net>
To: "'Michael Haggerty'" <mhagger@alum.mit.edu>,
	"'Junio C Hamano'" <gitster@pobox.com>,
	"'Johannes Schindelin'" <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jun 21 07:10:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6XWD-0001Wm-Om
	for gcvg-git-2@plane.gmane.org; Sun, 21 Jun 2015 07:10:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752043AbbFUFKF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Jun 2015 01:10:05 -0400
Received: from elephants.elehost.com ([216.66.27.132]:46788 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751143AbbFUFKD (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Jun 2015 01:10:03 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t5L59n0V077721
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 21 Jun 2015 01:09:49 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <558643CA.6000303@alum.mit.edu>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQJdUr2vRmNZi1cYzJCRB++UewVwtQKEUEVvAbz3BUEB6yXCwgIM+jIUAqrE/2IAeH1T95xCNEJQ
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272251>

On June 21, 2015 12:56 AM, Michael Haggerty wrote:
> On 06/19/2015 10:53 PM, Junio C Hamano wrote:
> > Johannes Schindelin <johannes.schindelin@gmx.de> writes:
> >
> >> Can you think of a name for the option that is as short as `--quick`
> >> but means the same as `--connectivity-only`?
> >
> > No I can't.  I think `--connectivity-only` is a very good name that is
> > unfortunately a mouthful, I agree that we need a name that is as short
> > as `--xxxxx` that means the same as `--connectivity-only`.  I do not
> > think `--quick` is that word; it does not mean such a thing.
> 
> `--connectivity-only` says that "of all the things that fsck can do, skip
everything
> except for the connectivity check". But the switch really affects not the
> connectivity part of the checks (that part is done in either case), but
the blob
> part. So, if we ignore the length of the option name for a moment, it
seems like
> the options should be something like
`--check-blob-integrity`/`--no-check-blob-
> integrity`. The default would remain `--check-blob-integrity` of course,
but
> 
> * Someday there might be a config setting that people can use to change
the
> default behavior of fsck to `--no-check-blob-integrity`.
> * Someday there might be other expensive types of checks [1] that we want
to
> turn on/off independent of blob integrity checks.
> 
> But now that I'm writing this, a silly question occurs to me: Do we need
an
> overall option like this at all? If I demote all blob-integrity checks to
"ignore"
> via the mechanism that you have added, then shouldn't fsck automatically
> detect that it doesn't have to open the blobs at all and enable this
speedup
> automatically? So maybe `--(no-)?check-blob-integrity` is actually a
shorthand
> for turning a few more specific checks on/off at once.
> 
> As for thinking of a shorter name for the option: assuming the blob
integrity
> checks can be turned on and off independently as described above, then I
think
> it is reasonable to *also* add a `--quick` option defined as
> 
> --quick: Skip some expensive checks, dramatically reducing the
>     runtime of `git fsck`. Currently this is equivalent to
>     `--no-check-blob-integrity`.
> 
> In the future if we invent other expensive checks we might also add them
to the
> list of things that are skipped by `--quick`.

Synonym suggestions: --links or --relations
I was going to include --refs but that may be ambiguous. Links also has
meaning so it's probably out and --hitch may just be silly and needlessly
introducing a new term.

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.
