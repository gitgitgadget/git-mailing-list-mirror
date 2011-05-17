From: Drew Northup <drew.northup@maine.edu>
Subject: Re: [PATCHv2] gitweb: Use GITWEB_CONFIG_SYSTEM even if
	GITWEB_CONFIG does exist
Date: Tue, 17 May 2011 11:19:49 -0400
Message-ID: <1305645589.11864.20.camel@drew-northup.unet.maine.edu>
References: <201105142137.16541.jnareb@gmail.com>
	 <20110514210603.GA11502@elie> <201105151153.08826.jnareb@gmail.com>
	 <201105161153.24382.jnareb@gmail.com>
	 <7v39kdj3hw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@kernel.org>,
	Petr Baudis <pasky@suse.cz>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 17 17:25:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QMM92-0005dn-Ms
	for gcvg-git-2@lo.gmane.org; Tue, 17 May 2011 17:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449Ab1EQPZG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 May 2011 11:25:06 -0400
Received: from basalt.its.maine.edu ([130.111.32.66]:44864 "EHLO
	basalt.its.maine.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755120Ab1EQPZE (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2011 11:25:04 -0400
Received: from [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e] (drew-northup.unet.maine.edu [IPv6:2610:48:100:827:211:43ff:fe9f:cb7e])
	by basalt.its.maine.edu (8.13.8/8.13.8) with ESMTP id p4HFJxUY022302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 17 May 2011 11:20:04 -0400
In-Reply-To: <7v39kdj3hw.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 2.12.3 (2.12.3-8.el5_2.3) 
X-DCC-URT-Metrics: basalt.its.maine.edu 1060; Body=6 Fuz1=6 Fuz2=6
X-MailScanner-Information: Please contact the ISP for more information
X-UmaineSystem-MailScanner-ID: p4HFJxUY022302
X-MailScanner: Found to be clean
X-MailScanner-From: drew.northup@maine.edu
X-UmaineSystem-MailScanner-Watermark: 1306250428.26256@u4gA2X/hw6u6PNf9zVF/cA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173803>


On Mon, 2011-05-16 at 22:32 -0700, Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > This commit changes gitweb behavior so that configuration in
> > per-instance configuration file can _override_ settings from
> > system-wide configuration file.
> >
> > Note that strictly speaking it is backwards incompatible change.
> 
> I am not sure if we gain enough from this change.  As the system-wide one
> can be arbitrarily overriden by per-instance one, the goal of this change
> cannot be to make sure that the system administrator can enforce the
> system wide policy over all the gitweb instances.

Currently if there is a local configuration file
_there_is_no_system-wide_policy_. That's the problem.

> I think the goal is to let per-instance configuration have an easy way to
> inherit from a common sane default, but if that is the case, wouldn't it
> be a lot safer and more backward compatible way to just instruct people to
> include that common default configuration at the beginning of per-instance
> configuration file instead?  After all, you would need to give some advice
> like this ...

If that's currently being done anywhere this change will not cause any
pain. If the default /etc/gitweb.conf contains a set of commented-out
sample entries, as it should in the case of something like this, then
there will be no problems. As the local configurations will override the
system configuration items one by one, instead of wholesale and
outright, those items most likely to be a problem will be set correctly
in my estimation.

>From my day job I happen to know that asking the user to please respect
the existing policy by including it in their local configuration policy
doesn't work out very well. What usually happens is the user removes
whatever is there and replaces it with whatever the tutorial they are
currently looking at has in it. I highly doubt we'll change all of the
tutorials out on the Internet, or all of the mere mortals using them. We
can change Gitweb.

The difference between the current situation and the resultant one can
be summed up thusly:

Currently
/etc/gitweb.conf only: System policy
gitweb_config.perl only: Local policy
both: Local policy ONLY

New
/etc/gitweb.conf only: System policy
gitweb_config.perl only: Local policy
both: Local policy overrides System policy on a per-configurable item
basis

-- 
-Drew Northup
________________________________________________
"As opposed to vegetable or mineral error?"
-John Pescatore, SANS NewsBites Vol. 12 Num. 59
