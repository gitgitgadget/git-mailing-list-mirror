From: "Eric S. Raymond" <esr@thyrsus.com>
Subject: Re: Millisecond precision in timestamps?
Date: Thu, 29 Nov 2012 14:02:05 -0500
Organization: Eric Conspiracy Secret Labs
Message-ID: <20121129190205.GA11629@thyrsus.com>
References: <20121128011750.GA23498@sigill.intra.peff.net>
 <7v7gp6i3rx.fsf@alter.siamese.dyndns.org>
 <CABYiQpmEpdf3L56NYSvPWovNOs_ifqj5QctuPSMoygHyMrz8+g@mail.gmail.com>
 <CAMP44s3MPMySnwjWjzo4aRX05u05xratgiyiYJUYPmnV2WK6kQ@mail.gmail.com>
 <CABYiQpnEZECU5Vj5JzMimtw-CAJQz2d=3rii4gM6d37wCnO5AA@mail.gmail.com>
 <E4C993F4-B7A4-4CB6-A9EA-BFE98BE3A381@gmail.com>
 <7va9u0sx26.fsf@alter.siamese.dyndns.org>
 <CAMP44s3ShoR7iR5QLYn_u+u_nNGnS1jumpt+iseWYKx0PX9UEA@mail.gmail.com>
 <20121129103847.GA9264@thyrsus.com>
 <7vtxs8qs1r.fsf@alter.siamese.dyndns.org>
Reply-To: esr@thyrsus.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Steven Michalske <smichalske@gmail.com>,
	Thomas Berg <merlin66b@gmail.com>, Jeff King <peff@peff.net>,
	Shawn Pearce <spearce@spearce.org>, git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Nov 29 20:02:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Te9Na-000538-42
	for gcvg-git-2@plane.gmane.org; Thu, 29 Nov 2012 20:02:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753328Ab2K2TCP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Nov 2012 14:02:15 -0500
Received: from static-71-162-243-5.phlapa.fios.verizon.net ([71.162.243.5]:54050
	"EHLO snark.thyrsus.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753051Ab2K2TCM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Nov 2012 14:02:12 -0500
Received: by snark.thyrsus.com (Postfix, from userid 1000)
	id 7AABD4065F; Thu, 29 Nov 2012 14:02:05 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vtxs8qs1r.fsf@alter.siamese.dyndns.org>
X-Eric-Conspiracy: There is no conspiracy
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210862>

Junio C Hamano <gitster@pobox.com>:
> That is exactly why I said it is all relative.  If it helps your
> application, you can weigh the pros-and-cons yourself and choose to
> throw "junk" extended header fields in the commit objects you
> create, using hash-object (or commit-tree).  You can read it out
> using cat-file and do whatever you want to do with it, and modern
> Git (v1.5.0 was from early 2007) and tools that are designed to work
> with Git know to ignore such "junk" field.

A good start.  But remember that reposurgeon's entire interface to the
git object level is through fast-export/fast-import.  I need import-
stream syntax for these.

bzr's syntax would do:

-------------------------------------------
mark :1
committer Eric S. Raymond <esr@thyrsus.com> 1289147634 -0500
data 14
First commit.

property branch-nick 12 bzr-testrepo
M 644 inline README
data 41
This is a test file in a dummy bzr repo.
-------------------------------------------

If we actually care about keys being full utf-8 with embedded whitespace
it should look more like this:

-------------------------------------------
mark :1
committer Eric S. Raymond <esr@thyrsus.com> 1289147634 -0500
data 14
First commit.

property 11
branch-nick
propval 12 
bzr-testrepo
M 644 inline README
data 41
This is a test file in a dummy bzr repo.
-------------------------------------------
-- 
		<a href="http://www.catb.org/~esr/">Eric S. Raymond</a>
