From: Brad King <brad.king@kitware.com>
Subject: Re: [PATCH 2/2] revision: do not include sibling history in --ancestry-path
 output
Date: Fri, 26 Aug 2011 08:51:36 -0400
Message-ID: <4E5796D8.3060407@kitware.com>
References: <20110824213205.GI45292@book.hvoigt.net> <438ea0b254ccafb3fc9f3431f8f86007cc03132b.1314290439.git.brad.king@kitware.com> <7v7h61gf5i.fsf_-_@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 26 14:52:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwvtN-0003Mp-Vw
	for gcvg-git-2@lo.gmane.org; Fri, 26 Aug 2011 14:52:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754533Ab1HZMwJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Aug 2011 08:52:09 -0400
Received: from na3sys009aog119.obsmtp.com ([74.125.149.246]:41482 "HELO
	na3sys009aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1754504Ab1HZMwH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2011 08:52:07 -0400
Received: from mail-gx0-f178.google.com ([209.85.161.178]) (using TLSv1) by na3sys009aob119.postini.com ([74.125.148.12]) with SMTP
	ID DSNKTleW9sYmr3Hyq8lWmOAo4a0k0llpix+D@postini.com; Fri, 26 Aug 2011 05:52:07 PDT
Received: by mail-gx0-f178.google.com with SMTP id 8so3527106gxk.23
        for <git@vger.kernel.org>; Fri, 26 Aug 2011 05:52:06 -0700 (PDT)
Received: by 10.150.194.12 with SMTP id r12mr11967ybf.415.1314363126418;
        Fri, 26 Aug 2011 05:52:06 -0700 (PDT)
Received: from [192.168.1.220] (66-194-253-20.static.twtelecom.net [66.194.253.20])
        by mx.google.com with ESMTPS id q25sm1073052yhm.20.2011.08.26.05.52.05
        (version=SSLv3 cipher=OTHER);
        Fri, 26 Aug 2011 05:52:05 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0) Gecko/20110812 Thunderbird/6.0
In-Reply-To: <7v7h61gf5i.fsf_-_@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180164>

On 8/25/2011 9:00 PM, Junio C Hamano wrote:
> If the commit specified as the bottom of the commit range has a direct
> parent that has another child commit that contributed to the resulting
> history, "rev-list --ancestry-path" was confused and listed that side
> history as well.
>
>               D---E
>              /     \
>          ---X---A---B---C
>
> In this history, "rev-list --ancestry-path A..C" should list among what
> the corresponding command without --ancestry-path option would produce,
> namely, D, E, B and C, but limiting the result to those that are
> descendant of A (i.e. B and C). Due to the command line parser subtlety
> corrected by the previous commit, it also listed those that are descendant
> of X as well.
>
> Signed-off-by: Junio C Hamano<gitster@pobox.com>
> ---
>   * And this should fix the breakage you demonstrated.

Yes it does, thanks.  It also makes the submodule search during recursive
merge work as I expect after the fix I tried (only run the search if
o->call_depth == 0).  I'll submit that patch separately when I find time.

Tested-by: Brad King <brad.king@kitware.com>

Thanks,
-Brad
