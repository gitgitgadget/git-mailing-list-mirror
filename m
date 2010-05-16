From: Geert Bosch <bosch@adacore.com>
Subject: Re: [PATCH v2] ls-remote: print URL when no repo is specified
Date: Sun, 16 May 2010 13:27:15 -0400
Message-ID: <47A48A85-CAFC-4B8B-9D24-869A6ABC8EF1@adacore.com>
References: <1273416140-5044-1-git-send-email-rctay89@gmail.com>  <1273598423-3156-1-git-send-email-rctay89@gmail.com> <7veihh8y8b.fsf@alter.siamese.dyndns.org>  <AANLkTinxm8hwX53LE9_7rDPoKs9UnGAyFFfVcoh-WGxE@mail.gmail.com>  <C21B68F7-E430-4BCA-A1D1-80446B0B76DE@adacore.com> <AANLkTikKZAinLGeRMnqUPsTbBjMiAQuOCXxr4VEPBhHW@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Tay Ray Chuan <rctay89@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 16 19:29:22 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ODheS-0002nK-Ho
	for gcvg-git-2@lo.gmane.org; Sun, 16 May 2010 19:29:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754105Ab0EPR1S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 May 2010 13:27:18 -0400
Received: from rock.gnat.com ([205.232.38.15]:52321 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754080Ab0EPR1R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 16 May 2010 13:27:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 859ED2BAB04;
	Sun, 16 May 2010 13:27:16 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id rnBKTISO+DEK; Sun, 16 May 2010 13:27:16 -0400 (EDT)
Received: from [172.16.1.3] (sdsl-216-220-103-157.dsl.bway.net [216.220.103.157])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id 2605A2BAB34;
	Sun, 16 May 2010 13:27:16 -0400 (EDT)
In-Reply-To: <AANLkTikKZAinLGeRMnqUPsTbBjMiAQuOCXxr4VEPBhHW@mail.gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147195>


On May 16, 2010, at 06:36, Sverre Rabbelier wrote:

> On Sun, May 16, 2010 at 04:14, Geert Bosch <bosch@adacore.com> wrote:
>> What git seems to be missing is a "git info" command, which
>> would print out essentially something like what "svn info" does:
>> name of remote repo that we're tracking, name of current branch,
>> date/author/subject of last commit.
> 
> You can get information about the remote with:
> 
> $ git remote -v

geert-boschs-computer:/tmp%ssh kwai git init --bare /work/bosch/temp.git
Initialized empty Git repository in /export/work/bosch/temp.git/
geert-boschs-computer:/tmp%git init temp
Initialized empty Git repository in /private/tmp/temp/.git/
geert-boschs-computer:/tmp%cd temp
geert-boschs-computer:/tmp/temp%echo hello>world
geert-boschs-computer:/tmp/temp%git add world
geert-boschs-computer:/tmp/temp%git commit -m "Add hello" world
[master (root-commit) 10837b9] Add hello
 1 files changed, 1 insertions(+), 0 deletions(-)
 create mode 100644 world
geert-boschs-computer:/tmp/temp%git push --all kwai:/work/bosch/temp.git
Counting objects: 3, done.
Writing objects: 100% (3/3), 211 bytes, done.
Total 3 (delta 0), reused 0 (delta 0)
To kwai:/work/bosch/temp.git
 * [new branch]      master -> master
geert-boschs-computer:/tmp/temp%git push -u --all kwai:/work/bosch/temp.git
Branch master set up to track remote branch master from kwai:/work/bosch/temp.git.
Everything up-to-date
geert-boschs-computer:/tmp/temp%git remote -v
geert-boschs-computer:/tmp/temp%git push
Everything up-to-date

So, there is a remote that gets used automatically by git push and git pull,
but it's not obvious which one. Basically, a "git info" command should give
a dozen lines or so that allows one quickly to identify a repository, including
current branch, any remote it tracks, last commit, wether the working directory
is clean, wether anything is staged for commit, wether the repository tracks
a non-git (svn, bzr, hg) repository.

> 
> And then for the branch etc you can do (although it doesn't list the author):
> 
> $ git branch -v
While both commands are very useful, I think a case can be made for a single
command that pulls together enough information in a few lines that it is clear.

I'll see if I can cobble something up.