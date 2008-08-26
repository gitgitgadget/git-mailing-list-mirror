From: "Mike Ralphson" <mike.ralphson@gmail.com>
Subject: Re: [PATCH 1/2] git wrapper: Make while loop more reader-friendly
Date: Tue, 26 Aug 2008 09:50:34 +0100
Message-ID: <e2b179460808260150p15b7da0ev913eced3709c2cd1@mail.gmail.com>
References: <20080824202325.GA14930@eagain.net>
	 <7vbpzikt4b.fsf@gitster.siamese.dyndns.org>
	 <20080824222534.GC14930@eagain.net>
	 <alpine.DEB.1.00.0808251235430.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <48B29B2A.6000802@gnu.org>
	 <alpine.DEB.1.00.0808251955490.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <237967ef0808251125q3e50fa04wf0e97ff29298bef2@mail.gmail.com>
	 <alpine.DEB.1.00.0808252206150.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <alpine.DEB.1.00.0808252225520.24820@pacific.mpi-cbg.de.mpi-cbg.de>
	 <alpine.DEB.1.00.0808252248150.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Mikael Magnusson" <mikachu@gmail.com>,
	"Johannes Sixt" <johannes.sixt@telecom.at>,
	"Paolo Bonzini" <bonzini@gnu.org>,
	"Tommi Virtanen" <tv@eagain.net>,
	"Junio C Hamano" <gitster@pobox.com>,
	"Git Mailing List" <git@vger.kernel.org>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Aug 26 10:51:41 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KXuH5-0004ac-H5
	for gcvg-git-2@gmane.org; Tue, 26 Aug 2008 10:51:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752140AbYHZIuf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Aug 2008 04:50:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752983AbYHZIuf
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Aug 2008 04:50:35 -0400
Received: from rv-out-0506.google.com ([209.85.198.228]:25903 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750954AbYHZIue (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Aug 2008 04:50:34 -0400
Received: by rv-out-0506.google.com with SMTP id k40so2036929rvb.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2008 01:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=gsIG5l2e8tFx5Wsyb1uk4dI6vZaH1Uu998PE0km9DEc=;
        b=OddfQqzNswfSyTVL/hsITRRBA1gl+QsB2PZSULat0671qz9VkkAoBzcIodISrWHOJ5
         Mw5uLIMuwPFELdDRRxg8JWB9FSNAIwkmEnf7cTGcupfEw6lA0ufssId7cJHb+DySQwWW
         Z93FpuBncdmEDl9SSeiX2kivVi04eXPfflw8g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=O5TUOE31BczMAnGkZ5bDDO3Nh5C8eP+kWN3qf9f6aQP5FTon132khmnuJPEwl46L//
         M9jSsEJVvW5yPR7WkAddEbcbKqRFoFyYOtRCP3/A8PIYXmxZt7OqVgJXsMKGHi/R5UlU
         DkVZZgjQioO9O5xoC1cJcK2Q+YKidyBG/2Y4E=
Received: by 10.140.202.21 with SMTP id z21mr2694901rvf.81.1219740634333;
        Tue, 26 Aug 2008 01:50:34 -0700 (PDT)
Received: by 10.141.19.11 with HTTP; Tue, 26 Aug 2008 01:50:34 -0700 (PDT)
In-Reply-To: <alpine.DEB.1.00.0808252248150.24820@pacific.mpi-cbg.de.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93728>

2008/8/25 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>
> It is not a good practice to prefer performance over readability in
> something as performance uncritical as finding the trailing slash
> of argv[0].
>
> So avoid head-scratching by making the loop user-readable, and not
> hyper-performance-optimized.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>
>  git.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/git.c b/git.c
> index a647741..2fd74c4 100644
> --- a/git.c
> +++ b/git.c
> @@ -427,9 +427,8 @@ int main(int argc, const char **argv)
>         * name, and the dirname as the default exec_path
>         * if we don't have anything better.
>         */
> -       do
> -               --slash;
> -       while (cmd <= slash && !is_dir_sep(*slash));
> +       while (cmd <= slash && !is_dir_sep(*slash))
> +               slash--;
>        if (slash < cmd) {
>                cmd = lookup_program_in_path(cmd);
>                for (slash = (char *)cmd + strlen(cmd) - 1;
> --
> 1.6.0.211.ga840e.dirty

Isn't it more likely that this form was chosen to indicate that the
loop body was expected to execute at least once, rather than zero or
more times?

Mike
