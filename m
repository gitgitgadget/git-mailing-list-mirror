From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: Re: [StGit PATCH] edit: Allow setting git tree SHA1 of a patch
Date: Fri, 21 May 2010 16:16:18 +0100
Message-ID: <AANLkTilV3VQARdyZ-m9GCXz1Rwt0j6Q6noNyFrmmDzR5@mail.gmail.com>
References: <20100516172738.5043.94039.stgit@localhost.localdomain>
	 <AANLkTikcG3Chw1cpiKB00MrnZz-HZk9xAF_KtTTiVECi@mail.gmail.com>
	 <u5tzkzt73us.fsf@beatles.e.vtech>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?ISO-8859-1?Q?Gustav_H=E5llberg?= <gustav@gmail.com>,
	kha@treskal.com, git@vger.kernel.org
To: =?ISO-8859-1?Q?David_K=E5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Fri May 21 17:16:32 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFTxa-0002zz-Us
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 17:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758170Ab0EUPQV convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 21 May 2010 11:16:21 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:64285 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754781Ab0EUPQU convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 21 May 2010 11:16:20 -0400
Received: by fg-out-1718.google.com with SMTP id d23so1096571fga.1
        for <git@vger.kernel.org>; Fri, 21 May 2010 08:16:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=qUCqQMn/tCh4XxXq/J6GBHgwiXAOxJAUKUfcmSAW210=;
        b=NqrX7IrMkVwok1Zd96fZwcESANGQBIaxmAth4V50M/c9YPsntu1fcCTkOYo1ybJZa0
         SxAfMSlyJOsqmPcU9topJhOZPhhoQXir3MpA/SbVuO7a62pq1n5LWl/VuVKW+xzMzciU
         a/THYgwN5hMUwDzq/Qw2K1wlol33rHiBjDBKc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=MUvoIr6XHtwMK3QNyjc9nv6FJIo5KB6AISu2hJhPJG98/KLri1hb06F9vQD/JzjQ7q
         XvobTUsoQzM+A9JgpIxwi0GQG+OXiKL00Ity8La8wv8ew+F+dCJEW/lhR/S1bv57jDyt
         TTbJFWIRtTFgD0nDKcsMDviPkSZV4BJiKHjus=
Received: by 10.223.62.202 with SMTP id y10mr1566386fah.100.1274454978601; 
	Fri, 21 May 2010 08:16:18 -0700 (PDT)
Received: by 10.223.117.204 with HTTP; Fri, 21 May 2010 08:16:18 -0700 (PDT)
In-Reply-To: <u5tzkzt73us.fsf@beatles.e.vtech>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147463>

On 21 May 2010 14:59, David K=E5gedal <davidk@lysator.liu.se> wrote:
> Catalin Marinas <catalin.marinas@gmail.com> writes:
>> 2010/5/16 Gustav H=E5llberg <gustav@gmail.com>:
>>> I would like to have something similar to this patch, which allows =
for
>>> setting the (git) tree of a particular patch. I would like to use i=
t
>>> (from the Emacs mode) to make it easier to split an old patch into =
two
>>> (or more).
>>>
>>> It might be that this is too "powerful" (read: unsafe), and maybe a
>>> better (safer) command would use whatever is currently in the index
>>> rather than a SHA1.
>>
>> I'm not against such option (as long as it is somehow mentioned that=
's
>> dangerous) though I don't fully understand how one would use it,
>> especially when the patch is buried under other patches. With a seri=
es
>> of patches, any easily accessible tree (sha1) belongs to one of the
>> patches.
>
> The idea is that Gustav wants to allow the editing of a file as it
> appears in an earlier version. Lets say you have patches A, B, C and
> D. You realize that one of the changes in to foo.c in C shuold really=
 be
> done in A. So you open the "A version of foo.c" in your editor, do th=
e
> change, and then save it. The save operation needs to update A to be
> the new tree that contains the updated foo.c, and the remaining patch=
es
> will keep their tree. The effect is that the moved change now appears=
 as
> a diff in A, but not in C (nor B or D).

This is currently achieved by "pop B C D", edit file, "refresh", "push
--set-tree B C D".

Can "edit --set-tree <sha1>" make this simpler? Which <sha1> value
would be used with "edit --set-tree" (unless that's done by Emacs mode
behind the scene and it generates the tree that gets passed to edit).

> Working like this means that we don't really see the series as a stri=
ng
> of patches, but as a series of named commits that we can go back and
> edit. But this is a natural way of working with it once the tools get
> powerful enough to support it.

That's looks a bit difficult (at least to me) since the commits are
usually chained. But, yes, as long as the resulting tree remains he
same, we could freely edit the tree corresponding to intermediate
patches.

--=20
Catalin
