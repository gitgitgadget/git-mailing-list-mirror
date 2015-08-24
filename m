From: Rafik E Younan <rafik.arkdev@gmail.com>
Subject: index file list files not found in working tree
Date: Mon, 24 Aug 2015 12:34:43 +0200
Message-ID: <55DAF343.2050908@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 24 12:34:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZTp5d-0006eA-Mb
	for gcvg-git-2@plane.gmane.org; Mon, 24 Aug 2015 12:34:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbbHXKex (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Aug 2015 06:34:53 -0400
Received: from mail-wi0-f175.google.com ([209.85.212.175]:35747 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbbHXKew (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Aug 2015 06:34:52 -0400
Received: by wicne3 with SMTP id ne3so67800979wic.0
        for <git@vger.kernel.org>; Mon, 24 Aug 2015 03:34:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-type:content-transfer-encoding;
        bh=PmtWvbKPpe+xX2KJZyp7h1E5RPAON1ENphLvyV23kEw=;
        b=VptwnWsGvjzV+c9VdglGv4VOQK6fmGSYxR3YlwIjgF7c4jfZhOdgKLJLhyh4ZcwdAK
         /pqXz878Br3zuL0a1WAWH8w+kd7i2XQNMrNGs5lunYPqFbzHhhIzvcXiIYYBi8NZrVUj
         o0xYhTcAQiNyY+mtsL6JmmLNna44kwHEL4mIVgtAKVhqtREDvEyCUnoQ26AoDI0/IAof
         2RhPK5+FMG4pU0fnH8JMew96wmqOaUr7f+UMhV2LCqvmeAz8GEAA9/+hLIBB1mGQILcH
         Ontrz/lp9k+lZYZItPdmME16ufU53QDa13osnWxbrqyU7pkW+nLofiyxxiFLeG42uRqZ
         3Sxg==
X-Received: by 10.195.11.202 with SMTP id ek10mr39611989wjd.12.1440412491125;
        Mon, 24 Aug 2015 03:34:51 -0700 (PDT)
Received: from [192.168.1.115] ([196.205.146.227])
        by smtp.googlemail.com with ESMTPSA id n6sm15541783wix.1.2015.08.24.03.34.46
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Aug 2015 03:34:50 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276444>

Hi,

After several merges and rebases I finally got my branches and history 
to reflect valid commits and proper history. Everything is pushed to 
internal bare repo and the remotes seems OK.

When I clone the updated repository, all branches reflect the correct 
updated trees and blobs.

The problem occurs only on the original local repository where all the 
merging and re-basing took place!

When I checkout a branch, several files and folders are deleted from the 
working tree. When I examine the history of these files, there are only 
commits of adding them and modifying them but no log for deleting them, 
and they aren't deleted when I checkout the same branch in another fresh 
cloned repo.

Git status command doesn't indicate any changes in these files. I found 
the files and folders names in the `.git/index` file. So after manually 
removing the `.git/index` file and usinge `git reset` command, `git 
status` indicates that the files and folders are deleted.

I use `git checkout -- <File_or_folder_names>...` and restore all 
missing files and folders, just then the working tree matches the fresh 
checkout of the same branch on any other cloned repo.

After examining the tree object of the current commit, all files and 
folders exists, although clearly the checkout missed some of them!

Because the repository is local and private, I can't share any url for 
publicly accessible repository, and if one exists, no problem could be 
found, because the problem resides in just this certain local clone.

Answering the following questions might give some clues for the problem:
* How does git populate the index file after every branch checkout?
* Is there any object to reflect the content of the index file?

I would appreciate any pointers for where the problem could be.

Thanks,
Rafik
