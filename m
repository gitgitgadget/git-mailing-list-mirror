From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 2/4] reachable.c: mark reachable objects in index from all worktrees
Date: Wed, 1 Jun 2016 14:13:55 -0400
Message-ID: <CAPig+cRzRa1uZ+2jD4_uCSisb+0dywPGV3AVE38-xZr3hauTtA@mail.gmail.com>
References: <574D382A.8030809@kdbg.org>
	<20160601104519.16563-1-pclouds@gmail.com>
	<20160601104519.16563-3-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
	Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	David Turner <dturner@twopensource.com>
To: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 20:14:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8Aem-0006c3-1r
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 20:14:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161298AbcFASOE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Jun 2016 14:14:04 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:36243 "EHLO
	mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161285AbcFASOC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Jun 2016 14:14:02 -0400
Received: by mail-it0-f65.google.com with SMTP id i127so4104351ita.3
        for <git@vger.kernel.org>; Wed, 01 Jun 2016 11:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-transfer-encoding;
        bh=9wa2tjc3rDyXpwaeceBHdZRN4pPhcJ9D1+iTJU4J/yU=;
        b=vgGl283kgabxpf4/Q+naaF6Cfy2WttqLWpW/PQ2ti2G5y/lsWaAbXJhlI2ohFSR8Bz
         Y6g26HTQt75ID6Lbo1TmglzdBN48JR4S2XDALT5sZfnDp0mdam+hEdmRJuL65e2iqwLl
         6w3kBycqPjgCp/BPzhWCRucHzlpqnDXio3T8QfbJdy0+7mVl4/f5DBCR1z3BOJMwkwVD
         tALnlkhHaXldlG59K8CR8RKvWdMqyu3x/DSJLysB8YBHPJA6YVzVCSBSgkBzZCa0cQk3
         +2VtmKEofazePawU3WSxYs6Pmql3TWQwZIkPhfN9JVlZwWjeVv5ANthhC9QuBmPV9HE+
         0zag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-transfer-encoding;
        bh=9wa2tjc3rDyXpwaeceBHdZRN4pPhcJ9D1+iTJU4J/yU=;
        b=EyS3vOB2bLWq5tEkKEv+SrsjY1S5Wo16C4wBZFgYCR8Npy+KCi4fFBXBxw0NUVQzcx
         2/EuolkVS7zjkYR+oczcdTNtHJd5quheZbwGPZQMw8W+xgiGVM1aCURc+n9zU8L+wthE
         0W2VJAYuQXPYCrVO9SbC3lW6CT6KhKRBv7SxsTzk8+YLjyzaz++MTQKCUeS2+412bQXn
         5S+kPh63LDrZX3ct0Zv8qRg41eNDemypVT0uEPeeENVQU2K6va6/LbqU7JjLtVK9LxeQ
         QoiAN/r8bAzlbb9iupcxvAfg500k8nQHzadYWVXHR0cLqPa/nCxDd0V1Pvc7iFk0g0FY
         tWHQ==
X-Gm-Message-State: ALyK8tLtSxknUXS9/3aVY9xhlwbdQKAht/Q9qc4HGNkH5wfy2QeGvkjQ7BdUsrVyVr0I4M0w82T5tNqps6ZiaA==
X-Received: by 10.36.6.73 with SMTP id 70mr22975269itv.1.1464804837056; Wed,
 01 Jun 2016 11:13:57 -0700 (PDT)
Received: by 10.79.0.30 with HTTP; Wed, 1 Jun 2016 11:13:55 -0700 (PDT)
In-Reply-To: <20160601104519.16563-3-pclouds@gmail.com>
X-Google-Sender-Auth: 6O7ebhZAcQHby8_ZEXsi9iny3t0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296142>

On Wed, Jun 1, 2016 at 6:45 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> Current mark_reachable_objects() only marks objects from index from
> _current_ worktree as reachable instead of all worktrees. Because thi=
s
> function is used for pruning, there is a chance that objects referenc=
ed
> by other worktrees may be deleted. Fix that.
>
> Small behavior change in "one worktree" case, the index is read again
> from file. In the current implementation, if the_index is already
> loaded, the index file will not be read from file again. This adds so=
me
> more cost to this operation, hopefully insignificant because
> reachability test is usually very expensive already.

Could this extra index read be avoided by taking advantage of 'struct
worktree::is_current'[1] and passing the already-loaded index to
add_index_objects_to_pending() if true?

Or, am I misunderstanding the issue?

[1]: http://article.gmane.org/gmane.comp.version-control.git/292194

> Reported-by: Johannes Sixt <j6t@kdbg.org>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
> diff --git a/reachable.c b/reachable.c
> @@ -155,6 +156,32 @@ int add_unseen_recent_objects_to_traversal(struc=
t > +static void add_objects_from_worktree(struct rev_info *revs)
> +{
> +       struct worktree **worktrees, **p;
> +
> +       worktrees =3D get_worktrees();
> +       for (p =3D worktrees; *p; p++) {
> +               struct worktree *wt =3D *p;
> +               struct index_state istate;
> +
> +               memset(&istate, 0, sizeof(istate));
> +               if (read_index_from(&istate,
> +                                   worktree_git_path(wt, "index")) >=
 0)
> +                       add_index_objects_to_pending(revs, 0, &istate=
);
> +               discard_index(&istate);
> +       }
> +       free_worktrees(worktrees);
> +
> +       /*
> +        * this is in case the index is already updated but not
> +        * written down in file yet, then add_index_... in the above
> +        * loop will miss new objects that are just created or
> +        * referenced.
> +        */
> +       add_index_objects_to_pending(revs, 0, &the_index);
> +}
