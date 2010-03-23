From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 7/6] Enable threaded async procedures whenever pthreads is  available
Date: Tue, 23 Mar 2010 21:25:49 +0100
Message-ID: <201003232125.49933.j6t@kdbg.org>
References: <cover.1267889072.git.j6t@kdbg.org> <4c8ef71003230115y64d36094y178fcfe6576e9c66@mail.gmail.com> <201003232119.19430.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 23 21:27:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NuAhh-00024U-Ln
	for gcvg-git-2@lo.gmane.org; Tue, 23 Mar 2010 21:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752879Ab0CWU1w convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 23 Mar 2010 16:27:52 -0400
Received: from bsmtp4.bon.at ([195.3.86.186]:39219 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1752147Ab0CWU1v (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Mar 2010 16:27:51 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id CF2CA2C4006;
	Tue, 23 Mar 2010 21:27:50 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 00A4C19F6B8;
	Tue, 23 Mar 2010 21:25:49 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <201003232119.19430.j6t@kdbg.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143048>

On Dienstag, 23. M=E4rz 2010, Johannes Sixt wrote:
> On Dienstag, 23. M=E4rz 2010, Fredrik Kuivinen wrote:
> > On Wed, Mar 17, 2010 at 22:28, Johannes Sixt <j6t@kdbg.org> wrote:
> > > ----------
> > > upload_pack:create_pack_file():
> >
> > ...
> > sha1_to_hex is also called by the parent and the current
> > implementation of that function is not thread-safe. sha1_to_hex is
> > also called by some paths in the revision machinery, but I don't kn=
ow
> > if it will ever be called in this particular case.
>
> sha1_to_hex is only called by the parent when the async procedure is =
not
> used.

BTW, the real fix for this potentially problematic case is to teach=20
pack-objects to create a pack file for a shallow clone. Then we don't n=
eed=20
this instance of an async procedure.

-- Hannes
