From: "Avery Pennarun" <apenwarr@gmail.com>
Subject: Re: [PATCH] Respect crlf attribute even if core.autocrlf has not been set
Date: Wed, 30 Jul 2008 17:07:49 -0400
Message-ID: <32541b130807301407m59eef936m5e07dd33a4eb5b04@mail.gmail.com>
References: <488772BC.80207@workspacewhiz.com>
	 <alpine.DEB.1.00.0807250159420.4140@eeepc-johanness>
	 <E0666371-5C5E-4AA9-B67A-16C42477865B@orakel.ntnu.no>
	 <20080725140142.GB2925@dpotapov.dyndns.org>
	 <42C252B2-85B9-4D05-B3A2-2A0250D7F5D6@orakel.ntnu.no>
	 <20080729134619.GB7008@dpotapov.dyndns.org>
	 <A8BF9951-AB9D-4391-A6CB-E9778064F4A8@orakel.ntnu.no>
	 <80518F08-A9A9-4190-9AC4-D24DD6A1188B@zib.de>
	 <32541b130807301133w4bfc8288oa2d15911b2317dca@mail.gmail.com>
	 <56C07978-D6C9-4219-8B92-6217BD33F6D4@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: "Eyvind Bernhardsen" <eyvind-git@orakel.ntnu.no>,
	"Dmitry Potapov" <dpotapov@gmail.com>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Joshua Jensen" <jjensen@workspacewhiz.com>,
	"Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: "Steffen Prohaska" <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Jul 30 23:09:11 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOIv0-0006kf-E8
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 23:09:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752993AbYG3VHw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 17:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753365AbYG3VHv
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 17:07:51 -0400
Received: from wa-out-1112.google.com ([209.85.146.183]:56706 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752993AbYG3VHu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 17:07:50 -0400
Received: by wa-out-1112.google.com with SMTP id j37so126400waf.23
        for <git@vger.kernel.org>; Wed, 30 Jul 2008 14:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:cc:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:references;
        bh=7xE4+58C+VfgQboJ6xQIkM2BPEUaYuC8hAF995sVM6s=;
        b=tAsbtqB3fF99h0vWU+wId5CKOJgdhtg0ilNZM7cACLWlU2QwC/4aNisRyOLjeROH5x
         9crxWMSpwxBgJY5elK7Ari57+0HrNMtpTUsSFO2QlyxoEXFT4V0csJqbWc6SoRSM7frJ
         w5Z10dshkDTERUdsXACyxiQiuMr95EZ7CwquY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version
         :content-type:content-transfer-encoding:content-disposition
         :references;
        b=MHRlwaXlyES/iYELlS2gCR3sw9Eghazlg3bTbajGhQrNfZUsFasoEtUXJQRHgVnDQ3
         RlmO6dg8CN/AZ30MOkFq2SGQNSTD5ljm7odQ0z244IWjIdYivvxH1JaxcW1k41kww5Vl
         ukDkW11xHHRwWuZX0Cg9T/IIH9CPvqs+mE448=
Received: by 10.114.56.4 with SMTP id e4mr9321358waa.0.1217452069177;
        Wed, 30 Jul 2008 14:07:49 -0700 (PDT)
Received: by 10.150.98.19 with HTTP; Wed, 30 Jul 2008 14:07:49 -0700 (PDT)
In-Reply-To: <56C07978-D6C9-4219-8B92-6217BD33F6D4@zib.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90855>

On 7/30/08, Steffen Prohaska <prohaska@zib.de> wrote:
> > And so here's the problem: svn hands you a file.  It may or may not
> > have CRLFs in it, and the line endings may actually be a random mix of
> > LF and CRLF, as I am actually experiencing at the moment in a
> > particular repository at work.  If core.autocrlf is anything other
> > than "false", git will modify the file, and git-svn won't be apply the
> > diff on the next revision.
>
>  This sound like a specific problem with svn, not a general problem
>  of git's autocrlf concept.  I work with a git-only workflow and I
>  never see the problems you describe.

My apologies, I think I got this thread mixed up with a different
thread about the fact that git-svn doesn't work with autocrlf.

FWIW, this problem would apply to any system that incrementally
imports into git from another system using binary deltas.

Have fun,

Avery
