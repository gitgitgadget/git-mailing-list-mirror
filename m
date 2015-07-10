From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH v4] notes: Allow treeish expressions as notes ref
Date: Fri, 10 Jul 2015 09:16:16 +0200
Message-ID: <CALKQrgdGJy6vtBRL413bbSHSi+=KTh4Q98hpbgg29j4J191=bA@mail.gmail.com>
References: <CALKQrgd_eB2ZUwUz54vW9OFOuZshvGGe9dx+suvd0=WA0OmOFQ@mail.gmail.com>
	<1436491711-19056-1-git-send-email-mh@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Fri Jul 10 09:16:42 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZDSXz-0007KP-4T
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jul 2015 09:16:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753161AbbGJHQ0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jul 2015 03:16:26 -0400
Received: from locusts.copyleft.no ([188.94.218.116]:57988 "EHLO
	mail.mailgateway.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752880AbbGJHQY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jul 2015 03:16:24 -0400
Received: from mail-yk0-f172.google.com ([209.85.160.172])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1ZDSXm-0007fX-Ej
	for git@vger.kernel.org; Fri, 10 Jul 2015 09:16:22 +0200
Received: by ykee186 with SMTP id e186so56218553yke.2
        for <git@vger.kernel.org>; Fri, 10 Jul 2015 00:16:16 -0700 (PDT)
X-Received: by 10.13.204.142 with SMTP id o136mr22378777ywd.171.1436512576541;
 Fri, 10 Jul 2015 00:16:16 -0700 (PDT)
Received: by 10.37.92.2 with HTTP; Fri, 10 Jul 2015 00:16:16 -0700 (PDT)
In-Reply-To: <1436491711-19056-1-git-send-email-mh@glandium.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/273804>

On Fri, Jul 10, 2015 at 3:28 AM, Mike Hommey <mh@glandium.org> wrote:
> init_notes() is the main point of entry to the notes API. It is an arbitrary
> restriction that all it allows as input is a strict ref name, when callers
> may want to give an arbitrary treeish.
>
> However, some operations that require updating the notes tree require a
> strict ref name, because they wouldn't be able to update e.g. foo@{1}.
>
> So we allow treeish expressions to be used in the case the notes tree is
> going to be used without write "permissions", and to distinguish whether
> the notes tree is intended to be used for reads only, or will be updated,
> a flag is added.
>
> This has the side effect of enabling the use of treeish as notes refs in
> commands allowing them, e.g. git log --notes=foo@{1}.

Looks good. However, on a second pass I noticed that the patch comes
with no tests. I'd like at least a couple of tests thrown in there to verify
correctness; e.g. reading notes from refs/notes/commits^{tree} shall
succeed, and trying to write notes to refs/notes/commits^{tree} shall fail.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
