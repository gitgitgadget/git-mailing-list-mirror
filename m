From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH v2 18/31] rebase: extract merge code to new source file
Date: Tue, 1 Mar 2011 23:43:31 +0100
Message-ID: <201103012343.33781.jnareb@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com> <m3sjvb7tg4.fsf@localhost.localdomain> <20110301220428.GE23945@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <chriscool@tuxfamily.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 01 23:44:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PuYIb-00016k-HD
	for gcvg-git-2@lo.gmane.org; Tue, 01 Mar 2011 23:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756643Ab1CAWoE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Mar 2011 17:44:04 -0500
Received: from mail-fx0-f46.google.com ([209.85.161.46]:62839 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756496Ab1CAWoC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Mar 2011 17:44:02 -0500
Received: by fxm17 with SMTP id 17so5336659fxm.19
        for <git@vger.kernel.org>; Tue, 01 Mar 2011 14:44:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Mu+W7UQrfBXiclFRokIOoFl7rg/RluhSB/LxPDk/Cwc=;
        b=Gu28/p5GMZodV9tG0vEfRNNUBfKDvYuopOLAIDZq5oZm/E1iRTGygcpwcBUBGAzoJD
         tYeuv6OWYJeNCCztxciDE9Zn5SYTJnX/5CC9q3rrsxBSI1xj9vHQNHdzhxuT1LROVKR3
         FDdLwwuLFZnkHLywxQd1L1vhfcrXRZZRDN/vU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=KgOE6qog0B8l64rUV+6/pXWJgMJJ/htxE0ZZJu1ZNbeqaw/0YqWTNcMfNZYm761SKS
         dSOr/TBn/f4QTl/L+FfWqg3KC52kHqbReeQhMDRuGa1TeuAewZFMOooLoa1QweQ2xhJF
         IyZr1qkrVx0oxMWhLGe9D+qct6k6zT35OhxZU=
Received: by 10.223.102.67 with SMTP id f3mr3651295fao.125.1299019424386;
        Tue, 01 Mar 2011 14:43:44 -0800 (PST)
Received: from [192.168.1.13] (abvt248.neoplus.adsl.tpnet.pl [83.8.217.248])
        by mx.google.com with ESMTPS id n2sm184591fam.28.2011.03.01.14.43.41
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Mar 2011 14:43:43 -0800 (PST)
User-Agent: KMail/1.9.3
In-Reply-To: <20110301220428.GE23945@sigill.intra.peff.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168269>

On Tue, 1 Mar 2011, Jeff King wrote:
> On Fri, Feb 25, 2011 at 12:27:03PM -0800, Jakub Narebski wrote:
> 
> > > > Yes, sourced scripts should not have an executable bit. See 46bac90 for
> > > > rationale.
> > > 
> > > And I should have mentioned: they should go in SCRIPT_LIB in the
> > > Makefile, not SCRIPT_SH.
> > 
> > Shouldn't this information be in Documentation/CodingGuidelines, and
> > perhaps also (checking if one doesn't accidentally change executable
> > bit on sourced scripts) in Documentation/SubmittingPatches?
> 
> I think it might make more sense as comments in the Makefile, which is
> not very well commented for people tweaking non-config bits. Patches
> welcome.

I meant here describing that sourced scripts should not have an executable
bit in CodingGuidelines, ensure that it didn't acquire executable bit in
SubmittingPatches, the fact that added new scripts got to SCRIPT_SH and
new sourced scripts to SCRIPT_LIB in CodingGuidelines / SubmittingPatches.

Description of SCRIPT_SH and SCRIPT_LIB in Makefile comments would be
also nice, and perhaps replace some of proposed additions to 
CodingGuidelines and SubmittingPatches documents.

-- 
Jakub Narebski
Poland
