From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH v2 4/4] upload-archive: use start_command instead of fork
Date: Mon, 01 Aug 2011 23:52:43 +0200
Message-ID: <4E37202B.80208@lsrfire.ath.cx>
References: <1311012516-4836-1-git-send-email-kusmabite@gmail.com> <1311012516-4836-5-git-send-email-kusmabite@gmail.com> <7vmxga7zb9.fsf@alter.siamese.dyndns.org> <CABPQNSYtpRpNQVW=QvyfFhmWge5-C+k85bs2EJeK8k0jdfHzrw@mail.gmail.com> <20110728160845.GA14337@sigill.intra.peff.net> <20110728164758.GA15931@sigill.intra.peff.net> <20110728170222.GB15931@sigill.intra.peff.net> <CABPQNSaqyD+rhWPRbtVdnkweuXSycBahKEsasGZkEg3mi4SaxQ@mail.gmail.com> <20110801174603.GB10302@sigill.intra.peff.net> <CABPQNSbyp2hEgXvzo3bMHHxrbc9fQLqaABweqfjP7xQzBUdj6A@mail.gmail.com> <20110801182516.GC10302@sigill.intra.peff.net> <4E371109.7050500@lsrfire.ath.cx> <4E3718B4.6090803@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Erik Faye-Lund <kusmabite@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Mon Aug 01 23:52:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qo0Pq-00067z-K2
	for gcvg-git-2@lo.gmane.org; Mon, 01 Aug 2011 23:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752982Ab1HAVwr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 1 Aug 2011 17:52:47 -0400
Received: from india601.server4you.de ([85.25.151.105]:38720 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751034Ab1HAVwp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2011 17:52:45 -0400
Received: from [192.168.2.104] (p4FFD8EFC.dip.t-dialin.net [79.253.142.252])
	by india601.server4you.de (Postfix) with ESMTPSA id 665612F8035;
	Mon,  1 Aug 2011 23:52:44 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <4E3718B4.6090803@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178419>

Am 01.08.2011 23:20, schrieb Johannes Sixt:
> Am 01.08.2011 22:48, schrieb Ren=C3=A9 Scharfe:
>> So git archive gives the right results when writing to a pipe, but
>> always the same wrong result when writing directly to a file.
>=20
> This could indeed be a CRLF issue. archive-tar.c runs gzip to let it
> write to the original fd 1 (stdout). gzip is an MSYS program, and MSY=
S
> is "clever" and sets up the channel in text mode (CRLF conversion) if=
 it
> is a regular file, but in binary mode if it is a pipe.
>=20
> Without the gzip filter, git-archive writes to stdout itself. Since w=
e
> have set up all our channels in binary mode, we do not suffer from th=
e
> same problem for plain tar format.
>=20
> So, I don't think we can do a lot about it, short of patching MSYS ag=
ain...

Or we could pipe the output through us, i.e. attach a builtin version o=
f
cat at the output end of the called command.  Only on Windows, of
course.  Better ugly and limping then wrong, right?

Ren=C3=A9
