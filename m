From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: re-running merge on a single file
Date: Fri, 12 Mar 2010 10:00:23 +0100
Message-ID: <201003121000.25217.jnareb@gmail.com>
References: <a038bef51003111054n5bcecd2eud531dcc80509f952@mail.gmail.com> <a038bef51003111631n38f7e50cp79d8335109f3ed0@mail.gmail.com> <a038bef51003111633v5d5d418bu332b63bb3874e3ef@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: GIT <git@vger.kernel.org>
To: Chris Packham <judge.packham@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 12 10:00:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Nq0jZ-0007h5-1K
	for gcvg-git-2@lo.gmane.org; Fri, 12 Mar 2010 10:00:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756867Ab0CLJAd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Mar 2010 04:00:33 -0500
Received: from mail-bw0-f209.google.com ([209.85.218.209]:48955 "EHLO
	mail-bw0-f209.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756678Ab0CLJAc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Mar 2010 04:00:32 -0500
Received: by bwz1 with SMTP id 1so836904bwz.21
        for <git@vger.kernel.org>; Fri, 12 Mar 2010 01:00:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=hoIhzzNs/nhil5BPkk3SB40TDoHq1s7ie6dx3mTtFOI=;
        b=xaAvDbzrjMol3m24bNXnFE7yoUX+4TTSi6DAwfibW8uz8OmPQ12qWqilAwv+pUb1vM
         zWNxEuCB0urYd5UtFm1ky3mf8a0caE5gEB0Ff9t/u14Ho3hRL+RMjPTSu0qgYR8uI3w1
         nSAhHpPJse7Li35PK7zUNIpYQ9japX/7pHD64=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=HJMJbg00sy/Cr5CePMVGU1FEACRTI0rbfHuJc7mdcC2bW1T2vLUfQOz/YOfjtzxnu/
         H6tpO7hwZ6Qm7G7sNcvrhMK/jSrB5wvYQIWOoTpX5PIi5ZfNqx9UCV0UBubq4E0ucN13
         e7Moer23uy7hxrL4jYx0dQZffeCDj9KgLnvNs=
Received: by 10.204.161.197 with SMTP id s5mr1973734bkx.90.1268384430859;
        Fri, 12 Mar 2010 01:00:30 -0800 (PST)
Received: from [192.168.1.13] (abwe142.neoplus.adsl.tpnet.pl [83.8.228.142])
        by mx.google.com with ESMTPS id 13sm601867bwz.7.2010.03.12.01.00.28
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 12 Mar 2010 01:00:29 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <a038bef51003111633v5d5d418bu332b63bb3874e3ef@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142034>

On Fri, 12 Mar 2010, Chris Packham wrote:
> On Thu, Mar 11, 2010 at 3:20 PM, Jakub Narebski <jnareb@gmail.com> wr=
ote:

> > Try
> >
> > =C2=A0$ git show :1:$(git rev-parse --show-prefix)cpu/mpc83xx/start=
=2ES \
> > =C2=A0 =C2=A0> cpu/mpc83xx/start.S.base
>=20
> git show doesn't complain about the path. But I'm obviously not
> setting the stage correctly
>=20
> $ git checkout --merge -- cpu/mpc83xx/start.S
> $ git show :1:$(git rev-parse --show-prefix)cpu/mpc83xx/start.S
> fatal: Path 'cpu/mpc83xx/start.S' is in the index, but not at stage 1=
=2E
> Did you mean ':0:cpu/mpc83xx/start.S'?
>=20
> By now I have additional commits that touch cpu/mpc83xx/start.S so
> I'll see if I can find a file that I haven't touched since the merge.

Note that "git checkout --merge <file>" re-creates <file> in the state
of textual merge conflict from the index (from stages 1, 2, 3).  It is
not able, unfortunately, to recover stages in index if you marked
<file> as resolved using "git add <file>".

Note also that you would get non-0 stages in index only if there was
a *merge conflict* for a file which was not automatically resolved.
If cpu/mpc83xx/start.S resolved cleanly, it would be in stage-0 only.

You can check what stages you have in index for a specified file using

  $ git ls-files --stage cpu/mpc83xx/start.S


If you don't have stages 1 and 2 in the index (which you can check usin=
g
command provided above), you can instead get versions of a file which
would be used in resolving conflict:

 $ git show HEAD:cpu/mpc83xx/start.S \
   >cpu/mpc83xx/start.S.ours
 $ git show MERGE_HEAD:cpu/mpc83xx/start.S \
   >cpu/mpc83xx/start.S.theirs
 $ git show $(git merge-base HEAD MERGE_HEAD):cpu/mpc83xx/start.S \
   >cpu/mpc83xx/start.S.base

Sidenote: versions in stage 1, 2, 3 differ from above versions in that
they have those conflict (chunks) that can be automatically resolved,
resolved.

HTH
--=20
Jakub Narebski
Poland
