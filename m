From: Erick Mattos <erick.mattos@gmail.com>
Subject: [PATCH 0/5] checkout --orphan improvements
Date: Fri, 21 May 2010 21:28:34 -0300
Message-ID: <1274488119-6989-1-git-send-email-erick.mattos@gmail.com>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 22 02:29:29 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFcah-00022i-K7
	for gcvg-git-2@lo.gmane.org; Sat, 22 May 2010 02:29:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932429Ab0EVA3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 20:29:18 -0400
Received: from mail-gx0-f227.google.com ([209.85.217.227]:60715 "EHLO
	mail-gx0-f227.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932341Ab0EVA3R (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 20:29:17 -0400
Received: by gxk27 with SMTP id 27so949251gxk.1
        for <git@vger.kernel.org>; Fri, 21 May 2010 17:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=qkNDSJ6FBqFErd3E4+czEijENedKjGeTWofzkWT7c9k=;
        b=m2ZIGVtrBwHDMs8MtogfSTh8fnPHgQoZq0DM65vTJMsQ2Co3gEz5hYtizc3GIS/Ydd
         lk99ZRA3NTQ2VjFIEsmDTLSaIwXBHL+Ewyty3JESAxjYvjujTPVHyqylSb2iKt+5QvoK
         dKCmq9K0r0EHaEHtzD40JEHcVFdLkhVbvW4zk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=tyD6ZAW7cefzYEevyhUFP995Al+3vcSBDAm4HMoY66iInh01qhg8X5kaf60J/ZDuPz
         2Dn/3oOHMHTMKz1Yg52s95l2yviGAsJ8KZZlXZKW9p5wFfgz1cb2A+KHFbR2fJj3l++f
         n8ZRXMiDQf7si1KqIu+UFrkrj+3fQPo2PiGmk=
Received: by 10.150.244.11 with SMTP id r11mr3345662ybh.366.1274488156502;
        Fri, 21 May 2010 17:29:16 -0700 (PDT)
Received: from localhost.localdomain ([187.15.117.192])
        by mx.google.com with ESMTPS id z42sm23557998ybc.6.2010.05.21.17.29.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 21 May 2010 17:29:16 -0700 (PDT)
X-Mailer: git-send-email 1.7.1.231.g0687c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147497>

These series of patches are improvements to 'git checkout --orphan'.

The main reason for them is a corner case which is not being solved by
actual implementation.  As it is a quite improbable situation and as it was
necessary to do more extensive changes to support it then its development
was held to be presented in a new developing cycle.

When someone set core.logAllRefUpdates to false reflogs are not created
automatically.  This behavior is superseeded by -l option.  Actually this is
not allowed with --orphan by current implementation.  Those new patches are
made to fix that.

There are also two other patches for configuring completion in bash and to
enhance documentation.

To be completely honest I don't see a point of not having the reflogs
created and deleted automatically so I see no reason for -l and
core.logAllRefUpdates at all.  But I do not like to do anything partially
thus these new patches.  If someone could show me a case please do it.  ;-)

[PATCH 1/5] Documentation: alter checkout --orphan description

This one improves documentation text by late corrections from previous
threads.

[PATCH 2/5] refs: split log_ref_write logic into log_ref_setup

Prepare the field by separating the logic to set up the reflog from the
reflog writing action.

[PATCH 3/5] checkout --orphan: respect -l option always

This is the actual actor.

[PATCH 4/5] t3200: test -l with core.logAllRefUpdates options

Adjusting scripts to test everything extensively.

[PATCH 5/5] bash completion: add --orphan to 'git checkout'

Just do that git change.
