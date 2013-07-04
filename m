From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: unexpected file deletion after using git rebase --abort
Date: Thu, 4 Jul 2013 19:27:36 -0400
Message-ID: <CAPig+cSz2MH4REJyNDox_NCM3DnFamizzMMiDzX=SumpDL77Gw@mail.gmail.com>
References: <20130703224402.GF9016@localhost.localdomain>
	<20130703225642.GU408@google.com>
	<7vip0rckjs.fsf@alter.siamese.dyndns.org>
	<20130704193550.GA4183@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>
To: "Paul A. Kennedy" <pakenned@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jul 05 01:27:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuswD-00065K-5D
	for gcvg-git-2@plane.gmane.org; Fri, 05 Jul 2013 01:27:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756973Ab3GDX1l (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Jul 2013 19:27:41 -0400
Received: from mail-la0-f42.google.com ([209.85.215.42]:53644 "EHLO
	mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756798Ab3GDX1k (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jul 2013 19:27:40 -0400
Received: by mail-la0-f42.google.com with SMTP id eb20so1587523lab.29
        for <git@vger.kernel.org>; Thu, 04 Jul 2013 16:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=qjLGUiSnklr55I0TRadHClj7masaDjru84b8AgrHuy4=;
        b=fRbY/QdCCU5kcJPCiIZ1SnOhZ+vhZ4hTe6ffNZfMyuQhfCOPSW6/plmA+9zCJWhz41
         PmlGYtHm7MdXZ2VMWPUg+nnsA6HKny5ZTh4D6vdyUKXZbnfdH+qkvzD8Gz/sRhz7Zk5e
         Z+TjfDaewBJreHOR17CYVpU+1Xd2aUjzZout6INpDYNwcrAOH6jjkTn0u9X6SbSZp5K9
         YZeWh0wLt+vCtEAzZiWsK84wUhFNje5sp77JaoC3gvcloiv5G7T8Kvftkn6bV4UwFY0R
         sbbpzg8EJmiqp8UcBGUJoDagNdwShjC27xcwKNRz6RV7h5/OqXppVHbwynAlXEbmF/Ls
         /5Ug==
X-Received: by 10.152.4.65 with SMTP id i1mr3880717lai.21.1372980456554; Thu,
 04 Jul 2013 16:27:36 -0700 (PDT)
Received: by 10.114.187.78 with HTTP; Thu, 4 Jul 2013 16:27:36 -0700 (PDT)
In-Reply-To: <20130704193550.GA4183@localhost.localdomain>
X-Google-Sender-Auth: 7YsG5rvNqJBzXwprc2hft0JwlQ0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229624>

On Thu, Jul 4, 2013 at 3:35 PM, Paul A. Kennedy <pakenned@pobox.com> wrote:
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index aca8405..ffaef29 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -238,6 +238,13 @@ leave out at most one of A and B, in which case it defaults to HEAD.
>         will be reset to where it was when the rebase operation was
>         started.
>
> +       Untracked files added to the index will not be unstaged, and
> +       therefore, not present in the working directory upon abort.
> +       Unstage files before the abort, or stash untracked content before
> +       starting the rebase (see linkgit:git-stash[1]).  Dangling blobs
> +       may be found and recovered using fsck and cat-file (see
> +       linkgit:git-fsck[1], linkgit:git-cat-file[1]).
> +

Not commenting about the change in general, just one issue: The
transition to "dangling blobs" seems abrupt and may convey little
meaning to non-expert users. Perhaps lead in to that sentence with
something along the lines of:

  "If you neglect to unstage untracked files before abort, they become
dangling blogs, which may be found ..."

Also, a bit earlier, perhaps: s/Unstage files/Manually unstage files/
