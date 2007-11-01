From: Bill Lear <rael@zopyra.com>
Subject: Re: Question on git-filter-branch
Date: Thu, 1 Nov 2007 07:19:05 -0600
Message-ID: <18217.53833.710503.667761@lisa.zopyra.com>
References: <18217.52425.655322.52338@lisa.zopyra.com>
	<20071101125845.GA27567@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Nov 01 14:19:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InZxS-00022v-SD
	for gcvg-git-2@gmane.org; Thu, 01 Nov 2007 14:19:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755295AbXKANTZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Nov 2007 09:19:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754297AbXKANTZ
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Nov 2007 09:19:25 -0400
Received: from mail.zopyra.com ([65.68.225.25]:60512 "EHLO zopyra.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754159AbXKANTY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Nov 2007 09:19:24 -0400
Received: (from rael@localhost)
	by zopyra.com (8.11.6/8.11.6) id lA1DJAH13769;
	Thu, 1 Nov 2007 07:19:10 -0600
In-Reply-To: <20071101125845.GA27567@glandium.org>
X-Mailer: VM 7.18 under Emacs 21.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62955>

On Thursday, November 1, 2007 at 13:58:45 (+0100) Mike Hommey writes:
>On Thu, Nov 01, 2007 at 06:55:37AM -0600, Bill Lear wrote:
>> In my repo, I have sensitive files A, C, and a directory full of
>> sensitive stuff I want to remove forever from the git repository.
>> 
>> % ls
>> A B C D sensitive_stuff
>> 
>> % git --version
>> git version 1.5.3.5
>> 
>> % git filter-branch --index-filter 'git update-index --remove A' HEAD
>> Rewrite 5dd7d5f2d7d3a5f43c242188ac96294628267673 (7/7)
>> Ref 'refs/heads/master' was rewritten
>> 
>> These refs were rewritten:
>> % ls
>> B  C  D  sensitive_stuff
>> 
>> % git status
>> # On branch master
>> nothing to commit (working directory clean)
>> 
>> Ok, so I guess it has done what I wanted.  So, I try to remove the
>> next file that has sensitive information in it:
>> 
>> % git filter-branch --index-filter 'git update-index --remove C' HEAD
>> Namespace refs/original/ not empty
>
>Just remove .git/refs/original/

Ok, thanks.  But, how do I remove the subdirectory?

% rm -rf .git/refs/original
% git filter-branch --index-filter 'git update-index --remove sensitive_stuff' HEAD
Rewrite 6711f6a50605918326f67ca0c3402eab9a4c8571 (8/8)
WARNING: Ref 'refs/heads/master' is unchanged

% ls sensitive_stuff
E  F  G
% git filter-branch --index-filter 'git update-index --remove sensitive_stuff/*' HEAD
Rewrite 6711f6a50605918326f67ca0c3402eab9a4c8571 (8/8)
WARNING: Ref 'refs/heads/master' is unchanged

% ls sensitive_stuff
E  F  G

% cd sensitive_stuff
% git filter-branch --index-filter 'git update-index --remove E F G' HEAD
fatal: Not a git repository: '.git'
You need to run this command from the toplevel of the working tree.


Bill
