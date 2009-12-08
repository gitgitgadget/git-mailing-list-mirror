From: James Vega <vega.james@gmail.com>
Subject: Re: git-apply fails on creating a new file, with both -p and
 --directory specified
Date: Mon, 7 Dec 2009 22:39:31 -0500
Message-ID: <20091208033931.GK14401@jamessan.com>
References: <20091123194523.GZ15966@cl.cam.ac.uk>
 <7vws1e3ma1.fsf@alter.siamese.dyndns.org>
 <loom.20091207T222449-752@post.gmane.org>
 <7vk4wyqigf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 08 04:39:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHqvK-00051M-Pn
	for gcvg-git-2@lo.gmane.org; Tue, 08 Dec 2009 04:39:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933750AbZLHDj1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Dec 2009 22:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932739AbZLHDj1
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Dec 2009 22:39:27 -0500
Received: from qmta10.emeryville.ca.mail.comcast.net ([76.96.30.17]:38562 "EHLO
	QMTA10.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932282AbZLHDj1 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Dec 2009 22:39:27 -0500
Received: from OMTA05.emeryville.ca.mail.comcast.net ([76.96.30.43])
	by QMTA10.emeryville.ca.mail.comcast.net with comcast
	id ESqy1d0050vp7WLAATfaBF; Tue, 08 Dec 2009 03:39:34 +0000
Received: from debil.jamessan.com ([98.216.49.10])
	by OMTA05.emeryville.ca.mail.comcast.net with comcast
	id ETfY1d00C0DBqmy8RTfZDi; Tue, 08 Dec 2009 03:39:34 +0000
Received: by debil.jamessan.com (Postfix, from userid 1000)
	id 5BB5CA1AFA; Mon,  7 Dec 2009 22:39:31 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vk4wyqigf.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134813>

On Mon, Dec 07, 2009 at 06:59:28PM -0800, Junio C Hamano wrote:
> James Vega <vega.james@gmail.com> writes:
> 
> > It looks like this may have introduced a bug when staging a file
> > removal.  Here's an example git session showing the issue:
> > <<snipped>>
> 
> Thanks for a report, but I cannot get the evidence that the said patch has
> anything to do with the issue you illustrated.

Right, I incorrectly assumed the problem was with git-apply when I saw
Steve's patch since the symptoms seemed similar.

I just finished a bisect, though, and the problem is in removing a
non-empty file with "git add -p".  This wasn't caught by existing tests
because they only try to remove an empty file.

This was introduced in

8f0bef6 (git-apply--interactive: Refactor patch mode code, 2009-08-13)

-- 
James
GPG Key: 1024D/61326D40 2003-09-02 James Vega <vega.james@gmail.com>
