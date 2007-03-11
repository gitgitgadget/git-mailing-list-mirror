From: "Jon Smirl" <jonsmirl@gmail.com>
Subject: A tracking tree for the active work space
Date: Sun, 11 Mar 2007 10:06:11 -0400
Message-ID: <9e4733910703110706m14abae25r2a965b644d8c3bbb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "Shawn O. Pearce" <spearce@spearce.org>,
	"Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 11 15:06:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HQOgk-0001Qo-Bp
	for gcvg-git@gmane.org; Sun, 11 Mar 2007 15:06:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933634AbXCKOGP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Mar 2007 10:06:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933635AbXCKOGP
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Mar 2007 10:06:15 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:30926 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933634AbXCKOGN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Mar 2007 10:06:13 -0400
Received: by ug-out-1314.google.com with SMTP id 44so1906247uga
        for <git@vger.kernel.org>; Sun, 11 Mar 2007 07:06:12 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=PE6ne0v0bOQt1OKtqlRtWhwz99DxPAZ0WKZyGbSf/LPwowAhZl/u2W3A6o8qlk54TIfK9q1ftACd1Ded1RXefRiSTUJFLJeL2ZOrvpU1o78XWZYc3UkJ6RysnuLbszYv0ToSfeH/U6NvFlVonRfET5KBNBQ2RHcg6qcmkapnoMI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=NAR2VXF2K5zJ70t/ERhJLEBgaNCKXA8czMXa8z7FUCbXKQnTg2Fn9+Mc1HHMRVjvXQ3C4btPwqKUIPMgX6+wNK2tDzwj47ciVxuUPnBHzzdTRF440QbKtggEnh2OQtaUqkzO54t79wqE2isr0HX8OvMq4f+fwHM4qImogNsgKRE=
Received: by 10.114.208.8 with SMTP id f8mr811728wag.1173621971584;
        Sun, 11 Mar 2007 07:06:11 -0700 (PDT)
Received: by 10.114.194.9 with HTTP; Sun, 11 Mar 2007 07:06:11 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41926>

Reading the other thread on tracking temporary changes made me think
of using inotify with git. The basic idea would be to a daemon running
that uses inotify to listen for changes in the working tree. As these
changes happen they get committed to a tracking tree.

The tracking tree serves two purposes. First it is a good way to
recover from programmer error. I have definitely written big chunks of
code, discarded them, and then realized later that they were the right
solution and had to write them again.

The tracking tree also makes a 'git grep' for uncommitted changes
easier to implement since the changes are always committed with this
model. For dual processors the inverted index can be computed in
parallel with editing.

Of course this daemon needs some smarts. You don't want it generating
a delta the hard way from a git check out of a different workspace It
will also make real check-ins instant since you  just copy the tip of
the tacking tree.


-- 
Jon Smirl
jonsmirl@gmail.com
