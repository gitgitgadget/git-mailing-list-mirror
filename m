From: Jon Forrest <nobozo@gmail.com>
Subject: Re: A Basic Git Question About File Tracking [ANSWERED]
Date: Sat, 08 Oct 2011 19:42:28 -0700
Message-ID: <4E910A14.7040801@gmail.com>
References: <j6dlhf$dp3$1@dough.gmane.org> <20111004011035.GA13836@elie> <4E8A5DF0.6040003@gmail.com> <20111004012244.GB13836@elie> <4E90E60C.7060105@gmail.com> <m3ipnz0xri.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-4; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 04:44:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCjNh-0002Cy-Jq
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 04:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751520Ab1JICok (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 22:44:40 -0400
Received: from mail-yw0-f46.google.com ([209.85.213.46]:43505 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751512Ab1JICoj (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 8 Oct 2011 22:44:39 -0400
Received: by ywb5 with SMTP id 5so4579425ywb.19
        for <git@vger.kernel.org>; Sat, 08 Oct 2011 19:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=6RN1oyl4qBveBTUovxNi7T4IiWYZ3w5M3FPi7DtVCaA=;
        b=fbDXtLG9Nit5/wVbYDwpqaWSEoJpDA13hUndTsXVJz820WhaSBIqmIwzGuHXHxzf47
         jdg9mJLAQfzKtRxaiYNpw0Iv8jEo9DqWCCUgkalHl3YpFDzEg2StHYJcZ1leRVtyyJ47
         4pZx3fYPB4GajDkSFhUzthTu6C4kWibc/nsf0=
Received: by 10.68.4.201 with SMTP id m9mr25865396pbm.40.1318128278794;
        Sat, 08 Oct 2011 19:44:38 -0700 (PDT)
Received: from [192.168.0.107] (c-98-248-228-38.hsd1.ca.comcast.net. [98.248.228.38])
        by mx.google.com with ESMTPS id ki1sm50028524pbb.3.2011.10.08.19.44.37
        (version=SSLv3 cipher=OTHER);
        Sat, 08 Oct 2011 19:44:38 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
In-Reply-To: <m3ipnz0xri.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183182>

On 10/8/2011 6:17 PM, Jakub Narebski wrote:

> You seem to be under [false] impression that git commit is about
> _changes_ / _changeset_.

This is correct. The Pro Git book says:

"You stage these modified files and then commit
all your staged changes"

Plus, even "git status" tells me

$ git status
# On branch master
# Changes to be committed:

But I see my error. Below is what I hope is a clear
explanation of what I didn't understand. It presumes
that the reader understands the git objects model.
Please let me know if anything is incorrect.
----------
When you "git add" a file two things happen:

1) The file is copied to the git objects tree.
This location where the file is copied depends
on the hash of the file's content.

2) An entry for the file is added to the git index.
This entry includes the same hash that was mentioned
in #1.

A tracked file has an entry in the git index file.
A copy of the file also exists in the objects tree.

When you run 'git status', git computes the hash of
every file in your working directory and looks
up each file in the index. If the file isn't found
then the file is shown as untracked.

When you do a commit, the hash values of everything
in the index are copied into a tree object. The hash
value of the tree object is then placed in a commit object.
No copies of tracked files in the working directory are
made at commit time. This is because the files were already
copied into the objects tree when 'git add' was run.
This is one reason why git commits are so fast.

-----

How's that?

Thanks to everyone for sticking with me on this.

Jon
