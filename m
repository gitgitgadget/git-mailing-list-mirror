From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [PATCH 2/2] read-tree: at least one tree-ish argument is required
Date: Fri, 18 Dec 2009 14:21:49 -0600
Message-ID: <fabb9a1e0912181221i31c32a76n50581adfb2185037@mail.gmail.com>
References: <4B274BDE.8000504@viscovery.net> <4B2B5085.1050906@viscovery.net> 
	<7v4onoywws.fsf@alter.siamese.dyndns.org> <200912182004.25520.j.sixt@viscovery.net> 
	<7voclwxemf.fsf@alter.siamese.dyndns.org> <fabb9a1e0912181137t1265f86cs9e02019da136a0a@mail.gmail.com> 
	<7veimsvz8a.fsf@alter.siamese.dyndns.org> <fabb9a1e0912181159u65ae9c6fg1481ab744575475f@mail.gmail.com> 
	<7vy6l0ujkx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 21:27:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLjQI-0004m2-2b
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 21:27:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932736AbZLRUWN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 15:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932732AbZLRUWM
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 15:22:12 -0500
Received: from mail-vw0-f192.google.com ([209.85.212.192]:38569 "EHLO
	mail-vw0-f192.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932708AbZLRUWK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 15:22:10 -0500
Received: by vws30 with SMTP id 30so1117031vws.33
        for <git@vger.kernel.org>; Fri, 18 Dec 2009 12:22:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=M3TIulwCTD/0bqz023FvxVDxi/jaiuMgUcOiq5FflqA=;
        b=i6T7eP48PhAAHmtCi1bcghxU7Bh2GY7WIhkjDaOETMfXJ4KJMANoDxnE9n1fDP0ur+
         UpKDiJP3LL9hxHWy5llSXR2Grg4IeIHIC3Uv6Q8yAj48/3YQMjklM18DsvprKO8wttoa
         DH2R7TTCvxGiilDYoJwbhTVYelGOLhQxqp5Z0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=QNqL2Pa6sQrkIzaO4iD2x985DC0B6td8zT/iDSUsjcu+ETbQ8gL3CcLHduorKbuDVY
         MJfcKJZ0zg2aLDV9LRceN4rmHPpYC9mjkKUW+n5rRyTVM00Gkf2QNryeKFsM6ShkeJrh
         GCcKpU1qupANyWnpfB7NeYK5cPTtDBDi45akY=
Received: by 10.220.127.70 with SMTP id f6mr1065835vcs.88.1261167729142; Fri, 
	18 Dec 2009 12:22:09 -0800 (PST)
In-Reply-To: <7vy6l0ujkx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135436>

Heya,

On Fri, Dec 18, 2009 at 14:13, Junio C Hamano <gitster@pobox.com> wrote:
> Sounds like "commit.confirm = xxx" configuration patches are coming?

Not a bad idea.

> What
> other questionable operations we might want to let users configure git to
> ask for confirmation?

I don't see any other of the above category, that is, the category of
operations that contain 'git commit -a' with a non-empty index, and
'git rm' on a modified file (which we already prevent). But see below.

> I somehow suspect that you haven't had your morning coffee yet ;-)
> Aren't we talking about the index, and why are you bringing up the reflog?

It was a topic hijack of sorts, we were talking about data loss. I
brought up the reflog since I think that was mentioned before when we
discussed ways to prevent data loss (e.g., create a commit of the
current state when doing 'git reset --hard' and record it in such a
reflog).

> More importantly, if you accept that there are non-interrogator commands
> in the git command set, I somehow suspect that you will soon realize that
> "git config core.nodataloss true" is equivalent to "chmod a-w -R .".

I don't think that's quite right, since you don't lose any data if you
do only additive commands (e.g., create new commits, etc).

> might be useful mode of non-operation (read-only historical archive) but I
> do not think it deserves a configuration of its own with checks in the
> code all over the place that might possibly change any states of the
> repository.

That is not quite what I intended with 'core.preventdataloss' (which I
agree is a bad name for what I intend with it). I meant for a
configuration option which insures that all non-interrogation commands
make sure that what they throw away is recoverable (for example
through the reflog).

> "git config user.novice true" to increase the verbosity and degree of
> hand-holding is an entirely different matter, but if that is what you are
> advocating, you shouldn't call it "core.nodataloss".

I'm not sure I'd call it "user.novice", since I don't consider myself
a novice user, and I would definitely like to be able to recover data
that I accidentally deleted with 'git reset --hard'.

-- 
Cheers,

Sverre Rabbelier
