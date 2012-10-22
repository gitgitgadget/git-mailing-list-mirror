From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: The config include mechanism doesn't allow for overwriting
Date: Mon, 22 Oct 2012 17:55:00 +0200
Message-ID: <CACBZZX4cu9XuS5AtduWrNeXNUeZ4rqDUzRdmyz2b3cXtmo1nqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Oct 22 17:55:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TQKLm-0006nb-2T
	for gcvg-git-2@plane.gmane.org; Mon, 22 Oct 2012 17:55:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751555Ab2JVPzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2012 11:55:22 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:48598 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750798Ab2JVPzV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2012 11:55:21 -0400
Received: by mail-ob0-f174.google.com with SMTP id uo13so2560520obb.19
        for <git@vger.kernel.org>; Mon, 22 Oct 2012 08:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:cc:content-type;
        bh=yf/6DNRUFN4ANvAI8BQ/bCyrKvf5p+DVjiYscnyr7kA=;
        b=QdRikGDJt9b0un6I5cPhTxpsiOXIFu2/g65152+IdpppAILA/sx+WOXDirAgAi2T3D
         A5H1JrfJRUlAL2DPC3k4/q20eEb3HmMBHSgHIv75ZDTpIQox/RmcP6vPs+qT5DKYSNIr
         koXqdWTQupAWyYPW+m0fUzo1MDoboHcPO6JunZcMx11aX5nvg9jobTlF06etNtXP+yUg
         ebi/qbcMbjLQcpk7JXdqvEB0EJUHjxKhdfVJVbJ+jm2U76fAEstR6jEYrU7y02KVL4VQ
         VceuVMwQtuj50x2mgwUHR30Pxvg1f8Ohh+E3t/6dbNRYDSZF6JcWtdk2lqwryQRtiUVQ
         7s6w==
Received: by 10.60.19.168 with SMTP id g8mr6022067oee.101.1350921320572; Mon,
 22 Oct 2012 08:55:20 -0700 (PDT)
Received: by 10.60.94.225 with HTTP; Mon, 22 Oct 2012 08:55:00 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208195>

I was hoping to write something like this:

    [user]
        name = Luser
        email = some-default@example.com
    [include]
        path = ~/.gitconfig.d/user-email

Where that file would contain:

    [user]
        email = local-email@example.com

But when you do that git prints:

    $ git config --get user.email
     some-default@example.com
     error: More than one value for the key user.email: local-email@example.com

I couldn't find information in either the commt that introduced the
feature or the documentation explaining whether this was the intent or
not.

I think config inclusion is much less useful when you can't clobber
previously assigned values.
