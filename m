From: Liu Yubao <yubao.liu@gmail.com>
Subject: Re: [RFC] separate .git from working directory
Date: Thu, 12 Oct 2006 12:07:58 +0800
Message-ID: <452DBF9E.7010900@gmail.com>
References: <fcaeb9bf0610110623q365d3ffcw9ba9e11936d03a9d@mail.gmail.com>	 <BAYC1-PASMTP10003954B66E10247020A7AE140@CEZ.ICE> <fcaeb9bf0610111455y225237cmdbaadbf294686d8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sean <seanlkml@sympatico.ca>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 12 06:08:50 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GXrsF-0001Ec-TP
	for gcvg-git@gmane.org; Thu, 12 Oct 2006 06:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422763AbWJLEIo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Oct 2006 00:08:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422767AbWJLEIo
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Oct 2006 00:08:44 -0400
Received: from qb-out-0506.google.com ([72.14.204.234]:59703 "EHLO
	qb-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1422763AbWJLEIo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Oct 2006 00:08:44 -0400
Received: by qb-out-0506.google.com with SMTP id p36so26999qba
        for <git@vger.kernel.org>; Wed, 11 Oct 2006 21:08:43 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=OR8jsE29cinPBBowE0Kh3xZAC/MbGR05DX1Zj6F0J2UHoRWl2EuBy7lGBfxLboOkzfj+NvQVDtXdiSngMfr1qizA3Q7XhXaSovyc7oDceznCflJ5VtZc+Ak71loS/oMNDTmG1CIIdIrb000oRX1Q4jNV+Cv+zqURWcnALyEQeDs=
Received: by 10.35.77.1 with SMTP id e1mr2323574pyl;
        Wed, 11 Oct 2006 21:08:42 -0700 (PDT)
Received: from ?192.168.88.85? ( [221.122.47.70])
        by mx.google.com with ESMTP id 15sm1371928nzn.2006.10.11.21.08.41;
        Wed, 11 Oct 2006 21:08:42 -0700 (PDT)
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
In-Reply-To: <fcaeb9bf0610111455y225237cmdbaadbf294686d8e@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28769>

Nguyen Thai Ngoc Duy wrote:
> On 10/11/06, Sean <seanlkml@sympatico.ca> wrote:
>> You can export a GIT_DIR manually pretty easily if you want to move
>> the .git directory somewhere else.  Also you could make a "git find"
>> shell script named "gf" that does something like:
>>
>> #/bin/sh
>> find "$@" ! -path '*/.git/*'
>>
>> Which would let you type  "gf -name blah" and automatically ignore
>> the .git directory.
> 
> It should work. However I would rather use "normal" find than
> specialized ones. Imagine somedays I hate find and start to love grep,
> I would have to find out --exclude option and create new "gg" script.
> In worse cases where recursive commands don't support filtering, I
> have no chance to filter out .git directories.
> 
Subversion puts a .svn/ in every directory under control, I dislike this
feature, I have to use many wrapper scripts.

Maybe the svk way is worth considering, it maintains a map relation
between paths in repository and file system like this:

$ svk checkout --list
           depot path			path
==================================================================
//path/in/repos/hello/world.c           /path/in/fs/hello/world.c

The problem is users must maintain this map when move or delete
/path/in/fs/hello/world.c, it's a bit annoying.

see http://svkbook.elixus.org/nightly/en/svk-book.html#svk.ref.svk.c.checkout
for more information.
