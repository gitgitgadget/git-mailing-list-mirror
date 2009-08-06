From: Brandon Casey <brandon.casey.ctr@nrlssc.navy.mil>
Subject: Re: What's in git.git (Aug 2009, #01; Wed, 05)
Date: Thu, 06 Aug 2009 17:24:00 -0500
Message-ID: <MEhvdM_GHnyaFj9ZU3lxKS47vmOk5BKslGm0FxkE_lg0SQT5Zx6KhA@cipher.nrlssc.navy.mil>
References: <7vd479x6hx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 07 00:24:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MZBNc-0001xm-J6
	for gcvg-git-2@gmane.org; Fri, 07 Aug 2009 00:24:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754577AbZHFWYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Aug 2009 18:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754557AbZHFWYD
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Aug 2009 18:24:03 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:57981 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754340AbZHFWYD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Aug 2009 18:24:03 -0400
Received: by mail.nrlssc.navy.mil id n76MO1av015547; Thu, 6 Aug 2009 17:24:01 -0500
In-Reply-To: <7vd479x6hx.fsf@alter.siamese.dyndns.org>
X-OriginalArrivalTime: 06 Aug 2009 22:24:00.0839 (UTC) FILETIME=[98FA8570:01CA16E4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/125132>

Junio C Hamano wrote:
> The 1.6.4 release seems to have been quite solid, and there is no
> brown-paper-bag bugfixes on 'maint' yet ;-).

Found one.

I didn't realize the whole git-am discussion did _not_ result in a
fix being applied.  But git-am will currently refuse to apply any
patch from email that does not have "From " or "From: " in the first
three lines of the email.  For those of us whose mail servers prepend
many lines of the form:

Received: from XXX ([XXX]) by XXX with Microsoft SMTPSVC(6.0.3790.2825);
	 Tue, 14 Jul 2009 07:24:06 -0500
Received: by XXX id n6ECJvlh010405; Tue, 14 Jul 2009 07:24:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751929AbZGNMYD (ORCPT <rfc822;XXX@XXX>);
	Tue, 14 Jul 2009 08:24:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752103AbZGNMYC
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Jul 2009 08:24:02 -0400
Received: from mail-ew0-f226.google.com ([209.85.219.226]:50485 "EHLO
	mail-ew0-f226.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751626AbZGNMYB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Jul 2009 08:24:01 -0400

We can not apply any patches saved from email.


I think we should at least do this to fall back to mbox format:

diff --git a/git-am.sh b/git-am.sh
index d64d997..94fa9c9 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -187,6 +187,7 @@ check_patch_format () {
 				patch_format=stgit
 				;;
 			*)
+				patch_format=mbox
 				;;
 			esac
 			;;

-brandon
