From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: git (commit|tag) atomicity
Date: Tue, 28 Feb 2012 09:41:28 -0800 (PST)
Message-ID: <m3aa42vosb.fsf@localhost.localdomain>
References: <CADWOt=j8gJvr88eNAfoYq_qGQvG6M_k-9MCuof_DRrH0sHRVCA@mail.gmail.com>
	<4F4D04F4.80905@ira.uka.de>
	<CADWOt=ig5=Bhhkjs9-wbm2djtwWPOfPGtYt9pH-U3YuQ+iyXzg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Holger Hellmuth <hellmuth@ira.uka.de>
To: Jon Jagger <jon@jaggersoft.com>
X-From: git-owner@vger.kernel.org Tue Feb 28 18:41:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2R3P-0003PQ-Py
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 18:41:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756827Ab2B1Rla convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Feb 2012 12:41:30 -0500
Received: from mail-ee0-f46.google.com ([74.125.83.46]:50103 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754175Ab2B1Rl3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 28 Feb 2012 12:41:29 -0500
Received: by eekc41 with SMTP id c41so1266460eek.19
        for <git@vger.kernel.org>; Tue, 28 Feb 2012 09:41:28 -0800 (PST)
Received-SPF: pass (google.com: domain of jnareb@gmail.com designates 10.14.28.194 as permitted sender) client-ip=10.14.28.194;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of jnareb@gmail.com designates 10.14.28.194 as permitted sender) smtp.mail=jnareb@gmail.com; dkim=pass header.i=jnareb@gmail.com
Received: from mr.google.com ([10.14.28.194])
        by 10.14.28.194 with SMTP id g42mr11703594eea.44.1330450888794 (num_hops = 1);
        Tue, 28 Feb 2012 09:41:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=8hdPl456YhQ1jkmObv29EwH9vDvKIITDgtSC7/sLvic=;
        b=dfRieWforMdhx3aqYSFNHuCrIapJH43zFDAsLGMxCG1be4tOHFfI57Ef2prjXwBtLl
         qJLQsqfhDUAutmU7zcSWZlG/DP4vstUy4dF+aTCxVuHGBshJ+PrO/0LSeddlKMlJbN+A
         MfPsxc/x2P2+RLU+Idwb963UihC5nbIrpRb5Y=
Received: by 10.14.28.194 with SMTP id g42mr8823468eea.44.1330450888631;
        Tue, 28 Feb 2012 09:41:28 -0800 (PST)
Received: from localhost.localdomain (abwh28.neoplus.adsl.tpnet.pl. [83.8.231.28])
        by mx.google.com with ESMTPS id v51sm72587416eef.2.2012.02.28.09.41.26
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 28 Feb 2012 09:41:28 -0800 (PST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id q1SHfQa3023113;
	Tue, 28 Feb 2012 18:41:27 +0100
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id q1SHfPMZ023104;
	Tue, 28 Feb 2012 18:41:25 +0100
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <CADWOt=ig5=Bhhkjs9-wbm2djtwWPOfPGtYt9pH-U3YuQ+iyXzg@mail.gmail.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191752>

Jon Jagger <jon@jaggersoft.com> writes:
> On Tue, Feb 28, 2012 at 4:46 PM, Holger Hellmuth <hellmuth@ira.uka.de=
> wrote:
> > On 28.02.2012 16:40, Jon Jagger wrote:
>>>
>>> I don't know a lot about git - I use it as a tool behind
>>> http://cyber-dojo.com
>>> which is an online coding dojo server.
>>> I have a quick question...
>>> If I do a
>>> =A0 =A0git commit ....
>>> in one thread and a
>>> =A0 =A0git tag | sort -g
>>> in another thread is the output of the git tag guaranteed to be ato=
mic?
>>
>> Can a "git commit" add or remove tags? AFAIK it can't and so the two
>> commands don't conflict in any way.
>=20
> Sorry, I failed to ask the question I really wanted to ask...
>=20
> I mean in one thread
>    git tag -m 'AAA' BBB HEAD
> and in another thread
>    git tag | sort -g
>=20
> and the question is whether the output of the git tag|sort -g command
> is guaranteed to be from before the git tag -m... or from after the
> git tag -m... but not "interleaved" in any way....

Creating a tag or a commit is guaranteed to be atomic.  Git first
atomically adds tag or a commit to object database (atomic file write)
as loose object, then atomically writes tag reference as loose tag
('.git/refs/tags/foo' file, containing SHA-1 id of newly created tag).

"git tag", which list all tags, recursively scans (reads) 'refs/tags/'
directory, so it could theoretically happen that if you have very
large number of loose (unpacked) tags, "git tag" might theoretically
list tag 'zzz' created after start of command, but not list 'aaa' tag
created after start of command.

But I am not sure... that probably depends on how opendir(3) and
readdir(3) works on given filesystem wrt. updates to opened directory.
I think VFS on Linux ensures that you see view of filesystem as it was
on opendir().

--=20
Jakub Narebski
