From: Mike Hommey <mh@glandium.org>
Subject: Re: Help! My ISP blocks repo.or.cz. How to push changes?
Date: Mon, 12 Jan 2009 13:23:38 +0100
Organization: glandium.org
Message-ID: <20090112122337.GA7262@glandium.org>
References: <200901120246.28364.jnareb@gmail.com> <81b0412b0901120117mf010317m79874a235e29a439@mail.gmail.com> <200901121213.45858.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 12 13:25:37 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LMLrA-0008U7-3G
	for gcvg-git-2@gmane.org; Mon, 12 Jan 2009 13:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751343AbZALMYA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jan 2009 07:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbZALMYA
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jan 2009 07:24:00 -0500
Received: from vuizook.err.no ([85.19.221.46]:58723 "EHLO vuizook.err.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799AbZALMX7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jan 2009 07:23:59 -0500
Received: from cha92-13-88-165-248-19.fbx.proxad.net ([88.165.248.19] helo=vaio.glandium.org)
	by vuizook.err.no with esmtps (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <mh@glandium.org>)
	id 1LMLph-0004v0-Bg; Mon, 12 Jan 2009 13:23:56 +0100
Received: from mh by vaio.glandium.org with local (Exim 4.63)
	(envelope-from <mh@glandium.org>)
	id 1LMLpT-0004yt-4n; Mon, 12 Jan 2009 13:23:39 +0100
Content-Disposition: inline
In-Reply-To: <200901121213.45858.jnareb@gmail.com>
X-GPG-Fingerprint: A479 A824 265C B2A5 FC54  8D1E DE4B DA2C 54FD 2A58
User-Agent: Mutt/1.5.13 (2006-08-11)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mh@glandium.org
X-SA-Exim-Scanned: No (on vaio.glandium.org); SAEximRunCond expanded to false
X-Spam-Status: (score 1.4): No, score=1.4 required=5.0 tests=PLING_QUERY,RDNS_DYNAMIC autolearn=disabled version=3.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105335>

On Mon, Jan 12, 2009 at 12:13:44PM +0100, Jakub Narebski <jnareb@gmail.com> wrote:
> Alex Riesen wrote:
> > 2009/1/12 Jakub Narebski <jnareb@gmail.com>:
> 
> > > Do you have any suggestions to bypass this block for git? I have access
> > > to Linux shell account (no root access, though) which doesn't have
> > > problems with repo.or.cz, so I think I could set up SSH tunnel: but
> > > how? And what to do with access via git:// - move to SSH too?
> > 
> > See man ssh, look for -L. It works for arbitrary ports, so you can redirect
> > git:// port to anywhere. Same for push over ssh, just give another port when
> > connecting.
> 
> Currently I have the folowing in my ~/.ssh/config:
> 
>   # TP S.A. blocks repo.or.cz
>   Host repo.or.cz
> 	NoHostAuthenticationForLocalhost yes
> 	HostName localhost
> 	Port 2222
> 
> and I can simply use "git push repo" without any changes.
> But I have to run 
> 
>  $ ssh -f -N -L 2222:repo.or.cz:22 jnareb@host.example.com
> 
> first. Is there any way to automate this?

Something like the following should do the trick:
Host repo.or.cz
	ProxyCommand ssh jnareb@host.example.com nc %h %p

You will need nc (netcat) installed on the host.example.com server, though.

Mike
