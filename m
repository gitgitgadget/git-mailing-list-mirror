From: Greg Brockman <gdb@MIT.EDU>
Subject: Re: [RFC/PATCH] git-add: Don't exclude explicitly-specified tracked 
	files
Date: Wed, 11 Aug 2010 14:36:13 -0400
Message-ID: <AANLkTinbMHDa6P8N4Mne34rMkmzzbrpm0osd2LRbr-Jv@mail.gmail.com>
References: <1281510236-8103-1-git-send-email-gdb@mit.edu>
	<7vmxstypot.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jens.Lehmann@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 11 20:36:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjGA3-0004II-1b
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 20:36:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753528Ab0HKSgS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 11 Aug 2010 14:36:18 -0400
Received: from DMZ-MAILSEC-SCANNER-3.MIT.EDU ([18.9.25.14]:50884 "EHLO
	dmz-mailsec-scanner-3.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753684Ab0HKSgR convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 14:36:17 -0400
X-AuditID: 1209190e-b7bbeae000000a09-88-4c62eda2f8c8
Received: from mailhub-auth-1.mit.edu (MAILHUB-AUTH-1.MIT.EDU [18.9.21.35])
	by dmz-mailsec-scanner-3.mit.edu (Symantec Brightmail Gateway) with SMTP id B9.70.02569.2ADE26C4; Wed, 11 Aug 2010 14:36:18 -0400 (EDT)
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by mailhub-auth-1.mit.edu (8.13.8/8.9.2) with ESMTP id o7BIaFwW001299
	for <git@vger.kernel.org>; Wed, 11 Aug 2010 14:36:16 -0400
Received: from mail-wy0-f174.google.com (mail-wy0-f174.google.com [74.125.82.174])
	(authenticated bits=0)
        (User authenticated as gdb@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id o7BIaDVK025363
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NOT)
	for <git@vger.kernel.org>; Wed, 11 Aug 2010 14:36:14 -0400 (EDT)
Received: by wyb32 with SMTP id 32so433821wyb.19
        for <git@vger.kernel.org>; Wed, 11 Aug 2010 11:36:13 -0700 (PDT)
Received: by 10.216.231.73 with SMTP id k51mr17012849weq.5.1281551773094; Wed, 
	11 Aug 2010 11:36:13 -0700 (PDT)
Received: by 10.216.19.142 with HTTP; Wed, 11 Aug 2010 11:36:13 -0700 (PDT)
In-Reply-To: <7vmxstypot.fsf@alter.siamese.dyndns.org>
X-Brightmail-Tracker: AAAAARWXE7o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153278>

> What should happen if the user did these instead, after adding "dir" =
as an
> ignored entry, and adding dir/file but not dir/untracked to the index=
?
>
> =A0(1) =A0 =A0git add dir/file dir/untracked =A0 =A0; explicitly name=
d
> =A0(2) =A0 =A0git add dir/* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ;=
 have shell glob--same as (1)
> =A0(3) =A0 =A0git add "dir/*" =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ; h=
ave git glob
> =A0(4) =A0 =A0git add dir =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 ; have git recurse

In all four cases, the output I get is:
"""
The following paths are ignored by one of your .gitignore files:
dir
Use -f if you really want to add them.
fatal: no files added
"""

Note that this is also the output if you run

(5) rm dir/untracked && git add "dir/*"

Greg
