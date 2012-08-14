From: Charles Bailey <charles@hashpling.org>
Subject: Re: What should mergetool do with --no-prompt?
Date: Tue, 14 Aug 2012 18:09:00 +0100
Message-ID: <20120814170900.GA28978@hashpling.org>
References: <CAJDDKr5TK910n603jcmoq6WoaLL9DX9hgwF3Y+MmjngMpAXPQw@mail.gmail.com>
 <20120814071823.GA21031@hashpling.org>
 <7vehn98qcv.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Aguilar <davvid@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Tim Henigan <tim.henigan@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 14 19:09:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T1KcB-0005b3-0D
	for gcvg-git-2@plane.gmane.org; Tue, 14 Aug 2012 19:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083Ab2HNRJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Aug 2012 13:09:05 -0400
Received: from avasout05.plus.net ([84.93.230.250]:59670 "EHLO
	avasout05.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753594Ab2HNRJE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Aug 2012 13:09:04 -0400
Received: from hashpling.plus.com ([212.159.69.125])
	by avasout05 with smtp
	id mh901j00A2iA9hg01h914D; Tue, 14 Aug 2012 18:09:02 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.0 cv=FYC1NeC6 c=1 sm=1 a=wpJ/2au8Z6V/NgdivHIBow==:17
 a=-GleFfVwiy8A:10 a=wh2Od-te4LEA:10 a=mSBy96HJJ2wA:10 a=BHUvooL90DcA:10
 a=kj9zAlcOel0A:10 a=Ew9TdX-QAAAA:8 a=6Fi1yIpwmqJ6oRqFAhYA:9 a=CjuIK1q_8ugA:10
 a=wpJ/2au8Z6V/NgdivHIBow==:117
Received: from charles by hashpling.plus.com with local (Exim 4.72)
	(envelope-from <charles@hashpling.org>)
	id 1T1Kc0-0007jG-ST; Tue, 14 Aug 2012 18:09:00 +0100
Content-Disposition: inline
In-Reply-To: <7vehn98qcv.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-08-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203416>

On Tue, Aug 14, 2012 at 08:06:56AM -0700, Junio C Hamano wrote:
> 
> Could it be that the calling user or script does not even have a
> terminal but still can spawn the chosen mergetool backend and
> interact with the user via its GUI?  Or it may have a terminal that
> is hard for the user to interact with, and the prompt and "read ans"
> may get stuck.

It could be, although this certainly wasn't considered in the original
design. I know that we removed explicit references to /dev/tty and
replaced them with exec n>&m juggling which made things generally more
robust and allowed some basic shell tests to work more reliably. I
don't object to handling non-interactive mode better but it feels
unsatisfactory to only be able to resolve some types of conflict and
have to skip others.

> In such an environment, the ideal behaviour for the "git mergetool"
> frontend may be not to interact via the terminal at all and instead
> run its interaction to choose the resolution using a matching GUI
> interface.  I see when "read ans" fails (e.g. the standard input to
> the mergetool is closed), resolve_{symlink,deleted}_merge will not
> get stuck but instead fail, so perhaps David's issue could be solved
> by running "git mergetool --tool=... </dev/null" or something?

To be honest, I wasn't sure what David's issue was, other than "I
spotted this could/should it be fixed?". Is it a real world issue?

Charles.
