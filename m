From: Mike Hommey <mh@glandium.org>
Subject: Re: remote-helpers and refs without a value
Date: Mon, 28 Mar 2011 09:50:09 +0200
Message-ID: <20110328075009.GA5115@glandium.org>
References: <20110327082428.GA4428@glandium.org>
 <AANLkTi=cNin=XYqbAJMggWj7OcZ8=9PGCVGGg=JRO-bj@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 28 09:50:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q47DU-0000CX-4e
	for gcvg-git-2@lo.gmane.org; Mon, 28 Mar 2011 09:50:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752974Ab1C1HuR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Mar 2011 03:50:17 -0400
Received: from vuizook.err.no ([85.19.221.46]:48418 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751347Ab1C1HuQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Mar 2011 03:50:16 -0400
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=glandium.org)
	by vuizook.err.no with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.72)
	(envelope-from <mh@glandium.org>)
	id 1Q47DG-0002OF-8x; Mon, 28 Mar 2011 09:50:11 +0200
Received: from mh by glandium.org with local (Exim 4.74)
	(envelope-from <mh@glandium.org>)
	id 1Q47DF-0001LV-BP; Mon, 28 Mar 2011 09:50:09 +0200
Content-Disposition: inline
In-Reply-To: <AANLkTi=cNin=XYqbAJMggWj7OcZ8=9PGCVGGg=JRO-bj@mail.gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: (score 0.4): No, score=0.4 required=5.0 tests=RDNS_DYNAMIC autolearn=disabled version=3.3.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170109>

On Mon, Mar 28, 2011 at 03:22:57PM +0800, Tay Ray Chuan wrote:
> Hi,
> 
> On Sun, Mar 27, 2011 at 4:24 PM, Mike Hommey <mh@glandium.org> wrote:
> > But when the helper returns a '?' value to the list command, I don't see
> > how things are supposed to be updated. It looks like the helper is
> > the only one, then, to be able to update the refs. But it also doesn't
> > have any way to know which refs it needs to update...
> 
> I don't think that's right. The transport machinery (transport.c,
> transport-helper.c) in git is the one who calls the shots - the
> transport machinery first 1) asks for the list of refs, 2) does the
> appropriate "matching" (of what refs to fetch/push), then 3) sends
> this down to the remote helper.
> 
> If the remote helper sends back a '?', the transport machinery should
> be implemented to fail and die. A quick scan of transport.c does not
> show this, but I assume the failure would happen at the ref matching
> level, leading to failure of the whole fetch/push.

Failing wouldn't make sense. That'd mean '?' may not be used by
remote-helpers, and that they'd need to grab everything from the remote
before git even decides what to grab.

Mike
