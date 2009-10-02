From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: How to delete large files
Date: Fri, 2 Oct 2009 14:26:44 +0200
Message-ID: <237967ef0910020526w51c05570g606ebc16e0b4a3e7@mail.gmail.com>
References: <C6EB1E10.D7AB%nilshomer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Nils Homer <nilshomer@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 14:27:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MthDu-0003er-UA
	for gcvg-git-2@lo.gmane.org; Fri, 02 Oct 2009 14:26:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756248AbZJBM0p convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 2 Oct 2009 08:26:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756251AbZJBM0o
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Oct 2009 08:26:44 -0400
Received: from mail-bw0-f210.google.com ([209.85.218.210]:56959 "EHLO
	mail-bw0-f210.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756057AbZJBM0l convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Oct 2009 08:26:41 -0400
Received: by bwz6 with SMTP id 6so931090bwz.37
        for <git@vger.kernel.org>; Fri, 02 Oct 2009 05:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=TWPdWOOmdp1vzXSNzmUX1t+tvyjojMy8z3vmg/Gd1Es=;
        b=YWoMdb9pK2zjrxpJ8A468D9hgsHQr33P82K2jmxMLgZHrKmg8/4TeU5s67KUq9lf63
         FH39a4Km6B4rbnZ9fbNw1kYGLWoN+noRkIR8PI+P/7ldDXqGDF1pqrTSwPtZT15lP7+Z
         LisNV8oqMq/rA83wfvZozMxCsqRnDEkt2Pvmw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=G2tV5OSjpL2Z9WYcca4UlD+nDMOPimVLyZgHSo/Erf9w0zaMzva40JcBxpqhtC9Ymi
         gmEiPWpRpMLjIT2/AEUaqr+huGB0SuCAIOt1c8ESOhTdlSHZk2i7bb3Ilr+ytZN2UrLW
         MCAO8lMQQvoQHjrZa6HF84BvUfHVNM531/9XI=
Received: by 10.204.34.203 with SMTP id m11mr1118675bkd.79.1254486404716; Fri, 
	02 Oct 2009 05:26:44 -0700 (PDT)
In-Reply-To: <C6EB1E10.D7AB%nilshomer@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129440>

2009/10/2 Nils Homer <nilshomer@gmail.com>:
> I wish to delete some large offending files (10MB to >100MB each) fro=
m my
> git repository (git://bfast.git.sourceforge.net/gitroot/bfast/bfast).=
  The
> current size of the repo is 656MB.
>
> I created a backup of my repository and then searched for such offend=
ing
> files using a script found here:
> http://stubbisms.wordpress.com/2009/07/10/git-script-to-show-largest-=
pack-ob
> jects-and-trim-your-waist-line/
> where I modified the script to output in MB instead of KB.
>
> This gave me a list of files that I wanted to delete:
> -e   size  pack                                      SHA
> location
> 113  113   f9f2faab597d4f8ccbfac2864347dbc256353fbf
> tests.long/save/save.tar.gz
> 113  113   926b1ba880a26354c4a6b9391985f57fbc9a1174
> tests.long/save/save.tar.gz
> 113  113   e568480bcb8239e6d1ed8d2da86c309c0d3d101b
> tests.long/save/save.tar.gz
> 113  113   e3c0ee53f20e8ebfb60eaefcd7b405168c26a565
> tests.long/save/save.tar.gz
> 103  103   ee2ee50c5075d05d29764c8d4b9acc2acedda919
> tests.long/save/save.tar.gz
> 35   35    319c75945c27096093dbab5a0bf6a9a08089bc2d
> tests.long/data/data.tar.gz
> 11   11    805193c74ceeffca9da3a2788545e701d77e1caf  tests/save/save.=
tar.gz
> 11   11    658e4a78c1028875ab597d6bde5823cd6a1694b9  tests/save/save.=
tar.gz
>
> So I decided to remove these files using:
> git filter-branch --index-filter "git rm -rf --cached --ignore-unmatc=
h
> tests.long/save/save.tar.gz tests.long/data/data.tar.gz
> tests/save/save.tar.gz" HEAD
>
> I then ran:
> rm -rf .git/refs/original
> git reflog expire --expire=3Dnow =E5=8D=9Fll
> git gc --prune=3Dnow
>
> Still (using du =E8=99=90) the repository is 656MB and I can see the =
above files in
> the revision list:
> git rev-list --all --objects | grep tests.long/save/save.tar.gz
> ee2ee50c5075d05d29764c8d4b9acc2acedda919 tests.long/save/save.tar.gz
> e568480bcb8239e6d1ed8d2da86c309c0d3d101b tests.long/save/save.tar.gz
> f9f2faab597d4f8ccbfac2864347dbc256353fbf tests.long/save/save.tar.gz
> 926b1ba880a26354c4a6b9391985f57fbc9a1174 tests.long/save/save.tar.gz
> e3c0ee53f20e8ebfb60eaefcd7b405168c26a565 tests.long/save/save.tar.gz
>
> Could this be because of tags that I had previously created?
>
> I am running git version 1.6.3.3.  I appreciate any help in advance,

Well, you just gave "HEAD" to git filter-branch to rewrite, i think
you want --all to rewrite all refs you have.

--=20
Mikael Magnusson
