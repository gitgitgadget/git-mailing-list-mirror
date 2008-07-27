From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC/PATCH v2] merge-base: teach "git merge-base" to accept more than 2 arguments
Date: Sun, 27 Jul 2008 08:02:21 -0700 (PDT)
Message-ID: <m3vdyrtloo.fsf@localhost.localdomain>
References: <20080727053324.b54fe48e.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Sun Jul 27 17:03:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN7mO-00087I-T4
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 17:03:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510AbYG0PCY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 11:02:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752594AbYG0PCY
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 11:02:24 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:6874 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752479AbYG0PCX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 11:02:23 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1396743nfc.21
        for <git@vger.kernel.org>; Sun, 27 Jul 2008 08:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        bh=enruBAwBDWSc0r/AB9nyWscZSpD5lo+SkU16Coci0ZM=;
        b=wuck3YpJMgniBEAObEYluRO2qLocjcCWL8YtwKq9Hbiy/vJ9cVyfouRVLcR6+EMgsW
         9vgb5FVZgvws/56ptm5oE8T+xcS8/nOBc81mogxLqwhV/rpbR6f/+qos+JpG9G+MbnA/
         0yaiLl2UORT9WSRog/X5yPszBTpsbUIHdHosk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:in-reply-to
         :message-id:lines:user-agent:mime-version:content-type:date;
        b=c2rpZFOmG4f0edYRMuqUDu55QnAoU4yKtifIn9+Dzb6nroGQX7VjZGqCgsgVcfgokf
         poVsuQjQ5KWhft62hcPjDU6yUUgeNoI0j+89tiOH3wmKHJgML+fgnsw3e+nI6lbLDPOC
         Qeglp3FNIGFiypj+IqBHJf8nwtj9QA6suFfxo=
Received: by 10.210.47.7 with SMTP id u7mr4592827ebu.14.1217170942304;
        Sun, 27 Jul 2008 08:02:22 -0700 (PDT)
Received: from localhost.localdomain ( [83.8.240.214])
        by mx.google.com with ESMTPS id y34sm18188093iky.10.2008.07.27.08.02.20
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 27 Jul 2008 08:02:21 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id m6RF2IYI027637;
	Sun, 27 Jul 2008 17:02:19 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id m6RF2FIE027633;
	Sun, 27 Jul 2008 17:02:15 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <20080727053324.b54fe48e.chriscool@tuxfamily.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90339>

Christian Couder <chriscool@tuxfamily.org> writes:

> Before this patch "git merge-base" accepted only 2 arguments, so
> only merge bases between 2 references could be computed.

> +'git-merge-base' finds as good common ancestors as possible between
> +the first commit and the other commits. The default behavior is to
> +output only one as good as possible common ancestor, called a merge
> +base.
> +
> +For example, given two commits A and B, `git merge-base A B` will
> +output a commit which is reachable from both A and B through the
> +parent relationship.
> +
> +Given three commits A, B and C, `git merge-base A B C` will output a
> +commit which is reachable through the parent relationship from both A
> +and B, or from both A and C.

I don't understand this complication.  Isn't merge base (merge bases)
for commits A, B and C simply least common ancestor (or ancestors)
of commits A, B and C (with commits being included as their own
ancestors)?

What are the results of "git merge-base" and "git merge-base --all"
in the following situations?

For two commits:

      .---.---*---.---.---A
               \
                \-.---B


      .---m-----b---.---.---A
           \     \ /
            \     X
             \   / \
              \-a---.---.---B


For three commits:

      .---.---1---2---.---.---A
               \   \
                \   \-.---B
                 \
                  \---.---.---C


                    /-.---.---A
                   /
      .---.---1---2---.---.---B
               \
                \-.---.---.---C 
-- 
Jakub Narebski
Poland
ShadeHawk on #git
