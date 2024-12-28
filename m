Received: from libero.it (smtp-18-vd.italiaonline.it [213.209.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C24F2AE84
	for <git@vger.kernel.org>; Sat, 28 Dec 2024 15:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.209.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735401016; cv=none; b=PDC8phpfuriy1PxmJkc2kVuYSh5p0nauHR+7t3OEy46EGMuWTAmscTtEXLAhSP/+p+oQBYvt5Qk+C5j7p2Gd4Cu9An8ISk7AvhRMuBJ0NrleSisQntK6QOn4v2awFgXCGLkgOVvhELPDQ6u5OuNl3lcpgDBcDzcUd4wJPmSCukg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735401016; c=relaxed/simple;
	bh=jr6WDkbMhpB+CA6Fwbj4bxck2Pts/paMtOSjPqWOnlI=;
	h=To:From:Subject:Message-ID:Date:MIME-Version:Content-Type; b=j4Hp/0MH4lDQb7ikjffgOBPKh3wNcL1/76RgI7Kt6HlA86w97g/Ab1ea7RsGF12vmIPss82WqPEYaH8BhBWTvtPLcaKy8COj8el0BLdQAGG4WV12C+zi/Bxu2lCMcxYuI2xqLwaKR2H63nT+nvSIffPnkt9y1v1CTpq0nG90EdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it; spf=pass smtp.mailfrom=libero.it; dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b=MGIMeyTK; arc=none smtp.client-ip=213.209.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=libero.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=libero.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=libero.it header.i=@libero.it header.b="MGIMeyTK"
Received: from [192.168.0.129] ([188.27.146.10])
	by smtp-18.iol.local with ESMTPA
	id RZ2Gti1WcgetmRZ2LtPgYz; Sat, 28 Dec 2024 16:47:35 +0100
x-libjamoibt: 1601
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=libero.it; s=s2021;
	t=1735400855; bh=xoCVZHPtifBtPX6Ut7Dg2l6WEB+2O77lenlIL/suU4k=;
	h=From;
	b=MGIMeyTKvDqG/fOteK6i2XBiO3GhA1YPkdTi/GkepKtkWmTfaiDU7a/7HdFepu5do
	 2T0A6efH4r0OY8r8mMC83FhzuPYfdfTaIyYH23nOImoDMASHx4BKiZv5+C6Jq6/36z
	 Ku9aomdHNVJ7Y++nNCjZQXOHAfB6vqB0D77uS5jJeubQ90vL5KuDme+2aE6bICatCh
	 D2JNzelfU3f2Q7ckeGR7dKFjM9gMA7rR8e/cocbs30fBgBEVC6a1Ceqx0aWAaZczkB
	 tXuF//OKVRT3ECSHYsM6voGu4h3BK5eM/IZKj/WNCltnteUCW94Ta5ZqUSixQiapQV
	 vh7yFKcclXHSg==
X-CNFS-Analysis: v=2.4 cv=QPmjRRLL c=1 sm=1 tr=0 ts=67701d97 cx=a_exe
 a=nouTapptOgoxzTc4WCMdog==:117 a=nouTapptOgoxzTc4WCMdog==:17
 a=IkcTkHD0fZMA:10 a=f7IdgyKtn90A:10 a=logazWH7uhjONDQgVrkA:9 a=QEXdDO2ut3YA:10
To: git@vger.kernel.org
From: crstml@libero.it
Subject: connecting the local main branch to the remote origin/main without
 pushing
Message-ID: <a69c4e2e-cbb0-c242-a34a-8997a84fefb7@libero.it>
Date: Sat, 28 Dec 2024 16:47:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Firefox/91.0 SeaMonkey/2.53.18.2
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfP3L8suG5xWZkUolkmJPa13qEmVw/v/5m4Yp+V0emXuVhfM4BG8R9w6WYtlNVDuYX1n5kLJpYVwS4FBalvb+UUwt94pOpwslKx/aQBmVGkwI7SSZT4nJ
 FJ0te7xoESSSabk06q/baONJUogQNo6Xi4rSYImj4pTgYJgb8cwKDN4z8a2nI+R1Cjwo3lgUWl2rAg==

Hello all

I would like to put a set of files under version control and I
have some issues with the workflow. Let me explain:

First I create the bare repository with the command:

     git init --bare -b main ~/rps/project-x.git

Then I can proceed in one of the following ways:


---- Method 1 ----

    By first cloning the remote repository locally and next
    putting the files under version control. All running the
    following commands:

    1    cd ~/projects;
    2    git clone ~/rps/project-x.git project-x
    3    cp ~/my-existing-project-x-files/* project-x
    4    cd project-x
    5    git add .
    6    git commit -m "fc"
    7    git push origin
    8    rm -rf ~/my-existing-project-x-files   # clean your home folder

---- Method 2 ----

    By putting the existing files under version control and next
    adding the remote. Running the following commands:

    1    cd ~/projects/project-x
    2    git init -b main
    3    git add .
    4    git commit -m "fc"
    5    git remote add origin ~/rps/project-x.git
    6    git push --set-upstream origin main


Let me discuss both these methods:

Method 1:

   Everything works but the cp statement may be problematic. If
   you have hidden files (starting with .) or if you want to
   preserve the file permissions and owenership, the invokation
   of the cp command is trickier.

   After you copy the files all the next statements work well.
   The main branch in the cloned repository is connected to the
   upstream origin/main branch and "git push" will work.

   There is one more small problem with this workflow: the
   statement 8 is ugly.



Method 2

   Everything is very clean (apparently). We don't have to think
   to file permissions, hidden files, tricky cp invocations and
   there is no need to clean your home folder at the end. We are
   interested to put files under version control, so we focus only
   the version control system.


   The problem  with this workflow (from my point of view) is the
   statement 6. This statement makes two things which is contrary
   to the UNIX philosophy: programs that do one thing and do it well.

       1) The command connects the local main branch to the
          remote origin/main branch.

       2) Pushes the files to the remote.

   From my point of view instead of executing the statement 6 I would
   like to execute the following two statements that I will number
   here as 6.1 and 6.2:

    6.1  # To connect the main branch to origin/main
         #
         git branch -u origin/main main

    6.2  # To push to the remote.
         #
         git push origin

    However, the statement 6.1 does not work. Git prints the following
    message.

    hint: If you are planning on basing your work on an upstream
    hint: branch that already exists at the remote, you may need to
    hint: run "git fetch" to retrieve it.
    hint:
    hint: If you are planning to push out a new local branch that
    hint: will track its remote counterpart, you may want to use
    hint: "git push -u" to set the upstream config as you push.
    hint: Disable this message with "git config advice.setUpstreamFailure false"

    The end solution it suggests to use with "git push -u" which
    is the same as the statement on line 6 that I would like to
    avoid.  I would add that by issuing a "git fecth" before 6.1
    would not bring the remote branch origin/main in the local
    repository.

    The core of the problem is that the local branch main is not connected
    to the origin/main branch.

My question is:
      Is it possible when applying the method 2 to have (without pushing)
      the local main branch connected to the remote origin/main branch as
      in the case of method 1 which by cloning connects these branches.

Thank you
Cristian
