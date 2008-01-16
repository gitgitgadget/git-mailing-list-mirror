From: Luke Lu <git@vicaya.com>
Subject: Re: I don't want the .git directory next to my code.
Date: Tue, 15 Jan 2008 20:55:49 -0800
Message-ID: <D017F6F6-D674-428B-936B-181BF20CF4B5@vicaya.com>
References: <478D79BD.7060006@talkingspider.com> <ee77f5c20801152006w11307ce0j17463f1c6536543f@mail.gmail.com> <478D85A9.6050807@talkingspider.com>
Mime-Version: 1.0 (Apple Message framework v753)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: David Symonds <dsymonds@gmail.com>, git@vger.kernel.org
To: Mike <fromlists@talkingspider.com>
X-From: git-owner@vger.kernel.org Wed Jan 16 05:56:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JF0KA-00011t-98
	for gcvg-git-2@gmane.org; Wed, 16 Jan 2008 05:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751484AbYAPEz6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jan 2008 23:55:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbYAPEz6
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jan 2008 23:55:58 -0500
Received: from rv-out-0910.google.com ([209.85.198.191]:64459 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751078AbYAPEz5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jan 2008 23:55:57 -0500
Received: by rv-out-0910.google.com with SMTP id k20so99799rvb.1
        for <git@vger.kernel.org>; Tue, 15 Jan 2008 20:55:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        bh=D63wgy2zZ/P4+rE6KOBHUmbFUSoz8rbZp6pp3xa7ccQ=;
        b=vM6vpYBMKmfxriolRfZrwOhVlVdNjYw+NgG3zPG13+pE5sNeyba8z9GcbkQN+QblLdBHBHKi1G9gy0rVwHL52BNlcyqjk6OlYzXndo5pfFKXgTbwJsf1sbkSWAiv9LhIXHWEYHwR6VtbN4c6mVqhPUUYd5w7htGwZ6txZ+jnkyI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=in-reply-to:references:mime-version:content-type:message-id:cc:content-transfer-encoding:from:subject:date:to:x-mailer:sender;
        b=B8ChSVjLMHibHQyBZSDw1iRaOOMlEt/xMTYYeJXPTasCsry39v9waWWfCnDC7c8LO7+bfhgwNnu6ECkm8wpxYTVnULZp2bdUNZcF+73U17D7grROMYx1O/lvLT74WahihR3GTtTN4rj9tZYa/Tstic1QsVOL/il2p6W39Ug2o0Q=
Received: by 10.141.98.13 with SMTP id a13mr240726rvm.222.1200459353429;
        Tue, 15 Jan 2008 20:55:53 -0800 (PST)
Received: from ?192.168.15.20? ( [98.207.63.2])
        by mx.google.com with ESMTPS id c19sm1054104rvf.30.2008.01.15.20.55.50
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Jan 2008 20:55:51 -0800 (PST)
In-Reply-To: <478D85A9.6050807@talkingspider.com>
X-Mailer: Apple Mail (2.753)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70632>


On Jan 15, 2008, at 8:18 PM, Mike wrote:

>
> David Symonds wrote:
>> On Jan 16, 2008 2:27 PM, Mike <fromlists@talkingspider.com> wrote:
>>> 2. If I tar/gz my code and deliver it to a client, I don't want  
>>> the .git
>>> dir slipping into the tarball, allowing my client to be able to  
>>> peruse
>>> the history of what we did and when.
>> Use git-archive.
>
> Thanks but this isn't sufficient. If we have one directory of our  
> web root in a git repository, say docroot/php, and we tar up  
> docroot, it will include php/.git.  We don't want that.  We would  
> have to go out of our way to avoid the .git directory.  The point  
> is, we don't want anything in docroot that shouldn't be made live.

git-archive generates an archive file *without* the .git directory.  
 From git-archive(1):

   git archive --format=tar --prefix=junk/ HEAD | (cd /var/tmp/ &&  
tar xf -)
               Create a tar archive that contains the contents of the  
latest
               commit on the current branch, and extracts it in /var/ 
tmp/junk
               directory.

   git archive --format=tar --prefix=git-1.4.0/ v1.4.0 | gzip >  
git-1.4.0.tar.gz
               Create a compressed tarball for v1.4.0 release.

   git archive --format=tar --prefix=git-1.4.0/ v1.4.0^{tree} | gzip  
 >git-1.4.0.tar.gz
               Create a compressed tarball for v1.4.0 release, but  
without a
               global extended pax header.

   git archive --format=zip --prefix=git-docs/ HEAD:Documentation/ >  
git-1.4.0-docs.zip
               Put everything in the current head's Documentation/  
directory
               into git-1.4.0-docs.zip, with the prefix git-docs/.

IMHO, git export is probably a better name for the command. git- 
archive sounds like backup everything associated with git.

__Luke
