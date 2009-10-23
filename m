From: Mikael Magnusson <mikachu@gmail.com>
Subject: Re: Unreachable code in builtin-merge.c ?
Date: Fri, 23 Oct 2009 17:12:43 +0200
Message-ID: <237967ef0910230812r621ac705qb029dade20c455a7@mail.gmail.com>
References: <B221C4384AE5104EB414A877DFD0372C0B0092C0C5@DEWDFECCR04.wdf.sap.corp>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: "Zivkov, Sasa" <sasa.zivkov@sap.com>
X-From: git-owner@vger.kernel.org Fri Oct 23 17:12:54 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N1Loz-00040d-TD
	for gcvg-git-2@lo.gmane.org; Fri, 23 Oct 2009 17:12:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752357AbZJWPMj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Oct 2009 11:12:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752321AbZJWPMj
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Oct 2009 11:12:39 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:46296 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752291AbZJWPMj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Oct 2009 11:12:39 -0400
Received: by ewy4 with SMTP id 4so1714413ewy.37
        for <git@vger.kernel.org>; Fri, 23 Oct 2009 08:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=wa68ahQjcl58pdt0oCewpj/SDh5Nhkqlaqp0kaa4CY8=;
        b=HDuLLxFrpbcOS04ZswnlqwISFSfZoELn29GizrQKJSwB+Dh/tsSHp3Gb8wjfZ4lMIf
         FUJN3/dWQdBniJaotQ2yj9f+H6VSnCm0HG/SozML4Bv9zLNCk83Od96vShL0uL8LJiEv
         3VguyYYOux16Kt+BiooCOluYNg09NaDLS7vms=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=W301TsBO0LhTjqLtbxXqkBjdsvOnmIZfsxOyAxyHJP+t9TDkF0bI8ubDG1aWQeWpHg
         TzJgQCKH/n23apJvflbuLoKhEBzypFJKFGFCX6nOEwkHF+YZhtqWQtWqZtozptPVADZa
         oQOhfUVXjR5B0JalFLXUpRSqljIZKh1dkZt7U=
Received: by 10.211.147.8 with SMTP id z8mr733374ebn.87.1256310763118; Fri, 23 
	Oct 2009 08:12:43 -0700 (PDT)
In-Reply-To: <B221C4384AE5104EB414A877DFD0372C0B0092C0C5@DEWDFECCR04.wdf.sap.corp>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131107>

2009/10/23 Zivkov, Sasa <sasa.zivkov@sap.com>:
> In the try_merge_strategy function the expression in the following if statement seems to always evaluate to TRUE:
>
>        if (!strcmp(strategy, "recursive") || !strcmp(strategy, "subtree")) {
>
> If strategy is "recursive" then !strcmp(strategy, "subtree") evaluates to TRUE.
> If strategy is "subtree" then !strcmp(strategy, "recursive") evaluates to TRUE.
> If strategy is neither "recursive" nor "subtree" then any side of || evaluates to TRUE.
>
> Looks like the code in the else block is unreachable?

You seem to have forgotten that strcmp returns 0 when the strings
match. (It returns -1 or 1 when they don't, depending on their
alphabetical ordering).

-- 
Mikael Magnusson
