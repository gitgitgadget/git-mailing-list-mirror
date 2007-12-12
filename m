From: linux@horizon.com
Subject: Re: git-pull followed by git-gc often yields *much* bigger pack than git-pull alone
Date: 12 Dec 2007 16:53:03 -0500
Message-ID: <20071212215303.29921.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org, nix@esperi.org.uk
X-From: git-owner@vger.kernel.org Wed Dec 12 23:00:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2Zce-00014I-RX
	for gcvg-git-2@gmane.org; Wed, 12 Dec 2007 23:00:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751710AbXLLV7q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Dec 2007 16:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751634AbXLLV7q
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Dec 2007 16:59:46 -0500
Received: from science.horizon.com ([192.35.100.1]:18152 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751411AbXLLV7q (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Dec 2007 16:59:46 -0500
X-Greylist: delayed 401 seconds by postgrey-1.27 at vger.kernel.org; Wed, 12 Dec 2007 16:59:45 EST
Received: (qmail 29922 invoked by uid 1000); 12 Dec 2007 16:53:03 -0500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68103>

Pre-gc:
> -r--r--r-- 1 compiler hackers   12080 2007-12-12 20:35 pack-f534c957f3ee7f3f1046dee0081fcc315d9698bb.idx
> -r--r--r-- 1 compiler hackers  678643 2007-12-12 20:35 pack-f534c957f3ee7f3f1046dee0081fcc315d9698bb.pack

Post-gc:
> -r--r--r-- 1 compiler hackers   20912 2007-12-12 20:36 pack-5145ce9770077cee99795fc21cfcc6ea30eb6d47.idx
> -r--r--r-- 1 compiler hackers 1144055 2007-12-12 20:36 pack-5145ce9770077cee99795fc21cfcc6ea30eb6d47.pack

The fact that the index file has grown so much indicates that it's sucking in a bunch of
extra objects from the .keep pack, and you're seeing the duplication.

I'm not sure how that's happening, though.  I thought the --local flag to git-pack-objects told
it not to do that.
