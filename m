From: Klas Lindberg <klas.lindberg@gmail.com>
Subject: Submodules can't work recursively because Git implements policy?
Date: Mon, 6 Apr 2009 15:42:31 +0200
Message-ID: <33f4f4d70904060642m25b2cff8nafed433eeabfb6c4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Users List <git@vger.kernel.org>
To: Finn Arne Gangstad <finnag@pvv.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 15:44:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqp7O-0003AL-UK
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 15:44:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307AbZDFNmf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 09:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753785AbZDFNmf
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 09:42:35 -0400
Received: from mail-fx0-f158.google.com ([209.85.220.158]:58464 "EHLO
	mail-fx0-f158.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753119AbZDFNme (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 09:42:34 -0400
Received: by fxm2 with SMTP id 2so1891415fxm.37
        for <git@vger.kernel.org>; Mon, 06 Apr 2009 06:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=SyzhdtcOm8u+ER3cbsV9iWxsCTAezchERCCSh8e4XuM=;
        b=HwJgHN1ZGuLKqyJ7DYsJEkIjVE5kLn98HZOMoIyLNlTSK0GEP3ShZdDmTxlwtJFIzo
         2KB91UR3AV+G+KEAhzfvBzGPj+4hR5XJTdKK2onEiDES5UXyUoui/w2z/zkRsb1V1oBU
         0DIqpYNbptpdCgrB6PYfJzAkvpbDATodQypXw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=dEXUKRegSMyNcPYNyd7brfTwvAmLT14bnAzDYp2mh+MJk19GS2gB7UjcYE/kwJsc2O
         eFV01z6zdacbaQGhzitirmoLbNAMiVN1yQVtXrqKkVbIYSqq0QlTnwJv0ucJHAAhDPvt
         CrhZaOihARZw3ENow/Xv3B3ilov+CpItY0GBo=
Received: by 10.223.117.1 with SMTP id o1mr3732540faq.96.1239025351397; Mon, 
	06 Apr 2009 06:42:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115829>

On Mon, Apr 6, 2009 at 3:16 PM, Finn Arne Gangstad <finnag@pvv.org> wrote:

> git submodule update just does "git fetch" and hopes that the required
> commit appears. In practice this means that you (may) need to invent a
> tag or a branch for all the submodules, otherwise they are not
> fetchable.
>
> This bit us pretty hard when we tried to use submodules earlier, so we
> gave up. Maybe some day...

It "hopes" to find them? This is actually my other reason for bringing
the whole SHA key fetching thing up. From what I can see, it is not
possible to implement submodules sensibly without support for fetching
SHA keys. I.e. I want fetch, checkout and every other command to
recurse as needed in the presence of submodules. This limitation
forces me to implement a whole CM tool where none should be necessary.

It appears to me that the security concern (being able to hide commits
by making them unreachable from a named reference) is actually a
policy decision and not a technical one. On what grounds does Git
decide for me how to handle security concerns? It just seems more
important to be able to have recursive submodule behaviour than to
provide band aid for careless users.

Out of curiosity: Is it really possible to change the value of an
already pushed tag? Can you only do the hiding trick with branches?

BR / Klas
