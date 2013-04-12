From: Mike Galbraith <bitbucket@online.de>
Subject: Re: regression: "96b9e0e3 config: treat user and xdg config
 permission problems as errors" busted git-daemon
Date: Fri, 12 Apr 2013 07:46:25 +0200
Message-ID: <1365745585.4539.18.camel@marge.simpson.net>
References: <20130411181103.GJ27070@google.com>
	 <20130411181439.GA2820@sigill.intra.peff.net>
	 <7vwqs8hmh1.fsf@alter.siamese.dyndns.org>
	 <20130411200330.GA15667@odin.tremily.us>
	 <7vip3shfpd.fsf@alter.siamese.dyndns.org>
	 <20130411222301.GA11283@sigill.intra.peff.net>
	 <20130412005748.GA17116@odin.tremily.us>
	 <7vvc7sfkwn.fsf@alter.siamese.dyndns.org>
	 <20130412043501.GA12942@sigill.intra.peff.net>
	 <7vr4igfj9w.fsf@alter.siamese.dyndns.org>
	 <20130412050550.GA15724@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	"W. Trevor King" <wking@tremily.us>,
	Jonathan Nieder <jrnieder@gmail.com>, git <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 12 07:47:15 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQWpP-0005Ga-9d
	for gcvg-git-2@plane.gmane.org; Fri, 12 Apr 2013 07:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752845Ab3DLFrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Apr 2013 01:47:10 -0400
Received: from moutng.kundenserver.de ([212.227.17.8]:52031 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752180Ab3DLFrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Apr 2013 01:47:09 -0400
Received: from [192.168.178.27] (p4FE19057.dip0.t-ipconnect.de [79.225.144.87])
	by mrelayeu.kundenserver.de (node=mreu1) with ESMTP (Nemesis)
	id 0MdqQ5-1UEBxf39YL-00PNkF; Fri, 12 Apr 2013 07:46:27 +0200
In-Reply-To: <20130412050550.GA15724@sigill.intra.peff.net>
X-Mailer: Evolution 3.2.3 
X-Provags-ID: V02:K0:YCLuiEQZKTFRLXE5B2qemq4FwXU6rpTaydJ920ZA5CU
 0rLzE5EpQJbe7AGvkai2Yv+UEjX6Pue9pWSwV18n5IfS5iz6Ym
 kJuMjuQhhmq1z7g1jJ4bu/VnbSsvIJHzvEK4mjwD7pl5HHiBKr
 KJdkIjbsnntjVQiyyidCFpZL2lXTPAIwe42VJZlzWVY/99tye5
 ovHj9zSQ/vTBRUJmRHnMDU4RYmmQKpKsPDUK0/RVgrKDI9/VvL
 kPfIoc77WO8SJQ8BMPR5btsF5WrwBpv83STzoSL1XePOOTLW2M
 dA7zeUOVHvejrnnzpmExfE5S+r9GLt3+VftLGodIJK32c9L9wt
 0cTnNo6Rs1Ru/aWypnRhcdIUEZXbvkI5LGeqyKpgeXg3mADSCn
 hDaeN9qXtob2A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220956>

On Fri, 2013-04-12 at 01:05 -0400, Jeff King wrote: 
> On Thu, Apr 11, 2013 at 09:46:35PM -0700, Junio C Hamano wrote:
> 
> > >>     --user::
> > >> 	... current description ...
> > >>     +
> > >>     (Like|Unlike) many programs that let you run programs as
> > >>     specified user, the daemon does not reset environment variables
> > >>     such as $HOME when it runs git programs like upload-pack and
> > >>     receive-pack. Set and export HOME to point at the home directory
> > >>     of the user you specify with this option before you start the
> > >>     daemon, and make sure the Git configuration files in that
> > >>     directory is readable by that user.
> > >
> > > So choosing "Like" here, I think this makes sense.
> > 
> > I would prefer the simplicity ;-)
> > 
> > "Set and export HOME to point at the home directory of the user you
> > specify with this option" screams that it wants to be rephrased at
> > me, though.  It somehow sounds as if this option is a way to set and
> > export the environment variable unless re-read carefully X-<.
> 
> Perhaps:
> 
>   Like many programs that switch user id, the daemon does not reset
>   environment variables such a `$HOME` when it runs git programs like
>   `upload-pack` and `receive-pack`. When using this option, you may also
>   want to set and export `HOME` to point at the home directory of
>   `<user>` before starting the daemon, and make sure the Git
>   configuration file in that directory are readable by `<user>`.
> 
> I tried to address your concern above (which I agree with), smooth over
> a few clunky wordings, and use "<user>", which is defined in the heading
> of the option:
> 
>   --user=<user>, --group=<group>

I just updated my local rpm to set HOME, so the surprise of no workee
after upgrade here is forever gone.  Looks like suses (at least)
packagers will need to do the same, else canned setup ain't gonna work.

-Mike
