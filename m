From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH] notes: allow merging from arbitrary references
Date: Sun, 15 Nov 2015 23:14:11 +0100
Message-ID: <CALKQrgcKxJqJn+3-rg4DCbT5CFDZW8o9GtCS=kh-iSy0YyGAUA@mail.gmail.com>
References: <1447432462-21192-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git mailing list <git@vger.kernel.org>,
	Mike Hommey <mh@glandium.org>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Jacob Keller <jacob.keller@gmail.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 23:51:56 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zy69L-0007uP-7G
	for gcvg-git-2@plane.gmane.org; Sun, 15 Nov 2015 23:51:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093AbbKOWvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2015 17:51:21 -0500
Received: from locusts.copyleft.no ([188.94.218.116]:60545 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbbKOWvV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2015 17:51:21 -0500
X-Greylist: delayed 2221 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Nov 2015 17:51:20 EST
Received: from mail-yk0-f181.google.com ([209.85.160.181])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Zy5Yv-000KLI-QV
	for git@vger.kernel.org; Sun, 15 Nov 2015 23:14:17 +0100
Received: by ykba77 with SMTP id a77so211267356ykb.2
        for <git@vger.kernel.org>; Sun, 15 Nov 2015 14:14:11 -0800 (PST)
X-Received: by 10.13.230.145 with SMTP id p139mr27905171ywe.314.1447625651960;
 Sun, 15 Nov 2015 14:14:11 -0800 (PST)
Received: by 10.37.208.21 with HTTP; Sun, 15 Nov 2015 14:14:11 -0800 (PST)
In-Reply-To: <1447432462-21192-1-git-send-email-jacob.e.keller@intel.com>
X-Gmail-Original-Message-ID: <CALKQrgcKxJqJn+3-rg4DCbT5CFDZW8o9GtCS=kh-iSy0YyGAUA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281323>

On Fri, Nov 13, 2015 at 5:34 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Create a new expansion function, expand_loose_notes_ref which will
> expand any ref using get_sha1, but falls back to expand_notes_ref if
> this fails. The contents of the strbuf will be either the hex string of
> the sha1, or the expanded notes ref. It is expected to be re-expanded
> using get_sha1 inside the notes merge machinery, and there is no real
> error checking provided at this layer.
>
> Since we now support merging from non-notes refs, remove the test case
> associated with that behavior. Add a test case for merging from a
> non-notes ref.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---
> I do not remember what version this was since it has been an age ago
> that I sent the previous code. This is mostly just a rebase onto current
> next. I believe I have covered everything previous reviewers noted.

Looks good to me.

> I'm interested in whether this is the right direction, as my longterm
> goal is to be able to push/pull notes to a specific namespace (probably
> refs/remote-notes/*, since actually modifying to use
> refs/remotes/notes/* is difficult to send to users, and remote-notes
> makes the most useful sense). The first part of this is allowing merge
> to come from an arbitrary reference, as currently it is not really
> possible to merge from refs/remote-notes as we'd need it to be.

Yes, I agree that merging from refs outside refs/notes/ should become possible.

A related topic that has been discussed (although I cannot remember if
any conclusion was reached) is whether to allow more notes operations
- specifically _read-only_ operations - on notes trees outside
refs/notes/. I believe this should also become possible, although I
haven't thoroughly examined all implications.

...Johan


-- 
Johan Herland, <johan@herland.net>
www.herland.net
