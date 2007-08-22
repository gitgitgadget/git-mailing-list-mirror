From: =?utf-8?Q?David_K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: Re: [StGit PATCH 2/6] Don't try to merge files that merge-recursive already merged
Date: Wed, 22 Aug 2007 11:37:03 +0200
Message-ID: <87sl6bewqo.fsf@morpheus.local>
References: <11875975232619-git-send-email-davidk@lysator.liu.se>
	<1187597523433-git-send-email-davidk@lysator.liu.se>
	<11875975232734-git-send-email-davidk@lysator.liu.se>
	<20070822092152.GB30748@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, catalin marinas <catalin.marinas@gmail.com>
To: Karl =?utf-8?Q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Wed Aug 22 11:37:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1INmeL-00028o-JE
	for gcvg-git@gmane.org; Wed, 22 Aug 2007 11:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119AbXHVJhJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Wed, 22 Aug 2007 05:37:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756097AbXHVJhI
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 05:37:08 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:52135 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753551AbXHVJhG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Aug 2007 05:37:06 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id A88EC200A1F8;
	Wed, 22 Aug 2007 11:37:04 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 18707-01-30; Wed, 22 Aug 2007 11:37:03 +0200 (CEST)
Received: from morpheus (vtab.com [62.20.90.195])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id E0883200A1F1;
	Wed, 22 Aug 2007 11:37:03 +0200 (CEST)
Received: by morpheus (Postfix, from userid 1000)
	id 7899ABFC8A; Wed, 22 Aug 2007 11:37:03 +0200 (CEST)
In-Reply-To: <20070822092152.GB30748@diana.vm.bytemark.co.uk> (Karl
 =?utf-8?Q?Hasselstr=C3=B6m's?= message of "Wed, 22 Aug 2007 11:21:52
 +0200")
User-Agent: Gnus/5.1008 (Gnus v5.10.8) Emacs/22.1 (gnu/linux)
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56360>

Karl Hasselstr=C3=B6m <kha@treskal.com> writes:

> On 2007-08-20 10:11:59 +0200, David K=C3=A5gedal wrote:
>
>> This avoid duplicating work, but also changes the resulting index
>> state so that the conflicts are left in the index in the three
>> stages.
>
> After this patch, t1400-patch-history fails:

I think that the push(c) commits will never happen with my patches, so
the test case needs an update.

> *   ok 1: Initialize the StGIT repository
> *   ok 2: Create the first patch
> *   ok 3: Create the second patch
> *   ok 4: Check the "new" and "refresh" logs
> *   ok 5: Check the log annotation
> *   ok 6: Check the "push" log
> *   ok 7: Check the "push(f)" log
> *   ok 8: Check the "push(m)" log
> * FAIL 9: Check the "push(c)" log
>
>                 echo bar > test && stg refresh &&
>                 stg pop &&
>                 echo foo > test && stg refresh &&
>                 ! stg push &&
>                 stg log --full | grep -q -e "^push(c) "
>
> *   ok 10: Check the push "undo" log
> *   ok 11: Check the refresh "undo" log
> * failed 1 among 11 test(s)
>
> I'll see if I can figure out what's wrong.

--=20
David K=C3=A5gedal
