From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH 1/2] Add tests for git-sh-setup's
 require_clean_work_tree()
Date: Thu, 21 Jan 2016 02:27:11 +0100
Message-ID: <20160121022711.Horde.7Nh0N0fTAbd0JWIA99KKFQF@webmail.informatik.kit.edu>
References: <1448376345-27339-1-git-send-email-szeder@ira.uka.de>
 <xmqqbn8f3iq5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 21 02:27:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aM426-0002BT-C6
	for gcvg-git-2@plane.gmane.org; Thu, 21 Jan 2016 02:27:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752819AbcAUB10 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Jan 2016 20:27:26 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:41726 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751807AbcAUB1Z convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2016 20:27:25 -0500
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1aM41x-00056M-M0; Thu, 21 Jan 2016 02:27:21 +0100
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1aM41o-0004TV-0P; Thu, 21 Jan 2016 02:27:12 +0100
Received: from x4db253e6.dyn.telefonica.de (x4db253e6.dyn.telefonica.de
 [77.178.83.230]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Thu, 21 Jan 2016 02:27:11 +0100
In-Reply-To: <xmqqbn8f3iq5.fsf@gitster.mtv.corp.google.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1453339641.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284494>


Quoting Junio C Hamano <gitster@pobox.com>:

>> +test_expect_success 'error on clean index and worktree while on =20
>> orphan branch' '
>> +	test_when_finished "git checkout master" &&
>> +	git checkout --orphan orphan &&
>> +	git reset --hard &&
>> +	test_must_fail run_require_clean_work_tree
>> +'
>
> The title is wrong.  Immediately after creating and getting on an
> orphan branch, you have stuff in the index that is not committed to
> the branch, so your index cannot be clean by definition.

The index contains the file 'file', so it's not clean indeed.

> The
> contents of the working tree may or may not be clean immediately
> after getting on a new orphan branch, but you are doing "reset
> --hard" to make the index and the working tree agree,

=2E.. and match HEAD, which in this case means both the index and the
worktree become empty.

'git rm -r .' would have made the intent clearer.  Or 'git init emptyre=
po'.

> so this is
> testing the "clean working tree" case, I think.

So the question is, before we go any further: are an empty index and
empty worktree clean when HEAD doesn't point to a commit?  (either afte=
r
the command sequence in the above test, or right after 'git init').

I do think they are clean.


G=C3=A1bor
