From: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>
Subject: Re: [StGit PATCH] edit: Allow setting git tree SHA1 of a patch
Date: Fri, 21 May 2010 17:32:28 +0200
Message-ID: <AANLkTimYCxzT16aI96dztmcKYuVrvKikSkrkRHT-Ckcd@mail.gmail.com>
References: <20100516172738.5043.94039.stgit@localhost.localdomain>
	 <AANLkTikcG3Chw1cpiKB00MrnZz-HZk9xAF_KtTTiVECi@mail.gmail.com>
	 <u5tzkzt73us.fsf@beatles.e.vtech>
	 <AANLkTilV3VQARdyZ-m9GCXz1Rwt0j6Q6noNyFrmmDzR5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>,
	kha@treskal.com, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 21 17:40:34 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFUKv-00075X-Dr
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 17:40:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757467Ab0EUPk2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 11:40:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:34490 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755880Ab0EUPk1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 11:40:27 -0400
Received: by fxm5 with SMTP id 5so972812fxm.19
        for <git@vger.kernel.org>; Fri, 21 May 2010 08:40:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=UXSGfK+Dpi3Qana0CsuPGpIqIH1elvVMXZK9x2wRaKg=;
        b=Ys+6vdPV25a5RTJ89KShxNhbfSsbVA+Tg4lzJfuny8evHZz9AmLfPw68S8u2OKpVah
         yumR/y613joUCEPYt1b1W5jmvXoA87jVlScO+Y+hDGhswxJH3BF5e7D98NGjXYswaHF/
         O0JQEAaAuR5FgO5xegYaRPkCg72M+RL/vfs1A=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Sk8f8UaKe2sUmqEvmKJCZdsRqjoj70QcHGO5euKOe1nq/4aqpFrOCUMf2uplcv5cFT
         WCjmhXjdE7x808506daFLKD9VpYLjZ5IuUaqYgyYpTkjXAUx5q7UKbpwazHxxW2u2n4E
         maPdNIL5ijhSYKVmtBwGKxhpyJbquhMu7u0c8=
Received: by 10.204.161.211 with SMTP id s19mr110022bkx.129.1274455948333; 
	Fri, 21 May 2010 08:32:28 -0700 (PDT)
Received: by 10.204.76.68 with HTTP; Fri, 21 May 2010 08:32:28 -0700 (PDT)
In-Reply-To: <AANLkTilV3VQARdyZ-m9GCXz1Rwt0j6Q6noNyFrmmDzR5@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147470>

> On 21 May 2010 14:59, David K=E5gedal <davidk@lysator.liu.se> wrote:
>> The idea is that Gustav wants to allow the editing of a file as it
>> appears in an earlier version. Lets say you have patches A, B, C and
>> D. You realize that one of the changes in to foo.c in C shuold reall=
y be
>> done in A. So you open the "A version of foo.c" in your editor, do t=
he
>> change, and then save it. The save operation needs to update A to be
>> the new tree that contains the updated foo.c, and the remaining patc=
hes
>> will keep their tree. The effect is that the moved change now appear=
s as
>> a diff in A, but not in C (nor B or D).

David's example does not exactly describe the situation I have in
mind. I was only envisaging the possibility to move a change from one
patch to one of its neighbours. This is enforced by keeping all other
trees intact.

On Fri, May 21, 2010 at 5:16 PM, Catalin Marinas
<catalin.marinas@gmail.com> wro> This is currently achieved by "pop B
C D", edit file, "refresh", "push
> --set-tree B C D".
>
> Can "edit --set-tree <sha1>" make this simpler? Which <sha1> value
> would be used with "edit --set-tree" (unless that's done by Emacs mod=
e
> behind the scene and it generates the tree that gets passed to edit).

This is indeed my assumption. Without a "smart" user interface to hide
the intricacies this operation becomes too complicated. At least
unless you work exclusively with the index. My prototype for the Emacs
mode approximately does 'read-tree <old patch sha1>', 'update-index
--cache-info <new blob>', 'stg edit --set-tree $(write-tree)'.

I actually think it is the use of the Emacs user interface that really
enabled us (me and my colleagues) to see the stack as a living set of
changes that are very easy to edit. This lead to the conclusion that
one wants to make it much easier, light-weight and faster to move
individual changes between (for a start, neighbouring) patches.

As you point out, there are a number of ways to do these things
already; this is all about making it very easy.

- Gustav
