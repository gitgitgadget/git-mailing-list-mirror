From: Gelonida <gelonida@gmail.com>
Subject: Re: git clone / git pull to USB memory stick (FAT) and symlinks
Date: Thu, 11 Nov 2010 19:03:48 +0100
Message-ID: <ibhb64$51p$1@dough.gmane.org>
References: <ibh605$adm$1@dough.gmane.org> <7vk4kjhhjh.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 11 19:04:43 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PGbVn-00013R-7c
	for gcvg-git-2@lo.gmane.org; Thu, 11 Nov 2010 19:04:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755716Ab0KKSEH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Nov 2010 13:04:07 -0500
Received: from lo.gmane.org ([80.91.229.12]:41539 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755520Ab0KKSED (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Nov 2010 13:04:03 -0500
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <gcvg-git-2@m.gmane.org>)
	id 1PGbVB-0000hb-Ss
	for git@vger.kernel.org; Thu, 11 Nov 2010 19:04:01 +0100
Received: from unicorn.dungeon.de ([81.56.82.123])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 19:04:01 +0100
Received: from gelonida by unicorn.dungeon.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 11 Nov 2010 19:04:01 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: unicorn.dungeon.de
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 ""
In-Reply-To: <7vk4kjhhjh.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161282>

On 11/11/2010 06:54 PM, Junio C Hamano wrote:
> Gelonida <gelonida@gmail.com> writes:
> 
>> I thought about cloning a remote git repository onto the stick
>> and performing
>> - regular pulls in order to update the USB stick
>> - occasional pushes in orderto publish changes performed on the stick.
> 
> ... missing is the reason why this is done to a USB memory stick.  More
> specifically,...

The idea is to have a few administrator keys .


These administrator keys would be plugged into network less PCs. (no git
installed)


I wanted to use git to use these keys up to date.

As the write speed to USB keys is slow I thought about using git in
order to avoid copying wrting already up to date config scripts and tools.

Occasionally one might encounter errors in the setup scripts and fix
them immediatel with word pad on the targe system.

Thus the idea to change files directly on the USB key.

When repluging the key nto a development host one could pull / push in
order to update the central repositroy and all other users just ahd to
pull again to their keys.


I hope this explains why I thought about having
- a non bare repository on a USB stick
- due to historical reasons some sym links might be in the repository.
  thus my question of how to let git ignore these sym links.
   If this is not possible, then I would probably create a new
	symlink-less git repository


> 
>> 1.) Ignore skip / symlinks
>> 2.) Avoiding file permission issues: Is this sufficient
> 
> These become non-issues _if_ the reason you are putting this on an USB
> stick is to safekeep and sneakernet the project data, and are not
> interested in having a working tree on the stick, which I often find is
> the use case after grilling people who ask about placing git repositories
> on an USB stick.
> 
> And the commands to interact with such a repository without a working tree
> are to "push" (into it), and "fetch" (from it).  IOW, you do not "pull"
> into USB stick.
> 
> If you do need a working tree on the stick, and the stick has a FAT
> derived filesystem (which would be the most common), then you would need
> 
>> git config --add core.fileMode false
> 
> and perhaps "core.symlinks false" also would help
