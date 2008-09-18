From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Documentation: warn against merging in a dirty tree
Date: Thu, 18 Sep 2008 14:18:41 -0400
Message-ID: <32541b130809181118s1a4cffa6u3ad139aa05443ea6@mail.gmail.com>
References: <200809160048.31443.trast@student.ethz.ch>
	 <1221518994-26111-1-git-send-email-trast@student.ethz.ch>
	 <1221518994-26111-2-git-send-email-trast@student.ethz.ch>
	 <7vtzch7z7u.fsf@gitster.siamese.dyndns.org>
	 <32541b130809151653w27d7876fp35e0967d597ae2a9@mail.gmail.com>
	 <alpine.LFD.1.10.0809180804100.3337@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Thomas Rast" <trast@student.ethz.ch>, git@vger.kernel.org,
	"Jakub Narebski" <jnareb@gmail.com>,
	"Miklos Vajna" <vmiklos@frugalware.org>
To: "Linus Torvalds" <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 20:20:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgO6d-0000nZ-6P
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 20:19:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755271AbYIRSSn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 14:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753252AbYIRSSn
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 14:18:43 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:58833 "EHLO
	wr-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753963AbYIRSSm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 14:18:42 -0400
Received: by wr-out-0506.google.com with SMTP id 69so13190wri.5
        for <git@vger.kernel.org>; Thu, 18 Sep 2008 11:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=fr4Y2gq/XnPDhal0v2w6MwaoB9ETucs6TEBJIg95HGA=;
        b=r/Pe4oqPvQ7bGEd9YwNsAgIhJQzU6p48YxwlpeAf7MQfYOxiZo0FRtD9lVhHb6fJ01
         bU59uCiAH+VLJYMiPHJF7IuY66sGRi7OdVi/qnYTf3u4gKYmYC7mQj9gfSQk9XyP3n19
         Keo9Kfl4vtMyManxTRC2TK0OQAAFbaKZUsJpY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=wUrC3dWPAGbxFq202muvkCOSE5RVnTFoQaD/wu1M9wvJhPzhSBG6iYabhGCeQgN49F
         bw3rOuoeHPiwgKiydr6nNWaMfbZaGxA0ufbgdguTyMhFrq4qRS2kQfk/EpgBdr9vnf26
         aLsYKiy6/xrcOeGpsTzx46KRMtfreCbgG52bM=
Received: by 10.150.134.21 with SMTP id h21mr1694981ybd.181.1221761921283;
        Thu, 18 Sep 2008 11:18:41 -0700 (PDT)
Received: by 10.150.96.5 with HTTP; Thu, 18 Sep 2008 11:18:41 -0700 (PDT)
In-Reply-To: <alpine.LFD.1.10.0809180804100.3337@nehalem.linux-foundation.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96234>

On Thu, Sep 18, 2008 at 11:15 AM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, 15 Sep 2008, Avery Pennarun wrote:
>>
>> But how do you abort a *failed* merge in a situation like Linus's
>> example?  "git reset --hard HEAD" would destroy the unstaged Makefile
>> change.
>
> As mentioned by others, sometimes you are simply willing to take the risk.
> If I have dirty data, I still want to merge, because (a) my dirty data is
> a _convenience_ and (b) the risk of me having to do a "git reset" is
> pretty low anyway.

In that case, my next question is how you pull off (b), because that's
*way* better than just being able to undo when I get myself into
trouble :)  I do and then reset test merges all the time.

> That said, it's actually kind of sad that we don't expose a real
> capability that the git plumbing does have. Namely
>
>        git read-tree -u -m HEAD ORIG_HEAD
>
> should do the right thing if you want to undo a merge (except it doesn't
> actually write ORIG_HEAD to be the new head: you could use "git reset"
> with --soft to do that, or just git update-ref).

Hmm,

   $ git read-tree -u -m HEAD ORIG_HEAD
   fatal: you need to resolve your current index first

It appears that the above would be great for undoing a
*non*conflicting merge, but that's not as important ;)

> So it _may_ be that something like
>
>        [alias]
>                undo = !git read-tree -u -m HEAD ORIG_HEAD && git reset --soft ORIG_HEAD
>
> would actually give you "git undo".
>
> So we have the technology, and we just don't _expose_ that capability as a
> "git reset" thing. And we probably should. In fact, that is often the
> thing people really want, and it would have made sense to have it as the
> default action, but the initial design for "git reset" was literally as a
> way to get you out of a sticky corner when you had unmerged entries and
> you just wanted to throw away crud.

Note that if we were going to do an undo, it would be nice to be
careful about allowing multiple consecutive undos.  "git undo; git
undo;" shouldn't be a no-op, it should undo two things.  At least,
that's how the rest of the world (okay, my text editor) works.  "git
redo" could be the opposite of "git undo".

I imagine some trick using the reflog would thus be better here than
updating ORIG_HEAD.

Since that's a lot of work, I'd propose having a first pass at the
undo operation use ORIG_HEAD and then just delete or rename ORIG_HEAD,
so that 'git undo; git undo' is meaningless.

Have fun,

Avery
