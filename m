From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] diff: Make numstat machine friendly also for renames (and copies)
Date: Tue, 11 Dec 2007 00:14:47 +0100
Message-ID: <200712110014.48343.jnareb@gmail.com>
References: <200712102332.53114.jnareb@gmail.com> <7vir36jgty.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 00:15:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1rqL-0000v6-Pz
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 00:15:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752079AbXLJXPA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Dec 2007 18:15:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752076AbXLJXPA
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Dec 2007 18:15:00 -0500
Received: from nf-out-0910.google.com ([64.233.182.190]:21265 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbXLJXO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Dec 2007 18:14:59 -0500
Received: by nf-out-0910.google.com with SMTP id g13so1123031nfb
        for <git@vger.kernel.org>; Mon, 10 Dec 2007 15:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        bh=DdjvGPwFf18R2EBIW00xBgobC+TklMSE4eNnd2k5maI=;
        b=MhhPOje4XmP02HmYzlA3GL7Tbmd36D/9wBFOuERzB0pwQbZv8zLv0zCpqxbtBnPiML3Pm6FaszDCVUC6QmzpcYJwg1YhWhZRf0miTL5coM+dLPipWIx4RV/epEfAUrx9BnK/i5YpoCH+NQOwwEAMjWpNudQ/g+MYTS72ZrxRZ0g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=KmxL0CnZQI3RL3FmFQ5+FiN1Zhqv6NfTQXLNWK1787eFWYltUhlh6fNRWQ904zF2Rze8iUnBpx/nwuU3ASKjo9gZcjNqvc9IVzOZG1n18lxMhvPpvKdY881Sb0QOzqgYsJ9+3/DBxf8+jkLez6M81L96lD2hhJM/Nfe6mpgKEIM=
Received: by 10.86.54.3 with SMTP id c3mr6063285fga.1197328497881;
        Mon, 10 Dec 2007 15:14:57 -0800 (PST)
Received: from ?192.168.1.11? ( [83.8.241.16])
        by mx.google.com with ESMTPS id 4sm2583929fge.2007.12.10.15.14.55
        (version=SSLv3 cipher=OTHER);
        Mon, 10 Dec 2007 15:14:56 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <7vir36jgty.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67770>

Junio C Hamano wrote:
> Jakub Narebski <jnareb@gmail.com> writes:
> 
> > "git diff --numstat" used the same format as "git diff --stat" for
> > renamed (and copied) files, except that filenames were not shortened
> > when they didn't fit in the column width.  This format is suitable for
> > human consumption, but it cannot be unambiguously parsed.
> 
> Agreed about the (un)parsability, and --numstat is all about parsability
> so I would not object.  A fix is really needed there.
> 
> I do not have time to look at the patch right now, but if the changed
> output is in line with what --name-status would show, that would be
> great.  I'd call that "the format that should have been from day one".
> 
> I.e. no '=>' rename marker, but show two names c-quoted (unless -z is
> used) and separated with inter_name_termination).  IIRC, that is how
> rename/copy is shown with --name-status.

Unfortunately this is not possible, at least if we want to retain
the assertion that -z output looks like normal output, only without
quoting.

diff --name-status has _status_ field which can be used to distinguish
if the NUL (for -z output) is the end of source filename, or the end
of record.

The patch send changes --numstat to use only _destination_ name.
What you want I'd left for futore --numstat-extended (basically --numstat,
but with status field.

-- 
Jakub Narebski
Poland
