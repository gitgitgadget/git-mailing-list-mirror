From: Clemens Buchacher <drizzd@aon.at>
Subject: DWIM "git checkout frotz" to "git checkout -b frotz origin/frotz"
Date: Sat, 5 Jun 2010 13:09:30 +0200
Message-ID: <20100605110930.GA10526@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Peter Rabbitson <ribasushi@cpan.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 05 13:10:46 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OKrGy-0001CW-Rp
	for gcvg-git-2@lo.gmane.org; Sat, 05 Jun 2010 13:10:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932872Ab0FELKU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jun 2010 07:10:20 -0400
Received: from mail-ew0-f223.google.com ([209.85.219.223]:65040 "EHLO
	mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932827Ab0FELKT (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jun 2010 07:10:19 -0400
Received: by ewy23 with SMTP id 23so8112ewy.1
        for <git@vger.kernel.org>; Sat, 05 Jun 2010 04:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:subject:message-id:mime-version:content-type:content-disposition
         :user-agent;
        bh=ENbMLcA5Xb5a2NIxk7RLlwWoObEN21dGapsBmYz/kqo=;
        b=ln+v5AGgdy9WUhkb4giaZMYLLE5+rAhalrvKfG+WmKuTABYux8NxzuEga1xCbClbmx
         krh/0dPzB0smXnr7QVsMkfI5jgSbTBBAEW1vC11vLVSKKcoCXV7oUYkHWe1ETYdun27O
         xOU4IWNFY9/w/QT0GW2NfEGGhZUMWs3Ym/nkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        b=luw7WnZw99rWE7dSV88nSJWw352o+FK5Rtci0QtFHtvILerFr5iHYeXyanNEDSGR0q
         6R3j410HCvAA890O5X+7lbRnt8oejohdNKa6BC4gv1k81gG5Ls3tWo9kVCWy6wMfwNF0
         4+j7Ye/v6cA2tC6Dbt+XNb+pXAJJE/otVigHY=
Received: by 10.213.34.75 with SMTP id k11mr9041538ebd.45.1275736215198;
        Sat, 05 Jun 2010 04:10:15 -0700 (PDT)
Received: from darc.lan ([80.123.242.182])
        by mx.google.com with ESMTPS id 14sm1311808ewy.14.2010.06.05.04.10.14
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 05 Jun 2010 04:10:14 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.71)
	(envelope-from <drizzd@localhost>)
	id 1OKrFq-0002qd-DQ; Sat, 05 Jun 2010 13:09:30 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148466>

Hi,

Peter and I just stumbled on the following interpretations of the
checkout command.

 git checkout origin/frotz      -> detaches HEAD
 git checkout -t origin/frotz   -> git checkout -b frotz origin/frotz
 git checkout frotz             -> git checkout -b frotz origin/frotz
 git checkout -t frotz          -> fatal: Missing branch name

I was surprised by the third one, which I was expecting to fail.
Apparently it's a DWIM feature introduced in commit 70c9ac2f. I
doubt that is what the user was trying to do if they ran that
command. If anything, this behavior will serve to confuse them.

I think git checkout -t <remote>/<branch> is short enough for
creating a new tracking branch. For something even shorter, we can
create an alias. But I'd prefer to keep the already complex
checkout command a little simpler.

Regards,
Clemens
