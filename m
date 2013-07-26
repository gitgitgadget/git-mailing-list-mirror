From: =?iso-8859-1?Q?J=F6rn_Hees?= <dev@joernhees.de>
Subject: Re: [PATCH v3] remotes-hg: bugfix for fetching non local remotes
Date: Fri, 26 Jul 2013 14:17:08 +0200
Message-ID: <1A5ABD76-D3D9-400E-AC8F-26C0DEF43723@joernhees.de>
References: <1374712977-3215-1-git-send-email-dev@joernhees.de> <CAMP44s16bRx0p_F=PTcy9bekg_5TVC_GsQjzOev6xkpCEWcjAw@mail.gmail.com> <CALWbr2wN6k8JBCwLFC=TjTC_sg7Uh8AEsMOBKfH9aBxDEcV4oQ@mail.gmail.com> <CAMP44s2v+CF7x+S6_47CiPb6RMXu+iy06gqWNjus4vff5J8z3g@mail.gmail.com> <CALWbr2x9fG=diZPN-Wkq+-7bstoVmN_pnXN0EPi=4MZQVRuYXg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.5 \(1508\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 14:17:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2gxW-0001As-7M
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 14:17:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123Ab3GZMRS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 08:17:18 -0400
Received: from srv1.joernhees.de ([81.20.133.80]:52880 "EHLO mail.joernhees.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757003Ab3GZMRR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Jul 2013 08:17:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.joernhees.de (Postfix) with ESMTP id E2338E8C2E1;
	Fri, 26 Jul 2013 14:17:15 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at joernhees.de
Received: from mail.joernhees.de ([127.0.0.1])
	by localhost (srv1.joernhees.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n4EhDrEaeR+d; Fri, 26 Jul 2013 14:17:09 +0200 (CEST)
Received: from [192.168.83.24] (dfki-098.dfki.uni-kl.de [131.246.194.98])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mail.joernhees.de (Postfix) with ESMTPSA id E7411E8C2E2;
	Fri, 26 Jul 2013 14:17:08 +0200 (CEST)
In-Reply-To: <CALWbr2x9fG=diZPN-Wkq+-7bstoVmN_pnXN0EPi=4MZQVRuYXg@mail.gmail.com>
X-Mailer: Apple Mail (2.1508)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231182>

On 25 Jul 2013, at 23:10, Antoine Pelisse <apelisse@gmail.com> wrote:

> On Thu, Jul 25, 2013 at 10:40 PM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>> That's true. Maybe something like:
>> 
>> for x in repos:
>>  local_hg = os.path.join(shared_path, x, 'clone', '.hg')
>>  if os.path.exists(local_hg):
>>    shutil.copytree(local_hg, hg_path)
>>    break
> 
> I think that would work

yupp, might work, but holding you liable to the same optimality restriction you imposed on me before:
This will still refetch the whole repo once if it was cloned from a local hg repo first (they don't have a clone subdir).
Shouldn't we then also go through the additional effort and copy the .hg dir from local remotes when a "remote remote" is added and there's no other remote remote?

j
