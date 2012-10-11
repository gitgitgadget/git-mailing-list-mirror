From: James Nylen <jnylen@gmail.com>
Subject: Re: A basic question
Date: Thu, 11 Oct 2012 14:40:44 -0400
Message-ID: <507712AC.7090801@gmail.com>
References: <001501cda711$8ab6f0a0$a024d1e0$@com> <1349897794.32696.15.camel@drew-northup.unet.maine.edu> <002801cda7d7$4792c260$d6b84720$@com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, skotd122@gmail.com
To: Jim Vahl <jv@wmdb.com>
X-From: git-owner@vger.kernel.org Thu Oct 11 20:41:08 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TMNgw-00006B-Nt
	for gcvg-git-2@plane.gmane.org; Thu, 11 Oct 2012 20:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758881Ab2JKSk4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Oct 2012 14:40:56 -0400
Received: from mail-yh0-f46.google.com ([209.85.213.46]:35473 "EHLO
	mail-yh0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753739Ab2JKSkz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Oct 2012 14:40:55 -0400
Received: by mail-yh0-f46.google.com with SMTP id m54so576644yhm.19
        for <git@vger.kernel.org>; Thu, 11 Oct 2012 11:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kaWrmszDwrDaLVNut2ALIkiCRguac2Txz3A3Ur330Zs=;
        b=0ZpIUQLqHjQhHfvXjF71qSXv9YKWvjpMUxT/KMxXvmglvNJYkV05C9HpqJEqR8NCiV
         5WXeLrmS70DgM3f+5eN911+sFwxoxzmTI2vkchRc5cbnfrDzCTQqIbukNDmBcRn+o9p0
         sOneHf0ZoNMFkbQBq1tKmDag3/A6XiUFde4vV5lwBXu6AFbtb9X22aB+ho1PvIzMnm8r
         VWRbIWUAT18JUL+OXSK05zAAu30g9I10dQhnuu4nEtbOqCEoiAEMwQwxG6D8oku1y625
         NJcaxV/VIUK53QglvrqufFI3FjVhj1NlvEgMt7RG2NFEEPXcwW8HfWPvOcT050VbHSSc
         VZdA==
Received: by 10.236.150.1 with SMTP id y1mr1754164yhj.96.1349980854818;
        Thu, 11 Oct 2012 11:40:54 -0700 (PDT)
Received: from [192.168.11.100] (host-68-169-157-114.VALOLT2.epbfi.com. [68.169.157.114])
        by mx.google.com with ESMTPS id b46sm4934623yhn.5.2012.10.11.11.40.53
        (version=SSLv3 cipher=OTHER);
        Thu, 11 Oct 2012 11:40:53 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:14.0) Gecko/20120713 Thunderbird/14.0
In-Reply-To: <002801cda7d7$4792c260$d6b84720$@com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207503>


On 10/11/2012 1:38 PM, Jim Vahl wrote:
> For the sake of argument, I'll assume that a committing a change implies
> that the file has passed the testing process.  So my questions are:
You should not assume this.  You / your developers should commit far 
more frequently than you test and release versions.  For example, I 
usually try to commit after a day's work at most.

Instead, you should mark a tested version using tags (the git tag 
command). Here is a workflow that seems like it would work well for you:

1. Commit 1
2. Commit 2
3. Commit 3 - TAGGED as release-v0.1
4. Commit 4
5. Commit 5 - TAGGED as release-v0.2
6. Commit 6
7. Commit 7

In this scenario, you reviewed the code after Commit 3 was entered and 
it passed your tests.  You then tagged this version of the code as 
version 0.1.  Tagging is just a convenient way to associate a name (for 
example, "release-v0.1") with the code tree as of a certain commit.  
Similarly with Commit 5 and version 0.2.

Commits 6 and 7 represent changes made to the code for features that are 
in progress, bug fixes, etc.  They have not been reviewed yet.  For the 
purpose of releasing versions, you don't care about these commits.

For the purpose of releasing versions, you also don't care about the 
state of files in the git repository (whether they are modified, or some 
or all changes are staged).  These features exist to help you prepare 
commits and understand what changes you are committing, not as a way of 
managing versions of the software.

Many people use git in more complex ways that involve non-linear 
development histories (branches).  For example, you can have multiple 
developers working on different features simultaneously, each committing 
their own changes, and you can use git to help you reconcile the changes 
later.  You can also have a "release" branch which stores only the 
released versions, and separate "development" branches where code 
changes occur.  These workflows are harder to wrap your head around, though.

> 1) Does git have a built-in way to get a list of all of the "most recently
> committed" files only at a given point in time, thus automatically recording
> the revisions of all of the component files of a release?   This implies
> that for files which are being modified or which have been staged but not
> committed, that git would go back to find the "predecessor" file which had
> been committed.
Let's replace "committed" with "tagged as a released version". Then 
yes.  The person who wants to release a version would do:

git checkout release-v0.1

At this point their working folder will contain all of the files for the 
v0.1 release.  You can run tests, run the build process and generate 
executables, or whatever other kind of deployment process needs to be done.

Another option is to create a zip file containing all the code as of 
version 0.1:

git archive release-v0.1 -o release-v0.1.zip

>   2) Does git have a way of creating and exporting a list of the "most
> recently committed" files only?
There are many ways to list and manipulate the files stored in the 
repository, as of any commit that you want.

> 3) If the answer to the above questions is "No", then what is the normal way
> for a programming shop which is using git to extract/assemble the list of
> approved files for building a release?

The first step, which git will help you with, is to ensure that you are 
working with the right version of the code and development files (the 
version you tested, that you intend to release).  From there, extracting 
and deploying the files necessary for a release is up to you.
