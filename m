From: Bryan Donlan <bdonlan@gmail.com>
Subject: Re: unpack a single object
Date: Tue, 11 Aug 2009 16:49:11 -0400
Message-ID: <3e8340490908111349j323812dbmf2211e4cf454b8f1@mail.gmail.com>
References: <905315640908111315j459b81f2jc414f2a09c6b830e@mail.gmail.com> 
	<3e8340490908111348o5df64aa1md1ad8901e857ecb6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: tarmigan <tarmigan+lists@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 22:49:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MayI6-0005RV-9G
	for gcvg-git-2@gmane.org; Tue, 11 Aug 2009 22:49:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754509AbZHKUte convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Aug 2009 16:49:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754508AbZHKUtd
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Aug 2009 16:49:33 -0400
Received: from mail-ew0-f214.google.com ([209.85.219.214]:59173 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754450AbZHKUtc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Aug 2009 16:49:32 -0400
Received: by ewy10 with SMTP id 10so4095762ewy.37
        for <git@vger.kernel.org>; Tue, 11 Aug 2009 13:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=YUlYeHYp52rSdWbzB0136zV05Rkgk1QGf1CGbK6DXOY=;
        b=eMUjWVzQDHa7cwSDyMCb+c/C4/YFty+9yAPlTrKVCpS6KaVG5GRX4EFf4dvxNqUcEb
         L9FJRt2X1KAZ1AKpJiMBr8OjDCkUE5wOHvaUAB6zUFfzc8Y0Fc7ctsoxThSFnKBAkLyf
         AJPzYQYzSiAD6lI9TnnA6LXuLcaPHa55Wr/S4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Z3ehUu5rPcwLnG/VmwhMQz42lep9m3qnOljU0yRwo7SrKbV36fX+iprlrGtTI3dYJ2
         MxRhPS3ZCQ1NzR2d7OnpSj7w2GMzVI+DDFQAr9EN6FzBAp7AWVrHijBLmmoZ63KIe0Q3
         5Hg0gx+3+184r8Ebdy/9fRG1EOKTHimZlt56Y=
Received: by 10.216.74.78 with SMTP id w56mr1391800wed.105.1250023771443; Tue, 
	11 Aug 2009 13:49:31 -0700 (PDT)
In-Reply-To: <3e8340490908111348o5df64aa1md1ad8901e857ecb6@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125594>

On Tue, Aug 11, 2009 at 4:48 PM, Bryan Donlan<bdonlan@gmail.com> wrote:
> On Tue, Aug 11, 2009 at 4:15 PM, tarmigan<tarmigan+lists@gmail.com> w=
rote:
>> Hi,
>>
>> At work we use SVN. =A0To deal with this I mirror the svn repo with
>> git-svn and have a cron job that runs git svn rebase every hour, and
>> then I rebase from that git repo.
>>
>> Unfortunately, on the computer that runs the cron job, /home ran out
>> of space. =A0After making more space and deleting the
>> svn/trunk/.rev_map, my 'git svn rebase' dies with a
>>> git svn rebase
>> Rebuilding .git/svn/trunk/.rev_map.4279b43a-dd95-8640-b069-b0d2992e4=
ff2 ...
>> error: Could not read 3d4c2b0225e7605a7e2a38ffc44dcb888589f4ce
>> fatal: Failed to traverse parents of commit
>> 31c4379db99f05d0942e7c204b38f7b587fb4d3b
>> rev-list --pretty=3Draw --no-color --reverse refs/remotes/trunk --:
>> command returned error: 128
>>
>> So I look for corruption with
>>> git fsck --full --strict
>> broken link from =A0commit 31c4379db99f05d0942e7c204b38f7b587fb4d3b
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0to =A0commit 3d4c2b0225e7605a7e2a38ffc44d=
cb888589f4ce
>> dangling blob a6027cd01178f19243342c0f6ccaef8fb798dcf4
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0<snipped more dangling blobs>
>> dangling blob 4348d7ebd189208716b44bcf4198c1f29d18e6c3
>> missing commit 3d4c2b0225e7605a7e2a38ffc44dcb888589f4ce =A0******
>> dangling blob 22757bac2e3433cccd9d7e32fa79d90031e14353
>> dangling blob 1276575eca02976ff677b61a6873562db7db31d7
>> dangling blob f98343007ac9d2f33a81fe25f4d446b045c3167a
>> dangling blob d29043a6e2b87cd0be1f3fb39f0c88283b79409b
>> dangling blob f7d08b39830709c044279d17d3d85cbe813998bb
>> dangling blob 64f14b305164f65c788dc9970deb7dfc79ac7446
>>
>> Thankfully, I have copies of the repo and this object (3d4c2b) in
>> other location and that passes git-fsck. =A0Strangely, it is a commi=
t
>> object from about 18 month ago and should have been in a pack for a
>> long time, so maybe running out of disk space was not the cause.
>>
>> I would rather not copy the whole good repo back to the one that ran
>> out of space because it's multiple gigs. =A0My plan is to just explo=
de
>> the bad pack on of the corrupted repo, explode good pack and then,
>> copy the corrupted object back. =A0So my question is how do I tell w=
hich
>> pack contains that object? =A0(I would rather not explode all the pa=
cks
>> because of the repo size.) =A0Is there a way to extract a single obj=
ect
>> from a pack without exploding the whole pack?
>
> You should be able to just extract the single object in question:
>
> goodrepo$ git cat-file commit 3d4c2b0225e7605a7e2a38ffc44dcb888589f4c=
e
> =A0> ~/commit.dat
> goodrepo$ cd ~/badrepo
> badrepo$ git read-file -t commit ~/commit.dat
> (should output 3d4c2b0225e7605a7e2a38ffc44dcb888589f4ce)
>
> At this point your repo should be repaired.
>

Err, that should read git hash-object, not git read-file.
