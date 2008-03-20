From: Johan Herland <johan@herland.net>
Subject: Re: global hooks
Date: Thu, 20 Mar 2008 13:56:16 +0100
Message-ID: <200803201356.16512.johan@herland.net>
References: <1205942671.691.8.camel@omicron.ep.petrobras.com.br>
 <200803201220.47503.johan@herland.net>
 <46dff0320803200526x7b2a535fu25bae005348bb8e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Victor Bogado da Silva Lins <victor@bogado.net>
To: Ping Yin <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 13:57:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcKKo-0002FY-T8
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 13:57:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756094AbYCTM4t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 08:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754721AbYCTM4t
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 08:56:49 -0400
Received: from smtp.getmail.no ([84.208.20.33]:35756 "EHLO smtp.getmail.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753472AbYCTM4s (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 08:56:48 -0400
Received: from pmxchannel-daemon.no-osl-m323-srv-004-z2.isp.get.no by
 no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 id <0JY1008035AMFA00@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 20 Mar 2008 13:56:46 +0100 (CET)
Received: from smtp.getmail.no ([10.5.16.1])
 by no-osl-m323-srv-004-z2.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JY100KQ759T8D40@no-osl-m323-srv-004-z2.isp.get.no> for
 git@vger.kernel.org; Thu, 20 Mar 2008 13:56:17 +0100 (CET)
Received: from alpha.herland ([84.215.102.95])
 by no-osl-m323-srv-004-z1.isp.get.no
 (Sun Java System Messaging Server 6.2-7.05 (built Sep  5 2006))
 with ESMTP id <0JY10030E59SAQ50@no-osl-m323-srv-004-z1.isp.get.no> for
 git@vger.kernel.org; Thu, 20 Mar 2008 13:56:16 +0100 (CET)
In-reply-to: <46dff0320803200526x7b2a535fu25bae005348bb8e6@mail.gmail.com>
Content-disposition: inline
User-Agent: KMail/1.9.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77654>

On Thursday 20 March 2008, Ping Yin wrote:
> On Thu, Mar 20, 2008 at 7:20 PM, Johan Herland <johan@herland.net> wrote:
> > On Thursday 20 March 2008, Junio C Hamano wrote:
> >  > Victor Bogado da Silva Lins <victor@bogado.net> writes:
> >  > > SO my question is, is there a way to make that hook global to all
> >  > > projects? If not, would it be a good idea to allow this?
> >  >
> >  > Probably a post- git-init hook that lets you do anything to your newly
> >  > created repository would be the only thing that you need.  Then you can
> >  > copy, untar or even use symlink to muck with .git/hooks/ in whatever way
> >  > you please.
> >  >
> >  > There needs a mechanism for you to specify what that hook is, and it
> >  > cannot be in individual repositories, so it has to live in ~/.gitconfig
> >  > somewhere.
> >
> >  Or you could add the hook (either the post-init hook, or for that matter
> >  the hook you want to make global) to the Git template directory on your
> >  system (/usr/share/git-core/templates by default). If you don't want to
> >  make it system-global (only user-global), I guess you could make your
> >  own Git template directory somewhere (copy the system's template dir,
> >  and add/enable whatever hooks you like), and set up an alias to
> >  "git init --template=<your_template_dir>". Then use this alias instead
> >  of "git init".
> 
> template dir is meaningful for static hooks. However, sometimes we
> need dynamic hooks which change over time. Having a real global hook
> can help to implement a single logic or policy spreading among
> multiple repositories.

If you need to centralize the logic, you can just keep the actual hook
outside the template directory, and store an (absolute) symlink within
the template dir pointing to the hook. All your git repos will now
exercise the centralized hook instead of each having a separate copy.

> For example, we can enfore a policy to help to update the test or
> deploy environent automatically: when repositories are pushed into a
> central place, they are checked out into different places or hosts
> automatically.
> 
> I think ~/.gitconfig is a good place to give such an entry point.

Still, I think this can be solved with the existing tools, without
adding more features and config directives.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
