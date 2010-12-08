From: Anders Kaseorg <andersk@ksplice.com>
Subject: =?UTF-8?Q?Re=3A_=5BPATCH=5D_describe=3A_Don=E2=80=99t_look_up_commits_with_--exact-match?=
Date: Tue, 7 Dec 2010 23:41:39 -0500 (EST)
Message-ID: <alpine.DEB.2.02.1012072204371.23348@dr-wily.mit.edu>
References: <alpine.DEB.2.02.1011171830050.14285@dr-wily.mit.edu> <20101203084348.GD18202@burratino> <alpine.DEB.2.02.1012060149550.23348@dr-wily.mit.edu> <20101206073214.GA3745@burratino> <alpine.DEB.2.02.1012061159500.23348@dr-wily.mit.edu>
 <7vfwu9qvew.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	=?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder@ira.uka.de>,
	Kirill Smelkov <kirr@mns.spb.ru>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 08 05:41:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQBqg-0002yo-5a
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 05:41:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983Ab0LHElo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 7 Dec 2010 23:41:44 -0500
Received: from mail-qw0-f46.google.com ([209.85.216.46]:36883 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751438Ab0LHEln convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 7 Dec 2010 23:41:43 -0500
Received: by qwa26 with SMTP id 26so803262qwa.19
        for <git@vger.kernel.org>; Tue, 07 Dec 2010 20:41:42 -0800 (PST)
Received: by 10.224.6.130 with SMTP id 2mr6500109qaz.390.1291783302277;
        Tue, 07 Dec 2010 20:41:42 -0800 (PST)
Received: from localhost (LINERVA.MIT.EDU [18.181.0.232])
        by mx.google.com with ESMTPS id u2sm151092qcq.7.2010.12.07.20.41.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 07 Dec 2010 20:41:41 -0800 (PST)
X-X-Sender: andersk@dr-wily.mit.edu
In-Reply-To: <7vfwu9qvew.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (DEB 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163166>

On Tue, 7 Dec 2010, Junio C Hamano wrote:
> I however think this may hurt when more than one objects are asked to=
 be
> described and there is no exact match.

Yeah, that turns out to be true.  So I rewrote the patch to put the=20
commit_names into a hash table instead of a linked list, run=20
replace_name() only once per tag, and run the lookup code only once per=
=20
describe().  I also tried to split things up a bit more and explain mor=
e=20
in the commit messages.

> * Please run tests before submitting patches.  It appears to break t7=
407.

Oops, I was lazy and only ran the tests that (directly) use describe; I=
=E2=80=99ll=20
be more careful in the future. The new series doesn=E2=80=99t have this=
 problem=20
because it does the replace_name()s in the same order as the old code, =
and=20
it passes all tests.

fixed   1
success 6426
failed  0
broken  39
total   6496

Anders
