From: shi roger <rogershijicheng@gmail.com>
Subject: GSOC proposal: Parallel Git Commands
Date: Fri, 6 Apr 2012 23:37:00 +0800
Message-ID: <CAL8K7nJskxFwC+iyWiYPoXGWwOY3f2sjX9wjfBx31cgDdOTsHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 06 17:37:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SGBDq-00011t-3T
	for gcvg-git-2@plane.gmane.org; Fri, 06 Apr 2012 17:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757460Ab2DFPhD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 6 Apr 2012 11:37:03 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:57286 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754458Ab2DFPhB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Apr 2012 11:37:01 -0400
Received: by obbtb18 with SMTP id tb18so3216780obb.19
        for <git@vger.kernel.org>; Fri, 06 Apr 2012 08:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=XNSawmkjc72OsuFo4Usd9U/C7FPb6h+L3DLh/r6nmY4=;
        b=cnmogTT36aotFAHG91B9nE8NHR8pN76L6jGPVXXjepGHnczGUNVQ58SO3IELlLPzxL
         1PO/9wPcSLSIjERZjZ426TIaum8EGftfDdcppSSQKW5yxBJN2OKmENexxcfFPfntuE6T
         n1rUlUrdEWeC2bjv86LUhinzUYX6pLyuUqtQPI3Cro0r116fDVQXv50U0hpP1B4h5UZi
         qhsJDKUthqtEWPY175LCeDiSbY7sjc6qE1Xgvs6Tt433Mu/bS5rXseiB8lLriqrWYs3C
         sr4v24X6//juO1zRRLMhpEONdWH2QJne/TZW834Y70gmkpKeWuIrSzDHFEqIpLldLUT3
         GLwQ==
Received: by 10.182.36.3 with SMTP id m3mr9871543obj.8.1333726620922; Fri, 06
 Apr 2012 08:37:00 -0700 (PDT)
Received: by 10.182.115.73 with HTTP; Fri, 6 Apr 2012 08:37:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194875>

Goals and Steps:

This project is supposed to improve=C2=A0the parallelization and
scalability of Git command. Though=C2=A0the=C2=A0current version of Git=
 does
take parallel programming into consideration=C2=A0(such as git grep
command), there are a lot of=C2=A0aspects to improve. For instance,=C2=A0=
git
grep --cache=C2=A0and=C2=A0git diff=C2=A0haven=E2=80=99t adopted multi-=
thread programming
model.=C2=A0Therefore, I supposesome=C2=A0other commands=C2=A0shouldals=
o=C2=A0be
paralleled.

The project can be finished by the following steps:

1.=C2=A0=C2=A0Week 1 ~ 2:=C2=A0Profile the Git commands in=C2=A0an=C2=A0=
extremely tough
environment, such as a very big repository or a long time lasting
project. This is used to distinguish which command takes much more
time to accomplish as the repository grows more complexity.

2.=C2=A0=C2=A0Week 3 ~ 4:=C2=A0Profile the commands, which are selected=
 from the
first step in more detail to tell what=E2=80=99s the bottleneck and whe=
ther it
can be fixed in parallel manner. The profile tools can be oprofile,
dtrace or some other proper tools.

3.=C2=A0=C2=A0Week 5 ~ 12:=C2=A0Redesign the data structure and data pr=
ocess logic to
parallel the git commands.

4.=C2=A0=C2=A0Week 5=C2=A0~=C2=A012:=C2=A0Redo the profiling and testin=
g to confirm that these
changes really improve the scalability and parallelization of Git
commands.

5.=C2=A0=C2=A0Step 3 and Step 4 may loop several times to fix the error=
s and new
performance bottlenecks introduced by new design.

Success criteria:

=C2=A0 =C2=A0 After the project, git should scale well as the CPU core =
number
grows or at least have a better performance than the current version.

Interfaces:

This project doesn=E2=80=99t deal with extending git, but redesigning t=
he
internal data structure and process logic to parallel it. For
instance, there may be some data structures sharing between the loop
iterations which=C2=A0maybring difficulty to parallel it. So far, I hav=
e
checked the=C2=A0git grep=C2=A0and=C2=A0git diff=C2=A0commands and the =
related filesare
supposed tobe=C2=A0modified, such as=C2=A0diff.c=C2=A0and=C2=A0grep.c. =
However, as the
project goes on, more problems may be revealed and more files will
need to be changed.


About Me:

Jicheng Shi(=E6=96=BD=E7=BB=A7=E6=88=90)



=46irst Year Graduate Student

Parallel Processing Institute
=46udan University
RM 320, Software Building, 825 Zhangheng Road, Shanghai
P.R. China, 201203
Email:=C2=A0jcshi@fudan.edu.cn

Education

Sep. 2011 - Now. Software School, Fudan University

Sep. 2007 - July. 2011. Software School, Fudan University

Publication

Xiang Song, Jicheng Shi, Haibo Chen and Binyu Zang. Revisiting
Software Zero-Copy forWeb-caching Applications with Twin Allocators.
Proceedings of 2012 Usenix Annual Technical Conference (Usenix ATC
2012, short paper, to appear). Boston, Massachusetts USA, June, 2012.

Jicheng Shi, Xiang Song, Haibo Chen, Binyu Zang. Limiting Cache-based
Side-Channel in Multi-tenant Cloud using Dynamic Page Coloring. the
7th Workshop on Hot Topics in System Dependability (HotDep'11)



Research Projects

Paralleling VM Migration. =C2=A0Dec.2011 - Now

TCP/UDP Stack Buffer Zero-Copy. =C2=A0May.2011 - Nov.2011

Defending Side Channel Attack in Cloud. =C2=A0Nov.2009 - Apr.2011

Skills

Languages: C(4 years), Java(4 years), C++, Python (2 years), Common
Lisp, Javascript

System: Linux(Operation System), Xen(Virtualization System)
