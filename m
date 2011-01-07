From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: problem with cherry-picking a commit which comes before
 introducing a new submodule
Date: Fri, 7 Jan 2011 17:00:17 -0600
Message-ID: <20110107230017.GA15495@burratino>
References: <20110107172432.GA6040@onerussian.com>
 <20110107181501.GA28980@burratino>
 <20110107183226.GG6040@onerussian.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
To: Yaroslav Halchenko <debian@onerussian.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 00:00:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbLIc-0002lV-3w
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 00:00:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755682Ab1AGXAk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 18:00:40 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43154 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755623Ab1AGXAg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 18:00:36 -0500
Received: by ywl5 with SMTP id 5so6932039ywl.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 15:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=dJCtOIJtz8lvHrgNa2uNnqEM/kl2+y9NuJoOCYjp6C8=;
        b=T/uuZDMan2xysck3weoUkILAsnG+PNOeH09qb9JGb2fhLd8w84cHAkaw27eiLkh8Lb
         90G72NbK7JatAllyXqQRyxOQBqIdd7zmVUsaccWTS+NfdxvaAJoHFSXi0DKW3TpLOZEW
         vlqaihU4IkE76h1oEDrxckv0NrbD5sqs5nlj4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=XqQxKxemlC262/9i6Pi9k7skrFBSdfj/3fxla6Nz8Vwoh5c5LJ6ia7oB9N4Nok7oYZ
         KfqNalHhzC3W2ZsUuItlyE2BBT1rQQQGZFk0rnOqd5RPFFJ+4r4GM3mMcEuVidbjxj3Y
         Ek2A/cTEagow66r9wKv2YqnsvJ9mhlyf8oS5s=
Received: by 10.151.156.9 with SMTP id i9mr25487456ybo.444.1294441236029;
        Fri, 07 Jan 2011 15:00:36 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id v7sm700832ybe.3.2011.01.07.15.00.33
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 15:00:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110107183226.GG6040@onerussian.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164783>

Yaroslav Halchenko wrote [abbreviated]:

> Merging HEAD with todonotloose
> Merging:
> 855981d just placeholders in the abstract
> a00c497 Initial draft for HBM abstract.
> CONFLICT (file/directory): There is a directory with name frontiers/code in todonotloose. Adding frontiers/code as
> +frontiers/code~HEAD
> %         git ls-files -u
> 160000 a2b5787 2   frontiers/code
> %         git diff-tree todonotloose
> a00c497
> :040000 040000 40427e34 c7ba910 M	poster-hbm2011_neurodebian
> %         git diff-tree todonotloose^ HEAD
> :100644 100644 378e137 c39ced7 M	.gitmodules
> :000000 040000 0000000 141dbc1 A	challenge-execpapers
> :040000 040000 401fd66 ee190f0 M	frontiers
> :040000 040000 26c884a ad3e829 M	sty

One more piece of protocol: what git version are you using?  The
release notes mention a fix in this area in v1.7.3[1]:

 * "git merge -s recursive" (which is the default) did not handle cases
   where a directory becomes a file (or vice versa) very well.

Hopefully this is that.  In any case, sounds like a bug.

(Hopefully someone else can comment on why cherry-pick uses the
merge machinery to notice conflicts that would not be clear from
the patch alone.)

Thanks again.
Jonathan

[1] There is an updated Debian source package at [2].  Or, probably
faster: one can use the build result in bin-wrappers/ from a git.git
clone in place.
[2] http://mentors.debian.net/debian/pool/main/g/git/git_1.7.4~rc1-0.1.dsc
