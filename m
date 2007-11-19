From: Nicolas Pitre <nico@cam.org>
Subject: Re: [RFH] Flush progress message buffer in display().
Date: Mon, 19 Nov 2007 15:54:05 -0500 (EST)
Message-ID: <alpine.LFD.0.99999.0711191549510.19105@xanadu.home>
References: <200711192048.58864.johannes.sixt@telecom.at>
 <7voddqm0l7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 19 21:54:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IuDdg-0007rU-DC
	for gcvg-git-2@gmane.org; Mon, 19 Nov 2007 21:54:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751598AbXKSUyW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Nov 2007 15:54:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751596AbXKSUyW
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Nov 2007 15:54:22 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15061 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbXKSUyW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Nov 2007 15:54:22 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR005.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0JRR00KEUU26AYE0@VL-MO-MR005.ip.videotron.ca> for
 git@vger.kernel.org; Mon, 19 Nov 2007 15:54:07 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7voddqm0l7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 0.99999 (LFD 814 2007-11-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65499>

On Mon, 19 Nov 2007, Junio C Hamano wrote:

> Johannes Sixt <johannes.sixt@telecom.at> writes:
> 
> > I need this patch on Windows because appearently progress output is buffered
> > by stdio. Why doesn't Linux/glibc's stdio buffer output that goes to a pipe?
> > ...
> > ... What is flushing the progress
> > output?
> 
> The standard error stream is not "fully buffered":
> 
>     http://www.opengroup.org/onlinepubs/000095399/functions/xsh_chap02_05.html#tag_02_05
> 
> Not "fully buffered" means either "unbuffered" or "line
> buffered".  Because the progress display does not terminate its
> line, it means that the additional fflush(stderr) you added are
> needed if the stream is line buffered (still conforming).

Maybe stdio on Linux considers \r as a line termination.

Flushing stderr should not hurt anyway.


Nicolas
