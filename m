From: Avery Pennarun <apenwarr@gmail.com>
Subject: Re: Subtree merging of sub-directories between repositories?
Date: Sun, 2 Aug 2009 14:53:31 -0400
Message-ID: <32541b130908021153j28872a34v84dccfdfbc99b607@mail.gmail.com>
References: <2729632a0908012337l6d84ba76o81239d324ba11cf2@mail.gmail.com> 
	<32541b130908020130q11f1fa03yca276ab86c2ea4d5@mail.gmail.com> 
	<2729632a0908021105m10bfb8ddx700464d06fd38023@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Sun Aug 02 20:54:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MXgC7-0000tZ-0V
	for gcvg-git-2@gmane.org; Sun, 02 Aug 2009 20:54:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753332AbZHBSxv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Aug 2009 14:53:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753302AbZHBSxv
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Aug 2009 14:53:51 -0400
Received: from mail-yx0-f175.google.com ([209.85.210.175]:58747 "EHLO
	mail-yx0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753301AbZHBSxu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Aug 2009 14:53:50 -0400
Received: by yxe5 with SMTP id 5so1506398yxe.33
        for <git@vger.kernel.org>; Sun, 02 Aug 2009 11:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=LyxzM0+GJAcKDxlLGqWAfKtYlWQnGbpSxGAZacD+CpU=;
        b=ZyFmxaQ3cV/KKtOfgohPdC0nlzgRHHSgtJUdOl3qFPiD77z+5z4AScnq+Qi0qSRrd6
         Vi2fkhv8CPjaVb/zY21wnLxCxgbhA1Lw6AyIJPry9ZvTVClGce6+fdgkOmEXtY64s5dj
         X/9pGYEl3peLn65ElINE/viNE+zdYafusN8EY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=BPX5KmFeNl3TkyjJHb77D6/mcoQibM1eVaSVwQay4y+OtbD2y7A36IBjavY1E8RhJp
         EJo3gUZGdlxmXEqVGDAfhrnmB3F8A7oqacjVY2ksBPvwZqEHnL3lRYVM67ddz5Ip+yMA
         YNOHYLZWaAe16fxeBFfk0CAVfBJ3sPJKPxR9Y=
Received: by 10.151.50.18 with SMTP id c18mr8951121ybk.98.1249239231047; Sun, 
	02 Aug 2009 11:53:51 -0700 (PDT)
In-Reply-To: <2729632a0908021105m10bfb8ddx700464d06fd38023@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124675>

On Sun, Aug 2, 2009 at 2:05 PM, <skillzero@gmail.com> wrote:
> On Sun, Aug 2, 2009 at 1:30 AM, Avery Pennarun<apenwarr@gmail.com> wrote:
>> 2) Use "git subtree split" to take the subdir of A and give it a
>> history of its own, then merge that history into a subdir of B (using
>> "git subtree add" or any other subtree merge method you want to use).
>> You can then git subtree split/merge back and forth between A and B in
>> the future to copy future changes from one to the other.
>
> Thanks for the help. I tried #2 and it sort of worked. The history was
> imported, but the resulting paths were flattened. Here's what I did:
[...]
> The full history doesn't seem to be associated with that directory. If
> I do 'git log --name-only --topo-order', I see the full history, but
> the files are listed as:
>
> file.c
>
> and I was expecting to see:
>
> X/Y/C/file.c
>
> Because I'd want to be able to do 'git log X/Y/C' and see all the
> commits that affect that directory.

Yeah, this is a tricky one.  Git has all the necessary information to
"know" that the files were "moved" from file.c (in the subtree project
history) to X/Y/C.file.c (in your superproject).  But "git log"
doesn't use this information for anything at the moment, and
"--follow" doesn't seem to make it work.

Since I don't have the required skills or knowledge to fix git's
history following, my hope is that this will magically start working
in a future version of git because someone like you gets annoyed with
it :)

Have fun,

Avery
