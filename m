From: skillzero@gmail.com
Subject: Retry conflicting merge with matching line endings?
Date: Tue, 17 Feb 2009 17:55:42 -0800
Message-ID: <2729632a0902171755n3e89e717p6b3a38b556252bfb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 18 02:58:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZbi8-0008Jx-T8
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 02:58:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751597AbZBRBzo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Feb 2009 20:55:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbZBRBzo
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Feb 2009 20:55:44 -0500
Received: from el-out-1112.google.com ([209.85.162.181]:45873 "EHLO
	el-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbZBRBzn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Feb 2009 20:55:43 -0500
Received: by el-out-1112.google.com with SMTP id b25so1546164elf.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2009 17:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=S/LCBuULKoh5VE8J9ef7SioN0dAuOOeOPahchMDRYEo=;
        b=aMdaWsjUtOJCtvaDYSHZA78b3X6go/IsaO9HWNgyRAbyLj5cqmmOaCDBJsoUT0Qe3/
         sIj/Ol3kViEEH9lhXjjzHl8IgHdZ+yTiChZbopTtzG3BJ02omBjfAY+OwkRc/KP2gSvP
         ShqoeJKB2AySVGiaPAnYRBQuoGi9SZVnNK4fI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=kwJZwdSmS2o1JJgDxJYJ9PaOZFrIhoq2V/EUeBHbA0Rbz82qm2z4mo4bT46lR4SC/T
         JEoAZoVdZaQtXg8XeQjJuwvGxJ8bi8AgMNpCIOihy+jBSKbEHtWO/rUuP4jaL64lJPmD
         5tJmL8YUdcHflFGe24OSa/zyk9mKj58eL2sZk=
Received: by 10.150.140.6 with SMTP id n6mr2793871ybd.221.1234922142237; Tue, 
	17 Feb 2009 17:55:42 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110493>

I've been running into a lot of merge conflicts due to line endings
changing. For example, I branch from master when a file has CRLF line
endings (incorrectly) then somebody fixes a bug in that file (still
has CRLF line endings) on master then I realize the file should have
LF line endings so I change them. When I try to rebase on master
later, I get a merge conflict because it looks like every line has
changed and it conflicts with that other bug fix.

Would it be reasonable that if you get a conflict during a merge and
the line endings of the two commits are different then change the line
endings to match, retry the merge of that file, then apply the line
ending change commit?
