From: Christopher Tiwald <christiwald@gmail.com>
Subject: Re: [fixup PATCH] push: Provide situational hints for
 non-fast-forward errors
Date: Sat, 17 Mar 2012 14:46:51 -0400
Message-ID: <20120317184649.GA320@gmail.com>
References: <20120313232256.GA49626@democracyinaction.org>
 <vpqipi7zh3n.fsf@bauges.imag.fr>
 <7vty1rqek5.fsf@alter.siamese.dyndns.org>
 <7vlin1gl9l.fsf@alter.siamese.dyndns.org>
 <4F64C58B.4000207@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, peff@peff.net,
	Clemens Buchacher <drizzd@aon.at>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Sat Mar 17 19:47:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S8yeh-0002ve-H6
	for gcvg-git-2@plane.gmane.org; Sat, 17 Mar 2012 19:47:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964998Ab2CQSrB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 17 Mar 2012 14:47:01 -0400
Received: from mail-qc0-f174.google.com ([209.85.216.174]:64233 "EHLO
	mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755954Ab2CQSq5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Mar 2012 14:46:57 -0400
Received: by qcqw6 with SMTP id w6so553870qcq.19
        for <git@vger.kernel.org>; Sat, 17 Mar 2012 11:46:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=WpSZxP3WklqJFA58EcwkhGL7ostIy+JF4vRptEn48qE=;
        b=Ls8My68xe39vqqlrcaUThW6pslpibUzKgNC6pHCspoIpUSSPkBTWlGnExfX1yWyXNg
         iC83qcWDC8Ui2FZJ8GjwKO7zB1Izap8+BlYTckbLkK1gSD4U97FBCYFtmXhJ7vRuwCrj
         PUl4rj1x1POGoUfdwuD/YND0xHcJOo0IUA/utcN5xr0N8txejrJ8+ueRvMq5WnJHs7Ik
         F7qJA9kaBNHDgz7uf7lsNP3FTYH+lTA/tNGmG4CvmeIdQ0f38yTAYvr23ZkwJZbSxAHn
         az/i8DbTNRQfD0eMC0PBnVeujiZOAoFPSo1J5eYWXAjiAa7SymN/6IFj8UpumWldtYQK
         eRMw==
Received: by 10.229.111.74 with SMTP id r10mr826748qcp.122.1332010016425;
        Sat, 17 Mar 2012 11:46:56 -0700 (PDT)
Received: from gmail.com (cpe-74-66-248-47.nyc.res.rr.com. [74.66.248.47])
        by mx.google.com with ESMTPS id v8sm12564289qaa.11.2012.03.17.11.46.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 17 Mar 2012 11:46:54 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <4F64C58B.4000207@in.waw.pl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/193345>

On Sat, Mar 17, 2012 at 06:10:35PM +0100, Zbigniew J=C4=99drzejewski-Sz=
mek wrote:
>  static const char message_advice_use_upstream[] =3D
> -	N_("Some of your local branches were stale with respect to their\n"
> -	   "remote counterparts. If you did not intend to push these branch=
es,\n"
> -	   "you may want to set the 'push.default' configuration variable t=
o\n"
> -	   "'current' or 'upstream' to push only the current branch.");
> +	N_("Updates were rejected because a tip of your branch is behind th=
e remote.\n"
> +	   "If you did not intend to push that branch, you may want to expl=
icitly\n"
> +	   "specify branches to push or set the 'push.default' configuratio=
n variable"
> +	   "to 'current' or 'upstream' to always push only the current bran=
ch.");

I prefer the "Some of your local..." language to "Updates were
rejected..." as a reader, but I think you're right about providing the
reason git rejected the push up front.

My concern about this particular message is "tip of your branch is behi=
nd
the remote" reads to me like my _current_ branch is the offender, when
that cannot be the case (it'd hit message_advice_pull_before_push
first). Maybe something like this might make it clearer?

"Updates were rejected because a pushed branch tip is behind its remote
counterpart. If you did not intend to push that branch, you may want to
explicitly specify branches to push or set the 'push.default' configura=
tion
variable to 'current' or 'upstream' to always push only the current bra=
nch."

--
Christopher Tiwald
