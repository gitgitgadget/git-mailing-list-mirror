From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] upload-pack: squelch progress indicator if client does not request sideband
Date: Tue, 16 Jun 2009 11:57:49 -0700
Message-ID: <7vski0c8gi.fsf@alter.siamese.dyndns.org>
References: <200906142238.51725.j6t@kdbg.org>
	<7vprd4hito.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.00.0906161354010.16467@xanadu.home>
	<200906162041.16608.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Tue Jun 16 20:57:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MGdr4-0003iz-HI
	for gcvg-git-2@gmane.org; Tue, 16 Jun 2009 20:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759965AbZFPS5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2009 14:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752338AbZFPS5s
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jun 2009 14:57:48 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:51962 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751505AbZFPS5r (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2009 14:57:47 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090616185750.XBDA20976.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 16 Jun 2009 14:57:50 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo01.cox.net with bizsmtp
	id 4ixq1c0024aMwMQ03ixqJR; Tue, 16 Jun 2009 14:57:50 -0400
X-VR-Score: -200.00
X-Authority-Analysis: v=1.0 c=1 a=GCefh4Sw5xkA:10 a=A9qS8gIqAAAA:8
 a=nJMeUtDt4GbHdv4s5NwA:9 a=FddlTfmOBS9CzxDPQJ4A:7
 a=y1EvP51WC0ZiDUPDqXeDofZwoyEA:4 a=Kj4G0JfAssAA:10
X-CM-Score: 0.00
In-Reply-To: <200906162041.16608.j6t@kdbg.org> (Johannes Sixt's message of "Tue\, 16 Jun 2009 20\:41\:16 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121702>

Johannes Sixt <j6t@kdbg.org> writes:

> On Dienstag, 16. Juni 2009, Nicolas Pitre wrote:
> ...
>> I don't think it is worth it at all.  The regression is purely cosmetic,
>> and I suspect you'll have a really hard time finding someone still using
>> those ancient git clients anyway.  Remember that such clients are unable
>> to fetch with HTTP from repositories using version 2 of the pack index
>> by default already.  That's why we created version 1.4.4.5.
>
> Keep in mind that there could exist clients outside git.git that use modern
> pack-index or unpack-objects, but omit sideband support.
>
> I propose this patch instead, although the assumption that the --timeout
> option is only used by git-daemon may not be quite right. In this case it
> may be better to add a new option that sets the new flag and that
> git-daemon has to use.

Even though I tend to agree with Nico, this patch strikes a good balance
with a very small impact.  I am beginning to like it.

There _could_ be people who run fetch over git/ssh with custom --exec
option that has --timeout in it.  We _could_ teach --run-by-daemon option
to the (daemon, upload-pack) pair in the same release (because it is
reasonable to assume they come from the same vintage of git) to fix that
case.  But I do not think it is worth it.  As Nico says, this is purely
cosmetic.

Thanks.
