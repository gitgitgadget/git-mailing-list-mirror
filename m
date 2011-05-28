From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH] rebase: learn --discard subcommand
Date: Sat, 28 May 2011 18:45:16 +0530
Message-ID: <BANLkTim-Wva018BFeTUPqZuiK02-X01XJQ@mail.gmail.com>
References: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 28 15:15:44 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQJMl-00039k-NM
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 15:15:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753015Ab1E1NPi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 28 May 2011 09:15:38 -0400
Received: from mail-ww0-f42.google.com ([74.125.82.42]:48538 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751009Ab1E1NPh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 28 May 2011 09:15:37 -0400
Received: by wwk4 with SMTP id 4so473083wwk.1
        for <git@vger.kernel.org>; Sat, 28 May 2011 06:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=ZfcMQefvTvyYqi1DH4bHx23v8aYZ3P34wpby3MW2Y6k=;
        b=LwhgYM8uVso4ZMWFmh/WwB1LxR2wRZsqZWL4wJlpyOykjka10/1aFA7PE86tGKQQGv
         l7ncWvCvRYO7JzcR8JERXneehyQO/XWfq4pZ3Ib0yi2w6X0bO0UWRLfJmwgSwGw60M5+
         plhKfFrajzkLcrGwGZKmfXOF7FYevF6yTUpCM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=p3Nxe1n13VGMIP7YeuZEjKrvHL2pnzESAlkhXCf/fkz0c8d4edCcKk/GkHxEXmRJ/Q
         lGlkU7DjvfUU/6IOzPcvQGTgeBrxxHQZ2G4X7thmIw4XrHzSNTMTi+aiHyKooslZB2lB
         ArtxKuKs2qgzZzLuJ3h0PbXJN/0qdIdlTtNqA=
Received: by 10.216.145.200 with SMTP id p50mr713908wej.79.1306588536107; Sat,
 28 May 2011 06:15:36 -0700 (PDT)
Received: by 10.216.158.70 with HTTP; Sat, 28 May 2011 06:15:16 -0700 (PDT)
In-Reply-To: <1306551495-26685-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174661>

Hi Martin,

Martin von Zweigbergk writes:
> A long time ago I said I wished that 'git rebase --abort' would move
> back to the where HEAD was when the rebase was initiated, instead of
> moving back to the branch that was about to be rebased (which may be
> different for "git rebase $upstream $branch"). I think Junio then
> hinted that he sometimes wished that he could abort rebase without
> moving to anywhere else at all, which is what this patch implements. I
> don't feel strongly about this patch, but I would probably also use
> this subcommand once in a while. However, maybe the greatest value in
> it is that we don't have to tell users to mess with the .git
> directory?

Interesting. Yes, I usually remove the state file by hand too. In view
of "git rebase --interactive" being a porcelain command, I don't know
if it's alright to drop the user into a detached HEAD state.

> I used "rm -r" without -f to match how it is done in --abort, but
> maybe -f should be used? That is what we recommend to the end-user to
> use today.

If you've verified that a rebase is already in progress, I don't see
the point of using '-f'. Otherwise, it should error out and say that
"no rebase is in progress", like the other command-line options
currently do.

> A difference from --abort is that --discard does not clear
> rerere. Need this be mentioned in the documentation?

It depends on what you're expecting the user to do in this detached
HEAD state, no?

> I have not been involved in Ramkumar's work on the sequencer to know
> if and how this might impact it.

It'll have no impact on the Sequencer work. Thanks.

-- Ram
