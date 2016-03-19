From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: Re: parse-options does not recognize "unspecified" behavior
Date: Sat, 19 Mar 2016 12:25:35 +0100
Message-ID: <1458386735-8038-1-git-send-email-szeder@ira.uka.de>
References: <20160317014310.GA12830@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>,
	Stefan Beller <sbeller@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Pranit Bauva <pranit.bauva@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 19 12:28:55 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ahF3s-0005ze-83
	for gcvg-git-2@plane.gmane.org; Sat, 19 Mar 2016 12:28:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754064AbcCSL0I convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 19 Mar 2016 07:26:08 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:35501 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753827AbcCSL0G (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Mar 2016 07:26:06 -0400
Received: from x4db28c3d.dyn.telefonica.de ([77.178.140.61] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1ahF14-0007Gl-1a; Sat, 19 Mar 2016 12:25:59 +0100
X-Mailer: git-send-email 2.8.0.rc2.45.g196ad62
In-Reply-To: <20160317014310.GA12830@sigill.intra.peff.net>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1458386759.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289303>

> Yes, I think in general, "-v" and "-q" should work as opposites. But
> that is not the case with commit, where "-v" and "-q" operate on tota=
lly
> separate messages. I think that is a UX mistake, and we would not do
> it that way if designing from scratch. But we're stuck with it for
> historical reasons (I'd probably name "--verbose" as "--show-diff" or
> something if writing it today).

Yeah, as a long-time 'git commit -v' user I never really thought about
the name of the option, but when I pointed out the multiple verbose
levels it struck me as a rather unfortunate name for this feature,
too.  Oh, well, we are stuck with it indeed.

However, that doesn't mean that we have to spread this badly chosen
name from options to config variables, does it?  I think that if we
are going to define a new config variable today, then it should be
named properly, and it's better not to call it 'commit.verbose', but
'commit.showDiff' or something.  Perhaps we could even define two new
config variables: 'commit.showDiff' for the diff of the changes to be
committed (=3D '-v'), and 'commit.showUnstagedDiff' for the - wait for
it! - unstaged changes (=3D '-v -v').  Not sure about the variable
names, though, because "plain" 'git diff' shows unstaged changes,
while 'git diff --cached' shows staged changes.

=46urthermore, it doesn't mean that we can't add properly named command
line option(s) and state that '-v|--verbose' is a synonym to
'--show-diff' (maybe even deprecate '--verbose'), but I don't want to
squeeze even more into a GSOC micro project.


G=C3=A1bor
