From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH v2 2/2] pack-objects: don't loosen objects available in
 alternate or kept packs
Date: Sun, 22 Mar 2009 15:23:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0903221522341.30483@xanadu.home>
References: <ee63ef30903211526n47c40052mc40dc018f25c99fd@mail.gmail.com>
 <7vbpru9nh9.fsf@gitster.siamese.dyndns.org>
 <7viqm15qda.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Brandon Casey <drafnel@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 22 20:26:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LlTI8-0007uV-Ke
	for gcvg-git-2@gmane.org; Sun, 22 Mar 2009 20:25:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754513AbZCVTXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2009 15:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753011AbZCVTXf
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Mar 2009 15:23:35 -0400
Received: from relais.videotron.ca ([24.201.245.36]:47290 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752373AbZCVTXe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2009 15:23:34 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KGX00GJU9V3T840@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Sun, 22 Mar 2009 15:23:27 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <7viqm15qda.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114166>

On Sun, 22 Mar 2009, Junio C Hamano wrote:

> If you allow (last_found == NULL), the loop iterates over packed_git list,
> and when it has its last element in p after discovering nothing matches
> the criteria, this happens:
> 
> 	if (p == last_found) /* false, p is the last element on the list */
>         	p = packed_git; /* not taken */
> 	else
>         	p = p->next; /* taken, p == NULL now */
> 	if (p == last_found) /* true! */
> 		p = p->next; /* OOPS */

Yeah, you got it.  Now I remember.


Nicolas
