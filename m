From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: large files and low memory
Date: Tue, 05 Oct 2010 13:38:59 +0200
Message-ID: <vpqbp78x418.fsf@bauges.imag.fr>
References: <20101004092046.GA4382@nibiru.local>
	<AANLkTimbdrAqoWMxiteT5zNYmwHp8M698BEv1FLuiAxx@mail.gmail.com>
	<4CAA1BEB.3050908@workspacewhiz.com>
	<AANLkTi=nzyRgiBL07f2oeyjdUc8XnaKbJEJ+k8_g9rQ1@mail.gmail.com>
	<20101005005902.GC2768@nibiru.local>
	<20101005074144.GA22564@nibiru.local> <vpqpqvpf4qm.fsf@bauges.imag.fr>
	<20101005081700.GB22564@nibiru.local>
	<AANLkTin+i7VZApDRmairgpMth4MzPoDF=oHt-UHCt98E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: weigelt@metux.de, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 05 13:39:19 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P35rU-0007MS-Qp
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 13:39:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758193Ab0JELjG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Oct 2010 07:39:06 -0400
Received: from mx2.imag.fr ([129.88.30.17]:52971 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751573Ab0JELjF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Oct 2010 07:39:05 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id o95BXeK1006296
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Tue, 5 Oct 2010 13:33:40 +0200
Received: from bauges.imag.fr ([129.88.43.5])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1P35rH-0002vg-Cy; Tue, 05 Oct 2010 13:38:59 +0200
In-Reply-To: <AANLkTin+i7VZApDRmairgpMth4MzPoDF=oHt-UHCt98E@mail.gmail.com> (Alex Riesen's message of "Tue\, 5 Oct 2010 13\:29\:11 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Tue, 05 Oct 2010 13:33:40 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: o95BXeK1006296
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1286883221.31834@a8+Yv4uH5ow1allPcbjpeQ
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158188>

Alex Riesen <raa.lkml@gmail.com> writes:

> On Tue, Oct 5, 2010 at 10:17, Enrico Weigelt <weigelt@metux.de> wrote:
>> * Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> wrote:
>>
>>> git commit will show what's being commited (the output of "git commit
>>> --dry-run") in your editor, hence it needs to compute that.
>>
>> hmm, is there any way to get around this ?
>>
>
> Try "git commit -q -uno". This should skip creation of summary in the
> commit message and lookup for untracked files.

To avoid including the summary, the option would be --no-status (-q
makes commit less verbose in stdout, not in COMMIT_EDITMSG).

But

strace -fe lstat64 git commit -uno --no-status -q

still shows lstat64 for each tracked file in my working tree (even
when using -m to avoid launching the editor). I don't know if this is
intended, or just that nobody cared enough to optimize this.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
