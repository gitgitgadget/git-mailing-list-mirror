From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: Re: [PATCH] rebase -i: interrupt rebase when "commit --amend" failed during "reword"
Date: Wed, 30 Nov 2011 10:52:50 -0500
Message-ID: <1322668371-21218-1-git-send-email-andrew.kw.w@gmail.com>
References: <7vk46isncq.fsf@alter.siamese.dyndns.org>
Cc: Andrew Wong <andrew.kw.w@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 16:53:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVmTj-0003cG-C1
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 16:53:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757320Ab1K3Pxm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 10:53:42 -0500
Received: from mail-vx0-f174.google.com ([209.85.220.174]:44897 "EHLO
	mail-vx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757291Ab1K3Pxl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 10:53:41 -0500
Received: by vcbfk14 with SMTP id fk14so494976vcb.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 07:53:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=xUZ+LluCkwW//1NQfXuy2MXFZzj86P4fLazlw5gi0t8=;
        b=p/pTiFr2jwY4iqvrpgoyCtkrSsAeHaoIMoBbBqcSlfViNxZc89Q+2iX7zavJj2/rBm
         XN5jyUYOFJQ3sa6xSz0XkJVtdzBBAdVaPlhnokcVW3Qe8HS7p9c4Wsm+jmvZsHxP55Gg
         0fhLmpcvc9oOk4ZAQSIANg0hdW/L9JUBOPsXI=
Received: by 10.220.9.203 with SMTP id m11mr504241vcm.270.1322668421228;
        Wed, 30 Nov 2011 07:53:41 -0800 (PST)
Received: from nigel.sohovfx-toronto.com ([66.207.196.114])
        by mx.google.com with ESMTPS id em3sm2956136vdc.10.2011.11.30.07.53.39
        (version=SSLv3 cipher=OTHER);
        Wed, 30 Nov 2011 07:53:40 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc3.32.gb0399.dirty
In-Reply-To: <7vk46isncq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186127>

On 11-11-29 3:08 PM, Junio C Hamano wrote:
> Is there anything we should be saying more than "fatal: Cannot amend" to
> help users when this new "die" triggers? 

Ah, yes, that would be helpful.

The situation is actually very similar to an "edit", where a pick is successful
but requires user intervention. So I'm planning to refactor the behavior and
message from "edit" into a function called "exit_with_patch". Then call the
function from "reword" as well. Though it bothers me a bit that I have to pass
in an exit code as well, since we want the exit status for "reword" to indicate
a failure, but "edit" needs to indicate a success. Is this acceptable? Or
should I just not bother with refactoring?


Andrew Wong (1):
  rebase -i: interrupt rebase when "commit --amend" failed during
    "reword"

 git-rebase--interactive.sh |   36 +++++++++++++++++++++++-------------
 1 files changed, 23 insertions(+), 13 deletions(-)

-- 
1.7.8.rc3.32.gb0399.dirty
