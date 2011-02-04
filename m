From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Q: does index-pack work in place on windows?
Date: Thu, 03 Feb 2011 21:45:57 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1102032137230.12104@xanadu.home>
References: <7v39o6xk5q.fsf@alter.siamese.dyndns.org>
 <AANLkTi=m+kERSH7TJFjuRaUfA7FR03zwNn2PKFxrqiOp@mail.gmail.com>
 <alpine.LFD.2.00.1102030026430.12104@xanadu.home>
 <7vk4hhwpfb.fsf@alter.siamese.dyndns.org>
 <alpine.LFD.2.00.1102031958000.12104@xanadu.home>
 <7v1v3ozhij.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Erik Faye-Lund <kusmabite@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 04 03:46:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PlBgR-0005VA-SM
	for gcvg-git-2@lo.gmane.org; Fri, 04 Feb 2011 03:46:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754214Ab1BDCp6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Feb 2011 21:45:58 -0500
Received: from relais.videotron.ca ([24.201.245.36]:63991 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752420Ab1BDCp5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Feb 2011 21:45:57 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LG2003WUNNXGA00@vl-mh-mrz21.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 03 Feb 2011 21:45:33 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7v1v3ozhij.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166020>

On Thu, 3 Feb 2011, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > However index-pack won't tell you what is broken in the pack when 
> > corruptions are to be found.
> 
> Yes, but at that point, you are pretty much lost anyway, as the only thing
> you can do to salvage salvageable parts of the broken pack, if you still
> trust its associated .idx file, is to walk the table of contents and ask
> for each individual object; knowing where the .pack or .idx is broken with
> the current verify-pack does not help you very much.

Well... given that you do have to compare both the generated index and 
the on-disk index at some point, it is then possible to identify 
corrupted objects and their location.  And with pack index version 2 
including a CRC for the packed data, you should be able to tell if the 
corruption is actually in the pack or in the index (or both if the final 
pack/index SHA1 sum doesn't match).


Nicolas
