From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [PATCH 0/16] make prune mtime-checking more careful
Date: Sun, 05 Oct 2014 11:19:07 +0200
Message-ID: <54310D0B.60904@web.de>
References: <20141003202045.GA15205@peff.net> <xmqqbnprjx0t.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 05 11:20:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XahzZ-0003sg-5x
	for gcvg-git-2@plane.gmane.org; Sun, 05 Oct 2014 11:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751221AbaJEJUd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 5 Oct 2014 05:20:33 -0400
Received: from mout.web.de ([212.227.17.12]:63760 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbaJEJUc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Oct 2014 05:20:32 -0400
Received: from [192.168.178.27] ([79.253.129.50]) by smtp.web.de (mrweb102)
 with ESMTPSA (Nemesis) id 0MIvbh-1Xccj625Or-002a4P; Sun, 05 Oct 2014 11:20:13
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.2
In-Reply-To: <xmqqbnprjx0t.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:0LxWCs+xAQlNG7uJK2NkKx6ibktiYz4hZdNugF0IMJldFOi5jMA
 QPgfZYzM4xe+Y1KT8GgNxVIEl1NJIIJTw973+OpRAvomnDWbNyI/TW6BDuJpfERhUPy7Q8L
 KKyI1t4V4E2YVbW8zvGip6Mve+MNvgX5XLgATs9qW2e8dCSl8CXn+eZ5nvyYaOiA6QHPpgn
 zPTxwbkUdXfIFyVdansGQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257898>

Am 05.10.2014 um 00:22 schrieb Junio C Hamano:
> Jeff King <peff@peff.net> writes:
>
>> There's quite a lot of patches here, but most of them are preparator=
y
>> cleanups. The meat is in patches 13, 15, and 16.
>>
>>    [01/16]: foreach_alt_odb: propagate return value from callback
>>    [02/16]: isxdigit: cast input to unsigned char
>>    [03/16]: object_array: factor out slopbuf-freeing logic
>>    [04/16]: object_array: add a "clear" function
>>    [05/16]: clean up name allocation in prepare_revision_walk
>>    [06/16]: reachable: clear pending array after walking it
>>    [07/16]: t5304: use test_path_is_* instead of "test -f"
>>    [08/16]: t5304: use helper to report failure of "test foo =3D bar=
"
>>    [09/16]: prune: factor out loose-object directory traversal
>>    [10/16]: count-objects: do not use xsize_t when counting object s=
ize
>>    [11/16]: count-objects: use for_each_loose_file_in_objdir
>>    [12/16]: sha1_file: add for_each iterators for loose and packed o=
bjects
>>    [13/16]: prune: keep objects reachable from recent objects
>>    [14/16]: pack-objects: refactor unpack-unreachable expiration che=
ck
>>    [15/16]: pack-objects: match prune logic for discarding objects
>>    [16/16]: write_sha1_file: freshen existing objects
>
> Somebody please help me out here.
>
> This applied on top of 'maint' (which does have c40fdd01) makes the
> test #9 (prune: do not prune detached HEAD with no reflog) fail.

The test passes if the return value of freshen_file() is negated in=20
freshen_packed_object() (see my reply to patch 16).

> If we merge 'dt/cache-tree-repair' (which in turn needs
> 'jc/reopen-lock-file') to 'maint' and then apply these on top, the
> said test passes.  But I do not see an apparent reason why X-<.

Didn't check this interaction, but it sounds strange.

Ren=E9
