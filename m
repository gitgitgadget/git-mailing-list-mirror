From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [PATCH 1/3] Lazily open pack index files on demand
Date: Mon, 28 May 2007 19:40:37 +0200
Message-ID: <20070528174037.GA1118@diana.vm.bytemark.co.uk>
References: <20070526052419.GA11957@spearce.org> <7vabvsm1h8.fsf@assigned-by-dhcp.cox.net> <56b7f5510705261031o311b89bapd730374cbc063931@mail.gmail.com> <20070527033429.GY28023@spearce.org> <alpine.LFD.0.99.0705271110550.3366@xanadu.home> <20070527215245.GD28023@spearce.org> <alpine.LFD.0.99.0705271929480.3366@xanadu.home> <alpine.LFD.0.98.0705280907290.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon May 28 18:43:33 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsiJf-0000Yt-O9
	for gcvg-git@gmane.org; Mon, 28 May 2007 18:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762748AbXE1QnT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 28 May 2007 12:43:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762804AbXE1QnT
	(ORCPT <rfc822;git-outgoing>); Mon, 28 May 2007 12:43:19 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2237 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1762748AbXE1QnR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 May 2007 12:43:17 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1HsjCv-0000ML-00; Mon, 28 May 2007 18:40:37 +0100
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dana How <danahow@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.98.0705280907290.26602@woody.linux-foundation.org>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48625>

On 2007-05-28 09:22:02 -0700, Linus Torvalds wrote:

> Secondly, the cost of Newton isn't "almost O(1)". I don't know
> _what_ it is (the rule of thumb with Newton-Raphson should be that
> the number of significant correct digits in the answer doubles with
> each iteration: I think that probably means that it should
> approximate O(loglog(n)), but I haven't thought deeply about it.

With binary search, the number of correct bits in the index increases
by 1 for each iteration. With Newton iteration, the number of correct
bits doubles for each iteration. So the number of Newton iteration
should be the log of the number of binary search iterations, i.e. log
log n like you say.

But for non-astronomical values of n, I agree that this kind of big-O
analysis is much inferior to benchmarking.

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
