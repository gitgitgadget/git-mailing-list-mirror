From: Burke Cates <burke.cates@gmail.com>
Subject: Three-tiered VM development setup with support for branch switching
Date: Wed, 19 May 2010 20:59:50 -0400
Message-ID: <AANLkTinQJLsS6N_d2hsfwbibEuKiUHi9FAnrb5K4Frih@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 20 03:00:37 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OEu7o-0002qg-JF
	for gcvg-git-2@lo.gmane.org; Thu, 20 May 2010 03:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157Ab0ETBAP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 May 2010 21:00:15 -0400
Received: from mail-ww0-f46.google.com ([74.125.82.46]:61621 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753640Ab0ETBAM convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 May 2010 21:00:12 -0400
Received: by wwb18 with SMTP id 18so174283wwb.19
        for <git@vger.kernel.org>; Wed, 19 May 2010 18:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=anyXXDWiXaaUNP/MjtttFW96u6r/CFKrEbs3ic158oc=;
        b=RZFAo45pQKY0t+e+1h46sKoGj4R27F8q0ddhupd892xaWl9fauvFcnG2Mx3c7drXer
         ZYmGvyatYEMPiZVu61ZaHUghmRLDkPfLvsI8VdLhHkjTFHhbxzLlwbAM9sU7O3O13Dhu
         AjsvIYG6V9YKzo4E1EXS16oE2c1yzFgo2sUJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=KGAmZfVDdIVhFiVnC06FJDEbl5KP506ouf9bv8x5c13An1i/aBNJSYhPqVLZAOkigV
         4qQcJNOMrhZrBGxgdNZMIjOe7TYnQlw65FUVZlkiXXLWCr4kMYRb9ErcaCVMkHDc7feI
         jpcyHMpu5QLIcbAbNwOZJQPyO5pvGjGQZ3qJ8=
Received: by 10.216.86.20 with SMTP id v20mr5648060wee.122.1274317210365; Wed, 
	19 May 2010 18:00:10 -0700 (PDT)
Received: by 10.216.181.13 with HTTP; Wed, 19 May 2010 17:59:50 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147355>

I read Joe Maller's blog post "A web-focused Git workflow" (
http://joemaller.com/2008/11/25/a-web-focused-git-workflow/=C2=A0) and
thought this would be a great replacement for our current
scm/development workflow at my job, which I won't get into here. My
main concern with switching to a three-tiered setup using Git is that
switching branches on a workstation and pushing to the "hub" repo
would result in no change in the "prime" repo when "hub"'s post-update
hook runs, as it will not switch branches.
The only solution I can think of involves ripping the branch out of
the refspec that is passed to the hook and using that to call checkout
and pull (or possibly a checkout -b --track newbranch if I dont have
the branch locally on prime). I feel like this is a pretty nasty hack,
but I might be missing something completely that would make this sort
of setup much easier to pull off.
What I'm trying to pull off here is this: devs can code at their
workstations with whatever tools they want, and push changes to the
VM's with git. Hooks will be used to initiate makes for testing and
for pushing changes to other nodes in the test-cluster (who will have
the same make hook). The only obstacle at this point is the branch
switching.
