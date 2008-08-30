From: Alexandre Julliard <julliard@winehq.org>
Subject: Re: [PATCH] git.el: Diff only file at point by default
Date: Sat, 30 Aug 2008 20:29:00 +0200
Message-ID: <87r686we4z.fsf@wine.dyndns.org>
References: <87vdxtpjkd.fsf@lysator.liu.se>
	<7v3akvw7gz.fsf@gitster.siamese.dyndns.org>
	<87bpzh8msk.fsf@wine.dyndns.org> <873aktnsbf.fsf@lysator.liu.se>
	<871w0bmn6w.fsf@lysator.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: David =?utf-8?Q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Sat Aug 30 20:39:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KZVMN-0002mZ-U4
	for gcvg-git-2@gmane.org; Sat, 30 Aug 2008 20:39:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753527AbYH3Sij convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 30 Aug 2008 14:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753420AbYH3Sii
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Aug 2008 14:38:38 -0400
Received: from mail.codeweavers.com ([216.251.189.131]:34840 "EHLO
	mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518AbYH3Sii convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 30 Aug 2008 14:38:38 -0400
Received: from adsl-89-217-62-226.adslplus.ch ([89.217.62.226] helo=wine.dyndns.org)
	by mail.codeweavers.com with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <julliard@winehq.org>)
	id 1KZVKY-0003T3-Sd; Sat, 30 Aug 2008 13:38:36 -0500
Received: by wine.dyndns.org (Postfix, from userid 1000)
	id B771A1E716B; Sat, 30 Aug 2008 20:29:00 +0200 (CEST)
In-Reply-To: <871w0bmn6w.fsf@lysator.liu.se> ("David =?utf-8?Q?K=C3=A5geda?=
 =?utf-8?Q?l=22's?= message of
	"Wed, 27 Aug 2008 00:22:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.0.60 (gnu/linux)
X-Spam-Score: -3.9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94402>

David K=C3=A5gedal <davidk@lysator.liu.se> writes:

> Use prefix (C-u) to diff all marked files.
>
> Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
> ---
>  contrib/emacs/git.el |   62 +++++++++++++++++++++++++++++-----------=
----------
>  1 files changed, 36 insertions(+), 26 deletions(-)
>
> Here is an updated patch that udpate the stage diff commands as
> well. It doesn't touch git-diff-file-merge-head since that already
> uses prefix arguments. Don't know if there is a solution to that.

I'd suggest to change git-diff-file-merge-head to act on the current
file too. This means that the behavior is consistent across all diff
functions, even if we lose the ability to do git-diff-file-merge-head o=
n
all marked files. Later on we may want to use a different mechanism tha=
n
the prefix arg to toggle the marked file behavior for all diff function=
s
(something like the pcl-cvs toggle-marks function).

Also make sure to check the callers of the diff functions you are
changing; at least git-log-edit-diff got broken by your change, there
may be others.

--=20
Alexandre Julliard
julliard@winehq.org
