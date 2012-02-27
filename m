From: Holger Hellmuth <hellmuth@ira.uka.de>
Subject: Re: git compiled on same distro, different versions
Date: Mon, 27 Feb 2012 16:19:56 +0100
Message-ID: <4F4B9F1C.8040607@ira.uka.de>
References: <ji8u2f$gml$1@dough.gmane.org> <7vboonhoko.fsf@alter.siamese.dyndns.org> <4F4825CA.1060506@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Neal Kreitzinger <neal@rsss.com>, git@vger.kernel.org
To: Neal Kreitzinger <nkreitzinger@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 16:19:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S22MZ-00008e-HI
	for gcvg-git-2@plane.gmane.org; Mon, 27 Feb 2012 16:19:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753041Ab2B0PTg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 27 Feb 2012 10:19:36 -0500
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:33222 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752557Ab2B0PTf (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 27 Feb 2012 10:19:35 -0500
Received: from irams1.ira.uni-karlsruhe.de ([141.3.10.5])
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	id 1S22M4-00037a-0L; Mon, 27 Feb 2012 16:19:31 +0100
Received: from i20s141.iaks.uni-karlsruhe.de ([141.3.32.141] helo=[172.16.22.120])
	by irams1.ira.uni-karlsruhe.de with esmtpsa port 25 
	id 1S22M3-0001pZ-PW; Mon, 27 Feb 2012 16:19:11 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); en-US; rv:1.9.2.24) Gecko/20111101 SUSE/3.1.16 Thunderbird/3.1.16
In-Reply-To: <4F4825CA.1060506@gmail.com>
X-ATIS-AV: ClamAV (irams1.ira.uni-karlsruhe.de)
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-AV: Kaspersky (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1330355972.045884000
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191625>

On 25.02.2012 01:05, Neal Kreitzinger wrote:
> "high-level" question:
> If I compile git 1.7.9.2 (from git.git source) on RHEL6 test-box and
> test it and conclude that it "works right" is that sufficient for me to
> then go ahead and compile git 1.7.9.2 on RHEL5 real-box and
> expect/assume that it will also "work right"? IOW, will they produce the
> same results? Because if not then I have just potentially broken the
> real-box.

Depends on your thoroughness. I.e. you have to assume that your testing 
does actually test aspects that are not covered by all the tests 
included with git (and not detected by hundreds of other users on that 
platform). In that case you can't guarantee anything, even applying 
routine security patches to the operating system could potentially break 
things (and some companies really test every single patch they apply to 
mission-critical systems).

> "low-level" question:
> I suspect git calls linux commands alot. Git has "plumbing" commands
> that are not supposed to "break" scripts. Does linux also have
> "plumbing" commands that are not supposed to "break" scripts? Does git
> only use linux "plumbing" commands? Because if git commands uses linux
> "porcelain" then the linux "porcelain" change could cause git to change
> (not necessarily "break"). Maybe git-porcelain only uses
> linux-porcelain, and git-plumbing only uses linux-plumbing.

As far as I know there is no plumbing/porcelain distinction in the linux 
kernel. But while the internal interfaces in the kernel change a lot, 
the external interface (to user space programs like git) is relatively 
fixed. You can assume that git is adapted to incompatible changes very 
fast. But nobody can guarantee you that bugs won't make a difference 
going from one platform to another.
