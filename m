From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: Bug: "git checkout -b" should be allowed in empty repo
Date: Tue, 07 Feb 2012 09:04:11 +0100
Message-ID: <4F30DAFB.5050906@alum.mit.edu>
References: <7vwr8bvvxj.fsf@alter.siamese.dyndns.org> <4F263AEE.4080409@alum.mit.edu> <7v39axc9gp.fsf@alter.siamese.dyndns.org> <7vaa55ar4v.fsf@alter.siamese.dyndns.org> <20120130215043.GB16149@sigill.intra.peff.net> <7vobtcbtqa.fsf@alter.siamese.dyndns.org> <20120206043012.GD29365@sigill.intra.peff.net> <CAH5451ndjozo8-Cx3+Vc84TCjKJvCnSuOUsQS5cnqXsdc=8fMQ@mail.gmail.com> <20120206050637.GA4263@sigill.intra.peff.net> <4F2F94AC.6010800@alum.mit.edu> <20120206085707.GA24149@sigill.intra.peff.net> <7vpqdr7rn0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Andrew Ardill <andrew.ardill@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 07 09:04:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rug2K-0006CX-73
	for gcvg-git-2@plane.gmane.org; Tue, 07 Feb 2012 09:04:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449Ab2BGIET (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Feb 2012 03:04:19 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34323 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751349Ab2BGIET (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2012 03:04:19 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.100.152] (ssh.berlin.jpk.com [212.222.128.135])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q1784BWh020536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 7 Feb 2012 09:04:11 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.24) Gecko/20111108 Lightning/1.0b2 Thunderbird/3.1.16
In-Reply-To: <7vpqdr7rn0.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190152>

On 02/06/2012 07:17 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> Probably I am slower than my usual slow self this morning. Does Michael's
> approach go like this:
> 
> 	git init project
>         cd project
>         import import import
>         git branch -m vendor
>         git checkout -b master
> 
> to fork from third-party codebase?

I'm not really forking the third-party code; I'm just importing a
snapshot to a particular subdirectory of my own project.  I wanted to do
something like:

    git init project
    cd project
    git checkout -b vendor
    import import import commit (into subdirectory "foo")
    git checkout --orphan master
    git clean -fxd
    hack commit hack commit
    # Then when the vendor stuff is logically needed in master:
    git merge vendor

With the option to import later snapshots of the third-party code to the
"vendor" branch then re-merge it to master.

> Care to come up with a patch to Documentation/git-checkout.txt?  The
> description there strongly implies that <start point> is an existing
> commit.  Not much is said about what the lack of <start point> mean when
> it describes "checkout -b", and a standalone description of <start point>
> says "The name of a comit at which to start... Defaults to HEAD".  These
> need to be loosened and described in terms of the closer-to-the-user "at
> my current state".

I'll work on it as soon as I have time.

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
