From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git-describe recognize modified files
Date: Tue, 19 Jan 2010 04:49:40 -0800 (PST)
Message-ID: <m34omiclap.fsf@localhost.localdomain>
References: <829260.92036.qm@web45202.mail.sp1.yahoo.com>
	<alpine.DEB.1.00.1001191134130.3164@intel-tinevez-2-302>
	<20100119122122.GA28667@inner.home.ulmdo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	tzachi perelstein <tzachi_perelstein@yahoo.com>,
	git@vger.kernel.org
To: Andreas Krey <a.krey@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jan 19 13:49:52 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXDWp-0000eh-Pd
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 13:49:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752578Ab0ASMtp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Jan 2010 07:49:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751590Ab0ASMtp
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Jan 2010 07:49:45 -0500
Received: from fg-out-1718.google.com ([72.14.220.155]:41706 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751782Ab0ASMto (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Jan 2010 07:49:44 -0500
Received: by fg-out-1718.google.com with SMTP id 16so391162fgg.1
        for <git@vger.kernel.org>; Tue, 19 Jan 2010 04:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=yu3CwzwzVcYcElDNyurZYcL+iZ4KvXegZoDh8lEe4Qo=;
        b=L3yFwFOhzoGSxqpJuVr/kYvuc2IgUx6ZkNeRBVXImtV8J06F7M/CKs6lis+67E08OE
         G0fcxSinScHuKjymOvsF90wzXJVoZZ87lGi9EZW/Nm7QmFUgIhgkSW5KSWMIrhmQAo2U
         QG6bG2zEYExvJTbSOO80u/QJn0oJ2RPbpHDSA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=t2l0r/IOXmF5K5jEiRUT0JSPPJ1DyWpQypj1gW3356EZx6DC/vae7atqRiQbA3WDPH
         qeA2osr4InGteQsL/vaSzwCee5biPwgeJDvDtBBk2j/d9NforqKP3cWpMn7RfpQXSqN2
         KUt2vzksLGD9ShQ3ZM4Y40Ezh80YxfC9+376k=
Received: by 10.87.15.22 with SMTP id s22mr6977142fgi.56.1263905382469;
        Tue, 19 Jan 2010 04:49:42 -0800 (PST)
Received: from localhost.localdomain (abvz142.neoplus.adsl.tpnet.pl [83.8.223.142])
        by mx.google.com with ESMTPS id d6sm13042996fga.4.2010.01.19.04.49.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 19 Jan 2010 04:49:40 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o0JCn8OY010788;
	Tue, 19 Jan 2010 13:49:18 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o0JCmkXs010783;
	Tue, 19 Jan 2010 13:48:46 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20100119122122.GA28667@inner.home.ulmdo.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137453>

Andreas Krey <a.krey@gmx.de> writes:

> On Tue, 19 Jan 2010 11:35:41 +0000, Johannes Schindelin wrote:
> ...
> > > To solve this issue, in addition to git-describe, my do_version script
> > > also run git-status, and if there are "modified:" files then it
> > > concatenates the string "+dirty" to output of git-describe.
> > 
> > The problem is that this does not describe the exact version you used very 
> > well.
> 
> I (and probably the original poster) don't care that much; for me the
> important information is that the binary (or whatever) was not built
> from the exact committed state. Thus the question is whether the
> second two lines of
> 
>  BUILDINFO=git-`git describe --abbrev=16 --always HEAD 2>/dev/null`
>  git update-index -q --refresh
>  test -z "`git diff-index --name-only HEAD --`" || BUILDINFO="$BUILDINFO.dirty"
> 
> (after GIT-VERSION-GEN) are worth to be integrated into git-describe?
> 
> (And whether it should also say '.dirty'
>  when there are untracked files present.
>  Or either for submodules.)

FYI it is integrated in git-describe since

  9f67d2e (Teach "git describe" --dirty option, 2009-10-21)

by Jean Privat (it should be present in 1.6.6, IIRC).

-- 
Jakub Narebski
Poland
ShadeHawk on #git
